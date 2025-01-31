Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EE4C0218F
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:02:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE0E442E5F;
	Fri, 31 Jan 2025 13:59:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 0F0E642E37
 for <dev@dpdk.org>; Fri, 31 Jan 2025 13:59:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328387; x=1769864387;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=z2zumG0azCiYwq5dGlST7rlLUYrElIoktfqZp9C3fM4=;
 b=NUpyvyuQUgKJKpunas5QdaIJKMMWAddWtukyX0eZSLvd0s9ic5CfddyI
 FyV5ZVYpucwA+82fxQRXVEIIWXn/o8h+uYpxJ72792nLyMm9dZ5686Uw2
 0e/JtBgVM1STRKwqrAaYx0DakULAnKfa92WF7Th9/bbUpzIOrKkHZOob5
 Ki7uYL62q2Oz0kV6G3Q06vdG8ntUufpOCd6+7kCtVvSZH+/a4qMhnwJ2w
 clTYzu39YG7KkhNsHdY2kN+7LQWEzxALtNNHiN9/lbreShsXpXe/eHhlS
 3Ocj+QPwVa1/mIg/5bK7ayTKxmj5nVH8R2U7ONUPLbvHsRpnR9UVY+HRM g==;
X-CSE-ConnectionGUID: O3OVUM7GS3uCzj1Iun5xDA==
X-CSE-MsgGUID: Tp2q3I9bTEWZ8n9lp+ho6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315642"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315642"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:47 -0800
X-CSE-ConnectionGUID: 7SnKo4FXTs2vdki0r+ambw==
X-CSE-MsgGUID: bukCm83HS2iWHP9dGcnUyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503402"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:46 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 21/42] net/e1000/base: add LPI counters
Date: Fri, 31 Jan 2025 12:58:34 +0000
Message-ID: <6dc928cd81c31aa163ae095d2252e5c18123d95b.1738328107.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738328106.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
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
index 8c1f931038..cbef1fc10c 100644
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

