Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B160CF258D
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 06:03:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 29096402D1;
	Wed, 19 Nov 2025 07:03:16 +0100 (CET)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
 by mails.dpdk.org (Postfix) with ESMTP id B971240265;
 Wed, 19 Nov 2025 07:03:13 +0100 (CET)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4dB9rb3zDtz8Xs72;
 Wed, 19 Nov 2025 14:03:11 +0800 (CST)
Received: from szxl2zmapp05.zte.com.cn ([10.1.32.37])
 by mse-fl1.zte.com.cn with SMTP id 5AJ62R4V010470;
 Wed, 19 Nov 2025 14:02:27 +0800 (+08)
 (envelope-from xu.yang3@zte.com.cn)
Received: from LIN-994FDD64572.zte.com.cn (unknown [10.56.184.166])
 by smtp (Zmail) with SMTP; Wed, 19 Nov 2025 14:02:29 +0800
X-Zmail-TransId: 3e81691d5d7000c-07c97
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: xu.yang3@zte.com.cn
From: Yang Xu <xu.yang3@zte.com.cn>
To: thomas@monjalon.net, dsosnowski@nvidia.com, viacheslavo@nvidia.com,
 bingz@nvidia.com, orika@nvidia.com, suanmingm@nvidia.com,
 matan@nvidia.com, xu.yang3@zte.com.cn, yao.chenghu@zte.com.cn
