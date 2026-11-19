Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F3360A2612
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 10:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZqA8RPI4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57DCC4042C;
	Thu, 19 Nov 2026 11:41:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTPS id 52DB0402F1
 for <dev@dpdk.org>; Thu, 19 Nov 2026 11:41:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795084907; x=1826620907;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7aYsMV5UZgRxiz8xJw6Tovzl9nvOR7tpDG1pavOxHN0=;
 b=ZqA8RPI4hyutLUCNjcHkhNgJjfW3sRjrNH7VWKB+KhTNDoSe73LWexNj
 yj2naPa1mhyCpQAzTWwhusga+jPNpIb3Fu3z4bKcTZDi1sPxR9bKYWLIl
 T2F+bGfLTMJNHe2qyeILm13MBrVYnHnfvyYsFbwekQVPt6MnjboY9kWM8
 UCUjjscV8wSfKvKMfQBIq4ldWabIbXoVuCLRhRRJZBFKeM8ZQ3+poffQS
 iF97FIZiKYmdZ/OzFdpqH9/3GIVJYm8cX4YyTUfE6ukhzf1dUshcH/EU/
 OvBCLFOD9TnDzZ2J+hNfOJ/W0PoTqKaUpFM1QJ3usFjOcNHy/42WMLUBZ Q==;
X-CSE-ConnectionGUID: pmigU+/FS6i2zkbjs1t6iA==
X-CSE-MsgGUID: qFOrok19Sv+Jfp6+JoavuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3825095"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3825095"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 02:41:47 -0800
X-CSE-ConnectionGUID: ydam0XznQme15ZF1JIjgqg==
X-CSE-MsgGUID: v5cRzFSISh+Dq+iVb8g2UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; d="scan'208";a="10208899"
Received: from unknown (HELO tester12..) ([10.239.252.12])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 02:41:46 -0800
From: Hailin Xu <hailinx.xu@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: manjunathgouda.hosamani@intel.com,
	Hailin Xu <hailinx.xu@intel.com>
Subject: [PATCH v1 3/3] updated ixgbe latest recommended matching list
Date: Thu, 19 Nov 2026 18:34:08 +0800
Message-ID: <20261119103408.289005-4-hailinx.xu@intel.com>
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
 doc/guides/nics/ixgbe.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/guides/nics/ixgbe.rst b/doc/guides/nics/ixgbe.rst
index 90fdf0a39f..67d6c05372 100644
--- a/doc/guides/nics/ixgbe.rst
+++ b/doc/guides/nics/ixgbe.rst
@@ -68,6 +68,7 @@ are listed in the Tested Platforms section of the Release Notes for each release
 ============  =====================  ===============  ===============
 DPDK version  Kernel driver version  E610 FW version  X550 FW version
 ============  =====================  ===============  ===============
+   26.07              6.4.4               1.60             3.70
    26.03              6.3.4               1.41             3.70
    25.11              6.2.5               1.30
 ============  =====================  ===============  ===============
-- 
2.34.1

