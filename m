Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71597E6FE24
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Dec 2025 18:14:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91072402DC;
	Tue, 23 Dec 2025 19:14:30 +0100 (CET)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41]) by mails.dpdk.org (Postfix) with ESMTP id ACB8340615
 for <dev@dpdk.org>; Tue, 23 Dec 2025 19:14:28 +0100 (CET)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-b7a02592efaso763818566b.1
 for <dev@dpdk.org>; Tue, 23 Dec 2025 10:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766513668;
 x=1767118468; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vmW0EapljQF36KN4JI48XscDOxvks/pvjTAp8iLdZ8=;
 b=XAMBonXaHJpcer7mWQ0GNPuwCI3/UyoYjSCPY05z4YY+7j31aQzNbwSnVZUtgAzrPN
 Qu1akWQCKGdmA2jFoJUrvcm3cBqq9PL8TG9V0F7sAqWnhWwETK4b+5ZaC+hKFv3TClQc
 ArWNKkcv3rzJsEg83p0BZL3q5Tj+XtXqSt7+vAZ8OQwp/M7+uV3wmn3pKelwrMbVFP4V
 SIkyN7oYq7OsHNcNKIM5hL0sMxbkHM5QCxNfHUdoMuSVtEP9eD4Q9+0nWxmPY+KNNnRn
 VzmcIhQtLHIMm/5KeXgMD+043UpvFYZMvm0LbxuwZyO1DQb68SGzikVprZimEAFv7Z4I
 EdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766513668; x=1767118468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3vmW0EapljQF36KN4JI48XscDOxvks/pvjTAp8iLdZ8=;
 b=uuofcpPrQRAbtzUaq6M95740dhEAczKy9edOoJJ4ymiIPo31gUuw6s9zbg1nIDB9FG
 9IF+1Pbl7tk3E+O82HGcejZoynhhBymqibuimSJOI4o9WDbEb2xjjaAV/c+7stTXqzCI
 FE549F5C3PyZMylcWSeyplt8IHjgM+4YYSh6NMua64/xkrpMPorfn7vAw47VVuyYgUwq
 5dYowGN6CQCpWMIErcivlXPStfRoG4FE9K1UBnsMTIXY/7aTtgssTvtZtIYSHwnABPuU
 1dXLuKVGFyl44c9oc6UzFzMAisor+GFGabgZ0vasuKm75zj6w2B4WIHclksl9rU0JyHc
 9n4Q==
X-Gm-Message-State: AOJu0YxcTPn3eOBJ3Rs7Ei9CbSCL1cKrNduZbglO7kL3RCS1z1yebu0w
 pNxW5X0nJQAS/8CSbBIkc7jeAC4cpTwF8RsOcLpNQgXWl4e1ud/WwS1qWV10I5NGspk7usvZTPC
 NbOQvxQA=
X-Gm-Gg: AY/fxX7Yzn6imLFcxaz3jURHH9dgW4Uq4GOBWydFQB7mc/Bs45kLK2ifF3DoxReLANH
 BgQ7/+7TsO8rnZiDVG+JVnn1p/wVk89aDhpbXYAyzK0zBOOAT2bynMZ6ctiIMNXKUnoUl7yWAfP
 j6aM5abaoHdJenMVHRmDVggIxlecSEgsEEilzubO4BwrYKCGHE3Hnshr2C4tHbtDpiFH8vxr//t
 ZfAJJf2qSpp2wZvwDcKxLgg3FL8T/uDLcVaD6ZlCrvuw2OzeoCUNih/Sjrw71ZEZomENfa4hwgf
 hgx46Exmi6iWwXUhkgj319AgpJVAC15Q3hG6tIC8Ozg18drexMu6cbn/qmU89hJpgMOo7PPuaDl
 AvsAT/dC10eZ6iAcEYygOL8xsRJO0NJawEBkX5BGHlsA/FWOq0w6AZfBvXpomXFoQcze5C3Jj6j
 BAMlihA/HgBnQ/nf87CapgMRPiLrYnOzwWL6ZeLPeJUuHncjsBLA==
X-Google-Smtp-Source: AGHT+IHWp1bOpvUc43hK4rVXlmvIl59xf84z/I810jWqh83qOKwYKkSdMV4WxSEKwafI5M1CBTR39w==
X-Received: by 2002:a17:907:7621:b0:b80:3fff:420d with SMTP id
 a640c23a62f3a-b803fff4ee0mr968178366b.24.1766513668056; 
 Tue, 23 Dec 2025 10:14:28 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037f3e271sm1495302566b.60.2025.12.23.10.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 10:14:27 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 03/18] graph: avoid overflowing comment buffer
Date: Tue, 23 Dec 2025 10:13:01 -0800
Message-ID: <20251223181418.40834-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251223181418.40834-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251223181418.40834-1-stephen@networkplumber.org>
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

