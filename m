Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2AEC7115C
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 13:30:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 567E042EFC;
	Fri, 20 Jun 2025 15:30:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 153E6402F2
 for <dev@dpdk.org>; Fri, 20 Jun 2025 15:30:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750426228; x=1781962228;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=50PMQaZgo/e1VpFjohFgMvHGb7Usp0QN/I5God/EAPk=;
 b=RVlLqp+IvOD4Gaz0E9Qa+/5sFU7BDsjYrUPeFVm2meSc+H8hrHGQNRls
 hKieC/bNSRmGN5kYwejBEifj7creEWcZ+BAfCFfD0PnV3aXXlGB6vpCCQ
 z/1XJ9KyLlOW4FpMs9KZOMnWyA4225xMyg1neEmCATjEV39v/5+j+qMqP
 I/e6n2Qm14SfzWSFzDZ4JbGoByXUTqJPcgilRZ0pUpEyMy58CZBvYuvCM
 ZGIWWsMwQiFzqqutPFxsUPIdz90NyVMLR1cH01YRdrkNWkGE+hZbCVJMT
 e2fXRbXmSD3q+E9w85Eo202LSUFmlwUd0GXPyFM28pMgu/onzLoA97Qrp w==;
X-CSE-ConnectionGUID: n0ast45hTY+9hJli0wnrGQ==
X-CSE-MsgGUID: OpHu+W71SVm0b149h/tygw==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="75219019"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="75219019"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 06:30:26 -0700
X-CSE-ConnectionGUID: gAdcE3mBQwy0KDFmCjz6GQ==
X-CSE-MsgGUID: LzrlwbPgQcGQ1GYAmP69NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="150407256"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa006.jf.intel.com with ESMTP; 20 Jun 2025 06:30:25 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 1/1] memory: handle invalid socket ID's when allocating
Date: Fri, 20 Jun 2025 14:30:23 +0100
Message-ID: <4e785f17154922f775c56558947b2f967f25b23c.1750426216.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
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

This issue was reported by static analysis. It is a false positive,
because both `rte_socket_count` and `rte_socket_id_by_idx` only report
information about physical sockets, and these specific calls are made
during EAL initialization, so no other sockets (i.e. external) could have
been available, so it is pretty much impossible to get invalid return here.

Still, to avoid future false positives, we can fix it here.

Coverity issue: 470131

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/linux/eal_memory.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index 59f35b415e..e433c1afee 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -1785,8 +1785,14 @@ memseg_primary_init_32(void)
 		unsigned int main_lcore_socket;
 		struct rte_config *cfg = rte_eal_get_configuration();
 		bool skip;
+		int ret;
 
-		socket_id = rte_socket_id_by_idx(i);
+		ret = rte_socket_id_by_idx(i);
+		if (ret == -1) {
+			EAL_LOG(ERR, "Cannot get socket ID for socket index %u", i);
+			return -1;
+		}
+		socket_id = (unsigned int)ret;
 
 #ifndef RTE_EAL_NUMA_AWARE_HUGEPAGES
 		/* we can still sort pages by socket in legacy mode */
-- 
2.47.1

