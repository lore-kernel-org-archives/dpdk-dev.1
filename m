Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6BDC9830E
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 19:37:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB9CA40696;
	Thu, 24 Sep 2026 21:37:53 +0200 (CEST)
Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
 by mails.dpdk.org (Postfix) with ESMTP id 18F534026A
 for <dev@dpdk.org>; Thu, 24 Sep 2026 21:37:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=7301; q=dns/txt;
 s=iport01; t=1790278670; x=1791488270;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=LGKrCCaksGTKmUErIoXT8tWFphgl3HGQ44kNwbGwkQU=;
 b=en340a1Rmo3jA2pP+gzPIfQ5KvqHC7QC8Ph6hCfnFXzOa8h5ShP53ltX
 qH+puDQOEdRBaB5YHRc0wOoixa0BZzy3+ZtCT25MFjKYln5hlHXDEmPWi
 rGHatbAf2ra6WJ+LCEaxT0i33kUIXqmdUC9WUB0/XV9rnn1ejOtnaflKi
 XMeXCEfzDXdYtEH6XyRQQD/xaqx6YDgKFAQ7L8LxaJGRB3nzabqdwb2Cm
 Pl2X3ESoarvGTPb8UxaQfiVNvC+1yJ5A+Yvu8Epk87ntN6MWl+9a6kIlh
 OxiFwNyE7ZjjEJeuWE6PuFLOKkOGuy3/i8Qk6czXiivfSZFuzuzwh3PBD w==;
X-CSE-ConnectionGUID: SPjZEaVfS66CgkGmFZzBLg==
X-CSE-MsgGUID: 7u4YugbURQGS2QLhCDRtqA==
X-IPAS-Result: =?us-ascii?q?A0BJAgAye7Vq/5IQJK1aglmCV3VhQkmEV5FzA5Mdin2Bf?=
 =?us-ascii?q?g8BAQEPMSAEAQGFAQICAo4JAiY0CQ4BAgQDAgMBAQEBAQEBAQEBAQEKAQEFA?=
 =?us-ascii?q?QEBAgEHBYEOE4ZPDZATAgEDIwQLAUYQHwEFAiYCAkYQGYMCAYJ0A8JBen8zg?=
 =?us-ascii?q?QGEftlKgWgBCxQBgQouhUCDHwGBcYQIhHwnFQaBSUSBFTKDN4Qtg3GCagSDL?=
 =?us-ascii?q?oFajXOFTgmBQRwDWSwBVRMXCwcFYYEFA4EGbjIdgSM+Fy9YGwYFgR2BCQQTg?=
 =?us-ascii?q?hojGTZ6gQlegSspYAEQF4EJggcCglSCAQIBSUMOB0VTCSVBChJHJiIIEgkBE?=
 =?us-ascii?q?xowC4EjOkEJKAttPTcVGQQ9kSIegXMtRTEpIRQHDDpZgQg6ky6Dba9ZhCiMI?=
 =?us-ascii?q?pVUM4VbpRKZCKM+hgWBaDyBWU0jFYMiCUoZD44uFoMCzRMoNT8HAgcPApF0A?=
 =?us-ascii?q?SYHgU8BAQ?=
IronPort-Data: A9a23:yB0pp6y9yMDGUvlUGhV6t+dYxyrEfRIJ4+MujC+fZmUNrF6WrkUOn
 WNMUWiHa6rfZGHyeIx3Oozg/E9VsZ/VyNUxHQZqpFhgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlqCCKa/lHyYuCJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 4yaT/H3Ygf/hWYlaD5MscpvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE8NvK6X
 evK0Iai9Wrf+Ro3Yvv9+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+vpT2M4nVKtio27hc+adZ
 zl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CCe5xWuTpfi/xlhJHoOP78189h5Oj8Q3
 vMbBzUjXAKpo+3jldpXSsE07igiBMDvOIVavjRryivUSK53B5vCWK7No9Rf2V/chOgXQq2YP
 JRfMGQpNUieC/FMEg9/5JYWhvupjXTXeDxDo1XTrq0yi4TW5Fwsium9aoOMJbRmQ+0Kgxqpu
 23Mwl7ALSpADfif4ha/7muF07qncSTTHdh6+KeD3vJnnnWf3mAQThoMWjOTq+OkgUP4QdNUK
 0UO9jEpq4Az8lCmSp/2WBjQiHuOlgUZUsBMCO0z8gyW27HI7gOCQGMDS1Z8hMcOvcsyQ3kuk
 1SOhd6sXW0pu7yOQnXb/bCRxd+vBRUowaY5TXdsZWM4DxPL+enfUjqnog5fLZOI
IronPort-HdrOrdr: A9a23:hGyemq6Xff758NS2tQPXwOjXdLJyesId70hD6qm+c3Bom6uj5q
 WTdZUgpH3JYVkqNk3I9errBEDEexPhHP1OkO0s1MmZPTUO0VHAROpfBMnZsl7d8kbFmdK1u5
 0MT4FOTPvtEFN9kcH2pCO8E9om3Z271ZrAv5a485+oJjsaEp2JKGxCe2CmLnE=
