Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296A7C02196
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 09:58:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10861427DC;
	Fri,  7 Feb 2025 10:58:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 8915A427B8;
 Fri,  7 Feb 2025 10:58:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738922322; x=1770458322;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=iKfhYu8SFn8AOLEn4bgacb4p6AVZh3t1J7gZ4abolp0=;
 b=JpNpPBwEHQz2EtiAtbXLeX135+bpmOpbQYmiPGFX4/GODtILwvYV2OOg
 m3XdqwK/5FrzTu44hay/y1Ec0QNBIz47fn/gYKJ4C/ghHip2076yVmMrL
 NL7RHMbM5sxovVe6DlqvDilTfHMF8n9VjN5Err7x0W2b7te9NXAa52tVo
 G9vIN63wmZgxMW+r8RFM3ctjwYm4JmZk9YAs6er4cgHhEBD12bBBOxIgs
 qvLEZPQF9HPDx+nxHR1+1xNQ+7ltjjEjK5s1l5c/WKcZSxKBWqiZ1rnFm
 wfaBYAuQCW3gRFUf/Otfx65W1224wdQhZmZB0qkq8QcSKgGn8hhcX/anL w==;
X-CSE-ConnectionGUID: 3mHi9PKNT4mh4c0ihJzUTA==
X-CSE-MsgGUID: UQSd1+mlR7emjchwDLPwsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39432609"
X-IronPort-AV: E=Sophos;i="6.13,266,1732608000"; d="scan'208";a="39432609"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 01:58:41 -0800
X-CSE-ConnectionGUID: hwWv/oteTWWfm6iomzFDVQ==
X-CSE-MsgGUID: h73kTILqTrKohpHdWrv0vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,266,1732608000"; d="scan'208";a="111447510"
Received: from silpixa00401012.ir.intel.com ([10.243.23.14])
 by orviesa006.jf.intel.com with ESMTP; 07 Feb 2025 01:58:39 -0800
From: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
To: dev@dpdk.org
Cc: gakhil@marvell.com, brian.dooley@intel.com,
 Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>, stable@dpdk.org
Subject: [PATCH] common/qat: fix incorrect size in the parser
Date: Fri,  7 Feb 2025 09:58:32 +0000
Message-Id: <20250207095832.4032332-1-arkadiuszx.kusztal@intel.com>
X-Mailer: git-send-email 2.34.1
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
 drivers/common/qat/qat_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/qat/qat_device.c b/drivers/common/qat/qat_device.c
index bca88fd9bd..746d8a28bb 100644
--- a/drivers/common/qat/qat_device.c
+++ b/drivers/common/qat/qat_device.c
@@ -226,7 +226,7 @@ qat_dev_parse_command_line(struct qat_pci_device *qat_dev,
 	if (!devargs)
 		return 0;
 
-	len = strlen(devargs->drv_str);
+	len = strlen(devargs->drv_str) + 1;
 	if (len == 0)
 		return 0;
 	/* Allocate per-device command line */
-- 
2.34.1

