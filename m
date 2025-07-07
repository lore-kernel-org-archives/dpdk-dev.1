Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9140DC8303C
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 06:03:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDBF4402DF;
	Mon,  7 Jul 2025 08:03:51 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
 by mails.dpdk.org (Postfix) with ESMTP id 3567F4021E;
 Mon,  7 Jul 2025 08:03:49 +0200 (CEST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bbDFY37tlz8R044;
 Mon,  7 Jul 2025 14:03:45 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
 by mse-fl2.zte.com.cn with SMTP id 56763Yv9007164;
 Mon, 7 Jul 2025 14:03:34 +0800 (+08)
 (envelope-from wang.junlong1@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Mon, 7 Jul 2025 14:03:35 +0800
X-Zmail-TransId: 3e81686b6333000-d0a7b
X-Zmail-RealSender: wang.junlong1@zte.com.cn
From: Junlong Wang <wang.junlong1@zte.com.cn>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, Junlong Wang <wang.junlong1@zte.com.cn>, stable@dpdk.org
Subject: [PATCH v1 1/6] net/zxdh: fix meson.build issues in compilation
Date: Mon,  7 Jul 2025 13:56:16 +0800
Message-ID: <20250707055621.357606-1-wang.junlong1@zte.com.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn 56763Yv9007164
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 686B6341.000/4bbDFY37tlz8R044
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

Zml4IG1lc29uLmJ1aWxkIGlzc3VzIGluIGNvbXBpbGF0aW9uLCB3aGljaA0KY2F1c2VkIHRoZSBp
bmFiaWxpdHkgdG8gY29tcGlsZSBpbiB0aGUgYXJtNjQgZW52aXJvbm1lbnQuDQoNCkZpeGVzOiAy
OWU4OTI4OGZmMTQgKCJuZXQvenhkaDogYWRkIGRyaXZlciBza2VsZXRvbiIpDQpDYzogc3RhYmxl
QGRwZGsub3JnDQoNClNpZ25lZC1vZmYtYnk6IEp1bmxvbmcgV2FuZyA8d2FuZy5qdW5sb25nMUB6
dGUuY29tLmNuPg0KLS0tDQogZHJpdmVycy9uZXQvenhkaC9tZXNvbi5idWlsZCB8IDIgKy0NCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L3p4ZGgvbWVzb24uYnVpbGQgYi9kcml2ZXJzL25ldC96eGRoL21lc29u
LmJ1aWxkDQppbmRleCBhNDhhMGQ0M2MyLi5lYzcxNDUxYTU1IDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9uZXQvenhkaC9tZXNvbi5idWlsZA0KKysrIGIvZHJpdmVycy9uZXQvenhkaC9tZXNvbi5idWls
ZA0KQEAgLTcsNyArNyw3IEBAIGlmIG5vdCBpc19saW51eA0KICAgICBzdWJkaXJfZG9uZSgpDQog
ZW5kaWYNCiANCi1pZiBub3QgZHBka19jb25mLmhhcygnUlRFX0FSQ0hfWDg2XzY0Jykgb3Igbm90
IGRwZGtfY29uZi5nZXQoJ1JURV9BUkNIXzY0JykNCitpZiBhcmNoX3N1YmRpciAhPSAneDg2JyBh
bmQgYXJjaF9zdWJkaXIgIT0gJ2FybScgb3Igbm90IGRwZGtfY29uZi5nZXQoJ1JURV9BUkNIXzY0
JykNCiAgICAgYnVpbGQgPSBmYWxzZQ0KICAgICByZWFzb24gPSAnb25seSBzdXBwb3J0ZWQgb24g
eDg2XzY0IGFuZCBhYXJjaDY0Jw0KICAgICBzdWJkaXJfZG9uZSgpDQotLSANCjIuMjcuMA==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

Zml4Jm5ic3A7bWVzb24uYnVpbGQmbmJzcDtpc3N1cyZuYnNwO2luJm5ic3A7Y29tcGlsYXRpb24s
Jm5ic3A7d2hpY2g8YnIgLz5jYXVzZWQmbmJzcDt0aGUmbmJzcDtpbmFiaWxpdHkmbmJzcDt0byZu
YnNwO2NvbXBpbGUmbmJzcDtpbiZuYnNwO3RoZSZuYnNwO2FybTY0Jm5ic3A7ZW52aXJvbm1lbnQu
PGJyIC8+DTxiciAvPkZpeGVzOiZuYnNwOzI5ZTg5Mjg4ZmYxNCZuYnNwOygmcXVvdDtuZXQvenhk
aDombmJzcDthZGQmbmJzcDtkcml2ZXImbmJzcDtza2VsZXRvbiZxdW90Oyk8YnIgLz5DYzombmJz
cDtzdGFibGVAZHBkay5vcmc8YnIgLz4NPGJyIC8+U2lnbmVkLW9mZi1ieTombmJzcDtKdW5sb25n
Jm5ic3A7V2FuZyZuYnNwOyZsdDt3YW5nLmp1bmxvbmcxQHp0ZS5jb20uY24mZ3Q7DTxiciAvPi0t
LTxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgvbWVzb24uYnVpbGQmbmJzcDt8Jm5ic3A7MiZu
YnNwOystPGJyIC8+Jm5ic3A7MSZuYnNwO2ZpbGUmbmJzcDtjaGFuZ2VkLCZuYnNwOzEmbmJzcDtp
bnNlcnRpb24oKyksJm5ic3A7MSZuYnNwO2RlbGV0aW9uKC0pPGJyIC8+DTxiciAvPmRpZmYmbmJz
cDstLWdpdCZuYnNwO2EvZHJpdmVycy9uZXQvenhkaC9tZXNvbi5idWlsZCZuYnNwO2IvZHJpdmVy
cy9uZXQvenhkaC9tZXNvbi5idWlsZDxiciAvPmluZGV4Jm5ic3A7YTQ4YTBkNDNjMi4uZWM3MTQ1
MWE1NSZuYnNwOzEwMDY0NDxiciAvPi0tLSZuYnNwO2EvZHJpdmVycy9uZXQvenhkaC9tZXNvbi5i
dWlsZDxiciAvPisrKyZuYnNwO2IvZHJpdmVycy9uZXQvenhkaC9tZXNvbi5idWlsZDxiciAvPkBA
Jm5ic3A7LTcsNyZuYnNwOys3LDcmbmJzcDtAQCZuYnNwO2lmJm5ic3A7bm90Jm5ic3A7aXNfbGlu
dXg8YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtzdWJkaXJfZG9uZSgpPGJyIC8+
Jm5ic3A7ZW5kaWY8YnIgLz4mbmJzcDsNPGJyIC8+LWlmJm5ic3A7bm90Jm5ic3A7ZHBka19jb25m
LmhhcygmYXBvcztSVEVfQVJDSF9YODZfNjQmYXBvczspJm5ic3A7b3ImbmJzcDtub3QmbmJzcDtk
cGRrX2NvbmYuZ2V0KCZhcG9zO1JURV9BUkNIXzY0JmFwb3M7KTxiciAvPitpZiZuYnNwO2FyY2hf
c3ViZGlyJm5ic3A7IT0mbmJzcDsmYXBvczt4ODYmYXBvczsmbmJzcDthbmQmbmJzcDthcmNoX3N1
YmRpciZuYnNwOyE9Jm5ic3A7JmFwb3M7YXJtJmFwb3M7Jm5ic3A7b3ImbmJzcDtub3QmbmJzcDtk
cGRrX2NvbmYuZ2V0KCZhcG9zO1JURV9BUkNIXzY0JmFwb3M7KTxiciAvPiZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwO2J1aWxkJm5ic3A7PSZuYnNwO2ZhbHNlPGJyIC8+Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7cmVhc29uJm5ic3A7PSZuYnNwOyZhcG9zO29ubHkmbmJzcDtzdXBw
b3J0ZWQmbmJzcDtvbiZuYnNwO3g4Nl82NCZuYnNwO2FuZCZuYnNwO2FhcmNoNjQmYXBvczsNPGJy
IC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7c3ViZGlyX2RvbmUoKTxiciAvPi0tJm5i
c3A7DTxiciAvPjIuMjcuMDxiciAvPg==


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

