Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8331CCCD195
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Oct 2025 20:41:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6192D42DF1;
	Sun, 19 Oct 2025 22:41:15 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id DE999427C6
 for <dev@dpdk.org>; Sun, 19 Oct 2025 22:41:11 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2909448641eso35554055ad.1
 for <dev@dpdk.org>; Sun, 19 Oct 2025 13:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760906471;
 x=1761511271; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RNKn3SxKiE7no37EaRRxXgJJOu7Wh9ScpJFwtOEb70k=;
 b=JfCd5v2/KIMPDWufWXtVTzzQyxsd2zcrwKGoCBtgQisQ6JRyVC3S45Ns0EOeItsMy+
 rjRrA2zYDtWmSRUWlZT4WFS98oZAspP850TboXWt40zcChrDlXhDgUZAhuCOzAI8bkTx
 6ohW3WcTdOzMkQxInEsbd/GROqNt78PEeg65+H0Bd5DSR8cPpbslOvZIAJGNUgdaRAqU
 6h7IPmbC8JQ5fYWttk8ukLgf8TCzl0xoyar357njwM2WiYjtNBe1aNyPnwvqhw4E7HcU
 qOgENTUQWD1WESDFv2REsblAziOaM9m3FajSqO7VEorKglMqJdqtwRKgBeyCr3AugfpQ
 SfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760906471; x=1761511271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RNKn3SxKiE7no37EaRRxXgJJOu7Wh9ScpJFwtOEb70k=;
 b=jZtn65Y4rZgD5a/Auz2HeqeJnGj9mkblxYRRJh+kpgrTZwe8e5r5RB7xshtFWugRl5
 8z1OJc7byRnzZypRZ053e97UbLuI7VpOqU0OINsSPb8euWeMZxuLsM1G05DbYGeA/zMl
 39LS3b9Efs3jmdRySM188Ci1HnV8oJMuX1sHBSWhMfthswv0+BVAervr1JuZe0pOskG7
 TRTU3ZxbD8wQqQ5nnNUkdTqbKl999dv80bcuDbTvOXIy6UHvMl+bYCHprdeI/DiWjoHk
 hDRO0zQva+T4lLqErhSPHXngAv9PlIeFu8usWpdHEG11qGr8fU6+Q2qarE9dvaeLVXur
 U+vA==
X-Gm-Message-State: AOJu0YzlEC2/Ai15fC7AX7VK/WrLg6Z5rO4zmVtuLn4Lji/R+gySUAnq
 vz2ZpGfRRn3bazP1RlvZbDovPM3WfD7G9pre3GMy3SRMlF/cYfCEPnLzK8Mcz81uR3mmVqbQxT+
 Tmj+WxjE=
X-Gm-Gg: ASbGncvdrv1FgQ2AKl5gzrvUqeuAfcYL4dXyHi9tZRRS1Gv9yiF5NUyJLqfeNChtfgy
 snP6vJ+vPyWBkLI1h0vhOFs976nSsz7LBf+QQIJiB9BlSwAo8TUw0+k1IwRTSA0ymNO1zmD5mr+
 B+n1QP2heAatkmZWhKEo2nDUkTnPfiUprY89t/y8uhyTesQxOtGisRbw5f+Kq0stzRX13xXZ3FL
 9fMDPXq6Myg7cQ23s7hsloN/s1O4PaIXL+Fd3U2bkTTh8WX71LjvudhwNKhRpWp1mYw5gGJTgAw
 Fi83HCGKDLeOmVF5GBjT0tDY/kLUsJfyE3MF6wY9u333mnHIz06yZyB2DMbGzNT6JHF8GHYy4eL
 mTio0XyCPtyM0W0186Q0S4FPQUz9O1n7Apj4Ko71hWggnG6uY+Uw7rrV/WKHBfrKOYqQDz7lbLA
 fLsUIz8MtTR5HEK/OmJHFpzTAhecKEqEy+Oz/LAzo=
X-Google-Smtp-Source: AGHT+IHFDXjbLPJSitpu+jB4ADD7iEucPRffq1mwsoJ0ozYES1JDhI+09wXn4MWhABA9lHy5n1TAkw==
X-Received: by 2002:a17:902:f541:b0:292:9ac7:2608 with SMTP id
 d9443c01a7336-2929ac72697mr17688775ad.8.1760906471043; 
 Sun, 19 Oct 2025 13:41:11 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292472194b2sm60571935ad.103.2025.10.19.13.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 13:41:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v2 2/2] bpf: remove dependency on vla
Date: Sun, 19 Oct 2025 13:39:59 -0700
Message-ID: <20251019204106.29043-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251019204106.29043-1-stephen@networkplumber.org>
References: <20251019170040.166372-1-stephen@networkplumber.org>
 <20251019204106.29043-1-stephen@networkplumber.org>
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

The code for ethdev callbacks was using variable length arrays
which is a feature not supported on MSVC and later C standards.
Replace with alloca().

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/bpf/bpf_pkt.c   | 16 +++++++++-------
 lib/bpf/meson.build |  2 --
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index 01f813c56b..6a425d79b6 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -6,6 +6,7 @@
 #include <string.h>
 #include <errno.h>
 #include <stdint.h>
+#include <alloca.h>
 
 #include <sys/queue.h>
 
@@ -163,10 +164,11 @@ apply_filter(struct rte_mbuf *mb[], const uint64_t rc[], uint32_t num,
 	uint32_t drop)
 {
 	uint32_t i, j, k;
-	struct rte_mbuf *dr[num];
+	struct rte_mbuf **dr;
 
-	for (i = 0, j = 0, k = 0; i != num; i++) {
+	dr = alloca(sizeof(struct rte_mbuf *) * num);
 
+	for (i = 0, j = 0, k = 0; i != num; i++) {
 		/* filter matches */
 		if (rc[i] != 0)
 			mb[j++] = mb[i];
@@ -193,8 +195,8 @@ pkt_filter_vm(const struct rte_bpf *bpf, struct rte_mbuf *mb[], uint32_t num,
 	uint32_t drop)
 {
 	uint32_t i;
-	void *dp[num];
-	uint64_t rc[num];
+	void **dp = alloca(sizeof(void *) * num);
+	uint64_t *rc = alloca(sizeof(uint64_t) * num);
 
 	for (i = 0; i != num; i++)
 		dp[i] = rte_pktmbuf_mtod(mb[i], void *);
@@ -209,7 +211,7 @@ pkt_filter_jit(const struct rte_bpf_jit *jit, struct rte_mbuf *mb[],
 {
 	uint32_t i, n;
 	void *dp;
-	uint64_t rc[num];
+	uint64_t *rc = alloca(sizeof(uint64_t) * num);
 
 	n = 0;
 	for (i = 0; i != num; i++) {
@@ -228,7 +230,7 @@ static inline uint32_t
 pkt_filter_mb_vm(const struct rte_bpf *bpf, struct rte_mbuf *mb[], uint32_t num,
 	uint32_t drop)
 {
-	uint64_t rc[num];
+	uint64_t *rc = alloca(sizeof(uint64_t) * num);
 
 	rte_bpf_exec_burst(bpf, (void **)mb, rc, num);
 	return apply_filter(mb, rc, num, drop);
@@ -239,7 +241,7 @@ pkt_filter_mb_jit(const struct rte_bpf_jit *jit, struct rte_mbuf *mb[],
 	uint32_t num, uint32_t drop)
 {
 	uint32_t i, n;
-	uint64_t rc[num];
+	uint64_t *rc = alloca(sizeof(uint64_t) * num);
 
 	n = 0;
 	for (i = 0; i != num; i++) {
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

