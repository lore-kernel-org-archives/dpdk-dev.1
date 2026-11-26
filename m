Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2299C606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 13:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MoedMiGB
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BB8D4042C;
	Thu, 26 Nov 2026 14:29:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTPS id E1DDB402BD
 for <dev@dpdk.org>; Thu, 26 Nov 2026 14:29:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795699757; x=1827235757;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=dvRxageX7wn1nw/IvZWZ2HbmbXjnISHovM1U3CDzlIw=;
 b=MoedMiGBhrHkQ/R/hwOCaiatGEHM1u8FmpDl65mm1iLky/p7atLXTJEi
 6TiF9ko1heFwkQjbu41e892TWdvyL9HlFcoLR5fMv1iOzw3F9NgbNphXf
 LKWrED8EFUTfiS74naREpOgL/PHZ6X5lgeBJrdlMtyoAimLzVQwyV6qYo
 hVAE291Tx62mfnMWdWF6meFR9m4APwwWbcurMVp26XxIPiKglbejqxser
 AwmAWT5HFowOZfU81kiYJIZy6rCza6wVG/JFM+Mn9sq2sHcPGWPOcIdfD
 tOgfaPMCw5CZ2Ts5j0G4DspMn8Fr2ZPpB1JmXXPE+jX3MQeL2rLNIScFS g==;
X-CSE-ConnectionGUID: FO4jpD7+QIyXEn86Hevhig==
X-CSE-MsgGUID: Advb380YTXK8wTO6H/XUEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4578851"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4578851"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 05:29:15 -0800
X-CSE-ConnectionGUID: G/jVp4jLTyumERB4+zfdCw==
X-CSE-MsgGUID: 6jhy4e0LQTKE91MDQfjBIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; d="scan'208";a="12032039"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 26 Nov 2026 05:29:14 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 0/4] net/i40e: fix interrupt support
Date: Thu, 26 Nov 2026 13:29:04 +0000
Message-ID: <20261126132909.3488716-1-bruce.richardson@intel.com>
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

Bugzilla issues 1345, 1346 and 1347 highlight some issues with interrupt
support in i40e driver, and in the process of investigating these, with
AI assistance, a number of other issues with the support in that driver
were discovered. This patchset therefore fixes the newly discovered
issues as well as bugzilla ids 1345 and 1347. Issue 1346 is not covered
in this set - the exact correct behaviour according to ethdev contract
is a little unclear so that is left for future work.

Bruce Richardson (4):
  net/i40e: fix VMDq Rx interrupt vector mapping
  net/i40e: handle Rx interrupt vector lookup errors
  net/i40e: disallow interrupt support in secondaries
  net/i40e: fix Rx descriptor write-back with interrupts disabled

 drivers/net/intel/i40e/i40e_ethdev.c | 269 ++++++++++++++++++++++++---
 drivers/net/intel/i40e/i40e_ethdev.h |  20 +-
 drivers/net/intel/i40e/i40e_fdir.c   |   2 +-
 drivers/net/intel/i40e/i40e_pf.c     |   2 +-
 4 files changed, 261 insertions(+), 32 deletions(-)

--
2.55.0

