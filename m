Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BB5C71157
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 11:05:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9AAD042D2B;
	Wed, 18 Jun 2025 13:05:30 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id 20D36427E6
 for <dev@dpdk.org>; Wed, 18 Jun 2025 13:05:26 +0200 (CEST)
X-QQ-mid: esmtpgz10t1750244721t10745142
X-QQ-Originating-IP: F/IAlN+o+7S8BT3xbUO52RxOtnV++QZpmMMgmaO9hAM=
Received: from localhost.localdomain ( [203.174.112.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 18 Jun 2025 19:05:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10823971345831428772
EX-QQ-RecipientCnt: 4
From: Wenbo Cao <caowenbo@mucse.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	yaojun@mucse.com,
	Wenbo Cao <caowenbo@mucse.com>
Subject: [PATCH v0 0/3] [v0]drivers/net fixed Coverity issue
Date: Wed, 18 Jun 2025 19:05:13 +0800
Message-Id: <20250618110516.90113-1-caowenbo@mucse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: Np+AlqyfvJHVh7rZoWjhrbLDwszbv9HK5oAN66mqdoxy4Jn6wViROj2p
 fcxLET2Ob+xtrKetNpXshTCCank0aK3aa01yq9eVWHAFrZ5gi2D2bOArc7vHO4VHp7Dgr0N
 l/0liD6Nie0ZdywPeCw4l7DJvbyG+dPQqGzZLqrPiEVSU/ceEALFG6WsoTTIq98OW1u2dGe
 PVKT2ynhTO4FV8wwKTmqLf3czuhzov5c3OZh16jEggG9BNSjR+siaJOobrFow6XgdiBNBnm
 o9aE5xMto6X8hUfoP72N+WeD8umwjcQRbsQvf2yyjtjNJlkw7wpxRIAUNdNIIBBb296suub
 1WiNtnHR6VIIHD7AjeJzBP1ObV6sEB82Xqs7cO6qCL0HeGcRGe6PalCeztrIZ7HTmLsuKas
 3cCFRTxI6pGabXjQ0ZuEfX4rQwHfMs5XpCUiaYvMa+qd1G5HoqDXZffiOgr7MSW8c13fI+x
 gN0BDAyeB4ynfdbprnnm0k3jktbz77rKE3+ngyE9Lmrf+5aVan/C5C26YgEghTbKiPEgQNL
 ecRWvAdmbNobjbF/7OpkMEZIYKmg/eaCMkbFk5XxqOoY/MgZ1kgMQRXVSb/eIyp3wTFydpC
 xyqcxTSkWcCrSwjZw0vzCranunLiKE1/gKcT1K7pyU3OBko/mehKD3pLDpuDUJvSBoXHUyA
 ptHopfRcSCJTnNUURGps2Z47sNYh5F+CyT3/gkL7vX2sutoKD1EX2XHQHQeHD53Bg8YlnZL
 hSWn6X+uuLnA7lcS+ymIYH0SpyCVW3fZc9GFU5BzkayXupGTHQVe01ENM1BI7fOHrFeP89N
 9X1Trxi7rwU9k3Wp5j9Wv0MfF1tuutkBbFHP5TeUuQNqFv2gEmWdKTkgiAGAg0IPshlegKU
 uEX9zWOACwE9WH4QHMIKrYqxTbwMiNcXnk4GVVQIGkgSylhZLlFVebMmXX6v9+PMMlPFxoR
 AqXqB7r6UVpXZzlUSVULu7QD8D299r8hsc+NjCQrQ3sUa/EQ5NYFjFqUh
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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

This patchset primarily optimizes the robustness of code logic and
resolves anomalies in TSO segmentation.

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
 drivers/net/rnp/rnp_ethdev.c      |  16 ++---
 drivers/net/rnp/rnp_rxtx.c        | 110 ++++++++++++++++++++++++------
 drivers/net/rnp/rnp_rxtx.h        |   1 +
 5 files changed, 112 insertions(+), 31 deletions(-)

-- 
2.25.1

