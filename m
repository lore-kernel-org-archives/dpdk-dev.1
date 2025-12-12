Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC790D4417D
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 11:07:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F068F40ECF;
	Fri, 12 Dec 2025 12:06:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id EA1FC40E41;
 Fri, 12 Dec 2025 12:06:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765537607; x=1797073607;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7G3JqIt2UeSME5dzKdtzRDfTjdadb58AsLoIRcr0flk=;
 b=GQ09r236IrCatatqy3R5cd4a1ahO4TYaCMczSXAwgRmtx4akR1KcEDKk
 hrr2fu1NTDnHZHZoD9h9k3qgam53PFDLma7Ugbh8qn6Y9DxO8+xXKvvKn
 K3ScaxVHrak05Lc9X1Z2PfYDxdZARRrHNg8s8eiLZLjsIIQmH4RL1nKU3
 Qa2UiHX+7RgpQpSXEsEg3mLc+Xhtw0nMq+Bkt9L+W9Qn2VYw6WRw51PWh
 R70JQIeyjwj1CuQ1GfbtLYusI7vR+4d40fk69Hp5LI3/j2V33r7wSQBxy
 /iXYxaizA3RB97z0C0+gVBgH14qJWElDBY2ApjpFJfcHpJjyGhocDiVbg Q==;
X-CSE-ConnectionGUID: 5M5u57iSRx6HSAF81KkCmA==
X-CSE-MsgGUID: q7e46VDeTMiiIIl8C4Y+Mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67472087"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; d="scan'208";a="67472087"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2025 03:06:46 -0800
X-CSE-ConnectionGUID: xw82xTTJTdyqrFQQif2TuA==
X-CSE-MsgGUID: LlKcjGhUQhmSN3yiUB/Wcg==
X-ExtLoop1: 1
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa003.fm.intel.com with ESMTP; 12 Dec 2025 03:06:45 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 10/10] docs: fix TSO feature status in i40e driver
 documentation
Date: Fri, 12 Dec 2025 11:06:28 +0000
Message-ID: <20251212110628.1634703-11-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251212110628.1634703-1-ciara.loftus@intel.com>
References: <20251212103323.1481307-1-ciara.loftus@intel.com>
 <20251212110628.1634703-1-ciara.loftus@intel.com>
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

TSO is only supported on the scalar path so change the status to
partially supported.

Fixes: 9ed94e5bb04e ("i40e: add vector Rx")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/nics/features/i40e.ini | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/nics/features/i40e.ini b/doc/guides/nics/features/i40e.ini
index 4610444ace..fb00b69830 100644
--- a/doc/guides/nics/features/i40e.ini
+++ b/doc/guides/nics/features/i40e.ini
@@ -16,7 +16,7 @@ Runtime Tx queue setup = Y
 Burst mode info      = Y
 Power mgmt address monitor = Y
 Scattered Rx         = Y
-TSO                  = Y
+TSO                  = P
 Promiscuous mode     = Y
 Allmulticast mode    = Y
 Unicast MAC filter   = Y
-- 
2.43.0

