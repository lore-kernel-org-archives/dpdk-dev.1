Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B3DCD98EE
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 09:02:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0954F40A73;
	Wed, 17 Jun 2026 11:02:47 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
 by mails.dpdk.org (Postfix) with ESMTP id D8CB64027A;
 Wed, 17 Jun 2026 11:02:42 +0200 (CEST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ggHtn2XTBz8XrrZ;
 Wed, 17 Jun 2026 17:02:41 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
 by mse-fl2.zte.com.cn with SMTP id 65H92RU8019065;
 Wed, 17 Jun 2026 17:02:27 +0800 (+08)
 (envelope-from wang.junlong1@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Wed, 17 Jun 2026 17:02:30 +0800
X-Zmail-TransId: 3e816a3262a5004-fe0f0
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: wang.junlong1@zte.com.cn
From: Junlong Wang <wang.junlong1@zte.com.cn>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, Junlong Wang <wang.junlong1@zte.com.cn>, stable@dpdk.org
Subject: [PATCH v6 1/4] net/zxdh: fix queue enable intr issues
Date: Wed, 17 Jun 2026 16:28:24 +0800
Message-ID: <20260617082828.1058127-2-wang.junlong1@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617082828.1058127-1-wang.junlong1@zte.com.cn>
References: <20260606063226.491848-1-wang.junlong1@zte.com.cn>
 <20260617082828.1058127-1-wang.junlong1@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn 65H92RU8019065
X-TLS: YES
X-ENVELOPE-SENDER: wang.junlong1@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 17 Jun 2026 17:02:41 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A3262B1.000/4ggHtn2XTBz8XrrZ
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

Rml4IGluY29ycmVjdCBjb25kaXRpb24gY2hlY2sgaW4genhkaF9xdWV1ZV9lbmFibGVfaW50ci4N
CkNoYW5nZSAiPT0iIHRvICIhPSIsIGNvbnNpc3RlbnQgd2l0aCB6eGRoX3F1ZXVlX2Rpc2FibGVf
aW50ciBsb2dpYywNCnRvIHByb3Blcmx5IGVuYWJsZSBpbnRlcnJ1cHRzIHdoZW4gZXZlbnRfZmxh
Z3Nfc2hhZG93IGlzIG5vdA0KYWxyZWFkeSBzZXQgdG8gRU5BQkxFIHN0YXRlLg0KDQpGaXhlczog
NzY3N2YzODcxZWYzICgibmV0L3p4ZGg6IHNldHVwIFJ4L1R4IHF1ZXVlcyBhbmQgaW50ZXJydXB0
IikNCkNjOiBzdGFibGVAZHBkay5vcmcNCg0KU2lnbmVkLW9mZi1ieTogSnVubG9uZyBXYW5nIDx3
YW5nLmp1bmxvbmcxQHp0ZS5jb20uY24+DQotLS0NCiBkcml2ZXJzL25ldC96eGRoL3p4ZGhfcXVl
dWUuaCB8IDQgKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC96eGRoL3p4ZGhfcXVldWUuaCBiL2Ry
aXZlcnMvbmV0L3p4ZGgvenhkaF9xdWV1ZS5oDQppbmRleCAxYTBjOGEwZDkwLi43MTFlYTI5MWQw
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvenhkaC96eGRoX3F1ZXVlLmgNCisrKyBiL2RyaXZl
cnMvbmV0L3p4ZGgvenhkaF9xdWV1ZS5oDQpAQCAtMzQwLDggKzM0MCw4IEBAIHp4ZGhfcXVldWVf
ZGlzYWJsZV9pbnRyKHN0cnVjdCB6eGRoX3ZpcnRxdWV1ZSAqdnEpDQogc3RhdGljIGlubGluZSB2
b2lkDQogenhkaF9xdWV1ZV9lbmFibGVfaW50cihzdHJ1Y3QgenhkaF92aXJ0cXVldWUgKnZxKQ0K
IHsNCi0JaWYgKHZxLT52cV9wYWNrZWQuZXZlbnRfZmxhZ3Nfc2hhZG93ID09IFpYREhfUklOR19F
VkVOVF9GTEFHU19ESVNBQkxFKSB7DQotCQl2cS0+dnFfcGFja2VkLmV2ZW50X2ZsYWdzX3NoYWRv
dyA9IFpYREhfUklOR19FVkVOVF9GTEFHU19ESVNBQkxFOw0KKwlpZiAodnEtPnZxX3BhY2tlZC5l
dmVudF9mbGFnc19zaGFkb3cgIT0gWlhESF9SSU5HX0VWRU5UX0ZMQUdTX0VOQUJMRSkgew0KKwkJ
dnEtPnZxX3BhY2tlZC5ldmVudF9mbGFnc19zaGFkb3cgPSBaWERIX1JJTkdfRVZFTlRfRkxBR1Nf
RU5BQkxFOw0KIAkJdnEtPnZxX3BhY2tlZC5yaW5nLmRyaXZlci0+ZGVzY19ldmVudF9mbGFncyA9
IHZxLT52cV9wYWNrZWQuZXZlbnRfZmxhZ3Nfc2hhZG93Ow0KIAl9DQogfQ0KLS0gDQoyLjI3LjA=

--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

Rml4Jm5ic3A7aW5jb3JyZWN0Jm5ic3A7Y29uZGl0aW9uJm5ic3A7Y2hlY2smbmJzcDtpbiZuYnNw
O3p4ZGhfcXVldWVfZW5hYmxlX2ludHIuPGJyIC8+Q2hhbmdlJm5ic3A7JnF1b3Q7PT0mcXVvdDsm
bmJzcDt0byZuYnNwOyZxdW90OyE9JnF1b3Q7LCZuYnNwO2NvbnNpc3RlbnQmbmJzcDt3aXRoJm5i
c3A7enhkaF9xdWV1ZV9kaXNhYmxlX2ludHImbmJzcDtsb2dpYyw8YnIgLz50byZuYnNwO3Byb3Bl
cmx5Jm5ic3A7ZW5hYmxlJm5ic3A7aW50ZXJydXB0cyZuYnNwO3doZW4mbmJzcDtldmVudF9mbGFn
c19zaGFkb3cmbmJzcDtpcyZuYnNwO25vdDxiciAvPmFscmVhZHkmbmJzcDtzZXQmbmJzcDt0byZu
YnNwO0VOQUJMRSZuYnNwO3N0YXRlLjxiciAvPg08YnIgLz5GaXhlczombmJzcDs3Njc3ZjM4NzFl
ZjMmbmJzcDsoJnF1b3Q7bmV0L3p4ZGg6Jm5ic3A7c2V0dXAmbmJzcDtSeC9UeCZuYnNwO3F1ZXVl
cyZuYnNwO2FuZCZuYnNwO2ludGVycnVwdCZxdW90Oyk8YnIgLz5DYzombmJzcDtzdGFibGVAZHBk
ay5vcmc8YnIgLz4NPGJyIC8+U2lnbmVkLW9mZi1ieTombmJzcDtKdW5sb25nJm5ic3A7V2FuZyZu
YnNwOyZsdDt3YW5nLmp1bmxvbmcxQHp0ZS5jb20uY24mZ3Q7DTxiciAvPi0tLTxiciAvPiZuYnNw
O2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9xdWV1ZS5oJm5ic3A7fCZuYnNwOzQmbmJzcDsrKy0tPGJy
IC8+Jm5ic3A7MSZuYnNwO2ZpbGUmbmJzcDtjaGFuZ2VkLCZuYnNwOzImbmJzcDtpbnNlcnRpb25z
KCspLCZuYnNwOzImbmJzcDtkZWxldGlvbnMoLSk8YnIgLz4NPGJyIC8+ZGlmZiZuYnNwOy0tZ2l0
Jm5ic3A7YS9kcml2ZXJzL25ldC96eGRoL3p4ZGhfcXVldWUuaCZuYnNwO2IvZHJpdmVycy9uZXQv
enhkaC96eGRoX3F1ZXVlLmg8YnIgLz5pbmRleCZuYnNwOzFhMGM4YTBkOTAuLjcxMWVhMjkxZDAm
bmJzcDsxMDA2NDQ8YnIgLz4tLS0mbmJzcDthL2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9xdWV1ZS5o
PGJyIC8+KysrJm5ic3A7Yi9kcml2ZXJzL25ldC96eGRoL3p4ZGhfcXVldWUuaDxiciAvPkBAJm5i
c3A7LTM0MCw4Jm5ic3A7KzM0MCw4Jm5ic3A7QEAmbmJzcDt6eGRoX3F1ZXVlX2Rpc2FibGVfaW50
cihzdHJ1Y3QmbmJzcDt6eGRoX3ZpcnRxdWV1ZSZuYnNwOyp2cSk8YnIgLz4mbmJzcDtzdGF0aWMm
bmJzcDtpbmxpbmUmbmJzcDt2b2lkPGJyIC8+Jm5ic3A7enhkaF9xdWV1ZV9lbmFibGVfaW50cihz
dHJ1Y3QmbmJzcDt6eGRoX3ZpcnRxdWV1ZSZuYnNwOyp2cSk8YnIgLz4mbmJzcDt7PGJyIC8+LSZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwO2lmJm5ic3A7KHZxLSZndDt2cV9wYWNrZWQuZXZlbnRfZmxh
Z3Nfc2hhZG93Jm5ic3A7PT0mbmJzcDtaWERIX1JJTkdfRVZFTlRfRkxBR1NfRElTQUJMRSkmbmJz
cDt7PGJyIC8+LSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
O3ZxLSZndDt2cV9wYWNrZWQuZXZlbnRfZmxhZ3Nfc2hhZG93Jm5ic3A7PSZuYnNwO1pYREhfUklO
R19FVkVOVF9GTEFHU19ESVNBQkxFOzxiciAvPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtpZiZu
YnNwOyh2cS0mZ3Q7dnFfcGFja2VkLmV2ZW50X2ZsYWdzX3NoYWRvdyZuYnNwOyE9Jm5ic3A7WlhE
SF9SSU5HX0VWRU5UX0ZMQUdTX0VOQUJMRSkmbmJzcDt7PGJyIC8+KyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3ZxLSZndDt2cV9wYWNrZWQuZXZlbnRfZmxh
Z3Nfc2hhZG93Jm5ic3A7PSZuYnNwO1pYREhfUklOR19FVkVOVF9GTEFHU19FTkFCTEU7PGJyIC8+
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7dnEt
Jmd0O3ZxX3BhY2tlZC5yaW5nLmRyaXZlci0mZ3Q7ZGVzY19ldmVudF9mbGFncyZuYnNwOz0mbmJz
cDt2cS0mZ3Q7dnFfcGFja2VkLmV2ZW50X2ZsYWdzX3NoYWRvdzs8YnIgLz4mbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDt9PGJyIC8+Jm5ic3A7fTxiciAvPi0tJm5ic3A7DTxiciAvPjIuMjcu
MDxiciAvPg==


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

