Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B20CA5FA3
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 18:17:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2898D40E15;
	Mon, 28 Sep 2026 20:17:01 +0200 (CEST)
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
 by mails.dpdk.org (Postfix) with ESMTP id 7F0DB40E15
 for <dev@dpdk.org>; Mon, 28 Sep 2026 20:16:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=16838; q=dns/txt;
 s=iport01; t=1790619418; x=1791829018;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=bPq7ICNbPgd4uTQzdvLB0qIhBwO+0hYWwWH7ccZfzvM=;
 b=CjSt8iJgZzHkPrwyudRo5Nnm5VFlckrLC6pbUufQFmEBHD78v1NiAYv/
 y88r5kJ2CQ8NjmOC1yb8eg1ABzVCiWcj03RHtpmVwNahLnRSWXP/fxEZB
 /pGsihGEkBUlbEQlXZz8fepHoJIaDfz/rKz5JEr3z4gDob/Q+lhgM2XKo
 qdIgpOlwKx0vxxMW8MjdBOCWtLTuSRgqS20IjJ5h7SQGFrgLRbjj3maRj
 rjJTxkL+JrUHRPId84RWMSaQnZtHl3bOSQbueH+FyMGSF+3nh9uGaqzcQ
 BQvFWR4YH+ulSpEPCuEqorvD+bjZ7pgsvsvHUTE9udbruFJEnaABKK+pW Q==;
X-CSE-ConnectionGUID: iRsibhz5SZGXqoedEkYPyA==
X-CSE-MsgGUID: 1TekI4e3Q26/CuiLRSXwvg==
X-IPAS-Result: =?us-ascii?q?A0ADAAAwrrpq/4r/Ja1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBgXwFAQEBAQsBglZ1YUJJhFeIG4lYA5Mdin2Bfg8BAQEPNxoEA?=
 =?us-ascii?q?QGFAQICAo4JAiY0CQ4BAgQDAgMBAQEBAQEBAQEBAQEKAQEFAQEBAgEHBYEOE?=
 =?us-ascii?q?4ZPDZATAgEDIwQLAUYQHwEFAiYCAkYQGYMCAYJ0A8Jeen8zgQHeSIFoAQsUA?=
 =?us-ascii?q?YEKLgGFP4MfAYFxhAiEfCcVBoFJRIEVg2mEJQiDcYJqBIIigQyBWh6TKAmBQ?=
 =?us-ascii?q?RwDWSwBVRMXCwcFYYEFA4EGbjIdgSM+Fy9YGwYFgR2BCQQTghkjGTZ6gQleg?=
 =?us-ascii?q?SspYAEQF4EHggcCglSCAQIBSUMOB0VTCSVBChJHJiIIEgkBExowC4EhOEEJK?=
 =?us-ascii?q?BdtPTcVGQQ9kSYegXNyASwEJwEBIRMBEy8LWQpIODiTHRGDbYwpg1afWoQoj?=
 =?us-ascii?q?CKVVDOEBIFXkkCSVJkIoz5IhT2BaDyBWU0jFYMiCUoZD44rAxaDAocuxWUoN?=
 =?us-ascii?q?T8HAgcPApF0gX0BAQ?=
IronPort-Data: A9a23:g2eJWaC4Yo9eZBVW/zfiw5YqxClBgxIJ4kV8jS/XYbTApDgrg2NWz
 2EcWGrTM/mIYmf1fYh/at/g9E0BsZTRzINqOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGcYZsCCCM/n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357jXGthh
 fuo+5eBYA7/i2YtWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TEws91DUs2L9AjyMlHGGZD+
 dEbGQgcR0XW7w626OrTpuhEnM8vKozveYgYoHwllWifBvc9SpeFSKLPjTNa9G5v3YYVQrCEO
 pdfMGE/BPjDS0Un1lM/Eo4/l+qAjXjkeDoeo1WQzUYyyzWJnVQrgOSzbrI5fPTTechWvxqV/
 VucoSPSHxA+Duev1iSKpyfEaujn2HmTtJgpPLG16NZmmFGQgGsJB3U+X0GmqvT/kE+1W9tFJ
 1cT/AIvq7Q/8AqgSdyVdx27qXqetzYZUsBOHuk+rgqKz8L8+BqUHmgJSBZHZcA5s9U1XTg30
 1WEhZXuHzMHmLifYWmY/62ItjO7IyUOPHQeaCofCwAC5rHeTJoblBnDSJNnVaWylNCwQWi2y
 DGRpy94jLIW5SIW65iGEZn8q2rEjvD0osQdtm07gkrNAttFWbOY
