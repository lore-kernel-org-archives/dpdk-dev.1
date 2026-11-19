Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768FD606A326
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mZ31IFAu
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4BB1402DF;
	Thu, 19 Nov 2026 08:31:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTPS id 1D76C402DA
 for <dev@dpdk.org>; Thu, 19 Nov 2026 08:31:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795073517; x=1826609517;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=I9zcShVTk63JD/qOqa/fi3jlKt5CXlicYnteIcJAAoM=;
 b=mZ31IFAuIvhyVB4uIPt4a/MS3jCBS9ekT4LVKHj4ArN0ZRxlWqDw3sM1
 DcEyhCsKNfJRVCQIO9XtHz6Rs+0Xvs0b52+Vf6WmoHaZx7daqY8CAvTte
 x+5uZWGY9V69/wmawLM7dQ6s+4I/MfGVa0OoEasJL5KhzQOwxaQcrbs4s
 PLCrUD4TX2WuB00Eptfnq8KM0vcqPuFixTTjt6bnMAy3sLou0M6R/D8pb
 78ejC4rm3lnoO5vnNvduSsEN42AW3qP1msquer8E6TmZ01LgPcs4NSagA
 klghPIGn2FR7h11x0IBCbpJJA9J9rqiS04NOC3FPQoVsovKUkWU0L1H0f w==;
X-CSE-ConnectionGUID: qRE2O0aLSN+9vuQ4mCJEvw==
X-CSE-MsgGUID: URaxjSfLSZKcytZdMVQaGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3832025"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3832025"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 23:31:56 -0800
X-CSE-ConnectionGUID: 8subEORURq+oGNIPiT5brw==
X-CSE-MsgGUID: g8OyyTFaQPGuGnTrYKHQQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; d="scan'208";a="10356336"
Received: from unknown (HELO srv14..) ([10.190.212.243])
 by orviesa006.jf.intel.com with ESMTP; 18 Nov 2026 23:31:55 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: manoj.kumar.subbarao@intel.com
Subject: [PATCH v1 0/2] Intel IPU E2200 Critical Bug Fixes
Date: Thu, 19 Nov 2026 13:01:45 +0530
Message-ID: <20261119073147.71820-1-soumyadeep.hore@intel.com>
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

Following patches contain critical bug fixes for Mt Morgan.

Soumyadeep Hore (2):
  net/cpfl: fix function type on MMG device
  net/cpfl: fix log flood on empty mailbox

 drivers/net/intel/cpfl/cpfl_ethdev.c      |  6 +++++-
 drivers/net/intel/cpfl/cpfl_ethdev.h      | 17 ++++++++++++++-
 drivers/net/intel/cpfl/cpfl_representor.c | 26 ++++++++++++-----------
 3 files changed, 35 insertions(+), 14 deletions(-)

-- 
2.43.0

