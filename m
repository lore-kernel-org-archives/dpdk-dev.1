Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F523C02196
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:13:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26DBB4279B;
	Tue,  4 Feb 2025 16:11:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 40FFB41133
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:11:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681903; x=1770217903;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PbCixjzFDnAGOclQKTRVBbdTIDPOqLJoHTGGiaVhokc=;
 b=S3scoXJXh3+VKN7ssy93ZehBqpbWqFTxShkaRAh6rnHHktKd2+Y7N9qy
 wQp55zSXFVlptKxZeCEai2mg5kc+q/jdXhHhUomhDi1aCx3ch9DLHrL21
 jCAgYSo8bH5yZ8CC1MNpMaIkE3bhfwfDEYAc//fVdozaJ2jdrjQVhXsM7
 kualR91KyCXRa2it0wgHdqG2CtKyP6sekwkp7wIxXrAkc7O+doy6nzgDy
 1gypwelj7XFFP5EbeObrsyntMlZh7Cg0Lv/SQydOwM67nsYkTi9Gn6nhW
 r3Z9ybQh566DO24muJvQJdQfJFPd5VgQpdnh0sTPdLXpKPTq8VgSbgyTe w==;
X-CSE-ConnectionGUID: l/g425fjSSij9jy/K/1XGg==
X-CSE-MsgGUID: zSgBxVihQImXv4Qg/5/H+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097108"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097108"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:11:42 -0800
X-CSE-ConnectionGUID: yR1saxBHRl2Bbu/r3456kA==
X-CSE-MsgGUID: 49yT1Cp9SxmbYdgk7COoVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792600"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:11:41 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 11/54] net/e1000/base: rename VLAN PQF macros
Date: Tue,  4 Feb 2025 15:10:17 +0000
Message-ID: <3b6537067292325f5a470d85ca9d23b0c3905851.1738681726.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738681725.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738681725.git.anatoly.burakov@intel.com>
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
index 3d3bc3f6dc..b1e616781e 100644
--- a/drivers/net/intel/e1000/base/e1000_defines.h
+++ b/drivers/net/intel/e1000/base/e1000_defines.h
@@ -1509,9 +1509,9 @@
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

