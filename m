Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68716606A329
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=lrFspWps
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8FFE402D1;
	Fri,  6 Nov 2026 11:55:55 +0100 (CET)
Received: from aer-iport-6.cisco.com (aer-iport-6.cisco.com [173.38.203.68])
 by mails.dpdk.org (Postfix) with ESMTPS id A16D44026A
 for <dev@dpdk.org>; Fri,  6 Nov 2026 10:25:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=3524; q=dns/txt;
 s=iport01; t=1793957116; x=1795166716;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wd71omOdXERchwn0PGhxTf3gFDmCPZU7KtNmlf3Uvck=;
 b=lrFspWpsHzHOQb8CqEhxoPN+HalN17pqEkyaxf7oHwMO26q4Auw6mEhh
 a5f+FxmMF9vD1pzIiOdkglGQRwh0pTVkcQmjlzfCgsq+3+cihQVkFMM3d
 +pmzAXft3yP/rLrB4LDLGXwFoMZe6peynoNp9rj+6O1pDdExxQRJsefwn
 jBaL3Kqy0zehxLXZGlbSmoST6Hy00nRz75cFlT0CfsPneWwbR9PNhMFBc
 HjOtyeJe3wBCN3VVAqT83oLBJ0a9HoW42btbHw/GSwoH/YO8DRrpP0Ir1
 VXMnR7L+3dlFXnoYsYTHajJeByFLSfbzftEJJ9lDhVFb0tmKxuRj+z9WY A==;
X-CSE-ConnectionGUID: k5fSvZImSuGnXMS8/BiekQ==
X-CSE-MsgGUID: aREmW3ryQXO13oMQfIDjVA==
X-IPAS-Result: =?us-ascii?q?A0BBAgBlm+1q/9JK/pBaglmCV4FVQ0mWS4tokjyBJANXD?=
 =?us-ascii?q?wEBAQ9RBAEBhQWOHwImNAkOAQIEAwIDAQEBAQEBAQEBAQEBCgEBBQEBAQIBB?=
 =?us-ascii?q?wWBDhOGXJAVKwsBRoEBPBODAoI7AzcDvDmBeTOBAYR+2EwNcoFoAQsUAYE4i?=
 =?us-ascii?q?D+FJIVzJxuBSUSBFYNpgh+IagSDLpBFhnlIgR4DWSwBVRMNCgsHBYFoAzUSK?=
 =?us-ascii?q?hVuMh2BIz4XgQcbBgWBHYEegRKBB12BKyhdASGBCIF2AoJRggACAUlBDgdFU?=
 =?us-ascii?q?wklQxJHJCIIEgkBExosCoEaNTwJJj8VDGQIAxoFQAIfCAINDHQ5EDAeJC8FH?=
 =?us-ascii?q?CY+GwovGA1IESw3FRkEPm4Hkj2DEQEBgQ6BQwhMASyTSweyCk1xhCqbYoV8G?=
 =?us-ascii?q?jOXYZMPAZkIkhSSR4RpgWg8OYEgMxoIGxWDIlMZD918RjI9AgcCBw4DC5NmA?=
 =?us-ascii?q?QE?=
IronPort-Data: A9a23:/pXjjqugJNSJJ/i8U0xPoUxZOefnVANfMUV32f8akzHdYApBsoF/q
 tZmKTvUbqmLamSgethzb4u19R4OuZ+Am943SwFsrC9nESoTgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0nrb/656yYsjclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuFZzdJ5xYuajhKsvvb9Us21BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 47r0LGj82rFyAwmA9Wjn6yTWhVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0NS+7vw60c+VZk
 72hg3AfpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn3bEm51T4E8K0YIw+bt5On981
 PkjNR8LXjW416Wcwb+4c7w57igjBJGD0II3s3x6iDWcBvE8TNWbEuPB5MRT23E7gcUm8fT2P
 pZFL2AyMFKfP1sVYw9/5JEWxI9EglH9bzpcrF+JjaE2+GPUigd21dABNfKIK4TXFZwPzi50o
 ErPxUn8PUoAJeWv7mPe9VeViM7jnx3SDdd6+LqQs6QCbEeo7mAeFjUaTVe45/6jhSaWUchCI
 EFS4CslraEo+FesSPH8WQG1pDiPuRt0ZjZLO+Q38kSJj6HT+QvcXjlCRT9aY9tgv8gzLdA36
 mK0cxrSLWQHmNWopbi1r994cRva1fApEFI/
IronPort-HdrOrdr: A9a23:/XvXvaFBP3bGJcFBpLqE3MeALOsnbusQ8zAXPo5KJSC9Ffbo9f
 xG88506faZslwssRIb6LO90cu7IE80nKQdieIs1NyZMzUO1lHEEGgb1+vf6gylPTHi/ehA0q
 olWa1/BNrsSWVet6/BkWyF+xJK+qjhzEhu7t2uq0tQcQ==
X-Talos-CUID: 9a23:RCQRAWwl25+xukEWy2kJBgUXR84ebE/8yUzNDEmILF05D5eURFyprfY=
X-Talos-MUID: 9a23:SpXYPwglUn2HoGK5/CTfocMpPf1F5pv1ElE0obJf4M6hDCJRFzWjpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,197,1787011200"; d="scan'208";a="59058128"
Received: from aer-l-core-09.cisco.com ([144.254.74.210])
 by aer-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 06 Nov 2026 09:25:15 +0000
