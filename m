Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF9CE784BE
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Dec 2025 18:46:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6DF840648;
	Sun, 28 Dec 2025 19:45:50 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 51B2C402F0
 for <dev@dpdk.org>; Sun, 28 Dec 2025 19:45:44 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-47aa03d3326so53824355e9.3
 for <dev@dpdk.org>; Sun, 28 Dec 2025 10:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766947544;
 x=1767552344; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zmTGzv+JCWrykuXqU1JExJniJvskIzYAUQOcdQtwsmg=;
 b=aO2cQHxqbDhCkz2r/gV/NuxIpIDgEaIGyryCdOC0xg5pwz+clmVNHgDqO8syaMOuH/
 EmrLdFwJgJxUJJdkJCWn0RhD0kE6X7dzwtvLZLRnFoeeVfwBS/BGTFArWCaaofIICzEY
 QXpU1vUSzE1IeGtaraJMHNyuk/6/w/VJ/F8vTf0PhFM7kG8Y6AX2jRK+2dv9NFMrHrwM
 rf1Wtc0VWYFt+Fqmp0uP0CjsgDXvmCp3A30rsQhPzEyXufNe07CEVP7r0XpmE1Au4Oda
 vkDUOwg4X+68IrqRtLfWURT1h2Dr8MddKyWgbPOaCul3kyY752HoAMudR/jPANaLF+Sl
 a9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766947544; x=1767552344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zmTGzv+JCWrykuXqU1JExJniJvskIzYAUQOcdQtwsmg=;
 b=FSy8ZRJbEiA4Ta5qDReX0n4c6mrDXl5NwXiAOu4NQWTP+5oyROLWnFToWRCn9aqvDn
 4gOPE+8dOZFPCpJidE4sVXYebDkTZFIgC1XdsS/iRQM9kmhfOeltZWFgMvmk1uVLLyvh
 EwGeN7L8ATFUAG2RaPoLtHYS78GFbOUQJZ+AE17X/33spXejYPmPJFXqQiqQ+O1uD5f6
 xaYjBjNEZ3P10vmBaI58Eb3eyWSVDh8cY68vtRvU7nSYPBRqZwKD1EZyvpCbhee9FezZ
 KeSS+jtgppsrlyaohXqO/WVK3YCLpNg/cZMkIDLmn4F6dtTYOQs3jstZXTl7CnkS48y1
 /00g==
X-Gm-Message-State: AOJu0YyrAlhEyXvx1PSohah2fPtuRWl4qfptKO51drQt+iQGQhUu14ZT
 1+MYos/s8UAQ1WXQ8T0+9T4c3UkLXX56iZ+KPdUFFiPdhfEUX4cUa3+E79PsyCAvqlBuOsrTYqc
 jYrHGz3E=
X-Gm-Gg: AY/fxX6Oif4Cqv0orSboJBPjFt+qQrOTYDfLBZlsBFMITBa3Vm7vdW5PMGmrUyO6RIb
 riMIMjJvGMCecwNuH9WOOX8/uIUfvMR2r4kD0Fp0lGnrhSrdanfVo6P0U0EYGdlhRjDi9v7xvuI
 u7LU7L82toLD8fN5bEFXAIyf6C/LYDtEx1sd+v/He5EFtdqmQ1JflGwbMmQgsWFDQtFQOzJ0hne
 cq8Xd0apyNTiyH6A00t8lhCxorLLu6IJgcVmE15/vqZnW3sRworT35BGGjNb+OvfxU7Dd0pvDmP
 yvJ85ETPeE7awuuBM9z/W7CL5U8e8CB3XR9TtEHdUHXh6wv8NRtJ3uw40g6Z9ywKatHNewPPC1p
 dX8yo4Dj84LD2Hcy/Glfua+uink9NCazD5fnnSJf8Y9vsBtgR8ZMZLVsxir91Yk2X1K01Ex6QZK
 pRPyGxAfhrfKiRvwx6QQeYblPdiWla7skK/jjgEwtwLApJocciSQ==
