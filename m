Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0594C71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 18:26:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3273402CE;
	Tue, 17 Jun 2025 20:26:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 55BD4402C5
 for <dev@dpdk.org>; Tue, 17 Jun 2025 20:26:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750184796; x=1781720796;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7Jo+W89V91gthUa0r6KTu7utSJDdBIA3kfJa81Ic+1I=;
 b=cFiSbI1ShltmI6S2faxj0kipHi4Se5ZJ66jvUV+LofB/uEr49BP82Vfx
 a3vl6vlGJrh+eHS+GuInRBKjQbwGSz5h6/uApHUPIipIs9scBNf/uZxms
 biZiGRHpyym76mwHZZ+mKH9CNW6x8FsXzQcoIzLIRfNqX8ndwen+jzsrP
 9FyuMt623qKJXoGPqdoR/DlmjedKaba+sEhDvYaHdYpN8GIUrH2bYEKrL
 rlREV87ZWZno/wdFu1s1YO6wL8vDUZTqBrGPcX5VsrHimC2XVJLPnYdg1
 EqkpVqXjctq4IlIrrNJ5MUrni76n6/mXnbcD0ezP6hsN6goeK5bu7d+bW Q==;
X-CSE-ConnectionGUID: kTuLgYkVQF+kmxnnGh3O+g==
X-CSE-MsgGUID: 1TU5S5AjSzWdgArjSoBRWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="63737710"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; d="scan'208";a="63737710"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 11:26:35 -0700
X-CSE-ConnectionGUID: 0wGSF/IsTCOpB5WU4s15ZA==
X-CSE-MsgGUID: q9ELLhjxQY6Y1YDr//WFnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; d="scan'208";a="153622597"
Received: from txanpdk02.an.intel.com ([10.123.117.76])
 by orviesa003.jf.intel.com with ESMTP; 17 Jun 2025 11:26:34 -0700
From: Pravin Pathak <pravin.pathak@intel.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 Pravin Pathak <pravin.pathak@intel.com>
Subject: [PATCH v3 0/7] event/dlb2: dlb2 hw resource management
Date: Tue, 17 Jun 2025 13:26:23 -0500
Message-Id: <20250617182631.257612-1-pravin.pathak@intel.com>
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
  [PATCH v1 1/7] Added Fixes tag
  [PATCH v1 2/7] Added Fixes tag
  [PATCH v1 3/7] Added Fixes tag
  [PATCH v1 5/7] Added Fixes tag
  [PATCH v1 6/7] Added Fixes tag
  [PATCH v1 7/7] Added Fixes tag


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
 drivers/event/dlb2/rte_pmd_dlb2.h          |  48 +++-
 11 files changed, 470 insertions(+), 63 deletions(-)

-- 
2.39.1

