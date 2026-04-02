Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB95111227A
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Apr 2026 03:15:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6C614028B;
	Thu,  2 Apr 2026 05:15:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 2A16240275
 for <dev@dpdk.org>; Thu,  2 Apr 2026 05:15:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775099711; x=1806635711;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=YID4K9/lRD9m2uh4UvbxNaZrEcL6XroSu79suyB3G9Y=;
 b=PBgYLtZIdDagJAP4z0onrrOCyfD+sJme4wwIyiGoIswy/i7fI79nrzRY
 xVIXdwWyb5rI1xSQcm7Pn04yhEziGS3eROTh2wZK8DG0xfnCYz50wvvqh
 Nin2p/woNDw7pqDigK04/kKlA9yo1w5+UCSu7Qh1auFp+O8Nx6vmoESsi
 ogbfDmF3oQbyTU5seFIARnO+kO/VxfhouZK1D8CyRC3kiEEpws+aVWC1y
 RtQif+uBk0vXZHUB6PhI9iY04KmsYHyManpGX1eHgjp3oyY+9yzWY77T6
 By8wK81RdvNZzuFIsIPbhVwzAEcIgZ5C+0z/ik0AYf0oBPmFYybPo893C w==;
X-CSE-ConnectionGUID: FwBGPIrpRcmp+dTNKxHiLg==
X-CSE-MsgGUID: k89dXVamSm+i50v5XPAbgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="93732799"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="93732799"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2026 20:15:10 -0700
X-CSE-ConnectionGUID: mXbRF7KeTgOaN6xJKCHRhA==
X-CSE-MsgGUID: Bn15fcIeR5ueSD/K7wHcGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="225846909"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa006.jf.intel.com with ESMTP; 01 Apr 2026 20:15:07 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: bruce.richardson@intel.com, manoj.kumar.subbarao@intel.com,
 aman.deep.singh@intel.com, dev@dpdk.org, rajesh3.kumar@intel.com
Subject: [PATCH v2 0/2] Update Rx Timestamp in IAVF PMD
Date: Thu,  2 Apr 2026 11:46:53 -0400
Message-ID: <20260402154655.1540930-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260402152137.1527322-2-soumyadeep.hore@intel.com>
References: <20260402152137.1527322-2-soumyadeep.hore@intel.com>
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

