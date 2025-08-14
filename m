Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F89CA0EE0
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 03:03:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C2E9402EA;
	Thu, 14 Aug 2025 05:03:35 +0200 (CEST)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
 by mails.dpdk.org (Postfix) with ESMTP id 0576F402A8
 for <dev@dpdk.org>; Thu, 14 Aug 2025 05:03:32 +0200 (CEST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4c2VS01lfKz4xNv0;
 Thu, 14 Aug 2025 11:03:28 +0800 (CST)
Received: from szxl2zmapp05.zte.com.cn ([10.1.32.37])
 by mse-fl2.zte.com.cn with SMTP id 57E332rs013815;
 Thu, 14 Aug 2025 11:03:02 +0800 (+08)
 (envelope-from chen.bingbin@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Thu, 14 Aug 2025 11:03:03 +0800
X-Zmail-TransId: 3e81689d51df001-f14e7
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: chen.bingbin@zte.com.cn
From: Bingbin Chen <chen.bingbin@zte.com.cn>
To: stephen@networkplumber.org, ivan.malov@arknetworks.am,
 wang.junlong1@zte.com.cn, yang.yonggang@zte.com.cn
Cc: dev@dpdk.org, Bingbin Chen <chen.bingbin@zte.com.cn>
Subject: [PATCH v5 0/2] add support flow director ops
Date: Thu, 14 Aug 2025 10:52:40 +0800
Message-ID: <20250814025248.2194951-1-chen.bingbin@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250808071048.1906724-1-wang.junlong1@zte.com.cn>
References: <20250808071048.1906724-1-wang.junlong1@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn 57E332rs013815
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: chen.bingbin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Thu, 14 Aug 2025 11:03:28 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 689D5200.000/4c2VS01lfKz4xNv0
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

djU6DQogIC0gbW9kaWZ5IHNvbWUgZXJyb3IgbGV2ZWwgcHJpbnRpbmcgaW5mb3JtYXRpb24sDQog
ICAgYW5kIG90aGVyIGlzc3VlcyBmcm9tIE1haW50YWluZXIncy4NCg0KVjQ6DQogIC0gcmVwbGFj
ZSBydGVfbWFsbG9jIHdpdGggY2FsbG9jIGluIHRoZSBmbG93X2Rldl9kdW1wIGZ1bmN0aW9uLg0K
DQpWMzoNCiAgLSBmaXggc2V2ZXJhbCBjaGVja3BhdGNoIHdhcm5pbmdzLg0KDQpWMjoNCiAgLSBy
ZXNvbHZlIGNvZGUgc3R5bGUgYW5kIGdjYyBjb21waWxhdGlvbiBpc3N1ZS4NCg0KVjE6DQogIC0g
YWRkIHN1cHBvcnQgZmxvdyBkaXJlY3RvciBvcHMuDQoNCkJpbmdiaW4gQ2hlbiAoMik6DQogIG5l
dC96eGRoOiBucHNkayBhZGQgZmxvdyBkaXJlY3RvciB0YWJsZSBvcHMNCiAgbmV0L3p4ZGg6IGFk
ZCBzdXBwb3J0IGZsb3cgZGlyZWN0b3Igb3BzDQoNCiBkb2MvZ3VpZGVzL25pY3MvZmVhdHVyZXMv
enhkaC5pbmkgIHwgICAxNiArDQogZG9jL2d1aWRlcy9uaWNzL3p4ZGgucnN0ICAgICAgICAgICB8
ICAgIDEgKw0KIGRyaXZlcnMvbmV0L3p4ZGgvbWVzb24uYnVpbGQgICAgICAgfCAgICAxICsNCiBk
cml2ZXJzL25ldC96eGRoL3p4ZGhfY29tbW9uLmggICAgIHwgICAgMSArDQogZHJpdmVycy9uZXQv
enhkaC96eGRoX2V0aGRldi5jICAgICB8ICAgMjYgKw0KIGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9l
dGhkZXYuaCAgICAgfCAgIDEyICstDQogZHJpdmVycy9uZXQvenhkaC96eGRoX2V0aGRldl9vcHMu
YyB8ICAgIDIgKy0NCiBkcml2ZXJzL25ldC96eGRoL3p4ZGhfZXRoZGV2X29wcy5oIHwgICAgMSAr
DQogZHJpdmVycy9uZXQvenhkaC96eGRoX2Zsb3cuYyAgICAgICB8IDIwMTcgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KIGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9mbG93LmggICAgICAgfCAg
MjQwICsrKysNCiBkcml2ZXJzL25ldC96eGRoL3p4ZGhfbXNnLmMgICAgICAgIHwgIDI2NCArKyst
DQogZHJpdmVycy9uZXQvenhkaC96eGRoX21zZy5oICAgICAgICB8ICAgMzEgKy0NCiBkcml2ZXJz
L25ldC96eGRoL3p4ZGhfbnAuYyAgICAgICAgIHwgMTYzOCArKysrKysrKysrKysrKysrKysrKysr
DQogZHJpdmVycy9uZXQvenhkaC96eGRoX25wLmggICAgICAgICB8ICAgMzEgKy0NCiBkcml2ZXJz
L25ldC96eGRoL3p4ZGhfdGFibGVzLmggICAgIHwgICAxMCArLQ0KIDE1IGZpbGVzIGNoYW5nZWQs
IDQyMTcgaW5zZXJ0aW9ucygrKSwgNzQgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9mbG93LmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVy
cy9uZXQvenhkaC96eGRoX2Zsb3cuaA0KDQotLSANCjIuMjcuMA==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

djU6PGJyIC8+Jm5ic3A7Jm5ic3A7LSZuYnNwO21vZGlmeSZuYnNwO3NvbWUmbmJzcDtlcnJvciZu
YnNwO2xldmVsJm5ic3A7cHJpbnRpbmcmbmJzcDtpbmZvcm1hdGlvbiw8YnIgLz4mbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDthbmQmbmJzcDtvdGhlciZuYnNwO2lzc3VlcyZuYnNwO2Zyb20mbmJzcDtN
YWludGFpbmVyJmFwb3M7cy48YnIgLz4NPGJyIC8+VjQ6PGJyIC8+Jm5ic3A7Jm5ic3A7LSZuYnNw
O3JlcGxhY2UmbmJzcDtydGVfbWFsbG9jJm5ic3A7d2l0aCZuYnNwO2NhbGxvYyZuYnNwO2luJm5i
c3A7dGhlJm5ic3A7Zmxvd19kZXZfZHVtcCZuYnNwO2Z1bmN0aW9uLjxiciAvPg08YnIgLz5WMzo8
YnIgLz4mbmJzcDsmbmJzcDstJm5ic3A7Zml4Jm5ic3A7c2V2ZXJhbCZuYnNwO2NoZWNrcGF0Y2gm
bmJzcDt3YXJuaW5ncy48YnIgLz4NPGJyIC8+VjI6PGJyIC8+Jm5ic3A7Jm5ic3A7LSZuYnNwO3Jl
c29sdmUmbmJzcDtjb2RlJm5ic3A7c3R5bGUmbmJzcDthbmQmbmJzcDtnY2MmbmJzcDtjb21waWxh
dGlvbiZuYnNwO2lzc3VlLjxiciAvPg08YnIgLz5WMTo8YnIgLz4mbmJzcDsmbmJzcDstJm5ic3A7
YWRkJm5ic3A7c3VwcG9ydCZuYnNwO2Zsb3cmbmJzcDtkaXJlY3RvciZuYnNwO29wcy48YnIgLz4N
PGJyIC8+QmluZ2JpbiZuYnNwO0NoZW4mbmJzcDsoMik6PGJyIC8+Jm5ic3A7Jm5ic3A7bmV0L3p4
ZGg6Jm5ic3A7bnBzZGsmbmJzcDthZGQmbmJzcDtmbG93Jm5ic3A7ZGlyZWN0b3ImbmJzcDt0YWJs
ZSZuYnNwO29wczxiciAvPiZuYnNwOyZuYnNwO25ldC96eGRoOiZuYnNwO2FkZCZuYnNwO3N1cHBv
cnQmbmJzcDtmbG93Jm5ic3A7ZGlyZWN0b3ImbmJzcDtvcHM8YnIgLz4NPGJyIC8+Jm5ic3A7ZG9j
L2d1aWRlcy9uaWNzL2ZlYXR1cmVzL3p4ZGguaW5pJm5ic3A7Jm5ic3A7fCZuYnNwOyZuYnNwOyZu
YnNwOzE2Jm5ic3A7KzxiciAvPiZuYnNwO2RvYy9ndWlkZXMvbmljcy96eGRoLnJzdCZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
O3wmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsxJm5ic3A7KzxiciAvPiZuYnNwO2RyaXZlcnMvbmV0
L3p4ZGgvbWVzb24uYnVpbGQmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDt8Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7MSZuYnNwOys8YnIgLz4mbmJzcDtkcml2ZXJzL25l
dC96eGRoL3p4ZGhfY29tbW9uLmgmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7MSZuYnNwOys8YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4
ZGhfZXRoZGV2LmMmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7Jm5ic3A7Jm5i
c3A7MjYmbmJzcDsrPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96eGRoX2V0aGRldi5oJm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOyZuYnNwOyZuYnNwOzEyJm5ic3A7Ky08
YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfZXRoZGV2X29wcy5jJm5ic3A7fCZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOzImbmJzcDsrLTxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgv
enhkaF9ldGhkZXZfb3BzLmgmbmJzcDt8Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7MSZuYnNwOys8
YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfZmxvdy5jJm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOzIwMTcmbmJzcDsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96eGRoX2Zsb3cuaCZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wmbmJzcDsmbmJzcDsyNDAmbmJz
cDsrKysrPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96eGRoX21zZy5jJm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOyZuYnNwOzI2NCZuYnNw
OysrKy08YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfbXNnLmgmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7Jm5ic3A7Jm5ic3A7MzEm
bmJzcDsrLTxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9ucC5jJm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOzE2MzgmbmJz
cDsrKysrKysrKysrKysrKysrKysrKysrPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96eGRo
X25wLmgmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDt8Jm5ic3A7Jm5ic3A7Jm5ic3A7MzEmbmJzcDsrLTxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4
ZGgvenhkaF90YWJsZXMuaCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wmbmJzcDsmbmJz
cDsmbmJzcDsxMCZuYnNwOystPGJyIC8+Jm5ic3A7MTUmbmJzcDtmaWxlcyZuYnNwO2NoYW5nZWQs
Jm5ic3A7NDIxNyZuYnNwO2luc2VydGlvbnMoKyksJm5ic3A7NzQmbmJzcDtkZWxldGlvbnMoLSk8
YnIgLz4mbmJzcDtjcmVhdGUmbmJzcDttb2RlJm5ic3A7MTAwNjQ0Jm5ic3A7ZHJpdmVycy9uZXQv
enhkaC96eGRoX2Zsb3cuYzxiciAvPiZuYnNwO2NyZWF0ZSZuYnNwO21vZGUmbmJzcDsxMDA2NDQm
bmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfZmxvdy5oPGJyIC8+DTxiciAvPi0tJm5ic3A7DTxi
ciAvPjIuMjcuMDxiciAvPg==


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

