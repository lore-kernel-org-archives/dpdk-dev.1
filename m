Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45224FF885D
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Apr 2026 02:40:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1415340293;
	Mon, 27 Apr 2026 04:40:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 596744025F
 for <dev@dpdk.org>; Mon, 27 Apr 2026 04:39:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777257600; x=1808793600;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ipOmOwC+3j5Mcrcbor+FfHWSuqsitnjPHcggLXJxNxk=;
 b=VwxCOCIGyl7lMr8SvV+4Cq/rN8/PpvtSGmJAPoN1v698xzA/ujk2FhJ4
 lF0xVWSSo0zZKfbINlK5RJOLoWh74iaLfJXatjxd2ZcK1NBwfwYv+W80T
 zEdRr/TmT4GaF9lJqnGMLQsphjuC9kERcQT/jbI19L0tsaWjfX6jburtF
 wJWdHDfGYm1F/QtbH+QlmvzBZ/uVqgkhiIN1vuDmSCLBEG6R7COOJzg3l
 bc+ilPQcv5Z2ioI8Wyd1M8seyI/ozC81jA0oCg1lLxbp26KHMYJkIITIu
 9p63PHC6PpY24ifWfBe+SRFHypMj4yqqFA+sYdHSJ29r6Q6eDr8ie1MK1 Q==;
X-CSE-ConnectionGUID: DQkvQd/GQLWYFbQf/9vcJQ==
X-CSE-MsgGUID: hxxh4l2STTS4ssSAG1HbWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="95703502"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; d="scan'208";a="95703502"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2026 19:39:58 -0700
X-CSE-ConnectionGUID: S8891DQ0RNGvQ6ldsMpIbQ==
X-CSE-MsgGUID: +3XWY49bTyKT/zInPwBkvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; d="scan'208";a="271637673"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by orviesa001.jf.intel.com with ESMTP; 26 Apr 2026 19:39:56 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH 0/7] net/ice: L2TPv2 flow rule fixes
Date: Mon, 27 Apr 2026 08:01:08 +0530
Message-ID: <20260427023115.1225843-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.43.0
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

The original L2TPv2 flow support (733640dae75e) mapped every PPP tunnel
variant to a single generic PTYPE and programmed both segments with
identical headers. This caused several interrelated problems:
cross-protocol matches, silent inner-field drops, rule deletion
failures, and unintended side-effects on GTP-U flows.

This series addresses each issue:

  1/7  Use the 30 granular HW PTYPEs (396-425) defined by the DDP
       package instead of the generic ICE_MAC_IPV4_L2TPV2, and
       extend the training-packet switch to cover the new flow types.

  2/7  Add the 8 missing tunnel inset-to-flow-field mappings so
       inner IP/L4 fields are no longer silently dropped during
       field parsing.

  3/7  Pass a segment index to ice_fdir_input_set_hdrs() and expand
       each L2TPv2/PPP ptype into its own case with distinct outer
       and inner header sets. Also always program inner-segment
       headers for tunnel profiles, even when no inner fields are
       extracted, so ptype-only narrowing works.

  4/7  Fix deletion of bare L2TPv2 rules (no PPP) by switching to a
       single-segment profile, and normalize the L2TPv2 flags in the
       SW hash key to prevent lookup mismatches.

  5/7  Stop L2TPv2 tunnel detection from overwriting the GTP-U
       tunnel profile, which caused GTP-U flow rules to fail.

  6/7  Invalidate stale HW profiles when the L2TPv2 subtype changes
       between rule creations.

  7/7  Pin the outer Ethertype (0x0800 / 0x86DD) in L2TPv2 rules
       so IPv4 and IPv6 flows are not cross-matched.

Shaiq Wani (7):
  net/ice: use granular PTYPEs for L2TPv2 PPP
  net/ice: add tunnel inset bits to flow input set map
  net/ice: fix L2TPv2 inner segment header setup
  net/ice: fix bare L2TPv2 flow rule deletion
  net/ice: fix GTP-U failure due to wrong tunnel profile
  net/ice: fix stale profile after L2TPv2 subtype change
  net/ice: pin outer Ethertype for L2TPv2 flow rules

 drivers/net/intel/ice/base/ice_fdir.c    |  12 ++
 drivers/net/intel/ice/ice_fdir_filter.c  | 215 +++++++++++++++++++++--
 drivers/net/intel/ice/ice_generic_flow.c |  28 +--
 3 files changed, 223 insertions(+), 32 deletions(-)

-- 
2.43.0