IronPort-HdrOrdr: A9a23:XfinuqrCJUQHoXuJ0sIn1qkaV5oLeYIsimQD101hICG9vPb1qy
 nIpoV/6faUskdyZJhOo7690cW7K080sKQU3WBzB8bHYOCZggqVxehZhOOI/9SjIVycygc378
 hdmsZFZeHYPBxdkdvw5hW+HpILxdmK973tuMLlpk0dKj2Dr8pbnn5E4sHxKDwReDV7
X-Talos-CUID: 9a23:8H8nh20qJ96eNZYDO9r99rxfG/o+c3fd3irrEWCIEGFkRJCWeGeB0fYx
X-Talos-MUID: 9a23:n/wehARpF2chKpI9RXS1uDxhFZtluJ30VgcmjJQigfK0KjJ/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,128,1787011200"; d="scan'208";a="529028466"
Received: from rcdn-l-core-01.cisco.com ([173.37.255.138])
 by rcdn-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 28 Sep 2026 18:16:55 +0000
Received: from rtp-orb-10405.cisco.com (rtp-orb-10405.cisco.com [64.100.22.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by rcdn-l-core-01.cisco.com (Postfix) with ESMTPS id 07541180001D0;
 Mon, 28 Sep 2026 18:16:54 +0000 (GMT)
From: Randy L Tice <rtice@cisco.com>
To: dev@dpdk.org
Cc: Morten =?utf-8?q?Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Harman Kalra <hkalra@marvell.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 1/1] mbuf: add optional no-copy dynamic field storage
Date: Mon, 28 Sep 2026 14:16:54 -0400
Message-Id: <179061941387.2.13690688541375502570.v3-0001-mbuf-add-optional-no-copy-dynamic-field-storage.patch@cisco.com>
In-Reply-To: <179061941387.2.17741463412422386825.v3-0000-cover-letter.patch@cisco.com>
References: <179036466858.2.13982499480648014088.v2-0000-cover-letter.patch@cisco.com>
 <179061941387.2.17741463412422386825.v3-0000-cover-letter.patch@cisco.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Outbound-Client-TLS: ANONYMOUS; rtp-orb-10405.cisco.com [64.100.22.53];
 TLSv1.2; ECDHE-RSA-AES256-GCM-SHA384; 256
X-Outbound-SMTP-Client: 64.100.22.53, rtp-orb-10405.cisco.com
X-Outbound-Node: rcdn-l-core-01.cisco.com
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

The mbuf_dynfield3_size Meson option sets RTE_MBUF_DYNFIELD3_SIZE in
rte_build_config.h. A non-zero value enables the extra area and grows
every mbuf by the configured amount.

When enabled, dynfield3 is reserved for dynamic fields registered with
RTE_MBUF_DYNFIELD_F_NO_COPY. Such fields are allocated from dynfield3
and are not copied by the generic mbuf dynamic-field copy helper used by
mbuf copy and clone operations. Dynamic fields registered without this
flag continue to use the existing copied dynamic-field storage and are
prevented from overlapping dynfield3.

Disable the octeontx mempool driver when the option is enabled because
it requires sizeof(struct rte_mbuf) to remain at most 128 bytes.

Signed-off-by: Randy L Tice <rtice@cisco.com>
---
 app/test/test_mbuf.c                   | 72 ++++++++++++++++++++++++--
 config/meson.build                     |  5 ++
 devtools/test-meson-builds.sh          |  3 ++
 doc/guides/prog_guide/mbuf_lib.rst     |  9 ++++
 doc/guides/rel_notes/release_26_11.rst | 17 +++++-
 drivers/mempool/octeontx/meson.build   |  5 ++
 lib/mbuf/rte_mbuf_core.h               |  6 +++
 lib/mbuf/rte_mbuf_dyn.c                | 54 ++++++++++++++++---
 lib/mbuf/rte_mbuf_dyn.h                | 11 +++-
 meson_options.txt                      |  2 +
 10 files changed, 172 insertions(+), 12 deletions(-)

diff --git a/app/test/test_mbuf.c b/app/test/test_mbuf.c
index db23259745..c03878bd96 100644
--- a/app/test/test_mbuf.c
+++ b/app/test/test_mbuf.c
@@ -2569,7 +2569,7 @@ test_mbuf_dyn(struct rte_mempool *pktmbuf_pool)
 	};
 	const struct rte_mbuf_dynfield dynfield_fail_big = {
 		.name = "test-dynfield-fail-big",
-		.size = 256,
+		.size = sizeof(struct rte_mbuf),
 		.align = 1,
 		.flags = 0,
 	};
