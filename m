Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7F8CCD195
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Oct 2025 17:00:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 059B142E36;
	Sun, 19 Oct 2025 19:00:47 +0200 (CEST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id 1DD0A42DB1
 for <dev@dpdk.org>; Sun, 19 Oct 2025 19:00:45 +0200 (CEST)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-781ea2cee3fso3213501b3a.0
 for <dev@dpdk.org>; Sun, 19 Oct 2025 10:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760893244;
 x=1761498044; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RNKn3SxKiE7no37EaRRxXgJJOu7Wh9ScpJFwtOEb70k=;
 b=SJIVt0YoKIvi5V5YRJG2RlEh9Z+sjWjDjXPMbq1UFLyB5txxnHyNYAmd8lspWZpM8I
 Ns1B6/w3UT79wqcymufeh/miOY8K22WTZOcolXI6k+oS0JWvNGd7Ie16BC++HmS1EVhM
 dFLL1W1MQvUWvhcPrCFTV17eGqTyJICEx2YNJY+OP3AGRA/gyCYX2CgcjPO16VsJ9PvI
 wMOCRV075Vkn6OBF5ALSLuQRqZyC578HHFiNz319MTi5KwDoHRWGgM1NDZlkhLcvqVzb
 d1408ZxX1SMd0PDi51F34UEDFLoMhRWF2DgEyLH62jGL0eIIBbFuZDVe8woawKNYI7FN
 y9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760893244; x=1761498044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RNKn3SxKiE7no37EaRRxXgJJOu7Wh9ScpJFwtOEb70k=;
 b=vamtvwSSd68YXVJbsvvYQWTN38zIyudOFrfPOpQvoc2S50zG6hk5+nwtIfhpBkCJp7
 6ou+N5rJGn2Tg+8dS3h/tAfTKxY7DDGF//vUn70KdEhs4cz4Z6z8pWZ+LWJmtR/80JeI
 NneUDCEhX7Yj5nwlTWE68JGPKao0DNy3Bw6uYklGFdFRhuGHbcNOZxegQZPJwDSHdErm
 uAjjrf5hmw+r2v3Qo6KKeLcCW3Sm7XwbvWZg0NjEmU7BZIJl5xRVZ8n2VMfn2dx6VXcA
 JrJ9i8zoFifiOwrShZUet5bW2xuNrhq3MV8JM/nhODzJ+1+/+zF/sYoSoDzvFjJea/HY
 Fyow==
X-Gm-Message-State: AOJu0YwoJCzubL/GwgmARJpDaJsAWwoK6Icw5SM0wQGrK00/tSmAyKdJ
 UVi8Hzvf3WuXLAOA0peAbonTxbIm7PpG6kwu7MMPr/nj5BDC0SHlCNAJDB9MLnVgcSHE036havm
 WRyRpNms=
X-Gm-Gg: ASbGncu/XiAOHKVYDxgrHEqEku0V3ou98hUJpY3leeyz+e0mckAPaXkvl3V6MbMc2nW
 g0gj9zBoWVm2bgh7Krj0wb9NOpn4hei7FG0cE1qtnt8Ngjz0GBDUAi9vyD2/bSeerQ5GwYkliIH
 E8+NbgoKC53ZrTyOVBBvx+hZy64oodgpWIMhTO4G005S2o0KejFZIFbNtX/FUZFUPko+p+peka7
 2wnr80H2DuxKiSSCBVcILSmy7et4HPvFWnORakkn3wG0xXZ7OR1PsL06p9gVkH+mBhZKqKULVsO
 AyGl3lutgE+OTNdvoFU4lH0adehCa9nVSU5c9HUJewO6evNjrxLYN3iOygyk6t6j8PgRe0nPanw
 cZ09+of6iEAQweKGB3uskj0vvOhczBm7wwbclkibEOzfFPoIE3RSG3Zx7TBOTkm7v97Wl3wi+SC
 mbwlnpq9TmW818pq3kLAC//XIDUoiEy0qBiwwpvoiNABZr+0tE/A==
X-Google-Smtp-Source: AGHT+IEVJv7xKFBI5tag7J3dlcj0lFYAhaQ5hcsX5I8hYu05ePYI8oH84Pn9eLMtVhIiUAktmMPBmw==
X-Received: by 2002:a17:90b:28c4:b0:336:b563:993a with SMTP id
 98e67ed59e1d1-33bcf8e72f4mr15263896a91.23.1760893244111; 
 Sun, 19 Oct 2025 10:00:44 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33d5d00c909sm5696079a91.0.2025.10.19.10.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 10:00:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH 2/2] bpf: remove dependency on vla
Date: Sun, 19 Oct 2025 09:59:47 -0700
Message-ID: <20251019170040.166372-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251019170040.166372-1-stephen@networkplumber.org>
References: <20251019170040.166372-1-stephen@networkplumber.org>
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

