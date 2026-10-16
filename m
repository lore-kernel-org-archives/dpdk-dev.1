Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D0DCCA490
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 22:32:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A87D840615;
	Sat, 17 Oct 2026 00:32:09 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id CFADE40615
 for <dev@dpdk.org>; Sat, 17 Oct 2026 00:32:08 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-cc52c1b8286so327507a12.1
 for <dev@dpdk.org>; Fri, 16 Oct 2026 15:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792189928;
 x=1792794728; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oDALe+ba4O56Bl2xN+5KIa6El6cHsSJjqJqDmmYHpWA=;
 b=n7LiQiQdyltKbQdql8Wc+NYocog9incgB49npVDgVsRm/tZ8a0GEMHPhnLxYFfL2i7
 vAGsnE709bC8f+OgUaDrtWg5TG36H6kF9IpoM57PZHUfydhXqFXXTTTzSjJ3CICBxywU
 ipZMyYKKknyiESXIA4r1/HOG+7hvRakOr7HthrL7TfR7KPtGRdgHLVCNA6Pb1zGcqJ+F
 zQOKr2Izmo94EDJVcTjarp+hyex5amLcX3+am4dFFIi2GPB1nACbeQDyRml+uwpWEd8S
 QHpv43jdtaitEZU8KzOWi4f1Eo+HIvItjAav3YZi7baY9J8m1FhhUQWnhnHN+/4O4qTU
 2RWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792189928; x=1792794728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oDALe+ba4O56Bl2xN+5KIa6El6cHsSJjqJqDmmYHpWA=;
 b=XvTA/89vStMCIp1D35D3Du7dA2lHQXPODIsHtWxF9n79pAQ6Ufwy1u7hcEDQFFfoAV
 9F6EkkdkmbtpDTiKlrfE3SMvTzdIMb0Bmg/arKctNf7t4Rq+ZiUao3JwwDbGwpAgRywg
 sMkcK1cARUnTFmbiHV9UluECEfzaCurzy4GuHp7g+d3BHi3sCfy+DS2EeTg3jEpKk9MK
 fk9ClkIfLws+xS3dyi9RP3CvehCXiLil7hSJP9JP9kF1A15EAdXIJhBFTSUrTaovQK+l
 gFMpz/Jwd7nBgyd/xe54Rkwzg1Z51N5p+Zq9kciXsCwMb6JySTClRf6N94h/hFgJFpd1
 Im2A==
X-Gm-Message-State: AFq9FYImAlFEYnPshZTCLrN4E5P4gypHw4muxYxhLk3UkpLZHiA40kyk
 YDr6sApYQQ/55Lyg7pjzTAZs/FJXDmPnXOdaX7uiUmTeZP/6oI/YXRfG8hMQP0ychOSOzepHwi+
 t/qPoF8U=
X-Gm-Gg: AYBFou22Ef2+cUGRzM9HYJ/6zVjWtM8XoIQyfzAcSn5huk9t6GY/mgrGSu4f0Pt6sIG
 tXWDEYlLg518xkZhxUm0VaJpb9LLLKpwXNi4zd2e6OY5ZUhF9p9804eUXBeKUOIifBzqdN9Qz1u
 2uqQPt1sMWJJKvjtvkb/w1PPTep6sjIqehB+EValf3drHMZ3R33QOhfL+CS/IJ44U2o6ZvRvLhF
 DvQ0YFDOr3a+xnJBOC5vgK5VyP2WNOzKgKjC8144vg+VqA4R5xj+bJBvtxEMZYuX65DwGAJigNM
 YO4/9yPj4Wr1z4e2R0KrxwMoJoz/rFYtFvDJK1E7t0IzMuyzsdDjoLQd+bFMLxmSeRmLRBWBb7X
 UIGtAZzI6P07/zH+VX+UUYDXsiMgxNbkHiwq4EPJJfzAWyX8qcV3zGbWZ1nnBIXyF6Fazim7BFx
 nVFWLAc67hQY0hhkvLHzxWDTf6EBJJYbzWOS7tOU36lpv9Meo8/hgxVUcjudZHtxOwt5cBF5Yoh
 51XfudRXAb9+A/1GTZuEs7ysKsHb7srTfViQA==
