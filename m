Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF9BC3ABDD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 10:24:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC69440C35;
	Thu, 15 May 2025 12:24:22 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
 by mails.dpdk.org (Postfix) with ESMTP id E683740B97
 for <dev@dpdk.org>; Thu, 15 May 2025 12:24:20 +0200 (CEST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZymXb70nkz8RTZL
 for <dev@dpdk.org>; Thu, 15 May 2025 18:24:15 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
 by mse-fl1.zte.com.cn with SMTP id 54FAO6St006211
 for <dev@dpdk.org>; Thu, 15 May 2025 18:24:06 +0800 (+08)
 (envelope-from li.hanxiao@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Thu, 15 May 2025 18:24:10 +0800
X-Zmail-TransId: 3e816825c0ca004-c9508
From: Hanxiao Li <li.hanxiao@zte.com.cn>
To: dev@dpdk.org
Cc: Hanxiao Li <li.hanxiao@zte.com.cn>
Subject: [PATCH v3 3/9] crypto/zsda: add statistics
Date: Thu, 15 May 2025 18:19:20 +0800
Message-ID: <20250515101927.1926502-4-li.hanxiao@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515101927.1926502-1-li.hanxiao@zte.com.cn>
References: <20250303082751.1053432-2-li.hanxiao@zte.com.cn>
 <20250515101927.1926502-1-li.hanxiao@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 54FAO6St006211
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6825C0CF.003/4ZymXb70nkz8RTZL
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
dmVycy9jcnlwdG8venNkYS96c2RhX3N5bV9wbWQuYyB8IDIzICsrKysrKysrKysrKysrKysrKysr
Ky0tDQogMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2NyeXB0by96c2RhL3pzZGFfc3ltX3BtZC5jIGIvZHJpdmVy
cy9jcnlwdG8venNkYS96c2RhX3N5bV9wbWQuYw0KaW5kZXggZDE5YmMzY2I1Yy4uM2MyMGE0M2E5
ZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY3J5cHRvL3pzZGEvenNkYV9zeW1fcG1kLmMNCisrKyBi
L2RyaXZlcnMvY3J5cHRvL3pzZGEvenNkYV9zeW1fcG1kLmMNCkBAIC03OCw2ICs3OCwyNSBAQCB6
c2RhX2Rldl9pbmZvX2dldChzdHJ1Y3QgcnRlX2NyeXB0b2RldiAqZGV2LA0KIAl9DQogfQ0KIA0K
K3N0YXRpYyB2b2lkDQorenNkYV9jcnlwdG9fc3RhdHNfZ2V0KHN0cnVjdCBydGVfY3J5cHRvZGV2
ICpkZXYsIHN0cnVjdCBydGVfY3J5cHRvZGV2X3N0YXRzICpzdGF0cykNCit7DQorCXN0cnVjdCB6
c2RhX3FwX3N0YXQgY29tbSA9IHswfTsNCisNCisJenNkYV9zdGF0c19nZXQoZGV2LT5kYXRhLT5x
dWV1ZV9wYWlycywgZGV2LT5kYXRhLT5uYl9xdWV1ZV9wYWlycywNCisJCSAgICAgICAmY29tbSk7
DQorCXN0YXRzLT5lbnF1ZXVlZF9jb3VudCA9IGNvbW0uZW5xdWV1ZWRfY291bnQ7DQorCXN0YXRz
LT5kZXF1ZXVlZF9jb3VudCA9IGNvbW0uZGVxdWV1ZWRfY291bnQ7DQorCXN0YXRzLT5lbnF1ZXVl
X2Vycl9jb3VudCA9IGNvbW0uZW5xdWV1ZV9lcnJfY291bnQ7DQorCXN0YXRzLT5kZXF1ZXVlX2Vy
cl9jb3VudCA9IGNvbW0uZGVxdWV1ZV9lcnJfY291bnQ7DQorfQ0KKw0KK3N0YXRpYyB2b2lkDQor
enNkYV9jcnlwdG9fc3RhdHNfcmVzZXQoc3RydWN0IHJ0ZV9jcnlwdG9kZXYgKmRldikNCit7DQor
CXpzZGFfc3RhdHNfcmVzZXQoZGV2LT5kYXRhLT5xdWV1ZV9wYWlycywgZGV2LT5kYXRhLT5uYl9x
dWV1ZV9wYWlycyk7DQorfQ0KKw0KIHN0YXRpYyBzdHJ1Y3QgcnRlX2NyeXB0b2Rldl9vcHMgY3J5
cHRvX3pzZGFfb3BzID0gew0KIAkuZGV2X2NvbmZpZ3VyZSA9IHpzZGFfZGV2X2NvbmZpZywNCiAJ
LmRldl9zdGFydCA9IHpzZGFfZGV2X3N0YXJ0LA0KQEAgLTg1LDggKzEwNCw4IEBAIHN0YXRpYyBz
dHJ1Y3QgcnRlX2NyeXB0b2Rldl9vcHMgY3J5cHRvX3pzZGFfb3BzID0gew0KIAkuZGV2X2Nsb3Nl
ID0genNkYV9kZXZfY2xvc2UsDQogCS5kZXZfaW5mb3NfZ2V0ID0genNkYV9kZXZfaW5mb19nZXQs
DQogDQotCS5zdGF0c19nZXQgPSBOVUxMLA0KLQkuc3RhdHNfcmVzZXQgPSBOVUxMLA0KKwkuc3Rh
dHNfZ2V0ID0genNkYV9jcnlwdG9fc3RhdHNfZ2V0LA0KKwkuc3RhdHNfcmVzZXQgPSB6c2RhX2Ny
eXB0b19zdGF0c19yZXNldCwNCiAJLnF1ZXVlX3BhaXJfc2V0dXAgPSBOVUxMLA0KIAkucXVldWVf
cGFpcl9yZWxlYXNlID0gTlVMTCwNCiANCi0tIA0KMi4yNy4w


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

QWRkJm5ic3A7Y3J5cHRvJm5ic3A7c3RhdGlzdGljcyZuYnNwO29wZXJhdGlvbnMmbmJzcDtmb3Im
bmJzcDt6c2RhJm5ic3A7ZGV2aWNlcy48YnIgLz4NPGJyIC8+U2lnbmVkLW9mZi1ieTombmJzcDtI
YW54aWFvJm5ic3A7TGkmbmJzcDsmbHQ7bGkuaGFueGlhb0B6dGUuY29tLmNuJmd0Ow08YnIgLz4t
LS08YnIgLz4mbmJzcDtkcml2ZXJzL2NyeXB0by96c2RhL3pzZGFfc3ltX3BtZC5jJm5ic3A7fCZu
YnNwOzIzJm5ic3A7KysrKysrKysrKysrKysrKysrKysrLS08YnIgLz4mbmJzcDsxJm5ic3A7Zmls
ZSZuYnNwO2NoYW5nZWQsJm5ic3A7MjEmbmJzcDtpbnNlcnRpb25zKCspLCZuYnNwOzImbmJzcDtk
ZWxldGlvbnMoLSk8YnIgLz4NPGJyIC8+ZGlmZiZuYnNwOy0tZ2l0Jm5ic3A7YS9kcml2ZXJzL2Ny
eXB0by96c2RhL3pzZGFfc3ltX3BtZC5jJm5ic3A7Yi9kcml2ZXJzL2NyeXB0by96c2RhL3pzZGFf
c3ltX3BtZC5jPGJyIC8+aW5kZXgmbmJzcDtkMTliYzNjYjVjLi4zYzIwYTQzYTlmJm5ic3A7MTAw
NjQ0PGJyIC8+LS0tJm5ic3A7YS9kcml2ZXJzL2NyeXB0by96c2RhL3pzZGFfc3ltX3BtZC5jPGJy
IC8+KysrJm5ic3A7Yi9kcml2ZXJzL2NyeXB0by96c2RhL3pzZGFfc3ltX3BtZC5jPGJyIC8+QEAm
bmJzcDstNzgsNiZuYnNwOys3OCwyNSZuYnNwO0BAJm5ic3A7enNkYV9kZXZfaW5mb19nZXQoc3Ry
dWN0Jm5ic3A7cnRlX2NyeXB0b2RldiZuYnNwOypkZXYsPGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7fTxiciAvPiZuYnNwO308YnIgLz4mbmJzcDsNPGJyIC8+K3N0YXRpYyZuYnNw
O3ZvaWQ8YnIgLz4renNkYV9jcnlwdG9fc3RhdHNfZ2V0KHN0cnVjdCZuYnNwO3J0ZV9jcnlwdG9k
ZXYmbmJzcDsqZGV2LCZuYnNwO3N0cnVjdCZuYnNwO3J0ZV9jcnlwdG9kZXZfc3RhdHMmbmJzcDsq
c3RhdHMpPGJyIC8+K3s8YnIgLz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7c3RydWN0Jm5ic3A7
enNkYV9xcF9zdGF0Jm5ic3A7Y29tbSZuYnNwOz0mbmJzcDt7MH07PGJyIC8+KzxiciAvPismbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDt6c2RhX3N0YXRzX2dldChkZXYtJmd0O2RhdGEtJmd0O3F1ZXVl
X3BhaXJzLCZuYnNwO2Rldi0mZ3Q7ZGF0YS0mZ3Q7bmJfcXVldWVfcGFpcnMsPGJyIC8+KyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZhbXA7Y29tbSk7PGJyIC8+KyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwO3N0YXRzLSZndDtlbnF1ZXVlZF9jb3VudCZuYnNwOz0mbmJzcDtjb21tLmVu
cXVldWVkX2NvdW50OzxiciAvPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtzdGF0cy0mZ3Q7ZGVx
dWV1ZWRfY291bnQmbmJzcDs9Jm5ic3A7Y29tbS5kZXF1ZXVlZF9jb3VudDs8YnIgLz4rJm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7c3RhdHMtJmd0O2VucXVldWVfZXJyX2NvdW50Jm5ic3A7PSZuYnNw
O2NvbW0uZW5xdWV1ZV9lcnJfY291bnQ7PGJyIC8+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3N0
YXRzLSZndDtkZXF1ZXVlX2Vycl9jb3VudCZuYnNwOz0mbmJzcDtjb21tLmRlcXVldWVfZXJyX2Nv
dW50OzxiciAvPit9PGJyIC8+KzxiciAvPitzdGF0aWMmbmJzcDt2b2lkPGJyIC8+K3pzZGFfY3J5
cHRvX3N0YXRzX3Jlc2V0KHN0cnVjdCZuYnNwO3J0ZV9jcnlwdG9kZXYmbmJzcDsqZGV2KTxiciAv
Pit7PGJyIC8+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3pzZGFfc3RhdHNfcmVzZXQoZGV2LSZn
dDtkYXRhLSZndDtxdWV1ZV9wYWlycywmbmJzcDtkZXYtJmd0O2RhdGEtJmd0O25iX3F1ZXVlX3Bh
aXJzKTs8YnIgLz4rfTxiciAvPis8YnIgLz4mbmJzcDtzdGF0aWMmbmJzcDtzdHJ1Y3QmbmJzcDty
dGVfY3J5cHRvZGV2X29wcyZuYnNwO2NyeXB0b196c2RhX29wcyZuYnNwOz0mbmJzcDt7PGJyIC8+
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7LmRldl9jb25maWd1cmUmbmJzcDs9Jm5ic3A7
enNkYV9kZXZfY29uZmlnLDxiciAvPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOy5kZXZf
c3RhcnQmbmJzcDs9Jm5ic3A7enNkYV9kZXZfc3RhcnQsPGJyIC8+QEAmbmJzcDstODUsOCZuYnNw
OysxMDQsOCZuYnNwO0BAJm5ic3A7c3RhdGljJm5ic3A7c3RydWN0Jm5ic3A7cnRlX2NyeXB0b2Rl
dl9vcHMmbmJzcDtjcnlwdG9fenNkYV9vcHMmbmJzcDs9Jm5ic3A7ezxiciAvPiZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOy5kZXZfY2xvc2UmbmJzcDs9Jm5ic3A7enNkYV9kZXZfY2xvc2Us
PGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7LmRldl9pbmZvc19nZXQmbmJzcDs9
Jm5ic3A7enNkYV9kZXZfaW5mb19nZXQsPGJyIC8+Jm5ic3A7DTxiciAvPi0mbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsuc3RhdHNfZ2V0Jm5ic3A7PSZuYnNwO05VTEwsPGJyIC8+LSZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOy5zdGF0c19yZXNldCZuYnNwOz0mbmJzcDtOVUxMLDxiciAvPismbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsuc3RhdHNfZ2V0Jm5ic3A7PSZuYnNwO3pzZGFfY3J5cHRvX3N0YXRz
X2dldCw8YnIgLz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7LnN0YXRzX3Jlc2V0Jm5ic3A7PSZu
YnNwO3pzZGFfY3J5cHRvX3N0YXRzX3Jlc2V0LDxiciAvPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOy5xdWV1ZV9wYWlyX3NldHVwJm5ic3A7PSZuYnNwO05VTEwsPGJyIC8+Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7LnF1ZXVlX3BhaXJfcmVsZWFzZSZuYnNwOz0mbmJzcDtOVUxM
LDxiciAvPiZuYnNwOw08YnIgLz4tLSZuYnNwOw08YnIgLz4yLjI3LjA8YnIgLz4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

