Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548CFCD98ED
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 08:17:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACBA440FDE;
	Wed, 17 Jun 2026 10:15:32 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id DB0C140E54;
 Wed, 17 Jun 2026 10:15:29 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1781684126t4dc1b511
X-QQ-Originating-IP: sou5c4TxS1aqz9iJj14USdQcPqH65s+RvEwh3DmHDNo=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 16:15:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14753426094180086999
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v8 20/21] net/txgbe: fix to enable Tx desc check
Date: Wed, 17 Jun 2026 16:13:07 +0800
Message-Id: <20260617081309.19124-21-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617081309.19124-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260617081309.19124-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OSjQccS6YHkHzHYx5CmG4FfAQpBYbm+7LGyCvnfuxR/6iDVvInWcCLqq
 bu2t5xF7gUBCkVSGhXyP3BhO0bJ8sHFWWkf5ENE4MI40YfKZHeW169jPyQuKQjYc37fFuUn
 9+/G1VEOqsf/2NodFbR90wMs2MIUNLeai0kL2FAI783OegsTQs2Bc4VVs5I8xCjpOlUiyVe
 sAiOZFemtpKwRx/Jd8IkpZzgwy+2ipk/9Ge+3oNTkbbMPgFafyiwIgkI85lpZCPC2IuH/Wx
 9ysTwe3YfWm0x/p2EqRreGkNdmB/NpcPz1B5n+1R68d0Hxly1Flk1Ff5bIkC86Gn2ZEsBaa
 LYvYFPCllXbDcvICkK53aofTrYRCsNilwTPY+EZTemUv6HIjbKfNt9vVUpuMkkb4JWvY7s1
 ZTU9MhEoD5I8pmUcrxyExY9NWpV8hJ4pJ4gWEvoUIDQlvB7zg14j0QFxzRQHE76ZWVUvei2
 JpLGvZfmUhEEa2Cnq/iQONlC6i0SGzAoGS7lAeAWmDhHixZXcB4zG884hFCrmDj30hzodYd
 6xAdtGkLg4gwQ/fNiAxXhAwmSWbj7K7tbZBm9R/tag2soatJmJjrhqqt62Qbb192R+HbHXf
 ZYEkh8c3RDjIg0glnIN+yHiTMv6oyyYA1moh/4JodDj6MjpG9lEdW+upEwyFLl9+2RWChiG
 qyJy97wkK3GwNC3MI1BfAlVMyde64RT7x2IgNrbxhsceoEih848YVvq6SC04vfJ9h3Sn24J
 eiNEBktaeqRraZC9iAHg2yHYkaQr4ZwyiAYGgiJfzpCGMiZb/nPdlX+FTeLWaAXJmYleNaD
 As/UlB6MKsoJ9F+7CMFDuOOrYRXJZe1/Oqzw16n6DphpNeY8Ulc/oYnXXYIDywAABzLVzyt
 36Hi7S1MA5YL/kZAarb20MVTskS3sP46aqJ8CSHohNqAHiG8tsxoN46r6B/6M9wfEApt9L5
 rXNt9A/YOUvbxTsPAxZZ1x3kpgZIqUNmJ+mTQgT9OOpfVsI0EvmxinVRXdOz9DuqqzfzPQp
 Qx/T0nnZOQoSQ3wiQKkx0QLq2nRsYN1nOQXgekUXsCnCDtJpsvJvMmvSU0WsIWBPo+UotT3
 KZaJqgs68Hic2Zy5IaRKvk=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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

Now lib security is enabled by default, and cannot be disabled if the
driver is intended to be used. So Tdm_desc_chk is always unable to enable.
Remove this restriction, and just enable the corresponding queue check.

Fixes: 0eabdfcd4af4 ("net/txgbe: enable Tx descriptor error interrupt")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/txgbe_rxtx.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index 0a9fc3ddfd..f51c6193a9 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -4761,6 +4761,12 @@ txgbe_dev_tx_init(struct rte_eth_dev *dev)
 		wr32(hw, TXGBE_TXRP(txq->reg_idx), 0);
 		wr32(hw, TXGBE_TXWP(txq->reg_idx), 0);
 
+#ifdef RTE_LIB_SECURITY
+		if (!txq->using_ipsec)
+#endif
+			wr32m(hw, TXGBE_TDM_DESC_CHK(txq->reg_idx / 32),
+			      RTE_BIT32(txq->reg_idx % 32), RTE_BIT32(txq->reg_idx % 32));
+
 		if (txq->headwb_mem) {
 			uint32_t txdctl;
 
@@ -4778,11 +4784,6 @@ txgbe_dev_tx_init(struct rte_eth_dev *dev)
 		}
 	}
 
-#ifndef RTE_LIB_SECURITY
-	for (i = 0; i < 4; i++)
-		wr32(hw, TXGBE_TDM_DESC_CHK(i), 0xFFFFFFFF);
-#endif
-
 	/* Device configured with multiple TX queues. */
 	txgbe_dev_mq_tx_configure(dev);
 }
-- 
2.21.0.windows.1

