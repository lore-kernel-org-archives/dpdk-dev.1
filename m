Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E399ECA0EE4
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 16:53:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C48D427D7;
	Thu, 14 Aug 2025 18:53:29 +0200 (CEST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 0EB57427D1
 for <dev@dpdk.org>; Thu, 14 Aug 2025 18:53:27 +0200 (CEST)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-45a1b0d231eso6462325e9.3
 for <dev@dpdk.org>; Thu, 14 Aug 2025 09:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755190406;
 x=1755795206; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0aPTLmc496vzuZuJjV8xutwX6FyBeUmPZJiabxVkLsc=;
 b=wteL+uhio2aNciQzUrOXEtbGrLAWeWlqFlXdQ9fjVfT3fUu2V53MEvh5qQofS/rlT6
 fdmJeheyencpfaxjWa2aJdHDVKMzq76XvlrBZCgFg0rIdjG+cjvAy1B4qwbO4drl7AAL
 mVtl0uHKrFR8UZ0/lvr+YiMFwlL8uw6llGllQ5qcvSOFnISy8ju0ItJh2o4k7Hl1v/uQ
 LO3y0ppKztyz+XLeQXiKdOsr095/L0dJeAOB9zAU/eswnEwOAofO29YmuM9iRdabfeTU
 2JNyRB07st3cuw9opOdbyb7c/7zkSJSZwjVh3dAwniGYc/6Mw5baEeiW+OKvp9vJhJ/O
 6Xbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755190406; x=1755795206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0aPTLmc496vzuZuJjV8xutwX6FyBeUmPZJiabxVkLsc=;
 b=bzg0ttWuv0zM1TS3is8ngIu9o8nDwvL9LcQPR0PjTpcJNkXHakmhdudkjXznIVD2kr
 h4jKcN5G7Ut06GAYI3KKyFxxiMHW/OKCZ2EUIn027KHUu4xLWje7Tv7F8KoqDfagz6oN
 FpYYQqmpfi1a8fwddf/XEc57yuSP85qDJOm2Q4eJVnsNNseto/JOkSNDXyncVS/vXIMX
 iW61ysMejLYedvHBOxsPW+TU8r/+TBE6VBxvGTpqXULC/H89NYJbC5jfwchpy3jiwte9
 1qFZz/Ko4oZkzsNH90juDwogx7rGep7HIPONmwwL03WNe056NycFYvtibn31ESRCB8d6
 IwfQ==
X-Gm-Message-State: AOJu0YxIzZO2pavOEkToFuXFgXmm8iJY/Y9B85zmx3DzUMg0uoDIhZ/j
 HONs31MyjVgpITIV7C5tp2ootLe2VlXawg7szP6JZ51aD8d3IE4Y6dGzZQzeJuyjd23xyCyEZpL
 EUR9E
X-Gm-Gg: ASbGnct45k7mwjrtxa5PsqXWNAJtcLPl12Trs9JQVVckm5AHCerQiLGgQQ9K+qVF3XE
 iqNTwzhMDCOYFv37JVzH9zul9MccFUBCuLfh0ZL+wjnexC7Yo16OsdYBPajOkp9TgTkwMF33Rxg
 GCyzNFiI0mFKYtZwgj92LNAdsQuDdU8KD5QafUWl9KHwxaBV9MXfX7JU/JqF+SBC4kAV9ekvZYq
 xqOk/G31cWA/oe7rZwk6tQYS6b0pfXCbDyJucrlGj8RFspN2z0b1cRUC9ywXOVoT/mug2WMJATh
 1lp6ERBv0gu3KQopxgEYCjAXZXrrF+GKt/Fj2qAYs29wGs49YL+2PlnYRNXEL9GTl985OueC4xD
 6D7EtlblQvJ/LwmHJ0iLF158dEXPIfZLwdOv/+wZ7dNGVVLLPpuQb1dFWVV03aue4MjY+2xbG
X-Google-Smtp-Source: AGHT+IF/Z5470OXk+PexcZiOd7n4g2nATbnoAFnp5CFVMlTR+Hc9zSavtmsy5WkEZkxYeH19ZFOdQQ==
X-Received: by 2002:a5d:5f86:0:b0:3b7:8146:4640 with SMTP id
 ffacd0b85a97d-3ba50d87926mr3156441f8f.56.1755190406557; 
 Thu, 14 Aug 2025 09:53:26 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ba54f87e17sm1748197f8f.23.2025.08.14.09.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 09:53:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v2 7/8] pdump: remove use of VLA
Date: Thu, 14 Aug 2025 09:53:03 -0700
Message-ID: <20250814165307.12786-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250814165307.12786-1-stephen@networkplumber.org>
References: <20250811213632.16023-1-stephen@networkplumber.org>
 <20250814165307.12786-1-stephen@networkplumber.org>
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

Replace variable length array with alloca.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pdump/meson.build |  2 --
 lib/pdump/rte_pdump.c | 12 ++++++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/pdump/meson.build b/lib/pdump/meson.build
index 553dfdd5e6..da8d51b616 100644
--- a/lib/pdump/meson.build
+++ b/lib/pdump/meson.build
@@ -7,8 +7,6 @@ if is_windows
     subdir_done()
 endif
 
-cflags += no_wvla_cflag
-
 sources = files('rte_pdump.c')
 headers = files('rte_pdump.h')
 deps += ['ethdev', 'bpf', 'pcapng']
diff --git a/lib/pdump/rte_pdump.c b/lib/pdump/rte_pdump.c
index b95f7f863d..d201997b75 100644
--- a/lib/pdump/rte_pdump.c
+++ b/lib/pdump/rte_pdump.c
@@ -144,17 +144,21 @@ pdump_copy(uint16_t port_id, uint16_t queue,
 	unsigned int i;
 	int ring_enq;
 	uint16_t d_pkts = 0;
-	struct rte_mbuf *dup_bufs[nb_pkts];
+	struct rte_mbuf **dup_bufs;
 	struct rte_ring *ring;
 	struct rte_mempool *mp;
 	struct rte_mbuf *p;
-	uint64_t rcs[nb_pkts];
+	uint64_t *rcs = NULL;
 
-	if (cbs->filter)
+	if (cbs->filter) {
+		rcs = alloca(sizeof(uint64_t) * nb_pkts);
 		rte_bpf_exec_burst(cbs->filter, (void **)pkts, rcs, nb_pkts);
+	}
 
 	ring = cbs->ring;
 	mp = cbs->mp;
+	dup_bufs = alloca(sizeof(struct rte_mbuf *) * nb_pkts);
+
 	for (i = 0; i < nb_pkts; i++) {
 		/*
 		 * This uses same BPF return value convention as socket filter
@@ -162,7 +166,7 @@ pdump_copy(uint16_t port_id, uint16_t queue,
 		 * if program returns zero
 		 * then packet doesn't match the filter (will be ignored).
 		 */
-		if (cbs->filter && rcs[i] == 0) {
+		if (rcs != NULL && rcs[i] == 0) {
 			rte_atomic_fetch_add_explicit(&stats->filtered,
 					   1, rte_memory_order_relaxed);
 			continue;
-- 
2.47.2

