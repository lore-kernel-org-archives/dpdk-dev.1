Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E63C282D0
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Feb 2025 17:00:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7991840EE5;
	Fri, 28 Feb 2025 18:00:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id D3F6740280
 for <dev@dpdk.org>; Fri, 28 Feb 2025 18:00:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740762024; x=1772298024;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=zcmtBrVzKYVdUG006WldfLwAaHo3oRPlgQgmB62HvTU=;
 b=LS6Cd+PwK+viOKVo3rfi0tJ1Z6bJ3Oh03xvyT0CQD3QsFveD16klbade
 V9N5DfXpr+8c/wbpImz1+HFjQKli7jNNtbIBmZUaeMnY6prxD++ZhvW2F
 M7qT4uBatCkPVWF+tqgEO8B0YPaWTxNhb4DETEVszA233UkTfaOQU8Ww+
 r2nkdUMEYKz6XThIWkxzIgB2ZPij5bS1VLywri+Gu4SR1Wm9vUXgER4FS
 omkoCe6w+NPUtK+UllAyCNiCHLsP1cPvwg6ef792aabeydC1UV7439kLb
 mBwZXDD//VX9M7NZ4TQCQkA/iVM8v5Hosio4IIzJvpBtVNh3aisKZ17FD w==;
X-CSE-ConnectionGUID: MGKqEqEPT1SiY4lwsOaCaw==
X-CSE-MsgGUID: 2UtXAjMoS8OxuQ9WFZSVBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="53084405"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; d="scan'208";a="53084405"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2025 09:00:22 -0800
X-CSE-ConnectionGUID: DUI9ILnOSTqBZ1nAvdu6Pg==
X-CSE-MsgGUID: Jcd+WzgSQpigg/sguwXXDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; d="scan'208";a="122526310"
Received: from spr-npg-bds1-eec2.sn.intel.com (HELO spr-npg-bds1-eec2..)
 ([10.233.181.123])
 by fmviesa004.fm.intel.com with ESMTP; 28 Feb 2025 09:00:22 -0800
From: Nicolas Chautru <nicolas.chautru@intel.com>
To: dev@dpdk.org,
	maxime.coquelin@redhat.com
Cc: hemant.agrawal@nxp.com, hernan.vargas@intel.com,
 Nicolas Chautru <nicolas.chautru@intel.com>
Subject: [PATCH v1 0/2] bbdev: doc and vector clean up
Date: Fri, 28 Feb 2025 08:50:20 -0800
Message-Id: <20250228165022.480453-1-nicolas.chautru@intel.com>
X-Mailer: git-send-email 2.34.1
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

Minor changes to clean up the documentation for bbdev programming guide
and updating vectors to avoid false alarms when using different
windowing configuration assumption by users.

Nicolas Chautru (2):
  doc: update bbdev documentation
  test/bbdev: update to fft test vectors

 app/test-bbdev/test_vectors/fft_9.data      | 870 --------------------
 app/test-bbdev/test_vectors/fft_byp_28.data |  48 +-
 doc/guides/prog_guide/bbdev.rst             |   2 +-
 3 files changed, 25 insertions(+), 895 deletions(-)
 delete mode 100644 app/test-bbdev/test_vectors/fft_9.data

-- 
2.34.1

