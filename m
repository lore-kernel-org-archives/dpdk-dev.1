Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FDACA5FE6
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Jan 2026 22:01:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DCCC42F61;
	Sat, 17 Jan 2026 23:01:00 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 15F4542F61
 for <dev@dpdk.org>; Sat, 17 Jan 2026 23:00:59 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4801c2fae63so16889835e9.2
 for <dev@dpdk.org>; Sat, 17 Jan 2026 14:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768687259;
 x=1769292059; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z+1a7afTSOZsV8hfXmd7iCIR5FARLz3FK6SxtL04hwk=;
 b=Z0rNNDf7zImmIFdlfh+hOfHgABMOnD5qvn6S6xP4jyIlr/EcZWKOlvQKzdyz+XgZ5+
 sHtU0jekVbkbWHWIkwYt6x4prVz/XJhIrvt0qQyVBX18aoyfMsk8V3Z8em8PhgzwvSfn
 1DnFNpaGAAi5O33G06RgMr8rjBgByLbDtMFACDOeCHKCKm46FQVemiQVLUTYb129C5Hf
 9cpA+SYjlfmgSgOXKAOhhTGLDC3xgKT4YL+Nha0n45Sm/FL//mUQU0aAtjSIj14aowVt
 ow9qe3u6sfmKL3cOp6e95vDe+2vuRPR9fKksGyYPoMxEllS4GVgyMUbNcmIGwZVDrKl4
 gvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768687259; x=1769292059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z+1a7afTSOZsV8hfXmd7iCIR5FARLz3FK6SxtL04hwk=;
 b=iIbhibgWlzXbfyelNX6qwsUIq7y0upshyWESCUo/zPOiF6fzS3D6D5DJfWOqZ5dG33
 OVfL8Z6wqs2y3GjnXMDZPG+W4jwtkKOe98krdKrDeq5WNz2nhBW9DJVqsAxcrecGAzLa
 5B64d77nqxvPnMqtMz3Nhcc5iGwb/xjSi3lWEo6HOE6JwNMTyzM8xf+Ckehkl7AVAd1P
 jnLPiOgMjKxSV0t52OuJz5oC5hPwBPJnF93h5k1HXlfmW+OqGHNf3qdS7gJxwMLsFRr8
 09tveiV0HpsvEEQT5O/IsUERMOqe4NL8svB0w0dPSJ8thuTnZqvZu0rJA02jLOJvoWSs
 8pmA==
X-Gm-Message-State: AOJu0YzrwU2B0JlVZw7dh2e85RrE/McrPrFaGa3HR4SuEoDLJCg5g4c7
 paZUNd9Ws7c+wDCL7sFIuRkPHUBHLMLFNzuPvASQ0Bfq9RnCcCBZpkk6SBaFtwQqc0qzlNclDpA
 q0ukv
X-Gm-Gg: AY/fxX4+tT7siSHx16YJXwxTMu2gMCMiCluAQslPl2TNLG/MaioHFuIQ1bihciplIZY
 rnlKTaigAi0exd15xNviUXNDB6zJUZ+TSzL000cryPVaMejyeKTe4LU/hWE0yzE5Miz9xpHeD8W
 /BC6pGB8bvSJpD9Oh8otDLS5pKN9n30mfjRgBMFWheBRtRsNumFlSYdigprIeQyfAo59MbgTbzO
 q6KD1X0gQoo0NpNTV9XcQz6rhvVp4VGpin5eb9wGJwA1R5IbfiDSYTLnQoz2jPEP+bGSASLUL2r
 kviGkLdQnRVN83uyyfYZzXw8KjsjepiZmi5csTsGn8f06DktOuFDt7347/zFWPKVv7Ez6sHWXpD
 VoiuIu2xV1uHkvy2KZTZBzZcztdg7L/JspWfBvJKD4eMyvW2C7CdIUOgfP9CFeZiNJQZ29tZoK+
 5TdW1cJWc8v1DZD2DxX2B9gddE78UaEgN57jm5VWL+k/DzxA4fQg==
X-Received: by 2002:a05:600c:8816:b0:480:1e8f:d15f with SMTP id
 5b1f17b1804b1-4801e8fd2e5mr47890785e9.2.1768687258609; 
 Sat, 17 Jan 2026 14:00:58 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356992681esm13309352f8f.11.2026.01.17.14.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 14:00:57 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v4 08/11] net/pcap: remove global variables
Date: Sat, 17 Jan 2026 13:57:07 -0800
Message-ID: <20260117220030.273471-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260117220030.273471-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260117220030.273471-1-stephen@networkplumber.org>
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

Localize variables where possible.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
---
 drivers/net/pcap/pcap_ethdev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 7e2a69f137..9d4408a845 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -40,12 +40,10 @@
 
 #define RTE_PMD_PCAP_MAX_QUEUES 16
 
-static char errbuf[PCAP_ERRBUF_SIZE];
 static struct timespec start_time;
 static uint64_t start_cycles;
 static uint64_t hz;
 static struct rte_reciprocal_u64 hz_inv;
-static uint8_t iface_idx;
 
 static uint64_t timestamp_rx_dynflag;
 static int timestamp_dynfield_offset = -1;
@@ -556,6 +554,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 static inline int
 open_iface_live(const char *iface, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
 	pcap_t *pc;
 	int status;
 
@@ -654,6 +653,8 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 static int
 open_single_rx_pcap(const char *pcap_filename, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
+
 	*pcap = pcap_open_offline_with_tstamp_precision(pcap_filename,
 							PCAP_TSTAMP_PRECISION_NANO, errbuf);
 	if (*pcap == NULL) {
@@ -1358,6 +1359,7 @@ pmd_init_internals(struct rte_vdev_device *vdev,
 	 * derived from: 'locally administered':'p':'c':'a':'p':'iface_idx'
 	 * where the middle 4 characters are converted to hex.
 	 */
+	static uint8_t iface_idx;
 	(*internals)->eth_addr = (struct rte_ether_addr) {
 		.addr_bytes = { 0x02, 0x70, 0x63, 0x61, 0x70, iface_idx++ }
 	};
-- 
2.51.0

