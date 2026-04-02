Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31575111227B
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Apr 2026 03:16:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D51240DCB;
	Thu,  2 Apr 2026 05:16:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id CE2FE40275
 for <dev@dpdk.org>; Thu,  2 Apr 2026 05:16:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775099789; x=1806635789;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=YID4K9/lRD9m2uh4UvbxNaZrEcL6XroSu79suyB3G9Y=;
 b=PGGWm3VMayARRwyPTJ9HML6ak9xwMVRrjN1BWWYGx4QlyG0HNWH0fcdv
 DO0aAk9SiXpP2zEK8Hf2aMmPuqhetqv1bVOTZ45og66GN6OCE2+ZrRq3Y
 a9OGDYzGVnO3dTsUPFX+9NOIfTiR9a2fIcCR/Qj/9LUH/a6syMKprmBSZ
 St7zGfVaaZPzBBw+qWUJFErryOSiyOGni9uR8YVn5+qvncvnxRIbo5xMq
 eBLabf/Af66z1tfBmB4ZOgsKVrhvunN+BzsoA716R0YMXOZWGq729se9+
 5nC+iQzElRdyM9rNRmnb1E+Sd1RV9E2vpWjWgNmciDgfPEL3Q7KLtGa/D Q==;
X-CSE-ConnectionGUID: K0j9YS98Te2e1EhxwabNbg==
X-CSE-MsgGUID: WmQewoMJSl+Fn2/Ok5k7eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="75189058"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="75189058"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2026 20:16:28 -0700
X-CSE-ConnectionGUID: m5AXex+vSVa2xGGm60EIdg==
X-CSE-MsgGUID: 8eKwEb5UQpG/+aqCj9iNWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="220198959"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by fmviesa009.fm.intel.com with ESMTP; 01 Apr 2026 20:16:26 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: bruce.richardson@intel.com, manoj.kumar.subbarao@intel.com,
 aman.deep.singh@intel.com, dev@dpdk.org, rajesh3.kumar@intel.com
Subject: [PATCH v2 0/2] Update Rx Timestamp in IAVF PMD
Date: Thu,  2 Apr 2026 11:48:10 -0400
Message-ID: <20260402154812.1540949-1-soumyadeep.hore@intel.com>
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

