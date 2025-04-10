Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C82C3601E
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Apr 2025 05:22:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FA3A40673;
	Thu, 10 Apr 2025 07:22:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id BFD5C40288
 for <dev@dpdk.org>; Thu, 10 Apr 2025 07:22:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744262551; x=1775798551;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=TPuKtZCQK2Z7iPQepBprx0fGwmTxiPDKQHHhQxRgar4=;
 b=l7ceII4s14QuDSH9UzptNsjQ0bEZPI5Wr4p/nDqIEPtB+b8hh5kg4fSc
 9ADLVekmx6bwJPnn3nq//oT4RLC+OBjRNu0fSnd05PnglkDITvdnsyL4P
 xx66bhtZwbLLEle793mRMijvCjWLYLGIvUw6jLuW/ynpwzoDDvsTYVdsE
 UjzzvThuMG9CkJ2wv3IeuKmjhAFWJtCRyQW+e7/33ONsEvbhip0Y+usfs
 ik0EsmSo9ik3Vb72wd0mYwk6yNI4E5h5njShin3OfKYQp2VmSe5FxpNPS
 0PYhHzLtGDj4UJXLQebSvz8RJ6pZa/1Zf2krAcKh1Osr+4vx0sE652adf A==;
X-CSE-ConnectionGUID: dfHHBC6kShOmTUxfdEsOFA==
X-CSE-MsgGUID: +lWf4Zt0RA+bt24QH5w8Rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="45651567"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; d="scan'208";a="45651567"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2025 22:22:29 -0700
X-CSE-ConnectionGUID: nCrH5x2zQTWmmgMxU6cSmg==
X-CSE-MsgGUID: mh5CTzNwSb+guAq4OgJYSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; d="scan'208";a="133520345"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa005.fm.intel.com with ESMTP; 09 Apr 2025 22:22:28 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v7 0/4] net/intel: using common functions in idpf driver
Date: Thu, 10 Apr 2025 10:54:02 +0530
Message-Id: <20250410052406.293110-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312155351.409879-1-shaiq.wani@intel.com>
References: <20250312155351.409879-1-shaiq.wani@intel.com>
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

reworked the drivers to use the common functions
and structures from drivers/net/intel/common.

v7: rebased on top of latest main branch so that it now applies cleanly.

Shaiq Wani (4):
  net/intel: align Tx queue struct field names
  net/intel: use common Tx entry structure
  net/intel: use common Tx queue structure
  net/idpf: use common Tx free fn in idpf

 drivers/net/intel/common/tx.h                 |  18 +
 drivers/net/intel/cpfl/cpfl_ethdev.c          |   3 +-
 drivers/net/intel/cpfl/cpfl_ethdev.h          |   2 +-
 drivers/net/intel/cpfl/cpfl_rxtx.c            |  66 ++--
 drivers/net/intel/cpfl/cpfl_rxtx.h            |   3 +-
 drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h |   6 +-
 drivers/net/intel/idpf/idpf_common_rxtx.c     | 108 +++---
 drivers/net/intel/idpf/idpf_common_rxtx.h     |  69 +---
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 108 ++----
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  | 316 +++---------------
 drivers/net/intel/idpf/idpf_common_virtchnl.c |   8 +-
 drivers/net/intel/idpf/idpf_common_virtchnl.h |   2 +-
 drivers/net/intel/idpf/idpf_ethdev.c          |   3 +-
 drivers/net/intel/idpf/idpf_rxtx.c            |  47 ++-
 drivers/net/intel/idpf/idpf_rxtx.h            |   1 +
 drivers/net/intel/idpf/idpf_rxtx_vec_common.h |  17 +-
 16 files changed, 231 insertions(+), 546 deletions(-)

-- 
2.34.1

