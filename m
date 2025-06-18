Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73C9C7115B
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 07:55:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFD2F427B8;
	Wed, 18 Jun 2025 09:55:50 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
 by mails.dpdk.org (Postfix) with ESMTP id 74AC6427AC
 for <dev@dpdk.org>; Wed, 18 Jun 2025 09:55:49 +0200 (CEST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bMbdc1Tdkz8R043;
 Wed, 18 Jun 2025 15:55:48 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
 by mse-fl1.zte.com.cn with SMTP id 55I7tNuo069279;
 Wed, 18 Jun 2025 15:55:23 +0800 (+08)
 (envelope-from chen.bingbin@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Wed, 18 Jun 2025 15:55:26 +0800
X-Zmail-TransId: 3e81685270e7008-793c0
From: Bingbin Chen <chen.bingbin@zte.com.cn>
To: stephen@networkplumber.org, wang.junlong1@zte.com.cn,
 yang.yonggang@zte.com.cn
Cc: dev@dpdk.org, Bingbin Chen <chen.bingbin@zte.com.cn>
Subject: [PATCH v2 0/2] add support flow director ops
Date: Wed, 18 Jun 2025 15:49:28 +0800
Message-ID: <20250618074936.3616999-1-chen.bingbin@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617093114.3570444-1-chen.bingbin@zte.com.cn>
References: <20250617093114.3570444-1-chen.bingbin@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 55I7tNuo069279
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68527104.000/4bMbdc1Tdkz8R043
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

VjI6DQogIC0gcmVzb2x2ZSBjb2RlIHN0eWxlIGFuZCBnY2MgY29tcGlsYXRpb24gaXNzdWUuDQoN
ClYxOg0KICAtIGFkZCBzdXBwb3J0IGZsb3cgZGlyZWN0b3Igb3BzLg0KDQpCaW5nYmluIENoZW4g
KDIpOg0KICBuZXQvenhkaDogbnBzZGsgYWRkIGZsb3cgZGlyZWN0b3IgdGFibGUgb3BzDQogIG5l
dC96eGRoOiBhZGQgc3VwcG9ydCBmbG93IGRpcmVjdG9yIG9wcw0KDQogZG9jL2d1aWRlcy9uaWNz
L2ZlYXR1cmVzL3p4ZGguaW5pICB8ICAgMTYgKw0KIGRvYy9ndWlkZXMvbmljcy96eGRoLnJzdCAg
ICAgICAgICAgfCAgICAxICsNCiBkcml2ZXJzL25ldC96eGRoL21lc29uLmJ1aWxkICAgICAgIHwg
ICAgMSArDQogZHJpdmVycy9uZXQvenhkaC96eGRoX2NvbW1vbi5oICAgICB8ICAgIDEgKw0KIGRy
aXZlcnMvbmV0L3p4ZGgvenhkaF9ldGhkZXYuYyAgICAgfCAgIDI3ICsNCiBkcml2ZXJzL25ldC96
eGRoL3p4ZGhfZXRoZGV2LmggICAgIHwgICAxMyArLQ0KIGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9l
dGhkZXZfb3BzLmMgfCAgICAyICstDQogZHJpdmVycy9uZXQvenhkaC96eGRoX2V0aGRldl9vcHMu
aCB8ICAgIDEgKw0KIGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9mbG93LmMgICAgICAgfCAyMDA0ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCiBkcml2ZXJzL25ldC96eGRoL3p4ZGhfZmxvdy5o
ICAgICAgIHwgIDIzNyArKysrDQogZHJpdmVycy9uZXQvenhkaC96eGRoX21zZy5jICAgICAgICB8
ICAyNjMgKysrLQ0KIGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9tc2cuaCAgICAgICAgfCAgIDMxICst
DQogZHJpdmVycy9uZXQvenhkaC96eGRoX25wLmMgICAgICAgICB8IDE2MzggKysrKysrKysrKysr
KysrKysrKysrKysNCiBkcml2ZXJzL25ldC96eGRoL3p4ZGhfbnAuaCAgICAgICAgIHwgICAzMSAr
LQ0KIGRyaXZlcnMvbmV0L3p4ZGgvenhkaF90YWJsZXMuaCAgICAgfCAgIDEwICstDQogMTUgZmls
ZXMgY2hhbmdlZCwgNDIwNCBpbnNlcnRpb25zKCspLCA3MiBkZWxldGlvbnMoLSkNCiBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvenhkaC96eGRoX2Zsb3cuYw0KIGNyZWF0ZSBtb2RlIDEw
MDY0NCBkcml2ZXJzL25ldC96eGRoL3p4ZGhfZmxvdy5oDQoNCi0tIA0KMi4yNy4w


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

VjI6PGJyIC8+Jm5ic3A7Jm5ic3A7LSZuYnNwO3Jlc29sdmUmbmJzcDtjb2RlJm5ic3A7c3R5bGUm
bmJzcDthbmQmbmJzcDtnY2MmbmJzcDtjb21waWxhdGlvbiZuYnNwO2lzc3VlLjxiciAvPg08YnIg
Lz5WMTo8YnIgLz4mbmJzcDsmbmJzcDstJm5ic3A7YWRkJm5ic3A7c3VwcG9ydCZuYnNwO2Zsb3cm
bmJzcDtkaXJlY3RvciZuYnNwO29wcy48YnIgLz4NPGJyIC8+QmluZ2JpbiZuYnNwO0NoZW4mbmJz
cDsoMik6PGJyIC8+Jm5ic3A7Jm5ic3A7bmV0L3p4ZGg6Jm5ic3A7bnBzZGsmbmJzcDthZGQmbmJz
cDtmbG93Jm5ic3A7ZGlyZWN0b3ImbmJzcDt0YWJsZSZuYnNwO29wczxiciAvPiZuYnNwOyZuYnNw
O25ldC96eGRoOiZuYnNwO2FkZCZuYnNwO3N1cHBvcnQmbmJzcDtmbG93Jm5ic3A7ZGlyZWN0b3Im
bmJzcDtvcHM8YnIgLz4NPGJyIC8+Jm5ic3A7ZG9jL2d1aWRlcy9uaWNzL2ZlYXR1cmVzL3p4ZGgu
aW5pJm5ic3A7Jm5ic3A7fCZuYnNwOyZuYnNwOyZuYnNwOzE2Jm5ic3A7KzxiciAvPiZuYnNwO2Rv
Yy9ndWlkZXMvbmljcy96eGRoLnJzdCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsx
Jm5ic3A7KzxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgvbWVzb24uYnVpbGQmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
MSZuYnNwOys8YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfY29tbW9uLmgmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7MSZuYnNwOys8
YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfZXRoZGV2LmMmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDt8Jm5ic3A7Jm5ic3A7Jm5ic3A7MjcmbmJzcDsrPGJyIC8+Jm5ic3A7ZHJp
dmVycy9uZXQvenhkaC96eGRoX2V0aGRldi5oJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
fCZuYnNwOyZuYnNwOyZuYnNwOzEzJm5ic3A7Ky08YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRo
L3p4ZGhfZXRoZGV2X29wcy5jJm5ic3A7fCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOzImbmJzcDsr
LTxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9ldGhkZXZfb3BzLmgmbmJzcDt8Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7MSZuYnNwOys8YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRo
L3p4ZGhfZmxvdy5jJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZu
YnNwOzIwMDQmbmJzcDsrKysrKysrKysrKysrKysrKysrKysrKysrKysrPGJyIC8+Jm5ic3A7ZHJp
dmVycy9uZXQvenhkaC96eGRoX2Zsb3cuaCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwO3wmbmJzcDsmbmJzcDsyMzcmbmJzcDsrKysrPGJyIC8+Jm5ic3A7ZHJpdmVycy9u
ZXQvenhkaC96eGRoX21zZy5jJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7fCZuYnNwOyZuYnNwOzI2MyZuYnNwOysrKy08YnIgLz4mbmJzcDtkcml2ZXJzL25l
dC96eGRoL3p4ZGhfbXNnLmgmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDt8Jm5ic3A7Jm5ic3A7Jm5ic3A7MzEmbmJzcDsrLTxiciAvPiZuYnNwO2RyaXZlcnMv
bmV0L3p4ZGgvenhkaF9ucC5jJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOzE2MzgmbmJzcDsrKysrKysrKysrKysrKysrKysrKysrKzxi
ciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9ucC5oJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOyZuYnNwOyZuYnNwOzMxJm5i
c3A7Ky08YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfdGFibGVzLmgmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7Jm5ic3A7Jm5ic3A7MTAmbmJzcDsrLTxiciAvPiZu
YnNwOzE1Jm5ic3A7ZmlsZXMmbmJzcDtjaGFuZ2VkLCZuYnNwOzQyMDQmbmJzcDtpbnNlcnRpb25z
KCspLCZuYnNwOzcyJm5ic3A7ZGVsZXRpb25zKC0pPGJyIC8+Jm5ic3A7Y3JlYXRlJm5ic3A7bW9k
ZSZuYnNwOzEwMDY0NCZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9mbG93LmM8YnIgLz4mbmJz
cDtjcmVhdGUmbmJzcDttb2RlJm5ic3A7MTAwNjQ0Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96eGRo
X2Zsb3cuaDxiciAvPg08YnIgLz4tLSZuYnNwOw08YnIgLz4yLjI3LjA8YnIgLz4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