X-Google-Smtp-Source: AGHT+IE3xzLmZDjAt1DCrzdogPUpIPCOMBpIYHFH4YNCKw/EHZBKClo1wRSzBNWrvqzI3d7nZ5Ob4w==
X-Received: by 2002:a05:600c:4fd4:b0:477:9cdb:e336 with SMTP id
 5b1f17b1804b1-47d1957afd8mr322878685e9.21.1766947543832; 
 Sun, 28 Dec 2025 10:45:43 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa2bdfsm59150275f8f.32.2025.12.28.10.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 10:45:43 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH 3/7] test: add more tests for comments in pcapng
Date: Sun, 28 Dec 2025 10:40:16 -0800
Message-ID: <20251228184300.541639-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251228184300.541639-1-stephen@networkplumber.org>
References: <20251228184300.541639-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add some more cases where comment is set in pcapng file.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pcapng.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
index bcf99724fa..f2b49c31c7 100644
--- a/app/test/test_pcapng.c
+++ b/app/test/test_pcapng.c
@@ -125,8 +125,7 @@ test_setup(void)
 
 	/* Make a pool for cloned packets */
 	mp = rte_pktmbuf_pool_create_by_ops("pcapng_test_pool",
-					    MAX_BURST * 32, 0, 0,
-					    rte_pcapng_mbuf_size(pkt_len) + 128,
+					    MAX_BURST * 32, 0, 0, rte_pcapng_mbuf_size(pkt_len),
 					    SOCKET_ID_ANY, "ring_mp_sc");
 	if (mp == NULL) {
 		fprintf(stderr, "Cannot create mempool\n");
@@ -149,6 +148,13 @@ fill_pcapng_file(rte_pcapng_t *pcapng, unsigned int num_packets)
 	unsigned int burst_size;
 	unsigned int count;
 	ssize_t len;
+	const char *examples[] = {
+		"EAL init complete. May the cores be ever in your favor.",
+		"No packets were harmed in the making of this burst.",
+		"rte_eth_dev_start(): crossing fingers and enabling queues...",
+		"Congratulations, you’ve reached the end of the RX path. Please collect your free cache miss.",
+		"Lockless and fearless — that’s how we roll in userspace."
+	};
 
 	/* make a dummy packet */
 	mbuf1_prepare(&mbfs, pkt_len);
@@ -162,9 +168,14 @@ fill_pcapng_file(rte_pcapng_t *pcapng, unsigned int num_packets)
 		burst_size = rte_rand_max(MAX_BURST) + 1;
 		for (i = 0; i < burst_size; i++) {
 			struct rte_mbuf *mc;
+			const char *comment = NULL;
+
+			/* Put comment on occasional packets */
+			if ((count + i) % 42 == 0)
+				comment = examples[rte_rand_max(RTE_DIM(examples))];
 
 			mc = rte_pcapng_copy(port_id, 0, orig, mp, rte_pktmbuf_pkt_len(orig),
-					     RTE_PCAPNG_DIRECTION_IN, NULL);
+					     RTE_PCAPNG_DIRECTION_IN, comment);
 			if (mc == NULL) {
 				fprintf(stderr, "Cannot copy packet\n");
 				return -1;
@@ -386,7 +397,7 @@ static int
 test_write_packets(void)
 {
 	char file_name[] = "/tmp/pcapng_test_XXXXXX.pcapng";
-	static rte_pcapng_t *pcapng;
+	rte_pcapng_t *pcapng = NULL;
 	int ret, tmp_fd, count;
 	uint64_t now = current_timestamp();
 
@@ -413,6 +424,13 @@ test_write_packets(void)
 		goto fail;
 	}
 
+	/* write a statistics block */
+	ret = rte_pcapng_write_stats(pcapng, port_id, 0, 0, NULL);
+	if (ret <= 0) {
+		fprintf(stderr, "Write of statistics failed\n");
+		goto fail;
+	}
+
 	count = fill_pcapng_file(pcapng, TOTAL_PACKETS);
 	if (count < 0)
 		goto fail;
-- 
2.51.0

