Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31692CD8CA4
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 14:03:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C94D340664;
	Tue,  9 Jun 2026 16:03:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 69BF34025E;
 Tue,  9 Jun 2026 16:03:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781013816; x=1812549816;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=cEB3qmC2q8vHhiDQ/5Fl9581IOvaCZxOKIX4yV1FNes=;
 b=AzIchjqa0YgH8jzS4f6XYOFu9hL6THNJlbkuLlPFJlHtheUAw5hAnI9r
 nR5Cu4PyN283j7fWgwFG+PPntgZTv6JWo9ggxMwryFS38HXRxb+ZtoF5h
 bbJeE2/wxixZbcVoWMVXxy2EYLz1Ty7r2h8CJV6Rp/aXW8KCSZFWF/P2s
 w0IAX6tqlFhJ9F6eX6kBlmMKqxVuJ7pypiSbjG9KjCLTgJCwRW/OvJ5kb
 OVMzeZrYTIqVvDEYCfcGCvoG08LMX3omGtQwWn0a5gyeWE/ox50EBk10H
 p0s0vnJBVZQeMtjeWAv35ZncyhecBwwQksInjL/QUvsui3QOnURgHnJuf A==;
X-CSE-ConnectionGUID: iGelGVujTQaYfVUkkKeztA==
X-CSE-MsgGUID: nKCpt0pZSv6ZVpfoXjbyng==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="85397613"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="85397613"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 07:03:35 -0700
X-CSE-ConnectionGUID: 2tNI5f7SQleREYE7/ir8Ew==
X-CSE-MsgGUID: SiWyHH8GQNaY+8Ip5O46Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="250796828"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa005.jf.intel.com with ESMTP; 09 Jun 2026 07:03:34 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH] net/iavf: reject oversized frames in prep callback
Date: Tue,  9 Jun 2026 14:03:17 +0000
Message-ID: <20260609140317.1901278-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Currently, only the segment count is checked for non-TSO packets. There
is no upper bound placed on the packet length, so packets larger than
`IAVF_FRAME_SIZE_MAX` pass the prepare callback unchallenged and are
submitted to the hardware. Sending such frames can trigger Malicious
Driver Detection (MDD) on the PF. Fix this by adding a packet length
size check on the non-TSO path.

Fixes: 19ee91c6bd9a ("net/iavf: check illegal packet sizes")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index decbc75142..a57af7faed 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -3227,9 +3227,9 @@ iavf_prep_pkts(__rte_unused void *tx_queue, struct rte_mbuf **tx_pkts,
 		m = tx_pkts[i];
 		ol_flags = m->ol_flags;
 
-		/* Check condition for nb_segs > IAVF_TX_MAX_MTU_SEG. */
+		/* Validate segment count and packet length. */
 		if (!(ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))) {
-			if (m->nb_segs > IAVF_TX_MAX_MTU_SEG) {
+			if (m->nb_segs > IAVF_TX_MAX_MTU_SEG || m->pkt_len > IAVF_FRAME_SIZE_MAX) {
 				rte_errno = EINVAL;
 				return i;
 			}
-- 
2.43.0

