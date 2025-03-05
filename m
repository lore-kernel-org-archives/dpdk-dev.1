Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E8AC19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 08:28:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78C8B40616;
	Wed,  5 Mar 2025 09:28:00 +0100 (CET)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
 by mails.dpdk.org (Postfix) with ESMTP id 37E06402F1
 for <dev@dpdk.org>; Wed,  5 Mar 2025 09:27:58 +0100 (CET)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Z75K56y2Xz8RSdM;
 Wed,  5 Mar 2025 16:27:53 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
 by mse-fl2.zte.com.cn with SMTP id 5258ROlo085841;
 Wed, 5 Mar 2025 16:27:24 +0800 (+08)
 (envelope-from chen.bingbin@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Wed, 5 Mar 2025 16:27:27 +0800
X-Zmail-TransId: 3e8167c80ae5005-f11e0
From: Bingbin Chen <chen.bingbin@zte.com.cn>
To: stephen@networkplumber.org, wang.junlong1@zte.com.cn,
 yang.yonggang@zte.com.cn
Cc: dev@dpdk.org, Bingbin Chen <chen.bingbin@zte.com.cn>
Subject: [PATCH v3 00/14] net/zxdh: add network processor ops
Date: Wed,  5 Mar 2025 16:13:06 +0800
Message-ID: <20250305081320.1161982-1-chen.bingbin@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250210014441.4105335-1-chen.bingbin@zte.com.cn>
References: <20250210014441.4105335-1-chen.bingbin@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn 5258ROlo085841
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67C80B09.003/4Z75K56y2Xz8RSdM
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org



--=====_001_next=====
Content-Type: multipart/related;
	boundary="=====_002_next====="


--=====_002_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

VjM6DQogIC0gcmVzb2x2ZSBjb2RlIHN0eWxlLg0KICAtIHJlc29sdmUgc3BpbiBsb2NrIGJ1aWxk
IGlzc3VlLg0KICAtIHJlYmFzZSBjb2RlIGJhc2VsaW5lLg0KICAtIG1vZGlmeSBwYXJhbWV0ZXJz
IG9mIHRoZSBwbGNyIGZ1bmN0aW9uLg0KDQpWMjoNCiAgLSByZXNvbHZlIGNvZGUgc3R5bGUgYW5k
IGdpdGh1Yi1yb2JvdCBidWlsZCBpc3N1ZS4NCiAgLSBlbGltaW5hdGUgY29tbWl0IHdhcm5pbmcu
DQogIC0gcmVtb3ZlIHVubmVjZXNzYXJ5IGluaXRpYWxpemF0aW9uLCB3aGljaCBmaXJzdCB1c2Fn
ZSB3aWxsIHNldC4NCiAgLSByZXBsYWNlIG11dGV4IGxvY2sgd2l0aCBzcGlubG9jay4NCg0KVjE6
DQogIC0gdXBkYXRlZCBuZXR3b3JrIHByb2Nlc3NvciBkcml2ZXIuDQogIC0gaW1wcm92ZSBpbnNl
cnQvZGVsZXRlL2dldCB0YWJsZSBjb2RlIGZ1bmNzLg0KDQpCaW5nYmluIENoZW4gKDE0KToNCiAg
bmV0L3p4ZGg6IGFkZCBuZXR3b3JrIHByb2Nlc3NvciByZWdpc3RlcnMgb3BzDQogIG5ldC96eGRo
OiBzdXBwb3J0IGNvbXBhdGliaWxpdHkgY2hlY2sNCiAgbmV0L3p4ZGg6IGFkZCBhZ2VudCBjaGFu
bmVsDQogIG5ldC96eGRoOiBtb2RpZnkgZHRiIHF1ZXVlIG9wcw0KICBuZXQvenhkaDogYWRkIHRh
YmxlcyBkdW1wIGFkZHJlc3Mgb3BzDQogIG5ldC96eGRoOiBhZGQgZXJhbSB0YWJsZXMgb3BzDQog
IG5ldC96eGRoOiBnZXQgZmxvdyB0YWJsZXMgcmVzb3VyY2VzDQogIG5ldC96eGRoOiBzdXBwb3J0
IGhhc2ggcmVzb3VyY2VzIGNvbmZpZ3VyYXRpb24NCiAgbmV0L3p4ZGg6IGltcGxlbWVudCB0YWJs
ZXMgaW5pdGlhbGl6YXRpb24NCiAgbmV0L3p4ZGg6IHN1cHBvcnQgaGFzaCB0YWJsZXMgd3JpdGUg
YW5kIGRlbGV0ZSBvcHMNCiAgbmV0L3p4ZGg6IGdldCBoYXNoIHRhYmxlIGVudHJ5IHJlc3VsdA0K
ICBuZXQvenhkaDogZGVsZXRlIGFsbCBoYXNoIGVudHJpZXMNCiAgbmV0L3p4ZGg6IGFkZCBhY2wg
dGFibGVzIG9wcw0KICBuZXQvenhkaDogbW9kaWZ5IHBhcmFtZXRlcnMgb2YgdGhlIHBsY3IgZnVu
Y3Rpb24NCg0KIGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9ldGhkZXYuYyB8ICAgIDcwICsNCiBkcml2
ZXJzL25ldC96eGRoL3p4ZGhfZXRoZGV2LmggfCAgICAgMSArDQogZHJpdmVycy9uZXQvenhkaC96
eGRoX21zZy5jICAgIHwgICAgIDMgKy0NCiBkcml2ZXJzL25ldC96eGRoL3p4ZGhfbXRyLmMgICAg
fCAgICAgOCArLQ0KIGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9ucC5jICAgICB8IDExMzg3ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tLS0NCiBkcml2ZXJzL25ldC96eGRoL3p4ZGhfbnAuaCAg
ICAgfCAgMTIyMyArKystDQogNiBmaWxlcyBjaGFuZ2VkLCAxMTExOCBpbnNlcnRpb25zKCspLCAx
NTc0IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuMjcuMA==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

VjM6PGJyIC8+Jm5ic3A7Jm5ic3A7LSZuYnNwO3Jlc29sdmUmbmJzcDtjb2RlJm5ic3A7c3R5bGUu
PGJyIC8+Jm5ic3A7Jm5ic3A7LSZuYnNwO3Jlc29sdmUmbmJzcDtzcGluJm5ic3A7bG9jayZuYnNw
O2J1aWxkJm5ic3A7aXNzdWUuPGJyIC8+Jm5ic3A7Jm5ic3A7LSZuYnNwO3JlYmFzZSZuYnNwO2Nv
ZGUmbmJzcDtiYXNlbGluZS48YnIgLz4mbmJzcDsmbmJzcDstJm5ic3A7bW9kaWZ5Jm5ic3A7cGFy
YW1ldGVycyZuYnNwO29mJm5ic3A7dGhlJm5ic3A7cGxjciZuYnNwO2Z1bmN0aW9uLjxiciAvPg08
YnIgLz5WMjo8YnIgLz4mbmJzcDsmbmJzcDstJm5ic3A7cmVzb2x2ZSZuYnNwO2NvZGUmbmJzcDtz
dHlsZSZuYnNwO2FuZCZuYnNwO2dpdGh1Yi1yb2JvdCZuYnNwO2J1aWxkJm5ic3A7aXNzdWUuPGJy
IC8+Jm5ic3A7Jm5ic3A7LSZuYnNwO2VsaW1pbmF0ZSZuYnNwO2NvbW1pdCZuYnNwO3dhcm5pbmcu
PGJyIC8+Jm5ic3A7Jm5ic3A7LSZuYnNwO3JlbW92ZSZuYnNwO3VubmVjZXNzYXJ5Jm5ic3A7aW5p
dGlhbGl6YXRpb24sJm5ic3A7d2hpY2gmbmJzcDtmaXJzdCZuYnNwO3VzYWdlJm5ic3A7d2lsbCZu
YnNwO3NldC48YnIgLz4mbmJzcDsmbmJzcDstJm5ic3A7cmVwbGFjZSZuYnNwO211dGV4Jm5ic3A7
bG9jayZuYnNwO3dpdGgmbmJzcDtzcGlubG9jay48YnIgLz4NPGJyIC8+VjE6PGJyIC8+Jm5ic3A7
Jm5ic3A7LSZuYnNwO3VwZGF0ZWQmbmJzcDtuZXR3b3JrJm5ic3A7cHJvY2Vzc29yJm5ic3A7ZHJp
dmVyLjxiciAvPiZuYnNwOyZuYnNwOy0mbmJzcDtpbXByb3ZlJm5ic3A7aW5zZXJ0L2RlbGV0ZS9n
ZXQmbmJzcDt0YWJsZSZuYnNwO2NvZGUmbmJzcDtmdW5jcy48YnIgLz4NPGJyIC8+QmluZ2JpbiZu
YnNwO0NoZW4mbmJzcDsoMTQpOjxiciAvPiZuYnNwOyZuYnNwO25ldC96eGRoOiZuYnNwO2FkZCZu
YnNwO25ldHdvcmsmbmJzcDtwcm9jZXNzb3ImbmJzcDtyZWdpc3RlcnMmbmJzcDtvcHM8YnIgLz4m
bmJzcDsmbmJzcDtuZXQvenhkaDombmJzcDtzdXBwb3J0Jm5ic3A7Y29tcGF0aWJpbGl0eSZuYnNw
O2NoZWNrPGJyIC8+Jm5ic3A7Jm5ic3A7bmV0L3p4ZGg6Jm5ic3A7YWRkJm5ic3A7YWdlbnQmbmJz
cDtjaGFubmVsPGJyIC8+Jm5ic3A7Jm5ic3A7bmV0L3p4ZGg6Jm5ic3A7bW9kaWZ5Jm5ic3A7ZHRi
Jm5ic3A7cXVldWUmbmJzcDtvcHM8YnIgLz4mbmJzcDsmbmJzcDtuZXQvenhkaDombmJzcDthZGQm
bmJzcDt0YWJsZXMmbmJzcDtkdW1wJm5ic3A7YWRkcmVzcyZuYnNwO29wczxiciAvPiZuYnNwOyZu
YnNwO25ldC96eGRoOiZuYnNwO2FkZCZuYnNwO2VyYW0mbmJzcDt0YWJsZXMmbmJzcDtvcHM8YnIg
Lz4mbmJzcDsmbmJzcDtuZXQvenhkaDombmJzcDtnZXQmbmJzcDtmbG93Jm5ic3A7dGFibGVzJm5i
c3A7cmVzb3VyY2VzPGJyIC8+Jm5ic3A7Jm5ic3A7bmV0L3p4ZGg6Jm5ic3A7c3VwcG9ydCZuYnNw
O2hhc2gmbmJzcDtyZXNvdXJjZXMmbmJzcDtjb25maWd1cmF0aW9uPGJyIC8+Jm5ic3A7Jm5ic3A7
bmV0L3p4ZGg6Jm5ic3A7aW1wbGVtZW50Jm5ic3A7dGFibGVzJm5ic3A7aW5pdGlhbGl6YXRpb248
YnIgLz4mbmJzcDsmbmJzcDtuZXQvenhkaDombmJzcDtzdXBwb3J0Jm5ic3A7aGFzaCZuYnNwO3Rh
YmxlcyZuYnNwO3dyaXRlJm5ic3A7YW5kJm5ic3A7ZGVsZXRlJm5ic3A7b3BzPGJyIC8+Jm5ic3A7
Jm5ic3A7bmV0L3p4ZGg6Jm5ic3A7Z2V0Jm5ic3A7aGFzaCZuYnNwO3RhYmxlJm5ic3A7ZW50cnkm
bmJzcDtyZXN1bHQ8YnIgLz4mbmJzcDsmbmJzcDtuZXQvenhkaDombmJzcDtkZWxldGUmbmJzcDth
bGwmbmJzcDtoYXNoJm5ic3A7ZW50cmllczxiciAvPiZuYnNwOyZuYnNwO25ldC96eGRoOiZuYnNw
O2FkZCZuYnNwO2FjbCZuYnNwO3RhYmxlcyZuYnNwO29wczxiciAvPiZuYnNwOyZuYnNwO25ldC96
eGRoOiZuYnNwO21vZGlmeSZuYnNwO3BhcmFtZXRlcnMmbmJzcDtvZiZuYnNwO3RoZSZuYnNwO3Bs
Y3ImbmJzcDtmdW5jdGlvbjxiciAvPg08YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhf
ZXRoZGV2LmMmbmJzcDt8Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7NzAmbmJzcDsrPGJyIC8+Jm5i
c3A7ZHJpdmVycy9uZXQvenhkaC96eGRoX2V0aGRldi5oJm5ic3A7fCZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOzEmbmJzcDsrPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96eGRoX21z
Zy5jJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OzMmbmJzcDsrLTxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9tdHIuYyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwO3wmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDs4Jm5ic3A7Ky08
YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfbnAuYyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwO3wmbmJzcDsxMTM4NyZuYnNwOysrKysrKysrKysrKysrKysrKysrKysrKysrKy0t
LS08YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfbnAuaCZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwO3wmbmJzcDsmbmJzcDsxMjIzJm5ic3A7KysrLTxiciAvPiZuYnNwOzYmbmJz
cDtmaWxlcyZuYnNwO2NoYW5nZWQsJm5ic3A7MTExMTgmbmJzcDtpbnNlcnRpb25zKCspLCZuYnNw
OzE1NzQmbmJzcDtkZWxldGlvbnMoLSk8YnIgLz4NPGJyIC8+LS0mbmJzcDsNPGJyIC8+Mi4yNy4w
PGJyIC8+


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

