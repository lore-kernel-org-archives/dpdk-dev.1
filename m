Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14411C71159
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 04:03:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB76440287;
	Thu, 19 Jun 2025 06:03:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id A16C34021F
 for <dev@dpdk.org>; Thu, 19 Jun 2025 06:03:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750305802; x=1781841802;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=y5aLdDJF1iDAYU5l9BuFIyIQCdGZ8QmOOZ7AMk1Weko=;
 b=Mest6ygBTfmFejKmMDkMw0y4MMYFNSZUggSxG9QA0IG8vULlSyTf5NoQ
 gMMGQjEgM+wapGJyoa9pOXMH5c2BvnGQr3k7cYiLLgDEQxWLhpfkZuesx
 brWmMduZxcCp8FBJBahtFhDXJTiEBy6IYwxarF7W9lQkYzjR6hxRtqqMO
 tvMSguLypSCzcPs4561q+E/TLCmvVcG6Wj0ZNbOSq+Vkm1GmIiosB3SC3
 ADlDDuth0yoc3i4yzGsrbuYCwQVJwu+8FzS0uyXR62iA7GPK/OpsnfNim
 UqWCs3XU+GH+kL46GBfkgATPZC4ZBVxYbHF5hkjKOrEnQWDz5xE4QFlLH w==;
X-CSE-ConnectionGUID: 9k3Jl22ZQJCwXElG0WFnfQ==
X-CSE-MsgGUID: IrBsZITxRoeVAi2zrJ3kdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="63592726"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; d="scan'208";a="63592726"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2025 21:03:21 -0700
X-CSE-ConnectionGUID: Js/8dtXsTZyVglfBzJseog==
X-CSE-MsgGUID: tpQ23U98Rquu4FgHM2Tlcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; d="scan'208";a="150665468"
Received: from txanpdk02.an.intel.com ([10.123.117.76])
 by orviesa007.jf.intel.com with ESMTP; 18 Jun 2025 21:03:20 -0700
From: Pravin Pathak <pravin.pathak@intel.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 Pravin Pathak <pravin.pathak@intel.com>
Subject: [PATCH v4 0/7] event/dlb2: dlb2 hw resource management
Date: Wed, 18 Jun 2025 23:03:09 -0500
Message-Id: <20250619040316.317733-1-pravin.pathak@intel.com>
X-Mailer: git-send-email 2.39.1
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

This patchset introduces various fixes related to dlb2 hw resource
management. The dlb2 hw has limited resources, which are configurable
using command line options. This patch allows managing History list,
scheduling bandwidth and credits using command line options. It also
fixes some issues with resources management.

v2:
  [PATCH v1 3/7] Addressed issue with Fixes tag
  [PATCH v1 4/7] Renamed structure and Macros to avoid
                 name space conflicts.
  [PATCH v1 4/7] Addressed Doxygen format feedback

v3:
  [PATCH v2 1/7] Added Fixes tag
  [PATCH v2 2/7] Added Fixes tag
  [PATCH v2 3/7] Added Fixes tag
  [PATCH v2 5/7] Added Fixes tag
  [PATCH v2 6/7] Added Fixes tag
  [PATCH v2 7/7] Added Fixes tag

v4:
  [PATCH v3 4/7] Fixed Doxygen format and parameter type
	               to rte_pmd_dlb2_set_port_param()
								 Fixed other documentation feedback

Pravin Pathak (6):
  event/dlb2: fix addresses deq failure when CQ depth <= 16
  event/dlb2: fix validaton of LDB port COS ID arguments
  event/dlb2: fix num single link ports for DLB2.5
  event/dlb2: support managing history list resource
  event/dlb2: fix to avoid credit release race condition
  event/dlb2: fix qid depth xstat in vector path

Tirthendu Sarkar (1):
  event/dlb2: fix default credits based on HW version

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
 drivers/event/dlb2/rte_pmd_dlb2.h          |  55 ++++-
 11 files changed, 476 insertions(+), 64 deletions(-)

-- 
2.39.1

