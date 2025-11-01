Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F78CCFA00
	for <dpdk-dev@archiver.kernel.org>; Sat,  1 Nov 2025 18:07:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 916EC40656;
	Sat,  1 Nov 2025 19:07:10 +0100 (CET)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id CC0DD40395
 for <dev@dpdk.org>; Sat,  1 Nov 2025 19:07:08 +0100 (CET)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-782e93932ffso3209833b3a.3
 for <dev@dpdk.org>; Sat, 01 Nov 2025 11:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762020428;
 x=1762625228; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D0ZYcyBPJsdK5B5huSPK3LzKVD7fDGoli3Pmnq2uxs8=;
 b=AemuCPZlIDNj7E4/3QfLnCd46S6CaYUrSFrDU00ePaboGi3nGrjGZ3PiYvJyKP68t0
 +u6AZIPckpjmXsHZYoPnbqhpfptnUpcs9quxBWfHOolpujI9pnPwRB0fN1YuFYHjPEwt
 KGg4hp4q54wmFy9jUtw2Z3Mu0TFdn1S7ENqfNqL+430N4yaqW2oDW8HWgWyxN6sIktn4
 E1o8MLl9xzwybTPGbywYwKOH2N+8PDcITP5y1PPdX7TjM/W8wcVdP9vRDzmGVLOprTCL
 PyS0nP+yyASIUTKbyJrHv2jN7qWBu5qZcOHE/MHlgGm+OwO6+ecKoXkfMi5I+6n3tl2n
 BdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762020428; x=1762625228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D0ZYcyBPJsdK5B5huSPK3LzKVD7fDGoli3Pmnq2uxs8=;
 b=emI1CEdmySceOJi6bwGTrt69DWDJHiN4W6NoHN69BhEzlSxDhchQbazZgKQPveeFgW
 IKQV86RCVJNCSPK8BWoIaCTSBn8K6Pkzf0E7SE7c7Nm8ELaUjQATBdNMLKHz1cZ/mu3x
 giJVBkQWQ35QsEcod7F+s6dFCyDUiyttRYyYzGVB+7VShPKILrmaY/4J9nXdd/H1kFiw
 UuJndXa4iRVRmm1Hl9B16wo/8416i/+MKn6EF9fIVuGxx6bteeY+rXP4tWVY8RSxWWpH
 e4TqUe6KqJj7I6numR54iNUeUkj0II+qcGCLMfI1OqiC/EgME8zL0h7Hieb2NEMha/Dy
 OloA==
X-Gm-Message-State: AOJu0Ywl5rH/TodbLgBrFLExxIO9K5KAOcgeK0lS366uOonmQsOyoxLA
 WEYfmquPdzgAM7Q3I9gs9JpUjGb4lgPfliQNwQI//pAQPKiJw77XrbWxSAnTAOnPVEyOMFq5IvR
 LjDVC
X-Gm-Gg: ASbGncsR/8B2wdbsFoMOdFaanjb5DvTEu6ueBSSuM95eLeOC8YPhYH51cR8dLLzST/I
 WPv7qbOfJrlaKtL1WT/LSSOw4fLFgaRO/lo1aG6+5VHp+lrAt0Dmzc28sR8ZK+l/b9vtqHs/BlL
 MZQlc/8L9e6hEI6El/gOfKrfNmuIqTwlBtJJrnihVv6zxEF1yGGyD1d0qPUY+dCYOgttlFkuuZZ
 rBX2m4jhI+x4uQJPYxqGzVBqANwlGtMIqW7l4SPH8irG6bbd8bzV2nW419QLBoafRVPPB7saw8F
 XVxdpECTEORlXRzA/gluq+rZE92oidAI7yk8LYTYuZKLnH6Rw9vrlwpRTbRc0w1E8cQTW1Fxs8V
 fTgjm4dN6pczzwXEi00EQyt4gcDworxBGBSS8dKJ4YwxY+eC0fD9g0DQabT1iAHnY/tgtrmEnlo
 6W/TB17E4KIfV8NNuKxH6rEaaCch/oHtyJYAVvjqE=
X-Google-Smtp-Source: AGHT+IEi4SqqikgymWpTCBgla2y1Z+ri9p8dolxVCGOTbvXSQZpea8Eyg2Ki8vhuVDoIHZZqa7/Drg==
X-Received: by 2002:a05:6a00:cc8:b0:7a2:7893:b17a with SMTP id
 d2e1a72fcca58-7a77737e3fcmr9891919b3a.6.1762020427912; 
 Sat, 01 Nov 2025 11:07:07 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a7db0a019csm5861606b3a.42.2025.11.01.11.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Nov 2025 11:07:07 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v3 5/5] bpf: remove use of VLA
Date: Sat,  1 Nov 2025 11:04:47 -0700
Message-ID: <20251101180659.43883-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251101180659.43883-1-stephen@networkplumber.org>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251101180659.43883-1-stephen@networkplumber.org>
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

