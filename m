Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E10AD46C16
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 01:43:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99B7D4066D;
	Thu, 29 Jan 2026 02:43:26 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 8EDFD40668
 for <dev@dpdk.org>; Thu, 29 Jan 2026 02:43:25 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47ee937ecf2so3318805e9.0
 for <dev@dpdk.org>; Wed, 28 Jan 2026 17:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769651005;
 x=1770255805; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vmW0EapljQF36KN4JI48XscDOxvks/pvjTAp8iLdZ8=;
 b=jgKChpWaefcybTCXVme+ARSsvoy4j4u/+4HnHgldk/ozoGaL4vVCPfc+84N4xjg390
 SHCbH0VakulRsRfEZ+LpFhnwG3KYi7egNBkVSGSEVJdlp2adakI3n7n+DbtEOPbQXOCh
 cWIPx5OJ+14aWVz1uTiJejBL7ECm5N2xydlCP7dCIIW4NyqVipHsNvjtec/zfqHCwxOW
 qtx3c6D4bSPlOT0xmD3nF1CrWNLLS8TqI7jMsyLhQ5S8DjDOa4Vp+RK+5oW3Q50Tjybj
 0bcZEu53R4uEjllyRc8iebaL25+Gr3AX7oVVVubRmesvquXRKBAIC1wMS4Jb9oECVeMX
 zObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769651005; x=1770255805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3vmW0EapljQF36KN4JI48XscDOxvks/pvjTAp8iLdZ8=;
 b=sd62jT11lm4f8IOkkocxhlja+tsmD5trApi6da7ki3VJhRRGZHMi5fciiyfBOxydpR
 IScVkxic+sp21cn4yvMM4Y2jekJTxxRdglz+E93SC51bmN3nApOmzrIxhXXyerPe6XJ5
 A1pzVF67AEAVjBkp6buBYwqQO1gdL1j4mjwKcqq8HJDO8mSHubnApEGzokobQEO8BZgg
 PVnvqs1sKfwCArRLTl3yPxQ5UNEYKBFxyhgbUVVK+Fx4msR+5sncxIJsa9FLDlqr+7rO
 MZfFnNayHMlwXU/dSfGZE5r0aNOg0oOU8+D6asfRXT3L3XG/sl5s02u/KweXOz2DqkH7
 obHg==
X-Gm-Message-State: AOJu0YzWAygPdY41gOQoci0uPx7pBhhfthp30f4aJzDyXUKaX/9VqDPu
 9Mcsyv4XsETXLZxVJKmualgcKhnffWPUa6SoL0WCjvLPXEflwxOBh351dPyyjBXexo/KO8fZjMZ
 TRuZS
X-Gm-Gg: AZuq6aJFiiJUpHBiZiK6pSdpH02p/z4e66QbmqtvHeblCgWj1xhCmD2jHVBe18s8pyB
 sM7zaVYkaJjnzcaAbWzSPjOpXKj+lUe5+W+iDntLLVVjgAAvCu6r9y6CprUODrVL7j6QUWo1OAn
 1wCn1sUaNmylUeRM8IKfv1f/ldmdAjWs3UvJsLpg1hqSQ4/690EZn2IJaw1hUpMUAaIP6/BhdAB
 a5sryop2VzWCu5k36Chcqr+YXnsuGCNAOKC+GWm9Cci1HnqKfPUIDNg0tr0eqNUODW8T734e8QA
 qlzGoFjfXI3RQ1VwJ31rvhN46VtqbDacmAINV5kzz3VarO3DayiHgBrM7HnMMvcUktaXqxC264/
 wmm9dObLZgFOy7rwSJX3igBF4sChT9pZQaGB/66zIiCHwO++YejeOtX3kf4zrLQPlT1j7tvm0l6
 rTDLXITX554Fvw6U6XHOTpOqnhSHRd/dNUIJqCnyK4WnII18g0KQ==
X-Received: by 2002:a05:600c:2305:b0:471:793:e795 with SMTP id
 5b1f17b1804b1-48079af6674mr12032805e9.0.1769651005155; 
 Wed, 28 Jan 2026 17:43:25 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e18427sm3217985e9.16.2026.01.28.17.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:43:24 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: [PATCH v14 03/17] graph: avoid overflowing comment buffer
Date: Wed, 28 Jan 2026 17:41:06 -0800
Message-ID: <20260129014313.939831-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260129014313.939831-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260129014313.939831-1-stephen@networkplumber.org>
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

