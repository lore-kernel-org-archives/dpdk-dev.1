Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58875C02196
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:16:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACEF342DC1;
	Tue,  4 Feb 2025 16:12:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 302D1427C8
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:12:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681930; x=1770217930;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oZV8QLNWkJs40xYEtfm2n3jkJoNOHOXCmB33WExPHys=;
 b=arGjl+ZYp7iduDLmaQ42ZAzP315LPKmKvfjRoY6s5CwLaW2lRYgl4sHE
 tDkwgnhxbty3FmGIscZMss68GHuX2MG+zGjr/qQeFZDRJqHFr3chHYdYi
 QPNp+py2Bj8kuQu9F5JppfqG34j0gc5NVl3xslqjSWbNjyZixnv86Yh3f
 /qufSXY8nGWNnJkVodTAJoIXJNe8ImoVv+8qkdP5e+2UhRaNZyhzSgXB2
 24pAzSYaGZk6Pj3+H+Bw1DeF9ggtA9w6puoMDJwGUOvtgnCEQ97Idr4tJ
 DZrTXDnoJ7/9IW2JWVFoZRCPoskJrS3Hk2svJvOCyOrcbaaPdhn3nPyp4 g==;
X-CSE-ConnectionGUID: 3/qjHY0bQYi/8dpDsLU27w==
X-CSE-MsgGUID: gCeTgID5TBaPsHuaYFTD1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097151"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097151"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:12:09 -0800
X-CSE-ConnectionGUID: MNVqbkNPRTq/hfOz5DPa7g==
X-CSE-MsgGUID: IM8VoWSlS2W+Yp0G/k3t8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792722"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:12:08 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 33/54] net/e1000/base: add LPI counters
Date: Tue,  4 Feb 2025 15:10:39 +0000
Message-ID: <c9de2f5282eb482fcd5425f717a62d4c6af2564b.1738681726.git.anatoly.burakov@intel.com>
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

From: Sasha Neftin <sasha.neftin@intel.com>

Add new fields in structure to indicate if EEE LPI entries have been
observed on Tx and Rx path.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_hw.h  | 2 ++
 drivers/net/intel/e1000/base/e1000_mac.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/intel/e1000/base/e1000_hw.h b/drivers/net/intel/e1000/base/e1000_hw.h
index 7ef856226d..1b8292191a 100644
--- a/drivers/net/intel/e1000/base/e1000_hw.h
+++ b/drivers/net/intel/e1000/base/e1000_hw.h
@@ -645,6 +645,8 @@ struct e1000_hw_stats {
 	u64 o2bspc;
 	u64 b2ospc;
 	u64 b2ogprc;
+	u64 tlpic;
+	u64 rlpic;
 };
 
 struct e1000_vf_stats {
diff --git a/drivers/net/intel/e1000/base/e1000_mac.c b/drivers/net/intel/e1000/base/e1000_mac.c
index 0db114c0df..64486f4e4b 100644
--- a/drivers/net/intel/e1000/base/e1000_mac.c
+++ b/drivers/net/intel/e1000/base/e1000_mac.c
@@ -668,6 +668,8 @@ void e1000_clear_hw_cntrs_base_generic(struct e1000_hw *hw)
 	E1000_READ_REG(hw, E1000_TPT);
 	E1000_READ_REG(hw, E1000_MPTC);
 	E1000_READ_REG(hw, E1000_BPTC);
+	E1000_READ_REG(hw, E1000_TLPIC);
+	E1000_READ_REG(hw, E1000_RLPIC);
 }
 
 /**
-- 
2.43.5

