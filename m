Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4526DC021B2
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 01:11:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84B5040668;
	Fri, 21 Feb 2025 02:11:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 0CD1F40665
 for <dev@dpdk.org>; Fri, 21 Feb 2025 02:11:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740100290; x=1771636290;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qe+4rZGLwpoEModftzesdnSE+KOiKKZ6jvYA+tqdUFo=;
 b=PeQxdggXjLfYFpqhs7oco4MRC4F3pqEitbQN3DbtjkLpdbfZYAonyrqE
 XkyyHXff73kaeDAO7matm0q62eNr6Qk4Yg5gML/qC2DdCsAgVn6ONRkYL
 juTfhVzXl8PCsKCE5cSKUuNoL4CNuCUBqoqfswNlNlsLc+KvoRJOHHDeP
 gLzKcOTxi7U9BjYcVQz9CXbhPfNbRQoLI3trj2skzPm3MqUclatwfCvbt
 CpXh01ZjGuUatdOoU5+EQv8lajz3tspXDEXV0M3mnvo5SMAQZHaxgawP5
 DegsuaTeIv3bWFNvaaTaC3AXFD795U5wX5mZjStrsuujRK8PxifjNroR+ w==;
X-CSE-ConnectionGUID: 6bJ/eUIPQvWPm5Kzfhwx7g==
X-CSE-MsgGUID: mJ3LBAgET06sRJnWuN1d3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="51897986"
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; d="scan'208";a="51897986"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 17:11:29 -0800
X-CSE-ConnectionGUID: AyNYjUi2SSuGcJCsT6bjCA==
X-CSE-MsgGUID: iT7jj96JSKmhhDRUZrHLQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116114182"
Received: from dpdk-rosen-vc01.sh.altera.com (HELO rdma1..) ([10.220.4.210])
 by orviesa008.jf.intel.com with ESMTP; 20 Feb 2025 17:11:28 -0800
From: Rosen Xu <rosen.xu@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com, ferruh.yigit@amd.com,
 rosen.xu@intel.com, rosen.xu@altera.com
Subject: [PATCH 2/3] maintainers: update for Intel FPGA bus drivers
Date: Fri, 21 Feb 2025 00:45:27 +0000
Message-ID: <20250221004528.6999-2-rosen.xu@intel.com>
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

Change of maintainers' email for Intel FPGA bus drivers.

Signed-off-by: Rosen Xu <rosen.xu@intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fc65715d39..979e8ffb07 100644
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

