Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E93C87FD3
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 07:21:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A5C340270;
	Fri,  8 Aug 2025 09:21:02 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
 by mails.dpdk.org (Postfix) with ESMTP id B2A7340150
 for <dev@dpdk.org>; Fri,  8 Aug 2025 09:20:59 +0200 (CEST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bywRq6GNfz8Xs6y;
 Fri, 08 Aug 2025 15:20:55 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
 by mse-fl1.zte.com.cn with SMTP id 5787KYm5035127;
 Fri, 8 Aug 2025 15:20:34 +0800 (+08)
 (envelope-from wang.junlong1@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Fri, 8 Aug 2025 15:20:36 +0800
X-Zmail-TransId: 3e816895a53c001-39d88
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: wang.junlong1@zte.com.cn
From: Junlong Wang <wang.junlong1@zte.com.cn>
To: stephen@networkplumber.org, wang.junlong1@zte.com.cn,
 yang.yonggang@zte.com.cn
Cc: dev@dpdk.org, Bingbin Chen <chen.bingbin@zte.com.cn>
Subject: [PATCH v4 0/2] add support flow director ops
Date: Fri,  8 Aug 2025 15:10:35 +0800
Message-ID: <20250808071048.1906724-1-wang.junlong1@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702073453.113779-1-chen.bingbin@zte.com.cn>
References: <20250702073453.113779-1-chen.bingbin@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 5787KYm5035127
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.junlong1@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Fri, 08 Aug 2025 15:20:55 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6895A557.003/4bywRq6GNfz8Xs6y
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

RnJvbTogQmluZ2JpbiBDaGVuIDxjaGVuLmJpbmdiaW5AenRlLmNvbS5jbj4NCg0KVjQ6DQogIC0g
cmVwbGFjZSBydGVfbWFsbG9jIHdpdGggY2FsbG9jIGluIHRoZSBmbG93X2Rldl9kdW1wIGZ1bmN0
aW9uLg0KDQpWMzoNCiAgLSBmaXggc2V2ZXJhbCBjaGVja3BhdGNoIHdhcm5pbmdzLg0KDQpWMjoN
CiAgLSByZXNvbHZlIGNvZGUgc3R5bGUgYW5kIGdjYyBjb21waWxhdGlvbiBpc3N1ZS4NCg0KVjE6
DQogIC0gYWRkIHN1cHBvcnQgZmxvdyBkaXJlY3RvciBvcHMuDQoNCkJpbmdiaW4gQ2hlbiAoMik6
DQogIG5ldC96eGRoOiBucHNkayBhZGQgZmxvdyBkaXJlY3RvciB0YWJsZSBvcHMNCiAgbmV0L3p4
ZGg6IGFkZCBzdXBwb3J0IGZsb3cgZGlyZWN0b3Igb3BzDQoNCiBkb2MvZ3VpZGVzL25pY3MvZmVh
dHVyZXMvenhkaC5pbmkgIHwgICAxNiArDQogZG9jL2d1aWRlcy9uaWNzL3p4ZGgucnN0ICAgICAg
ICAgICB8ICAgIDEgKw0KIGRyaXZlcnMvbmV0L3p4ZGgvbWVzb24uYnVpbGQgICAgICAgfCAgICAx
ICsNCiBkcml2ZXJzL25ldC96eGRoL3p4ZGhfY29tbW9uLmggICAgIHwgICAgMSArDQogZHJpdmVy
cy9uZXQvenhkaC96eGRoX2V0aGRldi5jICAgICB8ICAgMjYgKw0KIGRyaXZlcnMvbmV0L3p4ZGgv
enhkaF9ldGhkZXYuaCAgICAgfCAgIDEyICstDQogZHJpdmVycy9uZXQvenhkaC96eGRoX2V0aGRl
dl9vcHMuYyB8ICAgIDIgKy0NCiBkcml2ZXJzL25ldC96eGRoL3p4ZGhfZXRoZGV2X29wcy5oIHwg
ICAgMSArDQogZHJpdmVycy9uZXQvenhkaC96eGRoX2Zsb3cuYyAgICAgICB8IDIwMDAgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KIGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9mbG93LmggICAg
ICAgfCAgMjM3ICsrKysNCiBkcml2ZXJzL25ldC96eGRoL3p4ZGhfbXNnLmMgICAgICAgIHwgIDI2
NCArKystDQogZHJpdmVycy9uZXQvenhkaC96eGRoX21zZy5oICAgICAgICB8ICAgMzEgKy0NCiBk
cml2ZXJzL25ldC96eGRoL3p4ZGhfbnAuYyAgICAgICAgIHwgMTYzOCArKysrKysrKysrKysrKysr
KysrKysrKw0KIGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9ucC5oICAgICAgICAgfCAgIDMxICstDQog
ZHJpdmVycy9uZXQvenhkaC96eGRoX3RhYmxlcy5oICAgICB8ICAgMTAgKy0NCiAxNSBmaWxlcyBj
aGFuZ2VkLCA0MTk3IGluc2VydGlvbnMoKyksIDc0IGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBkcml2ZXJzL25ldC96eGRoL3p4ZGhfZmxvdy5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9mbG93LmgNCg0KLS0gDQoyLjI3LjA=


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbTombmJzcDtCaW5nYmluJm5ic3A7Q2hlbiZuYnNwOyZsdDtjaGVuLmJpbmdiaW5AenRlLmNv
bS5jbiZndDsNPGJyIC8+DTxiciAvPlY0OjxiciAvPiZuYnNwOyZuYnNwOy0mbmJzcDtyZXBsYWNl
Jm5ic3A7cnRlX21hbGxvYyZuYnNwO3dpdGgmbmJzcDtjYWxsb2MmbmJzcDtpbiZuYnNwO3RoZSZu
YnNwO2Zsb3dfZGV2X2R1bXAmbmJzcDtmdW5jdGlvbi48YnIgLz4NPGJyIC8+VjM6PGJyIC8+Jm5i
c3A7Jm5ic3A7LSZuYnNwO2ZpeCZuYnNwO3NldmVyYWwmbmJzcDtjaGVja3BhdGNoJm5ic3A7d2Fy
bmluZ3MuPGJyIC8+DTxiciAvPlYyOjxiciAvPiZuYnNwOyZuYnNwOy0mbmJzcDtyZXNvbHZlJm5i
c3A7Y29kZSZuYnNwO3N0eWxlJm5ic3A7YW5kJm5ic3A7Z2NjJm5ic3A7Y29tcGlsYXRpb24mbmJz
cDtpc3N1ZS48YnIgLz4NPGJyIC8+VjE6PGJyIC8+Jm5ic3A7Jm5ic3A7LSZuYnNwO2FkZCZuYnNw
O3N1cHBvcnQmbmJzcDtmbG93Jm5ic3A7ZGlyZWN0b3ImbmJzcDtvcHMuPGJyIC8+DTxiciAvPkJp
bmdiaW4mbmJzcDtDaGVuJm5ic3A7KDIpOjxiciAvPiZuYnNwOyZuYnNwO25ldC96eGRoOiZuYnNw
O25wc2RrJm5ic3A7YWRkJm5ic3A7ZmxvdyZuYnNwO2RpcmVjdG9yJm5ic3A7dGFibGUmbmJzcDtv
cHM8YnIgLz4mbmJzcDsmbmJzcDtuZXQvenhkaDombmJzcDthZGQmbmJzcDtzdXBwb3J0Jm5ic3A7
ZmxvdyZuYnNwO2RpcmVjdG9yJm5ic3A7b3BzPGJyIC8+DTxiciAvPiZuYnNwO2RvYy9ndWlkZXMv
bmljcy9mZWF0dXJlcy96eGRoLmluaSZuYnNwOyZuYnNwO3wmbmJzcDsmbmJzcDsmbmJzcDsxNiZu
YnNwOys8YnIgLz4mbmJzcDtkb2MvZ3VpZGVzL25pY3MvenhkaC5yc3QmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7MSZuYnNwOys8YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL21l
c29uLmJ1aWxkJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOzEmbmJzcDsrPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96
eGRoX2NvbW1vbi5oJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOzEmbmJzcDsrPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96eGRoX2V0aGRl
di5jJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOyZuYnNwOyZuYnNwOzI2Jm5i
c3A7KzxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9ldGhkZXYuaCZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwO3wmbmJzcDsmbmJzcDsmbmJzcDsxMiZuYnNwOystPGJyIC8+Jm5i
c3A7ZHJpdmVycy9uZXQvenhkaC96eGRoX2V0aGRldl9vcHMuYyZuYnNwO3wmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsyJm5ic3A7Ky08YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfZXRo
ZGV2X29wcy5oJm5ic3A7fCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOzEmbmJzcDsrPGJyIC8+Jm5i
c3A7ZHJpdmVycy9uZXQvenhkaC96eGRoX2Zsb3cuYyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwO3wmbmJzcDsyMDAwJm5ic3A7KysrKysrKysrKysrKysrKysrKysrKysr
KysrKzxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9mbG93LmgmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt8Jm5ic3A7Jm5ic3A7MjM3Jm5ic3A7KysrKzxi
ciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9tc2cuYyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wmbmJzcDsmbmJzcDsyNjQmbmJzcDsrKystPGJy
IC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96eGRoX21zZy5oJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOyZuYnNwOyZuYnNwOzMxJm5ic3A7Ky08
YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfbnAuYyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wmbmJzcDsxNjM4Jm5ic3A7KysrKysr
KysrKysrKysrKysrKysrKys8YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfbnAuaCZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wmbmJz
cDsmbmJzcDsmbmJzcDszMSZuYnNwOystPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvenhkaC96eGRo
X3RhYmxlcy5oJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOyZuYnNwOyZuYnNw
OzEwJm5ic3A7Ky08YnIgLz4mbmJzcDsxNSZuYnNwO2ZpbGVzJm5ic3A7Y2hhbmdlZCwmbmJzcDs0
MTk3Jm5ic3A7aW5zZXJ0aW9ucygrKSwmbmJzcDs3NCZuYnNwO2RlbGV0aW9ucygtKTxiciAvPiZu
YnNwO2NyZWF0ZSZuYnNwO21vZGUmbmJzcDsxMDA2NDQmbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4
ZGhfZmxvdy5jPGJyIC8+Jm5ic3A7Y3JlYXRlJm5ic3A7bW9kZSZuYnNwOzEwMDY0NCZuYnNwO2Ry
aXZlcnMvbmV0L3p4ZGgvenhkaF9mbG93Lmg8YnIgLz4NPGJyIC8+LS0mbmJzcDsNPGJyIC8+Mi4y
Ny4wPGJyIC8+


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

