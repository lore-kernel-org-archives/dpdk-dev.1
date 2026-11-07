Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B99606A32D
	for <dpdk-dev@archiver.kernel.org>; Sat,  7 Nov 2026 03:16:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7993E42E5E;
	Sat,  7 Nov 2026 04:16:03 +0100 (CET)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
 by mails.dpdk.org (Postfix) with ESMTPS id 716AE42E10;
 Sat,  7 Nov 2026 04:16:00 +0100 (CET)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jM1Qk4Phsz8XrrJ;
 Sat, 07 Nov 2026 11:15:58 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
 by mse-fl1.zte.com.cn with SMTP id 6A73FidF019058;
 Sat, 7 Nov 2026 11:15:44 +0800 (+08)
 (envelope-from wang.junlong1@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Sat, 7 Nov 2026 11:15:46 +0800
X-Zmail-TransId: 3e816aee97e202a-ce9ac
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: wang.junlong1@zte.com.cn
From: Junlong Wang <wang.junlong1@zte.com.cn>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, Junlong Wang <wang.junlong1@zte.com.cn>, stable@dpdk.org
Subject: [PATCH v1 2/8] net/zxdh: initialise DTB entry in flow query
Date: Sat,  7 Nov 2026 11:04:42 +0800
Message-ID: <20261107030448.2891345-3-wang.junlong1@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107030448.2891345-1-wang.junlong1@zte.com.cn>
References: <20261107030448.2891345-1-wang.junlong1@zte.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 6A73FidF019058
X-TLS: YES
X-ENVELOPE-SENDER: wang.junlong1@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 07 Nov 2026 11:15:58 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEE97EE.001/4jM1Qk4Phsz8XrrJ
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



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

enhkaF9od19mbG93X3F1ZXJ5KCkgZGVjbGFyZXMgaXRzIFpYREhfRFRCX1VTRVJfRU5UUllfVCB3
aXRob3V0IGFuDQppbml0aWFsaXNlciwgdW5saWtlIHRoZSBzaWJsaW5nIGRlY2xhcmF0aW9ucyBp
bg0KenhkaF9od19mbG93X2luc2VydCgpIGFuZCB6eGRoX2h3X2Zsb3dfZGVsKCkgd2hpY2ggdXNl
ID0gezB9LiBXaGVuDQp0aGUgZmxvdyBpbmRleCBpcyBaWERIX01BWF9GTE9XX05VTSBvciBtb3Jl
LA0KenhkaF9mZF9mbG93X3RvX2R0YmVudHJ5KCkgcmV0dXJucyBiZWZvcmUgd3JpdGluZyB0aGUg
ZW50cnksIGFuZCB0aGUNCmZyZWVfcmVzIHBhdGggdGhlbiBjYWxscyBydGVfZnJlZSgpIG9uIHRo
ZSB1bmluaXRpYWxpc2VkDQpwX2VudHJ5X2RhdGEgcG9pbnRlci4gVGhlIGluZGV4IGNvbWVzIGZy
b20gYSBWRidzIFpYREhfRkxPV19IV19HRVQNCm1haWxib3ggbWVzc2FnZSwgYW5kIHBmX2ZkX2h3
X3F1ZXJ5X2NvdW50KCkgb25seSBjaGVja3MgaXQgYWZ0ZXIgdGhlDQpxdWVyeSwgc28gYSBzaW5n
bGUgcmVxdWVzdCBmcm9tIGEgZ3Vlc3QgZnJlZXMgZ2FyYmFnZSBhbmQga2lsbHMgdGhlDQpwcm9j
ZXNzIGRyaXZpbmcgdGhlIFBGIGluIGEgcmVsZWFzZSBidWlsZC4NCg0KSW5pdGlhbGlzZSB0aGUg
ZW50cnkgdGhlIHdheSB0aGUgc2libGluZ3MgZG86IGJvdGggZXJyb3IgcGF0aHMNCihvdXQtb2Yt
cmFuZ2UgaW5kZXggYW5kIHJ0ZV96bWFsbG9jKCkgZmFpbHVyZSkgdGhlbiBlbmQgaW4NCnJ0ZV9m
cmVlKE5VTEwpLCBhIG5vLW9wLCBhbmQgdGhlIFZGIGdldHMgdGhlIGV4aXN0aW5nIGVycm9yIHJl
cGx5Lg0KVmFsaWQgaW5kaWNlcyBiZWhhdmUgYXMgYmVmb3JlLg0KDQpGaXhlczogZDBhZjQ4YzFi
OTUyICgibmV0L3p4ZGg6IHN1cHBvcnQgZmxvdyBBUEkiKQ0KQ2M6IHN0YWJsZUBkcGRrLm9yZw0K
DQpTaWduZWQtb2ZmLWJ5OiBKdW5sb25nIFdhbmcgPHdhbmcuanVubG9uZzFAenRlLmNvbS5jbj4N
Ci0tLQ0KIGRyaXZlcnMvbmV0L3p4ZGgvenhkaF9mbG93LmMgfCAyICstDQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC96eGRoL3p4ZGhfZmxvdy5jIGIvZHJpdmVycy9uZXQvenhkaC96eGRoX2Zsb3cuYw0KaW5k
ZXggNTZhYzM0YzZlMy4uYTUxY2U5ZWY3NyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3p4ZGgv
enhkaF9mbG93LmMNCisrKyBiL2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9mbG93LmMNCkBAIC0xMTM3
LDcgKzExMzcsNyBAQCB6eGRoX2h3X2Zsb3dfcXVlcnkoc3RydWN0IHJ0ZV9ldGhfZGV2ICpkZXYs
IHN0cnVjdCB6eGRoX2Zsb3cgKmRoX2Zsb3csDQogCXN0cnVjdCB6eGRoX2h3ICpodyA9IGRldi0+
ZGF0YS0+ZGV2X3ByaXZhdGU7DQogCWludCByZXQgPSAwOw0KIAlzdHJ1Y3QgenhkaF9mbG93X2lu
Zm8gKmZsb3cgPSAmZGhfZmxvdy0+Zmxvd2VudHJ5Ow0KLQlaWERIX0RUQl9VU0VSX0VOVFJZX1Qg
ZHRiX2VudHJ5Ow0KKwlaWERIX0RUQl9VU0VSX0VOVFJZX1QgZHRiX2VudHJ5ID0gezB9Ow0KIAl1
aW50MTZfdCBoYW5kbGVfaWR4Ow0KIA0KIAloYW5kbGVfaWR4ID0genhkaF9mZF9mbG93X3RvX2R0
YmVudHJ5KGh3LCBmbG93LCAmZHRiX2VudHJ5KTsNCi0tIA0KMi4yNy4w


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

enhkaF9od19mbG93X3F1ZXJ5KCkmbmJzcDtkZWNsYXJlcyZuYnNwO2l0cyZuYnNwO1pYREhfRFRC
X1VTRVJfRU5UUllfVCZuYnNwO3dpdGhvdXQmbmJzcDthbjxiciAvPmluaXRpYWxpc2VyLCZuYnNw
O3VubGlrZSZuYnNwO3RoZSZuYnNwO3NpYmxpbmcmbmJzcDtkZWNsYXJhdGlvbnMmbmJzcDtpbjxi
ciAvPnp4ZGhfaHdfZmxvd19pbnNlcnQoKSZuYnNwO2FuZCZuYnNwO3p4ZGhfaHdfZmxvd19kZWwo
KSZuYnNwO3doaWNoJm5ic3A7dXNlJm5ic3A7PSZuYnNwO3swfS4mbmJzcDtXaGVuPGJyIC8+dGhl
Jm5ic3A7ZmxvdyZuYnNwO2luZGV4Jm5ic3A7aXMmbmJzcDtaWERIX01BWF9GTE9XX05VTSZuYnNw
O29yJm5ic3A7bW9yZSw8YnIgLz56eGRoX2ZkX2Zsb3dfdG9fZHRiZW50cnkoKSZuYnNwO3JldHVy
bnMmbmJzcDtiZWZvcmUmbmJzcDt3cml0aW5nJm5ic3A7dGhlJm5ic3A7ZW50cnksJm5ic3A7YW5k
Jm5ic3A7dGhlPGJyIC8+ZnJlZV9yZXMmbmJzcDtwYXRoJm5ic3A7dGhlbiZuYnNwO2NhbGxzJm5i
c3A7cnRlX2ZyZWUoKSZuYnNwO29uJm5ic3A7dGhlJm5ic3A7dW5pbml0aWFsaXNlZDxiciAvPnBf
ZW50cnlfZGF0YSZuYnNwO3BvaW50ZXIuJm5ic3A7VGhlJm5ic3A7aW5kZXgmbmJzcDtjb21lcyZu
YnNwO2Zyb20mbmJzcDthJm5ic3A7VkYmYXBvcztzJm5ic3A7WlhESF9GTE9XX0hXX0dFVDxiciAv
Pm1haWxib3gmbmJzcDttZXNzYWdlLCZuYnNwO2FuZCZuYnNwO3BmX2ZkX2h3X3F1ZXJ5X2NvdW50
KCkmbmJzcDtvbmx5Jm5ic3A7Y2hlY2tzJm5ic3A7aXQmbmJzcDthZnRlciZuYnNwO3RoZTxiciAv
PnF1ZXJ5LCZuYnNwO3NvJm5ic3A7YSZuYnNwO3NpbmdsZSZuYnNwO3JlcXVlc3QmbmJzcDtmcm9t
Jm5ic3A7YSZuYnNwO2d1ZXN0Jm5ic3A7ZnJlZXMmbmJzcDtnYXJiYWdlJm5ic3A7YW5kJm5ic3A7
a2lsbHMmbmJzcDt0aGU8YnIgLz5wcm9jZXNzJm5ic3A7ZHJpdmluZyZuYnNwO3RoZSZuYnNwO1BG
Jm5ic3A7aW4mbmJzcDthJm5ic3A7cmVsZWFzZSZuYnNwO2J1aWxkLjxiciAvPg08YnIgLz5Jbml0
aWFsaXNlJm5ic3A7dGhlJm5ic3A7ZW50cnkmbmJzcDt0aGUmbmJzcDt3YXkmbmJzcDt0aGUmbmJz
cDtzaWJsaW5ncyZuYnNwO2RvOiZuYnNwO2JvdGgmbmJzcDtlcnJvciZuYnNwO3BhdGhzPGJyIC8+
KG91dC1vZi1yYW5nZSZuYnNwO2luZGV4Jm5ic3A7YW5kJm5ic3A7cnRlX3ptYWxsb2MoKSZuYnNw
O2ZhaWx1cmUpJm5ic3A7dGhlbiZuYnNwO2VuZCZuYnNwO2luPGJyIC8+cnRlX2ZyZWUoTlVMTCks
Jm5ic3A7YSZuYnNwO25vLW9wLCZuYnNwO2FuZCZuYnNwO3RoZSZuYnNwO1ZGJm5ic3A7Z2V0cyZu
YnNwO3RoZSZuYnNwO2V4aXN0aW5nJm5ic3A7ZXJyb3ImbmJzcDtyZXBseS48YnIgLz5WYWxpZCZu
YnNwO2luZGljZXMmbmJzcDtiZWhhdmUmbmJzcDthcyZuYnNwO2JlZm9yZS48YnIgLz4NPGJyIC8+
Rml4ZXM6Jm5ic3A7ZDBhZjQ4YzFiOTUyJm5ic3A7KCZxdW90O25ldC96eGRoOiZuYnNwO3N1cHBv
cnQmbmJzcDtmbG93Jm5ic3A7QVBJJnF1b3Q7KTxiciAvPkNjOiZuYnNwO3N0YWJsZUBkcGRrLm9y
ZzxiciAvPg08YnIgLz5TaWduZWQtb2ZmLWJ5OiZuYnNwO0p1bmxvbmcmbmJzcDtXYW5nJm5ic3A7
Jmx0O3dhbmcuanVubG9uZzFAenRlLmNvbS5jbiZndDsNPGJyIC8+LS0tPGJyIC8+Jm5ic3A7ZHJp
dmVycy9uZXQvenhkaC96eGRoX2Zsb3cuYyZuYnNwO3wmbmJzcDsyJm5ic3A7Ky08YnIgLz4mbmJz
cDsxJm5ic3A7ZmlsZSZuYnNwO2NoYW5nZWQsJm5ic3A7MSZuYnNwO2luc2VydGlvbigrKSwmbmJz
cDsxJm5ic3A7ZGVsZXRpb24oLSk8YnIgLz4NPGJyIC8+ZGlmZiZuYnNwOy0tZ2l0Jm5ic3A7YS9k
cml2ZXJzL25ldC96eGRoL3p4ZGhfZmxvdy5jJm5ic3A7Yi9kcml2ZXJzL25ldC96eGRoL3p4ZGhf
Zmxvdy5jPGJyIC8+aW5kZXgmbmJzcDs1NmFjMzRjNmUzLi5hNTFjZTllZjc3Jm5ic3A7MTAwNjQ0
PGJyIC8+LS0tJm5ic3A7YS9kcml2ZXJzL25ldC96eGRoL3p4ZGhfZmxvdy5jPGJyIC8+KysrJm5i
c3A7Yi9kcml2ZXJzL25ldC96eGRoL3p4ZGhfZmxvdy5jPGJyIC8+QEAmbmJzcDstMTEzNyw3Jm5i
c3A7KzExMzcsNyZuYnNwO0BAJm5ic3A7enhkaF9od19mbG93X3F1ZXJ5KHN0cnVjdCZuYnNwO3J0
ZV9ldGhfZGV2Jm5ic3A7KmRldiwmbmJzcDtzdHJ1Y3QmbmJzcDt6eGRoX2Zsb3cmbmJzcDsqZGhf
Zmxvdyw8YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtzdHJ1Y3QmbmJzcDt6eGRo
X2h3Jm5ic3A7Kmh3Jm5ic3A7PSZuYnNwO2Rldi0mZ3Q7ZGF0YS0mZ3Q7ZGV2X3ByaXZhdGU7PGJy
IC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7aW50Jm5ic3A7cmV0Jm5ic3A7PSZuYnNw
OzA7PGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7c3RydWN0Jm5ic3A7enhkaF9m
bG93X2luZm8mbmJzcDsqZmxvdyZuYnNwOz0mbmJzcDsmYW1wO2RoX2Zsb3ctJmd0O2Zsb3dlbnRy
eTs8YnIgLz4tJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7WlhESF9EVEJfVVNFUl9FTlRSWV9UJm5i
c3A7ZHRiX2VudHJ5OzxiciAvPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtaWERIX0RUQl9VU0VS
X0VOVFJZX1QmbmJzcDtkdGJfZW50cnkmbmJzcDs9Jm5ic3A7ezB9OzxiciAvPiZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwO3VpbnQxNl90Jm5ic3A7aGFuZGxlX2lkeDs8YnIgLz4mbmJzcDsN
PGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7aGFuZGxlX2lkeCZuYnNwOz0mbmJz
cDt6eGRoX2ZkX2Zsb3dfdG9fZHRiZW50cnkoaHcsJm5ic3A7ZmxvdywmbmJzcDsmYW1wO2R0Yl9l
bnRyeSk7PGJyIC8+LS0mbmJzcDsNPGJyIC8+Mi4yNy4wPGJyIC8+


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

