Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B165AC77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 13:52:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CE8140277;
	Fri, 27 Jun 2025 15:52:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id DEB93400D5;
 Fri, 27 Jun 2025 15:52:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751032333; x=1782568333;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=LxDAfnc6QiOy9R3Lw5RErPJdGSs9uZNN9EhZeXhpMKQ=;
 b=SF6j0POmy+BQ8ZI8BD8vSaYwu5ToLu4zYwouhG6q1pEAl6CfG1Dx57gk
 Qd1bF2zRnTGoJdmTcIKU2rJbvbjJeFouBlw4VegoI5MPXTAi29QH5ow5b
 lvLc87AduJEtd8B7I0SqzrqkaYCaShoC9ifXIPsttnY2dBXXO2KdFngO1
 jeJmLo9xqXeEXYik4VtDHfirKkvD3HiAsx3UOYLqp4t6/O47o0s8+b6py
 Rt6s0trF/MgSXLUgzEtkczfD/ImMgW+hLZWNU07nIHIms6F2v1Na/D+oO
 4JVwNkepWkIuzO2JR+Vv03A60rsU9VE4VrwSOlsKJJCjWaFRO4hPdG8A6 Q==;
X-CSE-ConnectionGUID: 4cOUmzTgQg+z2k1S9g0vrg==
X-CSE-MsgGUID: c/sqTeeYSEGuNBXj4mUh+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="57151345"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="57151345"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2025 06:52:12 -0700
X-CSE-ConnectionGUID: imUaLhXzSQ6q1eEMVVc8AA==
X-CSE-MsgGUID: vUWvu9bwRtOfE3gfSao+xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="153297628"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by orviesa008.jf.intel.com with ESMTP; 27 Jun 2025 06:52:10 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>, Mingjin Ye <mingjinx.ye@intel.com>
Subject: [PATCH] net/ice: fix inconsistency in Rx queue VLAN tag placement
Date: Fri, 27 Jun 2025 14:52:01 +0100
Message-ID: <20250627135201.1393662-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
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

When VLAN or QinQ stripping is enabled in the ice driver, an
inconsistency was observed between the placement of the VLAN tag in the
descriptors of the final Rx queue (irrespective of the number of queues)
vs descriptors of all other queues. This inconsistency was due to the
fact that the driver - when updating l2tsel (L2 tag selection) field -
used the queue id, rather than the register index for the queue. Queue 0
is normally HW queue 1, etc., meaning the final queue never had its
field updated.

Fixes: de5da9d16430 ("net/ice: support double VLAN")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 680e7724cd..513777e372 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -4988,11 +4988,11 @@ static void ice_vsi_update_l2tsel(struct ice_vsi *vsi, enum ice_l2tsel l2tsel)
 		l2tsel_bit = BIT(ICE_L2TSEL_BIT_OFFSET);
 
 	for (i = 0; i < dev_data->nb_rx_queues; i++) {
+		const struct ci_rx_queue *rxq = dev_data->rx_queues[i];
 		u32 qrx_context_offset;
 		u32 regval;
 
-		qrx_context_offset =
-			QRX_CONTEXT(ICE_L2TSEL_QRX_CONTEXT_REG_IDX, i);
+		qrx_context_offset = QRX_CONTEXT(ICE_L2TSEL_QRX_CONTEXT_REG_IDX, rxq->reg_idx);
 
 		regval = rd32(hw, qrx_context_offset);
 		regval &= ~BIT(ICE_L2TSEL_BIT_OFFSET);
-- 
2.48.1