X-Talos-CUID: 9a23:BpehAWy4If3N/LG40Tk/BgUvIsIXX3TjwkyOfWS3CklsZo+HY3ufrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AMctNxg13B4ItCQJAhbc9bg9zuzUjvLnyOV0Cm6g?=
 =?us-ascii?q?8gua/bxVUOxyxtiiua9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,121,1787011200"; d="scan'208";a="852982117"
Received: from alln-l-core-09.cisco.com ([173.36.16.146])
 by alln-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 24 Sep 2026 19:37:48 +0000
Received: from rtp-orb-10405.cisco.com (rtp-orb-10405.cisco.com [64.100.22.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alln-l-core-09.cisco.com (Postfix) with ESMTPS id 63F0E18000466;
 Thu, 24 Sep 2026 19:37:48 +0000 (GMT)
From: Randy L Tice <rtice@cisco.com>
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, bruce.richardson@intel.com
Subject: [PATCH 1/1] mbuf: add optional dynfield3 storage
Date: Thu, 24 Sep 2026 15:37:47 -0400
Message-Id: <179027866735.2.17588889285368059726.0001-mbuf-add-optional-dynfield3-storage.patch@cisco.com>
In-Reply-To: <179027866735.2.6802580807293251703.0000-cover-letter.patch@cisco.com>
References: <179027866735.2.6802580807293251703.0000-cover-letter.patch@cisco.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Outbound-Client-TLS: ANONYMOUS; rtp-orb-10405.cisco.com [64.100.22.53];
 TLSv1.2; ECDHE-RSA-AES256-GCM-SHA384; 256
X-Outbound-SMTP-Client: 64.100.22.53, rtp-orb-10405.cisco.com
X-Outbound-Node: alln-l-core-09.cisco.com
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

The mbuf_dynfield3_cnt Meson option sets RTE_MBUF_DYNFIELD3_CNT in
rte_build_config.h. A non-zero value enables the extra area.

When enabled, dynfield3 is made available to the mbuf dynamic field
allocator and is copied by the generic mbuf dynamic-field copy helper.
This extends the existing Dynamic Mbuf Fields backing storage without
changing the default mbuf layout.

Validate that the configured element count is non-negative and that the
reserved space is a multiple of the cache line size.

Signed-off-by: Randy L Tice <rtice@cisco.com>
---
 app/test/test_mbuf.c                   |  5 +++--
 config/meson.build                     | 10 ++++++++++
 doc/guides/rel_notes/release_26_11.rst | 15 +++++++++++++++
 lib/mbuf/rte_mbuf.h                    |  3 +++
 lib/mbuf/rte_mbuf_core.h               | 16 ++++++++++++++++
 lib/mbuf/rte_mbuf_dyn.c                |  3 +++
 meson_options.txt                      |  2 ++
 7 files changed, 52 insertions(+), 2 deletions(-)

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
index 344f68822b..e500a7b075 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -384,6 +384,11 @@ dpdk_conf.set('RTE_LIBEAL_USE_HPET', get_option('use_hpet'))
 dpdk_conf.set('RTE_ENABLE_STDATOMIC', get_option('enable_stdatomic'))
 dpdk_conf.set('RTE_ENABLE_TRACE_FP', get_option('enable_trace_fp'))
 dpdk_conf.set('RTE_PKTMBUF_HEADROOM', get_option('pkt_mbuf_headroom'))
+mbuf_dynfield3_cnt = get_option('mbuf_dynfield3_cnt')
+if mbuf_dynfield3_cnt < 0
+    error('mbuf_dynfield3_cnt must be greater than or equal to 0')
+endif
+dpdk_conf.set('RTE_MBUF_DYNFIELD3_CNT', mbuf_dynfield3_cnt)
 # values which have defaults which may be overridden
 dpdk_conf.set('RTE_MAX_VFIO_GROUPS', 64)
 dpdk_conf.set('RTE_DRIVER_MEMPOOL_BUCKET_SIZE_KB', 64)
@@ -395,6 +400,11 @@ dpdk_conf.set10('RTE_IOVA_IN_MBUF', get_option('enable_iova_as_pa'))
 
 compile_time_cpuflags = []
 subdir(arch_subdir)
+mbuf_dynfield3_size = mbuf_dynfield3_cnt * cc.sizeof('uintptr_t',
+        prefix: '#include <stdint.h>')
+if mbuf_dynfield3_size % dpdk_conf.get('RTE_CACHE_LINE_SIZE') != 0
+    error('mbuf_dynfield3_cnt must reserve a multiple of RTE_CACHE_LINE_SIZE')
+endif
 dpdk_conf.set('RTE_COMPILE_TIME_CPUFLAGS', ','.join(compile_time_cpuflags))
 
 # apply cross-specific options
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index dec96ccbc7..abe82e7e3f 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -60,6 +60,13 @@ New Features
   Added the experimental ``rte_cpu_socket_id()`` function
   to map an OS logical CPU ID to the NUMA socket containing that CPU.
 
+* **Added optional extra mbuf dynamic-field storage.**
+
+  Added ``mbuf_dynfield3_cnt`` build option to reserve a
+  cache-line-aligned ``dynfield3`` area in ``struct rte_mbuf``.
+  The value is defined as ``RTE_MBUF_DYNFIELD3_CNT`` in
+  ``rte_build_config.h``; a non-zero value enables the extra area.
+
 * **Added TPID support to VLAN tag insertion.**
 
   Added ``rte_vlan_insert_tpid()`` to the net library.
@@ -338,6 +345,14 @@ Known Issues
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* **Some drivers may require changes for enlarged mbufs.**
+
+  Enabling ``mbuf_dynfield3_cnt`` with a non-zero value increases
+  ``sizeof(struct rte_mbuf)``. Drivers or applications that assume a
+  fixed mbuf size may require follow-up changes. The
+  ``mempool/octeontx`` driver currently asserts that
+  ``sizeof(struct rte_mbuf)`` does not exceed its fixed buffer offset.
+
 
 Tested Platforms
 ----------------
diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
index 60ec8158cd..6a567a9e43 100644
--- a/lib/mbuf/rte_mbuf.h
+++ b/lib/mbuf/rte_mbuf.h
@@ -1231,6 +1231,9 @@ rte_mbuf_dynfield_copy(struct rte_mbuf *mdst, const struct rte_mbuf *msrc)
 	mdst->dynfield2 = msrc->dynfield2;
 #endif
 	memcpy(&mdst->dynfield1, msrc->dynfield1, sizeof(mdst->dynfield1));
+#if RTE_MBUF_DYNFIELD3_CNT > 0
+	memcpy(&mdst->dynfield3, msrc->dynfield3, sizeof(mdst->dynfield3));
+#endif
 }
 
 /* internal */
diff --git a/lib/mbuf/rte_mbuf_core.h b/lib/mbuf/rte_mbuf_core.h
index 98b0bd9ca7..bb57397bb6 100644
--- a/lib/mbuf/rte_mbuf_core.h
+++ b/lib/mbuf/rte_mbuf_core.h
@@ -17,6 +17,7 @@
  */
 
 #include <stdalign.h>
+#include <stddef.h>
 #include <stdint.h>
 
 #include <rte_byteorder.h>
@@ -686,8 +687,23 @@ struct __rte_cache_aligned rte_mbuf {
 	uint16_t timesync;
 
 	uint32_t dynfield1[9]; /**< Reserved for dynamic fields. */
+
+#if RTE_MBUF_DYNFIELD3_CNT > 0
+	alignas(RTE_CACHE_LINE_SIZE)
+	uintptr_t dynfield3[RTE_MBUF_DYNFIELD3_CNT];
+	/**< Reserved for dynamic fields. */
+#endif /* RTE_MBUF_DYNFIELD3_CNT > 0 */
 };
 
+#define RTE_MBUF_DYNFIELD3_SIZE \
+	(RTE_MBUF_DYNFIELD3_CNT * sizeof(uintptr_t))
+#if RTE_MBUF_DYNFIELD3_CNT > 0
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
index 5987c9dee8..dcbe0a8416 100644
--- a/lib/mbuf/rte_mbuf_dyn.c
+++ b/lib/mbuf/rte_mbuf_dyn.c
@@ -135,6 +135,9 @@ init_shared_mem(void)
 #if !RTE_IOVA_IN_MBUF
 		mark_free(dynfield2);
 #endif
+#if RTE_MBUF_DYNFIELD3_CNT > 0
+		mark_free(dynfield3);
+#endif
 
 		/* init free_flags */
 		for (mask = RTE_MBUF_F_FIRST_FREE; mask <= RTE_MBUF_F_LAST_FREE; mask <<= 1)
diff --git a/meson_options.txt b/meson_options.txt
index e28d24054c..337f9e5e49 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -44,6 +44,8 @@ option('max_numa_nodes', type: 'string', value: 'default', description:
        'Set the highest NUMA node supported by EAL; "default" is different per-arch, "detect" detects the highest NUMA node on the build machine.')
 option('enable_iova_as_pa', type: 'boolean', value: true, description:
        'Support the use of physical addresses for IO addresses, such as used by UIO or VFIO in no-IOMMU mode. When disabled, DPDK can only run with IOMMU support for address mappings, but will have more space available in the mbuf structure.')
+option('mbuf_dynfield3_cnt', type: 'integer', value: 0, description:
+       'Size of optional extra mbuf dynamic field area, in uintptr_t units.')
 option('mbuf_refcnt_atomic', type: 'boolean', value: true, description:
        'Atomically access the mbuf refcnt.')
 option('platform', type: 'string', value: 'native', description:
-- 
2.35.6

