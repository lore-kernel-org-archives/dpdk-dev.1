Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85BFC36002
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Mar 2025 12:38:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 987F640A6F;
	Mon, 24 Mar 2025 13:38:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 8CFFC402DA
 for <dev@dpdk.org>; Mon, 24 Mar 2025 13:38:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742819920; x=1774355920;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=zhGwFFB/pd1IINfhXcRFUIp2Lw6t7bZtPke0wrPB3ks=;
 b=D4qWrqhuYd+Ge55Evn6Ui0Hp+F8j2bEmT/HUEdbjhMj+pdx4mM6dmkYB
 dmwgfGDkCckGWE8oETQdxH7Y8h+N62JRZQMA2ueF5y3MzXl9kLc7JepXw
 t6h22wuf7MsCHCh3Rfk8nuQvNu/PnGctswrkvQMR3JP0ImgM5+z6iF+ch
 DTwfd0/UKybrVVxORIZth1XpFJ+CKe88FL8HGvs8kPQqCy+MsTJ/ZG0dX
 xweaEt/EslKs6cwQweHw2OBWCRTfkH6yY34OGsKL4WJ1yvY6WXBC6Qqwf
 wQkULrN8HNsZ/352uYDPgFaHgNN0s0Y+rrDsDzeXAu3v/4u4JEun/Rlhj A==;
X-CSE-ConnectionGUID: FwubnYxER3mBxQ77kHFkSw==
X-CSE-MsgGUID: yVRXJasvRNKsaD2cZPwrSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="54227005"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; d="scan'208";a="54227005"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2025 05:38:39 -0700
X-CSE-ConnectionGUID: 6i1I+ZNtQQKoHVQ+T2ncCw==
X-CSE-MsgGUID: gobYUPvfSdO/VFl9n+5DCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; d="scan'208";a="154943685"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by orviesa002.jf.intel.com with ESMTP; 24 Mar 2025 05:38:37 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v2 0/4] Use common structures and fns in IDPF and
Date: Mon, 24 Mar 2025 18:09:57 +0530
Message-Id: <20250324124001.1282624-1-shaiq.wani@intel.com>
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

Using common code from net/intel/common in idpf and cpfl drivers.

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