X-Received: by 2002:a17:90b:3c90:b0:3ab:b39f:41ca with SMTP id
 98e67ed59e1d1-3acef518d8amr545125a91.31.1792189927543; 
 Fri, 16 Oct 2026 15:32:07 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac9461d71esm10827348a91.7.2026.10.16.15.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 15:32:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v5 2/4] eal: add --no-capture option
Date: Fri, 16 Oct 2026 15:30:32 -0700
Message-ID: <20261016223201.608942-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016223201.608942-1-stephen@networkplumber.org>
References: <20260727224417.1419663-1-stephen@networkplumber.org>
 <20261016223201.608942-1-stephen@networkplumber.org>
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

Not every deployment wants packet capture available. The capture library
registers its telemetry commands from a constructor, before EAL has parsed
arguments, so it cannot decline to register; add an EAL option and have the
library refuse at use instead.

Capture is reached over the telemetry socket, so --no-telemetry implies
--no-capture.

The option is per-process like --no-telemetry: a secondary started with it
refuses to attach callbacks, and the primary treats that refusal as a
configured choice rather than an error.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/linux_gsg/eal_args.include.rst |  4 ++++
 doc/guides/prog_guide/capture_lib.rst     |  3 +++
 lib/capture/capture.c                     |  5 +++++
 lib/capture/multiproc.c                   | 11 ++++++++---
 lib/eal/common/eal_common_config.c        |  7 +++++++
 lib/eal/common/eal_common_options.c       |  3 +++
 lib/eal/common/eal_internal_cfg.h         |  1 +
 lib/eal/common/eal_option_list.h          |  1 +
 lib/eal/include/rte_eal.h                 |  9 +++++++++
 9 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/doc/guides/linux_gsg/eal_args.include.rst b/doc/guides/linux_gsg/eal_args.include.rst
index 32c24c8e41..7925084c5c 100644
--- a/doc/guides/linux_gsg/eal_args.include.rst
+++ b/doc/guides/linux_gsg/eal_args.include.rst
@@ -293,6 +293,10 @@ Other options
 
     Disable telemetry.
 
+*   ``--no-capture``:
+
+    Disable packet capture. Implied by ``--no-telemetry``.
+
 *   ``--force-max-simd-bitwidth=<val>``:
 
     Specify the maximum SIMD bitwidth size to handle. This limits which vector paths,
diff --git a/doc/guides/prog_guide/capture_lib.rst b/doc/guides/prog_guide/capture_lib.rst
index 43823ffc87..bafa194fd4 100644
--- a/doc/guides/prog_guide/capture_lib.rst
+++ b/doc/guides/prog_guide/capture_lib.rst
@@ -67,6 +67,9 @@ Requirements
   commands if the call does not work at startup, so capture is simply
   unavailable rather than unsafe.
 
+* Capture can be refused at runtime with the ``--no-capture`` EAL option,
+  which is also implied by ``--no-telemetry``.
+
 Telemetry commands
 ------------------
 
diff --git a/lib/capture/capture.c b/lib/capture/capture.c
index 62b95c9de4..af5800017f 100644
--- a/lib/capture/capture.c
+++ b/lib/capture/capture.c
@@ -384,6 +384,11 @@ capture_start_req(const char *cmd, const char *params, struct rte_tel_data *d)
 		return -1;
 	}
 
+	if (!rte_eal_has_capture()) {
+		capture_err(d, "capture disabled by --no-capture");
+		return 0;
+	}
+
 	/* Note: params is const so need non-const copy for parsing
 	 * Alternative would be to change telemetry to allow this.
 	 */
diff --git a/lib/capture/multiproc.c b/lib/capture/multiproc.c
index ab29710210..9de9d8117e 100644
--- a/lib/capture/multiproc.c
+++ b/lib/capture/multiproc.c
@@ -70,6 +70,10 @@ capture_mp_attach(struct capture *cap)
 	struct rte_eth_dev_info dev_info;
 	uint16_t num_queues;
 
+	/* each process decides for itself */
+	if (!rte_eal_has_capture())
+		return -EPERM;
+
 	if (rte_eth_dev_info_get(cap->port_id, &dev_info) < 0)
 		return -EINVAL;
 
