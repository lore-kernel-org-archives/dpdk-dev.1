Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B75606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cVYCxb+9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F120402B6;
	Fri, 23 Oct 2026 11:32:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 18A1040268
 for <dev@dpdk.org>; Fri, 23 Oct 2026 11:32:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792747961; x=1824283961;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=2pRSFyzcdD/TdaSI4fguieCfs6e4kBgK6ezSm6b5L+s=;
 b=cVYCxb+9jTpy3dDPhkwqoDPGmdR8HQzf6i6uLViInvetrIn6uZs5ykRC
 IfjP+rL+vrFvZwk5l+iX4pm6z2KhXLzdeaAL7bdTWeHmzFgCpcSFI2tFZ
 hkJirT1Bqr4TSTerfMc6/UmbKpIUlSKytoquZwD8pwz2pOpTip/91qenA
 Ilk/rr8n3mVIieYTv0fS3p6Y6Tm+dRDzNWVAeeoxmtcWuyVJCQ4j4wYx4
 Fue8UbsxBhIu7Q2m8InWQ6UjMqq8uEi8Vnh6Ycre6gtMCFly3TUtOIKVe
 PQK+RJFSvbj9fAJbGCSNRDD9oO10P9QfU2JHmQzFI+vJxeZ2WXOdHT3Ni w==;
X-CSE-ConnectionGUID: CUHlFKNFSPi/fjN9OZheEg==
X-CSE-MsgGUID: fKMcNt2dR2qcnxFfZJidjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1498261"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1498261"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 02:32:39 -0700
X-CSE-ConnectionGUID: eQpQg1JoSt+CyUo9xLO31w==
X-CSE-MsgGUID: m3OXwo2YS4GQphhuW8/9lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3509438"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 23 Oct 2026 02:32:38 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v5 00/10] IAVF Fixes
Date: Fri, 23 Oct 2026 10:32:20 +0100
Message-ID: <cover.1792747916.git.anatoly.burakov@intel.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

An assortment of IAVF flow-related memory leak fixes and cleanups.

v4 -> v5:
- Dropped the unnecessary EFD disable from patch 4

v3 -> v4:
- Fixed watchdog crash in commit 2

v2 -> v3:
- Rebase on top of latest next-net-intel including Anurag's fix [1]
- Dropped remnants of Anurag's patch [1] as it's now in the tree
- Fixed PF reset path still tearing down RSS when it shouldn't
- Fixed hash engine checking for VF reset when that's no longer necessary

v1 -> v2:
- Integrated Anurag's earlier fix [1] into the patchset
- Reworked generic flow to have centralized memory management
- Reordered some patches
- Integrated the IRQ leaks patchset [2] [3]
- Reworked IPsec fix

[1] https://patches.dpdk.org/project/dpdk/patch/20261010121255.528329-1-anurag.mandal@intel.com/
[2] https://patches.dpdk.org/project/dpdk/patch/809e0c5b2ab57f1b14c68be8ac34e70cbbe82233.1792053236.git.anatoly.burakov@intel.com/
[3] https://patches.dpdk.org/project/dpdk/patch/5488d85c2ded08838becaee6de8328694ee00234.1792053236.git.anatoly.burakov@intel.com/

Anatoly Burakov (10):
  net/iavf: keep device stopped if start fails
  net/iavf: do not store ethdev pointer
  net/iavf: fix false success on flow validation
  net/iavf: fix memory leaks around IRQ resources
  net/iavf: fix generic flow error-path leaks
  net/iavf: centralize memory management for flows
  net/iavf: skip RSS teardown during PF-initiated reset
  net/iavf: remove redundant reset checks from RSS engine
  net/iavf: fix null engine for egress security flows
  net/iavf: fix IPsec flow metadata leaks

 drivers/net/intel/iavf/iavf.h              |  14 +-
 drivers/net/intel/iavf/iavf_ethdev.c       |  45 ++++--
 drivers/net/intel/iavf/iavf_fdir.c         |  68 ++++----
 drivers/net/intel/iavf/iavf_fsub.c         |  23 +--
 drivers/net/intel/iavf/iavf_generic_flow.c |  95 ++++++------
 drivers/net/intel/iavf/iavf_generic_flow.h |   4 +-
 drivers/net/intel/iavf/iavf_hash.c         | 103 ++++---------
 drivers/net/intel/iavf/iavf_ipsec_crypto.c | 171 +++++++++++++++++----
 drivers/net/intel/iavf/iavf_ipsec_crypto.h |   4 +-
 drivers/net/intel/iavf/iavf_vchnl.c        |   7 +-
 10 files changed, 300 insertions(+), 234 deletions(-)

-- 
2.52.0

