Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804D9606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 10:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jFTP7TDH
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3818740151;
	Tue, 27 Oct 2026 11:56:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTPS id C21D0400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 11:56:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793098586; x=1824634586;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=K3vKY2nFchntz3Ah0fV6DO369qa3INomWfWxF4rW18s=;
 b=jFTP7TDH2tMeVtgnIkDyNjmYupN9gMnPm6G/lbOXhHn79DwkWT7lUY6+
 Yk4YXiQ9lTuk/xvAZg1eMwESC3h47tmgRJH3TvlPQHZTPxBvWwQSqVATo
 VISLlRC0soDhdVZP9/tlSvkxEtAG/fR4k70jV1pJeNI7ofh0sYj1hlDYQ
 9S3u4Ptb7tGxY0u3YBuUVkLsYAyYPSrXf+ouGg3OyLomxtzbsm/HNj5BS
 Eb5dvvCBz1yLHcSXPa8oFx33gyNVE2MbLIUCNiJIzu6/UpPoOVN5X/ohK
 M85MBoyz7WKNaxqatAuVQ6qyIhixvTt+i4WOTCqE/khzT/JkMOktECtTj w==;
X-CSE-ConnectionGUID: WPBF+/NzTVWkpzMexp6/Yw==
X-CSE-MsgGUID: +eIptHINSQubJg84onDYiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1679293"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1679293"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 03:56:25 -0700
X-CSE-ConnectionGUID: Y2wLcbPUTr60u0WEysijlg==
X-CSE-MsgGUID: zEumBdccQ9uegqflWk8M4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4901456"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by fmviesa009.fm.intel.com with ESMTP; 27 Oct 2026 03:56:23 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH 0/7] net/ice: fix memory leaks
Date: Tue, 27 Oct 2026 10:51:30 +0000
Message-Id: <cover.1793097896.git.anurag.mandal@intel.com>
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
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes memory leaks, and one double free, in the ice PMD.

a. The DDP package copy was freed twice when hardware table
   initialization failed during probe.

b. The switch filter management structures, the DDP package copy and
   any remaining VSI contexts were never freed on port close or
   reset.

c. The DDP filename devarg string leaked on probe failure, and when
   the devarg was given more than once.

d. The main VSI leaked when probe failed after PF setup.

e. MAC and VLAN filter entries could stay allocated when a VSI was
   released.

f. A failed flow director setup leaked the FDIR VSI, hash table, hash
   map and counter pools.

g. The flow segment used to create the ACL profiles leaked on every
   ACL engine init.

Anurag Mandal (7):
  net/ice: fix DDP package double free on init failure
  net/ice: fix memory leaks on port close
  net/ice: fix DDP filename leak
  net/ice: fix main VSI leak on init failure
  net/ice: fix MAC and VLAN filter leak on VSI release
  net/ice: fix FDIR resource leak on setup failure
  net/ice: fix ACL profile segment leak

 drivers/net/intel/ice/ice_acl_filter.c  |  1 +
 drivers/net/intel/ice/ice_ethdev.c      | 33 +++++++++++++++++++++----
 drivers/net/intel/ice/ice_fdir_filter.c | 10 ++++++--
 3 files changed, 37 insertions(+), 7 deletions(-)

-- 
2.25.1

