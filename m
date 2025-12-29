Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4DCE92FD6
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 20:48:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D12C440431;
	Mon, 29 Dec 2025 21:48:33 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 4715140430
 for <dev@dpdk.org>; Mon, 29 Dec 2025 21:48:31 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso49873795e9.1
 for <dev@dpdk.org>; Mon, 29 Dec 2025 12:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767041311;
 x=1767646111; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vmW0EapljQF36KN4JI48XscDOxvks/pvjTAp8iLdZ8=;
 b=j3qdvVLRhsVwRq4FjsWvyuIqVTS1YFUDxNnrxdh65MbMOLYCm0R5R8vv3VjPR4Reuv
 NETN1FiaTQxrzFqjXNIsXVIuvucY5sMTYJfsdQL26gWQMvxWcDUygikIMRQxmvcnvNAk
 ueBAIA95buUK92g3wcC6uu6UpZsoqny7RsrPHFOyxjFWa3BuGPlAO5X6jCzmUglE382R
 mUSO7rAHPBNqViD2xHVYNXfcAAJ38BMtRwnLtvxkZAc3T46Le2acHb6xqC4fqN39mXe2
 FETVtx3cbLr6FE/BM3jw5HF3Gu4nJn6G3gWWv3Vit2GN0RkPkmtgc2TjzgFFRzRcKUzI
 6tSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767041311; x=1767646111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3vmW0EapljQF36KN4JI48XscDOxvks/pvjTAp8iLdZ8=;
 b=bsSurzgCJznFN4UgciVEZdj8i/c54xqEMc8qOXrU82ecSEzoZbNIsMI412jIyVvG8k
 rHZn0QcF9kQEp4pxx+D9wBSwmh+k1pjVOk55NbK0idaLkYbypOs+QYvW1vjhPgdYj1Mc
 4/5K9ORWM+RIScAGW3Np2LB9uouaus8OGOxe94UkNfO9HNve/DWJdGISPAruNet7oo4T
 /mzdGX0U/OfFXYi1br5jqXPjG+3PTpw2MWZHel+DjJYL7ij6Lsekg0HWSMpM0w6Lr+lJ
 hNXyx/UdXF/+a8ZNWNhOdLExyXl+VUc0c1O2I9YW8bMvwXxjFdW/Uxjjc1ZrZyOGsE8H
 htQQ==
X-Gm-Message-State: AOJu0YxX0vOiLE2Y6cODQlyPfre0AT3n+pqNDo2pCAFBrWjn81B/TBme
 H6qkBMYAE6Cz+8oBPnmSYytpSfnYMhWBHdKJzlmW1U18dLn0LK7LMGZEdPqVIogDmR1YFbiiKL1
 hKZMS0D4=
X-Gm-Gg: AY/fxX5e11d4SUP9UNdyJ4nQkvfasOfOZJ5I9g88ClNRPiaYttlmXtU6M6dFoRxIv5o
 UrmU90Qpe4U1Sbkoa1/M7/JjnEhEv7qKHMoaKDE1HsWo5p9jkqvncdMEgmvIYcSFU1agCBgkfYx
 Q557vcH107wL/dgtJTU6jiV3sUfludEVmN+qH10FiP9gEG7fdBMvFkPCk4851LHB5Qrj4XrRHRY
 lwJQJa/IdUF0Iy4ftsHMkeVSBZ+A3toPfvz+UCufYFXy7lsWpYdnxy1REDoGwNvojXQynM6n28G
 qIWT3SU/5z1h8vZAgfDDuIVtbqkHtcS3S//7LUkWL98HSsn1MGQrMlCfenWP5ADoInWfSosyimh
 o5gu7FBJGvxmFKiKYx52VinMvGtm98UBJRQiUEE3NwzOcVxI9vkTcQo9UUEbQYnNTco2+IObIxB
 tq0GCGmHol5igl6eZyGk3szQLMYb6ljfAawN35s0yhKQG0GzWXig==
X-Google-Smtp-Source: AGHT+IHDAD0NCO2gI7rpQ8S+V4RaJ0dEtcqiVXP9U6YFlyI0KbH0jfaC5LOFNxFlTwSRhM40h19aYw==
X-Received: by 2002:a05:6000:2389:b0:430:fe6c:b1aa with SMTP id
 ffacd0b85a97d-432448c9ddemr45422006f8f.26.1767041310867; 
 Mon, 29 Dec 2025 12:48:30 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2c4fsm64676298f8f.42.2025.12.29.12.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 12:48:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: [PATCH v9 03/18] graph: avoid overflowing comment buffer
Date: Mon, 29 Dec 2025 11:38:01 -0800
Message-ID: <20251229204818.61231-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251229204818.61231-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251229204818.61231-1-stephen@networkplumber.org>
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

The library builds a pcapng comment to put on each packet but
the buffer is not big enough for the largest possible graph
node name, etc. Change to use asprintf() to allow any
string length. Note, if asprintf() fails it is better to
still log the packet without comment so no data is lost.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/graph/graph_pcap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/graph/graph_pcap.c b/lib/graph/graph_pcap.c
index 08dcda0d28..602be79ced 100644
--- a/lib/graph/graph_pcap.c
+++ b/lib/graph/graph_pcap.c
@@ -194,7 +194,7 @@ graph_pcap_dispatch(struct rte_graph *graph,
 			      uint16_t nb_objs)
 {
 	struct rte_mbuf *mbuf_clones[RTE_GRAPH_BURST_SIZE];
-	char buffer[GRAPH_PCAP_BUF_SZ];
+	char *comment = NULL;
 	uint64_t i, num_packets;
 	struct rte_mbuf *mbuf;
 	ssize_t len;
@@ -207,19 +207,22 @@ graph_pcap_dispatch(struct rte_graph *graph,
 	if (num_packets > nb_objs)
 		num_packets = nb_objs;
 
-	snprintf(buffer, GRAPH_PCAP_BUF_SZ, "%s: %s", graph->name, node->name);
+	/* put a comment on all these packets */
+	if (asprintf(&comment, "%s: %s", graph->name, node->name) < 0)
+		graph_err("asprintf for comment failed.");
 
 	for (i = 0; i < num_packets; i++) {
 		struct rte_mbuf *mc;
 		mbuf = (struct rte_mbuf *)objs[i];
 
 		mc = rte_pcapng_copy(mbuf->port, 0, mbuf, pkt_mp, mbuf->pkt_len,
-				     0, buffer);
+				     0, comment);
 		if (mc == NULL)
 			break;
 
 		mbuf_clones[i] = mc;
 	}
+	free(comment);
 
 	/* write it to capture file */
 	len = rte_pcapng_write_packets(pcapng_fd, mbuf_clones, i);
-- 
2.51.0