Received: from localhost (unknown [10.189.100.82])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by aer-l-core-09.cisco.com (Postfix) with ESMTPS id 9CE4D1800011D;
 Fri,  6 Nov 2026 09:25:15 +0000 (GMT)
From: Jerome Tollet <jtollet@cisco.com>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: [PATCH] net/intel/common: track all RS buckets used by a Tx packet
Date: Fri,  6 Nov 2026 10:25:14 +0100
Message-ID: <20261106092514.76289-1-jtollet@cisco.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-Client-TLS: ANONYMOUS; unknown [10.189.100.82]; TLSv1.3;
 TLS_AES_256_GCM_SHA384; 256
X-Outbound-SMTP-Client: 10.189.100.82, [10.189.100.82]
X-Outbound-Node: aer-l-core-09.cisco.com
X-Mailman-Approved-At: Fri, 06 Nov 2026 11:55:54 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A TSO packet can use more descriptors than tx_rs_thresh. The scalar Tx
path records the completion descriptor only for the bucket containing
the packet's first descriptor. If the packet fills the next bucket,
that bucket has no completion entry. Cleanup then stops reclaiming
descriptors and the Tx ring stalls.

Record the packet's last descriptor for every bucket it crosses, and
wrap the bucket index at the end of the ring.

On E810 PF (ice) and VF (iavf) with 2K buffers and tx_rs_thresh=32,
65K GSO NVMe/TCP traffic reproduced the stall. With this change,
4K and 128K CRC tests passed with TSO enabled on both.

A standalone DPDK iavf reproducer, with no VPP, sends a 31-descriptor
TSO packet followed by a 33-descriptor TSO packet. Both pass
rte_eth_tx_prepare(). The original PMD leaves rs_last_id[1] pointing
to descriptor 0 and stalls after 991 further packets. With this fix,
it records descriptor 63 and transmits all 2048 further packets.

Fixes: 8f4396b9f63c ("net/intel: use separate array for desc status tracking")
Cc: stable@dpdk.org
Signed-off-by: Jerome Tollet <jtollet@cisco.com>
---
 .mailmap                             |  1 +
 drivers/net/intel/common/tx_scalar.h | 23 +++++++++++++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/.mailmap b/.mailmap
index 754dd9e760..ff75ec12a2 100644
--- a/.mailmap
+++ b/.mailmap
@@ -752,6 +752,7 @@ Jerin Jacob <jerinj@marvell.com> <jerin.jacob@caviumnetworks.com>
 Jerin Jacob <jerinj@marvell.com> <jerinjacobk@gmail.com>
 Jeroen de Borst <jeroendb@google.com>
 Jerome Jutteau <jerome.jutteau@outscale.com>
+Jerome Tollet <jtollet@cisco.com>
 Jerry Hao OS <jerryhao@os.amperecomputing.com>
 Jerry Lilijun <jerry.lilijun@huawei.com>
 Jerry Zhang <jerry.zhang@intel.com>
diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
index 7368d3abc9..c328f8d56b 100644
--- a/drivers/net/intel/common/tx_scalar.h
+++ b/drivers/net/intel/common/tx_scalar.h
@@ -614,22 +614,25 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 end_pkt:
 		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
 
-		/* Check if packet crosses into a new RS threshold bucket.
-		 * The RS bit is set on the last descriptor when we move from one bucket to another.
-		 * For example, with tx_rs_thresh=32 and a 5-descriptor packet using slots 30-34:
-		 *   - pkt_rs_idx = 30 >> 5 = 0 (started in bucket 0)
-		 *   - tx_last = 34, so 35 >> 5 = 1 (next packet is in bucket 1)
-		 *   - Since 0 != 1, set RS bit on descriptor 34, and record rs_last_id[0] = 34
+		/* A packet may consume more than one RS threshold bucket. The
+		 * last descriptor reports completion for every bucket crossed by
+		 * that packet, including buckets with no packet start.
 		 */
-		uint16_t next_rs_idx = ((tx_last + 1) >> txq->log2_rs_thresh);
+		const uint16_t nb_rs_buckets = txq->nb_tx_desc >> txq->log2_rs_thresh;
+		uint16_t next_rs_idx = (tx_last + 1) >> txq->log2_rs_thresh;
+		uint16_t rs_idx = pkt_rs_idx;
 
+		if (next_rs_idx == nb_rs_buckets)
+			next_rs_idx = 0;
 		if (next_rs_idx != pkt_rs_idx) {
-			/* Packet crossed into a new bucket - set RS bit on last descriptor */
 			txd->cmd_type_offset_bsz |=
 					rte_cpu_to_le_64(CI_TX_DESC_CMD_RS << CI_TXD_QW1_CMD_S);
 
-			/* Record the last descriptor ID for the bucket we're leaving */
-			txq->rs_last_id[pkt_rs_idx] = tx_last;
+			do {
+				txq->rs_last_id[rs_idx] = tx_last;
+				if (++rs_idx == nb_rs_buckets)
+					rs_idx = 0;
+			} while (rs_idx != next_rs_idx);
 		}
 
 		if (ts_fns != NULL)
-- 
2.56.0

