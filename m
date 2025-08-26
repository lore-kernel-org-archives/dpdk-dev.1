Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C564EDF038
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 05:31:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D740740647;
	Thu, 12 Feb 2026 06:31:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id B43C24042C
 for <dev@dpdk.org>; Thu, 12 Feb 2026 06:31:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770874292; x=1802410292;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=doigNYn8mbt3BmpE6ZNueFYuJUchwJAOFVYgb9kAbFI=;
 b=KblIEYqvSr1ZscMDThMlEN2ja6KcRdGizBi2eXvdm9Gth3woWKZoNqcr
 iidDj7i+wQdpjHLF+m8ndUdhIYN5MhxwN43iU/thGrdcZPqKTZAoutFoz
 hjmH14Y5nMFJ97daQrMXHeL0alU8UQU3GQUhh0i2TwGG0kk0CYHypE/Xi
 XikZ9K64N/v4e8MHPxmhazcvOpaAmv5aKRTXeuUlrHFad//eryRrs0L0H
 R70zXv47e+fD+09FuGYpOpQy10DLqNLHp8OgoLqadYPYJ0tOele4JG1hQ
 QPPr/UdVVofAAVa9nbHP9zarEgUu8xKmzg8FRaGGCFiiPMrtIByxxyvPs w==;
X-CSE-ConnectionGUID: 8dd6aKpTQuWe1wPPwG1sdA==
X-CSE-MsgGUID: jjQqM6rgTviffxnHti03jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="83405335"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="83405335"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 21:31:31 -0800
X-CSE-ConnectionGUID: 8z9Q90TJToiV+FNiu8/I3g==
X-CSE-MsgGUID: oyb9WdGLQ3qLZMDddoRdVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="212581381"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by orviesa007.jf.intel.com with ESMTP; 11 Feb 2026 21:31:31 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: Song Jiale <songx.jiale@intel.com>
Subject: [PATCH v5 2/7] net/ice: add L2TPv2 tunnel type definition
Date: Tue, 26 Aug 2025 22:35:36 +0530
Message-Id: <20250826170541.5010-3-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826170541.5010-1-shaiq.wani@intel.com>
References: <20260202094244.447966-1-shaiq.wani@intel.com>
 <20250826170541.5010-1-shaiq.wani@intel.com>
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

Add ICE_FDIR_TUNNEL_TYPE_L2TPV2 to the tunnel type enum and
extend ice_fdir_fltr_pattern structure to include L2TPv2 data and
mask fields.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
Tested-by: Song Jiale <songx.jiale@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 9562b2b8f1..4b3718f715 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -369,6 +369,7 @@ enum ice_fdir_tunnel_type {
 	ICE_FDIR_TUNNEL_TYPE_VXLAN,
 	ICE_FDIR_TUNNEL_TYPE_GTPU,
 	ICE_FDIR_TUNNEL_TYPE_GTPU_EH,
+	ICE_FDIR_TUNNEL_TYPE_L2TPV2,
 };
 
 struct rte_flow;
@@ -405,6 +406,9 @@ struct ice_fdir_fltr_pattern {
 	struct ice_fdir_udp_gtp gtpu_data;
 	struct ice_fdir_udp_gtp gtpu_mask;
 
+	struct ice_fdir_l2tpv2 l2tpv2_data;
+	struct ice_fdir_l2tpv2 l2tpv2_mask;
+
 	struct ice_fdir_extra ext_data;
 	struct ice_fdir_extra ext_mask;
 
-- 
2.34.1

