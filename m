Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A28606CC71
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B3to5Gyw
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2553B402F2;
	Thu,  5 Nov 2026 10:52:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTPS id 0E2E140281
 for <dev@dpdk.org>; Thu,  5 Nov 2026 10:52:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793872354; x=1825408354;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Dqe+2Il0EKHwWA1PiTFsMqYoWQY1n1AW135zdCV0nuE=;
 b=B3to5Gywrzgx+3ztYth42t5JbTy2Euc852bz4rfkfZbf551egXLv8Hjl
 mCn9ttwENuTP0RURNZUzkWb64dRGgpQMwH6tq3KnfX0WHglC4+DwAf+TQ
 LVUY8jk/CmOERfYGxSy+xhl6MrltyayA0Mr2IKQ8uy/kzqf7ufssfY6j9
 OzHtusg4L5DFHNmPMh1duVGPnlfiB6T7tSkJ/p3dtzwKd+IBrTRa+MR0y
 xMK1IpuYu3NskuMRIajELmz+RVwVsvC1sW8wS3XjNSqBelZGaH9zutNYH
 C3UPAhW79J+EeDYdVnwuQZULbBHcLVlejVfRLK10V+tUfVPxA//XoA8tH Q==;
X-CSE-ConnectionGUID: ycLiZz/6Qj6OtpRwl4dveA==
X-CSE-MsgGUID: ZSxesZMoRsaqCxdI1ar3XQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2683950"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2683950"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 01:52:31 -0800
X-CSE-ConnectionGUID: dms9x4g+S5iIQ0KHAqHsmQ==
X-CSE-MsgGUID: fqAxc8wURJadIlJwqwid/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7034170"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by orviesa006.jf.intel.com with ESMTP; 05 Nov 2026 01:52:29 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH 0/8] net/ice: fix DCF memory leaks
Date: Thu,  5 Nov 2026 09:47:17 +0000
Message-Id: <cover.1793871697.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.25.1
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

This patch series fixes memory leaks, and related error path issues, 
in the ice DCF driver.

1. The VF VSI map leaked on DCF hardware init failure, and a failed
   VLAN capability query left the interrupt callback registered.

2. A failed DCF parent adapter init leaked the dummy main VSI, and a
   failed flow init also leaked the DDP parser and flow engine state.

3. The queue config message leaked when the required RXDID was not
   supported.

4. The temporary QoS bandwidth buffers still leaked on every
   successful hierarchy commit.

5. The QoS bandwidth config saved for replay leaked on every commit,
   close and reset.

6. TM nodes and shaper profiles leaked on close when the hierarchy was
   never committed.

7. The representor info leaked when the DCF port was closed.

8. A failed probe left the DCF port and its representors behind. A
   representor type other than VF is now rejected before the DCF port
   is created.

Anurag Mandal (8):
  net/ice: fix DCF hardware init error path
  net/ice: fix DCF parent adapter init error path
  net/ice: fix DCF queue config buffer leak
  net/ice: fix DCF QoS buffer leak on commit
  net/ice: fix DCF QoS bandwidth replay config leak
  net/ice: fix DCF TM config leak on close
  net/ice: fix DCF representor info leak on close
  net/ice: fix DCF port leak on probe failure

 drivers/net/intel/ice/ice_dcf.c        | 27 ++++++++++++---
 drivers/net/intel/ice/ice_dcf_ethdev.c | 48 +++++++++++++++++++-------
 drivers/net/intel/ice/ice_dcf_parent.c |  9 +++--
 drivers/net/intel/ice/ice_dcf_sched.c  |  4 +++
 4 files changed, 68 insertions(+), 20 deletions(-)

-- 
2.25.1

