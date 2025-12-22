Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11AED711D5
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Dec 2025 10:46:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3EA040658;
	Mon, 22 Dec 2025 11:46:28 +0100 (CET)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
 by mails.dpdk.org (Postfix) with ESMTP id 1742E40654
 for <dev@dpdk.org>; Mon, 22 Dec 2025 11:46:27 +0100 (CET)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4dZZZB1RnHz7VGTN;
 Mon, 22 Dec 2025 18:46:26 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
 by mse-fl1.zte.com.cn with SMTP id 5BMAk6QK085251;
 Mon, 22 Dec 2025 18:46:06 +0800 (+08)
 (envelope-from zhang.tianhao2@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Mon, 22 Dec 2025 18:46:09 +0800
X-Zmail-TransId: 3e8169492171000-2341f
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: zhang.tianhao2@zte.com.cn
From: Tianhao Zhang <zhang.tianhao2@zte.com.cn>
To: stephen@networkplumber.org, wang.junlong1@zte.com.cn,
 yang.yonggang@zte.com.cn
Cc: dev@dpdk.org, Tianhao Zhang <zhang.tianhao2@zte.com.cn>
Subject: [PATCH v1 2/2] net/zxdh: delete np soft resource uninstallation
Date: Mon, 22 Dec 2025 18:25:35 +0800
Message-ID: <20251222102535.401064-3-zhang.tianhao2@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222102535.401064-1-zhang.tianhao2@zte.com.cn>
References: <20251209021609.3911854-1-zhang.tianhao2@zte.com.cn>
 <20251222102535.401064-1-zhang.tianhao2@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 5BMAk6QK085251
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: zhang.tianhao2@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Mon, 22 Dec 2025 18:46:26 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69492182.000/4dZZZB1RnHz7VGTN
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

RGVsZXRlIG5wIHNvZnQgcmVzb3VyY2UgdW5pbnN0YWxsYXRpb24gZnJvbSBOUCBvbmxpbmUgdW5p
bml0IHByb2Nlc3MuDQoNClNpZ25lZC1vZmYtYnk6IFRpYW5oYW8gWmhhbmcgPHpoYW5nLnRpYW5o
YW8yQHp0ZS5jb20uY24+DQotLS0NCiBkcml2ZXJzL25ldC96eGRoL3p4ZGhfbnAuYyB8IDQgLS0t
LQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvenhkaC96eGRoX25wLmMgYi9kcml2ZXJzL25ldC96eGRoL3p4ZGhfbnAuYw0KaW5kZXgg
NGUyNjM3ZTFiNi4uM2JiNzY1ZTA1ZCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3p4ZGgvenhk
aF9ucC5jDQorKysgYi9kcml2ZXJzL25ldC96eGRoL3p4ZGhfbnAuYw0KQEAgLTQyNDMsMTAgKzQy
NDMsNiBAQCB6eGRoX25wX29ubGluZV91bmluaXQodWludDMyX3QgZGV2X2lkLA0KIAlpZiAocmMg
IT0gMCkNCiAJCVBNRF9EUlZfTE9HKEVSUiwgImR0YiByZWxlYXNlIHBvcnQgbmFtZSAlcyBxdWV1
ZSBpZCAldSIsIHBvcnRfbmFtZSwgcXVldWVfaWQpOw0KIA0KLQlyYyA9IHp4ZGhfbnBfc29mdF9y
ZXNfdW5pbnN0YWxsKGRldl9pZCk7DQotCWlmIChyYyAhPSAwKQ0KLQkJUE1EX0RSVl9MT0coRVJS
LCAienhkaF9ucF9zb2Z0X3Jlc191bmluc3RhbGwgZmFpbGVkIik7DQotDQogCXJldHVybiAwOw0K
IH0NCiANCi0tIA0KMi4yNy4w


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

RGVsZXRlJm5ic3A7bnAmbmJzcDtzb2Z0Jm5ic3A7cmVzb3VyY2UmbmJzcDt1bmluc3RhbGxhdGlv
biZuYnNwO2Zyb20mbmJzcDtOUCZuYnNwO29ubGluZSZuYnNwO3VuaW5pdCZuYnNwO3Byb2Nlc3Mu
PGJyIC8+DTxiciAvPlNpZ25lZC1vZmYtYnk6Jm5ic3A7VGlhbmhhbyZuYnNwO1poYW5nJm5ic3A7
Jmx0O3poYW5nLnRpYW5oYW8yQHp0ZS5jb20uY24mZ3Q7DTxiciAvPi0tLTxiciAvPiZuYnNwO2Ry
aXZlcnMvbmV0L3p4ZGgvenhkaF9ucC5jJm5ic3A7fCZuYnNwOzQmbmJzcDstLS0tPGJyIC8+Jm5i
c3A7MSZuYnNwO2ZpbGUmbmJzcDtjaGFuZ2VkLCZuYnNwOzQmbmJzcDtkZWxldGlvbnMoLSk8YnIg
Lz4NPGJyIC8+ZGlmZiZuYnNwOy0tZ2l0Jm5ic3A7YS9kcml2ZXJzL25ldC96eGRoL3p4ZGhfbnAu
YyZuYnNwO2IvZHJpdmVycy9uZXQvenhkaC96eGRoX25wLmM8YnIgLz5pbmRleCZuYnNwOzRlMjYz
N2UxYjYuLjNiYjc2NWUwNWQmbmJzcDsxMDA2NDQ8YnIgLz4tLS0mbmJzcDthL2RyaXZlcnMvbmV0
L3p4ZGgvenhkaF9ucC5jPGJyIC8+KysrJm5ic3A7Yi9kcml2ZXJzL25ldC96eGRoL3p4ZGhfbnAu
YzxiciAvPkBAJm5ic3A7LTQyNDMsMTAmbmJzcDsrNDI0Myw2Jm5ic3A7QEAmbmJzcDt6eGRoX25w
X29ubGluZV91bmluaXQodWludDMyX3QmbmJzcDtkZXZfaWQsPGJyIC8+Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7aWYmbmJzcDsocmMmbmJzcDshPSZuYnNwOzApPGJyIC8+Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7UE1EX0RSVl9MT0co
RVJSLCZuYnNwOyZxdW90O2R0YiZuYnNwO3JlbGVhc2UmbmJzcDtwb3J0Jm5ic3A7bmFtZSZuYnNw
OyVzJm5ic3A7cXVldWUmbmJzcDtpZCZuYnNwOyV1JnF1b3Q7LCZuYnNwO3BvcnRfbmFtZSwmbmJz
cDtxdWV1ZV9pZCk7PGJyIC8+Jm5ic3A7DTxiciAvPi0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDty
YyZuYnNwOz0mbmJzcDt6eGRoX25wX3NvZnRfcmVzX3VuaW5zdGFsbChkZXZfaWQpOzxiciAvPi0m
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtpZiZuYnNwOyhyYyZuYnNwOyE9Jm5ic3A7MCk8YnIgLz4t
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7UE1EX0RSVl9M
T0coRVJSLCZuYnNwOyZxdW90O3p4ZGhfbnBfc29mdF9yZXNfdW5pbnN0YWxsJm5ic3A7ZmFpbGVk
JnF1b3Q7KTs8YnIgLz4tPGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7cmV0dXJu
Jm5ic3A7MDs8YnIgLz4mbmJzcDt9PGJyIC8+Jm5ic3A7DTxiciAvPi0tJm5ic3A7DTxiciAvPjIu
MjcuMDxiciAvPg==


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

