Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C1DC5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 18:05:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB895410EA;
	Tue,  3 Jun 2025 20:05:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 5169540DCB
 for <dev@dpdk.org>; Tue,  3 Jun 2025 20:05:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748973919; x=1780509919;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RjT4o8d7RnmvAJgHJwa9uyEPOmYI5Onxyg3XEXo1164=;
 b=HTuMmIpwC8bic3I51yHSWduup8Oe4fEaO0fUoR1EqXKNuzVR9OFu8Wln
 WMWNDxgzpXjq3xo8wdrnEp+9hmR+woS1t3jDxVRaPAIWueuSKD7YkRDW1
 vHbQLPEAx3ltnPmRll+B1NH6PShgpXV5pwU6WjH5TIQzfPPeX6kEpXoy3
 W3rvdreCeyEEPYbtakknB+Bg7VTivmg7eWnv+iXliXSAUVAnBWNsc/KgR
 WRM7aNyDmpuOUgPs1DG8NaCx0LBvIOyEUVVMKbz06HoeKK5DKKaD6zCDR
 /kP4rMDtYB455Lq75SDclQh5RjAJ7LukJWgp0BLn1QBh77ydJUaI3TeIK A==;
X-CSE-ConnectionGUID: XNrZJpyATm6C54mi5nwzPA==
X-CSE-MsgGUID: 9sE6fI/YSVaE/Ssf9fOPnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="68463567"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="68463567"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 11:05:18 -0700
X-CSE-ConnectionGUID: 0ixruk1STYCjvUWEGEhFaA==
X-CSE-MsgGUID: v/UecfRbQjaGsdXoqih2IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="168110469"
Received: from txanpdk02.an.intel.com ([10.123.117.76])
 by fmviesa002.fm.intel.com with ESMTP; 03 Jun 2025 11:05:17 -0700
From: Pravin Pathak <pravin.pathak@intel.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 Pravin Pathak <pravin.pathak@intel.com>
Subject: [PATCH v2 0/7] event/dlb2: dlb2 hw resource management
Date: Tue,  3 Jun 2025 13:05:07 -0500
Message-Id: <20250603180514.3826917-1-pravin.pathak@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250509042401.2634765-1-pravin.pathak@intel.com>
References: <20250509042401.2634765-1-pravin.pathak@intel.com>
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

v2:
	[PATCH v1 3/7] Addressed issue with Fixes tag
	[PATCH v1 4/7] Renamed structure and Macros to avoid
				         name space conflicts.
	[PATCH v1 4/7] Addressed Doxygen format feedback

Pravin Pathak (6):
  event/dlb2: addresses deq failure when CQ depth <= 16
  event/dlb2: changes to correctly validate COS ID arguments
  event/dlb2: return 96 single link ports for DLB2.5
  event/dlb2: support managing history list resource
  event/dlb2: avoid credit release race condition
  event/dlb2: update qid depth xstat in vector path

Tirthendu Sarkar (1):
  event/dlb2: return default credits based on HW version

 drivers/event/dlb2/dlb2.c                  | 274 +++++++++++++++++----
 drivers/event/dlb2/dlb2_iface.c            |   5 +-
 drivers/event/dlb2/dlb2_iface.h            |   4 +-
 drivers/event/dlb2/dlb2_priv.h             |  20 +-
 drivers/event/dlb2/dlb2_user.h             |  24 ++
 drivers/event/dlb2/pf/base/dlb2_regs.h     |   9 +
 drivers/event/dlb2/pf/base/dlb2_resource.c |  74 ++++++
 drivers/event/dlb2/pf/base/dlb2_resource.h |  18 ++
 drivers/event/dlb2/pf/dlb2_pf.c            |  33 ++-
 drivers/event/dlb2/rte_pmd_dlb2.c          |  24 ++
 drivers/event/dlb2/rte_pmd_dlb2.h          |  48 +++-
 11 files changed, 470 insertions(+), 63 deletions(-)

-- 
2.25.1

