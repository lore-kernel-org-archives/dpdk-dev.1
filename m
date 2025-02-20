Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDEDC021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 08:54:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEDE34014F;
	Thu, 20 Feb 2025 09:54:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id B158840041
 for <dev@dpdk.org>; Thu, 20 Feb 2025 09:54:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740041688; x=1771577688;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4kdOfsG34eSkI/BqQ4KyPqHuFYnJmDn5BrZjLDZdK/g=;
 b=nupubsTAutvURhfiA43Y63J3AQbbypURknA+tzYt0vvuPKnyT0tjqelb
 goDnvNvB+oOp29C8/6MgGuzko/2baT3WLF46TmLXpt8cTsMDpDLhZ7h6u
 w9xlms0GskflQ8LyqLSayvBtCPRQHZw173kH9p794RENH1wSEOt1YdLD5
 HaAfNBUVy4wp3se5Uil+b2JND0cxPs7Ln+yqOmYklOvhfjnc5V4YJLI4J
 S0INPtsE4S+74XqDLU7RvYlEEYzkqdwAM5K6jfCwyiRdg+naIkZOn8z6c
 Mak2q20AfKvy0MmqIh2J+YtuQmg3iPGbqrkONSDTnShS8ZOCuWWrEibv4 g==;
X-CSE-ConnectionGUID: ckCrMn/jTJWVsz/506rMrw==
X-CSE-MsgGUID: +efV9djfR0GBzUX++tTtUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="51429020"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; d="scan'208";a="51429020"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 00:54:47 -0800
X-CSE-ConnectionGUID: vJ6NL4T4RzmW/idDQNio6A==
X-CSE-MsgGUID: qlhxHOabTqqCAuN0ZJLySw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; d="scan'208";a="145830403"
Received: from dpdk-rosen-vc01.sh.altera.com (HELO rdma1..) ([10.220.4.210])
 by orviesa002.jf.intel.com with ESMTP; 20 Feb 2025 00:54:43 -0800
From: Rosen Xu <rosen.xu@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com, ferruh.yigit@amd.com,
 rosen.xu@intel.com, rosen.xu@altera.com
Subject: [PATCH] maintainers: update for Intel FPGA bus drivers
Date: Thu, 20 Feb 2025 08:28:57 +0000
Message-ID: <20250220082857.2981-1-rosen.xu@intel.com>
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

Change of maintainers' email for Intel FPGA bus drivers.

Signed-off-by: Rosen Xu <rosen.xu@intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 312e6fcee5..3128734a61 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -621,7 +621,7 @@ M: Xueming Li <xuemingl@nvidia.com>
 F: drivers/bus/auxiliary/
 
 Intel FPGA bus
-M: Rosen Xu <rosen.xu@intel.com>
+M: Rosen Xu <rosen.xu@altera.com>
 F: drivers/bus/ifpga/
 
 NXP buses
-- 
2.43.0

