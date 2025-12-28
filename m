Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38005D3B7E5
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Dec 2025 20:19:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B4894065F;
	Sun, 28 Dec 2025 21:19:40 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 6C544402ED
 for <dev@dpdk.org>; Sun, 28 Dec 2025 21:19:36 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-47d59da3d81so27285e9.0
 for <dev@dpdk.org>; Sun, 28 Dec 2025 12:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766953176;
 x=1767557976; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vmW0EapljQF36KN4JI48XscDOxvks/pvjTAp8iLdZ8=;
 b=qN7woIbX+PWG+uORuDKh9pkwMDRok+dgskdZWVpoDu3ITGxHhKHWMSM2MIDISwW7zy
 MA34lpOH7ctSxxHe0nrfcUYIoRKV5pGwB6JvAdjbhkwxiLo2FQ/qreeMidyWpUpnjzE2
 yzWbc8HLeEzTMXDju9UG49LcUXulW/rqMY27RSH+X/Kcp8T1f2knYNTRlU6uRxw4hc81
 SvAVCiMN+n11KHh1ZU8RCPmnO+Llr3QNewnrIFVm5p9C2Cva3/7HXjP7xV9ygystheL4
 XCZl43y5umwhlfu0TWJgagixEvhSQl+2Xp+z99q8IgepASAumZaWAGmohlOmowpnmtrc
 xN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766953176; x=1767557976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3vmW0EapljQF36KN4JI48XscDOxvks/pvjTAp8iLdZ8=;
 b=RjyToQBsdsLSyOE7qldvwSOLCShaQ/IdVIQVBHr7Kszu1LAa0Z8Tha1vk0vI03n/mf
 N0Eh8hzpK3+N3sihU3gpv0y7aLgFqtrwWDt1w7dVoO1Wt/p2U7Ig07rmRRVuzjO3hOgg
 Y4P3CAogZsyrZwnnCErQa54FShc+blDv1ROp1X4Prrg2ei5DsiXbk8/tN4eFRboFpwDx
 dLgkuiOl9W9FeYfByjekIi29BrL3XOEVktol3YOHpl+MPsGzXKcfcY9U/2N21lCY2S6D
 t871R5h0O/KOb1qlmd0dlyJXiMHc/jfXY+8y8OkVTrOTg5EvXz2ZWQ2IRsXSGVUkZxES
 xhsQ==
X-Gm-Message-State: AOJu0YzDTrku9v5yydd8WnN698w79nn+ly/vwF3mKp7DdvSyKo0JKUdf
 RhxGlkBQT23nXANxvAGdk/xYki3ZJ1XHsrqzA2rJYX03KglS+80sUF6MevIGCXo8Qqc2z7H2ekv
 uDYzgm+4=
X-Gm-Gg: AY/fxX49lmLfXceCLBYx/hsSQh0+jsWAH6/ia4HtVWJaykoSxOR2NGIBOd0rHd8LOiy
 0CjetHflz8up1IdH/2hfO9AQAwkq88xO3uU8kRlVuBlLlTapuQOlXqfaN7ki9L6/nlHt9ECu4yd
 N11R024EtEOG3GvtnrwMCgIcg6zAQH/r8T4Ljx9T9zznGR/j8FllC0vtfgSK/iQ7j3Q5HHD5of2
 SuLbLoHufGzUi4d8oBdiIJYLvuemwRSEchL0HSZIOOInCpGcfdSAtGvfjfjEEV0nXrtCtm/milT
 nPUgvvDGY3Rxd0Fhwer34A52EYveWvhZgxMbSeDbS1p9l0riylh+iNwY1GLFPaiaQVtIziha/Zt
 xxx4FM4XrdUAceJt3F1rOI1WGgF603sJ47UHGufbsfasWrXwJ48K8HGP9hFr/4VywmlQ1VQWFbF
 EUN8tYtOKEsjpHhDPLOItgvsZG+UAtuZoYqyhGlh+f62NH5dRjPQGq1xMYuUTW
X-Google-Smtp-Source: AGHT+IHMOJ4Crfj3CZ57dBRlsO1G4FEzV9QD+KiuAiZ07nWM62mj6eMTDVXa4nL5+/1LfpxJFQubxA==
X-Received: by 2002:a05:600c:19ca:b0:477:a289:d854 with SMTP id
 5b1f17b1804b1-47d18b98f87mr335297195e9.5.1766953176039; 
 Sun, 28 Dec 2025 12:19:36 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3964226sm240319655e9.0.2025.12.28.12.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 12:19:35 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: [PATCH v8 03/18] graph: avoid overflowing comment buffer
Date: Sun, 28 Dec 2025 10:56:06 -0800
Message-ID: <20251228201236.547268-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251228201236.547268-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251228201236.547268-1-stephen@networkplumber.org>
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

