Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F12AC021B2
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Feb 2025 07:36:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32B83410E8;
	Sat, 22 Feb 2025 08:36:00 +0100 (CET)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
 by mails.dpdk.org (Postfix) with ESMTP id B9DA94025E
 for <dev@dpdk.org>; Sat, 22 Feb 2025 08:35:58 +0100 (CET)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4Z0JhB05NKz501gH;
 Sat, 22 Feb 2025 15:35:54 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
 by mse-fl2.zte.com.cn with SMTP id 51M7ZoHF030392;
 Sat, 22 Feb 2025 15:35:50 +0800 (+08)
 (envelope-from chen.bingbin@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Sat, 22 Feb 2025 15:35:52 +0800
X-Zmail-TransId: 3e8167b97e4a005-00718
From: Bingbin Chen <chen.bingbin@zte.com.cn>
To: stephen@networkplumber.org, wang.junlong1@zte.com.cn
Cc: dev@dpdk.org, Bingbin Chen <chen.bingbin@zte.com.cn>
Subject: [PATCH v2 00/14] add network processor ops
Date: Sat, 22 Feb 2025 15:22:18 +0800
Message-ID: <20250222072232.561353-1-chen.bingbin@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250210014441.4105335-1-chen.bingbin@zte.com.cn>
References: <20250210014441.4105335-1-chen.bingbin@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn 51M7ZoHF030392
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67B97E5A.000/4Z0JhB05NKz501gH
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

VjI6DQogIC0gcmVzb2x2ZSBjb2RlIHN0eWxlIGFuZCBnaXRodWItcm9ib3QgYnVpbGQgaXNzdWUu
DQogIC0gZWxpbWluYXRlIGNvbW1pdCB3YXJuaW5nLg0KICAtIHJlbW92ZSB1bm5lY2Vzc2FyeSBp
bml0aWFsaXphdGlvbiwgd2hpY2ggZmlyc3QgdXNhZ2Ugd2lsbCBzZXQuDQogIC0gcmVwbGFjZSBt
dXRleCBsb2NrIHdpdGggc3BpbmxvY2suDQoNClYxOg0KICAtIHVwZGF0ZWQgbmV0d29yayBwcm9j
ZXNzb3IgZHJpdmVyLg0KICAtIGltcHJvdmUgaW5zZXJ0L2RlbGV0ZS9nZXQgdGFibGUgY29kZSBm
dW5jcy4NCg0KQmluZ2JpbiBDaGVuICgxNCk6DQogIG5ldC96eGRoOiBhZGQgbmV0d29yayBwcm9j
ZXNzb3IgcmVnaXN0ZXJzIG9wcw0KICBuZXQvenhkaDogc3VwcG9ydCBjb21wYXRpYmlsaXR5IGNo
ZWNrDQogIG5ldC96eGRoOiBhZGQgYWdlbnQgY2hhbm5lbA0KICBuZXQvenhkaDogbW9kaWZ5IGR0
YiBxdWV1ZSBvcHMNCiAgbmV0L3p4ZGg6IGFkZCB0YWJsZXMgZHVtcCBhZGRyZXNzIG9wcw0KICBu
ZXQvenhkaDogYWRkIGVyYW0gdGFibGVzIG9wcw0KICBuZXQvenhkaDogZ2V0IGZsb3cgdGFibGVz
IHJlc291cmNlcw0KICBuZXQvenhkaDogc3VwcG9ydCBoYXNoIHJlc291cmNlcyBjb25maWd1cmF0
aW9uDQogIG5ldC96eGRoOiBpbXBsZW1lbnQgdGFibGVzIGluaXRpYWxpemF0aW9uDQogIG5ldC96
eGRoOiBzdXBwb3J0IGhhc2ggdGFibGVzIHdyaXRlIGFuZCBkZWxldGUgb3BzDQogIG5ldC96eGRo
OiBnZXQgaGFzaCB0YWJsZSBlbnRyeSByZXN1bHQNCiAgbmV0L3p4ZGg6IGRlbGV0ZSBhbGwgaGFz
aCBlbnRyaWVzDQogIG5ldC96eGRoOiBhZGQgYWNsIHRhYmxlcyBvcHMNCiAgbmV0L3p4ZGg6IGNs
ZWFuIHN0YXQgdmFsdWVzDQoNCiBkcml2ZXJzL25ldC96eGRoL3p4ZGhfZXRoZGV2LmMgICAgIHwg
ICAgNjMgKw0KIGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9ldGhkZXYuaCAgICAgfCAgICAgMSArDQog
ZHJpdmVycy9uZXQvenhkaC96eGRoX2V0aGRldl9vcHMuYyB8ICAgICA0ICsNCiBkcml2ZXJzL25l
dC96eGRoL3p4ZGhfbnAuYyAgICAgICAgIHwgMTEzMDYgKysrKysrKysrKysrKysrKysrKysrKyst
LS0tDQogZHJpdmVycy9uZXQvenhkaC96eGRoX25wLmggICAgICAgICB8ICAxMjU4ICsrLQ0KIDUg
ZmlsZXMgY2hhbmdlZCwgMTEyMDUgaW5zZXJ0aW9ucygrKSwgMTQyNyBkZWxldGlvbnMoLSkNCg0K
LS0gDQoyLjI3LjA=


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

VjI6PGJyIC8+Jm5ic3A7Jm5ic3A7LSZuYnNwO3Jlc29sdmUmbmJzcDtjb2RlJm5ic3A7c3R5bGUm
bmJzcDthbmQmbmJzcDtnaXRodWItcm9ib3QmbmJzcDtidWlsZCZuYnNwO2lzc3VlLjxiciAvPiZu
YnNwOyZuYnNwOy0mbmJzcDtlbGltaW5hdGUmbmJzcDtjb21taXQmbmJzcDt3YXJuaW5nLjxiciAv
PiZuYnNwOyZuYnNwOy0mbmJzcDtyZW1vdmUmbmJzcDt1bm5lY2Vzc2FyeSZuYnNwO2luaXRpYWxp
emF0aW9uLCZuYnNwO3doaWNoJm5ic3A7Zmlyc3QmbmJzcDt1c2FnZSZuYnNwO3dpbGwmbmJzcDtz
ZXQuPGJyIC8+Jm5ic3A7Jm5ic3A7LSZuYnNwO3JlcGxhY2UmbmJzcDttdXRleCZuYnNwO2xvY2sm
bmJzcDt3aXRoJm5ic3A7c3BpbmxvY2suPGJyIC8+DTxiciAvPlYxOjxiciAvPiZuYnNwOyZuYnNw
Oy0mbmJzcDt1cGRhdGVkJm5ic3A7bmV0d29yayZuYnNwO3Byb2Nlc3NvciZuYnNwO2RyaXZlci48
YnIgLz4mbmJzcDsmbmJzcDstJm5ic3A7aW1wcm92ZSZuYnNwO2luc2VydC9kZWxldGUvZ2V0Jm5i
c3A7dGFibGUmbmJzcDtjb2RlJm5ic3A7ZnVuY3MuPGJyIC8+DTxiciAvPkJpbmdiaW4mbmJzcDtD
aGVuJm5ic3A7KDE0KTo8YnIgLz4mbmJzcDsmbmJzcDtuZXQvenhkaDombmJzcDthZGQmbmJzcDtu
ZXR3b3JrJm5ic3A7cHJvY2Vzc29yJm5ic3A7cmVnaXN0ZXJzJm5ic3A7b3BzPGJyIC8+Jm5ic3A7
Jm5ic3A7bmV0L3p4ZGg6Jm5ic3A7c3VwcG9ydCZuYnNwO2NvbXBhdGliaWxpdHkmbmJzcDtjaGVj
azxiciAvPiZuYnNwOyZuYnNwO25ldC96eGRoOiZuYnNwO2FkZCZuYnNwO2FnZW50Jm5ic3A7Y2hh
bm5lbDxiciAvPiZuYnNwOyZuYnNwO25ldC96eGRoOiZuYnNwO21vZGlmeSZuYnNwO2R0YiZuYnNw
O3F1ZXVlJm5ic3A7b3BzPGJyIC8+Jm5ic3A7Jm5ic3A7bmV0L3p4ZGg6Jm5ic3A7YWRkJm5ic3A7
dGFibGVzJm5ic3A7ZHVtcCZuYnNwO2FkZHJlc3MmbmJzcDtvcHM8YnIgLz4mbmJzcDsmbmJzcDtu
ZXQvenhkaDombmJzcDthZGQmbmJzcDtlcmFtJm5ic3A7dGFibGVzJm5ic3A7b3BzPGJyIC8+Jm5i
c3A7Jm5ic3A7bmV0L3p4ZGg6Jm5ic3A7Z2V0Jm5ic3A7ZmxvdyZuYnNwO3RhYmxlcyZuYnNwO3Jl
c291cmNlczxiciAvPiZuYnNwOyZuYnNwO25ldC96eGRoOiZuYnNwO3N1cHBvcnQmbmJzcDtoYXNo
Jm5ic3A7cmVzb3VyY2VzJm5ic3A7Y29uZmlndXJhdGlvbjxiciAvPiZuYnNwOyZuYnNwO25ldC96
eGRoOiZuYnNwO2ltcGxlbWVudCZuYnNwO3RhYmxlcyZuYnNwO2luaXRpYWxpemF0aW9uPGJyIC8+
Jm5ic3A7Jm5ic3A7bmV0L3p4ZGg6Jm5ic3A7c3VwcG9ydCZuYnNwO2hhc2gmbmJzcDt0YWJsZXMm
bmJzcDt3cml0ZSZuYnNwO2FuZCZuYnNwO2RlbGV0ZSZuYnNwO29wczxiciAvPiZuYnNwOyZuYnNw
O25ldC96eGRoOiZuYnNwO2dldCZuYnNwO2hhc2gmbmJzcDt0YWJsZSZuYnNwO2VudHJ5Jm5ic3A7
cmVzdWx0PGJyIC8+Jm5ic3A7Jm5ic3A7bmV0L3p4ZGg6Jm5ic3A7ZGVsZXRlJm5ic3A7YWxsJm5i
c3A7aGFzaCZuYnNwO2VudHJpZXM8YnIgLz4mbmJzcDsmbmJzcDtuZXQvenhkaDombmJzcDthZGQm
bmJzcDthY2wmbmJzcDt0YWJsZXMmbmJzcDtvcHM8YnIgLz4mbmJzcDsmbmJzcDtuZXQvenhkaDom
bmJzcDtjbGVhbiZuYnNwO3N0YXQmbmJzcDt2YWx1ZXM8YnIgLz4NPGJyIC8+Jm5ic3A7ZHJpdmVy
cy9uZXQvenhkaC96eGRoX2V0aGRldi5jJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOzYzJm5ic3A7KzxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4
ZGgvenhkaF9ldGhkZXYuaCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsxJm5ic3A7KzxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgv
enhkaF9ldGhkZXZfb3BzLmMmbmJzcDt8Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7NCZu
YnNwOys8YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfbnAuYyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wmbmJzcDsxMTMwNiZuYnNw
OysrKysrKysrKysrKysrKysrKysrKysrLS0tLTxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgv
enhkaF9ucC5oJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7fCZuYnNwOyZuYnNwOzEyNTgmbmJzcDsrKy08YnIgLz4mbmJzcDs1Jm5ic3A7ZmlsZXMm
bmJzcDtjaGFuZ2VkLCZuYnNwOzExMjA1Jm5ic3A7aW5zZXJ0aW9ucygrKSwmbmJzcDsxNDI3Jm5i
c3A7ZGVsZXRpb25zKC0pPGJyIC8+DTxiciAvPi0tJm5ic3A7DTxiciAvPjIuMjcuMDxiciAvPg==

--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

