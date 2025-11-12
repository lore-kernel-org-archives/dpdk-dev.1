Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E53CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 14:11:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85976402EA;
	Wed, 12 Nov 2025 15:11:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 7F9B1402AF
 for <dev@dpdk.org>; Wed, 12 Nov 2025 15:11:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762956665; x=1794492665;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0iELwWHceTCnRqZyxIRHWqIUlkPyh+7fT+0EyB2bCBM=;
 b=OFzYnFfbCCnMTuXztH5lasLFblC9N8wge4r4fimCpQBCSpHtm1cXldd6
 pjfdfOlvSyKWl50DHnbqy37VX1aUmAxrHiMyRxRyxtK2Flmm5Y8asEW0c
 bkLJYCcMXppxTE6vEdHlFNXXvF11KQpRUkaA/umzYVaSARPEJ7JGfkFXl
 QPgZ5hoIGeKYK0DfrucGoMii97FT7RdBy1ddFN35XMcPubPyYGjCgts4D
 aegCt9nTBi8anQyjCZYLzq967JNUptSzr8QcKJF+2+uauZAhP069K/x9G
 feW8wznoro5MqT3uKfFA2UiXdqpYzAalksIHuQCScp37PCurlyMnjGDqz A==;
X-CSE-ConnectionGUID: FCARqANDQ7q51hXGhokl0w==
X-CSE-MsgGUID: rQYK8WjiRRC4ZUZHAUYPpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="82415957"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="82415957"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 06:11:04 -0800
X-CSE-ConnectionGUID: 2uEWalvGRJurxJcrDXISog==
X-CSE-MsgGUID: xYuV5G03THWA1cgt8XaQVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="226500110"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 12 Nov 2025 06:11:03 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Sunil Kumar Kori <skori@marvell.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 0/3] fix null packet prepare function pointers
Date: Wed, 12 Nov 2025 14:10:56 +0000
Message-ID: <20251112141059.1576919-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251110122457.2575615-1-skori@marvell.com>
References: <20251110122457.2575615-1-skori@marvell.com>
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

Update all intel drivers to ensure that the packet prepare function
pointer is non-null.

Bruce Richardson (2):
  net/ixgbe: fix null packet prepare function
  net/fm10k: fix null packet prepare function

Sunil Kumar Kori (1):
  net/ice: fix null packet prepare function

 drivers/net/intel/fm10k/fm10k_ethdev.c | 4 ++--
 drivers/net/intel/ice/ice_rxtx.c       | 4 ++--
 drivers/net/intel/ixgbe/ixgbe_rxtx.c   | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

--
2.48.1

