Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D593CAC599
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 14:22:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40DA2406BC;
	Tue, 16 Sep 2025 16:21:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id E979B402D1;
 Tue, 16 Sep 2025 16:21:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758032484; x=1789568484;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eKJ4dbsuKbzNsYYO7dn3bMyowcWmZKeymj/ait+OZYs=;
 b=SvReq3ZWVbZonjaqGoZBUKOgnkMD+V51hCNnOYFL5ufy4TiTM+k7urU+
 gYVjyqMSk5mlNKmX1gNfKOzj0AjImJ2iyBvwfKuRX3TGNx9qzPHRHYRIF
 H4GBXTr+DUqE1cwmTodvou0ShR0ypmtH/iq2DBrH3fYw8vhSgja7fm3cv
 VZ09fJdlC4gtuGaoHRGpGlQAbDSaQlFFv3iuaTAE4RyS427aJe26XMA++
 Rhc9oDaMrNnvpJifvBixYtjwPHMqyqrNLr9FYJ7RYYXsp4W77bi+ZCNDL
 rIFQaRFM6PpMblAYcCqBhG7/k7P4pABhP4UcUfo8cY8NufrCFEd41k2Dr A==;
X-CSE-ConnectionGUID: YXPN6Ej1Qcq9kkQJhICi/Q==
X-CSE-MsgGUID: fuZRuJaKSpGLumk2DW08PA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71681340"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; d="scan'208";a="71681340"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 07:21:23 -0700
X-CSE-ConnectionGUID: qlctk/pQTH254KdN8cCQNQ==
X-CSE-MsgGUID: OilKCHTdQkS60EMNUTgCkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; d="scan'208";a="212115230"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa001.jf.intel.com with ESMTP; 16 Sep 2025 07:21:23 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 6/8] net/iavf: document support for burst mode info
Date: Tue, 16 Sep 2025 14:21:11 +0000
Message-Id: <20250916142113.3485738-7-ciara.loftus@intel.com>
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

The burst mode info feature has been supported since commit 0d5a856f5be9
("net/iavf: support Rx/Tx burst mode info"). Update the list of
supported features to reflect this.

Fixes: 0d5a856f5be9 ("net/iavf: support Rx/Tx burst mode info")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 doc/guides/nics/features/iavf.ini | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/guides/nics/features/iavf.ini b/doc/guides/nics/features/iavf.ini
index 4e4c5cc817..7420432840 100644
--- a/doc/guides/nics/features/iavf.ini
+++ b/doc/guides/nics/features/iavf.ini
@@ -14,6 +14,7 @@ Free Tx mbuf on demand = Y
 Queue start/stop     = Y
 Runtime Rx queue setup = Y
 Runtime Tx queue setup = Y
+Burst mode info      = Y
 Power mgmt address monitor = Y
 MTU update           = Y
 Scattered Rx         = Y
-- 
2.34.1

