Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5119DE78498
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Dec 2025 22:13:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 384CE40611;
	Wed, 24 Dec 2025 23:13:20 +0100 (CET)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id 206AE4064A
 for <dev@dpdk.org>; Wed, 24 Dec 2025 23:13:19 +0100 (CET)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-42fb6ce71c7so4876957f8f.1
 for <dev@dpdk.org>; Wed, 24 Dec 2025 14:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766614398;
 x=1767219198; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vmW0EapljQF36KN4JI48XscDOxvks/pvjTAp8iLdZ8=;
 b=P+01gX4lVwTKAUOMhma8IdWvaao/Yh1zDpfbaXWLT2iIxUTNMCNt8YrClwxGUWo/xg
 xt49xO2NMyLEUVhEiOD6Xm08w+PolA+2sH0lvAD6WGlF1Dp/dJqKnDtlgHDDd7mry7k4
 mAd58+Rdh9x9TOvHWwxaIRKzUqWah8I13igKlFMH/p8OYxIPg8I6vAB2CwH/nQQP6JGm
 GATuRk3lpFC6cF/YsAUhFSYxDFYBjarYp50aWOqvkwRmJOZJ7TAprA68S3YJ1MapjVzK
 RRjQH6PM3/V+/uWJNcmgnj3UhDJ8Kf9cW+WDG80NGqfIljX5Aornm63eMdbtNdQVt04Q
 JDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766614398; x=1767219198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3vmW0EapljQF36KN4JI48XscDOxvks/pvjTAp8iLdZ8=;
 b=kAt6Rr2Aol8JoRpmIsZ1vKkcvWPXifmnjaq+QhBF7LZ94byPqhIAeDDQMAC5MaxqyV
 vcF84qKVScz4W06Nlo/lA+7yfMbcLePwpAuBNO+Bo518WZnWRyCoguAd8n3fF2APklUF
 3xUypLOiEG/wVZK1QmD6b755/eHEjbJC+60jwuoVGmtd2fq4Aka43k4SBZtvv/WQCEXX
 pUaSGQuMVWJS4n9ix4N7zBga5bqHSQ8Ksq7e2xHA9nKSsTAtw3wjBg6vvNjvhjk5yUq/
 f0yooDdt/kk0HQo9QdA12IrRsjveasu6X/PyL8uyYqmI/MkdDDM6K/SdyjO4/OyzabHm
 QihQ==
X-Gm-Message-State: AOJu0YwsBydK4ngfu4rkBM+zzh9tDjNKfnUxFIiRHoyCF8L74FzONYbK
 AuimGdFPVeLCNqOkY+UMgo45/uWA/2bR5O4Bki4YnhWltkItZBpdtHe5oTUYEBAn6jP3vHSIvQ4
 VUsV+COI=
X-Gm-Gg: AY/fxX7YGa/RCbi3Kb+GqBuBjouV/MkOdrGfCbBsGbmy79bcQCol0wuH/OBZxOhmqKL
 +lD686YVJQU1EI15HOdiTSDLu3ftK5eW3aspOsdlx0hrU5B81Pd8nDAVH75fiNnRD4qZxQZimSv
 jq5+QRyBe+UQBsK947KbA+5PICVAeMorIPQlZxK8hC95s8VOlEcxL16mKESv0s+6h3e6G+gve+B
 aUi746imMWLkvgmTf/XMU0MZXCsos4qKhESl00wps56jmYTJKAHtE0WtLl1SYMGyPALpUHF+P4f
 SSK98QAAWP+1zgGgTxJqvIwPyktm+AttC7zJc6UmyVV4aZBL3TxRNONoFdx5vGOlJQVxykqOKig
 ca+3GAXrQTV7IWrnIM9c8XSy2g4sJmiVaDf4YNU0gSKQ4gYQyAn8ZQPbbK8j/A7wZYvQTeuFHLO
 GEu4H6Y+ELH39roFkM+K1WfMEmuwls9HPv6eMhbpzr5p/i/eaU1Q==
X-Google-Smtp-Source: AGHT+IFde7lxMtJmIkm4WVjFfSpklXnjg3x09Teyv1K2zjOOvTSuaVIVM1TWfjhRZfjWyeANU5EL1Q==
X-Received: by 2002:a05:6000:2204:b0:431:66a:cbc3 with SMTP id
 ffacd0b85a97d-4324e4c127amr18049840f8f.6.1766614398227; 
 Wed, 24 Dec 2025 14:13:18 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830fesm36796622f8f.20.2025.12.24.14.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 14:13:17 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: [PATCH v7 03/18] graph: avoid overflowing comment buffer
Date: Wed, 24 Dec 2025 14:11:44 -0800
Message-ID: <20251224221301.52714-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224221301.52714-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251224221301.52714-1-stephen@networkplumber.org>
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

