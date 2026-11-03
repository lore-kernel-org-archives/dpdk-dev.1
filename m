Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024B6606A328
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 17:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DHRwzSBW
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 869024279F;
	Tue,  3 Nov 2026 18:30:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTPS id 38A8740265
 for <dev@dpdk.org>; Tue,  3 Nov 2026 18:30:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793727048; x=1825263048;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=NTgq749l7xC8pnPVGhh4+OgRAi3yd0KVAdtLV/H7Mvg=;
 b=DHRwzSBWBLQ+6ur771JBdIRhr+ePwt0SZ9Y+B/J0qWWwzn8FoGakVb08
 lrmXY6NBDP7GLq80uTQfkUMl973Bxxlxz5jumwV+aPv5Bz7nl4l2oTNEp
 bqKlrY+5XqBKormVHxlt1Y8sM6r37P4UHSiIkmyhZ2q/eKmFLUu6Blr5Z
 130uKRCPkelNA1VgUJ/jdup76FCYfTObZdJkGnZH/Suf8DLeopw639XK0
 yHGBCkusMRQk7kYCNBJG8NeQKZSl6ApCIgUyXkXIXU/v2mYtn6YtZMxCG
 7VvHxb0tgrLViNOrt6NpryKvfwzeB/QbCT39OiWcOv6RxCUC46WrblGDk Q==;
X-CSE-ConnectionGUID: SPlTIzTpQomgS26QC9B9UA==
X-CSE-MsgGUID: zV/loNUFS++RuRh3txzuNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2553262"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2553262"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 09:28:57 -0800
X-CSE-ConnectionGUID: UkXBpLSYQW2ny5LxwfGSGA==
X-CSE-MsgGUID: LuWN0v8cSeKEThYamWBOpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6495693"
Received: from unknown (HELO an4-swa15-spr.example.org) ([10.241.130.94])
 by fmviesa004.fm.intel.com with ESMTP; 03 Nov 2026 09:28:56 -0800
From: Hernan Vargas <hernan.vargas@intel.com>
To: dev@dpdk.org, gakhil@marvell.com, trix@redhat.com,
 maxime.coquelin@redhat.com
Cc: nicolas.chautru@intel.com, qi.z.zhang@intel.com,
 Hernan Vargas <hernan.vargas@intel.com>
Subject: [PATCH v1 0/5] bbdev, baseband/acc: bug fixes
Date: Tue,  3 Nov 2026 09:28:57 -0800
Message-Id: <20261103172902.4152956-1-hernan.vargas@intel.com>
X-Mailer: git-send-email 2.34.1
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

This series targeting 26.11 contains a set of small bug fixes for the
bbdev library and the baseband/acc (ACC100/VRB) drivers.

- bbdev: remove a spurious error log printed by
  rte_bbdev_enqueue_status_str() when called for valid cases such as
  queue dump.
- baseband/acc: fix the available dequeue size computation, which could
  go negative when dequeuing descriptors.
- baseband/acc: fix PF2VF communication so all FFT windows can be read
  (previously only the first was functional) on VRB1 and VRB2.
- baseband/acc: fix the ring interrupt handler error path so a malformed
  ring entry is consumed instead of being reprocessed forever and
  blocking further ring processing (PF and VF).
- baseband/acc: explicitly zero part of the FCW when alternating TB mode.

Hernan Vargas (5):
  bbdev: fix status error for ops dump
  baseband/acc: fix queue depth computation error
  baseband/acc: fix PF2VF Bug for FFT window probing
  baseband/acc: fix ring interrupt handler err path
  baseband/acc: fix bug when alternating TB mode

 drivers/baseband/acc/acc_common.h  | 5 ++++-
 drivers/baseband/acc/rte_vrb_pmd.c | 6 +++---
 lib/bbdev/rte_bbdev.c              | 1 -
 3 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.34.1

