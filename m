Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB12CCA471
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 11:09:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7E4B4028B;
	Fri,  3 Oct 2025 13:09:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 0DC3E40262;
 Fri,  3 Oct 2025 13:09:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759489790; x=1791025790;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/I4cryzZ2VWXbegWLnyfHr8Z+OIeVzlgvxhR2KzqOuo=;
 b=CvF2TtQ8aFCO/+Yub8CXusNsI2z2rtoBMDd2cnhvUQIMzSd4L+YU3q1R
 wB4cUwModlDumBKq0bXMczFHh7PEPb8vxRUchktfGmRcunvDKePuxhtJa
 lY/p63eIA/ftRg8JfhFLtztSX3vTG0sn7RfL/20JisyYa4qpYM93/YvLy
 GFPj7znLhXFbBCJDP0+H8AtoS7t5sZEBuSiibrKyAJqJW04/GpACt2kqh
 Djv0BUIzcfojg6EDzxkME5rLOPKLWxTSkfDVf/bTWDPnX8sBnKeXdZM3a
 juOXS8hR1LytaVQfafdEa/VDiOCqdf4TuRLt7OQqaDxWpB2tuRprjTlTs A==;
X-CSE-ConnectionGUID: RCVhBDwFQRyX2H3+Zcz59g==
X-CSE-MsgGUID: LmvhQ0kiS3yXxYOw2SMb+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="64386655"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="64386655"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 04:09:49 -0700
X-CSE-ConnectionGUID: WWMOTT9oSN2EGnGMgIhG6g==
X-CSE-MsgGUID: Y5pcXxr2SrmylLqe8ooCOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="209945200"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa002.jf.intel.com with ESMTP; 03 Oct 2025 04:09:48 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [PATCH] ethdev: fix copy-paste error in fn parameter description
Date: Fri,  3 Oct 2025 12:09:44 +0100
Message-ID: <20251003110944.1594659-1-bruce.richardson@intel.com>
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

The description of the rx_queue_id parameter was copy-pasted from the
queue mapping function without being updated. Fix the text.

Fixes: 81f9db8ecc2c ("ethdev: add vlan offload support")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/ethdev/rte_ethdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index a122df4e8e..6ab934b60c 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -3711,7 +3711,7 @@ int rte_eth_dev_vlan_filter(uint16_t port_id, uint16_t vlan_id, int on);
  * @param port_id
  *   The port identifier of the Ethernet device.
  * @param rx_queue_id
- *   The index of the receive queue for which a queue stats mapping is required.
+ *   The index of the receive queue on which to enable/disable VLAN stripping.
  *   The value must be in the range [0, nb_rx_queue - 1] previously supplied
  *   to rte_eth_dev_configure().
  * @param on
-- 
2.48.1

