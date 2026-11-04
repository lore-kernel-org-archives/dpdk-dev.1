Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBBF606A698
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 18:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FZ4Aaiy7
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79C4E40299;
	Wed,  4 Nov 2026 19:05:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTPS id 2AE4F40281
 for <dev@dpdk.org>; Wed,  4 Nov 2026 19:05:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793815513; x=1825351513;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Y+EwjEyWH/KPdsz+gwzUq3Hvp26XJ5fYmkcnkBt1+cQ=;
 b=FZ4Aaiy75Ju5e9RsNnuhrG6j4Y+THe2fnI2A3zNopyWR5jo8diGTlvOb
 mozCt83p6OEyd7ifr371ll4ODRwll9iFh5aBClT8Nlv3ZI9voK41ByCeu
 Mrl/sOfjyIYFb21sbZpxJfrz9QI2wEsTg1MhA2oNn6Ako1IFnl5sO9e9U
 mhjPYRjJusfG9/gemzd9TN9iQbycrx0tKDedFhHXFYBUoLyJ0zXIX5fLF
 hxzdjDFGi0RnGwI1zIVQMV1qnko2eDPXdw0YVwR3yDXPWRDiGBb597hdp
 AEKRHrQTvaMM6OThgmb80zOGbKYZSkgq6LetUCwAqVqywmWVD+VcVM9o1 w==;
X-CSE-ConnectionGUID: qfsEiCyjSDe08t3VOdUTpw==
X-CSE-MsgGUID: 4Rt0NDaDSPmfKxZW69dr2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2481586"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2481586"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 10:05:11 -0800
X-CSE-ConnectionGUID: 3Ls9qKmFSVioNMCqPkN+cw==
X-CSE-MsgGUID: SAUCKkheR1qbaV8BkRw2ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="8566446"
Received: from silpixa00401385.ir.intel.com ([10.20.227.220])
 by fmviesa012.fm.intel.com with ESMTP; 04 Nov 2026 10:05:10 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Kevin Laatz <kevin.laatz@intel.com>
Subject: [PATCH v2] dma/idxd: remove experimental on whole driver
Date: Wed,  4 Nov 2026 18:04:39 +0000
Message-ID: <20261104180503.4061143-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008154351.387445-1-bruce.richardson@intel.com>
References: <20261008154351.387445-1-bruce.richardson@intel.com>
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

The idxd DMA driver was marked as experimental in MAINTAINERS file.
Remove this designation as it's been stable for a long time now.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Kevin Laatz <kevin.laatz@intel.com>
---
V2: rebase patch
    remove CC stable
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d865ffd46..9cc4431bda 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1374,7 +1374,7 @@ M: Bhagyada Modali <bhagyada.modali@amd.com>
 F: drivers/dma/ae4dma/
 F: doc/guides/dmadevs/ae4dma.rst
 
-Intel IDXD - EXPERIMENTAL
+Intel IDXD
 M: Bruce Richardson <bruce.richardson@intel.com>
 M: Kevin Laatz <kevin.laatz@intel.com>
 F: drivers/dma/idxd/
-- 
2.55.0

