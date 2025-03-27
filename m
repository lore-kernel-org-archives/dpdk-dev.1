Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA45C3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 16:03:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CA0A406BB;
	Thu, 27 Mar 2025 17:03:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 2758140654
 for <dev@dpdk.org>; Thu, 27 Mar 2025 17:03:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743091400; x=1774627400;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=l+6wwPKEDucqi+wY0/bYaqCoxuQbvmvxgM79mWkkhRI=;
 b=YI0XwwbdNGBmdJF2RlVds21kvWy/FXWBh7MtHSIcrwv+Id884ZNH8DyA
 sdmMizQm2n8Xm/+QeusEvcIzx3WcCIfd68VAZnA1O39L7MwV6WFfaIjp8
 wphTJr+8deQaf9q6OsVT5hIJ1Qn23J1iQdxFIqdnJ72h+J0toDETiE3Hm
 gTx2e4mjGgt3Nz08nvdCo5f3iZ9ETxbTE5QytcOn2Y+kmv4LW/7oS4z4q
 36k9IORpvNTHZ54z/UfTxbmBTHWWvf33xTg0JMMtaWKybiRJbkwNVQKkN
 DHGga5GiTwyb1Gyhvn2MGucrhYe08lo4dtHynroWCzPhBI1qMLbx9rFbf Q==;
X-CSE-ConnectionGUID: JmGkOyNWQEWnY3KhsAZ/XA==
X-CSE-MsgGUID: nm6Kv4l9TZyCy8rSJmUvng==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="61825748"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="61825748"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 09:03:17 -0700
X-CSE-ConnectionGUID: ATokeHAFR/CCohgNwkvTCw==
X-CSE-MsgGUID: kKYGc4ogRjGNarO8/VtT/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="125412024"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2025 09:03:16 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v5 0/4] net/intel: using common functions in idpf driver
Date: Thu, 27 Mar 2025 21:34:33 +0530
Message-Id: <20250327160437.2296127-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250327104502.2107300-2-shaiq.wani@intel.com>
References: <20250327104502.2107300-2-shaiq.wani@intel.com>
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
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 115 ++-----
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  | 324 +++---------------
 drivers/net/intel/idpf/idpf_common_virtchnl.c |   8 +-
 drivers/net/intel/idpf/idpf_common_virtchnl.h |   2 +-
 drivers/net/intel/idpf/idpf_ethdev.c          |   3 +-
 drivers/net/intel/idpf/idpf_rxtx.c            |  47 ++-
 drivers/net/intel/idpf/idpf_rxtx.h            |   1 +
 drivers/net/intel/idpf/idpf_rxtx_vec_common.h |   9 +-
 16 files changed, 245 insertions(+), 550 deletions(-)

-- 
2.34.1

