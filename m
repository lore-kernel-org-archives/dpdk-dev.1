Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4A5CAC599
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 14:21:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D02A740696;
	Tue, 16 Sep 2025 16:21:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 92155402D1;
 Tue, 16 Sep 2025 16:21:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758032482; x=1789568482;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GVfmIdETVlFyA9TfAVXdVy/6bUZL8N6Qizl1jXZbtzo=;
 b=SZEBoOfF4SMSfyVUr1dAsBgU54FTxaTZSSlhVPDXEaeoC+FSZONRL5wH
 Z3ZOCcpaoZ9rz4OlmXjw7qLundwPXQRlxU1ifivnCj+LbQT5nxOPVEUe4
 K2M+uEwd5Ws2yS7tiI4wCmrM777iPRfhUd/zw0fn7c8FCerJr3gmwqkbp
 uWSaQ9Ndmjq3IdiDEIWUcTh9FjkOb3rtUt8vy7/O3nBnB0XyJkRNo/uE9
 yPLIvX4MlmvfosIJFfFDWzwAsa838padXi61tchU1Zc19B6jpviPUvPvY
 BBuTBZxOUHsFJYeUa1eivvMg5Myx14cdUOd9ziyf9E6Gv8/s6h7DLhA/L w==;
X-CSE-ConnectionGUID: Dx88GGYITBWKc1ElEYmQJA==
X-CSE-MsgGUID: 1YPMzRPSS7eK6pjvCwpKdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71681337"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; d="scan'208";a="71681337"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 07:21:21 -0700
X-CSE-ConnectionGUID: GT7+caVyRWCzo0sRf2pHXg==
X-CSE-MsgGUID: 4pZJzE6fQLevQx9LiFQbSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; d="scan'208";a="212115220"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa001.jf.intel.com with ESMTP; 16 Sep 2025 07:21:20 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 4/8] net/iavf: document support for fast mbuf free
Date: Tue, 16 Sep 2025 14:21:09 +0000
Message-Id: <20250916142113.3485738-5-ciara.loftus@intel.com>
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

The fast mbuf free feature has been partially supported since commit
9ab9514c150e ("net/iavf: enable AVX512 for Tx"). Update the list of
supported features to reflect this.

Fixes: 9ab9514c150e ("net/iavf: enable AVX512 for Tx")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 doc/guides/nics/features/iavf.ini | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/guides/nics/features/iavf.ini b/doc/guides/nics/features/iavf.ini
index 4ce4dc5a88..aac27bd706 100644
--- a/doc/guides/nics/features/iavf.ini
+++ b/doc/guides/nics/features/iavf.ini
@@ -9,6 +9,7 @@
 [Features]
 Link status          = Y
 Rx interrupt         = Y
+Fast mbuf free       = P
 Queue start/stop     = Y
 Runtime Rx queue setup = Y
 Runtime Tx queue setup = Y
-- 
2.34.1

