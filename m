Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C19E8305C
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 07:42:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 734814066C;
	Tue,  3 Feb 2026 08:41:54 +0100 (CET)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
 by mails.dpdk.org (Postfix) with ESMTP id 863E540616
 for <dev@dpdk.org>; Tue,  3 Feb 2026 08:41:52 +0100 (CET)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4f4wRJ1rnKz4xPSn;
 Tue, 03 Feb 2026 15:41:48 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
 by mse-fl2.zte.com.cn with SMTP id 6137fYc4032676;
 Tue, 3 Feb 2026 15:41:34 +0800 (+08)
 (envelope-from zhang.tianhao2@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Tue, 3 Feb 2026 15:41:36 +0800
X-Zmail-TransId: 3e816981a6b0001-42e84
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: zhang.tianhao2@zte.com.cn
From: Tianhao Zhang <zhang.tianhao2@zte.com.cn>
To: stephen@networkplumber.org, wang.junlong1@zte.com.cn,
 yang.yonggang@zte.com.cn
Cc: dev@dpdk.org, Tianhao Zhang <zhang.tianhao2@zte.com.cn>
Subject: [PATCH v3 2/2] net/zxdh: optimize the procedure for NP online uninit
Date: Tue,  3 Feb 2026 15:17:29 +0800
Message-ID: <20260203071732.2601630-3-zhang.tianhao2@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203071732.2601630-1-zhang.tianhao2@zte.com.cn>
References: <20251230081127.813605-2-zhang.tianhao2@zte.com.cn>
 <20260203071732.2601630-1-zhang.tianhao2@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn 6137fYc4032676
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: zhang.tianhao2@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Tue, 03 Feb 2026 15:41:48 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6981A6BC.000/4f4wRJ1rnKz4xPSn
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

UmVtb3ZlIHRoZSBOUCBzb2Z0d2FyZSByZXNvdXJjZSB1bmluc3RhbGxhdGlvbiBwcm9jZWR1cmUg
ZnJvbSB0aGUgTlANCm9ubGluZSB1bmluaXQgcHJvY2Vzcy4gVGhlIE5QIHNvZnR3YXJlIHJlc291
cmNlIHVuaW5zdGFsbGF0aW9uIHNob3VsZCBiZQ0KY2FsbGVkIHNlcGFyYXRlbHkgd2l0aGluIE5Q
IHVuaW5pdCB0byBhdm9pZCBkdXBsaWNhdGUgcmVzb3VyY2UNCnJlbGVhc2UuDQoNClNpZ25lZC1v
ZmYtYnk6IFRpYW5oYW8gWmhhbmcgPHpoYW5nLnRpYW5oYW8yQHp0ZS5jb20uY24+DQotLS0NCiBk
cml2ZXJzL25ldC96eGRoL3p4ZGhfbnAuYyB8IDQgLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGRl
bGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvenhkaC96eGRoX25wLmMgYi9k
cml2ZXJzL25ldC96eGRoL3p4ZGhfbnAuYw0KaW5kZXggNGNiOWRkZTk4Mi4uMzBjNDY4YzIxOCAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9ucC5jDQorKysgYi9kcml2ZXJzL25l
dC96eGRoL3p4ZGhfbnAuYw0KQEAgLTQyNDIsMTAgKzQyNDIsNiBAQCB6eGRoX25wX29ubGluZV91
bmluaXQodWludDMyX3QgZGV2X2lkLA0KIAlpZiAocmMgIT0gMCkNCiAJCVBNRF9EUlZfTE9HKEVS
UiwgImR0YiByZWxlYXNlIHBvcnQgbmFtZSAlcyBxdWV1ZSBpZCAldSIsIHBvcnRfbmFtZSwgcXVl
dWVfaWQpOw0KIA0KLQlyYyA9IHp4ZGhfbnBfc29mdF9yZXNfdW5pbnN0YWxsKGRldl9pZCk7DQot
CWlmIChyYyAhPSAwKQ0KLQkJUE1EX0RSVl9MT0coRVJSLCAienhkaF9ucF9zb2Z0X3Jlc191bmlu
c3RhbGwgZmFpbGVkIik7DQotDQogCXJldHVybiAwOw0KIH0NCiANCi0tIA0KMi4yNy4w


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

UmVtb3ZlJm5ic3A7dGhlJm5ic3A7TlAmbmJzcDtzb2Z0d2FyZSZuYnNwO3Jlc291cmNlJm5ic3A7
dW5pbnN0YWxsYXRpb24mbmJzcDtwcm9jZWR1cmUmbmJzcDtmcm9tJm5ic3A7dGhlJm5ic3A7TlA8
YnIgLz5vbmxpbmUmbmJzcDt1bmluaXQmbmJzcDtwcm9jZXNzLiZuYnNwO1RoZSZuYnNwO05QJm5i
c3A7c29mdHdhcmUmbmJzcDtyZXNvdXJjZSZuYnNwO3VuaW5zdGFsbGF0aW9uJm5ic3A7c2hvdWxk
Jm5ic3A7YmU8YnIgLz5jYWxsZWQmbmJzcDtzZXBhcmF0ZWx5Jm5ic3A7d2l0aGluJm5ic3A7TlAm
bmJzcDt1bmluaXQmbmJzcDt0byZuYnNwO2F2b2lkJm5ic3A7ZHVwbGljYXRlJm5ic3A7cmVzb3Vy
Y2U8YnIgLz5yZWxlYXNlLjxiciAvPg08YnIgLz5TaWduZWQtb2ZmLWJ5OiZuYnNwO1RpYW5oYW8m
bmJzcDtaaGFuZyZuYnNwOyZsdDt6aGFuZy50aWFuaGFvMkB6dGUuY29tLmNuJmd0Ow08YnIgLz4t
LS08YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfbnAuYyZuYnNwO3wmbmJzcDs0Jm5i
c3A7LS0tLTxiciAvPiZuYnNwOzEmbmJzcDtmaWxlJm5ic3A7Y2hhbmdlZCwmbmJzcDs0Jm5ic3A7
ZGVsZXRpb25zKC0pPGJyIC8+DTxiciAvPmRpZmYmbmJzcDstLWdpdCZuYnNwO2EvZHJpdmVycy9u
ZXQvenhkaC96eGRoX25wLmMmbmJzcDtiL2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9ucC5jPGJyIC8+
aW5kZXgmbmJzcDs0Y2I5ZGRlOTgyLi4zMGM0NjhjMjE4Jm5ic3A7MTAwNjQ0PGJyIC8+LS0tJm5i
c3A7YS9kcml2ZXJzL25ldC96eGRoL3p4ZGhfbnAuYzxiciAvPisrKyZuYnNwO2IvZHJpdmVycy9u
ZXQvenhkaC96eGRoX25wLmM8YnIgLz5AQCZuYnNwOy00MjQyLDEwJm5ic3A7KzQyNDIsNiZuYnNw
O0BAJm5ic3A7enhkaF9ucF9vbmxpbmVfdW5pbml0KHVpbnQzMl90Jm5ic3A7ZGV2X2lkLDxiciAv
PiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO2lmJm5ic3A7KHJjJm5ic3A7IT0mbmJzcDsw
KTxiciAvPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwO1BNRF9EUlZfTE9HKEVSUiwmbmJzcDsmcXVvdDtkdGImbmJzcDtyZWxlYXNlJm5ic3A7cG9y
dCZuYnNwO25hbWUmbmJzcDslcyZuYnNwO3F1ZXVlJm5ic3A7aWQmbmJzcDsldSZxdW90OywmbmJz
cDtwb3J0X25hbWUsJm5ic3A7cXVldWVfaWQpOzxiciAvPiZuYnNwOw08YnIgLz4tJm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7cmMmbmJzcDs9Jm5ic3A7enhkaF9ucF9zb2Z0X3Jlc191bmluc3RhbGwo
ZGV2X2lkKTs8YnIgLz4tJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7aWYmbmJzcDsocmMmbmJzcDsh
PSZuYnNwOzApPGJyIC8+LSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwO1BNRF9EUlZfTE9HKEVSUiwmbmJzcDsmcXVvdDt6eGRoX25wX3NvZnRfcmVzX3VuaW5z
dGFsbCZuYnNwO2ZhaWxlZCZxdW90Oyk7PGJyIC8+LTxiciAvPiZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwO3JldHVybiZuYnNwOzA7PGJyIC8+Jm5ic3A7fTxiciAvPiZuYnNwOw08YnIgLz4t
LSZuYnNwOw08YnIgLz4yLjI3LjA8YnIgLz4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

