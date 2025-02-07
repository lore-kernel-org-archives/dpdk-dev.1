Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00123C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 12:47:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8505F42E45;
	Fri,  7 Feb 2025 13:46:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id C02C642E50
 for <dev@dpdk.org>; Fri,  7 Feb 2025 13:46:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738932365; x=1770468365;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ZyGaVKpjEqmMgqV6oFEDBdXuIFdf3WDeCDRHx+cgltk=;
 b=PJKlVd/qSMckSG1Jn+RRa+LQI5hBAQIjhZMtL2jt35S1Q4LZqiayiFbh
 4nPksvyCdrlH0rcXGvT7LFyg3uCkJlHCbtU0v0swSdb4CmBmxj6CGttFe
 2ejVCQJwd3KHGikk76LulB1yxhooZU3Rb/Ww8gulPBjTW3yqRWOwBDaUJ
 YO57wy59MK4pu+yxrzDdlASNaE4+3YFmRBAEwzZ2s3GreHEybfkGkXfv2
 n3XWiDnczaunlvw1Ummt7FcvOIuS4TrmI9QrLPz1GeZ0KkkGO+pQyz2Xk
 rVhFAbudM8eAN7a6a/BpJCxLjUhgMS+A8687tlWLwWA1XoVa57BzmG9Sh A==;
X-CSE-ConnectionGUID: tQEg9kiiSkuQLgH3d2E6DA==
X-CSE-MsgGUID: hMlmtwFARDSW5pQPW62p5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43331756"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="43331756"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 04:46:04 -0800
X-CSE-ConnectionGUID: aBEIFD27ThyKCiz0LfNvzQ==
X-CSE-MsgGUID: QQQQUXu/T3uNgQv1M32dJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111953552"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 07 Feb 2025 04:46:02 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 11/36] net/e1000/base: rename VLAN PQF macros
Date: Fri,  7 Feb 2025 12:45:03 +0000
Message-ID: <a4fc52d58eede6ce7d2a728e051554f0459c3eb4.1738932115.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738932113.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738932113.git.anatoly.burakov@intel.com>
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

From: Sasha Neftin <sasha.neftin@intel.com>

Align VLAN PQF naming convention to base code usage, as well as fix typos.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_defines.h | 6 +++---
 drivers/net/intel/e1000/base/e1000_regs.h    | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_defines.h b/drivers/net/intel/e1000/base/e1000_defines.h
index ea7d70b77e..2037e006c4 100644
--- a/drivers/net/intel/e1000/base/e1000_defines.h
+++ b/drivers/net/intel/e1000/base/e1000_defines.h
@@ -1510,9 +1510,9 @@
 #define E1000_MAX_MAC_HDR_LEN	127
 #define E1000_MAX_NETWORK_HDR_LEN	511
 
-#define E1000_VLAPQF_QUEUE_SEL(_n, q_idx) ((q_idx) << ((_n) * 4))
-#define E1000_VLAPQF_P_VALID(_n)	(0x1 << (3 + (_n) * 4))
-#define E1000_VLAPQF_QUEUE_MASK	0x03
+#define E1000_VLANPQF_QSEL(_n, q_idx)	((q_idx) << ((_n) * 4))
+#define E1000_VLANPQF_VALID(_n)		(0x1 << (3 + (_n) * 4))
+#define E1000_VLANPQF_QUEUE_MASK	0x03
 #define E1000_VFTA_BLOCK_SIZE	8
 /* SerDes Control */
 #define E1000_GEN_CTL_READY		0x80000000
diff --git a/drivers/net/intel/e1000/base/e1000_regs.h b/drivers/net/intel/e1000/base/e1000_regs.h
index 3af356be77..ad091d1734 100644
--- a/drivers/net/intel/e1000/base/e1000_regs.h
+++ b/drivers/net/intel/e1000/base/e1000_regs.h
@@ -273,7 +273,7 @@
 				 (0x054E0 + ((_i - 16) * 8)))
 #define E1000_RAH(_i)		(((_i) <= 15) ? (0x05404 + ((_i) * 8)) : \
 				 (0x054E4 + ((_i - 16) * 8)))
-#define E1000_VLAPQF		0x055B0  /* VLAN Priority Queue Filter VLAPQF */
+#define E1000_VLANPQF		0x055B0  /* VLAN Priority Queue Filter VLANPQF */
 
 #define E1000_SHRAL(_i)		(0x05438 + ((_i) * 8))
 #define E1000_SHRAH(_i)		(0x0543C + ((_i) * 8))
-- 
2.43.5