@@ -2583,8 +2583,28 @@ test_mbuf_dyn(struct rte_mempool *pktmbuf_pool)
 		.name = "test-dynfield",
 		.size = sizeof(uint8_t),
 		.align = alignof(uint8_t),
-		.flags = 1,
+		.flags = RTE_MBUF_DYNFIELD_F_NO_COPY << 1,
+	};
+#if RTE_MBUF_DYNFIELD3_SIZE > 0
+	const struct rte_mbuf_dynfield dynfield3_no_copy = {
+		.name = "test-dynfield3-no-copy",
+		.size = sizeof(uint64_t),
+		.align = alignof(uint64_t),
+		.flags = RTE_MBUF_DYNFIELD_F_NO_COPY,
+	};
+	const struct rte_mbuf_dynfield dynfield_no_copy_bad_offset = {
+		.name = "test-dynfield-no-copy-bad-offset",
+		.size = sizeof(uint64_t),
+		.align = alignof(uint64_t),
+		.flags = RTE_MBUF_DYNFIELD_F_NO_COPY,
+	};
+	const struct rte_mbuf_dynfield dynfield_copy_bad_offset = {
+		.name = "test-dynfield-copy-bad-offset",
+		.size = 2 * sizeof(uint64_t),
+		.align = alignof(uint64_t),
+		.flags = 0,
 	};
+#endif
 	const struct rte_mbuf_dynflag dynflag_fail_flag = {
 		.name = "test-dynflag",
 		.flags = 1,
@@ -2602,7 +2622,11 @@ test_mbuf_dyn(struct rte_mempool *pktmbuf_pool)
 		.flags = 0,
 	};
 	struct rte_mbuf *m = NULL;
+	struct rte_mbuf *mc = NULL;
 	int offset, offset2, offset3;
+#if RTE_MBUF_DYNFIELD3_SIZE > 0
+	int dynfield3_no_copy_offset;
+#endif
 	int flag, flag2, flag3;
 	int ret;
 
@@ -2654,6 +2678,29 @@ test_mbuf_dyn(struct rte_mempool *pktmbuf_pool)
 	if (ret != -1)
 		GOTO_FAIL("dynamic field creation should fail (invalid flag)");
 
+#if RTE_MBUF_DYNFIELD3_SIZE > 0
+	dynfield3_no_copy_offset = rte_mbuf_dynfield_register_offset(&dynfield3_no_copy,
+			offsetof(struct rte_mbuf, dynfield3));
+	if (dynfield3_no_copy_offset != offsetof(struct rte_mbuf, dynfield3))
+		GOTO_FAIL("failed to register no-copy dynfield3 field, offset=%d: %s",
+			dynfield3_no_copy_offset, strerror(errno));
+
+	ret = rte_mbuf_dynfield_register_offset(&dynfield_no_copy_bad_offset,
+			offsetof(struct rte_mbuf, dynfield1[0]));
+	if (ret != -1)
+		GOTO_FAIL("no-copy dynamic field creation should fail outside dynfield3");
+
+	ret = rte_mbuf_dynfield_register_offset(&dynfield_copy_bad_offset,
+			offsetof(struct rte_mbuf, dynfield3));
+	if (ret != -1)
+		GOTO_FAIL("copied dynamic field creation should fail in dynfield3");
+
+	ret = rte_mbuf_dynfield_register_offset(&dynfield_copy_bad_offset,
+			offsetof(struct rte_mbuf, dynfield3) - sizeof(uint64_t));
+	if (ret != -1)
+		GOTO_FAIL("copied dynamic field creation should fail when straddling dynfield3");
+#endif
+
 	ret = rte_mbuf_dynflag_register(&dynflag_fail_flag);
 	if (ret != -1)
 		GOTO_FAIL("dynamic flag creation should fail (invalid flag)");
