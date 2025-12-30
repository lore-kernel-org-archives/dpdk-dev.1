Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A264CEE4992
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Dec 2025 18:59:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF2D240649;
	Tue, 30 Dec 2025 19:58:49 +0100 (CET)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46]) by mails.dpdk.org (Postfix) with ESMTP id 7B0D840615
 for <dev@dpdk.org>; Tue, 30 Dec 2025 19:58:48 +0100 (CET)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-64dfb22c7e4so6787785a12.1
 for <dev@dpdk.org>; Tue, 30 Dec 2025 10:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767121128;
 x=1767725928; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zmTGzv+JCWrykuXqU1JExJniJvskIzYAUQOcdQtwsmg=;
 b=3UadB/x3U7G3FlZg27iqXIuhvjEMVbCKnJpm1JoemUIUZJ4s4Y5MVgg+iFRE+cgxc6
 XDHadOJ+c0gxvmsrb5BRSG7dq/5hE36wQDvOGHPEqB3HDO4uyeJLWFLcVVry6fFPYW85
 MfHnwBb5jCKkNDEDqBlLEP1qz77RkrSBLdF+1b1OxY16P82QB7j/0wBDxl0yyr1NZwOn
 /jbT9gWngO0+h/c6mPZWUwAuVtrhSBPQtCNH+zRhn2AUBuO8tJ7OImJAu8ZKsbuar/cf
 Q9gqqstBxKpm+pLANOk56rwMM7spl2bZkZ8Y2YgDUfaQI4NvvvN4j8qUTaTxbYiKFZ2D
 s44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767121128; x=1767725928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zmTGzv+JCWrykuXqU1JExJniJvskIzYAUQOcdQtwsmg=;
 b=YX5kMlOVHbHQJ0ivH5+N2vlf+/5TNI3wANbQM/5xfCB8eL+sINFUdaEfSbtocbDBwL
 Rolf4K5I+lZl+oJQUE1ziBx9TxN0x0Lzs7gQd/uvrD5VkY38MjpFGDxCMKmHQ5YuGzV/
 V2Py+PnGbSiQ3j4HulmmZnZ1l6nopkAN1eIwn4hb6GlqRD9GNTSCbN6wnQFG04/+yhxW
 137XJBQ//Q5zr3XQbwJbszvVJNDmpeOakOJaJynWhVEo9AZTtL0QPWnnTIONf7/AK06a
 QxVLw7k8Ymf7EfdU0Yz9Vap3L5xSWu5S251huWdcKhMqUAX0Udk5A3zTNmsmh879tJtF
 19gQ==
X-Gm-Message-State: AOJu0YzWyAO4MGKbCy0mqnKXSxIC0ET8l3HnzGNF/0D+5YHfkj3JFb58
 eU2jfphOLr522e3usY3VNF+S9hhxQ5sFwgDcyhxbfW5SwyRQbY9hBhHPgyLQoY/6kh78bfvZhnm
 tDwaakNQ=
X-Gm-Gg: AY/fxX7ZvXY4kzEtnRx+EJNyfkGS8o9vVw7MWA83VONN5xXojRwwfaFi1mJEXtSLFg4
 /hE/6safyJ0dUT4HFhEYjgUWkU+k0FNSEmljv/IJ9SgRu37uAhQ8JpeaWn5009ES8Rzz79XtZPB
 v2TJ8vvgEOkA4nbPXT60A12ZJRvylwTjqc+C11cctrpDfs/4SWTUjj0LrZCU6vCX2QGkwQN9+9T
 gLQCBzQ4H7VHPBQmpcdwpc0ZhipNDZt8Cogx3L9jL3vGU4lhXmvbLsT6v/UUGpbyd1H58zIQomZ
 +b+L4e3BbpMVeyie5PMuNV0oke37602C6oQHfadb1CcrqI1MzDTFmQ0Cm/dyN+EPjioxGao4gtf
 kxAKMpOPSkCE+8dspWI5GJlAgoOs9ydhw6nrb/4h6Z868pb98lRWuQEiX38gYU/gdrYiyKVvouS
 SgRyRDp5/DKU2ORdAoKDcfBHpj/qiFPbqel76kGZhD1DUE5CP7WBNJWrFZ+1oA
X-Google-Smtp-Source: AGHT+IF5fDAgbnWlDkETonSHQuHMM95KsCi9G1TJ684tCBKAQoYrhUbLXn6UD9XbCDY7791zQqbXOg==
X-Received: by 2002:a17:907:8688:b0:b80:456d:bd99 with SMTP id
 a640c23a62f3a-b80456dc544mr3747455466b.19.1767121127955; 
 Tue, 30 Dec 2025 10:58:47 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037de0de1sm3745449366b.40.2025.12.30.10.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 10:58:47 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v2 3/7] test: add more tests for comments in pcapng
Date: Tue, 30 Dec 2025 10:55:11 -0800
Message-ID: <20251230185837.301163-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251230185837.301163-1-stephen@networkplumber.org>
References: <20251228184300.541639-1-stephen@networkplumber.org>
 <20251230185837.301163-1-stephen@networkplumber.org>
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

