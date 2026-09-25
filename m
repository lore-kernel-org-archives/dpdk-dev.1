Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C4DC98321
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 19:31:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D740640281;
	Fri, 25 Sep 2026 21:31:12 +0200 (CEST)
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
 by mails.dpdk.org (Postfix) with ESMTP id 0085A400D5
 for <dev@dpdk.org>; Fri, 25 Sep 2026 21:31:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=8140; q=dns/txt;
 s=iport01; t=1790364671; x=1791574271;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=C3yd9ofaYkbA5zR0+IAkH2wHo9bA1Smy8CfCDd8U11A=;
 b=bkf0mFIozTLR2Jz+gZI4Bmv/SBReXW65gxb9s6Imo4hYXhaJnblZUD+c
 SvLvG2aRzyoavASn+FgYe934f0pSh0RlrcvMQXbwQNRVMFAkyWfRzRMnN
 jV2PP2V0+9Ap80H/705nUXRLZtQNFgcH56vsvNNU8XNVYJU0f582G0Hrd
 6kh0PtVYBSj0r972Z+d5gJ+ZaJsBBFCWGJUPWSV/Hrw5inbwGzvH5S3Eu
 9o4xJJvJUuqJnhdRc6ISBjJSPyvoTjMoUyi7auAEhTe7J2OGy0M8mD6zg
 2uWeqZ9pbQ0GIe8BW5gca0vyZN0xGJnho79DhkQymkvSXRgqqAvavBZ9b g==;
X-CSE-ConnectionGUID: ibxk1VMtShumZETGodTdYQ==
X-CSE-MsgGUID: Y+dBqUfvQOq9bgWXZqnXFg==
X-IPAS-Result: =?us-ascii?q?A0BJAgDVyrZq/4wQJK1aHgEBCxIMggULgld1YUJJhFeRc?=
 =?us-ascii?q?wOTHYp9gX4PAQEBDzEgBAEBhQECAgKOCQImNAkOAQIEAwIDAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBCgEBBQEBAQIBBwWBDhOGTw2QEwIBAyMECwFGEB8BBQImAgJGEBmDAgGCd?=
 =?us-ascii?q?APBG3p/M4EB3kiBaAELFAGBCi6FQIMfAYFxhAiEfCcVBoFJRIEVMoM3hC1Cg?=
 =?us-ascii?q?y+CagSCDYEhgVqFEYhihU0JgUEcA1ksAVUTFwsHBWGBBQOBBm4yHYEjPhcvW?=
 =?us-ascii?q?BsGBYEdgQkEE4IZIxk2eoEJXoErKWABEBeBB4IHAoJUggECAUlDDgdFUwklQ?=
 =?us-ascii?q?QoSRyYiCBIJARMaMAuBIThBCSgLbT03FRkEPZEgHoFzLUQBMSkhFAcMOlmBC?=
 =?us-ascii?q?AI2ApMug22vWYQojCKVVDOFW6UUmQijPoYFgWg8gVlNIxWDIglKGQ+OKwMWg?=
 =?us-ascii?q?wLNEyg1PwcCBw8CkXQBJgeBTwEB?=
IronPort-Data: A9a23:shsEtK5GXo6OopwaE0MdkwxRtFfGchMFZxGqfqrLsTDasY5as4F+v
 jRJCD3UMqnYZjf8KNFwPI2x8k0AvpbdyYNnGgE6pShkZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyGa+1H1dOex9RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wo/KUzBHf/g2QqajNOtvrZwP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4ePIcI+b9JJH119
 eEdGh0xQRePu+6H+efuIgVsrpxLwMjDNYcbvDRkiDreF/tjGcuFSKTR7tge1zA17ixMNa+BP
 IxCN3w2MlKZP0Un1lQ/UPrSmM+ymnj0fhVTqUmeouw85G27IAlZgOW9aoaEJIbRLSlTtnfbq
 kjfwmrnOzYDZdaQ9gq363ScqOCayEsXX6pXTtVU7MVCjFCN7mALBB5QUkG0ydGzkFO1VpRFK
 kcU8zAitq803E2tUtT5GRa/pRasuxQ0QN9ZCfEh6AiXx7HF+BqUA3NCRTlEAOHKr+c/QTgsk
 1vMlNTzCHk36/ueSGmW8fGfqjba1TUpEFLurBQsFWMti+QPaqlq5v4TZr6PyJKIs+A=
