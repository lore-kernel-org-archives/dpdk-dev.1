Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434C1CA9ED0
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 21:09:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EC78402DB;
	Mon, 12 Oct 2026 23:09:52 +0200 (CEST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 32E80402C8
 for <dev@dpdk.org>; Mon, 12 Oct 2026 23:09:51 +0200 (CEST)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a172eb31f0so17095795e9.1
 for <dev@dpdk.org>; Mon, 12 Oct 2026 14:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791839391; x=1792444191; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dta+FCZ/l64EsAM7LFslwMPscZcnEsyk3AhFM56XajM=;
 b=JFu/cU39TsAbnBobZAfr1i56qjOT0IvVw0GGVWadhtX1125mkVDHHb+nTb+r+RUjo7
 78GM3mX0GBsCc4sWMbbmd2v5dUFWAqt6k3p0ZRU9ikKxRbKAmR8rYJu622MPndJ/5uGF
 zhl/v+Ch03PTHKG8a16tbdrF3VGG2qOND1hVjrsxyYOmMBgVRnjrfUNnqAT0pwkPXY9P
 7drArm6DX/0oWE7MMZKCHPPm3TN81RzgyyYM1i8GL+bw/q8PHTWHTwN3+SO67QuizOhg
 lS67tYc0IbNXyYfRXHz+qLoma6es9F9FX5WUkqNZxBUyxbN4Z2xr54hHj2xI88MYuMwS
 Ij8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791839391; x=1792444191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dta+FCZ/l64EsAM7LFslwMPscZcnEsyk3AhFM56XajM=;
 b=2vuFwnSHjWptOBT9d646JqsjYp9y66wdC1eKAr6KCUtMblBSMiQulXTtTzCzlShA5z
 YQKnEqkuU8Yj8Xr9acniXk7nrKCkABmUOKXAO4ibcE/IEfVwNkfYbP6lCq8fyBrvc7Fk
 6Ypcu61JXOTNGSaLwj/osP//NJ0pxVtvk0LzZH5S5tHJacVP358mV1kG4MCnK1RLkZtU
 QkaJEkIADYvYcytOTWhtubB/WnfbGCz+m9FQTi/WkrtK1445WNcWA7Z77iGbddDWwGiD
 HfkKds+5aqOvP73wEYdltGmcxvhhotSB9+42y7IUF9/rveQvL83P641zfeAiWVdqmMRY
 r4rQ==
X-Gm-Message-State: AFq9FYIhRxaqYurlDtapS3QYk5cyHydIAzeLPSBGk4T1NJ/pnfwl9EM9
 Hyi5dyxFaI5gjoVEwRMw+rTk3nM9jNluNVww38U64hQIZn+O0R1v6E+B
X-Gm-Gg: AYBFou3CMPym0yBNylzA8sMgdgMwGeaSkJgvs31E25178+NAL7X9Ka/jEsN25AcVWEc
 rJJu5Kmqnt+TtD8UI3XTv0Z2yqx+VGfpqh0KKkCJ/jVilar1egkp0+TI+2OQqgMICrjZyhzKaUO
 FcXmqdW7s4kfRSnwcAL9HUKEzCIV4F82AACGZXxDoOow8jF878nZ39wph6buRH6ZXrady0akqdV
 4JZ6PvWaObDrXv+81gRqETtNqlAdxfm2j/u36nbiOHMPuBqPx/oJ8ZeukylAYRXRo0bYU0df74I
 TBtbq2cSL+9F8ejwxZ4Tyf+uKlrbD7Vxm+3us9tt5WCIfrScjtZ6+PlMEQhp3S7PygLtqdtparw
 4rgngsLk5YM+GGMW1WZBYNRtMt41GhlLAG0gDyAu6lqNQyyP2sEXmmCkN4bZKSUhbeTHz9CMOvy
 k9FlBVNnEaPCdG0SuRQFnftzdWohWQCVVOBeOBFFTBlZ412cCmuL+x5drK2Qc=
X-Received: by 2002:a05:600c:c104:b0:4a1:96cd:2f73 with SMTP id
 5b1f17b1804b1-4a196cd32b0mr93485475e9.1.1791839390473; 
 Mon, 12 Oct 2026 14:09:50 -0700 (PDT)
Received: from dpdk.lxd ([80.233.57.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf2caf4sm342208725e9.10.2026.10.12.14.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 14:09:49 -0700 (PDT)
From: Marat Khalili <qm2k21@gmail.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
Cc: dev@dpdk.org,
	stephen@networkplumber.org
Subject: [PATCH v2 1/9] bpf: document packet callback unload sequence
Date: Mon, 12 Oct 2026 21:09:08 +0000
Message-ID: <20261012210917.161343-2-qm2k21@gmail.com>
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

Add a detailed comment with the sequence diagram to bpf_pkt.c describing
the current de-facto synchronization protocol on BPF program unload
between the control plane and the data plane.

Signed-off-by: Marat Khalili <qm2k21@gmail.com>
---
 lib/bpf/bpf_pkt.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index f072fdaaed..4223ef624e 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -21,9 +21,72 @@
 #include "bpf_impl.h"
 
 /*
- * information about installed BPF rx/tx callback
+ * CP-DP synchronization mechanism
+ *
+ * After the callback is installed to a port/queue, removing it safely is a non-trivial task.
+ * The `rte_bpf` object can only be destroyed while the callback is not being executed,
+ * while the number of synchronization calls in the packet callback must be minimized.
+ *
+ * APIs `rte_eth_remove_rx_callback` and `rte_eth_remove_tx_callback` remove the callback from
+ * the callback list and upon return guarantee that it will not be called again,
+ * but not that any existing invocation of the callback has completed.
+ *
+ * Current synchronization mechanism relies on the following per-port/queue entities:
+ * 1. List of installed port/queue callbacks ("cbs" on the diagram);
+ * 2. Member `cb` of struct `bpf_eth_cbi`;
+ * 3. Member `use` of struct `bpf_eth_cbi`;
+ *
+ * BPF program is only executed if the first two are set, and increments `use` at the start and
+ * end of the callback execution so that in the safe state its value is even.
+ * This relies on only one thread calling the per-port/queue callback at a time.
+ *
+ * Unload processing starts with clearing the first two entities,
+ * then waits for `use` to become even before destroying the BPF program.
+ * The whole operation is protected by a control-plane-only spinlock (not shown on the diagram).
+ *
+ * Typical sequence of synchronization actions between CP and DP on unload is shown below:
+ * ```
+ *   +----+                +-----+         +-----+        +----+         +-----+          +----+
+ *   | CP |                | cbs |         | use |        | cb |         | bpf |          | DP |
+ *   +----+                +-----+         +-----+        +----+         +-----+          +----+
+ *     |                      |               |              |              |                |
+ *     |                      |<---------------------- fetch callback -----------------------|
+ *     |                      |               |              |              |                |
+ *     |                      |               |<------------- increment to odd --------------|
+ *     |                      |               |              |              |                |
+ *     |-- remove callback -->|               |              |              |       rte_smp_mb()
+ *     |                      |               |              |              |                |
+ *     |                      |               |              |<------ fetch non-NULL --------|
+ *     |                      |               |              |              |                |
+ *     |------------------- store NULL --------------------->|              |                |
+ *     |                      |               |              |              |                |
+ *   rte_smp_mb()             |               |              |              |                |
+ *     |                      |               |              |              |                |
+ *   rte_smp_mb()             |               |              |              |                |
+ *     |                      |               |              |              |                |
+ *     +-if use is odd        |               |              |              | if cb not NULL-+
+ *     | |                    |               |              |              |              | |
+ *     | +------------ fetch odd ------------>|              |              |<-- execute --+ |
+ *     | |                    |               |              |              |  BPF program | |
+ *     | +-while use is same  |               |              |              |              +-+
+ *     | | |                  |               |              |              |                |
+ *     | | +---------- fetch odd ------------>|              |              |      rte_smp_rmb()
+ *     | | |                  |               |              |              |                |
+ *     +-+-+                  |               |<------------- increment to even -------------|
+ *     |                      |               |              |              |                |
+ *     |------------- fetch even ------------>|              |              |                |
+ *     |                      |               |              |              |                |
+ *     |----------------- destroy BPF program and cleanup ----------------->|                |
+ *     |                      |               |              |              |                |
+ *   +----+                +-----+         +-----+        +----+         +-----+          +----+
+ *   | CP |                | cbs |         | use |        | cb |         | bpf |          | DP |
+ *   +----+                +-----+         +-----+        +----+         +-----+          +----+
+ * ```
  */
 
+/*
+ * information about installed BPF rx/tx callback
+ */
 struct __rte_cache_aligned bpf_eth_cbi {
 	/* used by both data & control path */
 	RTE_ATOMIC(uint32_t) use;    /*usage counter */
-- 
2.43.0

