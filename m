Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A43606A327
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 08:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aYzY7bLV
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BFDD40264;
	Mon,  2 Nov 2026 09:15:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTPS id F25ED4003C
 for <dev@dpdk.org>; Mon,  2 Nov 2026 09:15:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793607330; x=1825143330;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fmDKmr4wXexYwGKkKhP4Na3LTqcCNeIIoUhNWboLYnw=;
 b=aYzY7bLVmlMrj1AZpFbyNKbLtrRFFXt6yQ2e6+ZQUeCZRjuwGnMbtOyx
 3Gim37LBGCWD8joArH7dS2IWMA1GCDMcRM/q6rsCxcpH1RX9uf7l5btMy
 Q0C9xRKKMrVynJVqR5sYhiNB9TkcIeBthLo4z0Al4+/fa+glQyRRrR1ca
 BMHZZG5KmPnUL+mR3LjC+p8Zzy6ShPM1s2orNVnSE4VJbKjk2q+xap7Qr
 cgzSd/NzSC7Oxko4O/tX0UhpEPg4w7tGvWUNVVT7ElPQFf0/+p2nOvU8p
 ftTt+xAOAmJMssRkEWnQUQFxdQEU3hJYxUKpLuE6QgEWlNhb1+h0U4wRa A==;
X-CSE-ConnectionGUID: gBxNUyzlRYGY9yqVrzb+jw==
X-CSE-MsgGUID: uw1atYFCQjO5hqdsePHvGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2283621"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2283621"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 00:15:28 -0800
X-CSE-ConnectionGUID: PGDcbo7xRSW0RofLi0rQgQ==
X-CSE-MsgGUID: x9ZkyVqBSUm+snHmRaczmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7818556"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by fmviesa012.fm.intel.com with ESMTP; 02 Nov 2026 00:15:27 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v2 0/7] net/ice: fix memory leaks
Date: Mon,  2 Nov 2026 08:10:30 +0000
Message-Id: <cover.1793605751.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793097896.git.anurag.mandal@intel.com>
References: <cover.1793097896.git.anurag.mandal@intel.com>
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

V2-changes:
 - Addressed Bruce Richardson's review comments.
 - Added "Cc: stable@dpdk.org" in all patches.
 - Use ice_deinit_hw() on close instead of open-coding it,
   which also returns the FD counter block to firmware
   on Patch-2.
 - Declare the devarg handler argument as char ** so the
   filename it points to is char * and can be freed without
   a cast on Patch-3.
 - use RTE_CAST_PTR when freeing the filename in ice_dev_init()
   on Patch-3.
 - allocate the flow segment on the stack instead of
   freeing it on Patch-7.

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
  net/ice: fix resource leaks on port close
  net/ice: fix DDP filename leak
  net/ice: fix main VSI leak on init failure
  net/ice: fix MAC and VLAN filter leak on VSI release
  net/ice: fix FDIR resource leak on setup failure
  net/ice: fix ACL profile segment leak

 drivers/net/intel/ice/ice_acl_filter.c  | 46 +++++++++++--------------
 drivers/net/intel/ice/ice_ethdev.c      | 37 ++++++++++++++------
 drivers/net/intel/ice/ice_fdir_filter.c | 10 ++++--
 3 files changed, 54 insertions(+), 39 deletions(-)

-- 
2.25.1

