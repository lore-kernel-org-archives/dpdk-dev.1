Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F7FC54E65
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 09:34:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6F204060B;
	Thu, 22 May 2025 11:34:49 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
 by mails.dpdk.org (Postfix) with ESMTP id 45A9E402CA
 for <dev@dpdk.org>; Thu, 22 May 2025 11:34:47 +0200 (CEST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4b336F52jBz5B1Gs
 for <dev@dpdk.org>; Thu, 22 May 2025 17:34:45 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
 by mse-fl1.zte.com.cn with SMTP id 54M9YQEP048603
 for <dev@dpdk.org>; Thu, 22 May 2025 17:34:26 +0800 (+08)
 (envelope-from li.hanxiao@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Thu, 22 May 2025 17:34:29 +0800
X-Zmail-TransId: 3e81682eefa5005-83e8c
From: Hanxiao Li <li.hanxiao@zte.com.cn>
To: dev@dpdk.org
Cc: Hanxiao Li <li.hanxiao@zte.com.cn>
Subject: [PATCH v6 3/9] crypto/zsda: add statistics
Date: Thu, 22 May 2025 17:30:29 +0800
Message-ID: <20250522093037.2274245-4-li.hanxiao@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250522093037.2274245-1-li.hanxiao@zte.com.cn>
References: <20250522064616.2267636-2-li.hanxiao@zte.com.cn>
 <20250522093037.2274245-1-li.hanxiao@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 54M9YQEP048603
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 682EEFB5.000/4b336F52jBz5B1Gs
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

QWRkIGNyeXB0byBzdGF0aXN0aWNzIG9wZXJhdGlvbnMgZm9yIHpzZGEgZGV2aWNlcy4NCg0KU2ln
bmVkLW9mZi1ieTogSGFueGlhbyBMaSA8bGkuaGFueGlhb0B6dGUuY29tLmNuPg0KLS0tDQogZHJp
dmVycy9jcnlwdG8venNkYS96c2RhX2NyeXB0b19wbWQuYyB8IDI0ICsrKysrKysrKysrKysrKysr
KysrKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcnlwdG8venNkYS96c2RhX2NyeXB0b19wbWQuYyBi
L2RyaXZlcnMvY3J5cHRvL3pzZGEvenNkYV9jcnlwdG9fcG1kLmMNCmluZGV4IDA0YzRlNDU4NDMu
LjhiNDRlYmU2MWYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2NyeXB0by96c2RhL3pzZGFfY3J5cHRv
X3BtZC5jDQorKysgYi9kcml2ZXJzL2NyeXB0by96c2RhL3pzZGFfY3J5cHRvX3BtZC5jDQpAQCAt
NzgsNiArNzgsMjYgQEAgenNkYV9kZXZfaW5mb19nZXQoc3RydWN0IHJ0ZV9jcnlwdG9kZXYgKmRl
diwNCiAJfQ0KIH0NCiANCitzdGF0aWMgdm9pZA0KK3pzZGFfY3J5cHRvX3N0YXRzX2dldChzdHJ1
Y3QgcnRlX2NyeXB0b2RldiAqZGV2LCBzdHJ1Y3QgcnRlX2NyeXB0b2Rldl9zdGF0cyAqc3RhdHMp
DQorew0KKwlzdHJ1Y3QgenNkYV9xcF9zdGF0IGNvbW0gPSB7MH07DQorDQorCXpzZGFfc3RhdHNf
Z2V0KGRldi0+ZGF0YS0+cXVldWVfcGFpcnMsIGRldi0+ZGF0YS0+bmJfcXVldWVfcGFpcnMsDQor
CQkgICAgICAgJmNvbW0pOw0KKwlzdGF0cy0+ZW5xdWV1ZWRfY291bnQgPSBjb21tLmVucXVldWVk
X2NvdW50Ow0KKwlzdGF0cy0+ZGVxdWV1ZWRfY291bnQgPSBjb21tLmRlcXVldWVkX2NvdW50Ow0K
KwlzdGF0cy0+ZW5xdWV1ZV9lcnJfY291bnQgPSBjb21tLmVucXVldWVfZXJyX2NvdW50Ow0KKwlz
dGF0cy0+ZGVxdWV1ZV9lcnJfY291bnQgPSBjb21tLmRlcXVldWVfZXJyX2NvdW50Ow0KK30NCisN
CitzdGF0aWMgdm9pZA0KK3pzZGFfY3J5cHRvX3N0YXRzX3Jlc2V0KHN0cnVjdCBydGVfY3J5cHRv
ZGV2ICpkZXYpDQorew0KKwl6c2RhX3N0YXRzX3Jlc2V0KGRldi0+ZGF0YS0+cXVldWVfcGFpcnMs
IGRldi0+ZGF0YS0+bmJfcXVldWVfcGFpcnMpOw0KK30NCisNCisNCiBzdGF0aWMgc3RydWN0IHJ0
ZV9jcnlwdG9kZXZfb3BzIGNyeXB0b196c2RhX29wcyA9IHsNCiAJLmRldl9jb25maWd1cmUgPSB6
c2RhX2Rldl9jb25maWcsDQogCS5kZXZfc3RhcnQgPSB6c2RhX2Rldl9zdGFydCwNCkBAIC04NSw4
ICsxMDUsOCBAQCBzdGF0aWMgc3RydWN0IHJ0ZV9jcnlwdG9kZXZfb3BzIGNyeXB0b196c2RhX29w
cyA9IHsNCiAJLmRldl9jbG9zZSA9IHpzZGFfZGV2X2Nsb3NlLA0KIAkuZGV2X2luZm9zX2dldCA9
IHpzZGFfZGV2X2luZm9fZ2V0LA0KIA0KLQkuc3RhdHNfZ2V0ID0gTlVMTCwNCi0JLnN0YXRzX3Jl
c2V0ID0gTlVMTCwNCisJLnN0YXRzX2dldCA9IHpzZGFfY3J5cHRvX3N0YXRzX2dldCwNCisJLnN0
YXRzX3Jlc2V0ID0genNkYV9jcnlwdG9fc3RhdHNfcmVzZXQsDQogCS5xdWV1ZV9wYWlyX3NldHVw
ID0gTlVMTCwNCiAJLnF1ZXVlX3BhaXJfcmVsZWFzZSA9IE5VTEwsDQogDQotLSANCjIuMjcuMA==

--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

QWRkJm5ic3A7Y3J5cHRvJm5ic3A7c3RhdGlzdGljcyZuYnNwO29wZXJhdGlvbnMmbmJzcDtmb3Im
bmJzcDt6c2RhJm5ic3A7ZGV2aWNlcy48YnIgLz4NPGJyIC8+U2lnbmVkLW9mZi1ieTombmJzcDtI
YW54aWFvJm5ic3A7TGkmbmJzcDsmbHQ7bGkuaGFueGlhb0B6dGUuY29tLmNuJmd0Ow08YnIgLz4t
LS08YnIgLz4mbmJzcDtkcml2ZXJzL2NyeXB0by96c2RhL3pzZGFfY3J5cHRvX3BtZC5jJm5ic3A7
fCZuYnNwOzI0Jm5ic3A7KysrKysrKysrKysrKysrKysrKysrKy0tPGJyIC8+Jm5ic3A7MSZuYnNw
O2ZpbGUmbmJzcDtjaGFuZ2VkLCZuYnNwOzIyJm5ic3A7aW5zZXJ0aW9ucygrKSwmbmJzcDsyJm5i
c3A7ZGVsZXRpb25zKC0pPGJyIC8+DTxiciAvPmRpZmYmbmJzcDstLWdpdCZuYnNwO2EvZHJpdmVy
cy9jcnlwdG8venNkYS96c2RhX2NyeXB0b19wbWQuYyZuYnNwO2IvZHJpdmVycy9jcnlwdG8venNk
YS96c2RhX2NyeXB0b19wbWQuYzxiciAvPmluZGV4Jm5ic3A7MDRjNGU0NTg0My4uOGI0NGViZTYx
ZiZuYnNwOzEwMDY0NDxiciAvPi0tLSZuYnNwO2EvZHJpdmVycy9jcnlwdG8venNkYS96c2RhX2Ny
eXB0b19wbWQuYzxiciAvPisrKyZuYnNwO2IvZHJpdmVycy9jcnlwdG8venNkYS96c2RhX2NyeXB0
b19wbWQuYzxiciAvPkBAJm5ic3A7LTc4LDYmbmJzcDsrNzgsMjYmbmJzcDtAQCZuYnNwO3pzZGFf
ZGV2X2luZm9fZ2V0KHN0cnVjdCZuYnNwO3J0ZV9jcnlwdG9kZXYmbmJzcDsqZGV2LDxiciAvPiZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO308YnIgLz4mbmJzcDt9PGJyIC8+Jm5ic3A7DTxi
ciAvPitzdGF0aWMmbmJzcDt2b2lkPGJyIC8+K3pzZGFfY3J5cHRvX3N0YXRzX2dldChzdHJ1Y3Qm
bmJzcDtydGVfY3J5cHRvZGV2Jm5ic3A7KmRldiwmbmJzcDtzdHJ1Y3QmbmJzcDtydGVfY3J5cHRv
ZGV2X3N0YXRzJm5ic3A7KnN0YXRzKTxiciAvPit7PGJyIC8+KyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwO3N0cnVjdCZuYnNwO3pzZGFfcXBfc3RhdCZuYnNwO2NvbW0mbmJzcDs9Jm5ic3A7ezB9Ozxi
ciAvPis8YnIgLz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7enNkYV9zdGF0c19nZXQoZGV2LSZn
dDtkYXRhLSZndDtxdWV1ZV9wYWlycywmbmJzcDtkZXYtJmd0O2RhdGEtJmd0O25iX3F1ZXVlX3Bh
aXJzLDxiciAvPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmYW1wO2NvbW0pOzxi
ciAvPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtzdGF0cy0mZ3Q7ZW5xdWV1ZWRfY291bnQmbmJz
cDs9Jm5ic3A7Y29tbS5lbnF1ZXVlZF9jb3VudDs8YnIgLz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7c3RhdHMtJmd0O2RlcXVldWVkX2NvdW50Jm5ic3A7PSZuYnNwO2NvbW0uZGVxdWV1ZWRfY291
bnQ7PGJyIC8+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3N0YXRzLSZndDtlbnF1ZXVlX2Vycl9j
b3VudCZuYnNwOz0mbmJzcDtjb21tLmVucXVldWVfZXJyX2NvdW50OzxiciAvPismbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDtzdGF0cy0mZ3Q7ZGVxdWV1ZV9lcnJfY291bnQmbmJzcDs9Jm5ic3A7Y29t
bS5kZXF1ZXVlX2Vycl9jb3VudDs8YnIgLz4rfTxiciAvPis8YnIgLz4rc3RhdGljJm5ic3A7dm9p
ZDxiciAvPit6c2RhX2NyeXB0b19zdGF0c19yZXNldChzdHJ1Y3QmbmJzcDtydGVfY3J5cHRvZGV2
Jm5ic3A7KmRldik8YnIgLz4rezxiciAvPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt6c2RhX3N0
YXRzX3Jlc2V0KGRldi0mZ3Q7ZGF0YS0mZ3Q7cXVldWVfcGFpcnMsJm5ic3A7ZGV2LSZndDtkYXRh
LSZndDtuYl9xdWV1ZV9wYWlycyk7PGJyIC8+K308YnIgLz4rPGJyIC8+KzxiciAvPiZuYnNwO3N0
YXRpYyZuYnNwO3N0cnVjdCZuYnNwO3J0ZV9jcnlwdG9kZXZfb3BzJm5ic3A7Y3J5cHRvX3pzZGFf
b3BzJm5ic3A7PSZuYnNwO3s8YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsuZGV2
X2NvbmZpZ3VyZSZuYnNwOz0mbmJzcDt6c2RhX2Rldl9jb25maWcsPGJyIC8+Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7LmRldl9zdGFydCZuYnNwOz0mbmJzcDt6c2RhX2Rldl9zdGFydCw8
YnIgLz5AQCZuYnNwOy04NSw4Jm5ic3A7KzEwNSw4Jm5ic3A7QEAmbmJzcDtzdGF0aWMmbmJzcDtz
dHJ1Y3QmbmJzcDtydGVfY3J5cHRvZGV2X29wcyZuYnNwO2NyeXB0b196c2RhX29wcyZuYnNwOz0m
bmJzcDt7PGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7LmRldl9jbG9zZSZuYnNw
Oz0mbmJzcDt6c2RhX2Rldl9jbG9zZSw8YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsuZGV2X2luZm9zX2dldCZuYnNwOz0mbmJzcDt6c2RhX2Rldl9pbmZvX2dldCw8YnIgLz4mbmJz
cDsNPGJyIC8+LSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOy5zdGF0c19nZXQmbmJzcDs9Jm5ic3A7
TlVMTCw8YnIgLz4tJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7LnN0YXRzX3Jlc2V0Jm5ic3A7PSZu
YnNwO05VTEwsPGJyIC8+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOy5zdGF0c19nZXQmbmJzcDs9
Jm5ic3A7enNkYV9jcnlwdG9fc3RhdHNfZ2V0LDxiciAvPismbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsuc3RhdHNfcmVzZXQmbmJzcDs9Jm5ic3A7enNkYV9jcnlwdG9fc3RhdHNfcmVzZXQsPGJyIC8+
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7LnF1ZXVlX3BhaXJfc2V0dXAmbmJzcDs9Jm5i
c3A7TlVMTCw8YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsucXVldWVfcGFpcl9y
ZWxlYXNlJm5ic3A7PSZuYnNwO05VTEwsPGJyIC8+Jm5ic3A7DTxiciAvPi0tJm5ic3A7DTxiciAv
PjIuMjcuMDxiciAvPg==


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

