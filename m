Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D853C3ABC3
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 May 2025 04:24:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EF52402E1;
	Fri,  9 May 2025 06:24:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 639D34026B
 for <dev@dpdk.org>; Fri,  9 May 2025 06:24:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746764649; x=1778300649;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=aFxH0KqBDQ4/LhUbCaASIiZxdEBCNNEJ639X37Ize4I=;
 b=jWdsRUnbd1F5/ypsTVL4z4hOysN3/DCvTOP/fFiQYsX5IOYFPfkwg0ZH
 PO7jCs/SvPMzOzHo6PnkFndzN5+TbWnG/fDaVmLxpXtCt6XmzRzZm11fH
 eviLVblZXGiN+LPaPQ3lEyS+PA1uPzvOwID74o7oA9EqmIlLrkyuzLQA3
 l+/rMX50ALu0NIf2xAus4hrlSunCCTJ8en2fAtF6ppbjRcRmF31zjSyZp
 1rMQlWWInQjsFnkGXC0rA0OC6wgcdFMA0m3K772Th1j4Xfgdl181d+lLw
 TJ93FgOyv9GDOkMHnUnTm3N2WNB6EYV2CADyO9p90oO1yWY1I1cuRldC0 A==;
X-CSE-ConnectionGUID: 49ShTbVrTjaUtS1HiE8kEA==
X-CSE-MsgGUID: 7upmDsdaS5aPrOPHZG9GIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48692412"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="48692412"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 21:24:08 -0700
X-CSE-ConnectionGUID: 2pPFAFU5TFGd/6fx9tzIYw==
X-CSE-MsgGUID: 87492ubFRTGyrsY7gQ2gVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="136388781"
Received: from txanpdk02.an.intel.com ([10.123.117.76])
 by orviesa010.jf.intel.com with ESMTP; 08 May 2025 21:24:08 -0700
From: Pravin Pathak <pravin.pathak@intel.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 Pravin Pathak <pravin.pathak@intel.com>
Subject: [PATCH v1 0/7] event/dlb2: dlb2 hw resource management
Date: Thu,  8 May 2025 23:23:54 -0500
Message-Id: <20250509042401.2634765-1-pravin.pathak@intel.com>
X-Mailer: git-send-email 2.25.1
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

Pravin Pathak (6):
  event/dlb2: addresses deq failure when CQ depth <= 16
  event/dlb2: changes to correctly validate COS ID arguments
  event/dlb2: return 96 single link ports for DLB2.5
  event/dlb2: support managing history list resource
  event/dlb2: avoid credit release race condition
  event/dlb2: update qid depth xstat in vector path

Tirthendu Sarkar (1):
  event/dlb2: fix default credits in dlb2_eventdev_info_get()

 drivers/event/dlb2/dlb2.c                  | 274 +++++++++++++++++----
 drivers/event/dlb2/dlb2_iface.c            |   5 +-
 drivers/event/dlb2/dlb2_iface.h            |   4 +-
 drivers/event/dlb2/dlb2_priv.h             |  20 +-
 drivers/event/dlb2/dlb2_user.h             |  24 ++
 drivers/event/dlb2/pf/base/dlb2_regs.h     |   9 +
 drivers/event/dlb2/pf/base/dlb2_resource.c |  74 ++++++
 drivers/event/dlb2/pf/base/dlb2_resource.h |  18 ++
 drivers/event/dlb2/pf/dlb2_pf.c            |  33 ++-
 drivers/event/dlb2/rte_pmd_dlb2.c          |  23 ++
 drivers/event/dlb2/rte_pmd_dlb2.h          |  40 +++
 drivers/event/dlb2/version.map             |   1 +
 12 files changed, 463 insertions(+), 62 deletions(-)

-- 
2.25.1

