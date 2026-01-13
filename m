Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B3CD30CC1
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 20:23:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46BD34065E;
	Tue, 13 Jan 2026 21:23:42 +0100 (CET)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48]) by mails.dpdk.org (Postfix) with ESMTP id D98D540656
 for <dev@dpdk.org>; Tue, 13 Jan 2026 21:23:40 +0100 (CET)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-64b9d01e473so13413123a12.2
 for <dev@dpdk.org>; Tue, 13 Jan 2026 12:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768335820;
 x=1768940620; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vmW0EapljQF36KN4JI48XscDOxvks/pvjTAp8iLdZ8=;
 b=K3U8Z5ZLce0zAnjWC6KGDM6arkLGYGeKOzxBhWZh0QGJjnJ81JxYXCNOXyEa23U6oy
 BLHQeYTaCA+jEGHxjobupk8BImxvYQZckkF0niHB5ycFW5YSzfP728f4e164rFSXXtx9
 vc3ibj4mcUaoZ+WFRXU+Zp66HmhxHg/hge+Gm8KIuenP42lZoN/kAQrj4snT9Ai0dSiS
 EIwEDIpDot87ZPTs7SLKWZKgFRgwI642EvOZqiJ0mXU2X/NWcPpfF6hf/aHhiBFxjjwW
 7V2MxOinzVr+6oFGseRDh0kI5PnqvmDlvucjp4bjbZcg4Ef9JeWkw1BKcs6KJAoHb7KI
 FuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768335820; x=1768940620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3vmW0EapljQF36KN4JI48XscDOxvks/pvjTAp8iLdZ8=;
 b=HJBGq0XSqYaGI32DmNSWNNfSXmojvRUdzVMo5hg/KU9onVkctCA9BHW4TluwAHOfBi
 J7PCjKfO4hmX2LOwxLV1KqE67r8Zis0zwgIOUhv9BFP7i1Q/CFCavsKfystski2VP8iN
 r/sQ2uyJNFXRE7GjWFv1D08NcdSnzbPn+gOT7Zo7zO1zNMNr7qqZ9aGqQsqhXlHZ8ckC
 xE5yYx77kld4O1cJ+TjFvPzfZRnnbHpgMVn1r1orBJ/8Ch6IAQnbd3jewbPtMx2cpliZ
 tO4FYBhMVRJNDI4ZPCdwYuDDzeQMueFfUmTgOOTWWtbRMHd0tAQTE7/OdVm7WtMtP0zL
 Yc2g==
X-Gm-Message-State: AOJu0Yzwt+tUvLpB81fVloFcxsks0zr1Z/wuzlporm5PHD7i7j40tZIi
 1rfBXihURMlzEnlFbfBiMCLN9Myet/QUxWnLxgaQviZQWvFyGzx6GHCE24PhnSUQ6gsoKSKO6SA
 Z1V7Q
X-Gm-Gg: AY/fxX6e9J/+gAlbxkK4p7zEt8XfULSzsaaXnWUvh60VFuvTShTT74gk+sGzIB1HByx
 pa6z0kFXKeURypFkceD1k1Hx+GKTe4BHTSQJSOWxsdrCGcwM/SWsJCsyTnYisFc9T9lVCvtqXMW
 MQJtiSjO7B5Y8Eclt7VxK830r7THPwXnrUEKe14UhmgTBnvV/V4s8hAijoFXEzZsHF2onG0Wwdr
 9yL1v/E5xX0RpHCaZJdKjhiKUlu7Oss0Be/BaXYhNIepjlDuWP6BjjhoF5J3OAMWxkJt6s6hC5F
 z528ILeASheRwy0gSh1guzCUSKbpRC8x04t+0ZBK9whDroTTzfKt4kpIiMh4nSj0f15AOoiFO4y
 yX78qN8wdhLhMmSDWXLwrfFncqSI6KjidlQ/JBH4fMQ7ySaRqcmVg+MdwSjMh0jmsinkTRun4v/
 1OcMiAiMv/qvGcSSUADd1X19ad52jJCEDcDAos6DrcTWmAvYpBYg==
X-Received: by 2002:a17:906:d54f:b0:b79:fe73:3b18 with SMTP id
 a640c23a62f3a-b8761090e1fmr28526866b.22.1768335820414; 
 Tue, 13 Jan 2026 12:23:40 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a23433asm2314992166b.3.2026.01.13.12.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 12:23:40 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: [PATCH v10 03/18] graph: avoid overflowing comment buffer
Date: Tue, 13 Jan 2026 12:21:42 -0800
Message-ID: <20260113202329.35190-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113202329.35190-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260113202329.35190-1-stephen@networkplumber.org>
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

