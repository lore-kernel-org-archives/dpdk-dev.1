Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ADBCCD195
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Oct 2025 16:58:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C99142E1C;
	Sun, 19 Oct 2025 18:57:42 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 41D6742DC3
 for <dev@dpdk.org>; Sun, 19 Oct 2025 18:57:38 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-290aaff555eso34222405ad.2
 for <dev@dpdk.org>; Sun, 19 Oct 2025 09:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760893057;
 x=1761497857; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UwIpDiQsfb1LJw4fMx3rsfUiIKyc1zOAJqotNzQ/iIQ=;
 b=A1eY+9vPRcz96P3S1WaAORcwZfTOxX7CGJFAB4Mln0ZVs43j+6vCE7n4DNPTA8fc8b
 6Q2uGqnIHN2aamdP8yap6QjiKf7pxIUk48eEZ3ItGwnP4JF2ZJcrFYiyY7qtJA4D0RNG
 yMtIHRpjEtqJhxuwLWoV+hDIjDAPcYToebxh2QH02Wi/H4XQZMSnUYfckkyUudX99KHd
 ZaVA03b4/ZrAnGNaxZIzC52reXJMlm3m6FDqIpwmSYEhNsI729mVffpoa6OOkRw7aIdW
 04PSNvv8IUpTyN75irhu1d+Zw2dVn0nnglU8moAbR5VfU7w4as8e4eRFy7TvqQ/pudxz
 JXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760893057; x=1761497857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UwIpDiQsfb1LJw4fMx3rsfUiIKyc1zOAJqotNzQ/iIQ=;
 b=YE44+xtfPVLhOXWlQXj1/RrguVIRRKbgxYSRbAeIniBXwfpVLZhD1dnrCBzYabu+Cj
 HcpokxXyi3e21wwh0d6Odaa47zvvSTpnh1vW0Ve/MvVvqHhmJcwyEyOI7HUpF/lLS/JO
 N8IaFxaAuzevxmO4BG5GU0fc1NgtAGHnEAMq4sskAS9SSmqcQRh21p+EZjS3yF+bAdyI
 zBgb6xc3QnXE3P7ULTpvhPlk8MvP+GSxbdT0qsOqcEhrgaA+VN6vUUJ/WbrrMwpYB50t
 zPCSYSCwrBQFHYEV8EoNdMWjxUiCty3EDANPDFnmBlP9qg5SUI9ipMvsJ6Ct1NYab1mF
 aneg==
X-Gm-Message-State: AOJu0YzBVcRxkeMrgRdr67+pyCNoegFdIADs+781FjdcifRei7IZdqml
 g30P7xhnljO5BFzyWirN8piM8wUd+KbnHqunV9dN15hDRuwjk1xU1VQwJxsk4Pwm9on1r7geOrv
 kFN/1KGA=
X-Gm-Gg: ASbGnctUDMltxqg3+fMXIV23TtLQcmi4FOLFFlwarP4qVsmEIGlElH/PQtZkY5y8KPP
 e4W8RB91UO6yJwlI1KpT2GlplrRDB99onK6SzUFSOFFEl7P4rkMsiObNORpWuENZ/t1Vne8rmWI
 P46tXY33hwa5z+CtYK4FQM+oypqUVHyEBfSkUJDlPIsP6mIQPJrMWk3GPEhyK4EghKpJJtZp7fL
 gVcXQnspKC6tP5mua64B9vZSL6IY1vHeVfvkXJoSNgpfJ7fLd3j/S/I63G/poGpe+8TR5MbIxQK
 KVKEBaAfAc0j5ldzGOkROMoGNYvtjPUMgvXxpEytegH+fvKMn89PcDt8NmAPWno9MieeqhXbsa5
 3Z215Gpz2b0Hymhea5vGleNT+F1LX6xM4rlEUtO7TMNmYLGd9+ATnhFslkX9XXhRVsnhvhF+RgT
 nu5W/uqBagmpDfVMhWeixh/f2AAAC44hC2Frlp490=
X-Google-Smtp-Source: AGHT+IFY/CodZIW0qngiL/n7U5MQ76Mpn664E4TSvOs1sINlcJx/l8YAfoA/Yxkv9NUYzBms6TR/Cw==
X-Received: by 2002:a17:903:350d:b0:267:9a29:7800 with SMTP id
 d9443c01a7336-290ccad7623mr119834895ad.59.1760893057500; 
 Sun, 19 Oct 2025 09:57:37 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2924721b6fdsm56940455ad.118.2025.10.19.09.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 09:57:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v3 7/8] pdump: remove use of VLA
Date: Sun, 19 Oct 2025 09:56:14 -0700
Message-ID: <20251019165728.164929-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251019165728.164929-1-stephen@networkplumber.org>
References: <250811213632.16023-1-stephen@networkplumber.org>
 <20251019165728.164929-1-stephen@networkplumber.org>
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
2.51.0

