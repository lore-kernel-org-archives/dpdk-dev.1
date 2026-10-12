Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234EFCC6B04
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 21:10:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48634406BC;
	Mon, 12 Oct 2026 23:10:13 +0200 (CEST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id DC6614064E
 for <dev@dpdk.org>; Mon, 12 Oct 2026 23:10:11 +0200 (CEST)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-49ff680331aso18505025e9.3
 for <dev@dpdk.org>; Mon, 12 Oct 2026 14:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791839411; x=1792444211; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lOcJO4KNR6NBoVTesN4s6tNJTB+zBR8y82Gvk5fMt5g=;
 b=Wq1vdX1JhvWW7WZumxUEnoMtdwGviUeiGC5EdF7g98U45ZwswVZwfjvR4fjOonOSKQ
 r9XAF6QS1CuX8jaEbZwIzs92lYV2aYhtut20zfuPe/jDUMbJRiPmio/qeL+93xh/W5cm
 mzHFeKJDzDv7vtznTpSUEToI30xLquH5YklnaUwcxcDS4I35UMWHcnA1Jc+iPL4lvBUG
 ynHIiwyfh+TAZXHQnk/xHSHAt6LaSq8By53GQlWPLVnGVh9EM5PlhdDXCqBsRyTJIAAj
 WPGMwwsF03Z/y+nrUxQjBs+TG+sL9vjAuddziZ2ereQoC3Cd5QMVKQ8zhzsFA9o1y8LH
 pAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791839411; x=1792444211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lOcJO4KNR6NBoVTesN4s6tNJTB+zBR8y82Gvk5fMt5g=;
 b=yb6rjQKcCNa3RjQnsj19Rsx0NFt8X8CHcOEx/xaUbahNF/HrtkMZ2SHHQ3PW8UhEJS
 u/EeQP0VU+mJXYzxStjGXDyhw6dmKXQTuXOBs77kekACkzmcHSjzY7C62waM4gOPke5e
 OxxhLEawGDlddFlfEmoDdQtFJuBsrYPU6lQRR7vsVPoZbK5rsEuV5xhtUeI1s5y05Bpi
 CYBYcH4O9lQe2xWTsU9+6FeeUp/rusAV+6AtiuWk6rr1nxAeTR4dfQj+aWY65xOV3sBw
 t/II85pFuLtJ2EvsL+6FwZOEZ9z+i1NgmSQd6LBj+lERjUuLePfbAsPUeDEHmDctWrf6
 OB2Q==
X-Gm-Message-State: AFq9FYLiE6a7p5eQKAUPRsWRQTTslq6cHeu8LhYU+Vv0dHUelC4NyQ4z
 3skmus8icZ9FIQUF8KxM3QaLqHsJHrGNjFLlypUqy1AU5X5T9sbq0eEg
X-Gm-Gg: AYBFou2KYSw1ikEeyc/UKnqv59StHhK6En6ob0iLnENPRf98d5qbojjqZc4NIeyQp1X
 9rTzQN7/qOecazR72182hJ41gLmrjvvpTHoUt6hV1j+K/1Zv29Q1ht7X+mi3Oj2bZVLcquBWUHi
 PulpdGZIZMhGGtkHVpuubCqwUbJh1e3N9FJ4Uwi1YaUUVEbTzXTSKYT7ZO5DKq9WMT68h4EZAds
 PZ3tbfC5OL8FblHkM4avd2uXGN7nG23Q8VBvEgdbA8+3gn50eGKfSNXfk/4Ld5LowbgT0L9iKqT
 adiKvN1iCGh86VeIjCW2d5ZR0QIE8igQLYEQdNs0OycUOyro4hhhD5A94sUjJ1GbB3TZBOxdBm4
 L3xLreNd+pL3xwbSccyCsbFXotJkQrYtRyd7p/Iq9Pdxh5tMwuBXItadZCjSc6q/42prypUpxAz
 Kvuf2h06A7OBJh205xcg3hbUbi9UEAiYpaJFEY28iuPSrdgvqhx13XFEgIIAs=
X-Received: by 2002:a05:600c:8b64:b0:49d:174e:2a1e with SMTP id
 5b1f17b1804b1-4a18e498851mr210621715e9.19.1791839411429; 
 Mon, 12 Oct 2026 14:10:11 -0700 (PDT)
Received: from dpdk.lxd ([80.233.57.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf2caf4sm342208725e9.10.2026.10.12.14.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 14:10:10 -0700 (PDT)
From: Marat Khalili <qm2k21@gmail.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
Cc: dev@dpdk.org,
	stephen@networkplumber.org
Subject: [PATCH v2 9/9] bpf: add callback flag to skip multi-thread check
Date: Mon, 12 Oct 2026 21:09:16 +0000
Message-ID: <20261012210917.161343-10-qm2k21@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012210917.161343-1-qm2k21@gmail.com>
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261012210917.161343-1-qm2k21@gmail.com>
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

Add RTE_BPF_ETH_F_SKIP_MT_CHECK flag allowing callers to bypass the
suitability check when installing BPF packet callbacks.

This allows overriding rejections in cases where the port or queue is
configured with multi-thread capabilities (such as MT_LOCKFREE),
but the application guarantees that only one dataplane thread
accesses the queue at a time.

Update the unit test to verify that callback installation succeeds
when this flag is specified, and add a release note documenting the
restriction and the override flag.

Signed-off-by: Marat Khalili <qm2k21@gmail.com>
---
 app/test/test_bpf.c                    | 20 ++++++++++++++++++++
 doc/guides/rel_notes/release_26_11.rst |  5 +++++
 lib/bpf/bpf_pkt.c                      |  8 +++++---
 lib/bpf/rte_bpf_ethdev.h               |  5 ++++-
 4 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 02523984b5..0ab8aa8759 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -4692,7 +4692,27 @@ test_bpf_elf_tx_mt_lockfree(load_elf_image_t load_elf_image)
 		goto fail;
 	}
 
+	/* Tx installation must succeed when check is skipped with flag */
+	ret = rte_bpf_eth_tx_install(port, 0, bpf, RTE_BPF_ETH_F_SKIP_MT_CHECK);
+	if (ret != 0) {
+		printf("%s@%d: expected rte_bpf_eth_tx_install with SKIP_MT_CHECK to succeed, got %d\n",
+		       __func__, __LINE__, ret);
+		ret = TEST_FAILED;
+		goto fail;
+	}
+	rte_bpf_eth_tx_unload(port, 0);
+	bpf = NULL;
+
 	/* Rx installation on the same port must still succeed */
+	bpf = load_elf_image(app_test_bpf_filter_o, app_test_bpf_filter_o_len, "filter",
+			     NULL, 0, &prog_arg);
+	if (bpf == NULL) {
+		printf("%s@%d: failed to load BPF filter image\n",
+		       __func__, __LINE__);
+		ret = TEST_FAILED;
+		goto fail;
+	}
+
 	ret = rte_bpf_eth_rx_install(port, 0, bpf, 0);
 	if (ret != 0) {
 		printf("%s@%d: expected rte_bpf_eth_rx_install to succeed, got %d\n",
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index e282fa5581..a0a0161e39 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -366,6 +366,11 @@ API Changes
     ``rte_event_port_profile_links_get`` and
     ``rte_event_port_profile_unlink``
 
+* bpf: BPF packet callbacks can no longer be installed on
+  ``RTE_ETH_TX_OFFLOAD_MT_LOCKFREE`` ports and queues to prevent race
+  conditions on unload, but this safety feature can be overridden with
+  the new ``RTE_BPF_ETH_F_SKIP_MT_CHECK`` flag.
+
 * reorder: Promoted the following API from experimental to stable:
   ``rte_reorder_seqn``, ``rte_reorder_drain_up_to_seqn``,
   ``rte_reorder_min_seqn_set`` and ``rte_reorder_memory_footprint_get``.
diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index 0b59ce22f1..7ccc8daa88 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -602,9 +602,11 @@ bpf_eth_elf_install(struct bpf_eth_cbh *cbh, uint16_t port, uint16_t queue,
 	if (bpf->prm.nb_prog_arg != 1)
 		return -EINVAL;
 
-	rc = bpf_eth_check_mt(cbh, port, queue);
-	if (rc != 0)
-		return rc;
+	if ((flags & RTE_BPF_ETH_F_SKIP_MT_CHECK) == 0) {
+		rc = bpf_eth_check_mt(cbh, port, queue);
+		if (rc != 0)
+			return rc;
+	}
 
 	if (cbh->type == BPF_ETH_RX)
 		frx = select_rx_callback(bpf->prm.prog_arg[0].type, flags);
diff --git a/lib/bpf/rte_bpf_ethdev.h b/lib/bpf/rte_bpf_ethdev.h
index cf3b4048f0..7a9f87e6cb 100644
--- a/lib/bpf/rte_bpf_ethdev.h
+++ b/lib/bpf/rte_bpf_ethdev.h
@@ -13,7 +13,8 @@
  * - in the data plane, it expects only one thread per port/queue pair at a time.
  *   Calling RX/TX burst functions concurrently on the same queue (e.g. when using
  *   RTE_ETH_TX_OFFLOAD_MT_LOCKFREE, shared RX queues, or multi-threaded
- *   software PMDs) is not supported.
+ *   software PMDs) is not supported and will be rejected at installation time
+ *   unless overridden by RTE_BPF_ETH_F_SKIP_MT_CHECK.
  * - in the control plane, it is not MT safe, i.e. it is not allowed to do
  *   load/unload for the same port/queue from different threads in parallel.
  * - though it allows load/unload at runtime
@@ -37,6 +38,8 @@ extern "C" {
 enum {
 	RTE_BPF_ETH_F_NONE = 0,
 	RTE_BPF_ETH_F_JIT  = 0x1, /**< use compiled into native ISA code */
+	RTE_BPF_ETH_F_SKIP_MT_CHECK = 0x2,
+	/**< skip check for concurrent data plane thread usage */
 };
 
 /**
-- 
2.43.0