@@ -2693,13 +2740,29 @@ test_mbuf_dyn(struct rte_mempool *pktmbuf_pool)
 	if (*RTE_MBUF_DYNFIELD(m, offset2, uint16_t *) != 1000)
 		GOTO_FAIL("failed to read dynamic field");
 
+#if RTE_MBUF_DYNFIELD3_SIZE > 0
+	*RTE_MBUF_DYNFIELD(m, dynfield3_no_copy_offset, uint64_t *) =
+		UINT64_C(0x8877665544332211);
+	mc = rte_pktmbuf_alloc(pktmbuf_pool);
+	if (mc == NULL)
+		GOTO_FAIL("Cannot allocate mbuf for dynamic field copy test");
+	*RTE_MBUF_DYNFIELD(mc, dynfield3_no_copy_offset, uint64_t *) =
+		UINT64_C(0xa5a5a5a5a5a5a5a5);
+	rte_mbuf_dynfield_copy(mc, m);
+	if (*RTE_MBUF_DYNFIELD(mc, dynfield3_no_copy_offset, uint64_t *) !=
+			UINT64_C(0xa5a5a5a5a5a5a5a5))
+		GOTO_FAIL("copied no-copy dynfield3 dynamic field");
+#endif
+
 	/* set a dynamic flag */
 	m->ol_flags |= (1ULL << flag);
 
 	rte_mbuf_dyn_dump(stdout);
+	rte_pktmbuf_free(mc);
 	rte_pktmbuf_free(m);
 	return 0;
 fail:
+	rte_pktmbuf_free(mc);
 	rte_pktmbuf_free(m);
 	return -1;
 }
@@ -2776,8 +2839,9 @@ test_mbuf(void)
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
index 344f68822b..a6bd25b9ac 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -384,6 +384,8 @@ dpdk_conf.set('RTE_LIBEAL_USE_HPET', get_option('use_hpet'))
 dpdk_conf.set('RTE_ENABLE_STDATOMIC', get_option('enable_stdatomic'))
 dpdk_conf.set('RTE_ENABLE_TRACE_FP', get_option('enable_trace_fp'))
 dpdk_conf.set('RTE_PKTMBUF_HEADROOM', get_option('pkt_mbuf_headroom'))
+mbuf_dynfield3_size = get_option('mbuf_dynfield3_size')
+dpdk_conf.set('RTE_MBUF_DYNFIELD3_SIZE', mbuf_dynfield3_size)
 # values which have defaults which may be overridden
 dpdk_conf.set('RTE_MAX_VFIO_GROUPS', 64)
 dpdk_conf.set('RTE_DRIVER_MEMPOOL_BUCKET_SIZE_KB', 64)
@@ -395,6 +397,9 @@ dpdk_conf.set10('RTE_IOVA_IN_MBUF', get_option('enable_iova_as_pa'))
 
 compile_time_cpuflags = []
 subdir(arch_subdir)
+if mbuf_dynfield3_size % dpdk_conf.get('RTE_CACHE_LINE_SIZE') != 0
+    error('mbuf_dynfield3_size must be a multiple of RTE_CACHE_LINE_SIZE')
+endif
 dpdk_conf.set('RTE_COMPILE_TIME_CPUFLAGS', ','.join(compile_time_cpuflags))
 
 # apply cross-specific options
diff --git a/devtools/test-meson-builds.sh b/devtools/test-meson-builds.sh
index 11e4be3f88..23115def8c 100755
--- a/devtools/test-meson-builds.sh
+++ b/devtools/test-meson-builds.sh
@@ -259,6 +259,9 @@ fi
 build build-x86-generic cc skipABI --buildtype=debug -Dcheck_includes=true \
 	-Dlibdir=lib -Dcpu_instruction_set=$generic_isa $use_shared
 
