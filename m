Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92510CD343E
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 18:14:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 591A840B8D;
	Wed, 12 Nov 2025 19:14:31 +0100 (CET)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id CFEE840E09
 for <dev@dpdk.org>; Wed, 12 Nov 2025 19:14:27 +0100 (CET)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-7aa9be9f03aso1132894b3a.2
 for <dev@dpdk.org>; Wed, 12 Nov 2025 10:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762971267;
 x=1763576067; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zmTGzv+JCWrykuXqU1JExJniJvskIzYAUQOcdQtwsmg=;
 b=dOYJ/2gbAMo5v/U3zQn9ehxD/7zjoGT2jaSdz2MtNgqpptn9hSTjE1hSuJRyPQGTs9
 98wPpf4gTmOKuJ9UXk9y+Ox2Jok842V6HBHx/B4nxNZgk6m7K2UIMs+firwzDyjsFF9L
 ybl9stNUqbqmoO88/8BphS6P1NhQbAjDxfBXL5p2fjjofiFbCJrZcTBha8T2addf9Dmw
 Zyyl4PB8g4xA4YdcieH/4TsiSJ40En5L4txFbZMiGCSVK3WZjxOrYcTG8giyuBm+bdIl
 1jF2N4tbpF84Ny084t8N0N+DI7N39Iisj0FpYYb5ylgCMIvRtMN9xZ5Ck/YR/KWZA6pK
 o7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762971267; x=1763576067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zmTGzv+JCWrykuXqU1JExJniJvskIzYAUQOcdQtwsmg=;
 b=HjqiTycnkX9LFQ3sJvWUORXgzNwX2etgZqBRqv5d6z5ye7iQb/G6j59B3Mb/Kv9zec
 hxvfL0gzcEotodZCJ7QAm6Vui8huXOLuKb9VYAs92ZM0NbnzzuzIwYo9THyUCdKHKQPk
 aHVEwhfMlpSD+78CsYScynWG3WFuXciDnDY95fAnJchTK+89L/4y9LNvdPAeQ4huHO6J
 HqD1tI3VHjrbg/jJSuCyjTdAH2lMTyxoZ2Kl6ADTW5WfcFtTgDwKM/NF/C9W1bX369tJ
 0X9HenBPzYoB5buwthOAhK4K1TtNN92cMbfhLjUWajNe/m2yoU6awxQrOzG0RTEIo7fr
 rz3w==
X-Gm-Message-State: AOJu0YzTTlLLlNg7+S0or0eB8q8cN31OT69WDjILKG7mFBCCqgIfPtHH
 NC53b8AkNzkh90+el8CLHDpAlX/0vRuyylmHWw5ZpJfVS12uAFpJq0RErl1LrWpRhtwMetSVYdu
 GvUcI
X-Gm-Gg: ASbGncuZim/WZsSEZuITDQeY/keyp67Ozn33yijo+kDwUJNQeJVdMgtP9x7PCctT3Ij
 OmDmvNL4CT/H/CNzuLfJjUisqLYyEQ5SrJIzLIUmrXJQmpwMgNZ5GDzgBudUJciUBoiUDWgvA5q
 tBqmtcKjUTY0W9TauwnVaHJsq7DzS+RTQsuIjhEo0Rqwl6btRdB60d9SHo1zfMVEZRZdHuM53wd
 mImIzCj7DtoS1TVbfvtZ3gODKYxLkQ3iOo9OGR/TwszfEhH65OLjajJRr/Yrg7/8xHDD6RAHb9u
 6tjAlIAtuOmfKPTR9RYOOktyfogymWP85lIfEaf+JicD4N6i4eH7egOLfnytKsdeNmysRF2NKoU
 5A/P5c3tSO0G1cBszGZwiR7zYvXvwPI+bZnhd8xCYLORb7zxVI/OcEt+Q48/hZVmDwB6aVRMA4H
 BR7D7Nm9sbxR3qjeGkKlpOpZKbF2J7C8KmUIH0+lY=
X-Google-Smtp-Source: AGHT+IE8fwvVC/4jeyWH37bxQxWHHMcGeHnsef5+H/Mu3gPlHg8Jy8vhy+QkbLAhFqcDoaPVwrrA2g==
X-Received: by 2002:a05:6a00:1902:b0:77f:4c3e:c19d with SMTP id
 d2e1a72fcca58-7b7a2f925a6mr5074245b3a.12.1762971266868; 
 Wed, 12 Nov 2025 10:14:26 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7b0cc17b0b5sm19294006b3a.35.2025.11.12.10.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 10:14:26 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v2 3/4] test: add more tests for comments in pcapng
Date: Wed, 12 Nov 2025 10:12:49 -0800
Message-ID: <20251112181421.285119-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112181421.285119-1-stephen@networkplumber.org>
References: <20251105210657.871310-1-stephen@networkplumber.org>
 <20251112181421.285119-1-stephen@networkplumber.org>
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

