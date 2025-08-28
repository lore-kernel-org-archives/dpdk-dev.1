Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D25CA0EED
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 09:28:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BC55402DC;
	Thu, 28 Aug 2025 11:28:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 29F384025A
 for <dev@dpdk.org>; Thu, 28 Aug 2025 11:28:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756373312; x=1787909312;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=An50no9pO1fhZo44G23xW3Cw2ya0cUWhWZpgQb5yVfQ=;
 b=Hq58+E8sea9AKhdNVQN7FaUn+lAZ2rf3j4Gn75qLyTd89XH2HbJAqlot
 7E+/Kux82ZPnzC/UOgpqN5Vf7DXl0RRJPjMxcrkXq098/NrhY4XphxjiZ
 4jsnw0RusFy1eGZHk2IIUggFvqKukS9gX0zJl4DX+kgSjx0j8lBEQe3un
 Q314cXsXN3DniC6/d+lhbddiz7gvmk1FKZ9gKA2CYZ97Cr8o99Am5llHv
 zzH5jTKsaylVXInNDJ2apXg0ee7gR2YO/Gd3yBwCaYRN6G8ULV+Jq15JQ
 FCAANZbI680NfiTZke+Fra2RlIMrV4O0OlSASrtrGrGR9Fl6EYf1Zmq4S g==;
X-CSE-ConnectionGUID: CxBOlMyxSRSal8jQURzncg==
X-CSE-MsgGUID: lAEnCZ0hQkWpB2QiJqFGag==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="69732035"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="69732035"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 02:28:31 -0700
X-CSE-ConnectionGUID: sdovOtlnRuatyvU7BwjOHA==
X-CSE-MsgGUID: Pv8HKyidS1+0qIYLTQTfyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="170872930"
Received: from silpixa00401454.ir.intel.com ([10.237.213.198])
 by fmviesa010.fm.intel.com with ESMTP; 28 Aug 2025 02:28:28 -0700
From: Emma Finn <emma.finn@intel.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Cc: dev@dpdk.org,
	kai.ji@intel.com,
	Emma Finn <emma.finn@intel.com>
Subject: [PATCH] examples/fips_validation: fix dangling pointer for SHA test
Date: Thu, 28 Aug 2025 09:28:21 +0000
Message-Id: <20250828092822.2791101-1-emma.finn@intel.com>
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

Set vector pointer to NULL after free to avoid calling rte_free()
on the same pointer twice in some cases.

Signed-off-by: Emma Finn <emma.finn@intel.com>
---
 examples/fips_validation/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/examples/fips_validation/main.c b/examples/fips_validation/main.c
index f21826e9d7..60ee9f8dd4 100644
--- a/examples/fips_validation/main.c
+++ b/examples/fips_validation/main.c
@@ -2612,7 +2612,7 @@ fips_mct_sha_test(void)
 		rte_free(md[i].val);
 
 	rte_free(vec.pt.val);
-
+	vec.pt.val = NULL;
 	rte_free(val.val);
 	return 0;
 }
-- 
2.34.1