+build build-mbuf-dynfield3 cc skipABI --buildtype=debug \
+	-Dmbuf_dynfield3_size=256 $use_shared
+
 # 32-bit with default compiler
 if check_cc_flags '-m32' ; then
 	target_override='i386-pc-linux-gnu'
diff --git a/doc/guides/prog_guide/mbuf_lib.rst b/doc/guides/prog_guide/mbuf_lib.rst
index cf64add109..ca0efb99c1 100644
--- a/doc/guides/prog_guide/mbuf_lib.rst
+++ b/doc/guides/prog_guide/mbuf_lib.rst
@@ -234,6 +234,15 @@ The dynamic fields and flags are managed with the functions ``rte_mbuf_dyn*``.
 
 It is not possible to unregister fields or flags.
 
+The build option ``mbuf_dynfield3_size`` can add extra cache-line-aligned
+dynamic field storage to ``struct rte_mbuf``.  This increases every mbuf by
+the configured amount and changes the mbuf layout, so applications and
+secondary processes must be built with the same value as the primary process.
+The option defaults to ``0``.  The extra storage is reserved for dynamic
+fields registered with ``RTE_MBUF_DYNFIELD_F_NO_COPY``.  These fields are not
+copied by mbuf copy and clone operations.  Dynamic fields registered without
+this flag continue to use the existing copied dynamic-field storage.
+
 .. _direct_indirect_buffer:
 
 Direct and Indirect Buffers
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index dec96ccbc7..cff68d7034 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -60,6 +60,22 @@ New Features
   Added the experimental ``rte_cpu_socket_id()`` function
   to map an OS logical CPU ID to the NUMA socket containing that CPU.
 
+* **Added optional extra mbuf dynamic field storage.**
+
+  Added ``mbuf_dynfield3_size`` build option to enable a
+  cache-line-aligned ``dynfield3`` area in ``struct rte_mbuf``.
+  The configured size is defined as ``RTE_MBUF_DYNFIELD3_SIZE``
+  in ``rte_build_config.h``.
+  The extra storage is reserved for dynamic fields registered with
+  ``RTE_MBUF_DYNFIELD_F_NO_COPY``.
+  These fields are not copied by generic mbuf copy and clone operations.
+  Dynamic fields registered without this flag continue to use the existing
+  copied dynamic-field storage.
+  Applications and secondary processes must be built with the same
+  non-zero value as the primary process.
+  The ``mempool/octeontx`` driver is disabled when this option is
+  enabled because it requires a fixed 128-byte mbuf header.
+
 * **Added TPID support to VLAN tag insertion.**
 
   Added ``rte_vlan_insert_tpid()`` to the net library.
@@ -338,7 +354,6 @@ Known Issues
    Also, make sure to start the actual text at the margin.
    =======================================================
 
-
 Tested Platforms
 ----------------
 
diff --git a/drivers/mempool/octeontx/meson.build b/drivers/mempool/octeontx/meson.build
index 3ccecac75d..01aece94be 100644
--- a/drivers/mempool/octeontx/meson.build
+++ b/drivers/mempool/octeontx/meson.build
@@ -6,6 +6,11 @@ if not is_linux or not dpdk_conf.get('RTE_ARCH_64')
     reason = 'only supported on 64-bit Linux'
     subdir_done()
 endif
