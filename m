Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBE9CA0EED
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 Aug 2025 17:07:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0D7B4029A;
	Fri, 22 Aug 2025 19:07:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id A96A840297
 for <dev@dpdk.org>; Fri, 22 Aug 2025 19:07:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755882430; x=1787418430;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=VnuWx7skO8usYbxkzAcFquBkv/Pj4zsY/O7QgzwU2io=;
 b=mb6w0OlGBjghGEJ2NAdOh/FjbjBPdhMbDPAqkkW3rkYdObmknIHvLkRN
 pBLx9m3vrjgx1nBB34x02o6LZDq983rJV4EfsHeeTe1xGKh2lzOujb7rp
 X4NtnXGIKa+jgXJU0XOdc/XIP18C6PgiclOAARDLGGyN+QtAOMk0QUyBb
 OmoseGZHFT6+tXuH1E3e2trMNXb6/ViWIwijNv0q8w0vh85ofSUmLXQAi
 Hr23hRDfhZnss88uUgskw1sS1lC0gCGtJiutGPZbd+GjZzUcFg1h9zgZV
 BgvciK6yuhxiLyOjla94qLdR9wnfuyDCc0L2sEPBwvKFPa1ii090CtKOl g==;
X-CSE-ConnectionGUID: 7aZ3a8zJQSKTAoDLQDxKIw==
X-CSE-MsgGUID: zy4Jh2pKRVmw374bCRk+3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="69294553"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="69294553"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2025 10:07:08 -0700
X-CSE-ConnectionGUID: SyhTMzKjQ3C1HSimc/6OjQ==
X-CSE-MsgGUID: ZVCDELWPQneN5d4iZ7vZNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="192416666"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.55.129.54])
 by fmviesa002.fm.intel.com with ESMTP; 22 Aug 2025 10:07:07 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: mb@smartsharesystems.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 0/2] avoid using mempool fns directly
Date: Fri, 22 Aug 2025 17:06:54 +0000
Message-ID: <20250822170656.454571-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
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

Use the new mbuf inline APIs to avoid using mempool functions directly
from drivers.

Bruce Richardson (2):
  net/intel: avoid allocating from mempool directly
  net/intel: avoid accessing mempool directly on free

 drivers/net/intel/common/rx_vec_arm.h            |  6 +++---
 drivers/net/intel/common/rx_vec_ppc.h            |  6 +++---
 drivers/net/intel/common/rx_vec_x86.h            |  6 +++---
 drivers/net/intel/common/tx.h                    |  4 ++--
 drivers/net/intel/fm10k/fm10k_ethdev.c           |  5 ++---
 drivers/net/intel/fm10k/fm10k_rxtx.c             | 13 ++++++-------
 drivers/net/intel/fm10k/fm10k_rxtx_vec.c         |  7 +++----
 drivers/net/intel/i40e/i40e_rxtx.c               |  7 +++----
 drivers/net/intel/iavf/iavf_rxtx.c               |  2 +-
 drivers/net/intel/ice/ice_rxtx.c                 |  6 +++---
 drivers/net/intel/idpf/idpf_common_rxtx_avx2.c   |  2 +-
 drivers/net/intel/idpf/idpf_common_rxtx_avx512.c |  4 ++--
 drivers/net/intel/ixgbe/ixgbe_rxtx.c             |  7 +++----
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h  |  5 ++---
 14 files changed, 37 insertions(+), 43 deletions(-)

-- 
2.48.1

