Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BA5CA0EFF
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 08:50:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B697540657;
	Wed, 27 Aug 2025 10:50:50 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
 by mails.dpdk.org (Postfix) with ESMTP id 50D2D40653
 for <dev@dpdk.org>; Wed, 27 Aug 2025 10:50:49 +0200 (CEST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cBdXj5ymXz8Xs6v;
 Wed, 27 Aug 2025 16:50:45 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
 by mse-fl2.zte.com.cn with SMTP id 57R8oJP0093867;
 Wed, 27 Aug 2025 16:50:19 +0800 (+08)
 (envelope-from chen.bingbin@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Wed, 27 Aug 2025 16:50:22 +0800
X-Zmail-TransId: 3e8168aec6c9003-b5483
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: chen.bingbin@zte.com.cn
From: Bingbin Chen <chen.bingbin@zte.com.cn>
To: stephen@networkplumber.org, ivan.malov@arknetworks.am,
 wang.junlong1@zte.com.cn, yang.yonggang@zte.com.cn
Cc: dev@dpdk.org, Bingbin Chen <chen.bingbin@zte.com.cn>
Subject: [PATCH v7 0/2] add support flow director ops
Date: Wed, 27 Aug 2025 16:39:03 +0800
Message-ID: <20250827083909.2849389-1-chen.bingbin@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250815074221.2254545-1-chen.bingbin@zte.com.cn>
References: <20250815074221.2254545-1-chen.bingbin@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn 57R8oJP0093867
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: chen.bingbin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Wed, 27 Aug 2025 16:50:45 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68AEC6E5.000/4cBdXj5ymXz8Xs6v
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

djc6DQogIC0gbW9kaWZ5IHRoZSBpbml0aWFsaXphdGlvbiBvZiB2YXJpYWJsZXMgaW4gdGhlIGZ1
bmN0aW9uDQogICAgYW5kIGRlZmluZSB0aGVtIHdoZW4gdGhleSBhcmUgdXNlZC4NCiAgLSB1ZXMg
bWFsbG9jIGluc3RlYWQgb2YgcnRlX3ptYWxsb2MgaW4gYWNsIGR1bXAgY29kZS4NCg0KdjY6DQog
IC0gZml4IHJ0ZV9mcmVlIGNvbXBpbGF0aW9uIGVycm9ycy4NCg0KdjU6DQogIC0gbW9kaWZ5IHNv
bWUgZXJyb3IgbGV2ZWwgcHJpbnRpbmcgaW5mb3JtYXRpb24sDQogICAgYW5kIG90aGVyIGlzc3Vl
cyBmcm9tIE1haW50YWluZXIncy4NCg0KVjQ6DQogIC0gcmVwbGFjZSBydGVfbWFsbG9jIHdpdGgg
Y2FsbG9jIGluIHRoZSBmbG93X2Rldl9kdW1wIGZ1bmN0aW9uLg0KDQpWMzoNCiAgLSBmaXggc2V2
ZXJhbCBjaGVja3BhdGNoIHdhcm5pbmdzLg0KDQpWMjoNCiAgLSByZXNvbHZlIGNvZGUgc3R5bGUg
YW5kIGdjYyBjb21waWxhdGlvbiBpc3N1ZS4NCg0KVjE6DQogIC0gYWRkIHN1cHBvcnQgZmxvdyBk
aXJlY3RvciBvcHMuDQoNCkJpbmdiaW4gQ2hlbiAoMik6DQogIG5ldC96eGRoOiBucHNkayBhZGQg
ZmxvdyBkaXJlY3RvciB0YWJsZSBvcHMNCiAgbmV0L3p4ZGg6IGFkZCBzdXBwb3J0IGZsb3cgZGly
ZWN0b3Igb3BzDQoNCiBkb2MvZ3VpZGVzL25pY3MvZmVhdHVyZXMvenhkaC5pbmkgIHwgICAxNiAr
DQogZG9jL2d1aWRlcy9uaWNzL3p4ZGgucnN0ICAgICAgICAgICB8ICAgIDEgKw0KIGRyaXZlcnMv
bmV0L3p4ZGgvbWVzb24uYnVpbGQgICAgICAgfCAgICAxICsNCiBkcml2ZXJzL25ldC96eGRoL3p4
ZGhfY29tbW9uLmggICAgIHwgICAgMSArDQogZHJpdmVycy9uZXQvenhkaC96eGRoX2V0aGRldi5j
ICAgICB8ICAgMjYgKw0KIGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9ldGhkZXYuaCAgICAgfCAgIDEy
ICstDQogZHJpdmVycy9uZXQvenhkaC96eGRoX2V0aGRldl9vcHMuYyB8ICAgIDIgKy0NCiBkcml2
ZXJzL25ldC96eGRoL3p4ZGhfZXRoZGV2X29wcy5oIHwgICAgMSArDQogZHJpdmVycy9uZXQvenhk
aC96eGRoX2Zsb3cuYyAgICAgICB8IDIwMTkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
IGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9mbG93LmggICAgICAgfCAgMjQwICsrKysNCiBkcml2ZXJz
L25ldC96eGRoL3p4ZGhfbXNnLmMgICAgICAgIHwgIDI2NCArKystDQogZHJpdmVycy9uZXQvenhk
aC96eGRoX21zZy5oICAgICAgICB8ICAgMzEgKy0NCiBkcml2ZXJzL25ldC96eGRoL3p4ZGhfbnAu
YyAgICAgICAgIHwgMTQ4MiArKysrKysrKysrKysrKysrKysrKw0KIGRyaXZlcnMvbmV0L3p4ZGgv
enhkaF9ucC5oICAgICAgICAgfCAgIDMxICstDQogZHJpdmVycy9uZXQvenhkaC96eGRoX3RhYmxl
cy5oICAgICB8ICAgMTAgKy0NCiAxNSBmaWxlcyBjaGFuZ2VkLCA0MDYzIGluc2VydGlvbnMoKyks
IDc0IGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC96eGRoL3p4
ZGhfZmxvdy5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9mbG93
LmgNCg0KLS0gDQoyLjI3LjA=


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

djc6PGJyIC8+Jm5ic3A7Jm5ic3A7LSZuYnNwO21vZGlmeSZuYnNwO3RoZSZuYnNwO2luaXRpYWxp
emF0aW9uJm5ic3A7b2YmbmJzcDt2YXJpYWJsZXMmbmJzcDtpbiZuYnNwO3RoZSZuYnNwO2Z1bmN0
aW9uPGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7YW5kJm5ic3A7ZGVmaW5lJm5ic3A7dGhl
bSZuYnNwO3doZW4mbmJzcDt0aGV5Jm5ic3A7YXJlJm5ic3A7dXNlZC48YnIgLz4mbmJzcDsmbmJz
cDstJm5ic3A7dWVzJm5ic3A7bWFsbG9jJm5ic3A7aW5zdGVhZCZuYnNwO29mJm5ic3A7cnRlX3pt
YWxsb2MmbmJzcDtpbiZuYnNwO2FjbCZuYnNwO2R1bXAmbmJzcDtjb2RlLjxiciAvPg08YnIgLz52
Njo8YnIgLz4mbmJzcDsmbmJzcDstJm5ic3A7Zml4Jm5ic3A7cnRlX2ZyZWUmbmJzcDtjb21waWxh
dGlvbiZuYnNwO2Vycm9ycy48YnIgLz4NPGJyIC8+djU6PGJyIC8+Jm5ic3A7Jm5ic3A7LSZuYnNw
O21vZGlmeSZuYnNwO3NvbWUmbmJzcDtlcnJvciZuYnNwO2xldmVsJm5ic3A7cHJpbnRpbmcmbmJz
cDtpbmZvcm1hdGlvbiw8YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDthbmQmbmJzcDtvdGhl
ciZuYnNwO2lzc3VlcyZuYnNwO2Zyb20mbmJzcDtNYWludGFpbmVyJmFwb3M7cy48YnIgLz4NPGJy
IC8+VjQ6PGJyIC8+Jm5ic3A7Jm5ic3A7LSZuYnNwO3JlcGxhY2UmbmJzcDtydGVfbWFsbG9jJm5i
c3A7d2l0aCZuYnNwO2NhbGxvYyZuYnNwO2luJm5ic3A7dGhlJm5ic3A7Zmxvd19kZXZfZHVtcCZu
YnNwO2Z1bmN0aW9uLjxiciAvPg08YnIgLz5WMzo8YnIgLz4mbmJzcDsmbmJzcDstJm5ic3A7Zml4
Jm5ic3A7c2V2ZXJhbCZuYnNwO2NoZWNrcGF0Y2gmbmJzcDt3YXJuaW5ncy48YnIgLz4NPGJyIC8+
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
cDsmbmJzcDsmbmJzcDt8Jm5ic3A7Jm5ic3A7Jm5ic3A7MjYmbmJzcDsrPGJyIC8+Jm5ic3A7ZHJp
dmVycy9uZXQvenhkaC96eGRoX2V0aGRldi5oJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
fCZuYnNwOyZuYnNwOyZuYnNwOzEyJm5ic3A7Ky08YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRo
L3p4ZGhfZXRoZGV2X29wcy5jJm5ic3A7fCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOzImbmJzcDsr
LTxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9ldGhkZXZfb3BzLmgmbmJzcDt8Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7MSZuYnNwOys8YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRo
L3p4ZGhfZmxvdy5jJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZu
YnNwOzIwMTkmbmJzcDsrKysrKysrKysrKysrKysrKysrKysrKysrKysrPGJyIC8+Jm5ic3A7ZHJp
dmVycy9uZXQvenhkaC96eGRoX2Zsb3cuaCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwO3wmbmJzcDsmbmJzcDsyNDAmbmJzcDsrKysrPGJyIC8+Jm5ic3A7ZHJpdmVycy9u
ZXQvenhkaC96eGRoX21zZy5jJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7fCZuYnNwOyZuYnNwOzI2NCZuYnNwOysrKy08YnIgLz4mbmJzcDtkcml2ZXJzL25l
dC96eGRoL3p4ZGhfbXNnLmgmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDt8Jm5ic3A7Jm5ic3A7Jm5ic3A7MzEmbmJzcDsrLTxiciAvPiZuYnNwO2RyaXZlcnMv
bmV0L3p4ZGgvenhkaF9ucC5jJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOzE0ODImbmJzcDsrKysrKysrKysrKysrKysrKysrKzxiciAv
PiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9ucC5oJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOyZuYnNwOyZuYnNwOzMxJm5ic3A7
Ky08YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfdGFibGVzLmgmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7Jm5ic3A7Jm5ic3A7MTAmbmJzcDsrLTxiciAvPiZuYnNw
OzE1Jm5ic3A7ZmlsZXMmbmJzcDtjaGFuZ2VkLCZuYnNwOzQwNjMmbmJzcDtpbnNlcnRpb25zKCsp
LCZuYnNwOzc0Jm5ic3A7ZGVsZXRpb25zKC0pPGJyIC8+Jm5ic3A7Y3JlYXRlJm5ic3A7bW9kZSZu
YnNwOzEwMDY0NCZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9mbG93LmM8YnIgLz4mbmJzcDtj
cmVhdGUmbmJzcDttb2RlJm5ic3A7MTAwNjQ0Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96eGRoX2Zs
b3cuaDxiciAvPg08YnIgLz4tLSZuYnNwOw08YnIgLz4yLjI3LjA8YnIgLz4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

