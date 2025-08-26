Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCABEDF032
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 04:52:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F363402C0;
	Thu, 12 Feb 2026 05:52:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 839AE4025F
 for <dev@dpdk.org>; Thu, 12 Feb 2026 05:52:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770871974; x=1802407974;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Xeg3giOGDWge80j0wd4tAXHj3nyx09gzAIOUV5w+RhU=;
 b=ENGm7Mipi8bgXFPGwzrCLHfk4NTBOwaqSEQLRgkXNv+t095L9c/EStxq
 xpsMBXloOIb65Lr+qP17/JD6sRyoEHP28otGaB6xRKtVyohwwFrdO5Y/Y
 P+UpUDc6P/xpu6vcZ3Yao4WkFdH+/wEgR1N6/q3d7N4CqvqYrkDKTLVCu
 6v3JQmvI4Gxrg11DtrplQU3VtxCNP6OJGe0yq5jMMY8E5m7IW5u7XRNrM
 Hry3iAA/ymxLnHgnsMBASYqtBL1lYGXFfx99Q9ZuaoqTE6frGWM8R6sK2
 0KeJzApt4sbomTDtvlQp36mq904skRYmHKVA5eALrYVobFZh7levsbEpr Q==;
X-CSE-ConnectionGUID: 3xJ6cwa7SQqnR8G2U8XQzA==
X-CSE-MsgGUID: UuzyMQrlQ/iauC94BUucRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71940234"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="71940234"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 20:52:52 -0800
X-CSE-ConnectionGUID: iZIO+1uBRr2WqDqAiPistg==
X-CSE-MsgGUID: Tg/Q3MCDRtq0iblIdCN5ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="216715398"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa004.fm.intel.com with ESMTP; 11 Feb 2026 20:52:50 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v3 0/7] Add support for L2TPV2 over UDP to ICE PMD
Date: Tue, 26 Aug 2025 21:56:57 +0530
Message-Id: <20250826162704.4636-1-shaiq.wani@intel.com>
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

v4: Version 3 patchset was incomplete due to a server reboot.
    V4 includes all patches for review.

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

