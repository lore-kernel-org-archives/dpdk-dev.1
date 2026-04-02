Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353DD1112279
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Apr 2026 02:49:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B49040299;
	Thu,  2 Apr 2026 04:49:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 7631040275
 for <dev@dpdk.org>; Thu,  2 Apr 2026 04:49:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775098194; x=1806634194;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=nTJF3OPrU2mi+n5Z3LdxDvM8W87wbkLZ+MgejeYaVqQ=;
 b=eQhoOlOUgTigplAFfMICbfOHhHlvE5a7IwGecK06ZreoZ+1DMjTzhVw2
 eWVkjjTfxTjA3ZRspKahFIoxCSaQDKcJvCxk2aZ/rLK8//MFBNSjTO3od
 oqIy68+Q7yTqr96ierCudXycYGEyyhVxv8Kb7iILNJ7RWYJRDub/Pf7kY
 PpJA+zsmOrkQ4e5wzU+UFx9CXXfXB951k78az89uCif5v4sPTYeQm2xXS
 x9vVP9gY3guuAm+r5D9D+9rt99aabQpBjcRYKt7OXmk3Mh2Yl8s8J00Fq
 QtnaRPJqANkymkxix0GwCVe+SWKva3bWVIlXN4yJ0SBHmw2dILPaNtbA3 Q==;
X-CSE-ConnectionGUID: NCs2RMgcSfig40leYi0Ktg==
X-CSE-MsgGUID: dkSGB0v1SsyQwf9rj/+yfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="87224470"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; d="scan'208";a="87224470"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2026 19:49:52 -0700
X-CSE-ConnectionGUID: YspB/h4aQC2wR3k2cl/JwQ==
X-CSE-MsgGUID: opNGoIseSliwr6x7V7n09g==
X-ExtLoop1: 1
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by fmviesa003.fm.intel.com with ESMTP; 01 Apr 2026 19:49:49 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: bruce.richardson@intel.com, manoj.kumar.subbarao@intel.com,
 aman.deep.singh@intel.com, dev@dpdk.org, rajesh3.kumar@intel.com
Subject: [PATCH v1 0/2] Update Rx Timestamp in IAVF PMD
Date: Thu,  2 Apr 2026 11:21:35 -0400
Message-ID: <20260402152137.1527322-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
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

PHC Polling from Rx Datapath is removed and existing alarm handlers are
used to fix latency issues in IAVF PMD.

Soumyadeep Hore (2):
  net/iavf: remove PHC polling from Rx datapath
  net/iavf: reuse device alarm for PHC sync

 drivers/net/intel/iavf/iavf.h                 |  5 ++
 drivers/net/intel/iavf/iavf_ethdev.c          | 70 +++++++++++++++++++
 drivers/net/intel/iavf/iavf_rxtx.c            | 34 ---------
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   | 16 +----
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 16 +----
 drivers/net/intel/iavf/iavf_vchnl.c           |  4 ++
 6 files changed, 83 insertions(+), 62 deletions(-)

-- 
2.47.1

