Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518E3C56201
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Aug 2026 11:09:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F5CA40272;
	Wed,  5 Aug 2026 13:09:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 9B8A040144
 for <dev@dpdk.org>; Wed,  5 Aug 2026 13:09:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785928154; x=1817464154;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=IhwbfLGVGdsbwNlNMQTYQMZPbWEzSr5FjD6tl7zalII=;
 b=ikZEto5YfMJhFmxrq+j/JF1djrbp7ztpmN/Y235Wie8uddjkxYnLa/cA
 zQY6Nxzf/FTfAVhg/34i+7Dn7rFKjldnEhUnBeqcI0CjdSro4n/OWqWpQ
 quk8myJ4OgcLYWmntN6DUyvNucrds3IFpiHfSjzX0aBbNqSGlSUOzqgPS
 Siikz9hkVDniF/hJAz3hfqOKqzF1X0gQDkzeb3Gi6KbY9vt8cjgAcUxY2
 C+CILwvx9DuCYkNJ08AsJAOySwwFNkvMM7Ulmo8f6D9B7+tWQLXRQjtNX
 MCvJfn5qnVKGYZx39nYbiPDASdrwo/KBUQ2WVMXkffB9PHS89sqcUT2Gz Q==;
X-CSE-ConnectionGUID: DCbU6AxSTleftN11vnEO2g==
X-CSE-MsgGUID: dsAul/wnQRWSDkQYM/HJMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97146171"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="97146171"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 04:09:13 -0700
X-CSE-ConnectionGUID: dX7gmcXPQ0i+6kCAuQxDeg==
X-CSE-MsgGUID: mZEYydtnT8aDy0vIeYCiWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="265285286"
Received: from unknown (HELO localhost.localdomain.iind.intel.com)
 ([10.49.105.104])
 by orviesa003.jf.intel.com with ESMTP; 05 Aug 2026 04:09:12 -0700
From: sandeep.penigalapati@intel.com
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH] net/iavf: enable 200G link speed
Date: Wed,  5 Aug 2026 14:11:12 -0400
Message-Id: <20260805181112.164909-1-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.27.0
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

From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>

Enable 200G link speed reporting for E830 VFs.

Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index d601ec3b6a..7a47ad6a37 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -1300,6 +1300,9 @@ iavf_dev_link_update(struct rte_eth_dev *dev,
 	case 100000:
 		new_link.link_speed = RTE_ETH_SPEED_NUM_100G;
 		break;
+	case 200000:
+		new_link.link_speed = RTE_ETH_SPEED_NUM_200G;
+		break;
 	default:
 		new_link.link_speed = RTE_ETH_SPEED_NUM_NONE;
 		break;
-- 
2.27.0

