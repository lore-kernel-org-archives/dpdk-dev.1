Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E670C87FCB
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 15:19:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C40D040291;
	Mon, 28 Jul 2025 17:19:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id DB7504025A
 for <dev@dpdk.org>; Mon, 28 Jul 2025 17:19:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753715959; x=1785251959;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5ow2TApN4hg/v7n8fLpTK6dMTUH+JH4ytQOvPIpGOwM=;
 b=JSRVLRxVB6MHrGCwJfuNPxW1GhP5UmbDUMwehrPVOvV2p/OCX5eELz4W
 HRirHjlSkrh2lWdKGVOhKQBE14SNb+DDJKYmzZYNm+Zotj0UnUnYaIZyM
 QmSyIB/La8DK2ntzo0u4WOgD9GZloe4Puggcy8+2BlRZ5gpRJLMYmlNoS
 ntPdH5mdJoMzuIUDIFE6GV5yrOfCFxUuOQ3KGnuwFCTtpgMS6EtZCkANe
 Ii4BQylvq8wl6sRaNoR0hf87ETWggAoTG61qs7VA7f9EpR2dafjJshgwm
 wlzzSRkKOuwR5Qwc8PV4J733GAJKZ9Hby0umgZbD1knptfAiJHXgc65k5 Q==;
X-CSE-ConnectionGUID: 4GRWZ7H2S2OzZdeb3qs9Dg==
X-CSE-MsgGUID: UyQAIukZROWtxikH86CfSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="67404229"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="67404229"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2025 08:19:17 -0700
X-CSE-ConnectionGUID: BSUYzUh9SpmTtsmFRdDryg==
X-CSE-MsgGUID: otsovvz6TW+0TwUPluNMTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="199586015"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by orviesa001.jf.intel.com with ESMTP; 28 Jul 2025 08:19:18 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 0/3] remove fallbacks for old Linux versions
Date: Mon, 28 Jul 2025 16:19:05 +0100
Message-ID: <20250728151908.338534-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250630132904.1704901-1-bruce.richardson@intel.com>
References: <20250630132904.1704901-1-bruce.richardson@intel.com>
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

v2: rebase and resubmit on 25.11-rc0 baseline

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

