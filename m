Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34130EF4EC8
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Apr 2026 08:51:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CB194026D;
	Mon,  6 Apr 2026 10:51:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id E7C6540265
 for <dev@dpdk.org>; Mon,  6 Apr 2026 10:51:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775465462; x=1807001462;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Pb44z+pSDH73LcB4Bvkg0BYnixiNmsHIqvF1BnSkorY=;
 b=Foh1wmyERqbvZnut7fkp8doEbx8h6FPXv7TTynWCtEzgj2ahZHGWpSjW
 Q9zVj6o244iCtz/0igec43ihyEWOl67Od3Fv+ZXYwbhImemWkTxl6/lIN
 8XHOj2QIHvyEsy99D0igQLZ4oEkw+Q/zrEtiBXr7G3bQJWRhsA48GiyTB
 irTPW9l/6/dMlGGstQqlFmzbN9grrU46vsXXeOQDAtd7egDAcU4doBilM
 qw6uBFq7nxb9GIvqYMC6tSxKc1qREddGa9utjk9bUsVj/hDpqsDXFjgX8
 T9vhHz9FdbdDO4N+1xeLo2lWHUB+VLEf88y15fgebV/0xi7LkDGpd4Mtg w==;
X-CSE-ConnectionGUID: aX/jJVyuSsOAT6yuXpOQBw==
X-CSE-MsgGUID: XnZiUSS/QqGdpltJzEIzQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11750"; a="76133626"
X-IronPort-AV: E=Sophos;i="6.23,163,1770624000"; d="scan'208";a="76133626"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2026 01:51:01 -0700
X-CSE-ConnectionGUID: L6zzA1g8R7Kz5Nt9FAci4g==
X-CSE-MsgGUID: cQ2dM/A8R1mtQnNN9/pt0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,163,1770624000"; d="scan'208";a="227732486"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa009.jf.intel.com with ESMTP; 06 Apr 2026 01:50:58 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: bruce.richardson@intel.com, manoj.kumar.subbarao@intel.com,
 aman.deep.singh@intel.com, dev@dpdk.org, rajesh3.kumar@intel.com
Subject: [PATCH v3 0/2] Update Rx Timestamp in IAVF PMD
Date: Mon,  6 Apr 2026 17:22:06 -0400
Message-ID: <20260406212208.1562899-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260402154655.1540930-2-soumyadeep.hore@intel.com>
References: <20260402154655.1540930-2-soumyadeep.hore@intel.com>
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
v3:
- Addressed AI code reviews
---
v2:
- Fixed patch apply issues
---

Soumyadeep Hore (2):
  net/iavf: remove PHC polling from Rx datapath
  net/iavf: reuse device alarm for PHC sync

 drivers/net/intel/iavf/iavf.h                 |   6 +
 drivers/net/intel/iavf/iavf_ethdev.c          | 128 ++++++++++++++++++
 drivers/net/intel/iavf/iavf_rxtx.c            |  34 -----
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   |  24 +---
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c |  26 +---
 drivers/net/intel/iavf/iavf_vchnl.c           |   4 +
 6 files changed, 144 insertions(+), 78 deletions(-)

-- 
2.47.1

