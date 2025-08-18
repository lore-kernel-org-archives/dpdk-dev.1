Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA76CA0EC0
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 11:00:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D247E40664;
	Mon, 18 Aug 2025 12:59:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 57E964042F
 for <dev@dpdk.org>; Mon, 18 Aug 2025 12:59:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755514777; x=1787050777;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=z/7vpdejR/LynwUNltPimOymYbhgskI1uB1k0I2H0aw=;
 b=dEJN2/p8TJeYs3KsouZ6o6L2CveNmAH+xQhoomQtCap0+kZ4MKpbUQX1
 q2/NhDuUEYGxKiXDoy3pJWsiFObxB5JWtlLzEMJBzF9VuXU34xPyLZfGo
 C6j8ntJAhwGtu/veEjQpJphIKw5zDc+PdSGXVsbVVNGXZFpF4OpzTYyG0
 Ymq7ySGcEOwKhU9gmIya0kYN/PeKwKaadKOEELskLYlKGXWpATkDmlYSW
 HoX+wj2ku+1FNgaqZ7MBMUL2ZYbKM7KYke4FG9+VbA7QFIk1gIrU+42Ix
 HV1/EV+eHKiZ7Oc9DLQ7fwCLRFsKOt4uAES7J/HEjAGVqjyto5Gc5hpD7 A==;
X-CSE-ConnectionGUID: Di7LhrHeQ4+atDexrhK35Q==
X-CSE-MsgGUID: xmzQVtCST+KPV1UkAru3hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="83165427"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="83165427"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 03:59:36 -0700
X-CSE-ConnectionGUID: yz6WHnrDSiG5qOpNQvHt8g==
X-CSE-MsgGUID: L+TNSGejQFuC8OlLyCsl+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="166722948"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa006.jf.intel.com with ESMTP; 18 Aug 2025 03:59:35 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v3 05/15] net/intel: introduce common vector capability
 function
Date: Mon, 18 Aug 2025 10:59:04 +0000
Message-Id: <20250818105914.169732-6-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818105914.169732-1-ciara.loftus@intel.com>
References: <20250818105914.169732-1-ciara.loftus@intel.com>
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

From: Bruce Richardson <bruce.richardson@intel.com>

A common need within the drivers is to select between SSE, AVX2 and
AVX-512 code paths. Provide a common function which helps with this
decision making, that returns the max simd bandwidth based on any
user configured maximums and available CPU flags.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/common/rx_vec_x86.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/intel/common/rx_vec_x86.h b/drivers/net/intel/common/rx_vec_x86.h
index 3d7343b1ff..32dd5ce189 100644
--- a/drivers/net/intel/common/rx_vec_x86.h
+++ b/drivers/net/intel/common/rx_vec_x86.h
@@ -346,4 +346,26 @@ ci_rxq_rearm(struct ci_rx_queue *rxq, const enum ci_rx_vec_level vec_level)
 	rte_write32_wc(rte_cpu_to_le_32(rx_id), rxq->qrx_tail);
 }
 
+#ifdef CC_AVX512_SUPPORT
+#define X86_MAX_SIMD_BITWIDTH (rte_vect_get_max_simd_bitwidth())
+#else
+#define X86_MAX_SIMD_BITWIDTH RTE_MIN(256, rte_vect_get_max_simd_bitwidth())
+#endif /* CC_AVX512_SUPPORT */
+
+static inline enum rte_vect_max_simd
+ci_get_x86_max_simd_bitwidth(void)
+{
+	int ret = RTE_VECT_SIMD_DISABLED;
+	int simd = X86_MAX_SIMD_BITWIDTH;
+
+	if (simd >= 512 && rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1 &&
+			rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) == 1)
+		ret = RTE_VECT_SIMD_512;
+	else if (simd >= 256 && (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1))
+		ret = RTE_VECT_SIMD_256;
+	else if (simd >= 128)
+		ret = RTE_VECT_SIMD_128;
+	return ret;
+}
+
 #endif /* _COMMON_INTEL_RX_VEC_X86_H_ */
-- 
2.34.1

