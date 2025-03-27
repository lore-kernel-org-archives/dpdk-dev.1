Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC816C3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 14:52:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F81E40E41;
	Thu, 27 Mar 2025 15:52:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 7BBBC40E26;
 Thu, 27 Mar 2025 15:52:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743087138; x=1774623138;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0tFhfciWvwoyFiDHFtOyKO0CNmgPvuFXoXtuBgq9nVI=;
 b=nvop/1Lt3GgLKBZzz9GLmwDIe8KiRUm2StfHXBbwbq7zsnAriZ+cufE2
 zAoFdQ6G+67exS5dA5/Z51eGIu979z190XIAly+2IFaR71DOE7lKujtca
 vEdzCWOmzq9Z9oM7785/dAluCowz4p1o5AGetnJI8wuLp7UYwQdW9u+40
 gpmajeAhH2mais36SVDeWDpwK226ItgFemhEuE3x8BJupl5zxAMH7kP1Q
 C6Z9JCC5UTCmz1R3kG+PDDrOt5a1772KxcZn3pnM5aVyvv01hrpbByemu
 LebTzaKx9+piMJJIVGwhyCxN8JRYOakkIef9Fw9prVRf/vk8rj4QTdieM g==;
X-CSE-ConnectionGUID: HT676jBMTti2ewE1EiSdMg==
X-CSE-MsgGUID: R7eSDZBqQCuS/frIi9vqxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="48207067"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="48207067"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 07:52:17 -0700
X-CSE-ConnectionGUID: ZwrWBOKkQomM0uHNIQMtxg==
X-CSE-MsgGUID: qaSe4WiRRcG/bFvtrTDtZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="162400017"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa001.jf.intel.com with ESMTP; 27 Mar 2025 07:52:16 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 3/9] net/ixgbe/base: correct definition of macro
Date: Thu, 27 Mar 2025 14:51:55 +0000
Message-ID: <20250327145202.2220153-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250327145202.2220153-1-bruce.richardson@intel.com>
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
 <20250327145202.2220153-1-bruce.richardson@intel.com>
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

The definition of IXGBE_LE32_TO_CPUS macro is meant to modify the value
in place - similar to the le32_to_cpus() macro in kernel. Fixing the
definition allows us to remove some warning flags, and removes the need
for the uintptr_t typecasts.

Fixes: aa4fc14d2cee ("ixgbe: update base driver")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ixgbe/base/ixgbe_common.c | 4 ++--
 drivers/net/intel/ixgbe/base/ixgbe_osdep.h  | 2 +-
 drivers/net/intel/ixgbe/base/meson.build    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/ixgbe/base/ixgbe_common.c b/drivers/net/intel/ixgbe/base/ixgbe_common.c
index d6425c5b78..fbc9605e4d 100644
--- a/drivers/net/intel/ixgbe/base/ixgbe_common.c
+++ b/drivers/net/intel/ixgbe/base/ixgbe_common.c
@@ -4610,7 +4610,7 @@ s32 ixgbe_host_interface_command(struct ixgbe_hw *hw, u32 *buffer,
 	/* first pull in the header so we know the buffer length */
 	for (bi = 0; bi < dword_len; bi++) {
 		buffer[bi] = IXGBE_READ_REG_ARRAY(hw, IXGBE_FLEX_MNG, bi);
-		IXGBE_LE32_TO_CPUS((uintptr_t)&buffer[bi]);
+		IXGBE_LE32_TO_CPUS(&buffer[bi]);
 	}
 
 	/*
@@ -4646,7 +4646,7 @@ s32 ixgbe_host_interface_command(struct ixgbe_hw *hw, u32 *buffer,
 	/* Pull in the rest of the buffer (bi is where we left off) */
 	for (; bi <= dword_len; bi++) {
 		buffer[bi] = IXGBE_READ_REG_ARRAY(hw, IXGBE_FLEX_MNG, bi);
-		IXGBE_LE32_TO_CPUS((uintptr_t)&buffer[bi]);
+		IXGBE_LE32_TO_CPUS(&buffer[bi]);
 	}
 
 rel_out:
diff --git a/drivers/net/intel/ixgbe/base/ixgbe_osdep.h b/drivers/net/intel/ixgbe/base/ixgbe_osdep.h
index cffc6a4ce8..6e5f7b4ae8 100644
--- a/drivers/net/intel/ixgbe/base/ixgbe_osdep.h
+++ b/drivers/net/intel/ixgbe/base/ixgbe_osdep.h
@@ -83,7 +83,7 @@ enum {
 #define IXGBE_LE16_TO_CPU(_i)  rte_le_to_cpu_16(_i)
 #define IXGBE_LE32_TO_CPU(_i)  rte_le_to_cpu_32(_i)
 #define IXGBE_LE64_TO_CPU(_i)  rte_le_to_cpu_64(_i)
-#define IXGBE_LE32_TO_CPUS(_i) rte_le_to_cpu_32(_i)
+#define IXGBE_LE32_TO_CPUS(_i) do { *_i = rte_le_to_cpu_32(*_i); } while(0)
 #define IXGBE_CPU_TO_BE16(_i)  rte_cpu_to_be_16(_i)
 #define IXGBE_CPU_TO_BE32(_i)  rte_cpu_to_be_32(_i)
 #define IXGBE_BE32_TO_CPU(_i)  rte_be_to_cpu_32(_i)
diff --git a/drivers/net/intel/ixgbe/base/meson.build b/drivers/net/intel/ixgbe/base/meson.build
index 7e4fbdfa0f..f8b2ee6341 100644
--- a/drivers/net/intel/ixgbe/base/meson.build
+++ b/drivers/net/intel/ixgbe/base/meson.build
@@ -19,7 +19,7 @@ sources = [
         'ixgbe_x550.c',
 ]
 
-error_cflags = ['-Wno-unused-value',
+error_cflags = [
         '-Wno-unused-but-set-variable',
         '-Wno-unused-parameter',
         ]
-- 
2.45.2

