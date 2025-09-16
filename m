Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AD6CAC598
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 14:21:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 593E44067C;
	Tue, 16 Sep 2025 16:21:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 6D3D3402D1;
 Tue, 16 Sep 2025 16:21:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758032480; x=1789568480;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AhNlqD7PShY5giUoQpWzvRqHLn3ISxsubgmVYSpB8Jc=;
 b=AQ7YnyCOCIJPVJW+9LSI0jR+RP78X75F1YfBieskFs/OEkjW9LYjFn40
 ih5rnmHIpkx6Vsn+a0qmXmEUj20vkrZBCMvWqV0FT0HFdU9iMtCg27xuc
 gFtWDhpCpSbqW0TQJtNlWXFN1wPholwsODxwOR53hVNfdYnKG0oJHN1wr
 9ygKa1kUsDastSKUJK4S5cx1om+rAIvI1/dqMMWarAQV4t3nN0zKaZoBN
 4oj1mBEE6TVpNrIS4JZDUeQs3QW30YO7aFmWol/A5ErIK352npUduFGR6
 fWegVrN4A5z3lSEFfnc66tPHvZG53GlaS+ffWy3+gXDZXZJu4ROjfw2Kl w==;
X-CSE-ConnectionGUID: OHx/pGcDT/y9pHjvD5+M0A==
X-CSE-MsgGUID: vsNTEC4ASb245HFkUu2fPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71681331"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; d="scan'208";a="71681331"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 07:21:20 -0700
X-CSE-ConnectionGUID: 4UrVfDP3T+WbvDVVfmpoHw==
X-CSE-MsgGUID: GIHGhCGgTBOrY77JgHY2jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; d="scan'208";a="212115209"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa001.jf.intel.com with ESMTP; 16 Sep 2025 07:21:19 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 3/8] net/iavf: fix documentation for speed capabilities
Date: Tue, 16 Sep 2025 14:21:08 +0000
Message-Id: <20250916142113.3485738-4-ciara.loftus@intel.com>
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

The iavf PMD does not report the speed capabilities that the device is
capable of in the speed_capa field of the rte_eth_dev_info struct. The
documentation incorrectly stated this feature as supported. Fix this.

Fixes: 48de41ca11f0 ("net/avf: enable link status update")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 doc/guides/nics/features/iavf.ini | 1 -
 1 file changed, 1 deletion(-)

diff --git a/doc/guides/nics/features/iavf.ini b/doc/guides/nics/features/iavf.ini
index 61c4742197..4ce4dc5a88 100644
--- a/doc/guides/nics/features/iavf.ini
+++ b/doc/guides/nics/features/iavf.ini
@@ -7,7 +7,6 @@
 ; is selected.
 ;
 [Features]
-Speed capabilities   = Y
 Link status          = Y
 Rx interrupt         = Y
 Queue start/stop     = Y
-- 
2.34.1

