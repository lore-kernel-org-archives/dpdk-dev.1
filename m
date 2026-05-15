Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB44CD4851
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 May 2026 08:43:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 631A740269;
	Fri, 15 May 2026 10:43:57 +0200 (CEST)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
 by mails.dpdk.org (Postfix) with ESMTP id F08A0400EF
 for <dev@dpdk.org>; Fri, 15 May 2026 10:43:54 +0200 (CEST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4gH12G1JPjz4xPSP
 for <dev@dpdk.org>; Fri, 15 May 2026 16:43:50 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
 by mse-fl1.zte.com.cn with SMTP id 64F8heWJ018170
 for <dev@dpdk.org>; Fri, 15 May 2026 16:43:40 +0800 (+08)
 (envelope-from han.chengfei@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Fri, 15 May 2026 16:43:43 +0800
X-Zmail-TransId: 3e816a06dcbe002-650c2
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: han.chengfei@zte.com.cn
From: Chengfei Han <han.chengfei@zte.com.cn>
To: dev@dpdk.org
Cc: ran.ming@zte.com.cn, Chengfei Han <han.chengfei@zte.com.cn>
Subject: [PATCH 1/1] crypto/zsda: Update product name and maintainer
Date: Fri, 15 May 2026 16:12:12 +0800
Message-ID: <20260515081212.3565572-2-han.chengfei@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515081212.3565572-1-han.chengfei@zte.com.cn>
References: <20260515081212.3565572-1-han.chengfei@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 64F8heWJ018170
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: han.chengfei@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Fri, 15 May 2026 16:43:50 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A06DCC6.000/4gH12G1JPjz4xPSP
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

Q29ycmVjdCBwcm9kdWN0IG5hbWUgZnJvbSAnMWNmMicgdG8gJ05lbyBYNTEwL1g1MTInIGluIFBN
RCBkb2N1bWVudGF0aW9uLg0KVXBkYXRlIG1haW50YWluZXIgZm9yIFpURSBTdG9yYWdlIERhdGEg
QWNjZWxlcmF0b3IgKFpTREEpDQoNClNpZ25lZC1vZmYtYnk6IENoZW5nZmVpIEhhbiA8aGFuLmNo
ZW5nZmVpQHp0ZS5jb20uY24+DQotLS0NCiBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAg
ICB8IDMgKystDQogZG9jL2d1aWRlcy9jb21wcmVzc2RldnMvenNkYS5yc3QgfCAzICstLQ0KIGRv
Yy9ndWlkZXMvY3J5cHRvZGV2cy96c2RhLnJzdCAgIHwgMyArLS0NCiAzIGZpbGVzIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL01BSU5UQUlO
RVJTIGIvTUFJTlRBSU5FUlMNCmluZGV4IDBmNTUzOWY4NTEuLjdmMzAyMDViMjQgMTAwNjQ0DQot
LS0gYS9NQUlOVEFJTkVSUw0KKysrIGIvTUFJTlRBSU5FUlMNCkBAIC0xMzUyLDcgKzEzNTIsOCBA
QCBGOiBkb2MvZ3VpZGVzL2NvbXByZXNzZGV2cy96bGliLnJzdA0KIEY6IGRvYy9ndWlkZXMvY29t
cHJlc3NkZXZzL2ZlYXR1cmVzL3psaWIuaW5pDQogDQogWlRFIFN0b3JhZ2UgRGF0YSBBY2NlbGVy
YXRvciAoWlNEQSkNCi1NOiBIYW54aWFvIExpIDxsaS5oYW54aWFvQHp0ZS5jb20uY24+DQorTTog
Q2hlbmdmZWkgSGFuIDxoYW4uY2hlbmdmZWlAenRlLmNvbS5jbj4NCitNOiBNaW5nIFJhbiA8cmFu
Lm1pbmdAenRlLmNvbS5jbj4NCiBGOiBkcml2ZXJzL2NvbW1vbi96c2RhLw0KIEY6IGRyaXZlcnMv
Y29tcHJlc3MvenNkYS8NCiBGOiBkb2MvZ3VpZGVzL2NvbXByZXNzZGV2cy96c2RhLnJzdA0KZGlm
ZiAtLWdpdCBhL2RvYy9ndWlkZXMvY29tcHJlc3NkZXZzL3pzZGEucnN0IGIvZG9jL2d1aWRlcy9j
b21wcmVzc2RldnMvenNkYS5yc3QNCmluZGV4IDI1Yjc4ODQ1MzUuLjViOGQ0ODQ2YTAgMTAwNjQ0
DQotLS0gYS9kb2MvZ3VpZGVzL2NvbXByZXNzZGV2cy96c2RhLnJzdA0KKysrIGIvZG9jL2d1aWRl
cy9jb21wcmVzc2RldnMvenNkYS5yc3QNCkBAIC03LDggKzcsNyBAQCBaVEUgU3RvcmFnZSBEYXRh
IEFjY2VsZXJhdG9yIChaU0RBKSBQb2xsIE1vZGUgRHJpdmVyDQogVGhlIFpTREEgY29tcHJlc3Np
b24gUE1EIHByb3ZpZGVzIHBvbGwgbW9kZSBjb21wcmVzc2lvbiAmIGRlY29tcHJlc3Npb24gZHJp
dmVyDQogc3VwcG9ydCBmb3IgdGhlIGZvbGxvd2luZyBoYXJkd2FyZSBhY2NlbGVyYXRvciBkZXZp
Y2VzOg0KIA0KLSogWlRFIFByb2Nlc3NpbmcgYWNjZWxlcmF0b3JzIDFjZjINCi0NCistIE5lbyBY
NTEwL1g1MTINCiANCiBGZWF0dXJlcw0KIC0tLS0tLS0tDQpkaWZmIC0tZ2l0IGEvZG9jL2d1aWRl
cy9jcnlwdG9kZXZzL3pzZGEucnN0IGIvZG9jL2d1aWRlcy9jcnlwdG9kZXZzL3pzZGEucnN0DQpp
bmRleCBiMDI0ZjUzN2MxLi44ODg1NjYzZTllIDEwMDY0NA0KLS0tIGEvZG9jL2d1aWRlcy9jcnlw
dG9kZXZzL3pzZGEucnN0DQorKysgYi9kb2MvZ3VpZGVzL2NyeXB0b2RldnMvenNkYS5yc3QNCkBA
IC03LDggKzcsNyBAQCBaVEUgU3RvcmFnZSBEYXRhIEFjY2VsZXJhdG9yIChaU0RBKSBQb2xsIE1v
ZGUgRHJpdmVyDQogVGhlIFpTREEgY3J5cHRvIFBNRCBwcm92aWRlcyBwb2xsIG1vZGUgQ2lwaGVy
IGFuZCBIYXNoIGRyaXZlcg0KIHN1cHBvcnQgZm9yIHRoZSBmb2xsb3dpbmcgaGFyZHdhcmUgYWNj
ZWxlcmF0b3IgZGV2aWNlczoNCiANCi0qIFpURSBQcm9jZXNzaW5nIGFjY2VsZXJhdG9ycyAxY2Yy
DQotDQorLSBOZW8gWDUxMC9YNTEyDQogDQogRmVhdHVyZXMNCiAtLS0tLS0tLQ0KLS0gDQoyLjI3
LjA=


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

Q29ycmVjdCZuYnNwO3Byb2R1Y3QmbmJzcDtuYW1lJm5ic3A7ZnJvbSZuYnNwOyZhcG9zOzFjZjIm
YXBvczsmbmJzcDt0byZuYnNwOyZhcG9zO05lbyZuYnNwO1g1MTAvWDUxMiZhcG9zOyZuYnNwO2lu
Jm5ic3A7UE1EJm5ic3A7ZG9jdW1lbnRhdGlvbi48YnIgLz5VcGRhdGUmbmJzcDttYWludGFpbmVy
Jm5ic3A7Zm9yJm5ic3A7WlRFJm5ic3A7U3RvcmFnZSZuYnNwO0RhdGEmbmJzcDtBY2NlbGVyYXRv
ciZuYnNwOyhaU0RBKTxiciAvPg08YnIgLz5TaWduZWQtb2ZmLWJ5OiZuYnNwO0NoZW5nZmVpJm5i
c3A7SGFuJm5ic3A7Jmx0O2hhbi5jaGVuZ2ZlaUB6dGUuY29tLmNuJmd0Ow08YnIgLz4tLS08YnIg
Lz4mbmJzcDtNQUlOVEFJTkVSUyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wmbmJzcDszJm5ic3A7KystPGJy
IC8+Jm5ic3A7ZG9jL2d1aWRlcy9jb21wcmVzc2RldnMvenNkYS5yc3QmbmJzcDt8Jm5ic3A7MyZu
YnNwOystLTxiciAvPiZuYnNwO2RvYy9ndWlkZXMvY3J5cHRvZGV2cy96c2RhLnJzdCZuYnNwOyZu
YnNwOyZuYnNwO3wmbmJzcDszJm5ic3A7Ky0tPGJyIC8+Jm5ic3A7MyZuYnNwO2ZpbGVzJm5ic3A7
Y2hhbmdlZCwmbmJzcDs0Jm5ic3A7aW5zZXJ0aW9ucygrKSwmbmJzcDs1Jm5ic3A7ZGVsZXRpb25z
KC0pPGJyIC8+DTxiciAvPmRpZmYmbmJzcDstLWdpdCZuYnNwO2EvTUFJTlRBSU5FUlMmbmJzcDti
L01BSU5UQUlORVJTPGJyIC8+aW5kZXgmbmJzcDswZjU1MzlmODUxLi43ZjMwMjA1YjI0Jm5ic3A7
MTAwNjQ0PGJyIC8+LS0tJm5ic3A7YS9NQUlOVEFJTkVSUzxiciAvPisrKyZuYnNwO2IvTUFJTlRB
SU5FUlM8YnIgLz5AQCZuYnNwOy0xMzUyLDcmbmJzcDsrMTM1Miw4Jm5ic3A7QEAmbmJzcDtGOiZu
YnNwO2RvYy9ndWlkZXMvY29tcHJlc3NkZXZzL3psaWIucnN0PGJyIC8+Jm5ic3A7RjombmJzcDtk
b2MvZ3VpZGVzL2NvbXByZXNzZGV2cy9mZWF0dXJlcy96bGliLmluaTxiciAvPiZuYnNwOw08YnIg
Lz4mbmJzcDtaVEUmbmJzcDtTdG9yYWdlJm5ic3A7RGF0YSZuYnNwO0FjY2VsZXJhdG9yJm5ic3A7
KFpTREEpPGJyIC8+LU06Jm5ic3A7SGFueGlhbyZuYnNwO0xpJm5ic3A7Jmx0O2xpLmhhbnhpYW9A
enRlLmNvbS5jbiZndDsNPGJyIC8+K006Jm5ic3A7Q2hlbmdmZWkmbmJzcDtIYW4mbmJzcDsmbHQ7
aGFuLmNoZW5nZmVpQHp0ZS5jb20uY24mZ3Q7DTxiciAvPitNOiZuYnNwO01pbmcmbmJzcDtSYW4m
bmJzcDsmbHQ7cmFuLm1pbmdAenRlLmNvbS5jbiZndDsNPGJyIC8+Jm5ic3A7RjombmJzcDtkcml2
ZXJzL2NvbW1vbi96c2RhLzxiciAvPiZuYnNwO0Y6Jm5ic3A7ZHJpdmVycy9jb21wcmVzcy96c2Rh
LzxiciAvPiZuYnNwO0Y6Jm5ic3A7ZG9jL2d1aWRlcy9jb21wcmVzc2RldnMvenNkYS5yc3Q8YnIg
Lz5kaWZmJm5ic3A7LS1naXQmbmJzcDthL2RvYy9ndWlkZXMvY29tcHJlc3NkZXZzL3pzZGEucnN0
Jm5ic3A7Yi9kb2MvZ3VpZGVzL2NvbXByZXNzZGV2cy96c2RhLnJzdDxiciAvPmluZGV4Jm5ic3A7
MjViNzg4NDUzNS4uNWI4ZDQ4NDZhMCZuYnNwOzEwMDY0NDxiciAvPi0tLSZuYnNwO2EvZG9jL2d1
aWRlcy9jb21wcmVzc2RldnMvenNkYS5yc3Q8YnIgLz4rKysmbmJzcDtiL2RvYy9ndWlkZXMvY29t
cHJlc3NkZXZzL3pzZGEucnN0PGJyIC8+QEAmbmJzcDstNyw4Jm5ic3A7KzcsNyZuYnNwO0BAJm5i
c3A7WlRFJm5ic3A7U3RvcmFnZSZuYnNwO0RhdGEmbmJzcDtBY2NlbGVyYXRvciZuYnNwOyhaU0RB
KSZuYnNwO1BvbGwmbmJzcDtNb2RlJm5ic3A7RHJpdmVyPGJyIC8+Jm5ic3A7VGhlJm5ic3A7WlNE
QSZuYnNwO2NvbXByZXNzaW9uJm5ic3A7UE1EJm5ic3A7cHJvdmlkZXMmbmJzcDtwb2xsJm5ic3A7
bW9kZSZuYnNwO2NvbXByZXNzaW9uJm5ic3A7JmFtcDsmbmJzcDtkZWNvbXByZXNzaW9uJm5ic3A7
ZHJpdmVyPGJyIC8+Jm5ic3A7c3VwcG9ydCZuYnNwO2ZvciZuYnNwO3RoZSZuYnNwO2ZvbGxvd2lu
ZyZuYnNwO2hhcmR3YXJlJm5ic3A7YWNjZWxlcmF0b3ImbmJzcDtkZXZpY2VzOjxiciAvPiZuYnNw
Ow08YnIgLz4tKiZuYnNwO1pURSZuYnNwO1Byb2Nlc3NpbmcmbmJzcDthY2NlbGVyYXRvcnMmbmJz
cDsxY2YyPGJyIC8+LTxiciAvPistJm5ic3A7TmVvJm5ic3A7WDUxMC9YNTEyPGJyIC8+Jm5ic3A7
DTxiciAvPiZuYnNwO0ZlYXR1cmVzPGJyIC8+Jm5ic3A7LS0tLS0tLS08YnIgLz5kaWZmJm5ic3A7
LS1naXQmbmJzcDthL2RvYy9ndWlkZXMvY3J5cHRvZGV2cy96c2RhLnJzdCZuYnNwO2IvZG9jL2d1
aWRlcy9jcnlwdG9kZXZzL3pzZGEucnN0PGJyIC8+aW5kZXgmbmJzcDtiMDI0ZjUzN2MxLi44ODg1
NjYzZTllJm5ic3A7MTAwNjQ0PGJyIC8+LS0tJm5ic3A7YS9kb2MvZ3VpZGVzL2NyeXB0b2RldnMv
enNkYS5yc3Q8YnIgLz4rKysmbmJzcDtiL2RvYy9ndWlkZXMvY3J5cHRvZGV2cy96c2RhLnJzdDxi
ciAvPkBAJm5ic3A7LTcsOCZuYnNwOys3LDcmbmJzcDtAQCZuYnNwO1pURSZuYnNwO1N0b3JhZ2Um
bmJzcDtEYXRhJm5ic3A7QWNjZWxlcmF0b3ImbmJzcDsoWlNEQSkmbmJzcDtQb2xsJm5ic3A7TW9k
ZSZuYnNwO0RyaXZlcjxiciAvPiZuYnNwO1RoZSZuYnNwO1pTREEmbmJzcDtjcnlwdG8mbmJzcDtQ
TUQmbmJzcDtwcm92aWRlcyZuYnNwO3BvbGwmbmJzcDttb2RlJm5ic3A7Q2lwaGVyJm5ic3A7YW5k
Jm5ic3A7SGFzaCZuYnNwO2RyaXZlcjxiciAvPiZuYnNwO3N1cHBvcnQmbmJzcDtmb3ImbmJzcDt0
aGUmbmJzcDtmb2xsb3dpbmcmbmJzcDtoYXJkd2FyZSZuYnNwO2FjY2VsZXJhdG9yJm5ic3A7ZGV2
aWNlczo8YnIgLz4mbmJzcDsNPGJyIC8+LSombmJzcDtaVEUmbmJzcDtQcm9jZXNzaW5nJm5ic3A7
YWNjZWxlcmF0b3JzJm5ic3A7MWNmMjxiciAvPi08YnIgLz4rLSZuYnNwO05lbyZuYnNwO1g1MTAv
WDUxMjxiciAvPiZuYnNwOw08YnIgLz4mbmJzcDtGZWF0dXJlczxiciAvPiZuYnNwOy0tLS0tLS0t
PGJyIC8+LS0mbmJzcDsNPGJyIC8+Mi4yNy4wPGJyIC8+


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

