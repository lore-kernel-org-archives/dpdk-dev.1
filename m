Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A689D6CFBB
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 04:30:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CD30402CC;
	Fri, 23 Jan 2026 05:30:00 +0100 (CET)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id 2A696402DB
 for <dev@dpdk.org>; Fri, 23 Jan 2026 05:29:59 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-4359108fd24so1040956f8f.2
 for <dev@dpdk.org>; Thu, 22 Jan 2026 20:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769142599;
 x=1769747399; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vmW0EapljQF36KN4JI48XscDOxvks/pvjTAp8iLdZ8=;
 b=gCOzvkqoJ9K/s/hfNNdYplI4TAX5ZhqR+bkSGI6vTL8Z6cnhSwiTVPN/L9dRc2pe8z
 RaUHnzuRJLGaI6g7HGd3A2lGpA+/uUiPjZBUySZPvjuFq6VXIU8cC2HBq3gpduqxb/kQ
 wosK6aEQL+KVFHfugfG+JSiTm49U52iH8ooESlVUNa4qXOfRVY7gppj4KIPFbWhD3Vyp
 kKKw6pjjkrmCeag0Y+G0jyTgyFa9ZJErIUZoIEYX56uLsdeMz0REObiZ3h0rirImwU7Q
 Z/C/dCKygS28mPSy9jIFJ2F4NlRR41VKBI0g5yjd8aoYxkDIioqT4nhmOTpfnSyflNJT
 pMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769142599; x=1769747399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3vmW0EapljQF36KN4JI48XscDOxvks/pvjTAp8iLdZ8=;
 b=VPkOilY0n+bWVbP2vq9THZ8RE09ezCh7vdf6rgsfCjxwna/qNSdTMNxrY3zQnJK9mP
 E73Hmwr7w+ur5dWD3AxK6f4v4I33921irX+yi6sekBwUgnIFFxlPmD8kx3HHOkCSe3Z6
 scpSiLf152OEG5OeKbBKSSvlorOFg7izC52dvUe90Jgxvr30TgjhzlEgvGc2jjDDjWYb
 PO4Qe8NZXzhSpl1IbuwyU8nHi0E627CSTXSphA0CJ3dVqmulaMBlXPsYNWDfaUFcbXFH
 KLFeIph3N6tqLBwaNhDwcE1nS7Qy5yNxASO47DJvDnafesgCQoTnb213SiTvEzzql7jn
 sdTA==
X-Gm-Message-State: AOJu0YwNg60FpdSggDXZ7VJOyeeS8vhYK3qOVfSWPyg1fyg8Rw1sVDNt
 d1FB4YAc9AVSgWmmd96YqPrndppCVOZ9cYG0FnNBPF1igzphwFTn/tcbbfMXpnEMu2/apm9ggnI
 1fN5e
X-Gm-Gg: AZuq6aLq5H0ZVCfyoRlXNSPuPStDopIxO3rDNrxZf3ypAZQeyf2tgXDQ+3zHTsedgM+
 VeBQ/47uU6p9lohsAae8q6tyIQKFZVdraHSkIaJTyfz/YhAvvgzYvrqB1OTbfU4eXBMomIyBiiw
 zzf7sDnVj1gcfCIpenblHqIBH3bQedT6LcB1o/WyEk0M6j6w9k1cQK1fm2TT1uWwTzz4QErEJuv
 ffQs/NcfkjgVNfBz/UC7IipKNnqQ6MdlTKkveHNBh0q3jIiDSxPc5VCufme0lhE5WN4neLdDzM6
 Jjt38pzDqBNSCZ+4s4ClNOjmGarcd1eT3x5cmf2/ejQBNqLoZsf47v0btTW2/q30RxJijDZjYlG
 gIyMuqT2Kp98Gof+5oU+Dz99JyocSPhsKZL0uD1DwvKm5N+yo3hP2jaEPz+S2vEgVLPaS5uVbMU
 xr9RWcXE+1KmPS1/rCQVgm9wzoWy1WwWu9AaVUn91qj0oL6ybXGw==
X-Received: by 2002:a05:6000:2888:b0:432:8537:8592 with SMTP id
 ffacd0b85a97d-435b92f94afmr58660f8f.4.1769142598128; 
 Thu, 22 Jan 2026 20:29:58 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b41asm3603771f8f.39.2026.01.22.20.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 20:29:57 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: [PATCH v11 03/18] graph: avoid overflowing comment buffer
Date: Thu, 22 Jan 2026 20:28:01 -0800
Message-ID: <20260123042945.159075-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123042945.159075-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260123042945.159075-1-stephen@networkplumber.org>
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

