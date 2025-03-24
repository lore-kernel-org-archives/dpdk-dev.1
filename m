Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3BDC36002
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Mar 2025 12:47:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DECE240A6F;
	Mon, 24 Mar 2025 13:47:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id C476840655
 for <dev@dpdk.org>; Mon, 24 Mar 2025 13:47:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742820462; x=1774356462;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=e4T0rCRXIp2F13T6rVJttR3IXQnktEI6+/72l5xegW4=;
 b=mB0LRVZ77BtuMz7+Rx9ossTp+NSIDFvZ3cIY/U3lVByrGYd3rkpG8FsU
 0hE3A0xJX3L5co+MV7sgpgvUdUjtUUdaccyRmzqlVp+Lybtev94/J/0Q8
 gKIKTw0yw+hmiB8Jwp+hCDyavsxErwKzvHWYvNWcSuTts7n0kN87K5nO7
 5eIAjD3G5IUOxB//7JPaR4B8u60VRLgeOEPctHOf10ned2vIiBu4GyGHZ
 7ng6ywyaPjwFQpyud50OeGaRJf47yeYsnl3Jpd8+vxgtWjHRvQiHwFeiP
 MH/Ulor/qxA2jEmQLg1tWYtEMI4z0uXyy63K3CmZ/FEvZR5iJdJ2dGQ0o w==;
X-CSE-ConnectionGUID: LQwLVE2aSzacL8PD/dt32Q==
X-CSE-MsgGUID: xOTTaosPSES+xaDNMqKlHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="55396293"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; d="scan'208";a="55396293"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2025 05:47:41 -0700
X-CSE-ConnectionGUID: 83Nwfj2XSmS+AJ7cJwDlWQ==
X-CSE-MsgGUID: ncwTyue2S/2MD9Wp+gSWqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; d="scan'208";a="128213541"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa003.fm.intel.com with ESMTP; 24 Mar 2025 05:47:39 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v3 0/4] using common functions in idpf driver
Date: Mon, 24 Mar 2025 18:19:04 +0530
Message-Id: <20250324124908.1282692-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324124001.1282624-2-shaiq.wani@intel.com>
References: <20250324124001.1282624-2-shaiq.wani@intel.com>
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

reworked the idpf and cpfl drivers to use the common functions and structures
from drivers/net/intel/common.

Shaiq Wani (4):
  net/intel: use common Tx queue structure
  net/intel: align Tx queue struct field names
  net/intel: use common Tx entry structure
  net/idpf: use common Tx free fn in idpf

 drivers/net/intel/common/tx.h                 |  18 +
 drivers/net/intel/cpfl/cpfl_ethdev.c          |   3 +-
 drivers/net/intel/cpfl/cpfl_ethdev.h          |   2 +-
 drivers/net/intel/cpfl/cpfl_rxtx.c            |  66 ++--
 drivers/net/intel/cpfl/cpfl_rxtx.h            |   3 +-
 drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h |   7 +-
 drivers/net/intel/idpf/idpf_common_rxtx.c     | 112 +++---
 drivers/net/intel/idpf/idpf_common_rxtx.h     |  69 +---
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 115 ++-----
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  | 323 +++---------------
 drivers/net/intel/idpf/idpf_common_virtchnl.c |   8 +-
 drivers/net/intel/idpf/idpf_common_virtchnl.h |   2 +-
 drivers/net/intel/idpf/idpf_ethdev.c          |   3 +-
 drivers/net/intel/idpf/idpf_rxtx.c            |  48 ++-
 drivers/net/intel/idpf/idpf_rxtx.h            |   1 +
 drivers/net/intel/idpf/idpf_rxtx_vec_common.h |   9 +-
 drivers/net/intel/idpf/meson.build            |   2 +-
 17 files changed, 241 insertions(+), 550 deletions(-)

-- 
2.34.1

