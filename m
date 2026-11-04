Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C38606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 09:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XlL3GCJm
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A985406B7;
	Wed,  4 Nov 2026 10:55:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTPS id 69E5240151
 for <dev@dpdk.org>; Wed,  4 Nov 2026 10:55:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793786128; x=1825322128;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/O/yNXxgaZrcxFwVOwTilPUJYJoA2xHx63RYHDdZyj0=;
 b=XlL3GCJmu7nigOIvDA+ad/wg0RIdI97dVc6W9HIPUTpahF7yqe8sM7FG
 PXCBDMgHXF/NeMgrVBAkYCs2SyjL6iCXBGOFnarHMA3CLHnrHtALuZ7mm
 jpfC9VYMuuWeCYxOqATqKxHtJXaeaImBeDarPv6Dz/EDicAusREJttQrK
 uNVD8Y6Nbx8ZUgduLCmmHyAWRqNQcljfbJGYscyQn/m0chthjQStFkrZe
 S2YdqWk904dLZM8tRbVaADhXvYJYLX5ssJAfmVXfbMOPCE0DKAIUlNxL3
 WnxbodSVbiOQN6VGDPFx4jcbIs86wOuOX4OwO+uCnXXMTWMizoDDSWgDq A==;
X-CSE-ConnectionGUID: q5B9bmsFSuyOMHmMv9i5Sg==
X-CSE-MsgGUID: gwg0DtttRrOBM4fZwHTJxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2432690"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2432690"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 01:55:26 -0800
X-CSE-ConnectionGUID: 9SyiPDmvQ3KZBUAfXgX7QA==
X-CSE-MsgGUID: kSpN2Wx6QFKwlNYBJfelPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6699054"
Received: from silpixa00401177.ir.intel.com (HELO vm-icx177..)
 ([10.20.224.214])
 by orviesa001.jf.intel.com with ESMTP; 04 Nov 2026 01:55:25 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 0/3] iavf reset path fixes
Date: Wed,  4 Nov 2026 09:55:06 +0000
Message-ID: <20261104095510.10246-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
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

Three fixes related to the reset path in iavf. The first patch
was submitted as a standalone patch [1], but I've grouped it into
this series.

[1] https://patches.dpdk.org/project/dpdk/patch/20261102154558.78361-1-ciara.loftus@intel.com/

Ciara Loftus (3):
  net/iavf: fix crash in Tx drain on PF reset
  net/iavf: fix event handler leak on init failure
  net/iavf: fix watchdog clearing reset state during recovery

 drivers/net/intel/iavf/iavf.h        |  4 ++-
 drivers/net/intel/iavf/iavf_ethdev.c | 21 +++++++++---
 drivers/net/intel/iavf/iavf_rxtx.c   |  8 ++---
 drivers/net/intel/iavf/iavf_vchnl.c  | 48 ++++++++++++++++++++--------
 4 files changed, 56 insertions(+), 25 deletions(-)

-- 
2.43.0

