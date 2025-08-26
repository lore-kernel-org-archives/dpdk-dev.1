Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE098EDF038
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 05:31:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9323402C0;
	Thu, 12 Feb 2026 06:31:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id CD8284025F
 for <dev@dpdk.org>; Thu, 12 Feb 2026 06:31:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770874290; x=1802410290;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=vt8CxKYlwvh/UnxxtCkcS4iGNA26fnvf+BHAz5ZWuOw=;
 b=Zh08i7iC4LC8zLZjzez9C+ENE0fQJBS7n274U7Tg9tRK6EvRN8arI5lK
 GaBX9GT+zjssnfkU4BldNgqJFlkdWkRx3BnF3SmFxzb+f4KtTplzUeqg8
 /WnOxGY5i3iiQJ5x/D/Bmjci79Dm28SWzE0ShufLGw/LJ+HmtclfC2F8F
 PsLByyvBcuT4vxHoiCkkG883PKA/w/OeyIlenluIvWl4jpEVOcPFSuBXF
 lvEA+M/S4wouAEwKzyeaVrlsk5uV3A0jMDb7Yv8xX8lwVxbbxc+ZL2xVo
 dfnftqSryJ6QXeR3Fxje+2cIiHP9n+eo0qoRSDRHPYjL0wyddwlqQ7Ur6 w==;
X-CSE-ConnectionGUID: OcyJpAl6TPGwvsOryQNjzA==
X-CSE-MsgGUID: sBy7TyOOQuu4dMFmZamN1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="83405330"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="83405330"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 21:31:28 -0800
X-CSE-ConnectionGUID: 358cC/ssQna5zOyYaIv4oQ==
X-CSE-MsgGUID: kKS+9iFZRzapIY40gbDh4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="212581373"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by orviesa007.jf.intel.com with ESMTP; 11 Feb 2026 21:31:28 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v5 0/7]  Add support for L2TPV2 over UDP to ICE PMD
Date: Tue, 26 Aug 2025 22:35:34 +0530
Message-Id: <20250826170541.5010-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260202094244.447966-1-shaiq.wani@intel.com>
References: <20260202094244.447966-1-shaiq.wani@intel.com>
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

This patchset adds L2TPv2 protocol support to the ICE PMD
enabling RSS and Flow Director capabilities for L2TPv2 over UDP traffic.

v5: Resending v4 patches with correct cover letter and threading. 

v4: *Version 3 patchset was incomplete due to a server reboot.
     *V4 includes all patches for review.

v3: Fixed compilation issues.
v2: Addressed AI generated comments.

Shaiq Wani (7):
  net/ice: add L2TPv2 PPP and PPoE data structures
  net/ice: add L2TPv2 tunnel type definition
  net/ice: add L2TPv2 protocol and field definitions
  net/ice: add L2TPv2 flow patterns and FDIR support
  net/ice: add L2TPv2 hardware packet generation
  net/ice: add L2TPv2 RSS hash support
  doc: update release notes

 doc/guides/rel_notes/release_26_03.rst   |   4 +
 drivers/net/intel/ice/base/ice_fdir.c    |   6 +
 drivers/net/intel/ice/base/ice_fdir.h    |  17 +
 drivers/net/intel/ice/ice_ethdev.h       |   4 +
 drivers/net/intel/ice/ice_fdir_filter.c  | 451 ++++++++++++++++++++---
 drivers/net/intel/ice/ice_generic_flow.c | 177 +++++++++
 drivers/net/intel/ice/ice_generic_flow.h | 129 ++++---
 drivers/net/intel/ice/ice_hash.c         |  25 ++
 8 files changed, 717 insertions(+), 96 deletions(-)

-- 
2.34.1