IronPort-HdrOrdr: A9a23:uC+ReqwHl/H4hwzk8LLgKrPwDL1zdoMgy1knxilNoNJuHvBw8P
 re+cjztCWE6gr5N0tPpTntAsO9qDbnlaKdgrNhWYtKIjOGhILAFugLhrcKgQeQeBEWndQz6U
 4PScVDIey1K0RmhsDn5wT9OdMhzN6btJ2Mv47lvhBQpcUAUdAY0++/YTzrdHFLeA==
X-Talos-CUID: =?us-ascii?q?9a23=3ALJXb7WmEpvuTNTIiKWiuL3PWhIjXOXzX3HSJHWq?=
 =?us-ascii?q?kMmZ0TY+4dXCX9J9oovM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Aaxvp1A8G2pPImYgOAm4t5omQf/Yr7463NU4TqLI?=
 =?us-ascii?q?f6sOLChxCIjGtojviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,123,1787011200"; d="scan'208";a="858249623"
Received: from alln-l-core-03.cisco.com ([173.36.16.140])
 by alln-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 25 Sep 2026 19:31:09 +0000
Received: from rtp-orb-10405.cisco.com (rtp-orb-10405.cisco.com [64.100.22.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alln-l-core-03.cisco.com (Postfix) with ESMTPS id A00A1180007C2;
 Fri, 25 Sep 2026 19:31:09 +0000 (GMT)
From: Randy L Tice <rtice@cisco.com>
To: dev@dpdk.org
Cc: Morten =?utf-8?q?Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 1/1] mbuf: add optional dynfield3 storage
Date: Fri, 25 Sep 2026 15:31:08 -0400
Message-Id: <179036466858.2.6989648946195974931.v2-0001-mbuf-add-optional-dynfield3-storage.patch@cisco.com>
In-Reply-To: <179036466858.2.13982499480648014088.v2-0000-cover-letter.patch@cisco.com>
References: <179027866735.2.6802580807293251703.0000-cover-letter.patch@cisco.com>
 <179036466858.2.13982499480648014088.v2-0000-cover-letter.patch@cisco.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Outbound-Client-TLS: ANONYMOUS; rtp-orb-10405.cisco.com [64.100.22.53];
 TLSv1.2; ECDHE-RSA-AES256-GCM-SHA384; 256
X-Outbound-SMTP-Client: 64.100.22.53, rtp-orb-10405.cisco.com
X-Outbound-Node: alln-l-core-03.cisco.com
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

From: Randy L Tice <rtice@cisco.com>
Date: Thu, 03 Sep 2026 09:13:28 -0400

Add build-time support for optional cache-line-aligned dynamic-field
storage at the end of struct rte_mbuf.

The mbuf_dynfield3_size Meson option sets RTE_MBUF_DYNFIELD3_SIZE
in rte_build_config.h. A non-zero value enables the extra area. The
storage is represented as uint64_t elements for 32-bit and 64-bit
build consistency.

When enabled, dynfield3 is made available to the mbuf dynamic field
allocator. The mbuf_dynfield3_copy option controls whether the area is
copied by the generic mbuf dynamic-field copy helper, and defaults to
false.

Validate that the configured size is non-negative, is a multiple of
sizeof(uint64_t), and reserves a multiple of the cache line size.

Signed-off-by: Randy L Tice <rtice@cisco.com>
---
 app/test/test_mbuf.c                   |  5 +++--
 config/meson.build                     | 16 ++++++++++++++++
 doc/guides/rel_notes/release_26_11.rst | 15 +++++++++++++++
 lib/mbuf/rte_mbuf.h                    |  6 ++++++
 lib/mbuf/rte_mbuf_core.h               | 17 +++++++++++++++++
 lib/mbuf/rte_mbuf_dyn.c                |  3 +++
 meson_options.txt                      |  4 ++++
 7 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/app/test/test_mbuf.c b/app/test/test_mbuf.c
index db23259745..9f3b396a61 100644
--- a/app/test/test_mbuf.c
+++ b/app/test/test_mbuf.c
@@ -2776,8 +2776,9 @@ test_mbuf(void)
 	struct rte_mempool *pktmbuf_pool = NULL;
 	struct rte_mempool *pktmbuf_pool2 = NULL;
 
-
-	RTE_BUILD_BUG_ON(sizeof(struct rte_mbuf) != RTE_CACHE_LINE_MIN_SIZE * 2);
+	RTE_BUILD_BUG_ON(sizeof(struct rte_mbuf) !=
+		RTE_CACHE_LINE_MIN_SIZE * 2 +
+		RTE_MBUF_DYNFIELD3_SIZE);
 
 	/* create pktmbuf pool if it does not exist */
 	pktmbuf_pool = rte_pktmbuf_pool_create("test_pktmbuf_pool",
diff --git a/config/meson.build b/config/meson.build
index 344f68822b..dd857e065f 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -384,6 +384,19 @@ dpdk_conf.set('RTE_LIBEAL_USE_HPET', get_option('use_hpet'))
 dpdk_conf.set('RTE_ENABLE_STDATOMIC', get_option('enable_stdatomic'))
 dpdk_conf.set('RTE_ENABLE_TRACE_FP', get_option('enable_trace_fp'))
 dpdk_conf.set('RTE_PKTMBUF_HEADROOM', get_option('pkt_mbuf_headroom'))
+mbuf_dynfield3_size = get_option('mbuf_dynfield3_size')
+if mbuf_dynfield3_size < 0
+    error('mbuf_dynfield3_size must be greater than or equal to 0')
+endif
+if mbuf_dynfield3_size % cc.sizeof('uint64_t', prefix: '#include <stdint.h>') != 0
+    error('mbuf_dynfield3_size must be a multiple of sizeof(uint64_t)')
+endif
+mbuf_dynfield3_copy = get_option('mbuf_dynfield3_copy')
+if mbuf_dynfield3_copy and mbuf_dynfield3_size == 0
+    error('mbuf_dynfield3_copy requires mbuf_dynfield3_size greater than 0')
+endif
+dpdk_conf.set('RTE_MBUF_DYNFIELD3_SIZE', mbuf_dynfield3_size)
+dpdk_conf.set10('RTE_MBUF_DYNFIELD3_COPY', mbuf_dynfield3_copy)
 # values which have defaults which may be overridden
 dpdk_conf.set('RTE_MAX_VFIO_GROUPS', 64)
 dpdk_conf.set('RTE_DRIVER_MEMPOOL_BUCKET_SIZE_KB', 64)
@@ -395,6 +408,9 @@ dpdk_conf.set10('RTE_IOVA_IN_MBUF', get_option('enable_iova_as_pa'))
 
 compile_time_cpuflags = []
 subdir(arch_subdir)
+if mbuf_dynfield3_size % dpdk_conf.get('RTE_CACHE_LINE_SIZE') != 0
+    error('mbuf_dynfield3_size must be a multiple of RTE_CACHE_LINE_SIZE')
+endif
 dpdk_conf.set('RTE_COMPILE_TIME_CPUFLAGS', ','.join(compile_time_cpuflags))
 
 # apply cross-specific options
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index dec96ccbc7..2d0fb6660c 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -60,6 +60,15 @@ New Features
   Added the experimental ``rte_cpu_socket_id()`` function
   to map an OS logical CPU ID to the NUMA socket containing that CPU.
 
+* **Added optional extra mbuf dynamic field storage.**
+
+  Added ``mbuf_dynfield3_size`` build option to enable a
+  cache-line-aligned ``dynfield3`` area in ``struct rte_mbuf``.
+  The configured size is defined as ``RTE_MBUF_DYNFIELD3_SIZE``
+  in ``rte_build_config.h``.
+  The area is not copied by generic mbuf copy or clone operations
+  unless ``mbuf_dynfield3_copy`` is enabled.
+
 * **Added TPID support to VLAN tag insertion.**
 
   Added ``rte_vlan_insert_tpid()`` to the net library.
@@ -338,6 +347,12 @@ Known Issues
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* **Some drivers may require changes for enlarged mbufs.**
+
+  Enabling ``mbuf_dynfield3_size`` with a non-zero value increases
+  ``sizeof(struct rte_mbuf)``. Drivers or applications that assume a
+  fixed mbuf size may require follow-up changes.
+
 
 Tested Platforms
 ----------------
diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
index 60ec8158cd..97360d6549 100644
--- a/lib/mbuf/rte_mbuf.h
+++ b/lib/mbuf/rte_mbuf.h
@@ -1231,6 +1231,12 @@ rte_mbuf_dynfield_copy(struct rte_mbuf *mdst, const struct rte_mbuf *msrc)
 	mdst->dynfield2 = msrc->dynfield2;
 #endif
 	memcpy(&mdst->dynfield1, msrc->dynfield1, sizeof(mdst->dynfield1));
+#if RTE_MBUF_DYNFIELD3_SIZE > 0
+	if (RTE_MBUF_DYNFIELD3_COPY)
+		memcpy(RTE_PTR_ADD(mdst, RTE_MBUF_DYNFIELD3_OFFSET),
+			RTE_PTR_ADD(msrc, RTE_MBUF_DYNFIELD3_OFFSET),
+			RTE_MBUF_DYNFIELD3_SIZE);
+#endif
 }
 
 /* internal */
diff --git a/lib/mbuf/rte_mbuf_core.h b/lib/mbuf/rte_mbuf_core.h
index 98b0bd9ca7..5069984269 100644
--- a/lib/mbuf/rte_mbuf_core.h
+++ b/lib/mbuf/rte_mbuf_core.h
@@ -17,6 +17,7 @@
  */
 
 #include <stdalign.h>
+#include <stddef.h>
 #include <stdint.h>
 
 #include <rte_byteorder.h>
@@ -26,6 +27,9 @@
 extern "C" {
 #endif
 
+#define RTE_MBUF_DYNFIELD3_CNT \
+	(RTE_MBUF_DYNFIELD3_SIZE / sizeof(uint64_t))
+
 /*
  * Packet Offload Features Flags. It also carry packet type information.
  * Critical resources. Both rx/tx shared these bits. Be cautious on any change
@@ -686,8 +690,21 @@ struct __rte_cache_aligned rte_mbuf {
 	uint16_t timesync;
 
 	uint32_t dynfield1[9]; /**< Reserved for dynamic fields. */
+
+#if RTE_MBUF_DYNFIELD3_SIZE > 0
+	alignas(RTE_CACHE_LINE_SIZE)
+	uint64_t dynfield3[RTE_MBUF_DYNFIELD3_CNT];
+	/**< Reserved cache-line-aligned space for dynamic fields. */
+#endif /* RTE_MBUF_DYNFIELD3_SIZE > 0 */
 };
 
+#if RTE_MBUF_DYNFIELD3_SIZE > 0
+#define RTE_MBUF_DYNFIELD3_OFFSET \
+	offsetof(struct rte_mbuf, dynfield3)
+#else
+#define RTE_MBUF_DYNFIELD3_OFFSET 0
+#endif
+
 /**
  * Function typedef of callback to free externally attached buffer.
  */
diff --git a/lib/mbuf/rte_mbuf_dyn.c b/lib/mbuf/rte_mbuf_dyn.c
index 5987c9dee8..b42fe6377d 100644
--- a/lib/mbuf/rte_mbuf_dyn.c
+++ b/lib/mbuf/rte_mbuf_dyn.c
@@ -135,6 +135,9 @@ init_shared_mem(void)
 #if !RTE_IOVA_IN_MBUF
 		mark_free(dynfield2);
 #endif
+#if RTE_MBUF_DYNFIELD3_SIZE > 0
+		mark_free(dynfield3);
+#endif
 
 		/* init free_flags */
 		for (mask = RTE_MBUF_F_FIRST_FREE; mask <= RTE_MBUF_F_LAST_FREE; mask <<= 1)
diff --git a/meson_options.txt b/meson_options.txt
index e28d24054c..579c434b9a 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -44,6 +44,10 @@ option('max_numa_nodes', type: 'string', value: 'default', description:
        'Set the highest NUMA node supported by EAL; "default" is different per-arch, "detect" detects the highest NUMA node on the build machine.')
 option('enable_iova_as_pa', type: 'boolean', value: true, description:
        'Support the use of physical addresses for IO addresses, such as used by UIO or VFIO in no-IOMMU mode. When disabled, DPDK can only run with IOMMU support for address mappings, but will have more space available in the mbuf structure.')
+option('mbuf_dynfield3_size', type: 'integer', value: 0, description:
+       'Size of optional extra mbuf dynamic field area, in bytes.')
+option('mbuf_dynfield3_copy', type: 'boolean', value: false, description:
+       'Copy optional extra mbuf dynamic field area during mbuf copy/clone.')
 option('mbuf_refcnt_atomic', type: 'boolean', value: true, description:
        'Atomically access the mbuf refcnt.')
 option('platform', type: 'string', value: 'native', description:
-- 
2.35.6

