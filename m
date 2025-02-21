Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E327C021B2
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 01:11:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D217D40A82;
	Fri, 21 Feb 2025 02:11:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 81BEC40A70
 for <dev@dpdk.org>; Fri, 21 Feb 2025 02:11:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740100298; x=1771636298;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=S34oJ5L5g+n0ftom53gb46K+sdeCmsAvu8h+i7hp5uQ=;
 b=ZuiKkmTQoceHh3LDu7z/5mbA/NMnD2lIz4o+KFgduDbNnkxcaMaGYm10
 dab3PCO22Brg21sLuhHsxqa20OxkhcWeVI6URR+DSM3DRB1+BJhY7I05E
 c9HkMFVpEAnZ7AFLIZG8Tmghz4Fd9hrxxw3OUklIa0esxrXQVp0nW4+A9
 KxZroOzOkorLMr9gnBQF4HMexIwUQHko4oN9MNkGJNq4PNN8OPXqMNdcp
 LhjQVX6nwAfs3LxQTxAJ/NWZEfCx7bu7GUmu7tYplQ+5e4zSofruMez8y
 HcA8HZIuk3IqJlpxTyGunya4Sp+qvM0v+YYCWte2WH1v/pXO8/ROaz5ej Q==;
X-CSE-ConnectionGUID: PpvFUF+dQx2xyiEF95uSsA==
X-CSE-MsgGUID: aiesnY6XQUGRxgJLZX3Jxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="51898000"
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; d="scan'208";a="51898000"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 17:11:36 -0800
X-CSE-ConnectionGUID: 0yeiMILOSgKFJX5vOYsnYQ==
X-CSE-MsgGUID: o9QnDGJmTDKb4WALSafCbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116114192"
Received: from dpdk-rosen-vc01.sh.altera.com (HELO rdma1..) ([10.220.4.210])
 by orviesa008.jf.intel.com with ESMTP; 20 Feb 2025 17:11:32 -0800
From: Rosen Xu <rosen.xu@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com, ferruh.yigit@amd.com,
 rosen.xu@intel.com, rosen.xu@altera.com
Subject: [PATCH 3/3] maintainers: update for Intel FPGA rawdev drivers
Date: Fri, 21 Feb 2025 00:45:28 +0000
Message-ID: <20250221004528.6999-3-rosen.xu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250221004528.6999-1-rosen.xu@intel.com>
References: <20250221004528.6999-1-rosen.xu@intel.com>
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

Change of maintainers' email for Intel FPGA rawdev drivers

Signed-off-by: Rosen Xu <rosen.xu@intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 979e8ffb07..82f6e2f917 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1540,7 +1540,7 @@ Rawdev Drivers
 --------------
 
 Intel FPGA
-M: Rosen Xu <rosen.xu@intel.com>
+M: Rosen Xu <rosen.xu@altera.com>
 T: git://dpdk.org/next/dpdk-next-net-intel
 F: drivers/raw/ifpga/
 F: doc/guides/rawdevs/ifpga.rst
-- 
2.43.0

