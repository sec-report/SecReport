import io
import os
import sys
import zipfile
from typing import IO
from lxml import etree


def tidy_setting(setting_content: IO[bytes]) -> str:
    tree = etree.parse(setting_content)
    root = tree.getroot()
    namespaces = {
        'w': root.nsmap['w'],
    }
    update_fields_elem = tree.xpath('/w:settings/w:updateFields', namespaces=namespaces)
    if not update_fields_elem:
        settings_elem = tree.xpath('/w:settings', namespaces=namespaces)[0]
        update_fields_elem = etree.Element('{' + namespaces['w'] + '}updateFields')
        update_fields_elem.set('{' + namespaces['w'] + '}val', 'true')
        settings_elem.append(update_fields_elem)
        return etree.tostring(tree, xml_declaration=True, encoding='UTF-8', standalone='yes').decode()
    return ""


def tidy_document(document_content: IO[bytes]) -> str:
    tree = etree.parse(document_content)
    root = tree.getroot()
    namespaces = {
        'w': root.nsmap['w'],
    }
    hyperlink_fields_elem = tree.xpath('//w:hyperlink', namespaces=namespaces)
    if hyperlink_fields_elem:
        for hyperlink in hyperlink_fields_elem:
            hyperlink.getparent().remove(hyperlink)
        return etree.tostring(tree, xml_declaration=True, encoding='UTF-8', standalone='yes').decode()
    return ""


if __name__ == '__main__':
    docx_path = ""
    if len(sys.argv) == 2:
        docx_path = sys.argv[1]
    else:
        print("请指定文件")
        exit() 
    if not os.path.isfile(docx_path):
        print("文件不存在")
        exit()
    with zipfile.ZipFile(docx_path) as z:
        with io.BytesIO() as i:
            i.write(z.read('word/settings.xml'))
            i.seek(0)
            new_setting_content = tidy_setting(i)
        with io.BytesIO() as i:
            i.write(z.read('word/document.xml'))
            i.seek(0)
            new_document_content = tidy_document(i)
        with io.BytesIO() as buffer:
            with zipfile.ZipFile(buffer, 'w') as mem_zip:
                for item in z.infolist():
                    if item.filename == 'word/settings.xml' and new_setting_content != "":
                        mem_zip.writestr(item, new_setting_content)
                    elif item.filename == 'word/document.xml' and new_document_content != "":
                        mem_zip.writestr(item, new_document_content)
                    else:
                        mem_zip.writestr(item, z.read(item.filename))
            with open(docx_path, 'wb') as output_file:
                output_file.write(buffer.getvalue())
    print('Done')
