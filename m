Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2A4C83029
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 13:29:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9AAE0402A5;
	Mon, 30 Jun 2025 15:29:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id B246A40291
 for <dev@dpdk.org>; Mon, 30 Jun 2025 15:29:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751290156; x=1782826156;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8YvrJLrw28eJxbaeUY9AtSIw2QOmtLPs6YeUpevk3YY=;
 b=iyvvUaMSu3gT+/hyMLy9CIFmdO5KZtcUrufwKnBxBtTdDarmfbVl/KrU
 6BXsCMcfo7H2vX1x01DjuJpscAk/TEIH4M2X62WT1+Y0BHorRhSdzkrlR
 u3bOC27alCFkM5jZLIBXzcc6jacZQE4915hkh+qMluEOAqPx1CKFIDBZ6
 tYo2aeEKVmlrUuo5F2KhCfvhkXj3uBlHnJ1qoXLNK8M6reGmSElGckURM
 nzLa7aXZvBkiibQzhAPr8yro+eLGUVpl3xxGd26nU0VEjXs3YlqEwvIC7
 gZMame2KEoXoMntCTWtAwzCazhKqBaeirvec5BeaPLeYa5ZlDbaVCV4Xx A==;
X-CSE-ConnectionGUID: zBLehgGJRPye2wKvErfaTw==
X-CSE-MsgGUID: /VnAgj5NRWCGj07R6y039A==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="64113085"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; d="scan'208";a="64113085"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2025 06:29:15 -0700
X-CSE-ConnectionGUID: YMORl4+QRLqanNWmZl5H+Q==
X-CSE-MsgGUID: nwbNBHiPRWCB7AsC2v5RNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; d="scan'208";a="153764329"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.55.129.54])
 by fmviesa009.fm.intel.com with ESMTP; 30 Jun 2025 06:29:14 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 25.11 0/3] remove fallbacks for old Linux versions
Date: Mon, 30 Jun 2025 13:29:01 +0000
Message-ID: <20250630132904.1704901-1-bruce.richardson@intel.com>
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

We no longer support versions of linux before 4.19[1], therefore
all supported linux versions support F_ADD_SEALS (Linux 3.17+) and
MFD_HUGETLB (Linux 4.14+), so no need to have #ifdefs and fallbacks to
support systems which do not support those features.

[1] https://doc.dpdk.org/guides/linux_gsg/sys_reqs.html#system-software

Bruce Richardson (3):
  eal/linux: remove fallbacks for old Linux versions
  vhost: : remove fallbacks for old Linux versions
  memif: : remove fallbacks for old Linux versions

 drivers/net/memif/rte_eth_memif.h |  41 -------
 lib/eal/linux/eal_memalloc.c      | 174 +++++-------------------------
 lib/eal/linux/eal_memory.c        |   7 --
 lib/vhost/vhost_user.c            |   7 --
 4 files changed, 24 insertions(+), 205 deletions(-)

-- 
2.48.1

