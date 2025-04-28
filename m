Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC15C369D3
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Apr 2025 09:22:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 152744064A;
	Mon, 28 Apr 2025 11:22:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 6A11140156
 for <dev@dpdk.org>; Mon, 28 Apr 2025 11:22:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745832125; x=1777368125;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=uadRAMfp+gwv5LTyb2QPIkhUlZJM/7EB48PZLA4CfkU=;
 b=Yl5OH0ALsYqnkggHL9LdN7bPV3uJNWlso7buRPFNmCDza8oI2RpwJVwb
 qrt9bEb8DgGqdyAwaf+RJFFof4LLMwA1nhE+NOoKiuM758TuDqmfazUgg
 x3GrW4MIaEEUZYGU3GZxbRbnYovQ26dvSyOZRHnTny3FcVAbtLgu9G73R
 h//gsvbQLJuirF9No4if4vCMd7MhjQEDCSEE9fMmu3zwJ8snHwAskIgvm
 a0jcscyHH6SLSeCzGjyr2XKLt5vT4hJAC0d+4Zs0C/sUdy08GxiPWrQJr
 UNagWUANMh2igjCvAh54v7yQr7AhoDTwgaVBAjtah4t9WEntMipMHFVXU w==;
X-CSE-ConnectionGUID: YLZUEt9wTGGrc4uNrmz90Q==
X-CSE-MsgGUID: 2Gr68sZtTPCOVai7IHpBPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11416"; a="47300800"
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; d="scan'208";a="47300800"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 02:20:35 -0700
X-CSE-ConnectionGUID: pyy0qjwJSuqlyTkYvsHM9A==
X-CSE-MsgGUID: Yagh8Bb2SKWFyrxdANFy7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; d="scan'208";a="133352882"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa006.fm.intel.com with ESMTP; 28 Apr 2025 02:20:33 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v8 0/4] net/intel: using common functions in idpf driver
Date: Mon, 28 Apr 2025 14:51:31 +0530
Message-Id: <20250428092135.1058532-1-shaiq.wani@intel.com>
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

v8: fixed idpf_desc_done fn.
v7: rebased on top of latest main branch for a clean apply.

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
 drivers/net/intel/idpf/idpf_rxtx_vec_common.h |  21 +-
 16 files changed, 235 insertions(+), 546 deletions(-)

-- 
2.34.1

