Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE02E9A03B
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 11:24:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A51F3402EB;
	Thu, 19 Feb 2026 12:24:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 8AA29402A2
 for <dev@dpdk.org>; Thu, 19 Feb 2026 12:24:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771500287; x=1803036287;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jgt7AmLCzJixyTHQq5nHaNvRWHhbhyL1UN6sWr0WU/w=;
 b=TNF5eqSSLzRe7rRa60N69A8FLYkxOyfBEw3ZmZXpdHWWJ8Vf8iWIZyQO
 k2C2F0yFwUkMv1vin1CSBWNuy21rno46pq8yrUNT7ObZ/jv/iqyUacEjY
 TKyJJOUWmVqa6f3Ax8A3GRX0MQ2CCUCLI/FOUpdM57DPJzYg+ws5QZzK8
 USbRMnBqHCnYs+e4aORm5BmlmDd4RKgvGGBgrwbEIbN1D2MpLLQk6PIoI
 snQNYQ+L+Dr8uwQrcfp8l9dyZl3SExsn+vxW/bkKwVImnvzduTV4ubWh4
 Lxbj30X7uvEnOBQtdT0H9AY359vh9kyrNmnpQy27tQ+bBUUwarFeBtNQq A==;
X-CSE-ConnectionGUID: v8SsNwmHSU6rJS3YkoWjEQ==
X-CSE-MsgGUID: t6K7R187RzCquMllDNWDwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="76198674"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; d="scan'208";a="76198674"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 03:24:46 -0800
X-CSE-ConnectionGUID: 7YXi54YURPi6nNY34W4KKQ==
X-CSE-MsgGUID: RaAp/9M9TOGcImq3PqjTwA==
X-ExtLoop1: 1
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa003.fm.intel.com with ESMTP; 19 Feb 2026 03:24:44 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: Song Jiale <songx.jiale@intel.com>
Subject: [PATCH v7 1/7] net/ice: add L2TPv2 PPP and PPoE data structures
Date: Thu, 19 Feb 2026 16:50:57 +0530
Message-Id: <20260219112103.2370766-2-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219112103.2370766-1-shaiq.wani@intel.com>
References: <20260202094244.447966-2-shaiq.wani@intel.com>
 <20260219112103.2370766-1-shaiq.wani@intel.com>
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

Add data structure definitions for L2TPv2 PPP and
PPoE protocols to support rte_flow pattern matching.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
Tested-by: Song Jiale <songx.jiale@intel.com>
---
 drivers/net/intel/ice/base/ice_fdir.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/intel/ice/base/ice_fdir.h b/drivers/net/intel/ice/base/ice_fdir.h
index 3dd03f93f7..3d3b05da4a 100644
--- a/drivers/net/intel/ice/base/ice_fdir.h
+++ b/drivers/net/intel/ice/base/ice_fdir.h
@@ -230,6 +230,20 @@ struct ice_fdir_ecpri {
 	__be16 pc_id;
 };
 
+struct ice_fdir_pppoe {
+	u8 rsrvd_ver_type;
+	u8 rsrvd_code;
+	__be16 session_id;
+	__be16 length;
+	__be16 ppp_prot_id; /* control and data only */
+};
+
+struct ice_fdir_ppp {
+	u8 addr;
+	u8 ctrl;
+	__be16 proto_id;
+};
+
 struct ice_fdir_l2tpv2 {
 	__be16 flags_version;
 	__be16 length;
@@ -279,6 +293,9 @@ struct ice_fdir_fltr {
 	struct ice_fdir_ecpri ecpri_data;
 	struct ice_fdir_ecpri ecpri_mask;
 
+	struct ice_fdir_ppp ppp_data;
+	struct ice_fdir_ppp ppp_mask;
+
 	struct ice_fdir_l2tpv2 l2tpv2_data;
 	struct ice_fdir_l2tpv2 l2tpv2_mask;
 
-- 
2.34.1

