Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65AEC282C5
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Mar 2025 08:42:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CD804064C;
	Mon,  3 Mar 2025 09:42:14 +0100 (CET)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
 by mails.dpdk.org (Postfix) with ESMTP id 4D7744060A
 for <dev@dpdk.org>; Mon,  3 Mar 2025 09:42:12 +0100 (CET)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Z5skW2T64z5B1J6
 for <dev@dpdk.org>; Mon,  3 Mar 2025 16:42:11 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
 by mse-fl1.zte.com.cn with SMTP id 5238fg8b038010
 for <dev@dpdk.org>; Mon, 3 Mar 2025 16:41:42 +0800 (+08)
 (envelope-from li.hanxiao@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Mon, 3 Mar 2025 16:41:45 +0800
X-Zmail-TransId: 3e8167c56b49005-b82dc
From: Hanxiao Li <li.hanxiao@zte.com.cn>
To: dev@dpdk.org
Cc: Hanxiao Li <li.hanxiao@zte.com.cn>
Subject: [PATCH v2 3/9] crypto/zsda: add statistics
Date: Mon,  3 Mar 2025 16:27:43 +0800
Message-ID: <20250303082751.1053432-4-li.hanxiao@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250303082751.1053432-1-li.hanxiao@zte.com.cn>
References: <20250303031644.1041177-2-li.hanxiao@zte.com.cn>
 <20250303082751.1053432-1-li.hanxiao@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 5238fg8b038010
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67C56B63.000/4Z5skW2T64z5B1J6
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
cy9jcnlwdG8venNkYS96c2RhX3N5bV9wbWQuYw0KaW5kZXggMjJjOGQ0ODJmYi4uMzFiYTU4MmI2
OCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY3J5cHRvL3pzZGEvenNkYV9zeW1fcG1kLmMNCisrKyBi
L2RyaXZlcnMvY3J5cHRvL3pzZGEvenNkYV9zeW1fcG1kLmMNCkBAIC05MCw2ICs5MCwyNSBAQCB6
c2RhX3N5bV9kZXZfaW5mb19nZXQoc3RydWN0IHJ0ZV9jcnlwdG9kZXYgKmRldiwNCiAJfQ0KIH0N
CiANCitzdGF0aWMgdm9pZA0KK3pzZGFfc3ltX3N0YXRzX2dldChzdHJ1Y3QgcnRlX2NyeXB0b2Rl
diAqZGV2LCBzdHJ1Y3QgcnRlX2NyeXB0b2Rldl9zdGF0cyAqc3RhdHMpDQorew0KKwlzdHJ1Y3Qg
enNkYV9xcF9zdGF0IGNvbW0gPSB7MH07DQorDQorCXpzZGFfc3RhdHNfZ2V0KGRldi0+ZGF0YS0+
cXVldWVfcGFpcnMsIGRldi0+ZGF0YS0+bmJfcXVldWVfcGFpcnMsDQorCQkgICAgICAgJmNvbW0p
Ow0KKwlzdGF0cy0+ZW5xdWV1ZWRfY291bnQgPSBjb21tLmVucXVldWVkX2NvdW50Ow0KKwlzdGF0
cy0+ZGVxdWV1ZWRfY291bnQgPSBjb21tLmRlcXVldWVkX2NvdW50Ow0KKwlzdGF0cy0+ZW5xdWV1
ZV9lcnJfY291bnQgPSBjb21tLmVucXVldWVfZXJyX2NvdW50Ow0KKwlzdGF0cy0+ZGVxdWV1ZV9l
cnJfY291bnQgPSBjb21tLmRlcXVldWVfZXJyX2NvdW50Ow0KK30NCisNCitzdGF0aWMgdm9pZA0K
K3pzZGFfc3ltX3N0YXRzX3Jlc2V0KHN0cnVjdCBydGVfY3J5cHRvZGV2ICpkZXYpDQorew0KKwl6
c2RhX3N0YXRzX3Jlc2V0KGRldi0+ZGF0YS0+cXVldWVfcGFpcnMsIGRldi0+ZGF0YS0+bmJfcXVl
dWVfcGFpcnMpOw0KK30NCisNCiBzdGF0aWMgc3RydWN0IHJ0ZV9jcnlwdG9kZXZfb3BzIGNyeXB0
b196c2RhX29wcyA9IHsNCiANCiAJLmRldl9jb25maWd1cmUgPSB6c2RhX3N5bV9kZXZfY29uZmln
LA0KQEAgLTk4LDggKzExNyw4IEBAIHN0YXRpYyBzdHJ1Y3QgcnRlX2NyeXB0b2Rldl9vcHMgY3J5
cHRvX3pzZGFfb3BzID0gew0KIAkuZGV2X2Nsb3NlID0genNkYV9zeW1fZGV2X2Nsb3NlLA0KIAku
ZGV2X2luZm9zX2dldCA9IHpzZGFfc3ltX2Rldl9pbmZvX2dldCwNCiANCi0JLnN0YXRzX2dldCA9
IE5VTEwsDQotCS5zdGF0c19yZXNldCA9IE5VTEwsDQorCS5zdGF0c19nZXQgPSB6c2RhX3N5bV9z
dGF0c19nZXQsDQorCS5zdGF0c19yZXNldCA9IHpzZGFfc3ltX3N0YXRzX3Jlc2V0LA0KIAkucXVl
dWVfcGFpcl9zZXR1cCA9IE5VTEwsDQogCS5xdWV1ZV9wYWlyX3JlbGVhc2UgPSBOVUxMLA0KIA0K
LS0gDQoyLjI3LjA=


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
c3ltX3BtZC5jPGJyIC8+aW5kZXgmbmJzcDsyMmM4ZDQ4MmZiLi4zMWJhNTgyYjY4Jm5ic3A7MTAw
NjQ0PGJyIC8+LS0tJm5ic3A7YS9kcml2ZXJzL2NyeXB0by96c2RhL3pzZGFfc3ltX3BtZC5jPGJy
IC8+KysrJm5ic3A7Yi9kcml2ZXJzL2NyeXB0by96c2RhL3pzZGFfc3ltX3BtZC5jPGJyIC8+QEAm
bmJzcDstOTAsNiZuYnNwOys5MCwyNSZuYnNwO0BAJm5ic3A7enNkYV9zeW1fZGV2X2luZm9fZ2V0
KHN0cnVjdCZuYnNwO3J0ZV9jcnlwdG9kZXYmbmJzcDsqZGV2LDxiciAvPiZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwO308YnIgLz4mbmJzcDt9PGJyIC8+Jm5ic3A7DTxiciAvPitzdGF0aWMm
bmJzcDt2b2lkPGJyIC8+K3pzZGFfc3ltX3N0YXRzX2dldChzdHJ1Y3QmbmJzcDtydGVfY3J5cHRv
ZGV2Jm5ic3A7KmRldiwmbmJzcDtzdHJ1Y3QmbmJzcDtydGVfY3J5cHRvZGV2X3N0YXRzJm5ic3A7
KnN0YXRzKTxiciAvPit7PGJyIC8+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3N0cnVjdCZuYnNw
O3pzZGFfcXBfc3RhdCZuYnNwO2NvbW0mbmJzcDs9Jm5ic3A7ezB9OzxiciAvPis8YnIgLz4rJm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7enNkYV9zdGF0c19nZXQoZGV2LSZndDtkYXRhLSZndDtxdWV1
ZV9wYWlycywmbmJzcDtkZXYtJmd0O2RhdGEtJmd0O25iX3F1ZXVlX3BhaXJzLDxiciAvPismbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmYW1wO2NvbW0pOzxiciAvPismbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDtzdGF0cy0mZ3Q7ZW5xdWV1ZWRfY291bnQmbmJzcDs9Jm5ic3A7Y29tbS5l
bnF1ZXVlZF9jb3VudDs8YnIgLz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7c3RhdHMtJmd0O2Rl
cXVldWVkX2NvdW50Jm5ic3A7PSZuYnNwO2NvbW0uZGVxdWV1ZWRfY291bnQ7PGJyIC8+KyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwO3N0YXRzLSZndDtlbnF1ZXVlX2Vycl9jb3VudCZuYnNwOz0mbmJz
cDtjb21tLmVucXVldWVfZXJyX2NvdW50OzxiciAvPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtz
dGF0cy0mZ3Q7ZGVxdWV1ZV9lcnJfY291bnQmbmJzcDs9Jm5ic3A7Y29tbS5kZXF1ZXVlX2Vycl9j
b3VudDs8YnIgLz4rfTxiciAvPis8YnIgLz4rc3RhdGljJm5ic3A7dm9pZDxiciAvPit6c2RhX3N5
bV9zdGF0c19yZXNldChzdHJ1Y3QmbmJzcDtydGVfY3J5cHRvZGV2Jm5ic3A7KmRldik8YnIgLz4r
ezxiciAvPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt6c2RhX3N0YXRzX3Jlc2V0KGRldi0mZ3Q7
ZGF0YS0mZ3Q7cXVldWVfcGFpcnMsJm5ic3A7ZGV2LSZndDtkYXRhLSZndDtuYl9xdWV1ZV9wYWly
cyk7PGJyIC8+K308YnIgLz4rPGJyIC8+Jm5ic3A7c3RhdGljJm5ic3A7c3RydWN0Jm5ic3A7cnRl
X2NyeXB0b2Rldl9vcHMmbmJzcDtjcnlwdG9fenNkYV9vcHMmbmJzcDs9Jm5ic3A7ezxiciAvPiZu
YnNwOw08YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsuZGV2X2NvbmZpZ3VyZSZu
YnNwOz0mbmJzcDt6c2RhX3N5bV9kZXZfY29uZmlnLDxiciAvPkBAJm5ic3A7LTk4LDgmbmJzcDsr
MTE3LDgmbmJzcDtAQCZuYnNwO3N0YXRpYyZuYnNwO3N0cnVjdCZuYnNwO3J0ZV9jcnlwdG9kZXZf
b3BzJm5ic3A7Y3J5cHRvX3pzZGFfb3BzJm5ic3A7PSZuYnNwO3s8YnIgLz4mbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsuZGV2X2Nsb3NlJm5ic3A7PSZuYnNwO3pzZGFfc3ltX2Rldl9jbG9z
ZSw8YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsuZGV2X2luZm9zX2dldCZuYnNw
Oz0mbmJzcDt6c2RhX3N5bV9kZXZfaW5mb19nZXQsPGJyIC8+Jm5ic3A7DTxiciAvPi0mbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsuc3RhdHNfZ2V0Jm5ic3A7PSZuYnNwO05VTEwsPGJyIC8+LSZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOy5zdGF0c19yZXNldCZuYnNwOz0mbmJzcDtOVUxMLDxiciAvPism
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsuc3RhdHNfZ2V0Jm5ic3A7PSZuYnNwO3pzZGFfc3ltX3N0
YXRzX2dldCw8YnIgLz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7LnN0YXRzX3Jlc2V0Jm5ic3A7
PSZuYnNwO3pzZGFfc3ltX3N0YXRzX3Jlc2V0LDxiciAvPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOy5xdWV1ZV9wYWlyX3NldHVwJm5ic3A7PSZuYnNwO05VTEwsPGJyIC8+Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7LnF1ZXVlX3BhaXJfcmVsZWFzZSZuYnNwOz0mbmJzcDtOVUxM
LDxiciAvPiZuYnNwOw08YnIgLz4tLSZuYnNwOw08YnIgLz4yLjI3LjA8YnIgLz4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

