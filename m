Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12126C28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 11:16:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7009040665;
	Fri, 28 Mar 2025 12:16:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id CA4414065C;
 Fri, 28 Mar 2025 12:16:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743160594; x=1774696594;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0tFhfciWvwoyFiDHFtOyKO0CNmgPvuFXoXtuBgq9nVI=;
 b=A6KOXHTu+Od4PmKN9JI1y6dUJk6whFBvftFPdSCFUJ0NUOgAl7VcmEH4
 ejPblzC6LsFTsz/DsGNgnwU2IvUdcRPSZu/OYSu8MG3ulXyicc3SV0TXY
 iP9UUjmE2rD2z7W2+ho4tEsP+IovKCuGLUY/00Dq1Do4vSc1XNTkfGDK3
 yOcmDwU76Gkx8PaiNK0zRMjg40Tz26jP+TxnA/pUDVGiMM98uYKJuktov
 LibFzJkYBODaIONCUCXQnPfKBfRYghCdHzS06J1H69hqDaEGo1AC7dlVt
 vocSfmJ3L4Pp1wjChn/j5JVPCylvrEAcIiyHWKLOOM7ILVJh5r3qHH2C0 w==;
X-CSE-ConnectionGUID: i2YIeZqCSJ+MxMRlZxCI7A==
X-CSE-MsgGUID: nOTDPA5uSfevoccxL1pA7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44435465"
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="44435465"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 04:16:34 -0700
X-CSE-ConnectionGUID: 2tGj+KHeQpe0gV+WfsdtZw==
X-CSE-MsgGUID: f5Yim+/uRPa1yawrn99LNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="125423289"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa006.jf.intel.com with ESMTP; 28 Mar 2025 04:16:31 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: David Marchand <david.marchand@redhat.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org
Subject: [PATCH v4 3/9] net/ixgbe/base: correct definition of macro
Date: Fri, 28 Mar 2025 11:16:15 +0000
Message-ID: <20250328111621.2665257-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250328111621.2665257-1-bruce.richardson@intel.com>
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
 <20250328111621.2665257-1-bruce.richardson@intel.com>
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