@@ -223,10 +227,11 @@ capture_mp_broadcast(struct capture *cap, enum capture_mp_op op)
 			= (const struct capture_mp_response *)mp_reply.msgs[i].param;
 
 		/*
-		 * A secondary that has no callbacks to detach replies ENOENT,
-		 * which happens whenever it was not polling this port.
+		 * ENOENT: nothing to detach, it was not polling this port.
+		 * EPERM: started with --no-capture, which is not an error.
 		 */
-		if (resp->err != 0 && resp->err != -ENOENT) {
+		if (resp->err != 0 && resp->err != -ENOENT &&
+		    resp->err != -EPERM) {
 			CAPTURE_LOG(ERR, "Secondary could not %s capture: %s",
 				    op == CAPTURE_MP_START ? "start" : "stop",
 				    rte_strerror(-resp->err));
diff --git a/lib/eal/common/eal_common_config.c b/lib/eal/common/eal_common_config.c
index e2e69a75fb..953a5f7ef8 100644
--- a/lib/eal/common/eal_common_config.c
+++ b/lib/eal/common/eal_common_config.c
@@ -109,3 +109,10 @@ rte_eal_has_pci(void)
 {
 	return !internal_config.no_pci;
 }
+
+RTE_EXPORT_SYMBOL(rte_eal_has_capture)
+int
+rte_eal_has_capture(void)
+{
+	return !internal_config.no_capture;
+}
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index b2c0744447..3c347e1a01 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -2350,6 +2350,9 @@ eal_parse_args(void)
 		int_cfg->no_shconf = 1;
 	if (args.no_telemetry)
 		int_cfg->no_telemetry = 1;
+	/* capture is reached over the telemetry socket, so it goes with it */
+	if (args.no_capture || args.no_telemetry)
+		int_cfg->no_capture = 1;
 	if (args.match_allocations)
 		int_cfg->match_allocations = 1;
 	if (args.create_uio_dev)
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 07cd35167d..27e3a7990f 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -109,6 +109,7 @@ struct internal_config {
 	volatile unsigned int init_complete;
 	/**< indicates whether EAL has completed initialization */
 	unsigned int no_telemetry; /**< true to disable Telemetry */
+	unsigned int no_capture; /**< true to disable packet capture */
 	struct simd_bitwidth max_simd_bitwidth;
 	/**< max simd bitwidth path to use */
 	size_t huge_worker_stack_size; /**< worker thread stack size */
diff --git a/lib/eal/common/eal_option_list.h b/lib/eal/common/eal_option_list.h
index b72f243cc6..c8a1665d44 100644
--- a/lib/eal/common/eal_option_list.h
+++ b/lib/eal/common/eal_option_list.h
@@ -53,6 +53,7 @@ STR_ARG("--memory-channels", "-n", "Number of memory channels per socket", memor
 STR_ARG("--memory-ranks", "-r", "Force number of memory ranks (don't detect)", memory_ranks)
 STR_ARG("--memory-size", "-m", "Total size of memory to allocate initially", memory_size)
 BOOL_ARG("--no-auto-probing", "-A", "Do not probe any devices unless some -a option is set", no_auto_probing)
+BOOL_ARG("--no-capture", NULL, "Disable packet capture", no_capture)
 BOOL_ARG("--no-hpet", NULL, "Disable HPET timer", no_hpet)
 BOOL_ARG("--no-huge", NULL, "Disable hugetlbfs support", no_huge)
 BOOL_ARG("--no-pci", NULL, "Disable all PCI devices", no_pci)
diff --git a/lib/eal/include/rte_eal.h b/lib/eal/include/rte_eal.h
index 7241f3be5d..ded7be9196 100644
--- a/lib/eal/include/rte_eal.h
+++ b/lib/eal/include/rte_eal.h
@@ -392,6 +392,15 @@ int rte_eal_has_hugepages(void);
  */
 int rte_eal_has_pci(void);
 
+/**
+ * Whether packet capture is allowed.
+ * Disabled by the --no-capture and --no-telemetry options.
+ *
+ * @return
+ *   Nonzero if capture is enabled.
+ */
+int rte_eal_has_capture(void);
+
 /**
  * Whether the EAL was asked to create UIO device.
  *
-- 
2.53.0

