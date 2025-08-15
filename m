Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70CBCA0ED1
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 07:53:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B74CD4026C;
	Fri, 15 Aug 2025 09:53:00 +0200 (CEST)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
 by mails.dpdk.org (Postfix) with ESMTP id 37FC2400EF
 for <dev@dpdk.org>; Fri, 15 Aug 2025 09:52:59 +0200 (CEST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4c3DqS6m8Yz4xNv9;
 Fri, 15 Aug 2025 15:52:52 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
 by mse-fl1.zte.com.cn with SMTP id 57F7qdBn090010;
 Fri, 15 Aug 2025 15:52:39 +0800 (+08)
 (envelope-from chen.bingbin@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Fri, 15 Aug 2025 15:52:41 +0800
X-Zmail-TransId: 3e81689ee742002-2dc08
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: chen.bingbin@zte.com.cn
From: Bingbin Chen <chen.bingbin@zte.com.cn>
To: stephen@networkplumber.org, ivan.malov@arknetworks.am,
 wang.junlong1@zte.com.cn, yang.yonggang@zte.com.cn
Cc: dev@dpdk.org, Bingbin Chen <chen.bingbin@zte.com.cn>
Subject: [PATCH v6 0/2] add support flow director ops
Date: Fri, 15 Aug 2025 15:42:15 +0800
Message-ID: <20250815074221.2254545-1-chen.bingbin@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814025248.2194951-1-chen.bingbin@zte.com.cn>
References: <20250814025248.2194951-1-chen.bingbin@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 57F7qdBn090010
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: chen.bingbin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Fri, 15 Aug 2025 15:52:52 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 689EE754.000/4c3DqS6m8Yz4xNv9
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

djY6DQogIC0gZml4IHJ0ZV9mcmVlIGNvbXBpbGF0aW9uIGVycm9ycy4NCg0KdjU6DQogIC0gbW9k
aWZ5IHNvbWUgZXJyb3IgbGV2ZWwgcHJpbnRpbmcgaW5mb3JtYXRpb24sDQogICAgYW5kIG90aGVy
IGlzc3VlcyBmcm9tIE1haW50YWluZXIncy4NCg0KVjQ6DQogIC0gcmVwbGFjZSBydGVfbWFsbG9j
IHdpdGggY2FsbG9jIGluIHRoZSBmbG93X2Rldl9kdW1wIGZ1bmN0aW9uLg0KDQpWMzoNCiAgLSBm
aXggc2V2ZXJhbCBjaGVja3BhdGNoIHdhcm5pbmdzLg0KDQpWMjoNCiAgLSByZXNvbHZlIGNvZGUg
c3R5bGUgYW5kIGdjYyBjb21waWxhdGlvbiBpc3N1ZS4NCg0KVjE6DQogIC0gYWRkIHN1cHBvcnQg
ZmxvdyBkaXJlY3RvciBvcHMuDQoNCkJpbmdiaW4gQ2hlbiAoMik6DQogIG5ldC96eGRoOiBucHNk
ayBhZGQgZmxvdyBkaXJlY3RvciB0YWJsZSBvcHMNCiAgbmV0L3p4ZGg6IGFkZCBzdXBwb3J0IGZs
b3cgZGlyZWN0b3Igb3BzDQoNCiBkb2MvZ3VpZGVzL25pY3MvZmVhdHVyZXMvenhkaC5pbmkgIHwg
ICAxNiArDQogZG9jL2d1aWRlcy9uaWNzL3p4ZGgucnN0ICAgICAgICAgICB8ICAgIDEgKw0KIGRy
aXZlcnMvbmV0L3p4ZGgvbWVzb24uYnVpbGQgICAgICAgfCAgICAxICsNCiBkcml2ZXJzL25ldC96
eGRoL3p4ZGhfY29tbW9uLmggICAgIHwgICAgMSArDQogZHJpdmVycy9uZXQvenhkaC96eGRoX2V0
aGRldi5jICAgICB8ICAgMjYgKw0KIGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9ldGhkZXYuaCAgICAg
fCAgIDEyICstDQogZHJpdmVycy9uZXQvenhkaC96eGRoX2V0aGRldl9vcHMuYyB8ICAgIDIgKy0N
CiBkcml2ZXJzL25ldC96eGRoL3p4ZGhfZXRoZGV2X29wcy5oIHwgICAgMSArDQogZHJpdmVycy9u
ZXQvenhkaC96eGRoX2Zsb3cuYyAgICAgICB8IDIwMTcgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKw0KIGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9mbG93LmggICAgICAgfCAgMjQwICsrKysNCiBk
cml2ZXJzL25ldC96eGRoL3p4ZGhfbXNnLmMgICAgICAgIHwgIDI2NCArKystDQogZHJpdmVycy9u
ZXQvenhkaC96eGRoX21zZy5oICAgICAgICB8ICAgMzEgKy0NCiBkcml2ZXJzL25ldC96eGRoL3p4
ZGhfbnAuYyAgICAgICAgIHwgMTYzOCArKysrKysrKysrKysrKysrKysrKysrDQogZHJpdmVycy9u
ZXQvenhkaC96eGRoX25wLmggICAgICAgICB8ICAgMzEgKy0NCiBkcml2ZXJzL25ldC96eGRoL3p4
ZGhfdGFibGVzLmggICAgIHwgICAxMCArLQ0KIDE1IGZpbGVzIGNoYW5nZWQsIDQyMTcgaW5zZXJ0
aW9ucygrKSwgNzQgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0
L3p4ZGgvenhkaF9mbG93LmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvenhkaC96
eGRoX2Zsb3cuaA0KDQotLSANCjIuMjcuMA==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

djY6PGJyIC8+Jm5ic3A7Jm5ic3A7LSZuYnNwO2ZpeCZuYnNwO3J0ZV9mcmVlJm5ic3A7Y29tcGls
YXRpb24mbmJzcDtlcnJvcnMuPGJyIC8+DTxiciAvPnY1OjxiciAvPiZuYnNwOyZuYnNwOy0mbmJz
cDttb2RpZnkmbmJzcDtzb21lJm5ic3A7ZXJyb3ImbmJzcDtsZXZlbCZuYnNwO3ByaW50aW5nJm5i
c3A7aW5mb3JtYXRpb24sPGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7YW5kJm5ic3A7b3Ro
ZXImbmJzcDtpc3N1ZXMmbmJzcDtmcm9tJm5ic3A7TWFpbnRhaW5lciZhcG9zO3MuPGJyIC8+DTxi
ciAvPlY0OjxiciAvPiZuYnNwOyZuYnNwOy0mbmJzcDtyZXBsYWNlJm5ic3A7cnRlX21hbGxvYyZu
YnNwO3dpdGgmbmJzcDtjYWxsb2MmbmJzcDtpbiZuYnNwO3RoZSZuYnNwO2Zsb3dfZGV2X2R1bXAm
bmJzcDtmdW5jdGlvbi48YnIgLz4NPGJyIC8+VjM6PGJyIC8+Jm5ic3A7Jm5ic3A7LSZuYnNwO2Zp
eCZuYnNwO3NldmVyYWwmbmJzcDtjaGVja3BhdGNoJm5ic3A7d2FybmluZ3MuPGJyIC8+DTxiciAv
PlYyOjxiciAvPiZuYnNwOyZuYnNwOy0mbmJzcDtyZXNvbHZlJm5ic3A7Y29kZSZuYnNwO3N0eWxl
Jm5ic3A7YW5kJm5ic3A7Z2NjJm5ic3A7Y29tcGlsYXRpb24mbmJzcDtpc3N1ZS48YnIgLz4NPGJy
IC8+VjE6PGJyIC8+Jm5ic3A7Jm5ic3A7LSZuYnNwO2FkZCZuYnNwO3N1cHBvcnQmbmJzcDtmbG93
Jm5ic3A7ZGlyZWN0b3ImbmJzcDtvcHMuPGJyIC8+DTxiciAvPkJpbmdiaW4mbmJzcDtDaGVuJm5i
c3A7KDIpOjxiciAvPiZuYnNwOyZuYnNwO25ldC96eGRoOiZuYnNwO25wc2RrJm5ic3A7YWRkJm5i
c3A7ZmxvdyZuYnNwO2RpcmVjdG9yJm5ic3A7dGFibGUmbmJzcDtvcHM8YnIgLz4mbmJzcDsmbmJz
cDtuZXQvenhkaDombmJzcDthZGQmbmJzcDtzdXBwb3J0Jm5ic3A7ZmxvdyZuYnNwO2RpcmVjdG9y
Jm5ic3A7b3BzPGJyIC8+DTxiciAvPiZuYnNwO2RvYy9ndWlkZXMvbmljcy9mZWF0dXJlcy96eGRo
LmluaSZuYnNwOyZuYnNwO3wmbmJzcDsmbmJzcDsmbmJzcDsxNiZuYnNwOys8YnIgLz4mbmJzcDtk
b2MvZ3VpZGVzL25pY3MvenhkaC5yc3QmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
MSZuYnNwOys8YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL21lc29uLmJ1aWxkJm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OzEmbmJzcDsrPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96eGRoX2NvbW1vbi5oJm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOzEmbmJzcDsr
PGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96eGRoX2V0aGRldi5jJm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOyZuYnNwOyZuYnNwOzI2Jm5ic3A7KzxiciAvPiZuYnNwO2Ry
aXZlcnMvbmV0L3p4ZGgvenhkaF9ldGhkZXYuaCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
O3wmbmJzcDsmbmJzcDsmbmJzcDsxMiZuYnNwOystPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhk
aC96eGRoX2V0aGRldl9vcHMuYyZuYnNwO3wmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsyJm5ic3A7
Ky08YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfZXRoZGV2X29wcy5oJm5ic3A7fCZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOzEmbmJzcDsrPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhk
aC96eGRoX2Zsb3cuYyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wm
bmJzcDsyMDE3Jm5ic3A7KysrKysrKysrKysrKysrKysrKysrKysrKysrKzxiciAvPiZuYnNwO2Ry
aXZlcnMvbmV0L3p4ZGgvenhkaF9mbG93LmgmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDt8Jm5ic3A7Jm5ic3A7MjQwJm5ic3A7KysrKzxiciAvPiZuYnNwO2RyaXZlcnMv
bmV0L3p4ZGgvenhkaF9tc2cuYyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwO3wmbmJzcDsmbmJzcDsyNjQmbmJzcDsrKystPGJyIC8+Jm5ic3A7ZHJpdmVycy9u
ZXQvenhkaC96eGRoX21zZy5oJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7fCZuYnNwOyZuYnNwOyZuYnNwOzMxJm5ic3A7Ky08YnIgLz4mbmJzcDtkcml2ZXJz
L25ldC96eGRoL3p4ZGhfbnAuYyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwO3wmbmJzcDsxNjM4Jm5ic3A7KysrKysrKysrKysrKysrKysrKysrKzxi
ciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9ucC5oJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOyZuYnNwOyZuYnNwOzMxJm5i
c3A7Ky08YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfdGFibGVzLmgmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7Jm5ic3A7Jm5ic3A7MTAmbmJzcDsrLTxiciAvPiZu
YnNwOzE1Jm5ic3A7ZmlsZXMmbmJzcDtjaGFuZ2VkLCZuYnNwOzQyMTcmbmJzcDtpbnNlcnRpb25z
KCspLCZuYnNwOzc0Jm5ic3A7ZGVsZXRpb25zKC0pPGJyIC8+Jm5ic3A7Y3JlYXRlJm5ic3A7bW9k
ZSZuYnNwOzEwMDY0NCZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9mbG93LmM8YnIgLz4mbmJz
cDtjcmVhdGUmbmJzcDttb2RlJm5ic3A7MTAwNjQ0Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96eGRo
X2Zsb3cuaDxiciAvPg08YnIgLz4tLSZuYnNwOw08YnIgLz4yLjI3LjA8YnIgLz4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

