Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F106C02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:15:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E7EB42D76;
	Tue,  4 Feb 2025 16:12:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 1E1BD427A6
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:12:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681924; x=1770217924;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Oa80xVOKsmbKao3bHRnxXtsxlvl4qmf2T1H46kPnx7g=;
 b=LARCWdPX82Hbe1182Onve5R2AhZHtK8VeGt5G5zP15hwT6AYhTE7qQGp
 fY2HG+oNm4dq4/oGMgPlHpuoC2IVddxcc7eXMKh5K65FLAzm+p6vAqD3I
 s4ds4u3ffKDRt6fHRT4XhDbNCL/W2WrbhLL7vf8pvGD8dMaoOnRqpEGdU
 G1O6iEBmjBuOuIhSR3xfdXkm9M1n+azdyekGjlV+vaSwDMhBKMqfSm9zm
 cTsJZUw6lj7DCZnEqkQ5X1xD8oX/wC+ADGwQkme/eU9PFA9PDRu/Cu5AA
 8EC+lmsfgC5HksxIyKqtHWwEkN6dW5KtzLOTTebf+cpGxHMF7AcFQ+pV5 w==;
X-CSE-ConnectionGUID: hBymdmsTT3qhCOgXerxzRw==
X-CSE-MsgGUID: Ly1xE6PBQG2fxf1UymGtGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097144"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097144"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:12:03 -0800
X-CSE-ConnectionGUID: OCVreNSwSY6rXIqsyT4JYA==
X-CSE-MsgGUID: 43jzv1/5RS6wYTrGgHndeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792696"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:12:01 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 28/54] net/e1000/base: correct disable k1 logic
Date: Tue,  4 Feb 2025 15:10:34 +0000
Message-ID: <ca11430cecfff1c1259a56e2a5237d3613449ec1.1738681726.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738681725.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738681725.git.anatoly.burakov@intel.com>
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

From: Vitaly Lifshits <vitaly.lifshits@intel.com>

Starting from MTP PHY type there is a synchronization issue between the
PHY's clock and PCH's synopsis PHY. This causes Tx packets corruptions.

The workaround to this issue is to change P0s power down state from
P0/P0s to P1 prior to disabling K1.

Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_ich8lan.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.c b/drivers/net/intel/e1000/base/e1000_ich8lan.c
index 4ff213f2c4..b346b95d2f 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.c
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.c
@@ -2425,6 +2425,18 @@ s32 e1000_configure_k1_ich8lan(struct e1000_hw *hw, bool k1_enable)
 
 	DEBUGFUNC("e1000_configure_k1_ich8lan");
 
+	/* Due to clock synchronization issue on MTL and above prior to
+	 * disabling k1 it is required to disable P0s state
+	 */
+	if ((!k1_enable) && (hw->mac.type >= e1000_pch_mtp)) {
+		u32 fextnvm12 = E1000_READ_REG(hw, E1000_FEXTNVM12);
+		fextnvm12 |= (1 << 23);
+		fextnvm12 &= ~((1 << 22));
+		E1000_WRITE_REG(hw, E1000_FEXTNVM12, fextnvm12);
+
+		usec_delay(100);
+	}
+
 	ret_val = e1000_read_kmrn_reg_locked(hw, E1000_KMRNCTRLSTA_K1_CONFIG,
 					     &kmrn_reg);
 	if (ret_val)
-- 
2.43.5

