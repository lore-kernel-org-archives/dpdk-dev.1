Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058EDC369B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 07:48:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D343402A1;
	Tue, 15 Apr 2025 09:48:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 8CB0940289;
 Tue, 15 Apr 2025 09:48:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744703312; x=1776239312;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=YU77u8tQAA3xRZi3apVUR28xCZ01TawxLCrYttfReOA=;
 b=j2MX02bFFms//Fi0X93P8xHcegGG4PTNa/xw1LQN9pGNSv5UwjA8aMa9
 KdoYXGdHXZ76t2Ycm0oQBm4nv/a305xXSN3ofRlNm+g1Q/Paj4o8l3Om1
 cBSo08nAD8AV5SORbbmd7dO+N1aZrZ+Ago7TSYAMg89SdTv7u2GcnV9Yk
 xPDIzSi/g/ZOUH7az9/VFgUxifdLjqOniCF6sk4g8Lh2Ax0D7K93614y9
 0bpy/l+nPYxlO7e+cMGJf6cTSLVr9RfozQ1Pl41FCqhkCh+tElJU/a8Jt
 4wFk51lZDnxXdsE5tjFz7uScYA+9McIZvvjVHMD/xHLiJX+MFm94X4hYj g==;
X-CSE-ConnectionGUID: K71rAjX1SfaqxHtJT0Hy+g==
X-CSE-MsgGUID: JPCacdytQRyTIc1ylSexng==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="56835890"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; d="scan'208";a="56835890"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2025 00:48:30 -0700
X-CSE-ConnectionGUID: 6Nr+nAtCSyK7iOrNsJmOPg==
X-CSE-MsgGUID: S59BSNj+ROu4n6z1s/0ZRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; d="scan'208";a="135115373"
Received: from unknown (HELO localhost.localdomain) ([10.239.252.210])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2025 00:48:29 -0700
From: Yuan Wang <yuanx.wang@intel.com>
To: dev@dpdk.org
Cc: Yuan Wang <yuanx.wang@intel.com>,
	stable@dpdk.org
Subject: [PATCH] net/e1000: fix eeprom dump failure
Date: Tue, 15 Apr 2025 15:48:02 +0800
Message-ID: <20250415074802.454733-1-yuanx.wang@intel.com>
X-Mailer: git-send-email 2.47.1
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

There is a incorrect comparison in get_eeprom that cause epprom dump fail.
This patch fixes this issue.

Fixes: 83c314da4c38 (igb: add access to specific device info)
Cc: stable@dpdk.org

Signed-off-by: Yuan Wang <yuanx.wang@intel.com>
---
 drivers/net/intel/e1000/igb_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/e1000/igb_ethdev.c b/drivers/net/intel/e1000/igb_ethdev.c
index cbd2f15f5f..738c0ef895 100644
--- a/drivers/net/intel/e1000/igb_ethdev.c
+++ b/drivers/net/intel/e1000/igb_ethdev.c
@@ -5219,7 +5219,7 @@ eth_igb_get_eeprom(struct rte_eth_dev *dev,
 	first = in_eeprom->offset >> 1;
 	length = in_eeprom->length >> 1;
 	if ((first >= hw->nvm.word_size) ||
-	    ((first + length) >= hw->nvm.word_size))
+	    ((first + length) > hw->nvm.word_size))
 		return -EINVAL;
 
 	in_eeprom->magic = hw->vendor_id |
-- 
2.47.1