Cc: dev@dpdk.org, stable@dpdk.org
Subject: [PATCH v3 1/1] net/mlx5: fix port down in link detection error branch
Date: Wed, 19 Nov 2025 14:02:22 +0800
Message-Id: <20251119060222.2814478-1-xu.yang3@zte.com.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 5AJ62R4V010470
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.yang3@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Wed, 19 Nov 2025 14:03:11 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 691D5D9F.000/4dB9rb3zDtz8Xs72
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
b25zLg0KDQpGaXhlczogMTI1NjgwNWRkNTQgKCJuZXQvbWx4NTogbW92ZSBMaW51eC1zcGVjaWZp
YyBmdW5jdGlvbnMiKQ0KQ2M6IHN0YWJsZUBkcGRrLm9yZw0KDQpTaWduZWQtb2ZmLWJ5OiBZYW5n
IFh1IDx4dS55YW5nM0B6dGUuY29tLmNuPg0KLS0tDQogLm1haWxtYXAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgMSArDQogZHJpdmVycy9uZXQvbWx4NS9saW51eC9tbHg1X2V0aGRl
dl9vcy5jIHwgMSArDQogMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCg0KZGlmZiAt
LWdpdCBhLy5tYWlsbWFwIGIvLm1haWxtYXANCmluZGV4IDM0YTk5ZjkzYTEuLjE0ZDZlZTkzZGQg
MTAwNjQ0DQotLS0gYS8ubWFpbG1hcA0KKysrIGIvLm1haWxtYXANCkBAIC0xODkxLDMgKzE4OTEs
NCBAQCBab2x0YW4gS2lzcyA8em9sdGFuLmtpc3NAc2NoYW1hbi5odT4gPHpvbHRhbi5raXNzQGxp
bmFyby5vcmc+DQogWm9yaWsgTWFjaHVsc2t5IDx6b3Jpa0BhbWF6b24uY29tPg0KIFp5dGEgU3pw
YWsgPHp5dGFAbWFydmVsbC5jb20+IDx6ckBzZW1paGFsZi5jb20+DQogWnl0YSBTenBhayA8enl0
YUBtYXJ2ZWxsLmNvbT4gPHp5dGEuc3pwYWtAc2VtaWhhbGYuY29tPg0KK1lhbmcgWHUgPHh1Lnlh
bmczQHp0ZS5jb20uY24+DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvbWx4NS9saW51eC9tbHg1
X2V0aGRldl9vcy5jIGIvZHJpdmVycy9uZXQvbWx4NS9saW51eC9tbHg1X2V0aGRldl9vcy5jDQpp
bmRleCA5ZGFlZGE1NDM1Li40OWI4OGRmZWJiIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvbWx4
NS9saW51eC9tbHg1X2V0aGRldl9vcy5jDQorKysgYi9kcml2ZXJzL25ldC9tbHg1L2xpbnV4L21s
eDVfZXRoZGV2X29zLmMNCkBAIC01MDQsNiArNTA0LDcgQEAgbWx4NV9saW5rX3VwZGF0ZShzdHJ1
Y3QgcnRlX2V0aF9kZXYgKmRldiwgaW50IHdhaXRfdG9fY29tcGxldGUpDQogCQkJCXJldHVybiAt
cnRlX2Vycm5vOw0KIAkJCX0NCiAJCX0gZWxzZSBpZiAocmV0IDwgMCkgew0KKwkJCW1lbXNldCgm
ZGV2LT5kYXRhLT5kZXZfbGluaywgMCwgc2l6ZW9mKGRldi0+ZGF0YS0+ZGV2X2xpbmspKTsNCiAJ
CQlyZXR1cm4gcmV0Ow0KIAkJfQ0KIAl9IHdoaWxlICh3YWl0X3RvX2NvbXBsZXRlIHx8IHJldHJ5
LS0gPiAwKTsNCi0tIA0KMi4yNy4w


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
b25kaXRpb25zLjxiciAvPg08YnIgLz5GaXhlczombmJzcDsxMjU2ODA1ZGQ1NCZuYnNwOygmcXVv
dDtuZXQvbWx4NTombmJzcDttb3ZlJm5ic3A7TGludXgtc3BlY2lmaWMmbmJzcDtmdW5jdGlvbnMm
cXVvdDspPGJyIC8+Q2M6Jm5ic3A7c3RhYmxlQGRwZGsub3JnPGJyIC8+DTxiciAvPlNpZ25lZC1v
ZmYtYnk6Jm5ic3A7WWFuZyZuYnNwO1h1Jm5ic3A7Jmx0O3h1LnlhbmczQHp0ZS5jb20uY24mZ3Q7
DTxiciAvPi0tLTxiciAvPiZuYnNwOy5tYWlsbWFwJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fCZuYnNw
OzEmbmJzcDsrPGJyIC8+Jm5ic3A7ZHJpdmVycy9uZXQvbWx4NS9saW51eC9tbHg1X2V0aGRldl9v
cy5jJm5ic3A7fCZuYnNwOzEmbmJzcDsrPGJyIC8+Jm5ic3A7MiZuYnNwO2ZpbGVzJm5ic3A7Y2hh
bmdlZCwmbmJzcDsyJm5ic3A7aW5zZXJ0aW9ucygrKTxiciAvPg08YnIgLz5kaWZmJm5ic3A7LS1n
aXQmbmJzcDthLy5tYWlsbWFwJm5ic3A7Yi8ubWFpbG1hcDxiciAvPmluZGV4Jm5ic3A7MzRhOTlm
OTNhMS4uMTRkNmVlOTNkZCZuYnNwOzEwMDY0NDxiciAvPi0tLSZuYnNwO2EvLm1haWxtYXA8YnIg
Lz4rKysmbmJzcDtiLy5tYWlsbWFwPGJyIC8+QEAmbmJzcDstMTg5MSwzJm5ic3A7KzE4OTEsNCZu
YnNwO0BAJm5ic3A7Wm9sdGFuJm5ic3A7S2lzcyZuYnNwOyZsdDt6b2x0YW4ua2lzc0BzY2hhbWFu
Lmh1Jmd0OyZuYnNwOyZsdDt6b2x0YW4ua2lzc0BsaW5hcm8ub3JnJmd0Ow08YnIgLz4mbmJzcDta
b3JpayZuYnNwO01hY2h1bHNreSZuYnNwOyZsdDt6b3Jpa0BhbWF6b24uY29tJmd0Ow08YnIgLz4m
bmJzcDtaeXRhJm5ic3A7U3pwYWsmbmJzcDsmbHQ7enl0YUBtYXJ2ZWxsLmNvbSZndDsmbmJzcDsm
bHQ7enJAc2VtaWhhbGYuY29tJmd0Ow08YnIgLz4mbmJzcDtaeXRhJm5ic3A7U3pwYWsmbmJzcDsm
bHQ7enl0YUBtYXJ2ZWxsLmNvbSZndDsmbmJzcDsmbHQ7enl0YS5zenBha0BzZW1paGFsZi5jb20m
Z3Q7DTxiciAvPitZYW5nJm5ic3A7WHUmbmJzcDsmbHQ7eHUueWFuZzNAenRlLmNvbS5jbiZndDsN
PGJyIC8+ZGlmZiZuYnNwOy0tZ2l0Jm5ic3A7YS9kcml2ZXJzL25ldC9tbHg1L2xpbnV4L21seDVf
ZXRoZGV2X29zLmMmbmJzcDtiL2RyaXZlcnMvbmV0L21seDUvbGludXgvbWx4NV9ldGhkZXZfb3Mu
YzxiciAvPmluZGV4Jm5ic3A7OWRhZWRhNTQzNS4uNDliODhkZmViYiZuYnNwOzEwMDY0NDxiciAv
Pi0tLSZuYnNwO2EvZHJpdmVycy9uZXQvbWx4NS9saW51eC9tbHg1X2V0aGRldl9vcy5jPGJyIC8+
KysrJm5ic3A7Yi9kcml2ZXJzL25ldC9tbHg1L2xpbnV4L21seDVfZXRoZGV2X29zLmM8YnIgLz5A
QCZuYnNwOy01MDQsNiZuYnNwOys1MDQsNyZuYnNwO0BAJm5ic3A7bWx4NV9saW5rX3VwZGF0ZShz
dHJ1Y3QmbmJzcDtydGVfZXRoX2RldiZuYnNwOypkZXYsJm5ic3A7aW50Jm5ic3A7d2FpdF90b19j
b21wbGV0ZSk8YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDtyZXR1cm4mbmJzcDstcnRlX2Vycm5vOzxiciAvPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO308YnIg
Lz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt9
Jm5ic3A7ZWxzZSZuYnNwO2lmJm5ic3A7KHJldCZuYnNwOyZsdDsmbmJzcDswKSZuYnNwO3s8YnIg
Lz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7bWVtc2V0KCZhbXA7ZGV2LSZndDtkYXRhLSZndDtkZXZfbGluaywm
bmJzcDswLCZuYnNwO3NpemVvZihkZXYtJmd0O2RhdGEtJmd0O2Rldl9saW5rKSk7PGJyIC8+Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7cmV0dXJuJm5ic3A7cmV0OzxiciAvPiZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO308YnIgLz4mbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDt9Jm5ic3A7d2hpbGUmbmJzcDsod2FpdF90b19jb21wbGV0ZSZuYnNw
O3x8Jm5ic3A7cmV0cnktLSZuYnNwOyZndDsmbmJzcDswKTs8YnIgLz4tLSZuYnNwOw08YnIgLz4y
LjI3LjA8YnIgLz4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

