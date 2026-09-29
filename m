Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767F6CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:16:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B422942D27;
	Tue, 29 Sep 2026 16:16:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id A002642D27
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:16:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790691365; x=1822227365;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=cU/IAPvmjYn2ZR7mJaANXMggSXEeNMwHc7n6eqlBn18=;
 b=iJ90aGYQbQfD82J5NxsDHaNXpqqAW88LmbNVkApTWaFPSIIWzo81Jc9s
 WDnx/KyXjWbSpdfE7m3Qm5TTfJb0iYWlQYRoIainj+F/RerEnoPzidt7G
 cnIcnKk0MzpExs0k3GmKnWHlkZvDqWudcyoDY+KmxdemVt1tCUBEvqNNM
 QYh9kfE6Xjcmre8Be+yyfKC8tB5kqMbM6ExyiCzIulLeowmtihOscG4/B
 rvz8MeR58//waocUasYTKH4b7vPDHMlEgHnb8DMModNUEVgkcPAYQyoWb
 dao3qS1yCA+POy2+j9D9C/pVSp9eEIaKCAGTWiiXEH7ThZ8ClPCnelfQr Q==;
X-CSE-ConnectionGUID: 1gLnCxuJQqycX0VP2f3bOw==
X-CSE-MsgGUID: W26I7ii5RB6P3sa/IXskiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="101936277"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="101936277"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 07:16:04 -0700
X-CSE-ConnectionGUID: HOrhLfr1RpGwuYTa42B+cQ==
X-CSE-MsgGUID: 7NX5y+cfTqKm97oPgIYXgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="304882077"
Received: from silpixa00401842.ir.intel.com ([10.20.225.198])
 by orviesa002.jf.intel.com with ESMTP; 29 Sep 2026 07:16:03 -0700
From: Pablo de Lara <pablo.de.lara.guarch@intel.com>
To: thomas@monjalon.net,
	kai.ji@intel.com
Cc: dev@dpdk.org,
	Pablo de Lara <pablo.de.lara.guarch@intel.com>
Subject: [PATCH] maintainers: update for IPSEC MB and ISA-L drivers
Date: Tue, 29 Sep 2026 14:15:55 +0000
Message-ID: <20260929141600.3867376-1-pablo.de.lara.guarch@intel.com>
X-Mailer: git-send-email 2.43.0
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

Remove myself from IPSEC MB and ISA-L PMD maintainership,
as I will no longer be working at Intel or directly with DPDK.

Signed-off-by: Pablo de Lara <pablo.de.lara.guarch@intel.com>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 186cc82b39..1ae0ffaf18 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1223,7 +1223,6 @@ F: doc/guides/cryptodevs/features/qat.ini
 
 IPsec MB
 M: Kai Ji <kai.ji@intel.com>
-M: Pablo de Lara <pablo.de.lara.guarch@intel.com>
 F: drivers/crypto/ipsec_mb/
 F: doc/guides/cryptodevs/aesni_gcm.rst
 F: doc/guides/cryptodevs/aesni_mb.rst
@@ -1334,7 +1333,6 @@ F: drivers/compress/qat/
 F: drivers/common/qat/
 
 ISA-L
-M: Pablo de Lara <pablo.de.lara.guarch@intel.com>
 F: drivers/compress/isal/
 F: doc/guides/compressdevs/isal.rst
 F: doc/guides/compressdevs/features/isal.ini
-- 
2.43.0

