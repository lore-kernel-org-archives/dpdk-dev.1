Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D73ACCA46C
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 14:02:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56736402E9;
	Fri, 16 Oct 2026 16:02:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 966F3400D7
 for <dev@dpdk.org>; Fri, 16 Oct 2026 16:02:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792159346; x=1823695346;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=B5iaPvT0BYhkkxg3e0K3MaIxPy8NdVKTQgEgEEUmHvk=;
 b=NENSSvSuKwLrp8LLm7BwYBTNO/rotqk/FXH0PM8D52hJMpkcj9pkuqeT
 E2EhWkxcwGrqFNTfunYPaotnSgGYGiPfGWgpG7iErMFqWPn72WpwbMlOr
 YOx2GpEmLsQY/ZjM7P7FUmYgIs5Nb5MrBprZh1iKqFJxY+PuWZvM/upbt
 dFj3nzwUi+PT72aCNiNWlOFcEI0B4jpF8iUpXKNxFgDvx2NsKY9y1F0u6
 pQiN4OOGH2zkC25Fths2qGR8mAquJ/aW/zZKTHYa5zn/PLX++801krjfD
 LO00X14lgh7cc9YsN4RDzE0P2hpI8ITpzMn0bKMohV9OdxXcU1oeeO1SY A==;
X-CSE-ConnectionGUID: PdDCpECbReylE04hYU3+tA==
X-CSE-MsgGUID: 85IHa7GtQn2dEPRlkbidWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="1043659"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1043659"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 07:02:20 -0700
X-CSE-ConnectionGUID: iMvte+/MSza90Nht3VH78w==
X-CSE-MsgGUID: zwtU0nRIRNuXvouMRtY7lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1951639"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa001.jf.intel.com with ESMTP; 16 Oct 2026 07:02:19 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [27.03 RFC PATCH v1 0/8] Add usage counter helpers
Date: Fri, 16 Oct 2026 15:02:07 +0100
Message-ID: <cover.1792159157.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

There is a recurring pattern in DPDK code: on first use, do something,
on last use, undo something. In a lot of cases, these reference counters
are atomic or otherwise thread-safe, but in cases where they're not, we
use raw integers and do manual checks and counter updates instead.

This patchset attempts to provide a really minimal "usage counter" library
that does *only* that: track usage of resources. The patchset does not do
a full DPDK conversion to these counters, but it does convert a few things
to demonstrate what it would look like if we had them.

Anatoly Burakov (8):
  eal: add usage count helpers
  vfio: use usage counters
  dev: replace raw refcount with usage count
  vhost: use usage counters for vchan tracking
  acl: use usage counters for ref counting
  thash: use usage counters for ref counting
  lpm: use usage counters for ref counting
  net/nbl: track devices with usage counters

 doc/api/doxy-api-index.md                |  1 +
 drivers/net/nbl/nbl_common/nbl_userdev.c | 22 +++---
 lib/acl/acl.h                            |  4 +-
 lib/acl/acl_bld.c                        |  9 +--
 lib/eal/include/meson.build              |  1 +
 lib/eal/include/rte_usage_count.h        | 96 ++++++++++++++++++++++++
 lib/eal/linux/eal_dev.c                  | 20 +++--
 lib/eal/linux/eal_vfio.c                 |  7 +-
 lib/eal/linux/eal_vfio.h                 |  5 +-
 lib/eal/linux/eal_vfio_group.c           | 11 +--
 lib/hash/rte_thash.c                     | 10 +--
 lib/lpm/rte_lpm6.c                       | 13 ++--
 lib/vhost/vhost.c                        |  5 +-
 lib/vhost/vhost.h                        |  3 +-
 14 files changed, 151 insertions(+), 56 deletions(-)
 create mode 100644 lib/eal/include/rte_usage_count.h

-- 
2.52.0

