Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0698BC83F1B
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Jul 2025 15:41:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42CE74028B;
	Thu, 10 Jul 2025 17:41:35 +0200 (CEST)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
 by mails.dpdk.org (Postfix) with ESMTP id 610B1400D6;
 Thu, 10 Jul 2025 17:41:33 +0200 (CEST)
Received: by mxct.zte.com.cn (FangMail, from userid 0)
 id 4bdJwm1JbYz5B1Jw; Thu, 10 Jul 2025 23:41:28 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4bdCJ71868z4yBmm;
 Thu, 10 Jul 2025 19:27:51 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
 by mse-fl2.zte.com.cn with SMTP id 56ABQqCM078654;
 Thu, 10 Jul 2025 19:26:52 +0800 (+08)
 (envelope-from wang.junlong1@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Thu, 10 Jul 2025 19:26:54 +0800
X-Zmail-TransId: 3e81686fa37a001-1bcd1
X-Zmail-RealSender: wang.junlong1@zte.com.cn
From: Junlong Wang <wang.junlong1@zte.com.cn>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, Junlong Wang <wang.junlong1@zte.com.cn>, stable@dpdk.org
Subject: [PATCH v2 1/6] net/zxdh: fix meson.build issues in compilation
Date: Thu, 10 Jul 2025 19:19:25 +0800
Message-ID: <20250710111926.517171-1-wang.junlong1@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707055621.357606-1-wang.junlong1@zte.com.cn>
References: <20250707055621.357606-1-wang.junlong1@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn 56ABQqCM078654
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 686FDF25.602/4bdCJ71868z4yBmm
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

Zml4IG1lc29uLmJ1aWxkIGlzc3VlcyBpbiBjb21waWxhdGlvbiwgd2hpY2gNCmNhdXNlZCB0aGUg
aW5hYmlsaXR5IHRvIGNvbXBpbGUgaW4gdGhlIGFybTY0IGVudmlyb25tZW50Lg0KDQpGaXhlczog
MjllODkyODhmZjE0ICgibmV0L3p4ZGg6IGFkZCBkcml2ZXIgc2tlbGV0b24iKQ0KQ2M6IHN0YWJs
ZUBkcGRrLm9yZw0KDQpTaWduZWQtb2ZmLWJ5OiBKdW5sb25nIFdhbmcgPHdhbmcuanVubG9uZzFA
enRlLmNvbS5jbj4NCi0tLQ0KIGRyaXZlcnMvbmV0L3p4ZGgvbWVzb24uYnVpbGQgfCAyICstDQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC96eGRoL21lc29uLmJ1aWxkIGIvZHJpdmVycy9uZXQvenhkaC9tZXNv
bi5idWlsZA0KaW5kZXggYTQ4YTBkNDNjMi4uZWM3MTQ1MWE1NSAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvbmV0L3p4ZGgvbWVzb24uYnVpbGQNCisrKyBiL2RyaXZlcnMvbmV0L3p4ZGgvbWVzb24uYnVp
bGQNCkBAIC03LDcgKzcsNyBAQCBpZiBub3QgaXNfbGludXgNCiAgICAgc3ViZGlyX2RvbmUoKQ0K
IGVuZGlmDQogDQotaWYgbm90IGRwZGtfY29uZi5oYXMoJ1JURV9BUkNIX1g4Nl82NCcpIG9yIG5v
dCBkcGRrX2NvbmYuZ2V0KCdSVEVfQVJDSF82NCcpDQoraWYgYXJjaF9zdWJkaXIgIT0gJ3g4Nicg
YW5kIGFyY2hfc3ViZGlyICE9ICdhcm0nIG9yIG5vdCBkcGRrX2NvbmYuZ2V0KCdSVEVfQVJDSF82
NCcpDQogICAgIGJ1aWxkID0gZmFsc2UNCiAgICAgcmVhc29uID0gJ29ubHkgc3VwcG9ydGVkIG9u
IHg4Nl82NCBhbmQgYWFyY2g2NCcNCiAgICAgc3ViZGlyX2RvbmUoKQ0KLS0gDQoyLjI3LjA=


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

Zml4Jm5ic3A7bWVzb24uYnVpbGQmbmJzcDtpc3N1ZXMmbmJzcDtpbiZuYnNwO2NvbXBpbGF0aW9u
LCZuYnNwO3doaWNoPGJyIC8+Y2F1c2VkJm5ic3A7dGhlJm5ic3A7aW5hYmlsaXR5Jm5ic3A7dG8m
bmJzcDtjb21waWxlJm5ic3A7aW4mbmJzcDt0aGUmbmJzcDthcm02NCZuYnNwO2Vudmlyb25tZW50
LjxiciAvPg08YnIgLz5GaXhlczombmJzcDsyOWU4OTI4OGZmMTQmbmJzcDsoJnF1b3Q7bmV0L3p4
ZGg6Jm5ic3A7YWRkJm5ic3A7ZHJpdmVyJm5ic3A7c2tlbGV0b24mcXVvdDspPGJyIC8+Q2M6Jm5i
c3A7c3RhYmxlQGRwZGsub3JnPGJyIC8+DTxiciAvPlNpZ25lZC1vZmYtYnk6Jm5ic3A7SnVubG9u
ZyZuYnNwO1dhbmcmbmJzcDsmbHQ7d2FuZy5qdW5sb25nMUB6dGUuY29tLmNuJmd0Ow08YnIgLz4t
LS08YnIgLz4mbmJzcDtkcml2ZXJzL25ldC96eGRoL21lc29uLmJ1aWxkJm5ic3A7fCZuYnNwOzIm
bmJzcDsrLTxiciAvPiZuYnNwOzEmbmJzcDtmaWxlJm5ic3A7Y2hhbmdlZCwmbmJzcDsxJm5ic3A7
aW5zZXJ0aW9uKCspLCZuYnNwOzEmbmJzcDtkZWxldGlvbigtKTxiciAvPg08YnIgLz5kaWZmJm5i
c3A7LS1naXQmbmJzcDthL2RyaXZlcnMvbmV0L3p4ZGgvbWVzb24uYnVpbGQmbmJzcDtiL2RyaXZl
cnMvbmV0L3p4ZGgvbWVzb24uYnVpbGQ8YnIgLz5pbmRleCZuYnNwO2E0OGEwZDQzYzIuLmVjNzE0
NTFhNTUmbmJzcDsxMDA2NDQ8YnIgLz4tLS0mbmJzcDthL2RyaXZlcnMvbmV0L3p4ZGgvbWVzb24u
YnVpbGQ8YnIgLz4rKysmbmJzcDtiL2RyaXZlcnMvbmV0L3p4ZGgvbWVzb24uYnVpbGQ8YnIgLz5A
QCZuYnNwOy03LDcmbmJzcDsrNyw3Jm5ic3A7QEAmbmJzcDtpZiZuYnNwO25vdCZuYnNwO2lzX2xp
bnV4PGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7c3ViZGlyX2RvbmUoKTxiciAv
PiZuYnNwO2VuZGlmPGJyIC8+Jm5ic3A7DTxiciAvPi1pZiZuYnNwO25vdCZuYnNwO2RwZGtfY29u
Zi5oYXMoJmFwb3M7UlRFX0FSQ0hfWDg2XzY0JmFwb3M7KSZuYnNwO29yJm5ic3A7bm90Jm5ic3A7
ZHBka19jb25mLmdldCgmYXBvcztSVEVfQVJDSF82NCZhcG9zOyk8YnIgLz4raWYmbmJzcDthcmNo
X3N1YmRpciZuYnNwOyE9Jm5ic3A7JmFwb3M7eDg2JmFwb3M7Jm5ic3A7YW5kJm5ic3A7YXJjaF9z
dWJkaXImbmJzcDshPSZuYnNwOyZhcG9zO2FybSZhcG9zOyZuYnNwO29yJm5ic3A7bm90Jm5ic3A7
ZHBka19jb25mLmdldCgmYXBvcztSVEVfQVJDSF82NCZhcG9zOyk8YnIgLz4mbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDtidWlsZCZuYnNwOz0mbmJzcDtmYWxzZTxiciAvPiZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwO3JlYXNvbiZuYnNwOz0mbmJzcDsmYXBvcztvbmx5Jm5ic3A7c3Vw
cG9ydGVkJm5ic3A7b24mbmJzcDt4ODZfNjQmbmJzcDthbmQmbmJzcDthYXJjaDY0JmFwb3M7DTxi
ciAvPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3N1YmRpcl9kb25lKCk8YnIgLz4tLSZu
YnNwOw08YnIgLz4yLjI3LjA8YnIgLz4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

