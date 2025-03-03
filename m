Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D0EC19F32
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Mar 2025 03:31:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BEF24064F;
	Mon,  3 Mar 2025 04:31:21 +0100 (CET)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
 by mails.dpdk.org (Postfix) with ESMTP id 19DE2402D1
 for <dev@dpdk.org>; Mon,  3 Mar 2025 04:31:16 +0100 (CET)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Z5kql0TLgz5B1Gx
 for <dev@dpdk.org>; Mon,  3 Mar 2025 11:31:15 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
 by mse-fl1.zte.com.cn with SMTP id 5233UqTb050907;
 Mon, 3 Mar 2025 11:30:52 +0800 (+08)
 (envelope-from li.hanxiao@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Mon, 3 Mar 2025 11:30:53 +0800
X-Zmail-TransId: 3e8167c5226d005-af98e
From: Hanxiao Li <li.hanxiao@zte.com.cn>
To: dev@dpdk.org
Cc: root <root@localhost.localdomain>, Hanxiao Li <li.hanxiao@zte.com.cn>
Subject: [PATCH v1 3/9] crypto/zsda: add statistics
Date: Mon,  3 Mar 2025 11:16:34 +0800
Message-ID: <20250303031644.1041177-4-li.hanxiao@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250303031644.1041177-1-li.hanxiao@zte.com.cn>
References: <20250208072732.4008334-2-li.hanxiao@zte.com.cn>
 <20250303031644.1041177-1-li.hanxiao@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 5233UqTb050907
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67C52283.000/4Z5kql0TLgz5B1Gx
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

RnJvbTogcm9vdCA8cm9vdEBsb2NhbGhvc3QubG9jYWxkb21haW4+DQoNCkFkZCBjcnlwdG8gc3Rh
dGlzdGljcyBvcGVyYXRpb25zIGZvciB6c2RhIGRldmljZXMuDQoNClNpZ25lZC1vZmYtYnk6IEhh
bnhpYW8gTGkgPGxpLmhhbnhpYW9AenRlLmNvbS5jbj4NCi0tLQ0KIGRyaXZlcnMvY3J5cHRvL3pz
ZGEvenNkYV9zeW1fcG1kLmMgfCAyMyArKysrKysrKysrKysrKysrKysrKystLQ0KIDEgZmlsZSBj
aGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9jcnlwdG8venNkYS96c2RhX3N5bV9wbWQuYyBiL2RyaXZlcnMvY3J5cHRvL3pzZGEv
enNkYV9zeW1fcG1kLmMNCmluZGV4IDVlNzE0ZDU0YmYuLjM2NWNjN2E5NDEgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL2NyeXB0by96c2RhL3pzZGFfc3ltX3BtZC5jDQorKysgYi9kcml2ZXJzL2NyeXB0
by96c2RhL3pzZGFfc3ltX3BtZC5jDQpAQCAtOTAsNiArOTAsMjUgQEAgenNkYV9zeW1fZGV2X2lu
Zm9fZ2V0KHN0cnVjdCBydGVfY3J5cHRvZGV2ICpkZXYsDQogCX0NCiB9DQogDQorc3RhdGljIHZv
aWQNCit6c2RhX3N5bV9zdGF0c19nZXQoc3RydWN0IHJ0ZV9jcnlwdG9kZXYgKmRldiwgc3RydWN0
IHJ0ZV9jcnlwdG9kZXZfc3RhdHMgKnN0YXRzKQ0KK3sNCisJc3RydWN0IHpzZGFfcXBfc3RhdCBj
b21tID0gezB9Ow0KKw0KKwl6c2RhX3N0YXRzX2dldChkZXYtPmRhdGEtPnF1ZXVlX3BhaXJzLCBk
ZXYtPmRhdGEtPm5iX3F1ZXVlX3BhaXJzLA0KKwkJICAgICAgICZjb21tKTsNCisJc3RhdHMtPmVu
cXVldWVkX2NvdW50ID0gY29tbS5lbnF1ZXVlZF9jb3VudDsNCisJc3RhdHMtPmRlcXVldWVkX2Nv
dW50ID0gY29tbS5kZXF1ZXVlZF9jb3VudDsNCisJc3RhdHMtPmVucXVldWVfZXJyX2NvdW50ID0g
Y29tbS5lbnF1ZXVlX2Vycl9jb3VudDsNCisJc3RhdHMtPmRlcXVldWVfZXJyX2NvdW50ID0gY29t
bS5kZXF1ZXVlX2Vycl9jb3VudDsNCit9DQorDQorc3RhdGljIHZvaWQNCit6c2RhX3N5bV9zdGF0
c19yZXNldChzdHJ1Y3QgcnRlX2NyeXB0b2RldiAqZGV2KQ0KK3sNCisJenNkYV9zdGF0c19yZXNl
dChkZXYtPmRhdGEtPnF1ZXVlX3BhaXJzLCBkZXYtPmRhdGEtPm5iX3F1ZXVlX3BhaXJzKTsNCit9
DQorDQogc3RhdGljIHN0cnVjdCBydGVfY3J5cHRvZGV2X29wcyBjcnlwdG9fenNkYV9vcHMgPSB7
DQogDQogCS5kZXZfY29uZmlndXJlID0genNkYV9zeW1fZGV2X2NvbmZpZywNCkBAIC05OCw4ICsx
MTcsOCBAQCBzdGF0aWMgc3RydWN0IHJ0ZV9jcnlwdG9kZXZfb3BzIGNyeXB0b196c2RhX29wcyA9
IHsNCiAJLmRldl9jbG9zZSA9IHpzZGFfc3ltX2Rldl9jbG9zZSwNCiAJLmRldl9pbmZvc19nZXQg
PSB6c2RhX3N5bV9kZXZfaW5mb19nZXQsDQogDQotCS5zdGF0c19nZXQgPSBOVUxMLA0KLQkuc3Rh
dHNfcmVzZXQgPSBOVUxMLA0KKwkuc3RhdHNfZ2V0ID0genNkYV9zeW1fc3RhdHNfZ2V0LA0KKwku
c3RhdHNfcmVzZXQgPSB6c2RhX3N5bV9zdGF0c19yZXNldCwNCiAJLnF1ZXVlX3BhaXJfc2V0dXAg
PSBOVUxMLA0KIAkucXVldWVfcGFpcl9yZWxlYXNlID0gTlVMTCwNCiANCi0tIA0KMi4yNy4w


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbTombmJzcDtyb290Jm5ic3A7Jmx0O3Jvb3RAbG9jYWxob3N0LmxvY2FsZG9tYWluJmd0Ow08
YnIgLz4NPGJyIC8+QWRkJm5ic3A7Y3J5cHRvJm5ic3A7c3RhdGlzdGljcyZuYnNwO29wZXJhdGlv
bnMmbmJzcDtmb3ImbmJzcDt6c2RhJm5ic3A7ZGV2aWNlcy48YnIgLz4NPGJyIC8+U2lnbmVkLW9m
Zi1ieTombmJzcDtIYW54aWFvJm5ic3A7TGkmbmJzcDsmbHQ7bGkuaGFueGlhb0B6dGUuY29tLmNu
Jmd0Ow08YnIgLz4tLS08YnIgLz4mbmJzcDtkcml2ZXJzL2NyeXB0by96c2RhL3pzZGFfc3ltX3Bt
ZC5jJm5ic3A7fCZuYnNwOzIzJm5ic3A7KysrKysrKysrKysrKysrKysrKysrLS08YnIgLz4mbmJz
cDsxJm5ic3A7ZmlsZSZuYnNwO2NoYW5nZWQsJm5ic3A7MjEmbmJzcDtpbnNlcnRpb25zKCspLCZu
YnNwOzImbmJzcDtkZWxldGlvbnMoLSk8YnIgLz4NPGJyIC8+ZGlmZiZuYnNwOy0tZ2l0Jm5ic3A7
YS9kcml2ZXJzL2NyeXB0by96c2RhL3pzZGFfc3ltX3BtZC5jJm5ic3A7Yi9kcml2ZXJzL2NyeXB0
by96c2RhL3pzZGFfc3ltX3BtZC5jPGJyIC8+aW5kZXgmbmJzcDs1ZTcxNGQ1NGJmLi4zNjVjYzdh
OTQxJm5ic3A7MTAwNjQ0PGJyIC8+LS0tJm5ic3A7YS9kcml2ZXJzL2NyeXB0by96c2RhL3pzZGFf
c3ltX3BtZC5jPGJyIC8+KysrJm5ic3A7Yi9kcml2ZXJzL2NyeXB0by96c2RhL3pzZGFfc3ltX3Bt
ZC5jPGJyIC8+QEAmbmJzcDstOTAsNiZuYnNwOys5MCwyNSZuYnNwO0BAJm5ic3A7enNkYV9zeW1f
ZGV2X2luZm9fZ2V0KHN0cnVjdCZuYnNwO3J0ZV9jcnlwdG9kZXYmbmJzcDsqZGV2LDxiciAvPiZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO308YnIgLz4mbmJzcDt9PGJyIC8+Jm5ic3A7DTxi
ciAvPitzdGF0aWMmbmJzcDt2b2lkPGJyIC8+K3pzZGFfc3ltX3N0YXRzX2dldChzdHJ1Y3QmbmJz
cDtydGVfY3J5cHRvZGV2Jm5ic3A7KmRldiwmbmJzcDtzdHJ1Y3QmbmJzcDtydGVfY3J5cHRvZGV2
X3N0YXRzJm5ic3A7KnN0YXRzKTxiciAvPit7PGJyIC8+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
O3N0cnVjdCZuYnNwO3pzZGFfcXBfc3RhdCZuYnNwO2NvbW0mbmJzcDs9Jm5ic3A7ezB9OzxiciAv
Pis8YnIgLz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7enNkYV9zdGF0c19nZXQoZGV2LSZndDtk
YXRhLSZndDtxdWV1ZV9wYWlycywmbmJzcDtkZXYtJmd0O2RhdGEtJmd0O25iX3F1ZXVlX3BhaXJz
LDxiciAvPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmYW1wO2NvbW0pOzxiciAv
PismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtzdGF0cy0mZ3Q7ZW5xdWV1ZWRfY291bnQmbmJzcDs9
Jm5ic3A7Y29tbS5lbnF1ZXVlZF9jb3VudDs8YnIgLz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
c3RhdHMtJmd0O2RlcXVldWVkX2NvdW50Jm5ic3A7PSZuYnNwO2NvbW0uZGVxdWV1ZWRfY291bnQ7
PGJyIC8+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3N0YXRzLSZndDtlbnF1ZXVlX2Vycl9jb3Vu
dCZuYnNwOz0mbmJzcDtjb21tLmVucXVldWVfZXJyX2NvdW50OzxiciAvPismbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDtzdGF0cy0mZ3Q7ZGVxdWV1ZV9lcnJfY291bnQmbmJzcDs9Jm5ic3A7Y29tbS5k
ZXF1ZXVlX2Vycl9jb3VudDs8YnIgLz4rfTxiciAvPis8YnIgLz4rc3RhdGljJm5ic3A7dm9pZDxi
ciAvPit6c2RhX3N5bV9zdGF0c19yZXNldChzdHJ1Y3QmbmJzcDtydGVfY3J5cHRvZGV2Jm5ic3A7
KmRldik8YnIgLz4rezxiciAvPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt6c2RhX3N0YXRzX3Jl
c2V0KGRldi0mZ3Q7ZGF0YS0mZ3Q7cXVldWVfcGFpcnMsJm5ic3A7ZGV2LSZndDtkYXRhLSZndDtu
Yl9xdWV1ZV9wYWlycyk7PGJyIC8+K308YnIgLz4rPGJyIC8+Jm5ic3A7c3RhdGljJm5ic3A7c3Ry
dWN0Jm5ic3A7cnRlX2NyeXB0b2Rldl9vcHMmbmJzcDtjcnlwdG9fenNkYV9vcHMmbmJzcDs9Jm5i
c3A7ezxiciAvPiZuYnNwOw08YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsuZGV2
X2NvbmZpZ3VyZSZuYnNwOz0mbmJzcDt6c2RhX3N5bV9kZXZfY29uZmlnLDxiciAvPkBAJm5ic3A7
LTk4LDgmbmJzcDsrMTE3LDgmbmJzcDtAQCZuYnNwO3N0YXRpYyZuYnNwO3N0cnVjdCZuYnNwO3J0
ZV9jcnlwdG9kZXZfb3BzJm5ic3A7Y3J5cHRvX3pzZGFfb3BzJm5ic3A7PSZuYnNwO3s8YnIgLz4m
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsuZGV2X2Nsb3NlJm5ic3A7PSZuYnNwO3pzZGFf
c3ltX2Rldl9jbG9zZSw8YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsuZGV2X2lu
Zm9zX2dldCZuYnNwOz0mbmJzcDt6c2RhX3N5bV9kZXZfaW5mb19nZXQsPGJyIC8+Jm5ic3A7DTxi
ciAvPi0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsuc3RhdHNfZ2V0Jm5ic3A7PSZuYnNwO05VTEws
PGJyIC8+LSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOy5zdGF0c19yZXNldCZuYnNwOz0mbmJzcDtO
VUxMLDxiciAvPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsuc3RhdHNfZ2V0Jm5ic3A7PSZuYnNw
O3pzZGFfc3ltX3N0YXRzX2dldCw8YnIgLz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7LnN0YXRz
X3Jlc2V0Jm5ic3A7PSZuYnNwO3pzZGFfc3ltX3N0YXRzX3Jlc2V0LDxiciAvPiZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOy5xdWV1ZV9wYWlyX3NldHVwJm5ic3A7PSZuYnNwO05VTEwsPGJy
IC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7LnF1ZXVlX3BhaXJfcmVsZWFzZSZuYnNw
Oz0mbmJzcDtOVUxMLDxiciAvPiZuYnNwOw08YnIgLz4tLSZuYnNwOw08YnIgLz4yLjI3LjA8YnIg
Lz4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

