Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC8A606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 10:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=Y0u1JYBy
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECB6141140;
	Thu, 12 Nov 2026 11:38:29 +0100 (CET)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
 by mails.dpdk.org (Postfix) with ESMTPS id 0AFB2410EA;
 Thu, 12 Nov 2026 11:38:28 +0100 (CET)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jQH0x6DrXz4yjjD;
 Thu, 12 Nov 2026 18:38:25 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
 s=z202610; t=1794479905;
 bh=RueH1bh8169ML5jBMc4KCMs2qR6JtVGhuvvc24w9nSw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Y0u1JYByQciE9bJ5yXkuIaT2Sb9LYZoONd/pPfZlbmKyvZItw1ODT13UxaMn+SoEK
 moPi+jYvVv4s63nT3kee4YX+X5UdOHR+TxlJO325bkiFmG2W3LFQyAecsTV/TeYeuE
 aCfw8lplfzR7WAiRXmmMVQiXIwBV1dtGBeDda+M8JZb+o2VSL18IaWfyMxZWaSY/Qr
 iLY0CXy6yqh+M9zMosSc4dlRYOIwpc92Xh9T5XJ4wXTjeC7GxdEqAxfcmEG5DB0Kq4
 az1LN7EinVw6kqUjRhpB1FqyOGU3tsmvCrriryHpbZlph/RntqCUJFJF4idpQU2Ftd
 vN/4sbXRAkeXQ==
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
 by mse-fl1.zte.com.cn with SMTP id 6ACAcGfn094335;
 Thu, 12 Nov 2026 18:38:16 +0800 (+08)
 (envelope-from wang.junlong1@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Thu, 12 Nov 2026 18:38:19 +0800
X-Zmail-TransId: 3e816af5971b02c-aa899
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: wang.junlong1@zte.com.cn
From: Junlong Wang <wang.junlong1@zte.com.cn>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, Junlong Wang <wang.junlong1@zte.com.cn>, stable@dpdk.org
Subject: [PATCH v2 5/8] net/zxdh: free receive buffer on the async no-ack exit
Date: Thu, 12 Nov 2026 18:26:47 +0800
Message-ID: <20261112102650.3162875-6-wang.junlong1@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112102650.3162875-1-wang.junlong1@zte.com.cn>
References: <20261107030448.2891345-1-wang.junlong1@zte.com.cn>
 <20261112102650.3162875-1-wang.junlong1@zte.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 6ACAcGfn094335
X-TLS: YES
X-ENVELOPE-SENDER: wang.junlong1@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 12 Nov 2026 18:38:25 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF59721.000/4jQH0x6DrXz4yjjD
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

enhkaF9iYXJfaXJxX3JlY3YoKSBhbGxvY2F0ZXMgYSBidWZmZXIgZm9yIHRoZSBwYXlsb2FkIG9m
IGV2ZXJ5DQptZXNzYWdlIGl0IHRha2VzIG9mZiB0aGUgQkFSIGNoYW5uZWwgYW5kIGZyZWVzIGl0
IG9uIHR3byBvZiBpdHMgdGhyZWUNCmV4aXRzLiBUaGUgdGhpcmQgZXhpdCwgdGFrZW4gd2hlbiB0
aGUgaGVhZGVyIGlzIG1hcmtlZCBhc3luY2hyb25vdXMNCmFuZCBub3QgYW4gYWNrLCByZXR1cm5z
IHdpdGggdGhlIGJ1ZmZlciBzdGlsbCBhbGxvY2F0ZWQuIFRob3NlIHR3bw0KaGVhZGVyIGJpdHMg
YXJlIHdyaXR0ZW4gYnkgdGhlIFZGIGl0c2VsZiwgc28gYSBndWVzdCBjYW4gcGluIGFib3V0DQoy
MTc2IGJ5dGVzIG9mIHRoZSBwcm9jZXNzLXdpZGUgcnRlX21hbGxvYyBoZWFwIHBlciBtZXNzYWdl
LCB3aXRoIG5vDQpwZXItVkYgYWNjb3VudGluZywgdW50aWwgdGhlIGhlYXAgaXMgZnVsbDogdGhl
IFBGIHRoZW4gc3RvcHMNCmFuc3dlcmluZyBtYWlsYm94IHJlcXVlc3RzIGZyb20gZXZlcnkgVkYg
YW5kIGl0cyBvd24gdGFibGUgdXBkYXRlcw0KZmFpbCB1bnRpbCB0aGUgcHJvY2VzcyBpcyByZXN0
YXJ0ZWQuDQoNClJvdXRlIHRoYXQgcGF0aCB0aHJvdWdoIHRoZSBleGlzdGluZyBleGl0IGxhYmVs
IHNvIHRoZSBidWZmZXIgaXMNCmZyZWVkIGxpa2Ugb24gdGhlIG90aGVyIHR3byBwYXRocy4gVGhl
IHJldHVybiB2YWx1ZSBpcyB1bmNoYW5nZWQNCihaWERIX0JBUl9NU0dfT0sgaXMgMCkgYW5kIHN5
bmNocm9ub3VzIGFuZCBhY2tlZCBtZXNzYWdlcyBhcmUNCnVudG91Y2hlZC4NCg0KRml4ZXM6IDM2
MzBhYzhiZDgxZiAoIm5ldC96eGRoOiBjb25maWd1cmUgaW50ZXJydXB0IikNCkNjOiBzdGFibGVA
ZHBkay5vcmcNCg0KU2lnbmVkLW9mZi1ieTogSnVubG9uZyBXYW5nIDx3YW5nLmp1bmxvbmcxQHp0
ZS5jb20uY24+DQotLS0NCiBkcml2ZXJzL25ldC96eGRoL3p4ZGhfbXNnLmMgfCA1ICstLS0tDQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvenhkaC96eGRoX21zZy5jIGIvZHJpdmVycy9uZXQvenhkaC96eGRo
X21zZy5jDQppbmRleCA2YWFmZWZlMjg5Li5jN2EzMjgxOTg3IDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9uZXQvenhkaC96eGRoX21zZy5jDQorKysgYi9kcml2ZXJzL25ldC96eGRoL3p4ZGhfbXNnLmMN
CkBAIC0xMDIzLDExICsxMDIzLDggQEAgenhkaF9iYXJfaXJxX3JlY3YodWludDhfdCBzcmMsIHVp
bnQ4X3QgZHN0LCB1aW50NjRfdCB2aXJ0X2FkZHIsIHZvaWQgKmRldikNCiAJCWdvdG8gZXhpdDsN
CiAJfQ0KIAl6eGRoX2Jhcl9jaGFuX21zZ192YWxpZF9zZXQocmVjdl9hZGRyLCBaWERIX0JBUl9N
U0dfQ0hBTl9VU0FCTEUpOw0KLQlpZiAobXNnX2hlYWRlci5hY2sgPT0gWlhESF9CQVJfQ0hBTl9N
U0dfQUNLKSB7DQorCWlmIChtc2dfaGVhZGVyLmFjayA9PSBaWERIX0JBUl9DSEFOX01TR19BQ0sp
DQogCQl6eGRoX2Jhcl9tc2dfYWNrX2FzeW5jX21zZ19wcm9jKCZtc2dfaGVhZGVyLCByZWN2ZWRf
bXNnKTsNCi0JCWdvdG8gZXhpdDsNCi0JfQ0KLQlyZXR1cm4gMDsNCiANCiBleGl0Og0KIAlydGVf
ZnJlZShyZWN2ZWRfbXNnKTsNCi0tIA0KMi4yNy4w


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

enhkaF9iYXJfaXJxX3JlY3YoKSZuYnNwO2FsbG9jYXRlcyZuYnNwO2EmbmJzcDtidWZmZXImbmJz
cDtmb3ImbmJzcDt0aGUmbmJzcDtwYXlsb2FkJm5ic3A7b2YmbmJzcDtldmVyeTxiciAvPm1lc3Nh
Z2UmbmJzcDtpdCZuYnNwO3Rha2VzJm5ic3A7b2ZmJm5ic3A7dGhlJm5ic3A7QkFSJm5ic3A7Y2hh
bm5lbCZuYnNwO2FuZCZuYnNwO2ZyZWVzJm5ic3A7aXQmbmJzcDtvbiZuYnNwO3R3byZuYnNwO29m
Jm5ic3A7aXRzJm5ic3A7dGhyZWU8YnIgLz5leGl0cy4mbmJzcDtUaGUmbmJzcDt0aGlyZCZuYnNw
O2V4aXQsJm5ic3A7dGFrZW4mbmJzcDt3aGVuJm5ic3A7dGhlJm5ic3A7aGVhZGVyJm5ic3A7aXMm
bmJzcDttYXJrZWQmbmJzcDthc3luY2hyb25vdXM8YnIgLz5hbmQmbmJzcDtub3QmbmJzcDthbiZu
YnNwO2FjaywmbmJzcDtyZXR1cm5zJm5ic3A7d2l0aCZuYnNwO3RoZSZuYnNwO2J1ZmZlciZuYnNw
O3N0aWxsJm5ic3A7YWxsb2NhdGVkLiZuYnNwO1Rob3NlJm5ic3A7dHdvPGJyIC8+aGVhZGVyJm5i
c3A7Yml0cyZuYnNwO2FyZSZuYnNwO3dyaXR0ZW4mbmJzcDtieSZuYnNwO3RoZSZuYnNwO1ZGJm5i
c3A7aXRzZWxmLCZuYnNwO3NvJm5ic3A7YSZuYnNwO2d1ZXN0Jm5ic3A7Y2FuJm5ic3A7cGluJm5i
c3A7YWJvdXQ8YnIgLz4yMTc2Jm5ic3A7Ynl0ZXMmbmJzcDtvZiZuYnNwO3RoZSZuYnNwO3Byb2Nl
c3Mtd2lkZSZuYnNwO3J0ZV9tYWxsb2MmbmJzcDtoZWFwJm5ic3A7cGVyJm5ic3A7bWVzc2FnZSwm
bmJzcDt3aXRoJm5ic3A7bm88YnIgLz5wZXItVkYmbmJzcDthY2NvdW50aW5nLCZuYnNwO3VudGls
Jm5ic3A7dGhlJm5ic3A7aGVhcCZuYnNwO2lzJm5ic3A7ZnVsbDombmJzcDt0aGUmbmJzcDtQRiZu
YnNwO3RoZW4mbmJzcDtzdG9wczxiciAvPmFuc3dlcmluZyZuYnNwO21haWxib3gmbmJzcDtyZXF1
ZXN0cyZuYnNwO2Zyb20mbmJzcDtldmVyeSZuYnNwO1ZGJm5ic3A7YW5kJm5ic3A7aXRzJm5ic3A7
b3duJm5ic3A7dGFibGUmbmJzcDt1cGRhdGVzPGJyIC8+ZmFpbCZuYnNwO3VudGlsJm5ic3A7dGhl
Jm5ic3A7cHJvY2VzcyZuYnNwO2lzJm5ic3A7cmVzdGFydGVkLjxiciAvPg08YnIgLz5Sb3V0ZSZu
YnNwO3RoYXQmbmJzcDtwYXRoJm5ic3A7dGhyb3VnaCZuYnNwO3RoZSZuYnNwO2V4aXN0aW5nJm5i
c3A7ZXhpdCZuYnNwO2xhYmVsJm5ic3A7c28mbmJzcDt0aGUmbmJzcDtidWZmZXImbmJzcDtpczxi
ciAvPmZyZWVkJm5ic3A7bGlrZSZuYnNwO29uJm5ic3A7dGhlJm5ic3A7b3RoZXImbmJzcDt0d28m
bmJzcDtwYXRocy4mbmJzcDtUaGUmbmJzcDtyZXR1cm4mbmJzcDt2YWx1ZSZuYnNwO2lzJm5ic3A7
dW5jaGFuZ2VkPGJyIC8+KFpYREhfQkFSX01TR19PSyZuYnNwO2lzJm5ic3A7MCkmbmJzcDthbmQm
bmJzcDtzeW5jaHJvbm91cyZuYnNwO2FuZCZuYnNwO2Fja2VkJm5ic3A7bWVzc2FnZXMmbmJzcDth
cmU8YnIgLz51bnRvdWNoZWQuPGJyIC8+DTxiciAvPkZpeGVzOiZuYnNwOzM2MzBhYzhiZDgxZiZu
YnNwOygmcXVvdDtuZXQvenhkaDombmJzcDtjb25maWd1cmUmbmJzcDtpbnRlcnJ1cHQmcXVvdDsp
PGJyIC8+Q2M6Jm5ic3A7c3RhYmxlQGRwZGsub3JnPGJyIC8+DTxiciAvPlNpZ25lZC1vZmYtYnk6
Jm5ic3A7SnVubG9uZyZuYnNwO1dhbmcmbmJzcDsmbHQ7d2FuZy5qdW5sb25nMUB6dGUuY29tLmNu
Jmd0Ow08YnIgLz4tLS08YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL3p4ZGhfbXNnLmMmbmJz
cDt8Jm5ic3A7NSZuYnNwOystLS0tPGJyIC8+Jm5ic3A7MSZuYnNwO2ZpbGUmbmJzcDtjaGFuZ2Vk
LCZuYnNwOzEmbmJzcDtpbnNlcnRpb24oKyksJm5ic3A7NCZuYnNwO2RlbGV0aW9ucygtKTxiciAv
Pg08YnIgLz5kaWZmJm5ic3A7LS1naXQmbmJzcDthL2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9tc2cu
YyZuYnNwO2IvZHJpdmVycy9uZXQvenhkaC96eGRoX21zZy5jPGJyIC8+aW5kZXgmbmJzcDs2YWFm
ZWZlMjg5Li5jN2EzMjgxOTg3Jm5ic3A7MTAwNjQ0PGJyIC8+LS0tJm5ic3A7YS9kcml2ZXJzL25l
dC96eGRoL3p4ZGhfbXNnLmM8YnIgLz4rKysmbmJzcDtiL2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9t
c2cuYzxiciAvPkBAJm5ic3A7LTEwMjMsMTEmbmJzcDsrMTAyMyw4Jm5ic3A7QEAmbmJzcDt6eGRo
X2Jhcl9pcnFfcmVjdih1aW50OF90Jm5ic3A7c3JjLCZuYnNwO3VpbnQ4X3QmbmJzcDtkc3QsJm5i
c3A7dWludDY0X3QmbmJzcDt2aXJ0X2FkZHIsJm5ic3A7dm9pZCZuYnNwOypkZXYpPGJyIC8+Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Z290byZu
YnNwO2V4aXQ7PGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fTxiciAvPiZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3p4ZGhfYmFyX2NoYW5fbXNnX3ZhbGlkX3NldChyZWN2
X2FkZHIsJm5ic3A7WlhESF9CQVJfTVNHX0NIQU5fVVNBQkxFKTs8YnIgLz4tJm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7aWYmbmJzcDsobXNnX2hlYWRlci5hY2smbmJzcDs9PSZuYnNwO1pYREhfQkFS
X0NIQU5fTVNHX0FDSykmbmJzcDt7PGJyIC8+KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO2lmJm5i
c3A7KG1zZ19oZWFkZXIuYWNrJm5ic3A7PT0mbmJzcDtaWERIX0JBUl9DSEFOX01TR19BQ0spPGJy
IC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
enhkaF9iYXJfbXNnX2Fja19hc3luY19tc2dfcHJvYygmYW1wO21zZ19oZWFkZXIsJm5ic3A7cmVj
dmVkX21zZyk7PGJyIC8+LSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwO2dvdG8mbmJzcDtleGl0OzxiciAvPi0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt9PGJy
IC8+LSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3JldHVybiZuYnNwOzA7PGJyIC8+Jm5ic3A7DTxi
ciAvPiZuYnNwO2V4aXQ6PGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7cnRlX2Zy
ZWUocmVjdmVkX21zZyk7PGJyIC8+LS0mbmJzcDsNPGJyIC8+Mi4yNy4wPGJyIC8+


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