+if get_option('mbuf_dynfield3_size') != 0
+    build = false
+    reason = 'requires sizeof(struct rte_mbuf) <= 128'
+    subdir_done()
+endif
 
 sources = files(
         'octeontx_fpavf.c',
diff --git a/lib/mbuf/rte_mbuf_core.h b/lib/mbuf/rte_mbuf_core.h
index 98b0bd9ca7..b4f204b268 100644
--- a/lib/mbuf/rte_mbuf_core.h
+++ b/lib/mbuf/rte_mbuf_core.h
@@ -686,6 +686,12 @@ struct __rte_cache_aligned rte_mbuf {
 	uint16_t timesync;
 
 	uint32_t dynfield1[9]; /**< Reserved for dynamic fields. */
+
+#if RTE_MBUF_DYNFIELD3_SIZE > 0
+	alignas(RTE_CACHE_LINE_SIZE)
+	uint64_t dynfield3[RTE_MBUF_DYNFIELD3_SIZE / sizeof(uint64_t)];
+	/**< Reserved cache-line-aligned space for dynamic fields. */
+#endif /* RTE_MBUF_DYNFIELD3_SIZE > 0 */
 };
 
 /**
diff --git a/lib/mbuf/rte_mbuf_dyn.c b/lib/mbuf/rte_mbuf_dyn.c
index 5987c9dee8..7cecbc9ee6 100644
--- a/lib/mbuf/rte_mbuf_dyn.c
+++ b/lib/mbuf/rte_mbuf_dyn.c
@@ -3,6 +3,7 @@
  */
 
 #include <stdalign.h>
+#include <stddef.h>
 #include <sys/queue.h>
 #include <stdint.h>
 #include <limits.h>
@@ -51,7 +52,7 @@ struct mbuf_dyn_shm {
 	 * The value is the size of the biggest aligned element that
 	 * can fit in the zone.
 	 */
-	uint8_t free_space[sizeof(struct rte_mbuf)];
+	uint16_t free_space[sizeof(struct rte_mbuf)];
 	/** Bitfield of available flags. */
 	uint64_t free_flags;
 };
@@ -135,6 +136,9 @@ init_shared_mem(void)
 #if !RTE_IOVA_IN_MBUF
 		mark_free(dynfield2);
 #endif
+#if RTE_MBUF_DYNFIELD3_SIZE > 0
+		mark_free(dynfield3);
+#endif
 
 		/* init free_flags */
 		for (mask = RTE_MBUF_F_FIRST_FREE; mask <= RTE_MBUF_F_LAST_FREE; mask <<= 1)
@@ -147,11 +151,48 @@ init_shared_mem(void)
 }
 
 /* check if this offset can be used */
+static bool
+dynfield_in_dynfield3(size_t offset, size_t size)
+{
+#if RTE_MBUF_DYNFIELD3_SIZE > 0
+	size_t dynfield3_offset = offsetof(struct rte_mbuf, dynfield3);
+
+	return offset >= dynfield3_offset &&
+		size <= sizeof(((struct rte_mbuf *)0)->dynfield3) &&
+		offset - dynfield3_offset <= sizeof(((struct rte_mbuf *)0)->dynfield3) - size;
+#else
+	RTE_SET_USED(offset);
+	RTE_SET_USED(size);
+	return false;
+#endif
+}
+
+static bool
+dynfield_overlaps_dynfield3(size_t offset, size_t size)
+{
+#if RTE_MBUF_DYNFIELD3_SIZE > 0
+	size_t dynfield3_offset = offsetof(struct rte_mbuf, dynfield3);
+	size_t dynfield3_end = dynfield3_offset + sizeof(((struct rte_mbuf *)0)->dynfield3);
+
+	return offset < dynfield3_end && offset + size > dynfield3_offset;
+#else
+	RTE_SET_USED(offset);
+	RTE_SET_USED(size);
+	return false;
+#endif
+}
+
 static int
