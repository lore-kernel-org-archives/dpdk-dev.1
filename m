Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE41606A31B
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 12:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PIXEn0Aa
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CE7040DF8;
	Thu,  5 Nov 2026 13:33:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTPS id 0FC3C40296
 for <dev@dpdk.org>; Thu,  5 Nov 2026 13:32:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793881980; x=1825417980;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RzA2tSuRRYnGl8LgdEzhaAabfZVuHqyqkH/GjGXf4O8=;
 b=PIXEn0Aa1TT1S/p73VLqw6eMYtaVnyjePdXXGEqVMf4vE5NshJNdLOc1
 t6U0PkHi/LAQJitFormeBQsJ1OUfs9LbsiGdSOtTRGUQ8+tK3kIg4KIaj
 o70oVkE33s83lAH7oxbL97MHz0ncv/Lz65EMmAiC78H5T3vu97fuVCwGx
 kLMCKFd3hULOCAhRjoApexofcJGe3chpdmAnOw8J5L37tv410pS7iInRb
 Kv6QoiyRP2gZcJGPC4vUeeiVTOyBc37Q76m8RacKL/FiscW+Vfrlrozj6
 tnEb4re/ERv9LOqKhLNHvT+L6YQylan+neymcXys7hEm4zuWMgoTT7GFD A==;
X-CSE-ConnectionGUID: LF1kXHl2Sbq0RTouaWEPqQ==
X-CSE-MsgGUID: yvYvPOANR72mbASYmZ3jrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2556057"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2556057"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 04:32:57 -0800
X-CSE-ConnectionGUID: V5kUymiJQBG/egXXp+BUUQ==
X-CSE-MsgGUID: IGILfAuESd+PPTDhllrS+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7062110"
Received: from silpixa00401177.ir.intel.com (HELO vm-icx177..)
 ([10.20.224.214])
 by orviesa006.jf.intel.com with ESMTP; 05 Nov 2026 04:32:57 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v3 0/4] iavf reset path fixes
Date: Thu,  5 Nov 2026 12:32:24 +0000
Message-ID: <20261105123237.12279-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104095510.10246-1-ciara.loftus@intel.com>
References: <20261104095510.10246-1-ciara.loftus@intel.com>
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

Four fixes related to the reset path in iavf.

v3:
* Patch 3: made the vf_reset flag atomic and moved entry to the reset
  state into a helper.
* Added patch 4, fixing a race between watchdog enable and disable.

Ciara Loftus (4):
  net/iavf: fix crash in Tx drain on PF reset
  net/iavf: fix event handler leak on init failure
  net/iavf: fix watchdog clearing reset state during recovery
  net/iavf: fix watchdog enable racing disable

 drivers/net/intel/iavf/iavf.h        |   7 +-
 drivers/net/intel/iavf/iavf_ethdev.c |  74 +++++++++--------
 drivers/net/intel/iavf/iavf_rxtx.c   |   8 +-
 drivers/net/intel/iavf/iavf_vchnl.c  | 120 ++++++++++++++++++---------
 4 files changed, 128 insertions(+), 81 deletions(-)

-- 
2.43.0

