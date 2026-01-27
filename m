Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6A7D340A2
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 16:33:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FDC140E72;
	Tue, 27 Jan 2026 17:33:12 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 221FB40E72
 for <dev@dpdk.org>; Tue, 27 Jan 2026 17:33:11 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so67358385e9.1
 for <dev@dpdk.org>; Tue, 27 Jan 2026 08:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769531591;
 x=1770136391; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vmW0EapljQF36KN4JI48XscDOxvks/pvjTAp8iLdZ8=;
 b=fIZ4pXceXXVH5WQK5r0agWHHZlxThSRsQqLzd6R/PihoTaFTSLefe+IzH7HY7viruu
 1k7F4mzGajkZ/apJ/d97Zp1/GCnPZX3Qj8VYbatJ8OegIvbEitFGNZjiO6piHHBOnS7b
 KjU1E54JU5Ek7wUnTIY1F/PCUQ2qCM0SdmbR4BoCGWnFdRcD/M4UgUJcwIqiuTnbu+Hf
 +G1nQsyT4dSkQTBRev/7AxD4d6g7oAJ976eVN4ed329Cphr+QRjzQCvEujSjNPcH06hy
 xEHoJ4JuMfEkMQ2Yi3QYPU/NXSr4GGqrQx8Rt7hN+8SyQcD8Sl3ABUt/TGjbY1XBH9bf
 HjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769531591; x=1770136391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3vmW0EapljQF36KN4JI48XscDOxvks/pvjTAp8iLdZ8=;
 b=mUSqZQUQfrTMkeMjCS2EN/BWQREFxu9xfiYeCoBWWQnsxVkxputlZ/6N80Zn+e0I8i
 UTu/m8VT/dh64a/ssOVO1Ccj6fbZ3KctfPpGwTVmvie4SR9PBvpSvgVDk8IqIC648O0T
 i1XM3O/31LrZU+FXOzq8kdrR15OYoqNxLrUTpy81w/mFId+ymfeTYQGafltOMujM1TBD
 2v5ES2mRfbtF6ZVz9r0R1dgmuouNaxOOQ63cm3twQGam6rXwYNCbVKNiItE9cEqCchOo
 DcpvpxnGvCDeYjJaZvxZdMPNj/mpuTXxaqmr7eAi0BURCM0sdWxvD9gI1ul3zNqDyRti
 ScOA==
X-Gm-Message-State: AOJu0YzGeZVct5Q3zx8hH6IktkqaaBzOyiB3BR/caUbvbqHCD9nwwJG2
 UvacI5geLZxcK6bc0BhXPVwtMfPuofiPU/Zpt9lEUs2a172xj1nLxJcfm9qoPagedDlh3JV2GiY
 bAGFt
X-Gm-Gg: AZuq6aJRWH3CqmYYq+o/tEzpEvis/W1ey8pZxVIXO1FuSg/Cmqpg/XzB1DyqDnUvkJz
 IwuKQ1iQHYboqya4ZAxV047TdEZmK/6ZqRJVEKp/ADXf2TeFAl7Pq9qBCYw/NHC048ZkdGuhie+
 Ivir9A/eQY8J2Mtvc9hIvn12xYwaVUwfgHevNc77wxbIJaa76is+qndVUBevr4wAOKzHiSiwPLD
 t4fELvuklruYEm9pJ/kT81Oumr/eyGQxxn5skEcYlpjbCfsyj9zHkRzz11q4lcbJQgRPoOSfFwQ
 lifMsak/m/9ECN82ZKplGHFtcFf9HfqECVSMdPoqSL+mvWnlhDrjKoUEfs7LVEsy39bS3sNYrmW
 Wzjj7t0HCIqiilpBXVkaLOOyXvIufTg1gVXoR+4SEKdoE8PXrlWlt6cJG1hMZu9l+q8cp7NRoe3
 yNXWqEZgl/5D1/WWlNVthrCf08E2DlNbKPL3LllNYTlnoSqTXkWg==
X-Received: by 2002:a05:600c:c111:b0:480:6999:27ec with SMTP id
 5b1f17b1804b1-48069d6d6d0mr27456415e9.13.1769531590475; 
 Tue, 27 Jan 2026 08:33:10 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f745dbsm39978513f8f.34.2026.01.27.08.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:33:09 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: [PATCH v13 03/17] graph: avoid overflowing comment buffer
Date: Tue, 27 Jan 2026 08:30:17 -0800
Message-ID: <20260127163258.75566-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127163258.75566-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260127163258.75566-1-stephen@networkplumber.org>
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

