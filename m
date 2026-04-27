Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F13FF885D
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Apr 2026 02:40:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B5854064F;
	Mon, 27 Apr 2026 04:40:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 5986A4025F
 for <dev@dpdk.org>; Mon, 27 Apr 2026 04:40:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777257602; x=1808793602;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=MQ/Z/AkP3H3BPWNXNdWmpOFfQcZmTg0NVaIDMfakVf8=;
 b=gSBxd5dSMqYhcjqCQBIPeZc4wPqZNE1bqzsK8N35/iMKbsONO1lVqoRQ
 aUD2OXlRjTb7rj/ijCXboKUZVPobHmZ+O5yeKE9orMdazJXhJ+AGg2Ccy
 SjmMEpVghNRuxUumDoPT5BwET8wL/As0fKth2NHiQTjNxEBLUS4VH++Rm
 w/YJeH43XvCp0kKEPnH5P6u3FkJ4KgxV18/XqGPMnqSZyNA4qDhqioAKB
 b19Z0aNnnNAzAlXcJEKYMMlQS4zzj5zodmXfgJt2b5FiYHSb/U0epOw/1
 yohKo60kc2EKfMtJzreIACDAtZL1qXgNpkMoDnwwSEKE45HXW81ryyY0J Q==;
X-CSE-ConnectionGUID: ngYY3t3CTm6av4m4SX7V1g==
X-CSE-MsgGUID: Gj8O17NKQKK1sTSH7F6yNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="95703504"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; d="scan'208";a="95703504"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2026 19:40:01 -0700
X-CSE-ConnectionGUID: hmAulTy1SkSyaQre+gK/dg==
X-CSE-MsgGUID: Y7KOAUfxSxiNyc7uoQvOMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; d="scan'208";a="271637684"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by orviesa001.jf.intel.com with ESMTP; 26 Apr 2026 19:39:59 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH 2/7] net/ice: add tunnel inset bits to flow input set map
Date: Mon, 27 Apr 2026 08:01:10 +0530
Message-ID: <20260427023115.1225843-3-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427023115.1225843-1-shaiq.wani@intel.com>
References: <20260427023115.1225843-1-shaiq.wani@intel.com>
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

Tunnel inset bits (ICE_INSET_TUN_IPV4_SRC, ICE_INSET_TUN_IPV4_DST,
ICE_INSET_TUN_IPV6_SRC/DST, ICE_INSET_TUN_TCP/UDP_SRC/DST_PORT) are
absent from ice_inset_map[], so inner IP/L4 fields for L2TPv2/PPP
tunnel flow rules are silently ignored during field parsing.

Add the 8 missing tunnel inset-to-flow-field mappings.

Fixes: 733640dae75e ("net/ice: support L2TPv2 flow pattern matching")
Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/ice/ice_fdir_filter.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index ce80213429..5ee9edc442 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -1004,6 +1004,14 @@ ice_fdir_input_set_parse(uint64_t inset, enum ice_flow_field *field)
 		{ICE_INSET_NAT_T_ESP_SPI, ICE_FLOW_FIELD_IDX_NAT_T_ESP_SPI},
 		{ICE_INSET_L2TPV2OIP_SESSION_ID, ICE_FLOW_FIELD_IDX_L2TPV2_SESS_ID},
 		{ICE_INSET_L2TPV2OIP_LEN_SESSION_ID, ICE_FLOW_FIELD_IDX_L2TPV2_LEN_SESS_ID},
+		{ICE_INSET_TUN_IPV4_SRC, ICE_FLOW_FIELD_IDX_IPV4_SA},
+		{ICE_INSET_TUN_IPV4_DST, ICE_FLOW_FIELD_IDX_IPV4_DA},
+		{ICE_INSET_TUN_IPV6_SRC, ICE_FLOW_FIELD_IDX_IPV6_SA},
+		{ICE_INSET_TUN_IPV6_DST, ICE_FLOW_FIELD_IDX_IPV6_DA},
+		{ICE_INSET_TUN_TCP_SRC_PORT, ICE_FLOW_FIELD_IDX_TCP_SRC_PORT},
+		{ICE_INSET_TUN_TCP_DST_PORT, ICE_FLOW_FIELD_IDX_TCP_DST_PORT},
+		{ICE_INSET_TUN_UDP_SRC_PORT, ICE_FLOW_FIELD_IDX_UDP_SRC_PORT},
+		{ICE_INSET_TUN_UDP_DST_PORT, ICE_FLOW_FIELD_IDX_UDP_DST_PORT},
 	};
 
 	for (i = 0, j = 0; i < RTE_DIM(ice_inset_map); i++) {
-- 
2.43.0

