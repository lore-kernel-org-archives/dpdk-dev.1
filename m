Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525FBCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 16:44:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F04854066F;
	Fri, 31 Oct 2025 17:44:28 +0100 (CET)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 8AB0B402D8
 for <dev@dpdk.org>; Fri, 31 Oct 2025 17:44:26 +0100 (CET)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2951a817541so17135685ad.2
 for <dev@dpdk.org>; Fri, 31 Oct 2025 09:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761929066;
 x=1762533866; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D0ZYcyBPJsdK5B5huSPK3LzKVD7fDGoli3Pmnq2uxs8=;
 b=dOHjhYVsyMGl2SiHF77J2zNEcXkhRLsArKrKfXpUDXiOKG9gh+zOY2wocRCsg7fZED
 fM4+CXtbsWyN3mioYLjcXq9fbh6gyy80YnXP9RQhPk9L2VcKcvgK10qLAK0CujLZTzKq
 DftodO2IfawQdeoGeGPV7CYik/HHK9w9Ewyvl82aqq8yEnCzQuaU+ss6rRfc8OPOQlaM
 ymYSMZpNI+ltiSJXXZpWnWpMFBrWJabbYZH4LSa2bpzrhO2M0Os+uOvMzaOpjAjU7v7N
 MVCsmkIIjTFBhwICwrmrC9iCdyyeKMgITuRueRX3ZKan1WAXTFxlHxDXwZR94V7v8L7H
 umMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761929066; x=1762533866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D0ZYcyBPJsdK5B5huSPK3LzKVD7fDGoli3Pmnq2uxs8=;
 b=k+qR8VDoSMeXOjSh2FHmRQVSpeoZU3fdQozWlGZQIeIM0967Yeo6NFH47EOZqVcD4y
 G2Tn8XUolx5oMu4zfHR/k2QOTT19srVMu2TOC7+AWoRqkvR/0XvbxNZLzptFdk79wWtg
 R6/Q1ImPWUPMlyU3VIElSkBfaDzxUmyW7G3U/MsS0a99R+gTRkEA+VUygoCQd39NidRa
 px60OlomjglodeMtAIiNlMZ/Ni2EC+L36cHfx6C2IUWmWdaOYVRmKaz+V440gvIAh0ko
 beF3ac5sMMZQRPd91Ch7QrDLv2ukeKuvxvSiLFhx6gIBWD+mqpidXDBtCY/XMUJCZwU+
 1pDA==
X-Gm-Message-State: AOJu0YwXH/iwxBk2cooU4n215AHMd7WNJ6u64ieFqDlTrlvt22KWyxAa
 JQRxw+2UrGTNnRmff9G1BHZ2eYxrCmG/Hl34v695UCu27Mg2SdPKAFo4+zi+EZveNvtH9YkUL4A
 MGF6U
X-Gm-Gg: ASbGncsd6C0LUrJSfWvaVYDNVtTv2MjmYgJ0oewU/XRCQF4Z6PsIrYzgru1xG3kXreD
 OvDf4pHyv01N6nvFy7k5yHBLnCfKB/UmeO6Hr0r9R+yiME1ahsd4tMVlOK1Ae9735YVHaqYMRo5
 gLdA2Wwz7ww0IQdoqfNJlC1RLbGwOgahsG0swGbI7f5fJsxYd1kdjm1/mWSOHOT3vvLDdu/WDI8
 48aTZNPfUk220wxqXzmFTUhS7jN9/N0yNipUdImMpog7n9ou/lLvKlYoM2GJyGh892VPG2iM552
 5Ys5ZuR/iCCnmcTQSDi6IULeTtD0VfDPvQ5NA+Nsn/rn1aRMp0VqxeW3tJeMeHyVo9vcv21enNS
 1CBTG0Y8kT4X9KpXY0+GgtPuYsWA36rKrw75CxjZwFiCZQ96OV6etOvq6Xq6lsL7laMKZYn5GFm
 T0LxDx3iwYYL3lu+FlMul0MJK26ys8HxwqItFAQqP8GCV7sgvSGw==
X-Google-Smtp-Source: AGHT+IEcbg9da6AT/jvFq15TSAqtAziGL+fgK5zySMCPtdH13Ae8LPnOaj32UGMgv443x5tAI/lAmw==
X-Received: by 2002:a17:902:cecc:b0:252:5220:46b4 with SMTP id
 d9443c01a7336-2951a4dfbaemr54509445ad.37.1761929065512; 
 Fri, 31 Oct 2025 09:44:25 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-295269a8ddcsm28391845ad.91.2025.10.31.09.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 09:44:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v2 5/5] bpf: remove use of VLA
Date: Fri, 31 Oct 2025 09:41:49 -0700
Message-ID: <20251031164417.14166-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031164417.14166-1-stephen@networkplumber.org>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251031164417.14166-1-stephen@networkplumber.org>
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

