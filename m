Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521CECA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 00:37:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38D014013F;
	Mon, 18 Aug 2025 02:37:31 +0200 (CEST)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
 by mails.dpdk.org (Postfix) with ESMTP id 8669E4003C
 for <dev@dpdk.org>; Mon, 18 Aug 2025 02:37:28 +0200 (CEST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4c4v1c6xTnz5B12j;
 Mon, 18 Aug 2025 08:37:24 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
 by mse-fl2.zte.com.cn with SMTP id 57I0WW1P013292;
 Mon, 18 Aug 2025 08:32:32 +0800 (+08)
 (envelope-from xu.yang3@zte.com.cn)
Received: from LIN-994FDD64572.zte.com.cn (unknown [10.56.184.166])
 by smtp (Zmail) with SMTP; Mon, 18 Aug 2025 08:32:33 +0800
X-Zmail-TransId: 3e8168a2749a002-666f9
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: xu.yang3@zte.com.cn
From: Yang Xu <xu.yang3@zte.com.cn>
To: thomas@monjalon.net, dsosnowski@nvidia.com, viacheslavo@nvidia.com,
 bingz@nvidia.com, orika@nvidia.com, suanmingm@nvidia.com,
 matan@nvidia.com, xu.yang3@zte.com.cn, yao.chenghu@zte.com.cn
Cc: dev@dpdk.org
Subject: [PATCH 1/1] net/mlx5/linux: set down if detect any anomaly
Date: Mon, 18 Aug 2025 08:32:23 +0800
Message-Id: <20250818003223.2098419-1-xu.yang3@zte.com.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn 57I0WW1P013292
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.yang3@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Mon, 18 Aug 2025 08:37:24 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68A275C4.000/4c4v1c6xTnz5B12j
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

TUxYIG5ldHdvcmsgaW50ZXJmYWNlIGNhcmQgbGluayBkZXRlY3Rpb24gd2lsbCBzZXQgdGhlDQpp
bnRlcmZhY2UgdG8gYSBkb3duIHN0YXRlIHVwb24gZGV0ZWN0aW5nIGFuIGFub21hbHkuDQoNClNp
Z25lZC1vZmYtYnk6IFlhbmcgWHUgPHh1LnlhbmczQHp0ZS5jb20uY24+DQotLS0NCiAubWFpbG1h
cCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxICsNCiBkcml2ZXJzL25ldC9tbHg1
L2xpbnV4L21seDVfZXRoZGV2X29zLmMgfCAyICsrDQogMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhLy5tYWlsbWFwIGIvLm1haWxtYXANCmluZGV4IDM0YTk5
ZjkzYTEuLjE0ZDZlZTkzZGQgMTAwNjQ0DQotLS0gYS8ubWFpbG1hcA0KKysrIGIvLm1haWxtYXAN
CkBAIC0xODkxLDMgKzE4OTEsNCBAQCBab2x0YW4gS2lzcyA8em9sdGFuLmtpc3NAc2NoYW1hbi5o
dT4gPHpvbHRhbi5raXNzQGxpbmFyby5vcmc+DQogWm9yaWsgTWFjaHVsc2t5IDx6b3Jpa0BhbWF6
b24uY29tPg0KIFp5dGEgU3pwYWsgPHp5dGFAbWFydmVsbC5jb20+IDx6ckBzZW1paGFsZi5jb20+
DQogWnl0YSBTenBhayA8enl0YUBtYXJ2ZWxsLmNvbT4gPHp5dGEuc3pwYWtAc2VtaWhhbGYuY29t
Pg0KK1lhbmcgWHUgPHh1LnlhbmczQHp0ZS5jb20uY24+DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
ZXQvbWx4NS9saW51eC9tbHg1X2V0aGRldl9vcy5jIGIvZHJpdmVycy9uZXQvbWx4NS9saW51eC9t
bHg1X2V0aGRldl9vcy5jDQppbmRleCA5ZGFlZGE1NDM1Li4zNjRiMDI0Yjc3IDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9uZXQvbWx4NS9saW51eC9tbHg1X2V0aGRldl9vcy5jDQorKysgYi9kcml2ZXJz
L25ldC9tbHg1L2xpbnV4L21seDVfZXRoZGV2X29zLmMNCkBAIC00ODYsNiArNDg2LDcgQEAgbWx4
NV9saW5rX3VwZGF0ZShzdHJ1Y3QgcnRlX2V0aF9kZXYgKmRldiwgaW50IHdhaXRfdG9fY29tcGxl
dGUpDQogCXN0cnVjdCBydGVfZXRoX2xpbmsgZGV2X2xpbms7DQogCXRpbWVfdCBzdGFydF90aW1l
ID0gdGltZShOVUxMKTsNCiAJaW50IHJldHJ5ID0gTUxYNV9HRVRfTElOS19TVEFUVVNfUkVUUllf
Q09VTlQ7DQorCW1lbXNldCgmZGV2X2xpbmssIDAsIHNpemVvZihkZXZfbGluaykpOw0KIA0KIAlk
byB7DQogCQlyZXQgPSBtbHg1X2xpbmtfdXBkYXRlX3VubG9ja2VkX2dzKGRldiwgJmRldl9saW5r
KTsNCkBAIC01MDQsNiArNTA1LDcgQEAgbWx4NV9saW5rX3VwZGF0ZShzdHJ1Y3QgcnRlX2V0aF9k
ZXYgKmRldiwgaW50IHdhaXRfdG9fY29tcGxldGUpDQogCQkJCXJldHVybiAtcnRlX2Vycm5vOw0K
IAkJCX0NCiAJCX0gZWxzZSBpZiAocmV0IDwgMCkgew0KKwkJCWRldi0+ZGF0YS0+ZGV2X2xpbmsg
PSBkZXZfbGluazsNCiAJCQlyZXR1cm4gcmV0Ow0KIAkJfQ0KIAl9IHdoaWxlICh3YWl0X3RvX2Nv
bXBsZXRlIHx8IHJldHJ5LS0gPiAwKTsNCi0tIA0KMi4yNy4w


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

TUxYJm5ic3A7bmV0d29yayZuYnNwO2ludGVyZmFjZSZuYnNwO2NhcmQmbmJzcDtsaW5rJm5ic3A7
ZGV0ZWN0aW9uJm5ic3A7d2lsbCZuYnNwO3NldCZuYnNwO3RoZTxiciAvPmludGVyZmFjZSZuYnNw
O3RvJm5ic3A7YSZuYnNwO2Rvd24mbmJzcDtzdGF0ZSZuYnNwO3Vwb24mbmJzcDtkZXRlY3Rpbmcm
bmJzcDthbiZuYnNwO2Fub21hbHkuPGJyIC8+DTxiciAvPlNpZ25lZC1vZmYtYnk6Jm5ic3A7WWFu
ZyZuYnNwO1h1Jm5ic3A7Jmx0O3h1LnlhbmczQHp0ZS5jb20uY24mZ3Q7DTxiciAvPi0tLTxiciAv
PiZuYnNwOy5tYWlsbWFwJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNwOzEmbmJzcDsrPGJyIC8+
Jm5ic3A7ZHJpdmVycy9uZXQvbWx4NS9saW51eC9tbHg1X2V0aGRldl9vcy5jJm5ic3A7fCZuYnNw
OzImbmJzcDsrKzxiciAvPiZuYnNwOzImbmJzcDtmaWxlcyZuYnNwO2NoYW5nZWQsJm5ic3A7MyZu
YnNwO2luc2VydGlvbnMoKyk8YnIgLz4NPGJyIC8+ZGlmZiZuYnNwOy0tZ2l0Jm5ic3A7YS8ubWFp
bG1hcCZuYnNwO2IvLm1haWxtYXA8YnIgLz5pbmRleCZuYnNwOzM0YTk5ZjkzYTEuLjE0ZDZlZTkz
ZGQmbmJzcDsxMDA2NDQ8YnIgLz4tLS0mbmJzcDthLy5tYWlsbWFwPGJyIC8+KysrJm5ic3A7Yi8u
bWFpbG1hcDxiciAvPkBAJm5ic3A7LTE4OTEsMyZuYnNwOysxODkxLDQmbmJzcDtAQCZuYnNwO1pv
bHRhbiZuYnNwO0tpc3MmbmJzcDsmbHQ7em9sdGFuLmtpc3NAc2NoYW1hbi5odSZndDsmbmJzcDsm
bHQ7em9sdGFuLmtpc3NAbGluYXJvLm9yZyZndDsNPGJyIC8+Jm5ic3A7Wm9yaWsmbmJzcDtNYWNo
dWxza3kmbmJzcDsmbHQ7em9yaWtAYW1hem9uLmNvbSZndDsNPGJyIC8+Jm5ic3A7Wnl0YSZuYnNw
O1N6cGFrJm5ic3A7Jmx0O3p5dGFAbWFydmVsbC5jb20mZ3Q7Jm5ic3A7Jmx0O3pyQHNlbWloYWxm
LmNvbSZndDsNPGJyIC8+Jm5ic3A7Wnl0YSZuYnNwO1N6cGFrJm5ic3A7Jmx0O3p5dGFAbWFydmVs
bC5jb20mZ3Q7Jm5ic3A7Jmx0O3p5dGEuc3pwYWtAc2VtaWhhbGYuY29tJmd0Ow08YnIgLz4rWWFu
ZyZuYnNwO1h1Jm5ic3A7Jmx0O3h1LnlhbmczQHp0ZS5jb20uY24mZ3Q7DTxiciAvPmRpZmYmbmJz
cDstLWdpdCZuYnNwO2EvZHJpdmVycy9uZXQvbWx4NS9saW51eC9tbHg1X2V0aGRldl9vcy5jJm5i
c3A7Yi9kcml2ZXJzL25ldC9tbHg1L2xpbnV4L21seDVfZXRoZGV2X29zLmM8YnIgLz5pbmRleCZu
YnNwOzlkYWVkYTU0MzUuLjM2NGIwMjRiNzcmbmJzcDsxMDA2NDQ8YnIgLz4tLS0mbmJzcDthL2Ry
aXZlcnMvbmV0L21seDUvbGludXgvbWx4NV9ldGhkZXZfb3MuYzxiciAvPisrKyZuYnNwO2IvZHJp
dmVycy9uZXQvbWx4NS9saW51eC9tbHg1X2V0aGRldl9vcy5jPGJyIC8+QEAmbmJzcDstNDg2LDYm
bmJzcDsrNDg2LDcmbmJzcDtAQCZuYnNwO21seDVfbGlua191cGRhdGUoc3RydWN0Jm5ic3A7cnRl
X2V0aF9kZXYmbmJzcDsqZGV2LCZuYnNwO2ludCZuYnNwO3dhaXRfdG9fY29tcGxldGUpPGJyIC8+
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7c3RydWN0Jm5ic3A7cnRlX2V0aF9saW5rJm5i
c3A7ZGV2X2xpbms7PGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7dGltZV90Jm5i
c3A7c3RhcnRfdGltZSZuYnNwOz0mbmJzcDt0aW1lKE5VTEwpOzxiciAvPiZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwO2ludCZuYnNwO3JldHJ5Jm5ic3A7PSZuYnNwO01MWDVfR0VUX0xJTktf
U1RBVFVTX1JFVFJZX0NPVU5UOzxiciAvPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDttZW1zZXQo
JmFtcDtkZXZfbGluaywmbmJzcDswLCZuYnNwO3NpemVvZihkZXZfbGluaykpOzxiciAvPiZuYnNw
Ow08YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtkbyZuYnNwO3s8YnIgLz4mbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtyZXQmbmJz
cDs9Jm5ic3A7bWx4NV9saW5rX3VwZGF0ZV91bmxvY2tlZF9ncyhkZXYsJm5ic3A7JmFtcDtkZXZf
bGluayk7PGJyIC8+QEAmbmJzcDstNTA0LDYmbmJzcDsrNTA1LDcmbmJzcDtAQCZuYnNwO21seDVf
bGlua191cGRhdGUoc3RydWN0Jm5ic3A7cnRlX2V0aF9kZXYmbmJzcDsqZGV2LCZuYnNwO2ludCZu
YnNwO3dhaXRfdG9fY29tcGxldGUpPGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7cmV0dXJuJm5ic3A7LXJ0ZV9lcnJubzs8YnIgLz4mbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDt9PGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7fSZuYnNwO2Vsc2UmbmJzcDtpZiZuYnNwOyhyZXQmbmJzcDsmbHQ7Jm5ic3A7
MCkmbmJzcDt7PGJyIC8+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO2Rldi0mZ3Q7ZGF0YS0mZ3Q7ZGV2X2xpbmsm
bmJzcDs9Jm5ic3A7ZGV2X2xpbms7PGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7cmV0dXJuJm5i
c3A7cmV0OzxiciAvPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwO308YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt9Jm5ic3A7d2hp
bGUmbmJzcDsod2FpdF90b19jb21wbGV0ZSZuYnNwO3x8Jm5ic3A7cmV0cnktLSZuYnNwOyZndDsm
bmJzcDswKTs8YnIgLz4tLSZuYnNwOw08YnIgLz4yLjI3LjA8YnIgLz4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

