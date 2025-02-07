Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870FBC02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 12:48:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FA7242E91;
	Fri,  7 Feb 2025 13:46:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id DB7F742E7A
 for <dev@dpdk.org>; Fri,  7 Feb 2025 13:46:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738932380; x=1770468380;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=7Aav6CMNwOULIwyrIQCme13Sn4TeJylO1mONXzr95p8=;
 b=ANPEqCeG956uTFS7nqp/mETramsjnjx5GJ+WoH+SESJnzScuLyShPn5d
 oKRjZwnAFTuYjMoU1GqZPIYK1PZ8sFWGt1ZE1tfD9HgbgzOWTBQ5qC9iT
 3V94h6+r78pCvxysyZuJrKR9zzk1HO3qi1r7NqUPIoNl6vLA4hj6q9ocq
 McjF3kdK+330N3imNPvlIRhJXzE8O2QQuASX/i0jzKNp36zwqmoF0ZY9p
 fO2j42cMq9Ii4VXPqGZ6QXnDlblsu2IiR6+CsbQJdGvNJYQtbCzgSj5ES
 7Nby0S/Wsvt6CzkNP4jiffivjrp9eHdHnVnUSmFTCtvnAI3WNVIhG5okw Q==;
X-CSE-ConnectionGUID: d2E0rkwxT1qY3j5YYi/ruw==
X-CSE-MsgGUID: lC5SroBtRoOdxgr3vyjAJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43331852"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="43331852"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 04:46:20 -0800
X-CSE-ConnectionGUID: +GTW4n8ER+2wXVoq2y5J3w==
X-CSE-MsgGUID: JNr/qxZJSoSjvmReFlW2hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111953709"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 07 Feb 2025 04:46:19 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 22/36] net/e1000/base: add LPI counters
Date: Fri,  7 Feb 2025 12:45:14 +0000
Message-ID: <acdf2850f31d81624f1d8b461e35addecbffb65e.1738932115.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738932113.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738932113.git.anatoly.burakov@intel.com>
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
index 2250ed4dd7..53b1b0d5f2 100644
--- a/drivers/net/intel/e1000/base/e1000_mac.c
+++ b/drivers/net/intel/e1000/base/e1000_mac.c
@@ -670,6 +670,8 @@ void e1000_clear_hw_cntrs_base_generic(struct e1000_hw *hw)
 	E1000_READ_REG(hw, E1000_TPT);
 	E1000_READ_REG(hw, E1000_MPTC);
 	E1000_READ_REG(hw, E1000_BPTC);
+	E1000_READ_REG(hw, E1000_TLPIC);
+	E1000_READ_REG(hw, E1000_RLPIC);
 }
 
 /**
-- 
2.43.5

