Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8789606A8B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 10:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=Vuxt0uK9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59F8A427A9;
	Thu, 12 Nov 2026 11:38:39 +0100 (CET)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
 by mails.dpdk.org (Postfix) with ESMTPS id 1F0D142797;
 Thu, 12 Nov 2026 11:38:36 +0100 (CET)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4jQH121G43z55y2H;
 Thu, 12 Nov 2026 18:38:30 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
 s=z202610; t=1794479910;
 bh=IhNTIHLhb7yJtqhleMe3cmxMXIyrWQ3p/wcfZhIlBlY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Vuxt0uK9Lw2engmWjy2J74zP0SSm2YbUKqSVR2zwCevLxlFIGO868hxGJBQV0GHE3
 yrCsUAF2L3ZrdWIU4wXjnTqzM6liKZIXEE/l2X/Yr6IVT30jde/BbXEDIULNhfLYLi
 +KCc4h4dg74SsJrpB7jHx/T31XvELdKWaowSEaQ/rjVbcGPvic+E3ddDJvFftW0G1I
 dhL3S/LaiDpTY4Eg7xbAwQX39/XZkRvdBhT2zq0U+wQ9tBGpJEy2CcgduemhoVFKgj
 0e6BGalg/ekgYMI0hQ7EDR2u2hPEa9F8Dh4bdVngT7BS7zvA8J/IpNy4sj/QRWKvzN
 L1DBiZroujABw==
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
 by mse-fl2.zte.com.cn with SMTP id 6ACAcGwG087668;
 Thu, 12 Nov 2026 18:38:16 +0800 (+08)
 (envelope-from wang.junlong1@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Thu, 12 Nov 2026 18:38:18 +0800
X-Zmail-TransId: 3e816af5971a02c-aa890
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: wang.junlong1@zte.com.cn
From: Junlong Wang <wang.junlong1@zte.com.cn>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, Junlong Wang <wang.junlong1@zte.com.cn>, stable@dpdk.org
Subject: [PATCH v2 4/8] net/zxdh: initialise multicast delete flag
Date: Thu, 12 Nov 2026 18:26:46 +0800
Message-ID: <20261112102650.3162875-5-wang.junlong1@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112102650.3162875-1-wang.junlong1@zte.com.cn>
References: <20261107030448.2891345-1-wang.junlong1@zte.com.cn>
 <20261112102650.3162875-1-wang.junlong1@zte.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn 6ACAcGwG087668
X-TLS: YES
X-ENVELOPE-SENDER: wang.junlong1@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 12 Nov 2026 18:38:30 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF59726.000/4jQH121G43z55y2H
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
bmUgdGhhdCBzdGlsbCBoYXMgbWVtYmVycywgbGVhdmluZyBkZWxfZmxhZw0KcmVhZCB1bmluaXRp
YWxpemVkLCBzbyB0aGUgZW50cnkgY2FuIGJlIGRlbGV0ZWQgd2hpbGUgb3RoZXIgbWVtYmVycw0K
cmVtYWluLg0KDQpXaGVuZXZlciBvbmUgcG9ydCB0aGVyZWZvcmUgbGVhdmVzIGEgc2hhcmVkIG11
bHRpY2FzdCBhZGRyZXNzLCB0aGUNCmVudHJpZXMgaG9sZGluZyB0aGUgUEYncyBhbmQgZXZlcnkg
b3RoZXIgVkYncyBtZW1iZXJzaGlwIGFyZSBkZWxldGVkDQp0b286IHRoZSBQRiBhbmQgc2libGlu
ZyBWRnMgc2lsZW50bHkgbG9zZSB0aGVpciBtdWx0aWNhc3QgcmVjZXB0aW9uLA0Kd2l0aCBubyBh
dHRhY2tlciBpbnZvbHZlZC4NCg0KUmVzdG9yZSB0aGUgbWlzc2luZyBpbml0aWFsaXNlciwgc28g
dGhlIGVudHJ5IGlzIGRlbGV0ZWQgb25seSB3aGVuDQp0aGUgbGFzdCBtZW1iZXIgbGVhdmVzLg0K
DQpGaXhlczogYjY0NzQ3ZWYyOTUxICgibmV0L3p4ZGg6IGZpeCBNQUMgY29uZmlndXJhdGlvbiBm
YWlsdXJlIikNCkNjOiBzdGFibGVAZHBkay5vcmcNCg0KU2lnbmVkLW9mZi1ieTogSnVubG9uZyBX
YW5nIDx3YW5nLmp1bmxvbmcxQHp0ZS5jb20uY24+DQotLS0NCiBkcml2ZXJzL25ldC96eGRoL3p4
ZGhfdGFibGVzLmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC96eGRoL3p4ZGhfdGFibGVzLmMg
Yi9kcml2ZXJzL25ldC96eGRoL3p4ZGhfdGFibGVzLmMNCmluZGV4IDIzM2Q1M2E3ZTguLmU1YTVj
YzYzZGEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC96eGRoL3p4ZGhfdGFibGVzLmMNCisrKyBi
L2RyaXZlcnMvbmV0L3p4ZGgvenhkaF90YWJsZXMuYw0KQEAgLTM0OSw3ICszNDksNyBAQCB6eGRo
X2RlbF9tYWNfdGFibGUoc3RydWN0IHp4ZGhfaHcgKmh3LCB1aW50MTZfdCB2cG9ydCwgc3RydWN0
IHJ0ZV9ldGhlcl9hZGRyICphZA0KIAlzdHJ1Y3QgenhkaF9tYWNfbXVsdGljYXN0X3RhYmxlIG11
bHRpY2FzdF90YWJsZSA9IHswfTsNCiAJdW5pb24genhkaF92aXJwb3J0X251bSB2cG9ydF9udW0g
PSAodW5pb24genhkaF92aXJwb3J0X251bSl2cG9ydDsNCiAJdWludDE2X3QgdmZpZCA9IHp4ZGhf
dnBvcnRfdG9fdmZpZCh2cG9ydF9udW0pOw0KLQl1aW50MTZfdCBkZWxfZmxhZywgZ3JvdXBfaWQg
PSAwOw0KKwl1aW50MTZfdCBkZWxfZmxhZyA9IDAsIGdyb3VwX2lkID0gMDsNCiAJaW50MzJfdCBy
ZXQgPSAwOw0KIA0KIAlpZiAocnRlX2lzX3VuaWNhc3RfZXRoZXJfYWRkcihhZGRyKSkgew0KLS0g
DQoyLjI3LjA=


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
Jm5ic3A7bGVhdmluZyZuYnNwO2RlbF9mbGFnPGJyIC8+cmVhZCZuYnNwO3VuaW5pdGlhbGl6ZWQs
Jm5ic3A7c28mbmJzcDt0aGUmbmJzcDtlbnRyeSZuYnNwO2NhbiZuYnNwO2JlJm5ic3A7ZGVsZXRl
ZCZuYnNwO3doaWxlJm5ic3A7b3RoZXImbmJzcDttZW1iZXJzPGJyIC8+cmVtYWluLjxiciAvPg08
YnIgLz5XaGVuZXZlciZuYnNwO29uZSZuYnNwO3BvcnQmbmJzcDt0aGVyZWZvcmUmbmJzcDtsZWF2
ZXMmbmJzcDthJm5ic3A7c2hhcmVkJm5ic3A7bXVsdGljYXN0Jm5ic3A7YWRkcmVzcywmbmJzcDt0
aGU8YnIgLz5lbnRyaWVzJm5ic3A7aG9sZGluZyZuYnNwO3RoZSZuYnNwO1BGJmFwb3M7cyZuYnNw
O2FuZCZuYnNwO2V2ZXJ5Jm5ic3A7b3RoZXImbmJzcDtWRiZhcG9zO3MmbmJzcDttZW1iZXJzaGlw
Jm5ic3A7YXJlJm5ic3A7ZGVsZXRlZDxiciAvPnRvbzombmJzcDt0aGUmbmJzcDtQRiZuYnNwO2Fu
ZCZuYnNwO3NpYmxpbmcmbmJzcDtWRnMmbmJzcDtzaWxlbnRseSZuYnNwO2xvc2UmbmJzcDt0aGVp
ciZuYnNwO211bHRpY2FzdCZuYnNwO3JlY2VwdGlvbiw8YnIgLz53aXRoJm5ic3A7bm8mbmJzcDth
dHRhY2tlciZuYnNwO2ludm9sdmVkLjxiciAvPg08YnIgLz5SZXN0b3JlJm5ic3A7dGhlJm5ic3A7
bWlzc2luZyZuYnNwO2luaXRpYWxpc2VyLCZuYnNwO3NvJm5ic3A7dGhlJm5ic3A7ZW50cnkmbmJz
cDtpcyZuYnNwO2RlbGV0ZWQmbmJzcDtvbmx5Jm5ic3A7d2hlbjxiciAvPnRoZSZuYnNwO2xhc3Qm
bmJzcDttZW1iZXImbmJzcDtsZWF2ZXMuPGJyIC8+DTxiciAvPkZpeGVzOiZuYnNwO2I2NDc0N2Vm
Mjk1MSZuYnNwOygmcXVvdDtuZXQvenhkaDombmJzcDtmaXgmbmJzcDtNQUMmbmJzcDtjb25maWd1
cmF0aW9uJm5ic3A7ZmFpbHVyZSZxdW90Oyk8YnIgLz5DYzombmJzcDtzdGFibGVAZHBkay5vcmc8
YnIgLz4NPGJyIC8+U2lnbmVkLW9mZi1ieTombmJzcDtKdW5sb25nJm5ic3A7V2FuZyZuYnNwOyZs
dDt3YW5nLmp1bmxvbmcxQHp0ZS5jb20uY24mZ3Q7DTxiciAvPi0tLTxiciAvPiZuYnNwO2RyaXZl
cnMvbmV0L3p4ZGgvenhkaF90YWJsZXMuYyZuYnNwO3wmbmJzcDsyJm5ic3A7Ky08YnIgLz4mbmJz
cDsxJm5ic3A7ZmlsZSZuYnNwO2NoYW5nZWQsJm5ic3A7MSZuYnNwO2luc2VydGlvbigrKSwmbmJz
cDsxJm5ic3A7ZGVsZXRpb24oLSk8YnIgLz4NPGJyIC8+ZGlmZiZuYnNwOy0tZ2l0Jm5ic3A7YS9k
cml2ZXJzL25ldC96eGRoL3p4ZGhfdGFibGVzLmMmbmJzcDtiL2RyaXZlcnMvbmV0L3p4ZGgvenhk
aF90YWJsZXMuYzxiciAvPmluZGV4Jm5ic3A7MjMzZDUzYTdlOC4uZTVhNWNjNjNkYSZuYnNwOzEw
MDY0NDxiciAvPi0tLSZuYnNwO2EvZHJpdmVycy9uZXQvenhkaC96eGRoX3RhYmxlcy5jPGJyIC8+
KysrJm5ic3A7Yi9kcml2ZXJzL25ldC96eGRoL3p4ZGhfdGFibGVzLmM8YnIgLz5AQCZuYnNwOy0z
NDksNyZuYnNwOyszNDksNyZuYnNwO0BAJm5ic3A7enhkaF9kZWxfbWFjX3RhYmxlKHN0cnVjdCZu
YnNwO3p4ZGhfaHcmbmJzcDsqaHcsJm5ic3A7dWludDE2X3QmbmJzcDt2cG9ydCwmbmJzcDtzdHJ1
Y3QmbmJzcDtydGVfZXRoZXJfYWRkciZuYnNwOyphZDxiciAvPiZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwO3N0cnVjdCZuYnNwO3p4ZGhfbWFjX211bHRpY2FzdF90YWJsZSZuYnNwO211bHRp
Y2FzdF90YWJsZSZuYnNwOz0mbmJzcDt7MH07PGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7dW5pb24mbmJzcDt6eGRoX3ZpcnBvcnRfbnVtJm5ic3A7dnBvcnRfbnVtJm5ic3A7PSZu
YnNwOyh1bmlvbiZuYnNwO3p4ZGhfdmlycG9ydF9udW0pdnBvcnQ7PGJyIC8+Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7dWludDE2X3QmbmJzcDt2ZmlkJm5ic3A7PSZuYnNwO3p4ZGhfdnBv
cnRfdG9fdmZpZCh2cG9ydF9udW0pOzxiciAvPi0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt1aW50
MTZfdCZuYnNwO2RlbF9mbGFnLCZuYnNwO2dyb3VwX2lkJm5ic3A7PSZuYnNwOzA7PGJyIC8+KyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwO3VpbnQxNl90Jm5ic3A7ZGVsX2ZsYWcmbmJzcDs9Jm5ic3A7
MCwmbmJzcDtncm91cF9pZCZuYnNwOz0mbmJzcDswOzxiciAvPiZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwO2ludDMyX3QmbmJzcDtyZXQmbmJzcDs9Jm5ic3A7MDs8YnIgLz4mbmJzcDsNPGJy
IC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7aWYmbmJzcDsocnRlX2lzX3VuaWNhc3Rf
ZXRoZXJfYWRkcihhZGRyKSkmbmJzcDt7PGJyIC8+LS0mbmJzcDsNPGJyIC8+Mi4yNy4wPGJyIC8+

--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

