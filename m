Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD918D2CE17
	for <dpdk-dev@archiver.kernel.org>; Sun,  7 Dec 2025 19:13:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71B584064A;
	Sun,  7 Dec 2025 20:12:57 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 719FE4042F
 for <dev@dpdk.org>; Sun,  7 Dec 2025 20:12:56 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so29918595e9.3
 for <dev@dpdk.org>; Sun, 07 Dec 2025 11:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765134776;
 x=1765739576; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vmW0EapljQF36KN4JI48XscDOxvks/pvjTAp8iLdZ8=;
 b=rtNQUesgcu/WmzV6D7xL8LPpEnkOVKYWxhQnqZH82dt1Z3gBMAQovkOErxxBOxJMxU
 Gx8zE0RT8psuA3+WFPsz8mFa3Fj2JL+c72dtTYvzJ2v+T6f3Mx078psOpL7PFAeUtJMi
 iYyTkIZcHrpezQIR/FaHCYCYWhxZchH9TXGuvRwhMXJdJe09ydjltOTjl/33i9vwfaCS
 yCzG7H5BPeG1YgvmyuxOPwnxc2l4D2lkcHNO1qs9+zYhaCxfhdFUNyMcCvEsZbdZ+8s3
 AD3coOykppRco1ebiff5OFK6xJadSoQfFvD6HKJkiJ3nYpBI05+h4VwUEeRuIM2Cq6OC
 ThOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765134776; x=1765739576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3vmW0EapljQF36KN4JI48XscDOxvks/pvjTAp8iLdZ8=;
 b=Ih6/yEiwQgR216F5mvYUiMj4WxTb9Vc8xs1mTLJWBp0gmznYqoHzbSkC55pMCxBV0/
 YVlClAxGKXjjMtTfkn+kxx+dTaUjuxYAWmn0LtMDFet2ZcO9k/jSJLvkkViLUJ6bcZ9m
 wQrH8qj/U4loLGdpduGx1tq29nyG9Y7vx1SZQ2ctDnD3dvdQjIXpyQEnLBvaFZlhRxxT
 TNZf9oCXJreGvtUuW0TfZKrlpVZ0WLxThjD3VLkqZkoOMrP9lxqgA4tURi7dcL0PalvD
 zLRcms+Ui+xZ33l8pr7EQpwtHRSVBebiLo7BoVrT7/Fz2+SNmpR+n9t4aH3N0Wl1bAsN
 nMHQ==
X-Gm-Message-State: AOJu0Yx2rKoo2xjxLrqQWz8rPnyYz/p7TWfAuH22vQdCG755qdX429c4
 Pt1lY77gBfSRtQ3asZ+geuW6PWi+pHzRuhJCF9koRf8FSllpB53DhK3Y0foGcLKz/yDrkpfsvsB
 ggikY
X-Gm-Gg: ASbGncvTkxZrgkhPDbP3hcuka3lRci1lraCG+tMssxxMD6lH9t/Zjj4TWaniLEtdBMV
 Q9Wdcnyjl30MXntHGt3V97O5gDFPkjbAgq2k+Mwzbg2QUJxOEh8oBow/HAIg0+0bMPgcReeJGoW
 UKZ/oJz8a80iukZYaLpk4xlHaV1axSE/6IK2QKi9EFJ1BkFriH1t61AjE66Fc05FAytXUzAIBzU
 yDiFi+Tv20TItWEsO1Tuzz9uwn42B70cNUy4lHrBIR79VgoSABPMaPjwoSh+FFHvtHeFiZ8uj7x
 QWsku76pfaKsVEowKe3qnMJE7ZyPQWhSbPSYgk5/v8vyRDFEYiTGQHP9VACOwtOyq4X44NJsqxy
 TLC6c3EN65Pw+yuyzureZn+DV0kgQNJaZ98aZYzZeEcnYmtC0aglt0rBLmyh/aiX9V8xYNi2Reb
 9XyTRzTsTquUBZnGmEFRPVhbmc0tmDGP4aQXHweaaoJW8lqL5Mfg==
X-Google-Smtp-Source: AGHT+IEqpzGZzYaThhikl328dnQl572fqzdkqwZcY3gdwS7W0rn25aoahAjgbIxFONb7G36QmDvRHw==
X-Received: by 2002:a05:600c:8b55:b0:477:a0dd:b2af with SMTP id
 5b1f17b1804b1-47939e3e51amr56518345e9.33.1765134776063; 
 Sun, 07 Dec 2025 11:12:56 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479310b8e70sm205124205e9.5.2025.12.07.11.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Dec 2025 11:12:55 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: [PATCH v5 04/17] graph: avoid overflowing comment buffer
Date: Sun,  7 Dec 2025 11:11:55 -0800
Message-ID: <20251207191242.165619-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251207191242.165619-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251207191242.165619-1-stephen@networkplumber.org>
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

