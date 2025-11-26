Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C32D1037D
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Nov 2025 05:10:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 976A34029A;
	Wed, 26 Nov 2025 06:10:22 +0100 (CET)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
 by mails.dpdk.org (Postfix) with ESMTP id 178454026F;
 Wed, 26 Nov 2025 06:10:21 +0100 (CET)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4dGSLK4WHSz7VGTS;
 Wed, 26 Nov 2025 13:10:17 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4dGSLF4GnZz501bF;
 Wed, 26 Nov 2025 13:10:13 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
 by mse-fl2.zte.com.cn with SMTP id 5AQ59uum086206;
 Wed, 26 Nov 2025 13:09:56 +0800 (+08)
 (envelope-from xu.yang3@zte.com.cn)
Received: from LIN-994FDD64572.zte.com.cn (unknown [10.56.184.166])
 by smtp (Zmail) with SMTP; Wed, 26 Nov 2025 13:09:58 +0800
X-Zmail-TransId: 3e8169268b9e00c-b84e6
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: xu.yang3@zte.com.cn
From: Yang Xu <xu.yang3@zte.com.cn>
To: thomas@monjalon.net, dsosnowski@nvidia.com, viacheslavo@nvidia.com,
 bingz@nvidia.com, orika@nvidia.com, suanmingm@nvidia.com,
 matan@nvidia.com, xu.yang3@zte.com.cn, yao.chenghu@zte.com.cn
Cc: dev@dpdk.org, stable@dpdk.org
Subject: [PATCH v3 1/1] net/mlx5: fix port down in link detection error branch
Date: Wed, 26 Nov 2025 13:09:48 +0800
Message-Id: <20251126050948.3030776-1-xu.yang3@zte.com.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20251119060222.2814478-1-xu.yang3@zte.com.cn--in-reply-to=20251119060222.2814478-1-xu.yang3@zte.com.cn>
References: <20251119060222.2814478-1-xu.yang3@zte.com.cn--in-reply-to=20251119060222.2814478-1-xu.yang3@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn 5AQ59uum086206
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.yang3@zte.com.cn
X-SPF: None
X-SOURCE-IP: 192.168.251.13 unknown Wed, 26 Nov 2025 13:10:17 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69268BB9.000/4dGSLK4WHSz7VGTS
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

VGhlIHBvcnQgZG93biBzdGF0ZSB3YXMgbm90IGluaXRpYWxpemVkIGluIHRoZSBlcnJvciBicmFu
Y2ggb2YgbGluaw0KZGV0ZWN0aW9uIHdoZW4gTUxYIE5JQyBsaW5rIHN0YXR1cyB1cGRhdGUgZmFp
bGVkIChyZXQgPCAwKS4NClRoaXMgcmVzdWx0ZWQgaW4gaW5jb3JyZWN0IGxpbmsgc3RhdGUgcmVw
b3J0aW5nLCBhcyB0aGUgZGV2aWNlDQpyZXRhaW5lZCBzdGFsZSBsaW5rIHN0YXR1cyBpbnN0ZWFk
IG9mIHJlZmxlY3RpbmcgdGhlIGFjdHVhbCBkb3duDQpzdGF0ZSB1bmRlciBlcnJvciBjb25kaXRp
b25zLg0KDQpGaXhlczogMTI1NjgwNWRkNTRkICgibmV0L21seDU6IG1vdmUgTGludXgtc3BlY2lm
aWMgZnVuY3Rpb25zIikNCkNjOiBzdGFibGVAZHBkay5vcmcNCg0KU2lnbmVkLW9mZi1ieTogWWFu
ZyBYdSA8eHUueWFuZzNAenRlLmNvbS5jbj4NCi0tLQ0KIC5tYWlsbWFwICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8IDEgKw0KIGRyaXZlcnMvbmV0L21seDUvbGludXgvbWx4NV9ldGhk
ZXZfb3MuYyB8IDEgKw0KIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQoNCmRpZmYg
LS1naXQgYS8ubWFpbG1hcCBiLy5tYWlsbWFwDQppbmRleCAzNGE5OWY5M2ExLi4xNGQ2ZWU5M2Rk
IDEwMDY0NA0KLS0tIGEvLm1haWxtYXANCisrKyBiLy5tYWlsbWFwDQpAQCAtMTg5MSwzICsxODkx
LDQgQEAgWm9sdGFuIEtpc3MgPHpvbHRhbi5raXNzQHNjaGFtYW4uaHU+IDx6b2x0YW4ua2lzc0Bs
aW5hcm8ub3JnPg0KIFpvcmlrIE1hY2h1bHNreSA8em9yaWtAYW1hem9uLmNvbT4NCiBaeXRhIFN6
cGFrIDx6eXRhQG1hcnZlbGwuY29tPiA8enJAc2VtaWhhbGYuY29tPg0KIFp5dGEgU3pwYWsgPHp5
dGFAbWFydmVsbC5jb20+IDx6eXRhLnN6cGFrQHNlbWloYWxmLmNvbT4NCitZYW5nIFh1IDx4dS55
YW5nM0B6dGUuY29tLmNuPg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L21seDUvbGludXgvbWx4
NV9ldGhkZXZfb3MuYyBiL2RyaXZlcnMvbmV0L21seDUvbGludXgvbWx4NV9ldGhkZXZfb3MuYw0K
aW5kZXggOWRhZWRhNTQzNS4uNDliODhkZmViYiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L21s
eDUvbGludXgvbWx4NV9ldGhkZXZfb3MuYw0KKysrIGIvZHJpdmVycy9uZXQvbWx4NS9saW51eC9t
bHg1X2V0aGRldl9vcy5jDQpAQCAtNTA0LDYgKzUwNCw3IEBAIG1seDVfbGlua191cGRhdGUoc3Ry
dWN0IHJ0ZV9ldGhfZGV2ICpkZXYsIGludCB3YWl0X3RvX2NvbXBsZXRlKQ0KIAkJCQlyZXR1cm4g
LXJ0ZV9lcnJubzsNCiAJCQl9DQogCQl9IGVsc2UgaWYgKHJldCA8IDApIHsNCisJCQltZW1zZXQo
JmRldi0+ZGF0YS0+ZGV2X2xpbmssIDAsIHNpemVvZihkZXYtPmRhdGEtPmRldl9saW5rKSk7DQog
CQkJcmV0dXJuIHJldDsNCiAJCX0NCiAJfSB3aGlsZSAod2FpdF90b19jb21wbGV0ZSB8fCByZXRy
eS0tID4gMCk7DQotLSANCjIuMjcuMA==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

