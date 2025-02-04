Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA8DC02193
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 16:24:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB08040F16;
	Tue,  4 Feb 2025 17:23:03 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3FC294042C
 for <dev@dpdk.org>; Tue,  4 Feb 2025 17:22:49 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id AFC2F210C317; Tue,  4 Feb 2025 08:22:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AFC2F210C317
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738686167;
 bh=oLu7UWExVKp69S7C/lob/OoLtIJfTcLoLkvoKiCP8Rs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Xam4frqYx22AckxF/L2QW0aOlJ3thawkIa0wnyU9ryc2AdyzIyA3ipfPqmXT3Cjw1
 w4jBviqfwSmH7a8ANqDDf24F5nx6TbDROMBYPTfwGpyjVo7r6+T6yBmi30kwkxDTwc
 Z2K4/FctWo9BjU7SRGVASdAXdmv/NED1vboIH210=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com
Subject: [PATCH v20 10/27] net/ixgbe: remove use of VLAs
Date: Tue,  4 Feb 2025 08:21:47 -0800
Message-Id: <1738686124-16173-11-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738686124-16173-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738686124-16173-1-git-send-email-andremue@linux.microsoft.com>
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

From: Konstantin Ananyev <konstantin.ananyev@huawei.com>

1) ../drivers/net/ixgbe/ixgbe_ethdev.c:3556:46: warning:
    variable length array used [-Wvla]
2) ../drivers/net/ixgbe/ixgbe_ethdev.c:3739:23: warning:
    variable length array used [-Wvla]
3) ../drivers/net/ixgbe/ixgbe_rxtx_vec_common.h:17:24: warning:
    variable length array used [-Wvla]

For first two cases: in fact ixgbe_xstats_calc_num() always returns
constant value, so it should be safe to replace that function invocation
just with a macro that performs same calculations.

For case #3: reassemble_packets() is invoked only by
ixgbe_recv_scattered_burst_vec().
And in turn, ixgbe_recv_scattered_burst_vec() operates only on fixed
max amount of packets per call: RTE_IXGBE_MAX_RX_BURST.
So, it should be safe to replace VLA with fixed size array.

Signed-off-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 5f18fbaad5..c79ecd6eec 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -3437,11 +3437,16 @@ ixgbe_dev_stats_reset(struct rte_eth_dev *dev)
 }
 
 /* This function calculates the number of xstats based on the current config */
+
+#define IXGBE_XSTATS_CALC_NUM	\
+	(IXGBE_NB_HW_STATS + IXGBE_NB_MACSEC_STATS + \
+	(IXGBE_NB_RXQ_PRIO_STATS * IXGBE_NB_RXQ_PRIO_VALUES) + \
+	(IXGBE_NB_TXQ_PRIO_STATS * IXGBE_NB_TXQ_PRIO_VALUES))
+
 static unsigned
-ixgbe_xstats_calc_num(void) {
-	return IXGBE_NB_HW_STATS + IXGBE_NB_MACSEC_STATS +
-		(IXGBE_NB_RXQ_PRIO_STATS * IXGBE_NB_RXQ_PRIO_VALUES) +
-		(IXGBE_NB_TXQ_PRIO_STATS * IXGBE_NB_TXQ_PRIO_VALUES);
+ixgbe_xstats_calc_num(void)
+{
+	return IXGBE_XSTATS_CALC_NUM;
 }
 
 static int ixgbe_dev_xstats_get_names(__rte_unused struct rte_eth_dev *dev,
@@ -3557,8 +3562,8 @@ static int ixgbe_dev_xstats_get_names_by_id(
 	}
 
 	uint16_t i;
-	uint16_t size = ixgbe_xstats_calc_num();
-	struct rte_eth_xstat_name xstats_names_copy[size];
+	struct rte_eth_xstat_name xstats_names_copy[IXGBE_XSTATS_CALC_NUM];
+	const uint16_t size = RTE_DIM(xstats_names_copy);
 
 	ixgbe_dev_xstats_get_names_by_id(dev, NULL, xstats_names_copy,
 			size);
@@ -3740,8 +3745,8 @@ ixgbe_dev_xstats_get_by_id(struct rte_eth_dev *dev, const uint64_t *ids,
 	}
 
 	uint16_t i;
-	uint16_t size = ixgbe_xstats_calc_num();
-	uint64_t values_copy[size];
+	uint64_t values_copy[IXGBE_XSTATS_CALC_NUM];
+	const uint16_t size = RTE_DIM(values_copy);
 
 	ixgbe_dev_xstats_get_by_id(dev, NULL, values_copy, size);
 
-- 
2.47.2.vfs.0.1

