Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF97CA0EE8
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 05:27:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3620B40285;
	Wed, 17 Sep 2025 07:27:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 240804025A
 for <dev@dpdk.org>; Wed, 17 Sep 2025 07:27:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758086875; x=1789622875;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=yVqHUzfPIExP2y4EwhFaC1RcUJv/TUqRo4uUaAxaYCk=;
 b=WnBERz5SxKqu9TzMY//E3WqeZKHocuna8fsSVWGdq0xDQC/l+TrUciDH
 HUCqjWCV2aCqXxKVU8vCTIA2QNojUNB9QjwznNawyFVw3bIInoYb89+hY
 jwKKBYc+5rEfUZY7AM3+IhAbM3mqfeZOngGO6F8DhXUGZJplASlYIXqAa
 kb+VXlhmFWUG0QXGlj7X30qSko738c06WlZh6SXWV3tfaK6C6Rt0vGz+m
 XaEooerIkDZU+RQnlNXl2PdeUxDClx3jYASbDl9j4tvJQ2MLDLB3WNMg0
 sT6ozpVQ7L/aPC7DkChVWboESHEc5cUHL5XuskDuIYlb0EWgFMEBtVDp6 w==;
X-CSE-ConnectionGUID: pHwTxSGbTsmiYK7uIuDyvg==
X-CSE-MsgGUID: TNXMjefzRpiwcpMGq3USjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60250201"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; d="scan'208";a="60250201"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 22:27:53 -0700
X-CSE-ConnectionGUID: 3Zc20rAmSumi3et7HeQr2w==
X-CSE-MsgGUID: sM8ZvGp8QsuX5kngbyBilw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; d="scan'208";a="206101402"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa001.fm.intel.com with ESMTP; 16 Sep 2025 22:27:51 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH 0/2] net/idpf: enable AVX2 for split queue Rx/Tx
Date: Wed, 17 Sep 2025 10:56:56 +0530
Message-Id: <20250917052658.582872-1-shaiq.wani@intel.com>
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

In case some CPUs don't support AVX512. Enable AVX2 for them to
get better per-core performance.

In the single queue model, the same descriptor queue is used by SW
to post descriptors to the device and used by device to report completed
descriptors to SW. While as the split queue model separates them into
different queues for parallel processing and improved performance.

Shaiq Wani (2):
  net/idpf: enable AVX2 for split queue Tx
  net/idpf: enable AVX2 for split queue Rx

 drivers/net/intel/idpf/idpf_common_rxtx.h     |   6 +
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 448 ++++++++++++++++++
 drivers/net/intel/idpf/idpf_rxtx.c            |  20 +-
 3 files changed, 472 insertions(+), 2 deletions(-)

-- 
2.34.1

