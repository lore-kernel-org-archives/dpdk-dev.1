Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7374CD19523
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 23:24:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B694C40A70;
	Tue, 27 Jan 2026 00:24:43 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 11D5840A70
 for <dev@dpdk.org>; Tue, 27 Jan 2026 00:24:42 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-48068ed1eccso493195e9.2
 for <dev@dpdk.org>; Mon, 26 Jan 2026 15:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769469882;
 x=1770074682; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vmW0EapljQF36KN4JI48XscDOxvks/pvjTAp8iLdZ8=;
 b=fLIQgLIG5QBdHnyUYgz9Ib1PYq/I+y0wtrPU1XOYnfP19kFMw7Lm1l6rxVXvY91h8j
 YIPE5dz7zrlBI6klVBRVPRFRpioc5ML4ZCdxVmMG26R+Q+rGxCJ25ThXO9e//lU/Tuhd
 dw0QnCM7VAKuddSCfn5K7B2my+qGIG9B9paoPR8ki3gRlXZpfR3kBnrNMm5E+7JogzUO
 wLb5e3A/HzPPmsnTsrA+VckHzS6eJWxSSS048pbGXDtFRrlDrV548yWUwUdTQHbd40J/
 vi5VB7pFZ13BteSs901QDsThpw6pfTipdjComste6nVG5CvADIyxzhiWA+jWwkV43KUA
 mYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769469882; x=1770074682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3vmW0EapljQF36KN4JI48XscDOxvks/pvjTAp8iLdZ8=;
 b=CSLOZTw3QmsjGIt6B7okzVV+2d/+5k/s6MXLA6EWtdqCvYwN/yf+HJuDHARrKV0ZEi
 WgAvAm3oGLj+DDaIodfB5yIh3K90lrTqjDZMjijkeEMW8O/Pn16xsIFWoTXtaGaPe0Zf
 cLOeMijndOSqKNvOa6xfqVK1r99ttt713UcO3p3jDfz1k8fdWoPYRT9e5KPn1t7ObV7d
 3fbSGmG0t6gKu+vSPjGYa7aioDLj3e3Odpct9ULcyWe0XuU1IC/IsWtetmus349tqjgq
 xeKuioQLEggjV55WnCpGwKGEZju7IUSx/HTKa3ruR4fHBr5rsT3SYC3RQPBwvYIgAoV8
 6YEw==
X-Gm-Message-State: AOJu0YzEDUQBabw3N485hbW9h+fq7xilm9qvJNU1pkqrLKOYSkM2aDrm
 psEHUHh8awM0yI5O9Ia9LTUp9sA80UN4uWEGQRVKgCKXjTDYceC5nCQMDGrEvahVDITXldh98tH
 jVprm
X-Gm-Gg: AZuq6aJyGqfuNT3qqZazOwakVTzDDVS+uHpQxRc4c8Wqp1feGZMORUFf5lFCK2kOQvy
 26wMlBwdZAr3C5csU8hpGsprhc1cLD4sowLoDgFzqyDExSVHEQks+8sHTPRSeXXi+7EfimH/Y3U
 K8/E5SZeF2PZxxyAkAR2Up7XZLrrDhbd8lpvUbpQ4sl63Eq9JG5bbLUFqpIAf118NGFrzEY0TyQ
 6opq62RhlJ39BjJFz0qNXAD7kMhQYWwuanQQFGwSVylUbcgIX3mMz3IZF5LkO+KSjZ0RwHDbHZ2
 Uu3Fag61/snSfTlx+2/XXHUrW6sBESUt5lQyDK5PXFImlagEq0Re2iyOtMY5+Kq3mfm2/WmlbWe
 bj2oRVYaiC5FP+SL1cinhFJVf4vwyroOxvz330m7ey1JG8DxfdSgwdnEcV8dCyatdrUHeywiX43
 G2bQ0QhqFwoKzwtytKgbN6SCAoQ008n+yMlH4l4H3L0vT2bTmPgA==
X-Received: by 2002:a05:600c:6296:b0:480:3a72:5238 with SMTP id
 5b1f17b1804b1-4805cf67ef5mr97535275e9.30.1769469881709; 
 Mon, 26 Jan 2026 15:24:41 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24a6fsm33711846f8f.16.2026.01.26.15.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 15:24:41 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: [PATCH v12 03/17] graph: avoid overflowing comment buffer
Date: Mon, 26 Jan 2026 15:22:11 -0800
Message-ID: <20260126232428.276534-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126232428.276534-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260126232428.276534-1-stephen@networkplumber.org>
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

