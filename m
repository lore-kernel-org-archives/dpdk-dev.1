Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7222CCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 17:38:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A02B440662;
	Thu, 30 Oct 2025 18:37:47 +0100 (CET)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com
 [209.85.160.46]) by mails.dpdk.org (Postfix) with ESMTP id BB44340656
 for <dev@dpdk.org>; Thu, 30 Oct 2025 18:37:43 +0100 (CET)
Received: by mail-oa1-f46.google.com with SMTP id
 586e51a60fabf-3c92328d0bcso852097fac.2
 for <dev@dpdk.org>; Thu, 30 Oct 2025 10:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761845863;
 x=1762450663; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D0ZYcyBPJsdK5B5huSPK3LzKVD7fDGoli3Pmnq2uxs8=;
 b=FYccHdauDLUgXqJzSowKmdoCy5AshPSTktp9eAC+8uV1xGCrdgTRiGQLO/OY0Px2NP
 V/WOukp6y3xoyKEIhD9fEVov8kTARvZg/W5AO2RONr5HBZ7FtU6aF/t1bdf+SSDkIvgK
 ye+T0AgopX3Dwato/bDm6oK593pIDdKfu4kgzAmVyV11uTR+EVF43xuwpHvSRnF2a6vd
 r7+zdiyC2OzfyB9SL/bcaW5Wcz4Q3zzqD1M82VZYDQ1uYykLGgwmzVSrWKIvL9o2DOKx
 UQQGZSzrV/uoQvwjDMqKAezG7E3lW6pZzsUEiA8U/S5Ab4GlKMRY1k+nvJfI6XZhgBHg
 ch4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761845863; x=1762450663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D0ZYcyBPJsdK5B5huSPK3LzKVD7fDGoli3Pmnq2uxs8=;
 b=RhRakQyld+lxfRnc+ggqVsTN5wRB4vysjBRjsZ7o6TEBg7Fklkrrt3mdsV6v+f+ipx
 9sQZUcLkwEJd9J8WdZkzqv2LSlDyQKARpZRsI44br6EDUpM++A3gnhRdB/HxmxIyjWdF
 MfFys4J7ZNmNKzF8ygENzkxKWjBcr+tSvzBPtQKnyg10AzGRDoSJCU90Y1rbyfyka8/j
 bAGyT7YDOKrXzxY8vp57IPAPoTqa/xJeutSYps7Guk6XtWJhGfR3Iof5Z3lAPKEDOv+Q
 VnwmVtdB1NllmRcM8pMRteZSigdcV8WBRQkO/3slNcOsH+o5FFxI3hwOqj3QkQci1qwp
 SCsA==
X-Gm-Message-State: AOJu0Yz4QJVlcaolBbR5nduweK17X8/FH8FGVlj1Xc97/2GP0mkZBxt1
 vQWhiWobO5vFl5/YFJ9PMe+k82yQ2oKccdXqSbzIt6AWQLUH6Kc/GX7/f2/W+RmHif+ntYopuzB
 iWKrH
X-Gm-Gg: ASbGncs8XMZlCVG135CZuOrcYMB1OT379fb8Mf+F+cBr162353CbbYMTG/Nt2WfYtcc
 uc+WGPKEzFdNoYa0FuaN6QBMEOfdjxQmtz/4cJgYLO2feOdSjmUM4Va2WR2YIm8ZTG2atapOXLm
 y+P5s/Ij2VZQsrp9evf1v2pHe/WAH/G8SVdNBMN4fMNjqELFxY3+zcKiWrJiFZxLoQvEWwBp5bB
 exzC2yFWj6SQRWMmMMFPC1e7aObnJZeMKSjl9K4g8riRHnFUukRPYbLr2NPsF4ryGfA/kG42VsP
 m9B7Wr/vX0Q7163eX+J7RjThbMXO0SRAIPDTLEihaoe3cNA9Oc3rzurNA99aZu/7ukGAl/4NZ40
 9GdR2E5UOldRoYUhVaMVR5Jj7eXNS0LEkYBN/980C8WEUY0Ph5O60QyQxTu7OXPXsaAGL8noCwr
 qV6VIkh3s7BWz2XxmM4Bc6XjXO8lqfCF17RRT3PKo=
X-Google-Smtp-Source: AGHT+IG2nfU4Ve9Olj6RNgH9wJ/LGCGYL06HWDtxPRnfxsol6aftWtRBUWaB3xmOv/LNHxZBiqRBcg==
X-Received: by 2002:a05:6871:69c4:b0:368:54b7:5e5d with SMTP id
 586e51a60fabf-3daca727c9bmr201599fac.11.1761845863021; 
 Thu, 30 Oct 2025 10:37:43 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3d1e20f1396sm6057278fac.3.2025.10.30.10.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 10:37:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH 5/5] bpf: remove use of vla
Date: Thu, 30 Oct 2025 10:34:13 -0700
Message-ID: <20251030173732.246435-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030173732.246435-1-stephen@networkplumber.org>
References: <20251030173732.246435-1-stephen@networkplumber.org>
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

Replace variable length array with two part loop which
applies filter in bursts up to 32 packets.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/bpf/bpf_pkt.c   | 81 ++++++++++++++++++++++++++-------------------
 lib/bpf/meson.build |  2 --
 2 files changed, 47 insertions(+), 36 deletions(-)

diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index 087ac0f244..15d36739a0 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -157,13 +157,16 @@ bpf_eth_cbh_add(struct bpf_eth_cbh *cbh, uint16_t port, uint16_t queue)
 /*
  * BPF packet processing routines.
  */
