Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6442606A33F
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 03:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SiSQ38gF
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7958540395;
	Fri, 20 Nov 2026 04:23:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTPS id A197D402EF
 for <dev@dpdk.org>; Fri, 20 Nov 2026 04:23:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795144983; x=1826680983;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rzWJjSylfk15zkWeJlYec8JO/SP3Lzp4f/39V1rw/P4=;
 b=SiSQ38gFXeQoXzHzh/abOUndqq/NhnNjfJcFR3MQtl5o8TjSaR8rKNtr
 uI0BIXV1yCBZeFp4O/gPsKiUsdsIBIuNT5a2QX9A7BuE+ES1UrdfQptcD
 zimUFHcj0Uk/6OS62m+4QlGTkb62HAhn8CRRKSNvwtnDPRD3hepg32c2d
 jnVQ4OJ4FvB7WKT/ueq9D3kDnf2b11H0iGi3oR9v5uybMyrizJVJe8XW8
 PpdqoO3V7vP2KNgtn1eR4Y+6//p+eRla8MnsgawINJ68TkA0WcvkuIX7D
 CPR1WlAy7liMFmqcK86Hd2K1J4b91tuHwleUCYTPCWpENf9Mk6juVVq90 A==;
X-CSE-ConnectionGUID: 8d/OK4UDSse3lMmfQY4eGg==
X-CSE-MsgGUID: lrGkfJZjTnq54AKbfSFM5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3902114"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3902114"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 19:23:01 -0800
X-CSE-ConnectionGUID: u+mpnM3XRh+OBDO4RjTGIQ==
X-CSE-MsgGUID: Hu16M63vRtS5vYQc8ZkFZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; d="scan'208";a="10883252"
Received: from unknown (HELO tester12..) ([10.239.252.12])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 19:22:59 -0800
From: Hailin Xu <hailinx.xu@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: manjunathgouda.hosamani@intel.com,
	Hailin Xu <hailinx.xu@intel.com>
Subject: [PATCH v1 3/3] nics/ixgbe: update ixgbe latest recommended matching
 list
Date: Fri, 20 Nov 2026 11:15:25 +0800
Message-ID: <20261120031525.300632-4-hailinx.xu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261120031525.300632-1-hailinx.xu@intel.com>
References: <20261120031525.300632-1-hailinx.xu@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Hailin Xu <hailinx.xu@intel.com>
---
 doc/guides/nics/ixgbe.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/doc/guides/nics/ixgbe.rst b/doc/guides/nics/ixgbe.rst
index 1d14e292e2..6949575be2 100644
--- a/doc/guides/nics/ixgbe.rst
+++ b/doc/guides/nics/ixgbe.rst
@@ -68,8 +68,7 @@ are listed in the Tested Platforms section of the Release Notes for each release
 ============  =====================  ===============  ===============
 DPDK version  Kernel driver version  E610 FW version  X550 FW version
 ============  =====================  ===============  ===============
-   26.07              6.4.4               1.60             3.70
-   26.03              6.3.4               1.41             3.70
+   26.11              6.5.9               1.70             3.70
    25.11              6.2.5               1.30
 ============  =====================  ===============  ===============
 
-- 
2.43.0

