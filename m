Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714CDC021B3
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 01:11:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5081B402A8;
	Fri, 21 Feb 2025 02:11:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id AC42F4026D
 for <dev@dpdk.org>; Fri, 21 Feb 2025 02:11:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740100287; x=1771636287;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Sm93ruW5I7K32c5mCuElWuSD2H38/6LU2IGr34hAxJo=;
 b=aXzgzvLfBn6dzeFR3j1+0iT4bwotw3xOgi3HEYQfp0NfY6yWyCwudivz
 sn2mlT76pepKs0bZzi6JNsNtv5/wxgFP6RqchPv7GZ1XTd+9XF6pZ8Ww9
 /UdgTSouzK35ivnwM0qtjhQF9dJMhyJIr5cwaR+X0wSofuk4BqMYYB76h
 wmBdpIXYtNlDZpWp513MDoFbi89hZibKP4+qw4mK1jYqgsndPeKx0gH1U
 KIc6ilq7NPCMWzD0GwLPMb2N3emYJczD8ytyqbyle6zfyJMPBMFK9byCS
 gUZpMriZlVgyYpIUul5gxkRfvkA9Gbh4sJ+FDJncu4POXWXlTi3porCOD g==;
X-CSE-ConnectionGUID: +5VtRWV1RmioCZ4GT/eDHQ==
X-CSE-MsgGUID: IOrperRxSoyztrR7De8wug==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="51897979"
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; d="scan'208";a="51897979"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 17:11:25 -0800
X-CSE-ConnectionGUID: FpZn1x65T/ehf1o3ZBzlag==
X-CSE-MsgGUID: ghnwymOvQMWCzsSkS5+7Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116114178"
Received: from dpdk-rosen-vc01.sh.altera.com (HELO rdma1..) ([10.220.4.210])
 by orviesa008.jf.intel.com with ESMTP; 20 Feb 2025 17:11:20 -0800
From: Rosen Xu <rosen.xu@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com, ferruh.yigit@amd.com,
 rosen.xu@intel.com, rosen.xu@altera.com
Subject: [PATCH 1/3] maintainers: update for Intel ipn3ke drivers
Date: Fri, 21 Feb 2025 00:45:26 +0000
Message-ID: <20250221004528.6999-1-rosen.xu@intel.com>
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

Change of maintainers' email for Intel ipn3ke drivers.

Signed-off-by: Rosen Xu <rosen.xu@intel.com>
---
 .mailmap    | 2 +-
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index a03d3cfb59..59933f9bc3 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1325,7 +1325,7 @@ Rong Qian <qianr@yunsilicon.com>
 RongQing Li <lirongqing@baidu.com>
 Rongwei Liu <rongweil@nvidia.com>
 Rory Sexton <rory.sexton@intel.com>
-Rosen Xu <rosen.xu@intel.com>
+Rosen Xu <rosen.xu@altera.com> <rosen.xu@intel.com>
 Roy Franz <roy.franz@cavium.com>
 Roy Pledge <roy.pledge@nxp.com>
 Roy Shterman <roy.shterman@vastdata.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 312e6fcee5..fc65715d39 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -847,7 +847,7 @@ F: doc/guides/nics/cpfl.rst
 F: doc/guides/nics/features/cpfl.ini
 
 Intel ipn3ke
-M: Rosen Xu <rosen.xu@intel.com>
+M: Rosen Xu <rosen.xu@altera.com>
 T: git://dpdk.org/next/dpdk-next-net-intel
 F: drivers/net/intel/ipn3ke/
 F: doc/guides/nics/ipn3ke.rst
-- 
2.43.0

