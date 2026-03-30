Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD62AFF495E
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Mar 2026 14:15:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8E7D40691;
	Mon, 30 Mar 2026 16:14:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 39ED14065C
 for <dev@dpdk.org>; Mon, 30 Mar 2026 16:14:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774880070; x=1806416070;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qNtzfM+i5x9oQ+tUfGamj/BZWnKqkOVrc5957CXQzU4=;
 b=PCUvrOc4TPZ3soBGUhjbq5HaZMw6fyPhbX2EHcKST39aM3CF1VYj1x2m
 iGABLZtYSj4O5jEjZdu0p0wOJAHmR+n2G0ZgrM0wuKGr+f/r6YZkVNcZ8
 m/y+1kJzJ+yaW0E+Kmnfm1dbxSXIn7Z7u7hwp4OCmISf5WkHZe1n4nKQ3
 jTzfu51ED4JTy9KBAYGJX83xtGFVtLl9I8DYIrwY/YgxloQ0wkgzqGdzD
 Qs3BmCIF0r21rlEDZEvpSwsmhZN4Ew7YT9y8ywxuBJjZF09gyjqFwMS8v
 scym6Z+3gj9aINasrzHXwHZEkVvBjmUb29drbsh/Kvxh6/4Nc46UICp5A g==;
X-CSE-ConnectionGUID: y6rGX0tcR+CjNsf3i1UllQ==
X-CSE-MsgGUID: yZqVWDolRAyqkoUg3Ieefg==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75761673"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="75761673"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 07:14:29 -0700
X-CSE-ConnectionGUID: sV+2MMx9R0y5Y+VfQTPTOQ==
X-CSE-MsgGUID: f5/xR1hmTw2SOtsmK7FtHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="249123058"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 30 Mar 2026 07:14:27 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org,
	john.mcnamara@intel.com
Cc: Hailin Xu <hailinx.xu@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 6/6] net/i40e: update version matching table
Date: Mon, 30 Mar 2026 15:11:07 +0100
Message-ID: <20260330141415.1267233-7-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260330141415.1267233-1-bruce.richardson@intel.com>
References: <20260327130448.1033651-1-bruce.richardson@intel.com>
 <20260330141415.1267233-1-bruce.richardson@intel.com>
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

From: Hailin Xu <hailinx.xu@intel.com>

Update table with latest versions verified for 26.03 release.

Signed-off-by: Hailin Xu <hailinx.xu@intel.com>
Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/nics/i40e.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/guides/nics/i40e.rst b/doc/guides/nics/i40e.rst
index 2613ca46f6..a38fb27600 100644
--- a/doc/guides/nics/i40e.rst
+++ b/doc/guides/nics/i40e.rst
@@ -102,6 +102,8 @@ are listed in the Tested Platforms section of the Release Notes for each release
    +--------------+-----------------------+------------------+------------------+
    | DPDK version | Kernel driver version | X710* FW version |  X722 FW version |
    +==============+=======================+==================+==================+
+   |    26.03     |         2.28.16       |       9.56       |       6.51       |
+   +--------------+-----------------------+------------------+------------------+
    |    25.11     |         2.28.13       |       9.55       |       6.51       |
    +--------------+-----------------------+------------------+------------------+
    |    24.11     |         2.26.8        |       9.52       |       6.50       |
-- 
2.51.0

