Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C059C36010
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Apr 2025 01:40:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 466ED402D8;
	Wed,  9 Apr 2025 03:40:33 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
 by mails.dpdk.org (Postfix) with ESMTP id 61BD440265
 for <dev@dpdk.org>; Wed,  9 Apr 2025 03:40:31 +0200 (CEST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZXQcq5wt4z8R040;
 Wed,  9 Apr 2025 09:40:27 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
 by mse-fl1.zte.com.cn with SMTP id 5391eDWR052992;
 Wed, 9 Apr 2025 09:40:13 +0800 (+08)
 (envelope-from wang.junlong1@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Wed, 9 Apr 2025 09:40:15 +0800
X-Zmail-TransId: 3e8167f5cffa001-84add
From: Junlong Wang <wang.junlong1@zte.com.cn>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, Junlong Wang <wang.junlong1@zte.com.cn>
Subject: [PATCH v1] net/zxdh: fix using static assert in macro definition
Date: Wed,  9 Apr 2025 09:39:55 +0800
Message-ID: <20250409013955.133122-1-wang.junlong1@zte.com.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 5391eDWR052992
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67F5D00B.000/4ZXQcq5wt4z8R040
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

dXNpbmcgc3RhdGljX2Fzc2VydChSVEVfQlVJTERfQlVHX09OKSByZXBsYWNlZCBCVUlMRF9CVUdf
T04uDQoNCkZpeGVzOiA5YzNhMTIzZjllMDggKCJuZXQvenhkaDogb3B0aW1pemUgbXNnIHByb2Nl
c3Npbmcgb3BzIGFuZCBtb2RpZnkgc29tZSBpc3N1ZXMiKQ0KDQpTaWduZWQtb2ZmLWJ5OiBKdW5s
b25nIFdhbmcgPHdhbmcuanVubG9uZzFAenRlLmNvbS5jbj4NCi0tLQ0KIGRyaXZlcnMvbmV0L3p4
ZGgvenhkaF9jb21tb24uaCB8IDkgKystLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3p4ZGgv
enhkaF9jb21tb24uaCBiL2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9jb21tb24uaA0KaW5kZXggYWFm
NGUwYmVkYi4uYzE1MTEwMWJiYyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9j
b21tb24uaA0KKysrIGIvZHJpdmVycy9uZXQvenhkaC96eGRoX2NvbW1vbi5oDQpAQCAtODcsMjAg
Kzg3LDE1IEBAIHp4ZGhfc2V0X3ZhbHVlKHVpbnQzMl90IGZsZF9zeiwgdWludDhfdCAqYWRkciwg
c2l6ZV90IHZhbHVlKSB7DQogI2RlZmluZSBaWERIX0JZVEVfT0ZGKHR5cCwgZmxkKSAoX196eGRo
X2JpdF9vZmYodHlwLCBmbGQpIC8gOCkNCiAjZGVmaW5lIFpYREhfQUREUl9PRih0eXAsIHAsIGZs
ZCkgKCh1aW50OF90ICopKHApICsgWlhESF9CWVRFX09GRih0eXAsIGZsZCkpDQogDQotI2RlZmlu
ZSBCVUlMRF9CVUdfT04oY29uZGl0aW9uKSBkbyB7IFwNCi0JaWYgKGNvbmRpdGlvbikgXA0KLQkJ
X19idWlsdGluX3VucmVhY2hhYmxlKCk7IFwNCi0JfSB3aGlsZSAoMCkNCi0NCiAjZGVmaW5lIFpY
REhfU0VUKHR5cCwgcCwgZmxkLCB2KSBkbyB7IFwNCi0JQlVJTERfQlVHX09OKF9fenhkaF9iaXRf
c3oodHlwLCBmbGQpICUgOCk7IFwNCisJUlRFX0JVSUxEX0JVR19PTihfX3p4ZGhfYml0X3N6KHR5
cCwgZmxkKSAlIDgpOyBcDQogCXVpbnQzMl90IGZsZF9zeiA9IF9fenhkaF9iaXRfc3oodHlwLCBm
bGQpIC8gODsgXA0KIAl1aW50OF90ICphZGRyID0gWlhESF9BRERSX09GKHR5cCwgcCwgZmxkKTsg
XA0KIAl6eGRoX3NldF92YWx1ZShmbGRfc3osIGFkZHIsIHYpOyBcDQogfSB3aGlsZSAoMCkNCiAN
CiAjZGVmaW5lIFpYREhfR0VUKHR5cCwgcCwgZmxkKSAoeyBcDQotCUJVSUxEX0JVR19PTihfX3p4
ZGhfYml0X3N6KHR5cCwgZmxkKSAlIDgpOyBcDQorCVJURV9CVUlMRF9CVUdfT04oX196eGRoX2Jp
dF9zeih0eXAsIGZsZCkgJSA4KTsgXA0KIAl1aW50MzJfdCBmbGRfc3ogPSBfX3p4ZGhfYml0X3N6
KHR5cCwgZmxkKSAvIDg7IFwNCiAJdWludDhfdCAqYWRkciA9IFpYREhfQUREUl9PRih0eXAsIHAs
IGZsZCk7IFwNCiAJenhkaF9nZXRfdmFsdWUoZmxkX3N6LCBhZGRyKTsgXA0KLS0gDQoyLjI3LjA=

--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

dXNpbmcmbmJzcDtzdGF0aWNfYXNzZXJ0KFJURV9CVUlMRF9CVUdfT04pJm5ic3A7cmVwbGFjZWQm
bmJzcDtCVUlMRF9CVUdfT04uPGJyIC8+DTxiciAvPkZpeGVzOiZuYnNwOzljM2ExMjNmOWUwOCZu
YnNwOygmcXVvdDtuZXQvenhkaDombmJzcDtvcHRpbWl6ZSZuYnNwO21zZyZuYnNwO3Byb2Nlc3Np
bmcmbmJzcDtvcHMmbmJzcDthbmQmbmJzcDttb2RpZnkmbmJzcDtzb21lJm5ic3A7aXNzdWVzJnF1
b3Q7KTxiciAvPg08YnIgLz5TaWduZWQtb2ZmLWJ5OiZuYnNwO0p1bmxvbmcmbmJzcDtXYW5nJm5i
c3A7Jmx0O3dhbmcuanVubG9uZzFAenRlLmNvbS5jbiZndDsNPGJyIC8+LS0tPGJyIC8+Jm5ic3A7
ZHJpdmVycy9uZXQvenhkaC96eGRoX2NvbW1vbi5oJm5ic3A7fCZuYnNwOzkmbmJzcDsrKy0tLS0t
LS08YnIgLz4mbmJzcDsxJm5ic3A7ZmlsZSZuYnNwO2NoYW5nZWQsJm5ic3A7MiZuYnNwO2luc2Vy
dGlvbnMoKyksJm5ic3A7NyZuYnNwO2RlbGV0aW9ucygtKTxiciAvPg08YnIgLz5kaWZmJm5ic3A7
LS1naXQmbmJzcDthL2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9jb21tb24uaCZuYnNwO2IvZHJpdmVy
cy9uZXQvenhkaC96eGRoX2NvbW1vbi5oPGJyIC8+aW5kZXgmbmJzcDthYWY0ZTBiZWRiLi5jMTUx
MTAxYmJjJm5ic3A7MTAwNjQ0PGJyIC8+LS0tJm5ic3A7YS9kcml2ZXJzL25ldC96eGRoL3p4ZGhf
Y29tbW9uLmg8YnIgLz4rKysmbmJzcDtiL2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9jb21tb24uaDxi
ciAvPkBAJm5ic3A7LTg3LDIwJm5ic3A7Kzg3LDE1Jm5ic3A7QEAmbmJzcDt6eGRoX3NldF92YWx1
ZSh1aW50MzJfdCZuYnNwO2ZsZF9zeiwmbmJzcDt1aW50OF90Jm5ic3A7KmFkZHIsJm5ic3A7c2l6
ZV90Jm5ic3A7dmFsdWUpJm5ic3A7ezxiciAvPiZuYnNwOyNkZWZpbmUmbmJzcDtaWERIX0JZVEVf
T0ZGKHR5cCwmbmJzcDtmbGQpJm5ic3A7KF9fenhkaF9iaXRfb2ZmKHR5cCwmbmJzcDtmbGQpJm5i
c3A7LyZuYnNwOzgpPGJyIC8+Jm5ic3A7I2RlZmluZSZuYnNwO1pYREhfQUREUl9PRih0eXAsJm5i
c3A7cCwmbmJzcDtmbGQpJm5ic3A7KCh1aW50OF90Jm5ic3A7KikocCkmbmJzcDsrJm5ic3A7WlhE
SF9CWVRFX09GRih0eXAsJm5ic3A7ZmxkKSk8YnIgLz4mbmJzcDsNPGJyIC8+LSNkZWZpbmUmbmJz
cDtCVUlMRF9CVUdfT04oY29uZGl0aW9uKSZuYnNwO2RvJm5ic3A7eyZuYnNwO1w8YnIgLz4tJm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7aWYmbmJzcDsoY29uZGl0aW9uKSZuYnNwO1w8YnIgLz4tJm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7X19idWlsdGluX3Vu
cmVhY2hhYmxlKCk7Jm5ic3A7XDxiciAvPi0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt9Jm5ic3A7
d2hpbGUmbmJzcDsoMCk8YnIgLz4tPGJyIC8+Jm5ic3A7I2RlZmluZSZuYnNwO1pYREhfU0VUKHR5
cCwmbmJzcDtwLCZuYnNwO2ZsZCwmbmJzcDt2KSZuYnNwO2RvJm5ic3A7eyZuYnNwO1w8YnIgLz4t
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7QlVJTERfQlVHX09OKF9fenhkaF9iaXRfc3oodHlwLCZu
YnNwO2ZsZCkmbmJzcDslJm5ic3A7OCk7Jm5ic3A7XDxiciAvPismbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDtSVEVfQlVJTERfQlVHX09OKF9fenhkaF9iaXRfc3oodHlwLCZuYnNwO2ZsZCkmbmJzcDsl
Jm5ic3A7OCk7Jm5ic3A7XDxiciAvPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3VpbnQz
Ml90Jm5ic3A7ZmxkX3N6Jm5ic3A7PSZuYnNwO19fenhkaF9iaXRfc3oodHlwLCZuYnNwO2ZsZCkm
bmJzcDsvJm5ic3A7ODsmbmJzcDtcPGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
dWludDhfdCZuYnNwOyphZGRyJm5ic3A7PSZuYnNwO1pYREhfQUREUl9PRih0eXAsJm5ic3A7cCwm
bmJzcDtmbGQpOyZuYnNwO1w8YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt6eGRo
X3NldF92YWx1ZShmbGRfc3osJm5ic3A7YWRkciwmbmJzcDt2KTsmbmJzcDtcPGJyIC8+Jm5ic3A7
fSZuYnNwO3doaWxlJm5ic3A7KDApPGJyIC8+Jm5ic3A7DTxiciAvPiZuYnNwOyNkZWZpbmUmbmJz
cDtaWERIX0dFVCh0eXAsJm5ic3A7cCwmbmJzcDtmbGQpJm5ic3A7KHsmbmJzcDtcPGJyIC8+LSZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwO0JVSUxEX0JVR19PTihfX3p4ZGhfYml0X3N6KHR5cCwmbmJz
cDtmbGQpJm5ic3A7JSZuYnNwOzgpOyZuYnNwO1w8YnIgLz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7UlRFX0JVSUxEX0JVR19PTihfX3p4ZGhfYml0X3N6KHR5cCwmbmJzcDtmbGQpJm5ic3A7JSZu
YnNwOzgpOyZuYnNwO1w8YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt1aW50MzJf
dCZuYnNwO2ZsZF9zeiZuYnNwOz0mbmJzcDtfX3p4ZGhfYml0X3N6KHR5cCwmbmJzcDtmbGQpJm5i
c3A7LyZuYnNwOzg7Jm5ic3A7XDxiciAvPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3Vp
bnQ4X3QmbmJzcDsqYWRkciZuYnNwOz0mbmJzcDtaWERIX0FERFJfT0YodHlwLCZuYnNwO3AsJm5i
c3A7ZmxkKTsmbmJzcDtcPGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7enhkaF9n
ZXRfdmFsdWUoZmxkX3N6LCZuYnNwO2FkZHIpOyZuYnNwO1w8YnIgLz4tLSZuYnNwOw08YnIgLz4y
LjI3LjA8YnIgLz4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

