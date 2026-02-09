Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B79E81BDA
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 15:21:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8859D402B0;
	Mon,  9 Feb 2026 16:21:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 74E074028F
 for <dev@dpdk.org>; Mon,  9 Feb 2026 16:21:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770650464; x=1802186464;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=OBg1cbEIJwtwebO1xUn08DrmQRWzNTrqY/7CyiaLmt0=;
 b=bEQWUXVYbycso/T4W4dI0rUjvfK4fX/EUdca7+7Kfaby3GzHtYwlqyBW
 V5QInjswMblkG9EIpKnfxMRaYXrISuPQaSNCsWIVCcxficU8iarRgiVPe
 9etQdHLpnq0eV/I5SujgCTWxcH1UY9Y+Tj+NlKtWNAyraNEHh77s+yII6
 udj580pJgnuTMUVq4qaeUCUBgnHGYNhqCTRl77wZ5bpb1BkDnjj0Q4yXh
 Uq2sJ8+GY1pHZKz2gVWQo+uDiq/ezn7EZNepdz4WoZFmYgGvSwqhQxwnb
 oFp7Lqsx4HM6BY2H8zBBOL1sTsvu4wknhsLUoW/BSJwzQYkiayE+qGoFK Q==;
X-CSE-ConnectionGUID: riAXLdMxT2y+xFJB/pqbrg==
X-CSE-MsgGUID: LyMgXy9wQlGHOkhUBPAhoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71749094"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71749094"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 07:21:03 -0800
X-CSE-ConnectionGUID: 0r1lEQyESoqBH4J96IDOfA==
X-CSE-MsgGUID: T5djd7l8Qk6yMTi1VYq1Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="211676120"
Received: from silpixa00401921.ir.intel.com ([10.20.224.96])
 by orviesa007.jf.intel.com with ESMTP; 09 Feb 2026 07:21:02 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 0/2] iavf: use ptype for LLDP and add AVX2 ctx paths
Date: Mon,  9 Feb 2026 15:20:47 +0000
Message-ID: <20260209152049.1640121-1-ciara.loftus@intel.com>
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

This series changes the iavf driver to use the mbuf packet type
field instead of a dynamic field for LLDP packets, and adds new AVX2
context descriptor Tx paths which support LLDP.

Ciara Loftus (2):
  net/iavf: use mbuf packet type instead of dynfield for LLDP
  net/iavf: add AVX2 context descriptor Tx paths

 doc/guides/nics/intel_vf.rst                |  16 +-
 doc/guides/rel_notes/release_26_03.rst      |   2 +
 drivers/net/intel/iavf/iavf.h               |   2 +
 drivers/net/intel/iavf/iavf_ethdev.c        |  13 +-
 drivers/net/intel/iavf/iavf_rxtx.c          |  21 +-
 drivers/net/intel/iavf/iavf_rxtx.h          |  12 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c | 386 ++++++++++++++++++++
 drivers/net/intel/iavf/iavf_testpmd.c       |  20 +-
 drivers/net/intel/iavf/rte_pmd_iavf.h       |  10 +
 9 files changed, 448 insertions(+), 34 deletions(-)

-- 
2.43.0

