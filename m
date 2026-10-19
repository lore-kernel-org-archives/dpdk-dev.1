Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BCC60820EE
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Za5Q7Rom
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11926402E8;
	Mon, 19 Oct 2026 17:06:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id EEC754028E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 17:06:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792422395; x=1823958395;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=7w5yQBN3kvF142QkoR5odLzsZ96nxDlPDX1NVPQoFTM=;
 b=Za5Q7Romh8/es4cVpVRBeHbf36zCk2YlVPHS5dxPI1jQjxeAb4hxIqJt
 aBVd8N0ssXuUvGXxRVE79oyfsxXtvTkQ0Z6iudsCpNOzvjWe8bYVmj1SA
 cctdw3uwy9CGZmZ1T94f5OXiJYxnsZGH8U8MzJqTicMbJdez8bpaMn2dU
 lc/rp5umoWlEf3sdlOZdhBGfnmB13N0rNwhh0Im5rFXN//x9BMcCAP29s
 2WELXtlH8IGrnUraeA9J2okVZyPOwdJngmaooogO1ODUszhNJZ3RhjDRF
 Qlx4UFcJes9r1/FwZet/72gMRw7/p44jZX3i02RBvML1MV6jY2N/5dTxv g==;
X-CSE-ConnectionGUID: /gt+qZSBQhOawXJFr2sJ2w==
X-CSE-MsgGUID: dwFqX03zTna1T6LJfBREZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1132163"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1132163"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 08:06:34 -0700
X-CSE-ConnectionGUID: mHEKQdOyTmCj+MvnXL2Q6g==
X-CSE-MsgGUID: rpwF2UOtRJqoJZ2Kh6cSCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="4319710"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa012.fm.intel.com with ESMTP; 19 Oct 2026 08:06:32 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v2 0/9] IAVF Fixes
Date: Mon, 19 Oct 2026 16:06:19 +0100
Message-ID: <cover.1792422213.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1791991100.git.anatoly.burakov@intel.com>
References: <cover.1791991100.git.anatoly.burakov@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

An assortment of IAVF flow-related memory leak fixes and cleanups.

v1 -> v2:
- Integrated Anurag's earlier fix [1] into the patchset
- Reworked generic flow to have centralized memory management
- Reordered some patches
- Integrated the IRQ leaks patchset [2] [3]
- Reworked IPsec fix

[1] https://patches.dpdk.org/project/dpdk/patch/20261010121255.528329-1-anurag.mandal@intel.com/
[2] https://patches.dpdk.org/project/dpdk/patch/809e0c5b2ab57f1b14c68be8ac34e70cbbe82233.1792053236.git.anatoly.burakov@intel.com/
[3] https://patches.dpdk.org/project/dpdk/patch/5488d85c2ded08838becaee6de8328694ee00234.1792053236.git.anatoly.burakov@intel.com/

Anatoly Burakov (8):
  net/iavf: keep device stopped if start fails
  net/iavf: do not store ethdev pointer
  net/iavf: fix false success on flow validation
  net/iavf: fix memory leaks around IRQ resources
  net/iavf: fix generic flow error-path leaks
  net/iavf: centralize memory management for flows
  net/iavf: fix null engine for egress security flows
  net/iavf: fix IPsec flow metadata leaks

Anurag Mandal (1):
  net/iavf: fix memory leak in raw pattern parsing

 drivers/net/intel/iavf/iavf.h              |  14 +-
 drivers/net/intel/iavf/iavf_ethdev.c       |  42 +++--
 drivers/net/intel/iavf/iavf_fdir.c         |  68 ++++----
 drivers/net/intel/iavf/iavf_fsub.c         |  23 +--
 drivers/net/intel/iavf/iavf_generic_flow.c |  95 ++++++------
 drivers/net/intel/iavf/iavf_generic_flow.h |   4 +-
 drivers/net/intel/iavf/iavf_hash.c         |  80 +++-------
 drivers/net/intel/iavf/iavf_ipsec_crypto.c | 171 +++++++++++++++++----
 drivers/net/intel/iavf/iavf_ipsec_crypto.h |   4 +-
 drivers/net/intel/iavf/iavf_vchnl.c        |   7 +-
 10 files changed, 296 insertions(+), 212 deletions(-)

-- 
2.52.0

