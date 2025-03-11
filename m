Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A28C28B2E
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 10:30:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6376402E6;
	Tue, 11 Mar 2025 11:30:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id C4755402E5;
 Tue, 11 Mar 2025 11:30:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741689030; x=1773225030;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=GQktAtkKps6B4WquT702TaA9ABO0rRtOLK1jdgvPmtk=;
 b=oAXRZGjT84GEaTF20VfJBo3+GtF9nGLtFy/1StVM9Yuajb0mqc9wiVbi
 Klwzev8tjcmdKgVsl4FSzss3aNHkZzokO1cdnzizi3CfC7opLK8PgEZAI
 kKfLej5qYyhK2pWmLtnoXwWNWkd8IUjdiQj2ky2f4olR7E0fOz+U98rvu
 OmIbTEXz3y+BfXm/s/ETP043kBA2+cy8KVdNlVcJtScWa66kUZxuKyFj1
 +zDIOMJo29iZB6pEOjVFMaTujxAdmu12RZOlpcDA13+Zk7OxUA+uYoWmt
 vZiTb/suEVY8Z6CuJU73vceHGAC3BVNY4AEBFsUjorycUdNiampcq3RJL Q==;
X-CSE-ConnectionGUID: c5OPiv6bR/yR89826b7rAw==
X-CSE-MsgGUID: avDCafjrRG259sZ14nmEYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="54102236"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; d="scan'208";a="54102236"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2025 03:30:29 -0700
X-CSE-ConnectionGUID: UAQkWHBuSlSEGqXUMgIvag==
X-CSE-MsgGUID: /jTRAtnaRtCOt/J9en5qxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; d="scan'208";a="121189887"
Received: from silpixa00400465.ir.intel.com ([10.55.129.27])
 by orviesa008.jf.intel.com with ESMTP; 11 Mar 2025 03:30:28 -0700
From: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
To: dev@dpdk.org
Cc: gakhil@marvell.com, brian.dooley@intel.com,
 Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>, stable@dpdk.org
Subject: [PATCH v2] common/qat: fix incorrect size in the parser
Date: Tue, 11 Mar 2025 10:30:24 +0000
Message-ID: <20250311103024.1186285-1-arkadiuszx.kusztal@intel.com>
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

The function `strlen` returns the size of the string without a terminating
null-character, therefore a request to allocate memory space for a parsed
argument is too small by 1.

Fixes: 99ab2806687b ("common/qat: isolate parser arguments configuration")
Cc: stable@dpdk.org

Signed-off-by: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
---
v2:
- changed the placement of `len` incrementation

 drivers/common/qat/qat_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/common/qat/qat_device.c b/drivers/common/qat/qat_device.c
index bca88fd9bd..b582e3bf8b 100644
--- a/drivers/common/qat/qat_device.c
+++ b/drivers/common/qat/qat_device.c
@@ -229,6 +229,7 @@ qat_dev_parse_command_line(struct qat_pci_device *qat_dev,
 	len = strlen(devargs->drv_str);
 	if (len == 0)
 		return 0;
+	++len;
 	/* Allocate per-device command line */
 	qat_dev->command_line = rte_malloc(NULL, len, 0);
 	if (qat_dev->command_line == NULL) {
-- 
2.43.0

