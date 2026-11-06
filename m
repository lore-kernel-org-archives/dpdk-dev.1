Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1FB606A920
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MwB+6K43
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14F94402B8;
	Fri,  6 Nov 2026 10:40:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTPS id 167014026A
 for <dev@dpdk.org>; Fri,  6 Nov 2026 10:40:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793958025; x=1825494025;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qOMwI1FHzsjV9A1NgjyHNi+FFB7LjeUcXYU2yEF1X/k=;
 b=MwB+6K43HtJbtbGS+r3z8xQd3MZZBNUK3KBRuN2apJJsLWwpqTDgzLTv
 S3D6cKbs6Bh77TDcV7PzypyYwHCSaI1Z0I7o0e6+AMpKwebeiXUvpAFbb
 1egnKWPd7MEV8rwuiTA9ZbLvB1kRoRJNzCi4nWi4sUa/WcQYmqzpLvkLK
 NX5BW3164ga518pTF1z6elnyQcZxNYwCzHdcRGACyjuUrXh4uXQa6g2u9
 n6WeAKZ2j1Ij89fDJ8KLYjAFs8T4PjNiljlTp8h13VUdeQAwiMWFu/gBF
 7wMFHvdQwUrutq9M/bCN2DSmTcosGSfxAFsiOkplKUxcc5zURVI5HCTmd g==;
X-CSE-ConnectionGUID: 15z1uqzpRYGhKyPP9fvbjw==
X-CSE-MsgGUID: 0yNZfOAdRRmlNzTXEZecrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2808505"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2808505"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 01:40:23 -0800
X-CSE-ConnectionGUID: gZt8Urf6Qb203qXMGTqhZQ==
X-CSE-MsgGUID: 7zxRfR9aSr6H0H0M9zAZgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7287075"
Received: from silpixa00401177.ir.intel.com (HELO vm-icx177..)
 ([10.20.224.214])
 by orviesa002.jf.intel.com with ESMTP; 06 Nov 2026 01:40:22 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v4 0/4] iavf reset path fixes
Date: Fri,  6 Nov 2026 09:40:08 +0000
Message-ID: <20261106094014.28784-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105123237.12279-1-ciara.loftus@intel.com>
References: <20261105123237.12279-1-ciara.loftus@intel.com>
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

v4 ( patch 3):
* Remove overly defensive check after reset callback
* Added a log on event post failure

Ciara Loftus (4):
  net/iavf: fix crash in Tx drain on PF reset
  net/iavf: fix event handler leak on init failure
  net/iavf: fix watchdog clearing reset state during recovery
  net/iavf: fix watchdog enable racing disable

 drivers/net/intel/iavf/iavf.h        |   7 +-
 drivers/net/intel/iavf/iavf_ethdev.c |  74 +++++++++--------
 drivers/net/intel/iavf/iavf_rxtx.c   |   8 +-
 drivers/net/intel/iavf/iavf_vchnl.c  | 117 +++++++++++++++++----------
 4 files changed, 125 insertions(+), 81 deletions(-)

-- 
2.43.0

