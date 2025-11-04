Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADE7CCFA07
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 16:09:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 958B740697;
	Tue,  4 Nov 2025 17:08:56 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id A10EA4064F
 for <dev@dpdk.org>; Tue,  4 Nov 2025 17:08:54 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2956d816c10so32708075ad.1
 for <dev@dpdk.org>; Tue, 04 Nov 2025 08:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762272534;
 x=1762877334; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pkenP2FxzbVz8e0hjpeaWc3RH1zooqjXeV4GtKfNkyg=;
 b=KJPVPqlzl45/LnpMjHbqZhfaGA0Al+LzpAIuFFe5BoeRJwhqXSTkb63PN20Sz3jZ/+
 lS2koxEoOlENAJuqqdE0ApRnm/BC8d/MM/+uUtLICBNrYnrL3nB06Zwy95ss9gd6LLM/
 5wNLktlJVE9KA8fQX88D6bvKGyQf0OCorzTxFBBEtYycNgHrMWpqiy7C2ewgmjTlhIQn
 DBoCoxZlFyVXPJv+NQyd8hgQALrumYT1ymjcpVmwxcrKR6YsteoskZ+SB/l0l5RddADO
 //DpPtMc24QxUUjbv2I1xhWo67zyJbUS6QCVI3e6Rghbqd+LA2+/2xB6XqVv2QMWijx3
 jqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762272534; x=1762877334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pkenP2FxzbVz8e0hjpeaWc3RH1zooqjXeV4GtKfNkyg=;
 b=eIYXei8M4oJXpSahQXfchHJV9FjZ/nj1GPz3kwyRMKTZg6jOemDskninr3gq1jBP5t
 54Yg4cQPqMfp0DZD+tCX9K/1p7fF+Cl5UuAbw9mXvzOLpVNHqh9xYro1SUc1ht/ve2ZC
 flNicOINJYNAUCAt7eksAlHxXA1QvYxoIX/bnrab5u0fEHwFaD0hzvucd6Ge7UgvEXOy
 mvRB5EDWeY+mmdY/Dt3Xrl42L5a9XFB1SeUM3ekJuPV0PdBl0jfrh/hHDIL+wCqE2JSf
 S1+W/PVcU39YP6B6LuGRdwXwMFnqKC6dxb0QnJfKm5CDSaYNXjOAruJZ3cCPue2ePCts
 iK5A==
X-Gm-Message-State: AOJu0YzvhgRsNIq+56PYngEkVKSM83YVcTK4aI3UQbxi1OvXybgyG2yJ
 aSCl3IlinANNM0gHr3JUzjrSYNYelohp859NOENKkvZPe39F9hI33Mo+TRoPfTei8I3j5e3Lrsm
 BhdjB
X-Gm-Gg: ASbGncv+ntrRB+IJjd5EsxIdZuuyL/UIrbGVOzXHIFhiCVUFz2NzQCEKoTFI8t5YdMo
 xi8yDeoKdEQXJW5KuA7tuEFnz42yzXEAct3jaskM3b6Ay3W0Fw8oKWh1OZFR3+wyDKBABs4A9RR
 74xERhrWhILRn3wKK9PHsi6U3JV2fTXh4rFQQnmqvY6+rXKjnFUnX8CxL2mGfhBqEDvJlXCadOW
 6giFrp4+sR2Eu6TShIWxD3ThJz/xq/sKqVs5AaP5XWWJt77RsnToDGKUH0mQNtAGiO2i9QPhuqp
 OtnZt1Tyo9ALimHwcHz9FgjclNt4/WdvPffhi/iH/TPg0AlJq9Ji54JC/hQNRgDfDSJKJnST0QJ
 l0plxy974nBQNrdhXM0HkJCFd+znrpddgvcpoXuukUAdYGmBICQ71yL0fYf78er4oM2A9/7ssw+
 W3rw3wRlj4gDmV8HLKlu8LAyMo5cKHXra10DTOR7urHi58Ke2zSw==
X-Google-Smtp-Source: AGHT+IFQFe9o9Ot9seBqfb51GtTVyl6Vs5JoAohyOw31cXUyMmv/yAW2SvBp5xWQ5ClaCYbJN8ocpw==
X-Received: by 2002:a17:903:138a:b0:295:21ac:352b with SMTP id
 d9443c01a7336-2962ad1efcamr2236175ad.15.1762272533441; 
 Tue, 04 Nov 2025 08:08:53 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34159941803sm5084800a91.6.2025.11.04.08.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:08:53 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v4 5/5] bpf: replace use of VLA
Date: Tue,  4 Nov 2025 08:07:30 -0800
Message-ID: <20251104160843.304044-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104160843.304044-1-stephen@networkplumber.org>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251104160843.304044-1-stephen@networkplumber.org>
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

Variable length arrays are extension not required in C standard
and not available in Windows.
Use alloca() instead of variable length array.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/bpf/bpf_pkt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index 087ac0f244..5007f6aef5 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -163,7 +163,7 @@ apply_filter(struct rte_mbuf *mb[], const uint64_t rc[], uint32_t num,
 	uint32_t drop)
 {
 	uint32_t i, j, k;
-	struct rte_mbuf *dr[num];
+	struct rte_mbuf **dr = alloca(num * sizeof(struct rte_mbuf *));
 
 	for (i = 0, j = 0, k = 0; i != num; i++) {
 
@@ -192,8 +192,8 @@ pkt_filter_vm(const struct rte_bpf *bpf, struct rte_mbuf *mb[], uint32_t num,
 	uint32_t drop)
 {
 	uint32_t i;
-	void *dp[num];
-	uint64_t rc[num];
+	void **dp = alloca(num * sizeof(void *));
+	uint64_t *rc = alloca(num * sizeof(uint64_t));
 
 	for (i = 0; i != num; i++)
 		dp[i] = rte_pktmbuf_mtod(mb[i], void *);
@@ -208,7 +208,7 @@ pkt_filter_jit(const struct rte_bpf_jit *jit, struct rte_mbuf *mb[],
 {
 	uint32_t i, n;
 	void *dp;
-	uint64_t rc[num];
+	uint64_t *rc = alloca(num * sizeof(uint64_t));
 
 	n = 0;
 	for (i = 0; i != num; i++) {
@@ -227,7 +227,7 @@ static inline uint32_t
 pkt_filter_mb_vm(const struct rte_bpf *bpf, struct rte_mbuf *mb[], uint32_t num,
 	uint32_t drop)
 {
-	uint64_t rc[num];
+	uint64_t *rc = alloca(num * sizeof(uint64_t));
 
 	rte_bpf_exec_burst(bpf, (void **)mb, rc, num);
 	return apply_filter(mb, rc, num, drop);
@@ -238,7 +238,7 @@ pkt_filter_mb_jit(const struct rte_bpf_jit *jit, struct rte_mbuf *mb[],
 	uint32_t num, uint32_t drop)
 {
 	uint32_t i, n;
-	uint64_t rc[num];
+	uint64_t *rc = alloca(num * sizeof(uint64_t));
 
 	n = 0;
 	for (i = 0; i != num; i++) {
-- 
2.51.0

