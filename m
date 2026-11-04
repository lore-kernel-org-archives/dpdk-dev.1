Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7211A60B9095
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 20:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KKSjZNZ6
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 840444060F;
	Wed,  4 Nov 2026 21:15:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTPS id C746A40285
 for <dev@dpdk.org>; Wed,  4 Nov 2026 21:15:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793823312; x=1825359312;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=a7uuDDqUVpyIHdU9/a1d0eFaC3vRlRnfWlaFp4H3aDA=;
 b=KKSjZNZ6Vf12n7dBLrw9bUfceCeWcaXiaoCnMXt3yKyeMToyDyl4eaP8
 AQfxymGfrF+dbJLnQJga0pmcsdBa0o3lefWN8FvIbhe7QfXw+q4jQEUoR
 +17cd5yEGGCRkRQh0ky9C4CzeRBDxSN1MjO0kmqdsZ6LS6JfmVHY4ch/T
 6es0sxF3fAJDl8slpTHuPLufr4vK3OA3zFCggwL5JkoEefEiB41UxT0WN
 QQewY9XeETjtmUaEg0HxO62HnXQJh3pdN0oCgw0iqUxiEnED2M8SLFBii
 J8GjFGVWtLjRhH7dGBd23SFKRacBSfehE5ag1PSnJdUwKKxlKzdKp08hV A==;
X-CSE-ConnectionGUID: /SabhxuyQUKFfGot8tTrqQ==
X-CSE-MsgGUID: nztBpakeT0qcoBc2Yoj4Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2627683"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2627683"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 12:15:10 -0800
X-CSE-ConnectionGUID: u1YYadMRTKiAIzBUbyqEJQ==
X-CSE-MsgGUID: oB9tV2nxQa+sZRjlrqIC4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7130647"
Received: from silpixa00401385.ir.intel.com ([10.20.227.220])
 by fmviesa008.fm.intel.com with ESMTP; 04 Nov 2026 12:15:09 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 0/3] deprecate unneeded build options/support
Date: Wed,  4 Nov 2026 20:15:03 +0000
Message-ID: <20261104201506.4091374-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260602090847.905721-1-bruce.richardson@intel.com>
References: <20260602090847.905721-1-bruce.richardson@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Having unnecessary build options just makes things confusing for
the user, and expands the set of potential builds. This set
deprecates 3 build options, including deprecating all HPET support,
and marks them for future removal.

---
v2: rather than always building HPET to remove the option, deprecate
    all HPET support, which will also allow option removal in future.

Bruce Richardson (3):
  build: deprecate kernel dir option
  build: deprecate standalone tests option
  build: deprecate HPET support

 app/meson.build                      |  6 +-----
 doc/guides/linux_gsg/enable_func.rst | 32 ----------------------------
 doc/guides/linux_gsg/sys_reqs.rst    |  3 ---
 doc/guides/rel_notes/deprecation.rst | 11 ++++++++++
 meson_options.txt                    |  6 +++---
 5 files changed, 15 insertions(+), 43 deletions(-)

--
2.55.0

