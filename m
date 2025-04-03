Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17023C3600C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 11:23:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECB7340B8F;
	Thu,  3 Apr 2025 13:23:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 8DC504060C
 for <dev@dpdk.org>; Thu,  3 Apr 2025 13:23:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743679402; x=1775215402;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=PSUjJuTWtrsIOKup/eVZRM6eyxEQMJaUYSgzoX7eFjs=;
 b=aIhLyS9Ti6WN6KRZuKqZS/7EBG1RrWkLV7sjlXUAhPll4XPNPugSZKKU
 ohqRqCbd6OBoS08chgKp1QeTr88ahmCO5GdfV1xxmtt2W4AqAVii1VMZl
 CagvBozUj7ycZOhh97b7nkE73cEGtfAKfVzMwciGhorb+hEOvSM/Q1Uz6
 VnVMuO9sqPaZEiffdjTkGP+ZdIaaHhlms9SgLwlqGxusbrr+6v5srIHkB
 NS6wiuKbU5FD/UpJKhEkj8mKsCZkCheLcFbl0tvi6KZMP/0z+/DryIY9G
 gSyEfPCX+PiTgWUddXad2JAvltqMPg12jcvDXoXOrbMDn7HU0+koJ5G46 w==;
X-CSE-ConnectionGUID: zE9J8dnITO6nS5VA8gDVjA==
X-CSE-MsgGUID: VKXBzuJ6RdedUT//tWp1gQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="45257311"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; d="scan'208";a="45257311"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2025 04:23:21 -0700
X-CSE-ConnectionGUID: LLiaEnBVSSK8c/vHNYKjOw==
X-CSE-MsgGUID: Pl6optaHRmCp7XIdkghIIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; d="scan'208";a="127833181"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa009.fm.intel.com with ESMTP; 03 Apr 2025 04:23:20 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v6 0/4] net/intel: using common functions in idpf driver
Date: Thu,  3 Apr 2025 16:54:25 +0530
Message-Id: <20250403112429.2741138-1-shaiq.wani@intel.com>
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

