Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F86606A319
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JP2M5Ypd
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D001640270;
	Tue, 20 Oct 2026 11:11:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 7332140144
 for <dev@dpdk.org>; Tue, 20 Oct 2026 11:11:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792487499; x=1824023499;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=+wGyz/bKzwxFmxu+hyVdQw9LMNhoDkk4cMeIfigZHzo=;
 b=JP2M5YpdTuGgsIWAHrGyYzVkUOgrf8lw1snujl4pzP9o2Rpef6NYgjNE
 91qjEhANR8gOUOhrxJRfuQ8Dh9jICST+zK/GvGHYMhF/erznYck1c5aEJ
 UZJI/bLC9lWcaJJ0CqsrW/MSdakYFLXYVVjFaFpj/MoTuFLuAGm7d6fTs
 wwYRn//0ODY84zkkcABVe/InzN3cyYH7G0lCgYQDRwtX34oIqF3TxHXFh
 njxza8WbhhFyqCGlEKdvOU6A5qPcHe5bpM6PrPtgUpNOppWnC+9H2OqMB
 x8K13sWkh5hl0hY3us8fOydFuP+L4fONKbU813lHabvdwpRbE0gbWlN2J A==;
X-CSE-ConnectionGUID: x195kRvJRI6VVq32JfM1cA==
X-CSE-MsgGUID: nlRwzSW9Th2vhyEr9HXBtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1286804"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1286804"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 02:11:38 -0700
X-CSE-ConnectionGUID: y40PLxhtQyCOZPAgGr5ifw==
X-CSE-MsgGUID: kChRhS2kTiuH2UeXTLn8Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2879429"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa002.fm.intel.com with ESMTP; 20 Oct 2026 02:11:37 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 00/10] IAVF Fixes
Date: Tue, 20 Oct 2026 10:11:23 +0100
Message-ID: <cover.1792487374.git.anatoly.burakov@intel.com>
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
 drivers/net/intel/iavf/iavf_ethdev.c       |  50 +++---
 drivers/net/intel/iavf/iavf_fdir.c         |  68 ++++----
 drivers/net/intel/iavf/iavf_fsub.c         |  23 +--
 drivers/net/intel/iavf/iavf_generic_flow.c |  95 ++++++------
 drivers/net/intel/iavf/iavf_generic_flow.h |   4 +-
 drivers/net/intel/iavf/iavf_hash.c         | 103 ++++---------
 drivers/net/intel/iavf/iavf_ipsec_crypto.c | 171 +++++++++++++++++----
 drivers/net/intel/iavf/iavf_ipsec_crypto.h |   4 +-
 drivers/net/intel/iavf/iavf_vchnl.c        |   7 +-
 10 files changed, 303 insertions(+), 236 deletions(-)

-- 
2.52.0

