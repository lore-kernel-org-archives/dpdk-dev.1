Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF0AD3B7E0
	for <dpdk-dev@archiver.kernel.org>; Sat,  6 Dec 2025 18:44:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26DDD40615;
	Sat,  6 Dec 2025 19:44:26 +0100 (CET)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id A94B1402F2
 for <dev@dpdk.org>; Sat,  6 Dec 2025 19:44:24 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-42e2e445dbbso1531842f8f.2
 for <dev@dpdk.org>; Sat, 06 Dec 2025 10:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765046664;
 x=1765651464; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vmW0EapljQF36KN4JI48XscDOxvks/pvjTAp8iLdZ8=;
 b=Cyh0tEAN+P8TSKgCS18Of44Uuu6XT8j5MjWZCvU5bx0aEI2GJk2Q92Hg+HGR+cXVPx
 5Wc68beNVDLtZgeVWKp6nuhsNGuVHFl0dLRwCCgnwh2viLfZsDdpFxpqC/SAV9xSHpe6
 aY3PPqhxqRUr+Lyr9AaMBj+d6KE3+mpgwOPTqHyPZWHFFyKZV/+r9jiIl48Kq8zhqJ4r
 sz3aIRpus4aOKmbma1y5OBn9si5vmtRI+ptdxBiu8nC9moDk7xOzd026XmatD9vA11Ag
 ccF6h9GBAAs7jWriTYtvoK24QUTKlTdUPj6nV/AYyZ/g2qNwEBg4A4Q6rY6SpPibd3pp
 fL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765046664; x=1765651464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3vmW0EapljQF36KN4JI48XscDOxvks/pvjTAp8iLdZ8=;
 b=E6dHmVbZmRPBV/JhziNq0UkmoBrAeTWNatTl2gFYGt2veVpGC1Jpzel2xWtCZwLWM4
 gICwCJzYmam5yrzhvPZFRkA68XadJPSdo9P+RsF+GuPrQ/Jg01siaMCbozojaFdMZ95i
 UCdQh4UkAMr2lDzu6fL1D0yEi+h2/IEQznwYqspulv+BBfxvTENXx2+bLJBYH/YO3riP
 li3Qy5dWrAaQtFpWaT/rK1OOHZka2ajjzmMZPAt2UHcEnRLrAhK5PhDoydFNI36eonsU
 FnyLDSeauICXFa4i6KJ0VTnoMvNEPimEKmV/DZuNXTFy2nPx5bT8qzi/XWzmKkiDmysQ
 nHzQ==
X-Gm-Message-State: AOJu0Yx9DQ00W5lmgZ/GSum30dlkDfNbMzsZZzj2AbAEoMHxNRXG+nl7
 9VO7mHH1T3VOTJhEyqT1rdcfZhPkabMVo4+brSIqKDzLyI7tOilxWMtCj8MKXwlihMRkBUmkDPo
 l182H
X-Gm-Gg: ASbGncuyMhVDqupzFu0y3IIpgxk0Zwm++rNCCyuQCCCX4V/ghqYgiC6Aq2LRaRnJx0y
 p5VF7n3MGrN9qLbf2wXPB8BcKUwb2j/JItEPp47yaCjrQVujTwKGlnOsarLtOFT7GYn8LigGW7V
 +0nnDnMJUR01mhjksIvkFqvkEWNL2YsnS/HJUQFcEvVg2T2nJqFOmlJ+eC75/8Zi/+UcLY9rCXf
 WNc5KOC08BQZoHr5ralItyvUokHjkayo1TvSbAGqiO4Y/ugSIWn6LL1ap7zb7tnnHC1+/C3k0F9
 HDFZyl6/v1dZgzR5K6kOLt12FHaq4+u/OBMvUn7JJVwpYkYOv6ZBeu/eBXEL3JOk2jshH1e275S
 VgiwiPQDoff3khogD5QNxkcRXn9hXoHL4aoNsjWmNiXiz6n6gyBm2szJ8gkZFMArJQbtXUEsJY/
 kpJ8Xe36lkV90VN5cHqR17Vd1GcJ9uc0X5GY+lUoA9mCYoPpT9HA==
X-Google-Smtp-Source: AGHT+IHhzJcPlcMVF/WYDKCkEs5nAj316QIjKkGtg+aktdggh5mzQORTIVN7Q+fd7VgvhtMDAx3WfQ==
X-Received: by 2002:a05:6000:2384:b0:42f:7601:89ae with SMTP id
 ffacd0b85a97d-42f89f0f314mr2996217f8f.2.1765046663833; 
 Sat, 06 Dec 2025 10:44:23 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe90fdsm15281616f8f.3.2025.12.06.10.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 10:44:23 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: [PATCH v4 04/16] graph: avoid overflowing comment buffer
Date: Sat,  6 Dec 2025 10:43:05 -0800
Message-ID: <20251206184410.542725-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251206184410.542725-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251206184410.542725-1-stephen@networkplumber.org>
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

