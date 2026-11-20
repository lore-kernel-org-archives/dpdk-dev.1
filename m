Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73DB60A2600
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 03:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Kl0ow9lZ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4C17402EF;
	Fri, 20 Nov 2026 04:23:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTPS id A89C540151
 for <dev@dpdk.org>; Fri, 20 Nov 2026 04:23:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795144981; x=1826680981;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=V8tGNHhwCrcHks3wiypk6qPBT9hx0ImmJdONsHCtF3s=;
 b=Kl0ow9lZ2WplsBLf+EJz1huXHa0tG1tW7jrXtZN/os3AMN2UOp8O8Q++
 q9UJEDachDr096E2r5nCH/OHr3ed8//SYYVkd1+FGuMOyic0utzaOIzbA
 RGsFMLP/JJ5OHOQLV+LM3keffMHDI3V293AYnEwddli/ugAMdbC1LRkXk
 bTHU5qS4afXVDZiJcOs9ybWeqPk3BBiu03J7KC25A60cZdOwSkxZE+LCf
 7ancYA6ElRi6hBvaSesDMFzehMfnDCygpemsjfveXqZGoIjHi675VG0gS
 G55h5MwQVKm1xzpnAH76W7M0kw7e68pi7M5fkBqXCw+6TdVcbiOH6ZoA0 Q==;
X-CSE-ConnectionGUID: 4WDYpbV0Snai9RoYAVjazQ==
X-CSE-MsgGUID: mnXtEvJpQMKfgLFcBRw0Zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3902112"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3902112"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 19:22:59 -0800
X-CSE-ConnectionGUID: Dnkf9KrHQt6QO/yuIcORqg==
X-CSE-MsgGUID: 9LqJXimeQ96XUlMrfJkA5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; d="scan'208";a="10883248"
Received: from unknown (HELO tester12..) ([10.239.252.12])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 19:22:58 -0800
From: Hailin Xu <hailinx.xu@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: manjunathgouda.hosamani@intel.com,
	Hailin Xu <hailinx.xu@intel.com>
Subject: [PATCH v1 2/3] nics/i40e: update i40e latest recommended matching list
Date: Fri, 20 Nov 2026 11:15:24 +0800
Message-ID: <20261120031525.300632-3-hailinx.xu@intel.com>
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
 doc/guides/nics/i40e.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/doc/guides/nics/i40e.rst b/doc/guides/nics/i40e.rst
index 29234dbf0f..772b351232 100644
--- a/doc/guides/nics/i40e.rst
+++ b/doc/guides/nics/i40e.rst
@@ -102,8 +102,7 @@ are listed in the Tested Platforms section of the Release Notes for each release
 ============  =====================  ================  ===============
 DPDK version  Kernel driver version  X710* FW version  X722 FW version
 ============  =====================  ================  ===============
-   26.07             2.30.18               9.57             6.51
-   26.03             2.28.16               9.56             6.51
+   26.11             2.30.83               9.58             6.51
    25.11             2.28.13               9.55             6.51
    24.11             2.26.8                9.52             6.50
    23.11             2.23.17               9.30             6.20
-- 
2.43.0

