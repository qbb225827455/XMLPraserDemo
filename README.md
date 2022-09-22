# XMLPraserDemo

XML資料來源: https://www.nasa.gov/rss/dyn/breaking_news.rss

XML Viewer: https://jsonformatter.org/xml-viewer

| XML 結構 | 使用的節點 |
| ------ | ------ |
| <img src="https://github.com/qbb225827455/XMLPraserDemo/blob/master/image/XMLTree.PNG" width="500"> | <img src="https://github.com/qbb225827455/XMLPraserDemo/blob/master/image/node.PNG" width="500"> |

## 解析以上的 XML 時， NSXMLParser 物件會通知它以下事件的委派：
| 事件描述 | 委派的調用方法 |
| ------ | ------ |
|開始解析 XML ⽂件|parserDidStartDocument(_:)|
|搜尋元素 item 的起始標籤（tag）|parser(_:didStartElement:namespaceURI:qualifiedName:attributes:)|
|搜尋元素 title 的起始標籤|parser(_:didStartElement:namespaceURI:qualifiedName:attributes:)|
|找到 NASA Astronaut Frank Rubio... 字元|parser(_:foundCharacters:)|
|搜尋元素 title 的結束標籤|parser(_:didEndElement:namespaceURI:qualifiedName:)|
|搜尋元素 description 的起始標籤|parser(_:didStartElement:namespaceURI:qualifiedName:attributes:)|
|找到 NASA astronaut Frank Rubio... 字元|parser(_:foundCharacters:)|
|搜尋元素 description 的結束標籤|parser(_:didEndElement:namespaceURI:qualifiedName:)|
|搜尋元素 pubDate 的起始標籤|parser(_:didStartElement:namespaceURI:qualifiedName:attributes:)|
|找到 Wed, 21 Sep 2022 09:48 EDT 字元|parser(_:foundCharacters:)|
|搜尋元素 pubDate 的結束標籤|parser(_:didEndElement:namespaceURI:qualifiedName:)|
|搜尋元素 item 的結束標籤|parser(_:didEndElement:namespaceURI:qualifiedName:)|
|結束 XML ⽂件解析|parserDidEndDocument(_:)|
