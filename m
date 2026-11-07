Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6190606A326
	for <dpdk-dev@archiver.kernel.org>; Sat,  7 Nov 2026 03:16:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6414642E00;
	Sat,  7 Nov 2026 04:16:06 +0100 (CET)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
 by mails.dpdk.org (Postfix) with ESMTPS id 4E22642E69;
 Sat,  7 Nov 2026 04:16:04 +0100 (CET)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4jM1Ql3lkgz55y2J;
 Sat, 07 Nov 2026 11:15:59 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
 by mse-fl1.zte.com.cn with SMTP id 6A73FktT019070;
 Sat, 7 Nov 2026 11:15:46 +0800 (+08)
 (envelope-from wang.junlong1@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Sat, 7 Nov 2026 11:15:48 +0800
X-Zmail-TransId: 3e816aee97e302a-ce9b6
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: wang.junlong1@zte.com.cn
From: Junlong Wang <wang.junlong1@zte.com.cn>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, Junlong Wang <wang.junlong1@zte.com.cn>, stable@dpdk.org
Subject: [PATCH v1 4/8] net/zxdh: initialise multicast delete flag
Date: Sat,  7 Nov 2026 11:04:44 +0800
Message-ID: <20261107030448.2891345-5-wang.junlong1@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107030448.2891345-1-wang.junlong1@zte.com.cn>
References: <20261107030448.2891345-1-wang.junlong1@zte.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 6A73FktT019070
X-TLS: YES
X-ENVELOPE-SENDER: wang.junlong1@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 07 Nov 2026 11:15:59 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEE97EF.000/4jM1Ql3lkgz55y2J
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

enhkaF9kZWxfbWFjX3RhYmxlKCkgZGVjaWRlcyB3aGV0aGVyIGEgbXVsdGljYXN0IGFkZHJlc3Mg
c3RpbGwgaGFzDQpzdWJzY3JpYmVycyB3aXRoIGRlbF9mbGFnLCBidXQgdGhlIGZsYWcgaGFzIG5v
IGluaXRpYWxpc2VyIGFuZCBpcw0Kb25seSBldmVyIGFzc2lnbmVkIDEuIFRoZSBsb29wIHRoYXQg
d2Fsa3MgdGhlIGdyb3VwIGVudHJpZXMgYnJlYWtzDQpvdXQgYXMgc29vbiBhcyBpdCBmaW5kcyBv
bmUgdGhhdCBzdGlsbCBoYXMgbWVtYmVycywgbGVhdmluZyBkZWxfZmxhZw0KdW53cml0dGVuOyBh
dCAtTzEgYW5kIGFib3ZlLCBpbmNsdWRpbmcgdGhlIGRlZmF1bHQgLU8yIGJ1aWxkLCB0aGUNCmNv
bXBpbGVyIHJlc29sdmVzIHRoZSBzdWJzZXF1ZW50IHRlc3QgdG8gdHJ1ZSwgc28gdGhlIGRlbGV0
ZSBsb29wDQphbHdheXMgcnVucy4NCg0KV2hlbmV2ZXIgb25lIHBvcnQgdGhlcmVmb3JlIGxlYXZl
cyBhIHNoYXJlZCBtdWx0aWNhc3QgYWRkcmVzcywgdGhlDQplbnRyaWVzIGhvbGRpbmcgdGhlIFBG
J3MgYW5kIGV2ZXJ5IG90aGVyIFZGJ3MgbWVtYmVyc2hpcCBhcmUgZGVsZXRlZA0KdG9vOiB0aGUg
UEYgYW5kIHNpYmxpbmcgVkZzIHNpbGVudGx5IGxvc2UgdGhlaXIgbXVsdGljYXN0IHJlY2VwdGlv
biwNCndpdGggbm8gYXR0YWNrZXIgaW52b2x2ZWQuDQoNClJlc3RvcmUgdGhlIG1pc3NpbmcgaW5p
dGlhbGlzZXIsIHNvIHRoZSBlbnRyeSBpcyBkZWxldGVkIG9ubHkgd2hlbg0KdGhlIGxhc3QgbWVt
YmVyIGxlYXZlcy4NCg0KRml4ZXM6IGI2NDc0N2VmMjk1MSAoIm5ldC96eGRoOiBmaXggTUFDIGNv
bmZpZ3VyYXRpb24gZmFpbHVyZSIpDQpDYzogc3RhYmxlQGRwZGsub3JnDQoNClNpZ25lZC1vZmYt
Ynk6IEp1bmxvbmcgV2FuZyA8d2FuZy5qdW5sb25nMUB6dGUuY29tLmNuPg0KLS0tDQogZHJpdmVy
cy9uZXQvenhkaC96eGRoX3RhYmxlcy5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvenhkaC96
eGRoX3RhYmxlcy5jIGIvZHJpdmVycy9uZXQvenhkaC96eGRoX3RhYmxlcy5jDQppbmRleCAyMzNk
NTNhN2U4Li5lNWE1Y2M2M2RhIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvenhkaC96eGRoX3Rh
Ymxlcy5jDQorKysgYi9kcml2ZXJzL25ldC96eGRoL3p4ZGhfdGFibGVzLmMNCkBAIC0zNDksNyAr
MzQ5LDcgQEAgenhkaF9kZWxfbWFjX3RhYmxlKHN0cnVjdCB6eGRoX2h3ICpodywgdWludDE2X3Qg
dnBvcnQsIHN0cnVjdCBydGVfZXRoZXJfYWRkciAqYWQNCiAJc3RydWN0IHp4ZGhfbWFjX211bHRp
Y2FzdF90YWJsZSBtdWx0aWNhc3RfdGFibGUgPSB7MH07DQogCXVuaW9uIHp4ZGhfdmlycG9ydF9u
dW0gdnBvcnRfbnVtID0gKHVuaW9uIHp4ZGhfdmlycG9ydF9udW0pdnBvcnQ7DQogCXVpbnQxNl90
IHZmaWQgPSB6eGRoX3Zwb3J0X3RvX3ZmaWQodnBvcnRfbnVtKTsNCi0JdWludDE2X3QgZGVsX2Zs
YWcsIGdyb3VwX2lkID0gMDsNCisJdWludDE2X3QgZGVsX2ZsYWcgPSAwLCBncm91cF9pZCA9IDA7
DQogCWludDMyX3QgcmV0ID0gMDsNCiANCiAJaWYgKHJ0ZV9pc191bmljYXN0X2V0aGVyX2FkZHIo
YWRkcikpIHsNCi0tIA0KMi4yNy4w


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

enhkaF9kZWxfbWFjX3RhYmxlKCkmbmJzcDtkZWNpZGVzJm5ic3A7d2hldGhlciZuYnNwO2EmbmJz
cDttdWx0aWNhc3QmbmJzcDthZGRyZXNzJm5ic3A7c3RpbGwmbmJzcDtoYXM8YnIgLz5zdWJzY3Jp
YmVycyZuYnNwO3dpdGgmbmJzcDtkZWxfZmxhZywmbmJzcDtidXQmbmJzcDt0aGUmbmJzcDtmbGFn
Jm5ic3A7aGFzJm5ic3A7bm8mbmJzcDtpbml0aWFsaXNlciZuYnNwO2FuZCZuYnNwO2lzPGJyIC8+
b25seSZuYnNwO2V2ZXImbmJzcDthc3NpZ25lZCZuYnNwOzEuJm5ic3A7VGhlJm5ic3A7bG9vcCZu
YnNwO3RoYXQmbmJzcDt3YWxrcyZuYnNwO3RoZSZuYnNwO2dyb3VwJm5ic3A7ZW50cmllcyZuYnNw
O2JyZWFrczxiciAvPm91dCZuYnNwO2FzJm5ic3A7c29vbiZuYnNwO2FzJm5ic3A7aXQmbmJzcDtm
aW5kcyZuYnNwO29uZSZuYnNwO3RoYXQmbmJzcDtzdGlsbCZuYnNwO2hhcyZuYnNwO21lbWJlcnMs
Jm5ic3A7bGVhdmluZyZuYnNwO2RlbF9mbGFnPGJyIC8+dW53cml0dGVuOyZuYnNwO2F0Jm5ic3A7
LU8xJm5ic3A7YW5kJm5ic3A7YWJvdmUsJm5ic3A7aW5jbHVkaW5nJm5ic3A7dGhlJm5ic3A7ZGVm
YXVsdCZuYnNwOy1PMiZuYnNwO2J1aWxkLCZuYnNwO3RoZTxiciAvPmNvbXBpbGVyJm5ic3A7cmVz
b2x2ZXMmbmJzcDt0aGUmbmJzcDtzdWJzZXF1ZW50Jm5ic3A7dGVzdCZuYnNwO3RvJm5ic3A7dHJ1
ZSwmbmJzcDtzbyZuYnNwO3RoZSZuYnNwO2RlbGV0ZSZuYnNwO2xvb3A8YnIgLz5hbHdheXMmbmJz
cDtydW5zLjxiciAvPg08YnIgLz5XaGVuZXZlciZuYnNwO29uZSZuYnNwO3BvcnQmbmJzcDt0aGVy
ZWZvcmUmbmJzcDtsZWF2ZXMmbmJzcDthJm5ic3A7c2hhcmVkJm5ic3A7bXVsdGljYXN0Jm5ic3A7
YWRkcmVzcywmbmJzcDt0aGU8YnIgLz5lbnRyaWVzJm5ic3A7aG9sZGluZyZuYnNwO3RoZSZuYnNw
O1BGJmFwb3M7cyZuYnNwO2FuZCZuYnNwO2V2ZXJ5Jm5ic3A7b3RoZXImbmJzcDtWRiZhcG9zO3Mm
bmJzcDttZW1iZXJzaGlwJm5ic3A7YXJlJm5ic3A7ZGVsZXRlZDxiciAvPnRvbzombmJzcDt0aGUm
bmJzcDtQRiZuYnNwO2FuZCZuYnNwO3NpYmxpbmcmbmJzcDtWRnMmbmJzcDtzaWxlbnRseSZuYnNw
O2xvc2UmbmJzcDt0aGVpciZuYnNwO211bHRpY2FzdCZuYnNwO3JlY2VwdGlvbiw8YnIgLz53aXRo
Jm5ic3A7bm8mbmJzcDthdHRhY2tlciZuYnNwO2ludm9sdmVkLjxiciAvPg08YnIgLz5SZXN0b3Jl
Jm5ic3A7dGhlJm5ic3A7bWlzc2luZyZuYnNwO2luaXRpYWxpc2VyLCZuYnNwO3NvJm5ic3A7dGhl
Jm5ic3A7ZW50cnkmbmJzcDtpcyZuYnNwO2RlbGV0ZWQmbmJzcDtvbmx5Jm5ic3A7d2hlbjxiciAv
PnRoZSZuYnNwO2xhc3QmbmJzcDttZW1iZXImbmJzcDtsZWF2ZXMuPGJyIC8+DTxiciAvPkZpeGVz
OiZuYnNwO2I2NDc0N2VmMjk1MSZuYnNwOygmcXVvdDtuZXQvenhkaDombmJzcDtmaXgmbmJzcDtN
QUMmbmJzcDtjb25maWd1cmF0aW9uJm5ic3A7ZmFpbHVyZSZxdW90Oyk8YnIgLz5DYzombmJzcDtz
dGFibGVAZHBkay5vcmc8YnIgLz4NPGJyIC8+U2lnbmVkLW9mZi1ieTombmJzcDtKdW5sb25nJm5i
c3A7V2FuZyZuYnNwOyZsdDt3YW5nLmp1bmxvbmcxQHp0ZS5jb20uY24mZ3Q7DTxiciAvPi0tLTxi
ciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgvenhkaF90YWJsZXMuYyZuYnNwO3wmbmJzcDsyJm5i
c3A7Ky08YnIgLz4mbmJzcDsxJm5ic3A7ZmlsZSZuYnNwO2NoYW5nZWQsJm5ic3A7MSZuYnNwO2lu
c2VydGlvbigrKSwmbmJzcDsxJm5ic3A7ZGVsZXRpb24oLSk8YnIgLz4NPGJyIC8+ZGlmZiZuYnNw
Oy0tZ2l0Jm5ic3A7YS9kcml2ZXJzL25ldC96eGRoL3p4ZGhfdGFibGVzLmMmbmJzcDtiL2RyaXZl
cnMvbmV0L3p4ZGgvenhkaF90YWJsZXMuYzxiciAvPmluZGV4Jm5ic3A7MjMzZDUzYTdlOC4uZTVh
NWNjNjNkYSZuYnNwOzEwMDY0NDxiciAvPi0tLSZuYnNwO2EvZHJpdmVycy9uZXQvenhkaC96eGRo
X3RhYmxlcy5jPGJyIC8+KysrJm5ic3A7Yi9kcml2ZXJzL25ldC96eGRoL3p4ZGhfdGFibGVzLmM8
YnIgLz5AQCZuYnNwOy0zNDksNyZuYnNwOyszNDksNyZuYnNwO0BAJm5ic3A7enhkaF9kZWxfbWFj
X3RhYmxlKHN0cnVjdCZuYnNwO3p4ZGhfaHcmbmJzcDsqaHcsJm5ic3A7dWludDE2X3QmbmJzcDt2
cG9ydCwmbmJzcDtzdHJ1Y3QmbmJzcDtydGVfZXRoZXJfYWRkciZuYnNwOyphZDxiciAvPiZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3N0cnVjdCZuYnNwO3p4ZGhfbWFjX211bHRpY2FzdF90
YWJsZSZuYnNwO211bHRpY2FzdF90YWJsZSZuYnNwOz0mbmJzcDt7MH07PGJyIC8+Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7dW5pb24mbmJzcDt6eGRoX3ZpcnBvcnRfbnVtJm5ic3A7dnBv
cnRfbnVtJm5ic3A7PSZuYnNwOyh1bmlvbiZuYnNwO3p4ZGhfdmlycG9ydF9udW0pdnBvcnQ7PGJy
IC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7dWludDE2X3QmbmJzcDt2ZmlkJm5ic3A7
PSZuYnNwO3p4ZGhfdnBvcnRfdG9fdmZpZCh2cG9ydF9udW0pOzxiciAvPi0mbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDt1aW50MTZfdCZuYnNwO2RlbF9mbGFnLCZuYnNwO2dyb3VwX2lkJm5ic3A7PSZu
YnNwOzA7PGJyIC8+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3VpbnQxNl90Jm5ic3A7ZGVsX2Zs
YWcmbmJzcDs9Jm5ic3A7MCwmbmJzcDtncm91cF9pZCZuYnNwOz0mbmJzcDswOzxiciAvPiZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO2ludDMyX3QmbmJzcDtyZXQmbmJzcDs9Jm5ic3A7MDs8
YnIgLz4mbmJzcDsNPGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7aWYmbmJzcDso
cnRlX2lzX3VuaWNhc3RfZXRoZXJfYWRkcihhZGRyKSkmbmJzcDt7PGJyIC8+LS0mbmJzcDsNPGJy
IC8+Mi4yNy4wPGJyIC8+


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

