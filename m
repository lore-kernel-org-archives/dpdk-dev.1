Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0537CAC599
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 14:21:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3C0140613;
	Tue, 16 Sep 2025 16:21:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id CD796402D1;
 Tue, 16 Sep 2025 16:21:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758032479; x=1789568479;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=G3iCTcasRm/1hnT+PxD6241v0qfM/elU3wbANtlGIBQ=;
 b=cpJlteWKmkzbkvcfW+uX1L5PXlAFnMBhD96NZ4+XtfS9XwDfufOYfVXT
 REhJCrYNisdpHZn8hAlEC9qL6NFAb7dxyKU6ay2dAgP6IlQ0OKwMEZvsr
 Fnk5HRlODclrZgUH4pYkCBWm8/7oylR7vFbqOWCpgYmfNMdF0mR8CTZ3R
 XQde/gUUNOQQmTNXcozBkeoYmNtCctEZlYZ5RpvEAe9IjLeV9eEyyezvL
 XsKbNxdeFcQvnEcDWvuSi6xIL9+2YlEWp35sSNGB0ZyRyEdmF8W0/yg6L
 0Av1Gk+C9yxwNC2MlAKA37RNtmmJIOvMiPJapDA13D1f5j9q8U8ap2mvg Q==;
X-CSE-ConnectionGUID: LXhR6PybSHGIWPANRpY4Fg==
X-CSE-MsgGUID: tD4NvhPLSa6LUhPo4HTVZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71681329"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; d="scan'208";a="71681329"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 07:21:17 -0700
X-CSE-ConnectionGUID: KGi5o95ZSsC/ImMDUP8B+Q==
X-CSE-MsgGUID: eeNIy32qQ6q2QKzitEQ/6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; d="scan'208";a="212115195"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa001.jf.intel.com with ESMTP; 16 Sep 2025 07:21:17 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 1/8] net/ice: document support for free Tx mbuf on demand
Date: Tue, 16 Sep 2025 14:21:06 +0000
Message-Id: <20250916142113.3485738-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916142113.3485738-1-ciara.loftus@intel.com>
References: <20250916142113.3485738-1-ciara.loftus@intel.com>
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

The free tx mbuf on demand feature has been supported since commit
ab7cfe1fe3d7 ("net/ice: cleanup Tx buffers"). Update the list of
supported features to reflect this.

Fixes: ab7cfe1fe3d7 ("net/ice: cleanup Tx buffers")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 doc/guides/nics/features/ice.ini | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/guides/nics/features/ice.ini b/doc/guides/nics/features/ice.ini
index 9c8569740a..2703493514 100644
--- a/doc/guides/nics/features/ice.ini
+++ b/doc/guides/nics/features/ice.ini
@@ -14,6 +14,7 @@ Link status event    = Y
 FEC                  = Y
 Rx interrupt         = Y
 Fast mbuf free       = P
+Free Tx mbuf on demand = Y
 Queue start/stop     = Y
 Burst mode info      = Y
 Power mgmt address monitor = Y
-- 
2.34.1

