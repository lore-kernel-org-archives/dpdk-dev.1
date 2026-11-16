Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539C8606A335
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EV3a2m5c
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8618540294;
	Mon, 16 Nov 2026 17:09:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTPS id 4115F40150
 for <dev@dpdk.org>; Mon, 16 Nov 2026 17:09:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794845380; x=1826381380;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=XwbJK3Yf/Ja5BK0jZZd6xG5m5FVXj2ab+JgSR42EL2s=;
 b=EV3a2m5c+4slLkIkUrcbsEL6QqNAiMbesZWjhIIfvFAJk8je5hpCppM6
 Gq7SuYjdFmt731EaKvQrduDk/4pygASxcNbFVtBk5skCVmkhjLUJobdup
 +CNxsieikyN8oPmL0motSYo1HlPMX9KMWt42u1F/XYTU5vjzq9jjg5LUj
 1y8n5bLpUf5l0zmlg2HQPA4YGlIR7rH0FzLAI5GZcgFX7XiNhKmsUoecy
 U89FGFZ4bAiNUdb1XX50400BXhbsOkS3xk/9duBgRZX02DrFQ4Sqa95ZL
 GoEHa/++SwpMGN6qjxoWqtbf1sC27f4NoYAF3QhrWGqqX3lp966RyD9wa g==;
X-CSE-ConnectionGUID: 3G/S0vAORTG0VAkIQ9s4VQ==
X-CSE-MsgGUID: x6KZB1fMTPOhth4RUXkEZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3481858"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3481858"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 08:09:38 -0800
X-CSE-ConnectionGUID: V7u3X/SuRae8E86EeE0/9Q==
X-CSE-MsgGUID: tfFM6FKDTPy4si6RD2omNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9926969"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa009.fm.intel.com with ESMTP; 16 Nov 2026 08:09:38 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 27.03 0/6] eliminate unnecessary dynamic allocation
Date: Mon, 16 Nov 2026 16:09:26 +0000
Message-ID: <20261116160932.1006354-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

To reduce the possibility of bugs due to missing memory freeing on error
paths (or even the success path) in functions, we can switch memory use
from dynamic heap memory to stack memory in functions where both
allocation and free occur within the one function, and where the total
memory size is not very large (~4K max).

To facilitate this, the first patch of the series defines a new macro to
simplify the creation of stack objects which are of the format
struct+extra buffer, where the extra buffer space is sized to hold N
objects from a flex array member at the end of the primary structure.
That macro is then used throughout the drivers to define most of the new
stack variables used for e.g. admin queue messages.

Bruce Richardson (6):
  eal: add macros for local variable-length structure buffers
  net/iavf: use stack storage for virtchnl messages
  net/ice: use stack storage for function-local buffers
  net/idpf: use stack storage for virtchnl messages
  net/cpfl: use stack storage for function-local buffers
  net/i40e: use stack storage for function-local buffers

 app/test/test_common.c                        |  54 ++++
 drivers/net/intel/cpfl/cpfl_fxp_rule.c        |  20 +-
 drivers/net/intel/cpfl/cpfl_representor.c     |  15 +-
 drivers/net/intel/cpfl/cpfl_vchnl.c           |  41 ++-
 drivers/net/intel/i40e/i40e_ethdev.c          |  27 +-
 drivers/net/intel/i40e/i40e_testpmd.c         |  10 +-
 drivers/net/intel/iavf/iavf_ipsec_crypto.c    | 270 +++++-------------
 drivers/net/intel/iavf/iavf_tm.c              |  26 +-
 drivers/net/intel/ice/ice_dcf.c               |  21 +-
 drivers/net/intel/ice/ice_dcf_parent.c        |  12 +-
 drivers/net/intel/ice/ice_dcf_sched.c         |  25 +-
 drivers/net/intel/ice/ice_diagnose.c          |  12 +-
 drivers/net/intel/ice/ice_ethdev.c            | 104 ++-----
 drivers/net/intel/ice/ice_rxtx.c              |  26 +-
 drivers/net/intel/ice/ice_tm.c                |   7 +-
 drivers/net/intel/idpf/idpf_common_device.c   |  27 +-
 drivers/net/intel/idpf/idpf_common_virtchnl.c |  77 ++---
 lib/eal/include/rte_common.h                  |  46 +++
 18 files changed, 306 insertions(+), 514 deletions(-)

--
2.55.0

