Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4411606A31D
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 10:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f2/5XdUI
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 179AE40299;
	Fri, 23 Oct 2026 12:36:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id EDACD40268
 for <dev@dpdk.org>; Fri, 23 Oct 2026 12:36:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792751773; x=1824287773;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=QF+3UHODnk2M0zLNnpXBwYdg40vjQmh/NJXELW6LwHs=;
 b=f2/5XdUIE07M/07/amWNeWSlxulZMxY0IcYFMThi97okm1R5Av/Y5Q5g
 0JkLq7JwnGzaShpNcRhYmEX0ghZ5H+pQtx/MbY4KTW6ymsbhZCIZl5rMf
 35c0NSz3ObZQI/Z1IMFgVX/sI3PC1MBnQUDfw+pcVAw62XdI8mW4NpZ5k
 6jlBrA+J8H1r1E4+818iDIwdKPdjrkAB256EYr414qKv6ncF7Qy2xVkYA
 206+QFrQ1Z5WvMcb36htla5/8l0QgxrlLnV99pfTm+jng6lxEbmnWCjyV
 yAtQoTKulv1lKBtIWoAwsl+TvrBcolgGLDrdkVqrFjJdaBLAa+oYuT4PH w==;
X-CSE-ConnectionGUID: 2n3nMtoGTRaiyGbv4gQUGw==
X-CSE-MsgGUID: Z0VBG0QgRtG1OOpIKVwXOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1522861"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1522861"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 03:36:12 -0700
X-CSE-ConnectionGUID: w5GfJwJgThS0AwzXy39J9g==
X-CSE-MsgGUID: b6GRTsI0RAWYb25DzwmZZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="4098938"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by fmviesa010.fm.intel.com with ESMTP; 23 Oct 2026 03:36:10 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH 0/2] net/i40e: fix memory leaks
Date: Fri, 23 Oct 2026 10:31:28 +0000
Message-Id: <cover.1792750212.git.anurag.mandal@intel.com>
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

This series fixes few memory leaks in the i40e PMD:

1. When the main VSI was released, only the VSIs attached 
   to the floating VEB were released, not the VEB itself,
   leaking the VEB structure and its switch element. 
   This only affects setups with floating VEB enabled.

2. The flow director programming packet memzone was reserved
   at setup but never freed, so it leaked whenever the port 
   was closed.

Anurag Mandal (2):
  net/i40e: fix floating VEB leak
  net/i40e: fix FDIR memzone leak

 drivers/net/intel/i40e/i40e_ethdev.c | 1 +
 drivers/net/intel/i40e/i40e_ethdev.h | 1 +
 drivers/net/intel/i40e/i40e_fdir.c   | 4 ++++
 3 files changed, 6 insertions(+)

-- 
2.25.1

