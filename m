Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27DBC71157
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 12:11:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71DE142D7F;
	Wed, 18 Jun 2025 14:11:27 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id 8C872427E6
 for <dev@dpdk.org>; Wed, 18 Jun 2025 14:11:25 +0200 (CEST)
X-QQ-mid: esmtpgz13t1750248676td968d376
X-QQ-Originating-IP: rwRke3o/cI/9WbGblC1rQR0Xt/dnO9k8mRLT5G5ToGo=
Received: from localhost.localdomain ( [203.174.112.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 18 Jun 2025 20:11:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15863247692666215263
EX-QQ-RecipientCnt: 4
From: Wenbo Cao <caowenbo@mucse.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	yaojun@mucse.com,
	Wenbo Cao <caowenbo@mucse.com>
Subject: [PATCH v0 0/3] [v0]drivers/net fixed Coverity issue
Date: Wed, 18 Jun 2025 20:11:10 +0800
Message-Id: <20250618121113.17302-1-caowenbo@mucse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: NR3PJyWXADsZSoBDU6xD6jZt7xVJhcQKZvxzm3f/ObFzy9RXQzx/tAQK
 6/csDZluNn1dxIV44dIO18mVdsd0LCKJP+rs6/bxHbNodjSKwwISnjmV46AG1NZ0+uW/xhz
 RKVqfUlJdOnagw8bCQvmh6Q91TtMbsTIOLZGmvEQn72xFoUw7bMpt1sRtprC0Nn5faRtH6h
 EUch7N788OdoIiLhhRqs/PizYIPj0cA5bTUlJ10Kkk/3Ab+xZuaw9ya9QJM5yKEWrzmKRq4
 pQB4SgvFVpaFSTU8HJ7DF+alNTqDeRlQ69vVIOnk6LHF+bOz5jzAqVl94uyPq5B3li5A+YJ
 6ib0aXN6hRZ5NRwy90ght9tlnaQYtHRd3FWBqv6CQLywAa9fmNalxMYHDHPX1vjm8hQW+wZ
 YuP1TJ9v+KGCKqRDIFpsHHvEGq03DbwxqZgMDLbapvJkQm5cd6kiqh+OEHHP66MRGjGoYes
 /3KNpUZszw0RYFxX8KPr3KWBab+VAVtuWj0EqJmkvpf0VPqPq8J6xfmuCUkt1RWvTctFC9N
 oljpoYDOyBfI8sKQMXAs7eQoF5fHcGryd4+q7sV4pvpC7uFJcbOO7i8Lpo62Xc+gvCq5swd
 PN/7VTUdeJksV/LPbpb9GtWaLXbJJGz1g/2yAicOMjMHDmRUZD21KRzHLsq/PqFlZVMeeRN
 gMxYQQBRxbsAKNE6WNNCRzAkqmS1Rl3vvBlcSB+OxSrRW3nY0vEPaBPH5in5pAC07s6Porv
 QDQuzUmjCMG9ZBdwrK4SyF/BVh2Gwi4KlYC55L6ZJgLpHUZFi+yt00fiL9IpJf4u2L9/v4D
 v4OdeFszXv0WzjA7UpqBDqmEe7ZnCKDzyoqfdD30YCk0Dkbc06lOxiht66XZSc6Qgr3NqeQ
 F/6OkmZEalN/fQaEUJnL2l9qVGqlPwyME7uiy7lUd0c5aAWNTpEiGouXShlObbcDNHVqsd8
 dNslK+KxED5XB82T9lq0ANNZDsHlPdTxMbqzzdIXg3Hb6Jof2Sp7YlB2ZDwdqa+As9rU4r1
 5wizWyQiu1oNBYXu2XJBqesCVygLxHTf7xTDjbJjiUKLtj5JTmG2dxzOMrWXFvgFzhVzaIr
 UZnrqmyegQ2spc6ogESVJI3ZvpR7Tct03XuHg8YuF79
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0
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

v1:
  *:fixed compile issue
v0:
  *:fixed the below issue:
  	Coverity issue: 468860,468866,468858
	Fixes: 4530e70f1e32 ("net/rnp: support Tx TSO offload")
	Fixes: 52dfb84e14be ("net/rnp: add device init and uninit")
	Fixes: 52aae4ed4ffb ("net/rnp: add device capabilities")
  *:fixed 64k tso

Wenbo Cao (3):
  net/rnp: add check firmware respond info
  net/rnp: fix Tunnel-TSO VLAN header untrusted loop bound
  net/rnp: fix TSO segmentation for packets of 64KB

 drivers/net/rnp/base/rnp_fw_cmd.h |   1 +
 drivers/net/rnp/base/rnp_mbx_fw.c |  15 +++-
 drivers/net/rnp/rnp_ethdev.c      |  16 ++--
 drivers/net/rnp/rnp_rxtx.c        | 118 +++++++++++++++++++++++-------
 drivers/net/rnp/rnp_rxtx.h        |   1 +
 5 files changed, 117 insertions(+), 34 deletions(-)

-- 
2.25.1

