Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54ECCD4F21
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 May 2026 02:28:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2F5B402B5;
	Thu, 14 May 2026 04:28:28 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
 by mails.dpdk.org (Postfix) with ESMTP id 2FFBA40657
 for <dev@dpdk.org>; Thu, 14 May 2026 04:28:28 +0200 (CEST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gGDlX4cLxz8Xs6v;
 Thu, 14 May 2026 10:28:24 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
 by mse-fl1.zte.com.cn with SMTP id 64E2SBsX016105;
 Thu, 14 May 2026 10:28:11 +0800 (+08)
 (envelope-from wang.junlong1@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Thu, 14 May 2026 10:28:12 +0800
X-Zmail-TransId: 3e816a05333c002-23b09
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: wang.junlong1@zte.com.cn
From: Junlong Wang <wang.junlong1@zte.com.cn>
To: thomas@monjalon.net, stephen@networkplumber.org
Cc: ran.ming@zte.com.cn, dev@dpdk.org, Junlong Wang <wang.junlong1@zte.com.cn>
Subject: [PATCH v1 2/2] net/zxdh: update zxdh Maintainers eamil
Date: Thu, 14 May 2026 09:56:50 +0800
Message-ID: <20260514015650.3500578-2-wang.junlong1@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514015650.3500578-1-wang.junlong1@zte.com.cn>
References: <20260514015650.3500578-1-wang.junlong1@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 64E2SBsX016105
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.junlong1@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Thu, 14 May 2026 10:28:24 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A053348.002/4gGDlX4cLxz8Xs6v
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

dXBkYXRlIHp4ZGggTWFpbnRhaW5lcnMgZWFtaWwuDQoNClNpZ25lZC1vZmYtYnk6IEp1bmxvbmcg
V2FuZyA8d2FuZy5qdW5sb25nMUB6dGUuY29tLmNuPg0KLS0tDQogTUFJTlRBSU5FUlMgfCAyICst
DQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYg
LS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQppbmRleCAwZjU1MzlmODUxLi5lZWIz
NTJmNmZlIDEwMDY0NA0KLS0tIGEvTUFJTlRBSU5FUlMNCisrKyBiL01BSU5UQUlORVJTDQpAQCAt
MTExMCw3ICsxMTEwLDcgQEAgRjogZG9jL2d1aWRlcy9uaWNzL2ZlYXR1cmVzL2F2cC5pbmkNCiAN
CiBaVEUgenhkaA0KIE06IEp1bmxvbmcgV2FuZyA8d2FuZy5qdW5sb25nMUB6dGUuY29tLmNuPg0K
LU06IExpamllIFNoYW4gPHNoYW4ubGlqaWVAenRlLmNvbS5jbj4NCitNOiBNaW5nIFJhbiA8cmFu
Lm1pbmdAenRlLmNvbS5jbj4NCiBGOiBkcml2ZXJzL25ldC96eGRoLw0KIEY6IGRvYy9ndWlkZXMv
bmljcy96eGRoLnJzdA0KIEY6IGRvYy9ndWlkZXMvbmljcy9mZWF0dXJlcy96eGRoLmluaQ0KLS0g
DQoyLjI3LjA=


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

dXBkYXRlJm5ic3A7enhkaCZuYnNwO01haW50YWluZXJzJm5ic3A7ZWFtaWwuPGJyIC8+DTxiciAv
PlNpZ25lZC1vZmYtYnk6Jm5ic3A7SnVubG9uZyZuYnNwO1dhbmcmbmJzcDsmbHQ7d2FuZy5qdW5s
b25nMUB6dGUuY29tLmNuJmd0Ow08YnIgLz4tLS08YnIgLz4mbmJzcDtNQUlOVEFJTkVSUyZuYnNw
O3wmbmJzcDsyJm5ic3A7Ky08YnIgLz4mbmJzcDsxJm5ic3A7ZmlsZSZuYnNwO2NoYW5nZWQsJm5i
c3A7MSZuYnNwO2luc2VydGlvbigrKSwmbmJzcDsxJm5ic3A7ZGVsZXRpb24oLSk8YnIgLz4NPGJy
IC8+ZGlmZiZuYnNwOy0tZ2l0Jm5ic3A7YS9NQUlOVEFJTkVSUyZuYnNwO2IvTUFJTlRBSU5FUlM8
YnIgLz5pbmRleCZuYnNwOzBmNTUzOWY4NTEuLmVlYjM1MmY2ZmUmbmJzcDsxMDA2NDQ8YnIgLz4t
LS0mbmJzcDthL01BSU5UQUlORVJTPGJyIC8+KysrJm5ic3A7Yi9NQUlOVEFJTkVSUzxiciAvPkBA
Jm5ic3A7LTExMTAsNyZuYnNwOysxMTEwLDcmbmJzcDtAQCZuYnNwO0Y6Jm5ic3A7ZG9jL2d1aWRl
cy9uaWNzL2ZlYXR1cmVzL2F2cC5pbmk8YnIgLz4mbmJzcDsNPGJyIC8+Jm5ic3A7WlRFJm5ic3A7
enhkaDxiciAvPiZuYnNwO006Jm5ic3A7SnVubG9uZyZuYnNwO1dhbmcmbmJzcDsmbHQ7d2FuZy5q
dW5sb25nMUB6dGUuY29tLmNuJmd0Ow08YnIgLz4tTTombmJzcDtMaWppZSZuYnNwO1NoYW4mbmJz
cDsmbHQ7c2hhbi5saWppZUB6dGUuY29tLmNuJmd0Ow08YnIgLz4rTTombmJzcDtNaW5nJm5ic3A7
UmFuJm5ic3A7Jmx0O3Jhbi5taW5nQHp0ZS5jb20uY24mZ3Q7DTxiciAvPiZuYnNwO0Y6Jm5ic3A7
ZHJpdmVycy9uZXQvenhkaC88YnIgLz4mbmJzcDtGOiZuYnNwO2RvYy9ndWlkZXMvbmljcy96eGRo
LnJzdDxiciAvPiZuYnNwO0Y6Jm5ic3A7ZG9jL2d1aWRlcy9uaWNzL2ZlYXR1cmVzL3p4ZGguaW5p
PGJyIC8+LS0mbmJzcDsNPGJyIC8+Mi4yNy4wPGJyIC8+


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