VGhlJm5ic3A7cG9ydCZuYnNwO2Rvd24mbmJzcDtzdGF0ZSZuYnNwO3dhcyZuYnNwO25vdCZuYnNw
O2luaXRpYWxpemVkJm5ic3A7aW4mbmJzcDt0aGUmbmJzcDtlcnJvciZuYnNwO2JyYW5jaCZuYnNw
O29mJm5ic3A7bGluazxiciAvPmRldGVjdGlvbiZuYnNwO3doZW4mbmJzcDtNTFgmbmJzcDtOSUMm
bmJzcDtsaW5rJm5ic3A7c3RhdHVzJm5ic3A7dXBkYXRlJm5ic3A7ZmFpbGVkJm5ic3A7KHJldCZu
YnNwOyZsdDsmbmJzcDswKS48YnIgLz5UaGlzJm5ic3A7cmVzdWx0ZWQmbmJzcDtpbiZuYnNwO2lu
Y29ycmVjdCZuYnNwO2xpbmsmbmJzcDtzdGF0ZSZuYnNwO3JlcG9ydGluZywmbmJzcDthcyZuYnNw
O3RoZSZuYnNwO2RldmljZTxiciAvPnJldGFpbmVkJm5ic3A7c3RhbGUmbmJzcDtsaW5rJm5ic3A7
c3RhdHVzJm5ic3A7aW5zdGVhZCZuYnNwO29mJm5ic3A7cmVmbGVjdGluZyZuYnNwO3RoZSZuYnNw
O2FjdHVhbCZuYnNwO2Rvd248YnIgLz5zdGF0ZSZuYnNwO3VuZGVyJm5ic3A7ZXJyb3ImbmJzcDtj
b25kaXRpb25zLjxiciAvPg08YnIgLz5GaXhlczombmJzcDsxMjU2ODA1ZGQ1NGQmbmJzcDsoJnF1
b3Q7bmV0L21seDU6Jm5ic3A7bW92ZSZuYnNwO0xpbnV4LXNwZWNpZmljJm5ic3A7ZnVuY3Rpb25z
JnF1b3Q7KTxiciAvPkNjOiZuYnNwO3N0YWJsZUBkcGRrLm9yZzxiciAvPg08YnIgLz5TaWduZWQt
b2ZmLWJ5OiZuYnNwO1lhbmcmbmJzcDtYdSZuYnNwOyZsdDt4dS55YW5nM0B6dGUuY29tLmNuJmd0
Ow08YnIgLz4tLS08YnIgLz4mbmJzcDsubWFpbG1hcCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wmbmJz
cDsxJm5ic3A7KzxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L21seDUvbGludXgvbWx4NV9ldGhkZXZf
b3MuYyZuYnNwO3wmbmJzcDsxJm5ic3A7KzxiciAvPiZuYnNwOzImbmJzcDtmaWxlcyZuYnNwO2No
YW5nZWQsJm5ic3A7MiZuYnNwO2luc2VydGlvbnMoKyk8YnIgLz4NPGJyIC8+ZGlmZiZuYnNwOy0t
Z2l0Jm5ic3A7YS8ubWFpbG1hcCZuYnNwO2IvLm1haWxtYXA8YnIgLz5pbmRleCZuYnNwOzM0YTk5
ZjkzYTEuLjE0ZDZlZTkzZGQmbmJzcDsxMDA2NDQ8YnIgLz4tLS0mbmJzcDthLy5tYWlsbWFwPGJy
IC8+KysrJm5ic3A7Yi8ubWFpbG1hcDxiciAvPkBAJm5ic3A7LTE4OTEsMyZuYnNwOysxODkxLDQm
bmJzcDtAQCZuYnNwO1pvbHRhbiZuYnNwO0tpc3MmbmJzcDsmbHQ7em9sdGFuLmtpc3NAc2NoYW1h
bi5odSZndDsmbmJzcDsmbHQ7em9sdGFuLmtpc3NAbGluYXJvLm9yZyZndDsNPGJyIC8+Jm5ic3A7
Wm9yaWsmbmJzcDtNYWNodWxza3kmbmJzcDsmbHQ7em9yaWtAYW1hem9uLmNvbSZndDsNPGJyIC8+
Jm5ic3A7Wnl0YSZuYnNwO1N6cGFrJm5ic3A7Jmx0O3p5dGFAbWFydmVsbC5jb20mZ3Q7Jm5ic3A7
Jmx0O3pyQHNlbWloYWxmLmNvbSZndDsNPGJyIC8+Jm5ic3A7Wnl0YSZuYnNwO1N6cGFrJm5ic3A7
Jmx0O3p5dGFAbWFydmVsbC5jb20mZ3Q7Jm5ic3A7Jmx0O3p5dGEuc3pwYWtAc2VtaWhhbGYuY29t
Jmd0Ow08YnIgLz4rWWFuZyZuYnNwO1h1Jm5ic3A7Jmx0O3h1LnlhbmczQHp0ZS5jb20uY24mZ3Q7
DTxiciAvPmRpZmYmbmJzcDstLWdpdCZuYnNwO2EvZHJpdmVycy9uZXQvbWx4NS9saW51eC9tbHg1
X2V0aGRldl9vcy5jJm5ic3A7Yi9kcml2ZXJzL25ldC9tbHg1L2xpbnV4L21seDVfZXRoZGV2X29z
LmM8YnIgLz5pbmRleCZuYnNwOzlkYWVkYTU0MzUuLjQ5Yjg4ZGZlYmImbmJzcDsxMDA2NDQ8YnIg
Lz4tLS0mbmJzcDthL2RyaXZlcnMvbmV0L21seDUvbGludXgvbWx4NV9ldGhkZXZfb3MuYzxiciAv
PisrKyZuYnNwO2IvZHJpdmVycy9uZXQvbWx4NS9saW51eC9tbHg1X2V0aGRldl9vcy5jPGJyIC8+
QEAmbmJzcDstNTA0LDYmbmJzcDsrNTA0LDcmbmJzcDtAQCZuYnNwO21seDVfbGlua191cGRhdGUo
c3RydWN0Jm5ic3A7cnRlX2V0aF9kZXYmbmJzcDsqZGV2LCZuYnNwO2ludCZuYnNwO3dhaXRfdG9f
Y29tcGxldGUpPGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7cmV0dXJuJm5ic3A7LXJ0ZV9lcnJubzs8YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt9PGJy
IC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
fSZuYnNwO2Vsc2UmbmJzcDtpZiZuYnNwOyhyZXQmbmJzcDsmbHQ7Jm5ic3A7MCkmbmJzcDt7PGJy
IC8+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwO21lbXNldCgmYW1wO2Rldi0mZ3Q7ZGF0YS0mZ3Q7ZGV2X2xpbmss
Jm5ic3A7MCwmbmJzcDtzaXplb2YoZGV2LSZndDtkYXRhLSZndDtkZXZfbGluaykpOzxiciAvPiZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwO3JldHVybiZuYnNwO3JldDs8YnIgLz4mbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt9PGJyIC8+Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7fSZuYnNwO3doaWxlJm5ic3A7KHdhaXRfdG9fY29tcGxldGUmbmJz
cDt8fCZuYnNwO3JldHJ5LS0mbmJzcDsmZ3Q7Jm5ic3A7MCk7PGJyIC8+LS0mbmJzcDsNPGJyIC8+
Mi4yNy4wPGJyIC8+


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

