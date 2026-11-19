Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A33606A33F
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 10:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fE7mk3A1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C029A402ED;
	Thu, 19 Nov 2026 11:41:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTPS id D0D62400D7
 for <dev@dpdk.org>; Thu, 19 Nov 2026 11:41:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795084904; x=1826620904;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=L+TIlGnHDfqw/VfExKckofRFJzXK9pDt2KFSOaRrLLk=;
 b=fE7mk3A1dlEx3UYT9zB4lEjuS9xYxhek0znBf4UvNs2WD3Q73049Wa4M
 XX6ufGdTEUXPcRJN7fCAFDK4lQkZ7iad+y40U2tqDWILwekv+Mz2Pu3re
 J5E/CbKxN8gOr+IGiqagi59hEy/z0PPDNCR6rCtWzFQ2Wb4IYeX3uggmU
 1EYgoPSpODQAYN6Cjd4l5okKQg4BLFwcb6SmD+P0rxozR7S9q8NuP6Zw1
 yLfvJguf47H+RaaImlPel0Cb67s5+OiT8aLEfzlOsf+BnPUu55Rd61Ch5
 28XUv8vTGav/UFBFgIINxUVdAibazYYy/rCMimmDZiEP4lqp3gsfPNdjc g==;
X-CSE-ConnectionGUID: to5NgKQaQ0qcnvPJfRloyw==
X-CSE-MsgGUID: gKL6JYhVSvKWPreZgzLaVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3825091"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3825091"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 02:41:43 -0800
X-CSE-ConnectionGUID: hXq3CqOuRBa19skgnFuG5A==
X-CSE-MsgGUID: RQiXDVbISxqttlhMa3JLGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; d="scan'208";a="10208867"
Received: from unknown (HELO tester12..) ([10.239.252.12])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 02:41:43 -0800
From: Hailin Xu <hailinx.xu@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: manjunathgouda.hosamani@intel.com,
	Hailin Xu <hailinx.xu@intel.com>
Subject: [PATCH v1 1/3] updated i40e latest recommended matching list
Date: Thu, 19 Nov 2026 18:34:06 +0800
Message-ID: <20261119103408.289005-2-hailinx.xu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119103408.289005-1-hailinx.xu@intel.com>
References: <20261119103408.289005-1-hailinx.xu@intel.com>
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
 doc/guides/nics/i40e.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/guides/nics/i40e.rst b/doc/guides/nics/i40e.rst
index e67498aef4..b0e8cf1f55 100644
--- a/doc/guides/nics/i40e.rst
+++ b/doc/guides/nics/i40e.rst
@@ -102,6 +102,7 @@ are listed in the Tested Platforms section of the Release Notes for each release
 ============  =====================  ================  ===============
 DPDK version  Kernel driver version  X710* FW version  X722 FW version
 ============  =====================  ================  ===============
+   26.07             2.30.18               9.57             6.51
    26.03             2.28.16               9.56             6.51
    25.11             2.28.13               9.55             6.51
    24.11             2.26.8                9.52             6.50
-- 
2.34.1

