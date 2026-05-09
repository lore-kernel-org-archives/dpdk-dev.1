Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE31CD342F
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 May 2026 21:40:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA86F4026E;
	Fri,  8 May 2026 23:40:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id ACEF640268
 for <dev@dpdk.org>; Fri,  8 May 2026 23:40:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778276456; x=1809812456;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=T73Ppci63c6gpyBWJN+wDzvkHuIJSGHpL60fRWm0f5Q=;
 b=TB9KhriwD2vpnIwMFqe9n1Hh+WdToiNX2PY7AXPpkv/5VU9p98rNMIs4
 P7j9pFCS1sLwmeiFIFcd4oK/81iRhlF/09AIdw/CdGCS8DRsJ/1Gs+jLA
 hwvJQm3rvRXOOCNS0f0PZKdqB7gpMwdZrbjZRsYWojZrSu35NfKGA2hNI
 yjXWZhHHP4sGVbsLI2ze4DVqJ5XVGm+VcOIu3/JEe5BlrLHFU1472I+2Y
 vgF9xBGB0M3NOFJ++oiA6dqqS2XKToA6J7DMhJgNJmdKYKElHx/eQ5Mlw
 04CaxFvoa6XC2SJJenqKfAysj2hcEtIWQAIMwXnZIlh8StyXpIcPbm8Fx g==;
X-CSE-ConnectionGUID: CJREijADT92WcuT2Z3LFLQ==
X-CSE-MsgGUID: L4IV0pplTAq8sZ30GBd/jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="82876712"
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; d="scan'208";a="82876712"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 14:40:55 -0700
X-CSE-ConnectionGUID: iMUvVkMhSnOocvNZRDyZWw==
X-CSE-MsgGUID: U1h89RbQTY2ZQdMib4Fu7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; d="scan'208";a="236993083"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa009.jf.intel.com with ESMTP; 08 May 2026 14:40:52 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: bruce.richardson@intel.com, manoj.kumar.subbarao@intel.com,
 aman.deep.singh@intel.com, dev@dpdk.org
Subject: [PATCH v4 0/2] Update Rx Timestamp in IAVF PMD
Date: Sat,  9 May 2026 06:14:45 -0400
Message-ID: <20260509101447.42093-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260406212208.1562899-1-soumyadeep.hore@intel.com>
References: <20260406212208.1562899-1-soumyadeep.hore@intel.com>
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
---
v4:
- Addressed Bruce's comments
---
v3:
- Addressed AI code reviews
---
v2:
- Fixed patch apply issues
---

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

