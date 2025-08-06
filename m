Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB86C87FCB
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 Aug 2025 13:38:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C72B140291;
	Wed,  6 Aug 2025 15:38:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 8AD6B400D6
 for <dev@dpdk.org>; Wed,  6 Aug 2025 15:38:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754487522; x=1786023522;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=0e4PIaT2BSu8eZeeQtSqKa2rkSv9Y4+zpvGYHIHc6WA=;
 b=kMzrM2SRBiQDI+//X/jk4Gl4O+OD8rzXVxCWKqRon0lJHcMwKv8Bw2g0
 Bsa6DNygWPH3QDLb/1sWTVuWUUL/GQWwdN0wKgr5i2DpTTVXJPCfHxs9D
 sVXMA9y66W3OJa9aB3bi0pxWejnaKzFQAjqUUYrqh9zNNSsFk2ATkgNVL
 gbrLhgIsSzukZDasDhzcTcV9QlF7160+VYRJzUXmq2iyEEAbJ1cnyBB8V
 BZd9cUwZvvgfWORvPeWJmPoxENLgNMlZkKbibN5FxY28FW7JKP6GaNQxo
 pk47XKR9Ouli7r8wVy+TuNT+QfBlsrnjkb+wqNFmBK7f/KC96KhzfVbz+ g==;
X-CSE-ConnectionGUID: 3ND/tq4GSOSj8bCZP8B2gQ==
X-CSE-MsgGUID: rCqA/c4eTh6Bw43LmSOLrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56769210"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; d="scan'208";a="56769210"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2025 06:38:41 -0700
X-CSE-ConnectionGUID: Gl+cWp+DSpGakDJUquiE5Q==
X-CSE-MsgGUID: QyN9sD+kS02GHm2PoRkJQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; d="scan'208";a="201942350"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.55.129.54])
 by orviesa001.jf.intel.com with ESMTP; 06 Aug 2025 06:38:39 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 0/3] Use cross-platform rte_basename function
Date: Wed,  6 Aug 2025 13:38:30 +0000
Message-ID: <20250806133833.3236170-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
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

To enable more of DPDK to be buildable and usable on Windows, common
code should use rte_basename in place of regular basename() function.
Therefore update EAL common code and code in apps to use that new
rte_basename function.

In some cases rte_basename is easier to use than basename, since it
outputs to a new buffer, so also update idxd driver to use
rte_basename, since it simplifies the code, even though that code
does not need to work on non-Linux systems.

Depends-on: series-35845 ("improve cmdline file handling in testpmd")

Bruce Richardson (3):
  app: use cross-platform basename function
  eal: use common basename function
  dma/idxd: use DPDK basename function

 app/test-dma-perf/main.c         |  6 +++---
 app/test/process.h               |  2 +-
 drivers/dma/idxd/idxd_bus.c      | 12 ++++--------
 lib/eal/common/eal_common_proc.c |  5 +----
 4 files changed, 9 insertions(+), 16 deletions(-)

-- 
2.48.1

