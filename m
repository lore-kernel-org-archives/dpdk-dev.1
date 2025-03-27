Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B61C3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 10:43:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D6554069D;
	Thu, 27 Mar 2025 11:43:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 5DAA840687
 for <dev@dpdk.org>; Thu, 27 Mar 2025 11:43:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743072224; x=1774608224;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=rP+aVeDmUBwUbx6nlGpDqTvCC9KYp4Ud/p2qVit8qvc=;
 b=H78hCkvHOkgzyFACv/yLJINVwAf/9Rcxv+Sz6fyfXENmgCZfLyG0rgoD
 pO9DvubbOvAunpD4Z4XTMc098WxUoNCTwtKcRa3EXDewNTDnEOtSVqLEi
 lB1v2MXavBCfmc1yS43y10/JgFUn2sQExJsLJX89sOs/qx/ID78f8oMPh
 4jIUOBw4cVf5iydZGj8bv/YOStmv5083+Pwvl3bK4viKv6od5QZKLDadp
 3rMyi5FSB6pWZWuSIuPh8yhl/1oUIn7X3bE0aMugCzaJGzoYRBg783CR9
 62wB1jfERBeL7xjntFOTs5MRLDFvxRksyxbkeWsMPy0MdkF0eRC/bQyaw A==;
X-CSE-ConnectionGUID: jRXRb28JSWanSTVYVi+Uzw==
X-CSE-MsgGUID: Nj9efB3KTneXzd8v75dn8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44520203"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="44520203"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 03:43:43 -0700
X-CSE-ConnectionGUID: eq1wz0xTRjOQxB7L+yBlrA==
X-CSE-MsgGUID: KLGZqRZ7RsKHsRfTzMP5tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="130195167"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa004.fm.intel.com with ESMTP; 27 Mar 2025 03:43:42 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v4 0/4] net/intel: using common functions in idpf driver
Date: Thu, 27 Mar 2025 16:14:58 +0530
Message-Id: <20250327104502.2107300-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324124908.1282692-2-shaiq.wani@intel.com>
References: <20250324124908.1282692-2-shaiq.wani@intel.com>
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

reworked the drivers to use the common functions and structures
from drivers/net/intel/common.

Shaiq Wani (4):
  net/intel: align Tx queue struct field names
  net/intel: use common Tx queue structure
  net/intel: use common Tx entry structure
  net/idpf: use common Tx free fn in idpf

 drivers/net/intel/common/tx.h                 |  20 ++
 drivers/net/intel/cpfl/cpfl_ethdev.c          |   3 +-
 drivers/net/intel/cpfl/cpfl_ethdev.h          |   2 +-
 drivers/net/intel/cpfl/cpfl_rxtx.c            |  66 ++--
 drivers/net/intel/cpfl/cpfl_rxtx.h            |   3 +-
 drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h |   7 +-
 drivers/net/intel/idpf/idpf_common_rxtx.c     | 116 +++----
 drivers/net/intel/idpf/idpf_common_rxtx.h     |  69 +---
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    |  81 +++--
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  | 324 +++---------------
 drivers/net/intel/idpf/idpf_common_virtchnl.c |   8 +-
 drivers/net/intel/idpf/idpf_common_virtchnl.h |   2 +-
 drivers/net/intel/idpf/idpf_ethdev.c          |   3 +-
 drivers/net/intel/idpf/idpf_rxtx.c            |  47 ++-
 drivers/net/intel/idpf/idpf_rxtx.h            |   1 +
 drivers/net/intel/idpf/idpf_rxtx_vec_common.h |   9 +-
 16 files changed, 257 insertions(+), 504 deletions(-)

-- 
2.34.1