+#define BPF_FILTER_BURST	32u
 
 static inline uint32_t
 apply_filter(struct rte_mbuf *mb[], const uint64_t rc[], uint32_t num,
 	uint32_t drop)
 {
 	uint32_t i, j, k;
-	struct rte_mbuf *dr[num];
+	struct rte_mbuf *dr[BPF_FILTER_BURST];
+
+	RTE_ASSERT(num <= BPF_FILTER_BURST);
 
 	for (i = 0, j = 0, k = 0; i != num; i++) {
 
@@ -191,65 +194,75 @@ static inline uint32_t
 pkt_filter_vm(const struct rte_bpf *bpf, struct rte_mbuf *mb[], uint32_t num,
 	uint32_t drop)
 {
-	uint32_t i;
-	void *dp[num];
-	uint64_t rc[num];
+	uint32_t matched = 0;
+
+	for (uint32_t i = 0; i < num; i += BPF_FILTER_BURST) {
+		uint32_t burst_sz = RTE_MIN(num, BPF_FILTER_BURST);
+		void *dp[BPF_FILTER_BURST];
+		uint64_t rc[BPF_FILTER_BURST];
 
-	for (i = 0; i != num; i++)
-		dp[i] = rte_pktmbuf_mtod(mb[i], void *);
+		for (uint32_t j = 0; j < burst_sz; j++)
+			dp[j] = rte_pktmbuf_mtod(mb[i + j], void *);
 
-	rte_bpf_exec_burst(bpf, dp, rc, num);
-	return apply_filter(mb, rc, num, drop);
+		rte_bpf_exec_burst(bpf, dp, rc, burst_sz);
+		matched += apply_filter(mb + i, rc, burst_sz, drop);
+	}
+	return matched;
 }
 
 static inline uint32_t
 pkt_filter_jit(const struct rte_bpf_jit *jit, struct rte_mbuf *mb[],
 	uint32_t num, uint32_t drop)
 {
-	uint32_t i, n;
-	void *dp;
-	uint64_t rc[num];
-
-	n = 0;
-	for (i = 0; i != num; i++) {
-		dp = rte_pktmbuf_mtod(mb[i], void *);
-		rc[i] = jit->func(dp);
-		n += (rc[i] == 0);
-	}
+	uint32_t matched = 0;
+
+	for (uint32_t i = 0; i < num; i += BPF_FILTER_BURST) {
+		uint32_t burst_sz = RTE_MIN(num, BPF_FILTER_BURST);
+		uint64_t rc[BPF_FILTER_BURST];
+
+		for (uint32_t j = 0; j < burst_sz; j++) {
+			void *dp = rte_pktmbuf_mtod(mb[i + j], void *);
 
-	if (n != 0)
-		num = apply_filter(mb, rc, num, drop);
+			rc[j] = jit->func(dp);
+		}
 
-	return num;
+		matched += apply_filter(mb + i, rc, burst_sz, drop);
+	}
+	return matched;
 }
 
 static inline uint32_t
 pkt_filter_mb_vm(const struct rte_bpf *bpf, struct rte_mbuf *mb[], uint32_t num,
 	uint32_t drop)
 {
-	uint64_t rc[num];
+	uint32_t matched = 0;
+
+	for (uint32_t i = 0; i < num; i += BPF_FILTER_BURST) {
+		uint32_t burst_sz = RTE_MIN(num, BPF_FILTER_BURST);
+		uint64_t rc[BPF_FILTER_BURST];
 
-	rte_bpf_exec_burst(bpf, (void **)mb, rc, num);
-	return apply_filter(mb, rc, num, drop);
+		rte_bpf_exec_burst(bpf, (void **)mb, rc, burst_sz);
+		matched += apply_filter(mb + i, rc, burst_sz, drop);
+	}
+	return matched;
 }
 
 static inline uint32_t
 pkt_filter_mb_jit(const struct rte_bpf_jit *jit, struct rte_mbuf *mb[],
 	uint32_t num, uint32_t drop)
 {
-	uint32_t i, n;
-	uint64_t rc[num];
+	uint32_t matched = 0;
 
-	n = 0;
-	for (i = 0; i != num; i++) {
-		rc[i] = jit->func(mb[i]);
-		n += (rc[i] == 0);
-	}
+	for (uint32_t i = 0; i < num; i += BPF_FILTER_BURST) {
+		uint32_t burst_sz = RTE_MIN(num, BPF_FILTER_BURST);
+		uint64_t rc[BPF_FILTER_BURST];
 
-	if (n != 0)
-		num = apply_filter(mb, rc, num, drop);
+		for (uint32_t j = 0; j < burst_sz; j++)
+			rc[j] = jit->func(mb[i + j]);
 
-	return num;
+		matched += apply_filter(mb + i, rc, burst_sz, drop);
+	}
+	return matched;
 }
 
 /*
diff --git a/lib/bpf/meson.build b/lib/bpf/meson.build
index 28df7f469a..aa258a9061 100644
--- a/lib/bpf/meson.build
+++ b/lib/bpf/meson.build
@@ -7,8 +7,6 @@ if is_windows
     subdir_done()
 endif
 
-cflags += no_wvla_cflag
-
 if arch_subdir == 'x86' and dpdk_conf.get('RTE_ARCH_32')
     build = false
     reason = 'not supported on 32-bit x86'
-- 
2.51.0

