Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC1A606A321
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=A3wj/pY5
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2485D40E15;
	Thu, 12 Nov 2026 11:38:26 +0100 (CET)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
 by mails.dpdk.org (Postfix) with ESMTPS id 82F6140297;
 Thu, 12 Nov 2026 11:38:23 +0100 (CET)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jQH0r5JlFz8Xrkn;
 Thu, 12 Nov 2026 18:38:20 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
 s=z202610; t=1794479900;
 bh=5nAT0TkrTDh6JUolj3dMrAelxjg0Lkh0Jy4/Ci1mlPQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=A3wj/pY506GrQRT6Aq+y9lRVTtfeay8Yfy9DlX+Kv7q2HDdr5aFchYziPASfWxUpT
 XFdDVgv5HTXaqjJsFKdqXwy13CQWa7Dx1IBBskLTMa5GRRYUfe53VuHeZlAib4dSDG
 uKrXFMIZuCVipCBTQhdQ+cdSxOZCpbfw+7VNijRr6iBgcxDqG15Ol8vUtansVFp0T8
 wDp4w7GQRLX7LnMDSoTLGmY35fkDwruObEyOJdXYnAtuQ3/KtKDxw5JHGVNQW7f3hM
 r/R4lPBtbyqyv6Fxhy9LsQ/Bjx32REwyWhWohDBbF6q29zGb0BIN3F80G3v3AidBBC
 HXpsek3k18h9Q==
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
 by mse-fl1.zte.com.cn with SMTP id 6ACAcDPc094304;
 Thu, 12 Nov 2026 18:38:13 +0800 (+08)
 (envelope-from wang.junlong1@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Thu, 12 Nov 2026 18:38:16 +0800
X-Zmail-TransId: 3e816af5971702c-aa876
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: wang.junlong1@zte.com.cn
From: Junlong Wang <wang.junlong1@zte.com.cn>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, Junlong Wang <wang.junlong1@zte.com.cn>, stable@dpdk.org
Subject: [PATCH v2 1/8] net/zxdh: reject out-of-range VLAN ID from VF
Date: Thu, 12 Nov 2026 18:26:43 +0800
Message-ID: <20261112102650.3162875-2-wang.junlong1@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112102650.3162875-1-wang.junlong1@zte.com.cn>
References: <20261107030448.2891345-1-wang.junlong1@zte.com.cn>
 <20261112102650.3162875-1-wang.junlong1@zte.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 6ACAcDPc094304
X-TLS: YES
X-ENVELOPE-SENDER: wang.junlong1@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 12 Nov 2026 18:38:20 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF5971C.000/4jQH0r5JlFz8Xrkn
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

VGhlIFBGIGhhbmRsZXIgZm9yIGEgVkYncyBaWERIX1ZMQU5fRklMVEVSX0FERC9ERUwgbWVzc2Fn
ZSBwYXNzZXMgdGhlDQoxNi1iaXQgdmxhbl9pZCBmcm9tIHRoZSBtZXNzYWdlIGJvZHkgdG8genhk
aF92bGFuX2ZpbHRlcl90YWJsZV9zZXQoKQ0Kd2l0aG91dCBhIHJhbmdlIGNoZWNrLiBBbiBpZCBh
Ym92ZSA0MDk1IGJlY29tZXMgYSByb3cgaW5kZXggb3V0c2lkZQ0KdGhlIFZMQU4gZmlsdGVyIGdy
b3VwcyB0aGUgUEYgc2V0cyB1cCBmb3IgdGhlIGZ1bmN0aW9uLCBhbmQgdGhlIE5QDQpsYXllciBi
ZWxvdyBvbmx5IGNoZWNrcyBpdCBhZ2FpbnN0IHRoZSBlbmQgb2YgdGhlIHdob2xlIEVSQU0sIHNv
IG9uZQ0KcmVxdWVzdCBmcm9tIGEgZ3Vlc3QgcmVhZHMsIG1vZGlmaWVzIGFuZCB3cml0ZXMgYmFj
ayB1bnJlbGF0ZWQgdGFibGUNCnJvd3MuDQoNClJlamVjdCBpZHMgYWJvdmUgUlRFX0VUSEVSX01B
WF9WTEFOX0lEIHdoZXJlIHRoZSB2YWx1ZSBpcyB0YWtlbiBvdXQgb2YNCnRoZSBtZXNzYWdlLiBW
YWxpZCBpZHMgYmVoYXZlIGFzIGJlZm9yZS4NCg0KRml4ZXM6IGI0Zjk5NmI3ZmNmNiAoIm5ldC96
eGRoOiBvcHRpbWl6ZSBWTEFOIGZpbHRlciBhbmQgb2ZmbG9hZCIpDQpDYzogc3RhYmxlQGRwZGsu
b3JnDQoNClNpZ25lZC1vZmYtYnk6IEp1bmxvbmcgV2FuZyA8d2FuZy5qdW5sb25nMUB6dGUuY29t
LmNuPg0KLS0tDQogZHJpdmVycy9uZXQvenhkaC96eGRoX21zZy5jIHwgNyArKysrKystDQogMSBm
aWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvenhkaC96eGRoX21zZy5jIGIvZHJpdmVycy9uZXQvenhkaC96eGRoX21z
Zy5jDQppbmRleCA0YjAxZGFmMzdhLi5mMGYwNTIyODE3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9u
ZXQvenhkaC96eGRoX21zZy5jDQorKysgYi9kcml2ZXJzL25ldC96eGRoL3p4ZGhfbXNnLmMNCkBA
IC0xNTUyLDcgKzE1NTIsMTIgQEAgenhkaF92Zl92bGFuX2ZpbHRlcl90YWJsZV9wcm9jZXNzKHN0
cnVjdCB6eGRoX2h3ICpodywgdWludDE2X3QgdnBvcnQsDQogCXZvaWQgKnJlcGx5X2RhdGFfYWRk
ciA9IFpYREhfQUREUl9PRihtc2dfcmVwbHlfYm9keSwgcmVzX2luZm8sIHJlcGx5X2RhdGEpOw0K
IAlpbnQgcmV0ID0gMDsNCiANCi0JcmV0ID0genhkaF92bGFuX2ZpbHRlcl90YWJsZV9zZXQoaHcs
IHZwb3J0LCB2bGFuX2lkLCBlbmFibGUpOw0KKwlpZiAodmxhbl9pZCA+IFJURV9FVEhFUl9NQVhf
VkxBTl9JRCkgew0KKwkJUE1EX0RSVl9MT0coRVJSLCAidmxhbiBpZCAlZCBpcyBpbnZhbGlkIiwg
dmxhbl9pZCk7DQorCQlyZXQgPSAtRUlOVkFMOw0KKwl9IGVsc2Ugew0KKwkJcmV0ID0genhkaF92
bGFuX2ZpbHRlcl90YWJsZV9zZXQoaHcsIHZwb3J0LCB2bGFuX2lkLCBlbmFibGUpOw0KKwl9DQog
CWlmIChyZXQpDQogCQlzcHJpbnRmKHN0ciwgInZsYW4gZmlsdGVyIG9wLWNvZGVbJWRdIHZsYW4g
aWQ6JWQgZmFpbGVkLCBjb2RlOiVkXG4iLA0KIAkJCWVuYWJsZSwgdmxhbl9pZCwgcmV0KTsNCi0t
IA0KMi4yNy4w


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

VGhlJm5ic3A7UEYmbmJzcDtoYW5kbGVyJm5ic3A7Zm9yJm5ic3A7YSZuYnNwO1ZGJmFwb3M7cyZu
YnNwO1pYREhfVkxBTl9GSUxURVJfQUREL0RFTCZuYnNwO21lc3NhZ2UmbmJzcDtwYXNzZXMmbmJz
cDt0aGU8YnIgLz4xNi1iaXQmbmJzcDt2bGFuX2lkJm5ic3A7ZnJvbSZuYnNwO3RoZSZuYnNwO21l
c3NhZ2UmbmJzcDtib2R5Jm5ic3A7dG8mbmJzcDt6eGRoX3ZsYW5fZmlsdGVyX3RhYmxlX3NldCgp
PGJyIC8+d2l0aG91dCZuYnNwO2EmbmJzcDtyYW5nZSZuYnNwO2NoZWNrLiZuYnNwO0FuJm5ic3A7
aWQmbmJzcDthYm92ZSZuYnNwOzQwOTUmbmJzcDtiZWNvbWVzJm5ic3A7YSZuYnNwO3JvdyZuYnNw
O2luZGV4Jm5ic3A7b3V0c2lkZTxiciAvPnRoZSZuYnNwO1ZMQU4mbmJzcDtmaWx0ZXImbmJzcDtn
cm91cHMmbmJzcDt0aGUmbmJzcDtQRiZuYnNwO3NldHMmbmJzcDt1cCZuYnNwO2ZvciZuYnNwO3Ro
ZSZuYnNwO2Z1bmN0aW9uLCZuYnNwO2FuZCZuYnNwO3RoZSZuYnNwO05QPGJyIC8+bGF5ZXImbmJz
cDtiZWxvdyZuYnNwO29ubHkmbmJzcDtjaGVja3MmbmJzcDtpdCZuYnNwO2FnYWluc3QmbmJzcDt0
aGUmbmJzcDtlbmQmbmJzcDtvZiZuYnNwO3RoZSZuYnNwO3dob2xlJm5ic3A7RVJBTSwmbmJzcDtz
byZuYnNwO29uZTxiciAvPnJlcXVlc3QmbmJzcDtmcm9tJm5ic3A7YSZuYnNwO2d1ZXN0Jm5ic3A7
cmVhZHMsJm5ic3A7bW9kaWZpZXMmbmJzcDthbmQmbmJzcDt3cml0ZXMmbmJzcDtiYWNrJm5ic3A7
dW5yZWxhdGVkJm5ic3A7dGFibGU8YnIgLz5yb3dzLjxiciAvPg08YnIgLz5SZWplY3QmbmJzcDtp
ZHMmbmJzcDthYm92ZSZuYnNwO1JURV9FVEhFUl9NQVhfVkxBTl9JRCZuYnNwO3doZXJlJm5ic3A7
dGhlJm5ic3A7dmFsdWUmbmJzcDtpcyZuYnNwO3Rha2VuJm5ic3A7b3V0Jm5ic3A7b2Y8YnIgLz50
aGUmbmJzcDttZXNzYWdlLiZuYnNwO1ZhbGlkJm5ic3A7aWRzJm5ic3A7YmVoYXZlJm5ic3A7YXMm
bmJzcDtiZWZvcmUuPGJyIC8+DTxiciAvPkZpeGVzOiZuYnNwO2I0Zjk5NmI3ZmNmNiZuYnNwOygm
cXVvdDtuZXQvenhkaDombmJzcDtvcHRpbWl6ZSZuYnNwO1ZMQU4mbmJzcDtmaWx0ZXImbmJzcDth
bmQmbmJzcDtvZmZsb2FkJnF1b3Q7KTxiciAvPkNjOiZuYnNwO3N0YWJsZUBkcGRrLm9yZzxiciAv
Pg08YnIgLz5TaWduZWQtb2ZmLWJ5OiZuYnNwO0p1bmxvbmcmbmJzcDtXYW5nJm5ic3A7Jmx0O3dh
bmcuanVubG9uZzFAenRlLmNvbS5jbiZndDsNPGJyIC8+LS0tPGJyIC8+Jm5ic3A7ZHJpdmVycy9u
ZXQvenhkaC96eGRoX21zZy5jJm5ic3A7fCZuYnNwOzcmbmJzcDsrKysrKystPGJyIC8+Jm5ic3A7
MSZuYnNwO2ZpbGUmbmJzcDtjaGFuZ2VkLCZuYnNwOzYmbmJzcDtpbnNlcnRpb25zKCspLCZuYnNw
OzEmbmJzcDtkZWxldGlvbigtKTxiciAvPg08YnIgLz5kaWZmJm5ic3A7LS1naXQmbmJzcDthL2Ry
aXZlcnMvbmV0L3p4ZGgvenhkaF9tc2cuYyZuYnNwO2IvZHJpdmVycy9uZXQvenhkaC96eGRoX21z
Zy5jPGJyIC8+aW5kZXgmbmJzcDs0YjAxZGFmMzdhLi5mMGYwNTIyODE3Jm5ic3A7MTAwNjQ0PGJy
IC8+LS0tJm5ic3A7YS9kcml2ZXJzL25ldC96eGRoL3p4ZGhfbXNnLmM8YnIgLz4rKysmbmJzcDti
L2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9tc2cuYzxiciAvPkBAJm5ic3A7LTE1NTIsNyZuYnNwOysx
NTUyLDEyJm5ic3A7QEAmbmJzcDt6eGRoX3ZmX3ZsYW5fZmlsdGVyX3RhYmxlX3Byb2Nlc3Moc3Ry
dWN0Jm5ic3A7enhkaF9odyZuYnNwOypodywmbmJzcDt1aW50MTZfdCZuYnNwO3Zwb3J0LDxiciAv
PiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3ZvaWQmbmJzcDsqcmVwbHlfZGF0YV9hZGRy
Jm5ic3A7PSZuYnNwO1pYREhfQUREUl9PRihtc2dfcmVwbHlfYm9keSwmbmJzcDtyZXNfaW5mbywm
bmJzcDtyZXBseV9kYXRhKTs8YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtpbnQm
bmJzcDtyZXQmbmJzcDs9Jm5ic3A7MDs8YnIgLz4mbmJzcDsNPGJyIC8+LSZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwO3JldCZuYnNwOz0mbmJzcDt6eGRoX3ZsYW5fZmlsdGVyX3RhYmxlX3NldChodywm
bmJzcDt2cG9ydCwmbmJzcDt2bGFuX2lkLCZuYnNwO2VuYWJsZSk7PGJyIC8+KyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwO2lmJm5ic3A7KHZsYW5faWQmbmJzcDsmZ3Q7Jm5ic3A7UlRFX0VUSEVSX01B
WF9WTEFOX0lEKSZuYnNwO3s8YnIgLz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7UE1EX0RSVl9MT0coRVJSLCZuYnNwOyZxdW90O3ZsYW4mbmJzcDtpZCZu
YnNwOyVkJm5ic3A7aXMmbmJzcDtpbnZhbGlkJnF1b3Q7LCZuYnNwO3ZsYW5faWQpOzxiciAvPism
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtyZXQmbmJzcDs9
Jm5ic3A7LUVJTlZBTDs8YnIgLz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fSZuYnNwO2Vsc2Um
bmJzcDt7PGJyIC8+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwO3JldCZuYnNwOz0mbmJzcDt6eGRoX3ZsYW5fZmlsdGVyX3RhYmxlX3NldChodywmbmJzcDt2
cG9ydCwmbmJzcDt2bGFuX2lkLCZuYnNwO2VuYWJsZSk7PGJyIC8+KyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwO308YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtpZiZuYnNwOyhyZXQp
PGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7c3ByaW50ZihzdHIsJm5ic3A7JnF1b3Q7dmxhbiZuYnNwO2ZpbHRlciZuYnNwO29wLWNvZGVb
JWRdJm5ic3A7dmxhbiZuYnNwO2lkOiVkJm5ic3A7ZmFpbGVkLCZuYnNwO2NvZGU6JWRcbiZxdW90
Oyw8YnIgLz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtlbmFibGUsJm5ic3A7dmxhbl9pZCwmbmJzcDty
ZXQpOzxiciAvPi0tJm5ic3A7DTxiciAvPjIuMjcuMDxiciAvPg==


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

