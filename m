Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94EDCD98F2
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 16:53:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB5CF40656;
	Tue, 23 Jun 2026 18:52:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 9311640670;
 Tue, 23 Jun 2026 18:52:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782233541; x=1813769541;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QhI2BlXlBY0H59W2UYaIbCOhA5lAMgguS2kho6jTiwY=;
 b=bvezGEiLoYgfDq2P7ZDJl/o6Y/bAeUem84SBknT86eIgo+FcTd39yRs8
 cELU3R09rjEo5ucNG4X0G7KzKr4msMKt9gPZglYYUHQiZRxqKFhX5/RDi
 7olQmgx6KyeSgrZQTap+uyoDCZcoS4AdiFZthVd9/Di+etDBtHfBHRYwQ
 wmiW6JeESw6CK4b/njnhg0L3FPGH2QDMG05/jx8D/dGlcD8ysl39EYdL8
 PvzgsMZ60vtig6tnGvBH4pwjbrBvrPK5F/C9B/CkenC81wXyTkkGvaA/k
 ES4BfAJWvIbi93oDFx7CiWTzs+UPMJDOJvkzc4uZfQm5mvRiqSyzj+fJL w==;
X-CSE-ConnectionGUID: QCnMWNAbQnizmJmUUPpVjg==
X-CSE-MsgGUID: fKEFpiYjSm66AV/1VlaqBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100534677"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="100534677"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 09:52:20 -0700
X-CSE-ConnectionGUID: K2kFGImeQ+mZslBfI8j56g==
X-CSE-MsgGUID: syEp58FGRp+f+JrEh+/45A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="253928379"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 23 Jun 2026 09:52:19 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>, Harish Patil <harish.patil@cavium.com>
Subject: [PATCH 14/17] net/qede: replace strncpy with strlcpy
Date: Tue, 23 Jun 2026 17:51:44 +0100
Message-ID: <20260623165150.765443-15-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623165150.765443-1-bruce.richardson@intel.com>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
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

Replace strncpy() with safer strlcpy() which always null-terminates.

Fixes: 7eca78cefde8 ("net/qede: fix driver version string")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/qede/qede_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/qede/qede_ethdev.c b/drivers/net/qede/qede_ethdev.c
index 4efc2dd349..2f37f956cb 100644
--- a/drivers/net/qede/qede_ethdev.c
+++ b/drivers/net/qede/qede_ethdev.c
@@ -2596,7 +2596,7 @@ static int qede_common_dev_init(struct rte_eth_dev *eth_dev, bool is_vf)
 	params.drv_minor = QEDE_PMD_VERSION_MINOR;
 	params.drv_rev = QEDE_PMD_VERSION_REVISION;
 	params.drv_eng = QEDE_PMD_VERSION_PATCH;
-	strncpy((char *)params.name, QEDE_PMD_VER_PREFIX,
+	strlcpy((char *)params.name, QEDE_PMD_VER_PREFIX,
 		QEDE_PMD_DRV_VER_STR_SIZE);
 
 	qede_assign_rxtx_handlers(eth_dev, true);
-- 
2.53.0

