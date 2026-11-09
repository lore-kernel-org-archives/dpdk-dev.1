Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9E7606A321
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 05:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ibSArJut
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C6CA402CF;
	Mon,  9 Nov 2026 06:43:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTPS id 578DF40272;
 Mon,  9 Nov 2026 06:43:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794202996; x=1825738996;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=vMs7OGxwEFh1uBxJSosN81aZmJiGnCFugWdrtju03So=;
 b=ibSArJut/lCNK708XAVmSRfwvAzZqYNFChTkHWVCaf94rJ89jPg8ln+E
 ZNa+n4gmkw8QESfCFjC6lw8nnZwBP5JK2+cEC6L1IKQdnaZHoVUiCjR5O
 kwanwT707KKTzMM9Shd6J1gAcLDztBF1lVZSwAhwNlI+tTfFXn1wyB9yL
 O7M5XUPd7svg/9s2xNerEZTeBb9mxiWup8uKrtVp95Zyb+xWhdysGanU/
 JxgqmpgvPyHSnL1QgcLa74duZ2yGgPGlKNJPcWA9BcYd6vqDw4gK+ZKwT
 U4vOooIZ4SroFOt6Mvdm5ZW+OWpZ8s5d129zSDblZoUKhYu6BAga9cG/t g==;
X-CSE-ConnectionGUID: UbVJ9FlLTT6oepqgnWFW2g==
X-CSE-MsgGUID: pWuMAd5DSfii2deizgGngw==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2924108"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2924108"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2026 21:43:14 -0800
X-CSE-ConnectionGUID: GHLkQQ4CQVq9cPILu7NwFw==
X-CSE-MsgGUID: 1uBasyvjTY2TNWKO913XMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="7948261"
Received: from pae-31.iind.intel.com ([10.49.105.68])
 by fmviesa002.fm.intel.com with ESMTP; 08 Nov 2026 21:43:13 -0800
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH 0/2] fix minimum virtchnl API version logs
Date: Mon,  9 Nov 2026 12:45:22 +0000
Message-Id: <20261109124524.115656-1-sandeep.penigalapati@intel.com>
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The iavf and ice DCF version checks compare against the minimum
minor version, but both error logs pass the major macro twice.
Both minima are 1 today, so the printed text is still 1.1.
The logs would be wrong if a minor minimum ever diverged.

Sandeep Penigalapati (2):
  net/iavf: fix minimum API version log
  net/ice: fix DCF minimum API version log

 drivers/net/intel/iavf/iavf_vchnl.c | 2 +-
 drivers/net/intel/ice/ice_dcf.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1