-check_offset(size_t offset, size_t size, size_t align)
+check_offset(size_t offset, size_t size, size_t align, unsigned int flags)
 {
 	size_t i;
 
+	if ((flags & RTE_MBUF_DYNFIELD_F_NO_COPY) != 0 &&
+			!dynfield_in_dynfield3(offset, size))
+		return -1;
+	if ((flags & RTE_MBUF_DYNFIELD_F_NO_COPY) == 0 &&
+			dynfield_overlaps_dynfield3(offset, size))
+		return -1;
 	if ((offset & (align - 1)) != 0)
 		return -1;
 	if (offset + size > sizeof(struct rte_mbuf))
@@ -268,7 +309,7 @@ __rte_mbuf_dynfield_register_offset(const struct rte_mbuf_dynfield *params,
 		     offset < sizeof(struct rte_mbuf);
 		     offset++) {
 			if (check_offset(offset, params->size,
-						params->align) == 0 &&
+						params->align, params->flags) == 0 &&
 					shm->free_space[offset] < best_zone) {
 				best_zone = shm->free_space[offset];
 				req = offset;
@@ -279,7 +320,8 @@ __rte_mbuf_dynfield_register_offset(const struct rte_mbuf_dynfield *params,
 			return -1;
 		}
 	} else {
-		if (check_offset(req, params->size, params->align) < 0) {
+		if (check_offset(req, params->size, params->align,
+				params->flags) < 0) {
 			rte_errno = EBUSY;
 			return -1;
 		}
@@ -342,7 +384,7 @@ rte_mbuf_dynfield_register_offset(const struct rte_mbuf_dynfield *params,
 		rte_errno = EINVAL;
 		return -1;
 	}
-	if (params->flags != 0) {
+	if ((params->flags & ~RTE_MBUF_DYNFIELD_F_NO_COPY) != 0) {
 		rte_errno = EINVAL;
 		return -1;
 	}
@@ -573,7 +615,7 @@ void rte_mbuf_dyn_dump(FILE *out)
 	for (i = 0; i < sizeof(struct rte_mbuf); i++) {
 		if ((i % 8) == 0)
 			fprintf(out, "  %4.4zx: ", i);
-		fprintf(out, "%2.2x%s", shm->free_space[i],
+		fprintf(out, "%4.4x%s", shm->free_space[i],
 			(i % 8 != 7) ? " " : "\n");
 	}
 	fprintf(out, "Free bit in mbuf->ol_flags (0 = occupied, 1 = free):\n");
diff --git a/lib/mbuf/rte_mbuf_dyn.h b/lib/mbuf/rte_mbuf_dyn.h
index 20ce505bb4..d9a46b3c33 100644
--- a/lib/mbuf/rte_mbuf_dyn.h
+++ b/lib/mbuf/rte_mbuf_dyn.h
@@ -69,6 +69,7 @@
 #include <stdio.h>
 #include <stdint.h>
 
+#include <rte_bitops.h>
 #include <rte_stdatomic.h>
 
 #ifdef __cplusplus
@@ -80,6 +81,14 @@ extern "C" {
  */
 #define RTE_MBUF_DYN_NAMESIZE 64
 
+/**
+ * Do not copy this dynamic field during mbuf clone or copy.
+ *
+ * Fields using this flag are allocated from the optional dynfield3 area
+ * configured by the mbuf_dynfield3_size build option.
+ */
+#define RTE_MBUF_DYNFIELD_F_NO_COPY RTE_BIT32(0)
+
 /**
  * Structure describing the parameters of a mbuf dynamic field.
  */
@@ -87,7 +96,7 @@ struct rte_mbuf_dynfield {
 	char name[RTE_MBUF_DYN_NAMESIZE]; /**< Name of the field. */
 	size_t size;        /**< The number of bytes to reserve. */
 	size_t align;       /**< The alignment constraint (power of 2). */
-	unsigned int flags; /**< Reserved for future use, must be 0. */
+	unsigned int flags; /**< Dynamic field flags. */
 };
 
 /**
diff --git a/meson_options.txt b/meson_options.txt
index e28d24054c..1248498a3d 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -44,6 +44,8 @@ option('max_numa_nodes', type: 'string', value: 'default', description:
        'Set the highest NUMA node supported by EAL; "default" is different per-arch, "detect" detects the highest NUMA node on the build machine.')
 option('enable_iova_as_pa', type: 'boolean', value: true, description:
        'Support the use of physical addresses for IO addresses, such as used by UIO or VFIO in no-IOMMU mode. When disabled, DPDK can only run with IOMMU support for address mappings, but will have more space available in the mbuf structure.')
+option('mbuf_dynfield3_size', type: 'integer', min: 0, value: 0, description:
+       'Size of optional extra mbuf dynamic field area, in bytes.')
 option('mbuf_refcnt_atomic', type: 'boolean', value: true, description:
        'Atomically access the mbuf refcnt.')
 option('platform', type: 'string', value: 'native', description:
-- 
2.35.6

