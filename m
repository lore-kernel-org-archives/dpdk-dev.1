Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87423D3749B
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 20:16:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC60840616;
	Fri,  5 Dec 2025 21:15:52 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id 75C83402F2
 for <dev@dpdk.org>; Fri,  5 Dec 2025 21:15:51 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so31981225e9.2
 for <dev@dpdk.org>; Fri, 05 Dec 2025 12:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764965751;
 x=1765570551; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vmW0EapljQF36KN4JI48XscDOxvks/pvjTAp8iLdZ8=;
 b=G1r0Vo6y/VoPjl7urXVf1tKjGHeqgo7mfHlrEGQRACXPoXZpx/5qQkQMX7f79ZPW/Y
 n4rklGEJ7RLg2G9tZI6SzROuf2uRuscm+L1OI1QVEYuvOiWphAGWlNelsGynNE9SN0YW
 cp1PL4u7xYG26sRenncckq8A6JkaAhW1VwfPLu+8DgTdbrqR3kNUR2Uh+mlethXPXD/Z
 i6CiAJtcvG05TsT/F5Vfoy+7FoebMKFzZ547w6Z5sgJ7tBrMjCL7VOqsGnTeFFFU9IiS
 XtLuwFpvKIeX0qu9Mi02IvFOHv7kg+yIOML0kqPjMPPrj00I97KNCxzJ2HM4VuVskWaG
 dA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764965751; x=1765570551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3vmW0EapljQF36KN4JI48XscDOxvks/pvjTAp8iLdZ8=;
 b=akVpSFtQaonISfCT9lx+ejJ3U5ymON5b3ZQ1sJI3NE0iUVY5e/35vV/EeHWGwHPYdi
 IG3vuhQbMJsGDGHHIMXhZFNAaUGnHK8U5VncWQk68Du18WALyJ4Io8mZ4Kg6HUA3R1Pm
 n4nTDu+PV+EOX343ZW/M1+9XqH8mXcu4WjHkSgZfutyYEZ2o2LTXzLljadDWhftEEsgO
 quPGrz+QHdYjLrtkOyJYrsFf/C8crQAPLYXKQcpH2sKUO4bk+l9eI+56vIEE1IBWM8gg
 aXk4bAqnd3N1gyhDIhgMazxJcWWGq+zCZ8UJAan2GsshM/mdl62E3bfb/INLds7xUv+d
 4MHw==
X-Gm-Message-State: AOJu0YyBZqmQl4P1WGQ6WCg/v2CdG+zTMZySfQvcjP1aZICGZXBYLVNb
 EyANrsF3MIMZuWHqnFQFA+fOEz5hRQML/SFtupgYah47uHPsU0+2Jlc32C139Eto5m+CGRWCLEe
 f6EAQ
X-Gm-Gg: ASbGncsUruAfAIUMC7Wtk1R3IkmFFJagT+pAH2ZDxpmwCFHFCGvbj4OsZPWP+epF7F+
 hWuZrRE821JjaimAS2TGYcOxVTFeYZot9UjKHVidKWw/CPcDa05Zo2ffNkUaMtFSMlZuiDWFkjB
 EkjMEQnfFxG4B4VoG48KygvjfhSrQrkL4rodDx6VIlzBKjhdc34jp+m2EUpzChlh+wOXMEZ1b4E
 E1LQBvhgvpqtH42MrZ0n5EWFGU7dfglBNDFTIL7wGupd/F9LVOvHPz76NJZj3Qt68HHfzRdvHr1
 /j8DcSlrswDSkbWN0/GanTwAPVJYzMHChgh2h7R0FyaDxR6CwPVKS51udOU2LDpDr00apTRnpDw
 6UN3gYPvoF6Z5xsWLWBN4EdKIsahrnx6noO8u2s1mQ4y3LGKhNu06cAmM57TNso8R20u/qPfvX7
 w/WWwMnyWne43p7+SkOYjuNxR3k1Qv/PdOGm2QO5LUiIL1v8iXkOY/sp6hVRpF
X-Google-Smtp-Source: AGHT+IFJNFdXMXi2wreGgaBSz70GY66dZ35Z4t/VHn0O0zXeel0yCkuCkgFdX4kTuQ+mSys+eTi6EA==
X-Received: by 2002:a05:600c:a09:b0:477:58:7cf4 with SMTP id
 5b1f17b1804b1-47939df17demr5474935e9.4.1764965750982; 
 Fri, 05 Dec 2025 12:15:50 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47935fce542sm45344875e9.0.2025.12.05.12.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 12:15:50 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: [PATCH v3 04/16] graph: avoid overflowing comment buffer
Date: Fri,  5 Dec 2025 12:11:33 -0800
Message-ID: <20251205201537.251131-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205201537.251131-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251205201537.251131-1-stephen@networkplumber.org>
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

