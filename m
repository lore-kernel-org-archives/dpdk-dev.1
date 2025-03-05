Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F87C19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 18:37:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B266402E7;
	Wed,  5 Mar 2025 19:37:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 436D340275
 for <dev@dpdk.org>; Wed,  5 Mar 2025 19:37:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741199823; x=1772735823;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BkAP4DaUWz2XWq1IjbCexLBFIMIaRucf4z9kcxE3bqs=;
 b=ODhc90G3Ac0Aj8YsESmS7B13zY+6QQWxDAG78EvjFRNy3D5XdyVgd02x
 JHww3VojGhBhHC25a2vBplYZXSaC21QIw/kqy1j/7VV5loHBZv3RfzEkb
 zNsyii3rmhSUpI5LBO0B8py3OmgT40rIFha9ngBkbEI4LlZ/FyDCVaSKv
 HOm3CP0AmfAvmj0dkMi/bf2jsuWnA1u55WIls6aQFaAfJ8pCZl1ZJLMrz
 mTm5c3AO01xSQAG64aZqL0xmbgiLSxxxUGckTGVHUMR1w8vUgw8YMI0sD
 ZYs4LmaPZnAIcRhpVNe3ErY3j8Fd7b6UdgHXS4qc5ffHerv0ZcKVbn0Oa Q==;
X-CSE-ConnectionGUID: 6KGY2obYTCqW4DSILR7uFA==
X-CSE-MsgGUID: CeTVv8NuTbSkr6+C8XErPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="29763252"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; d="scan'208";a="29763252"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2025 10:37:02 -0800
X-CSE-ConnectionGUID: WIogTl9yRJaC4MV0y1emtQ==
X-CSE-MsgGUID: FzLdr49uSdSRVh6YCsKDhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119699876"
Received: from spr-npg-bds1-eec2.sn.intel.com (HELO spr-npg-bds1-eec2..)
 ([10.233.181.123])
 by orviesa008.jf.intel.com with ESMTP; 05 Mar 2025 10:37:02 -0800
From: Nicolas Chautru <nicolas.chautru@intel.com>
To: dev@dpdk.org,
	maxime.coquelin@redhat.com
Cc: hernan.vargas@intel.com,
	Nicolas Chautru <nicolas.chautru@intel.com>
Subject: [PATCH v1 0/1] baseband/acc: fix queue setup failure clean up
Date: Wed,  5 Mar 2025 10:27:15 -0800
Message-Id: <20250305182716.773937-1-nicolas.chautru@intel.com>
X-Mailer: git-send-email 2.34.1
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

Hi Maxime, 

This is the fix for the regression issue mentioned off list.
This could notably hit when running with bbdev-test over
more than 64 threads.

Thanks
Nic


Nicolas Chautru (1):
  baseband/acc: fix queue setup failure clean up

 drivers/baseband/acc/rte_vrb_pmd.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.34.1

