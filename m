Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40489C0219D
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 07:40:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F5534060B;
	Sat,  8 Feb 2025 08:40:22 +0100 (CET)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
 by mails.dpdk.org (Postfix) with ESMTP id 2DE6F402EE
 for <dev@dpdk.org>; Sat,  8 Feb 2025 08:40:18 +0100 (CET)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4YqjRd6cStz8R041
 for <dev@dpdk.org>; Sat,  8 Feb 2025 15:40:13 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
 by mse-fl1.zte.com.cn with SMTP id 5187dxS5040152
 for <dev@dpdk.org>; Sat, 8 Feb 2025 15:39:59 +0800 (+08)
 (envelope-from li.hanxiao@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Sat, 8 Feb 2025 15:40:01 +0800
X-Zmail-TransId: 3e8167a70a51004-0384f
From: Hanxiao Li <li.hanxiao@zte.com.cn>
To: dev@dpdk.org
Cc: Hanxiao Li <li.hanxiao@zte.com.cn>
Subject: [PATCH v26 01/13] config: add zsda device number
Date: Sat,  8 Feb 2025 15:27:17 +0800
Message-ID: <20250208072732.4008334-2-li.hanxiao@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208072732.4008334-1-li.hanxiao@zte.com.cn>
References: <20250122093325.3099070-2-li.hanxiao@zte.com.cn>
 <20250208072732.4008334-1-li.hanxiao@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 5187dxS5040152
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67A70A5D.001/4YqjRd6cStz8R041
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

QWRkIHRoZSBudW1iZXIgb2YgenNkYSBkZXZpY2VzLg0KDQpTaWduZWQtb2ZmLWJ5OiBIYW54aWFv
IExpIDxsaS5oYW54aWFvQHp0ZS5jb20uY24+DQotLS0NCiBjb25maWcvcnRlX2NvbmZpZy5oIHwg
NCArKysrDQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEv
Y29uZmlnL3J0ZV9jb25maWcuaCBiL2NvbmZpZy9ydGVfY29uZmlnLmgNCmluZGV4IDM3MzRkYjZi
ZGMuLjg2ODk3ZGU3NWUgMTAwNjQ0DQotLS0gYS9jb25maWcvcnRlX2NvbmZpZy5oDQorKysgYi9j
b25maWcvcnRlX2NvbmZpZy5oDQpAQCAtMTE5LDYgKzExOSwxMCBAQA0KICNkZWZpbmUgUlRFX1BN
RF9RQVRfQ09NUF9TR0xfTUFYX1NFR01FTlRTIDE2DQogI2RlZmluZSBSVEVfUE1EX1FBVF9DT01Q
X0lNX0JVRkZFUl9TSVpFIDY1NTM2DQogDQorLyogWlNEQSBkZXZpY2UgKi8NCisvKiBNYXguIG51
bWJlciBvZiBaU0RBIGRldmljZXMgd2hpY2ggY2FuIGJlIGF0dGFjaGVkICovDQorI2RlZmluZSBS
VEVfUE1EX1pTREFfTUFYX1BDSV9ERVZJQ0VTIDI1Ng0KKw0KIC8qIHZpcnRpbyBjcnlwdG8gZGVm
aW5lcyAqLw0KICNkZWZpbmUgUlRFX01BWF9WSVJUSU9fQ1JZUFRPIDMyDQogDQotLSANCjIuMjcu
MA==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

QWRkJm5ic3A7dGhlJm5ic3A7bnVtYmVyJm5ic3A7b2YmbmJzcDt6c2RhJm5ic3A7ZGV2aWNlcy48
YnIgLz4NPGJyIC8+U2lnbmVkLW9mZi1ieTombmJzcDtIYW54aWFvJm5ic3A7TGkmbmJzcDsmbHQ7
bGkuaGFueGlhb0B6dGUuY29tLmNuJmd0Ow08YnIgLz4tLS08YnIgLz4mbmJzcDtjb25maWcvcnRl
X2NvbmZpZy5oJm5ic3A7fCZuYnNwOzQmbmJzcDsrKysrPGJyIC8+Jm5ic3A7MSZuYnNwO2ZpbGUm
bmJzcDtjaGFuZ2VkLCZuYnNwOzQmbmJzcDtpbnNlcnRpb25zKCspPGJyIC8+DTxiciAvPmRpZmYm
bmJzcDstLWdpdCZuYnNwO2EvY29uZmlnL3J0ZV9jb25maWcuaCZuYnNwO2IvY29uZmlnL3J0ZV9j
b25maWcuaDxiciAvPmluZGV4Jm5ic3A7MzczNGRiNmJkYy4uODY4OTdkZTc1ZSZuYnNwOzEwMDY0
NDxiciAvPi0tLSZuYnNwO2EvY29uZmlnL3J0ZV9jb25maWcuaDxiciAvPisrKyZuYnNwO2IvY29u
ZmlnL3J0ZV9jb25maWcuaDxiciAvPkBAJm5ic3A7LTExOSw2Jm5ic3A7KzExOSwxMCZuYnNwO0BA
PGJyIC8+Jm5ic3A7I2RlZmluZSZuYnNwO1JURV9QTURfUUFUX0NPTVBfU0dMX01BWF9TRUdNRU5U
UyZuYnNwOzE2PGJyIC8+Jm5ic3A7I2RlZmluZSZuYnNwO1JURV9QTURfUUFUX0NPTVBfSU1fQlVG
RkVSX1NJWkUmbmJzcDs2NTUzNjxiciAvPiZuYnNwOw08YnIgLz4rLyombmJzcDtaU0RBJm5ic3A7
ZGV2aWNlJm5ic3A7Ki88YnIgLz4rLyombmJzcDtNYXguJm5ic3A7bnVtYmVyJm5ic3A7b2YmbmJz
cDtaU0RBJm5ic3A7ZGV2aWNlcyZuYnNwO3doaWNoJm5ic3A7Y2FuJm5ic3A7YmUmbmJzcDthdHRh
Y2hlZCZuYnNwOyovPGJyIC8+KyNkZWZpbmUmbmJzcDtSVEVfUE1EX1pTREFfTUFYX1BDSV9ERVZJ
Q0VTJm5ic3A7MjU2PGJyIC8+KzxiciAvPiZuYnNwOy8qJm5ic3A7dmlydGlvJm5ic3A7Y3J5cHRv
Jm5ic3A7ZGVmaW5lcyZuYnNwOyovPGJyIC8+Jm5ic3A7I2RlZmluZSZuYnNwO1JURV9NQVhfVklS
VElPX0NSWVBUTyZuYnNwOzMyPGJyIC8+Jm5ic3A7DTxiciAvPi0tJm5ic3A7DTxiciAvPjIuMjcu
MDxiciAvPg==


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

