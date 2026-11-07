Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20150606A332
	for <dpdk-dev@archiver.kernel.org>; Sat,  7 Nov 2026 23:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Gas2J+2p
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54EC340264;
	Sun,  8 Nov 2026 00:57:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTPS id 0E6604003C
 for <dev@dpdk.org>; Sun,  8 Nov 2026 00:57:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794095842; x=1825631842;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JhH8km+n2Xcrb6wYx1ZjPlgR/51XmOu8xsjpWX8vSps=;
 b=Gas2J+2ppUn/7RuGd8zV/L1NrJZ7vapppkyD0s0c03Q8eB8PAplC4ZBA
 WBHdPR263Dkv94G8NVOQcpivg2Fubc1NRKEirQRHqFuAnNw8wmQl/oRRo
 HCwMjSFzlUhGKaKaKBaKNWD91YXG24MkmuaOJkAhePO8vB3JZrHhNuyrT
 SnTl4+RWmX6O+qF8D/NorS7RlEhDW0gnFi7GO3z4xbsMQeJKqJi+hfwsA
 axY0TltlrsXk5OP74JpuspuDcBFyfLNFjeGOXCtF1AoANWwGr+lDJoJWX
 zn9ZKB6fBP+HBVqRoErJCCydf1oKxJBe60Qa/Rmrha7v/yh5vWdxciMN2 Q==;
X-CSE-ConnectionGUID: ollo/r+6TSu0QFEahRlIXg==
X-CSE-MsgGUID: NZjW6Tl7Q9aWwrwwRgIGEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11959"; a="2885081"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="2885081"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2026 15:57:20 -0800
X-CSE-ConnectionGUID: RpzqO6nuTyu2V74mxJrPvg==
X-CSE-MsgGUID: rryowwisQ1qz9DW5vX+QSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="7464624"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by orviesa005.jf.intel.com with ESMTP; 07 Nov 2026 15:57:18 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v2 0/8]  net/ice: fix DCF memory leaks
Date: Sat,  7 Nov 2026 23:52:10 +0000
Message-Id: <cover.1794094943.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793871697.git.anurag.mandal@intel.com>
References: <cover.1793871697.git.anurag.mandal@intel.com>
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
 - Patch-1: use rte_intr_callback_unregister_sync() in the new error
   path.
 - Patch-5: fix the re-commit leak by swapping the saved config
   under the lock the VF reset replay holds.

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
 drivers/net/intel/ice/ice_dcf_ethdev.h |  2 ++
 drivers/net/intel/ice/ice_dcf_parent.c | 24 +++++++++++--
 drivers/net/intel/ice/ice_dcf_sched.c  | 19 +++++-----
 5 files changed, 92 insertions(+), 28 deletions(-)

-- 
2.25.1

