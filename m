Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6655BEC1E85
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 09:47:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50F424026D;
	Thu,  5 Feb 2026 10:47:22 +0100 (CET)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
 by mails.dpdk.org (Postfix) with ESMTP id 4215340264
 for <dev@dpdk.org>; Thu,  5 Feb 2026 10:47:20 +0100 (CET)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4f6C770W54z51SdY;
 Thu, 05 Feb 2026 17:47:15 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
 by mse-fl2.zte.com.cn with SMTP id 6159l4vX035634;
 Thu, 5 Feb 2026 17:47:04 +0800 (+08)
 (envelope-from zhang.tianhao2@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Thu, 5 Feb 2026 17:47:06 +0800
X-Zmail-TransId: 3e8169846714001-9d1f9
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: zhang.tianhao2@zte.com.cn
From: Tianhao Zhang <zhang.tianhao2@zte.com.cn>
To: stephen@networkplumber.org, wang.junlong1@zte.com.cn,
 yang.yonggang@zte.com.cn
Cc: dev@dpdk.org, Tianhao Zhang <zhang.tianhao2@zte.com.cn>
Subject: [PATCH v1] net/zxdh: adjust the log level
Date: Thu,  5 Feb 2026 17:23:17 +0800
Message-ID: <20260205092317.2708097-1-zhang.tianhao2@zte.com.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn 6159l4vX035634
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: zhang.tianhao2@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Thu, 05 Feb 2026 17:47:15 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69846723.001/4f6C770W54z51SdY
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

U2luY2Ugc29tZSBmbG93IHRhYmxlcyBkbyBub3QgaGF2ZSBwYXJ0bmVyIHRhYmxlcywgY2hhbmdl
IHRoZSBsb2cgbGV2ZWwgZnJvbSBlcnJvciB0byBkZWJ1Zy4NCg0KU2lnbmVkLW9mZi1ieTogVGlh
bmhhbyBaaGFuZyA8emhhbmcudGlhbmhhbzJAenRlLmNvbS5jbj4NCi0tLQ0KIGRyaXZlcnMvbmV0
L3p4ZGgvenhkaF9ucC5jIHwgNCArKy0tDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9u
cC5jIGIvZHJpdmVycy9uZXQvenhkaC96eGRoX25wLmMNCmluZGV4IDAyNGRhMTEzZTIuLjQ4NjQ3
ODA0OGUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC96eGRoL3p4ZGhfbnAuYw0KKysrIGIvZHJp
dmVycy9uZXQvenhkaC96eGRoX25wLmMNCkBAIC00MDkyLDcgKzQwOTIsNyBAQCB6eGRoX25wX29u
ZV9oYXNoX3NvZnRfdW5pbnN0YWxsKHVpbnQzMl90IGRldl9pZCwgdWludDMyX3QgaGFzaF9pZCkN
CiAJSEFTSF9ERFJfQ0ZHICpwX3RlbXBfcmJrZXkgPSBOVUxMOw0KIA0KIAlpZiAocF9mdW5jX2lu
Zm8tPmlzX3VzZWQgPT0gMCkgew0KLQkJUE1EX0RSVl9MT0coRVJSLCAiRXJyb3JbMHgleF0sIGZ1
bl9pZCBbJXVdIGlzIG5vdCBpbml0ISIsDQorCQlQTURfRFJWX0xPRyhERUJVRywgIkVycm9yWzB4
JXhdLCBmdW5faWQgWyV1XSBpcyBub3QgaW5pdCEiLA0KIAkJCVpYREhfU0VfUkNfRlVOX0lOVkFM
SUQsIGhhc2hfaWQpOw0KIAkJcmV0dXJuIFpYREhfT0s7DQogCX0NCkBAIC00ODQ5LDcgKzQ4NDks
NyBAQCB6eGRoX25wX3NvZnRfc2R0X3RibF9nZXQodWludDMyX3QgZGV2X2lkLCB1aW50MzJfdCBz
ZHRfbm8sIHZvaWQgKnBfc2R0X2luZm8pDQogCXVpbnQzMl90IHJjOw0KIA0KIAlpZiAoc2R0X25v
ID4gWlhESF9ERVZfU0RUX0lEX01BWCAtIDEpIHsNCi0JCVBNRF9EUlZfTE9HKEVSUiwgIlNEVCBO
TyBbICV1IF0gaXMgaW52YWxpZCEiLCBzZHRfbm8pOw0KKwkJUE1EX0RSVl9MT0coREVCVUcsICJT
RFQgTk8gWyAldSBdIGlzIGludmFsaWQhIiwgc2R0X25vKTsNCiAJCXJldHVybiBaWERIX1BBUl9D
SEtfSU5WQUxJRF9QQVJBOw0KIAl9DQogDQotLSANCjIuMjcuMA==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

U2luY2UmbmJzcDtzb21lJm5ic3A7ZmxvdyZuYnNwO3RhYmxlcyZuYnNwO2RvJm5ic3A7bm90Jm5i
c3A7aGF2ZSZuYnNwO3BhcnRuZXImbmJzcDt0YWJsZXMsJm5ic3A7Y2hhbmdlJm5ic3A7dGhlJm5i
c3A7bG9nJm5ic3A7bGV2ZWwmbmJzcDtmcm9tJm5ic3A7ZXJyb3ImbmJzcDt0byZuYnNwO2RlYnVn
LjxiciAvPg08YnIgLz5TaWduZWQtb2ZmLWJ5OiZuYnNwO1RpYW5oYW8mbmJzcDtaaGFuZyZuYnNw
OyZsdDt6aGFuZy50aWFuaGFvMkB6dGUuY29tLmNuJmd0Ow08YnIgLz4tLS08YnIgLz4mbmJzcDtk
cml2ZXJzL25ldC96eGRoL3p4ZGhfbnAuYyZuYnNwO3wmbmJzcDs0Jm5ic3A7KystLTxiciAvPiZu
YnNwOzEmbmJzcDtmaWxlJm5ic3A7Y2hhbmdlZCwmbmJzcDsyJm5ic3A7aW5zZXJ0aW9ucygrKSwm
bmJzcDsyJm5ic3A7ZGVsZXRpb25zKC0pPGJyIC8+DTxiciAvPmRpZmYmbmJzcDstLWdpdCZuYnNw
O2EvZHJpdmVycy9uZXQvenhkaC96eGRoX25wLmMmbmJzcDtiL2RyaXZlcnMvbmV0L3p4ZGgvenhk
aF9ucC5jPGJyIC8+aW5kZXgmbmJzcDswMjRkYTExM2UyLi40ODY0NzgwNDhlJm5ic3A7MTAwNjQ0
PGJyIC8+LS0tJm5ic3A7YS9kcml2ZXJzL25ldC96eGRoL3p4ZGhfbnAuYzxiciAvPisrKyZuYnNw
O2IvZHJpdmVycy9uZXQvenhkaC96eGRoX25wLmM8YnIgLz5AQCZuYnNwOy00MDkyLDcmbmJzcDsr
NDA5Miw3Jm5ic3A7QEAmbmJzcDt6eGRoX25wX29uZV9oYXNoX3NvZnRfdW5pbnN0YWxsKHVpbnQz
Ml90Jm5ic3A7ZGV2X2lkLCZuYnNwO3VpbnQzMl90Jm5ic3A7aGFzaF9pZCk8YnIgLz4mbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtIQVNIX0REUl9DRkcmbmJzcDsqcF90ZW1wX3Jia2V5Jm5i
c3A7PSZuYnNwO05VTEw7PGJyIC8+Jm5ic3A7DTxiciAvPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwO2lmJm5ic3A7KHBfZnVuY19pbmZvLSZndDtpc191c2VkJm5ic3A7PT0mbmJzcDswKSZu
YnNwO3s8YnIgLz4tJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7UE1EX0RSVl9MT0coRVJSLCZuYnNwOyZxdW90O0Vycm9yWzB4JXhdLCZuYnNwO2Z1bl9pZCZu
YnNwO1sldV0mbmJzcDtpcyZuYnNwO25vdCZuYnNwO2luaXQhJnF1b3Q7LDxiciAvPismbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtQTURfRFJWX0xPRyhERUJV
RywmbmJzcDsmcXVvdDtFcnJvclsweCV4XSwmbmJzcDtmdW5faWQmbmJzcDtbJXVdJm5ic3A7aXMm
bmJzcDtub3QmbmJzcDtpbml0ISZxdW90Oyw8YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtaWERI
X1NFX1JDX0ZVTl9JTlZBTElELCZuYnNwO2hhc2hfaWQpOzxiciAvPiZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3JldHVybiZuYnNwO1pYREhfT0s7
PGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fTxiciAvPkBAJm5ic3A7LTQ4NDks
NyZuYnNwOys0ODQ5LDcmbmJzcDtAQCZuYnNwO3p4ZGhfbnBfc29mdF9zZHRfdGJsX2dldCh1aW50
MzJfdCZuYnNwO2Rldl9pZCwmbmJzcDt1aW50MzJfdCZuYnNwO3NkdF9ubywmbmJzcDt2b2lkJm5i
c3A7KnBfc2R0X2luZm8pPGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7dWludDMy
X3QmbmJzcDtyYzs8YnIgLz4mbmJzcDsNPGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7aWYmbmJzcDsoc2R0X25vJm5ic3A7Jmd0OyZuYnNwO1pYREhfREVWX1NEVF9JRF9NQVgmbmJz
cDstJm5ic3A7MSkmbmJzcDt7PGJyIC8+LSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwO1BNRF9EUlZfTE9HKEVSUiwmbmJzcDsmcXVvdDtTRFQmbmJzcDtOTyZu
YnNwO1smbmJzcDsldSZuYnNwO10mbmJzcDtpcyZuYnNwO2ludmFsaWQhJnF1b3Q7LCZuYnNwO3Nk
dF9ubyk7PGJyIC8+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwO1BNRF9EUlZfTE9HKERFQlVHLCZuYnNwOyZxdW90O1NEVCZuYnNwO05PJm5ic3A7WyZuYnNw
OyV1Jm5ic3A7XSZuYnNwO2lzJm5ic3A7aW52YWxpZCEmcXVvdDssJm5ic3A7c2R0X25vKTs8YnIg
Lz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDty
ZXR1cm4mbmJzcDtaWERIX1BBUl9DSEtfSU5WQUxJRF9QQVJBOzxiciAvPiZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwO308YnIgLz4mbmJzcDsNPGJyIC8+LS0mbmJzcDsNPGJyIC8+Mi4yNy4w
PGJyIC8+


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

