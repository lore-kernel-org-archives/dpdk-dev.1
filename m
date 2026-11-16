Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3C1606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 23:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=PddY1r4F
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B1554026F;
	Tue, 17 Nov 2026 00:28:39 +0100 (CET)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTPS id AD24540150
 for <dev@dpdk.org>; Tue, 17 Nov 2026 00:28:38 +0100 (CET)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-cd6acc50b8dso1979364a12.3
 for <dev@dpdk.org>; Mon, 16 Nov 2026 15:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794871717;
 x=1795476517; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=z5jaxOHOtJEi7JEi5YoAeZWH3CKYMx/3KQaINnHrjFU=;
 b=PddY1r4FaZHDduSTwk9y1yJ6xfRW0TjDvl5Q2MxsiNLK041q7jVG8MO009yK/mhfWT
 SL6fMCZjxF+1WZdEfwXiOVqNueAraCxj3B06dUA5+c83u2BDBmM/aDemoIB4mld4oF0/
 YKnDWi57n/tj4QSxbfethSXKccqaZ1xuuLC7OAk8ZzC2Doh1FrB/aeOft7WEVA/rzDYw
 5k2A41K9lFMcZ6/bCzfbgPXREqSUzPJUPw7loEtffIudHs6/pmuzeIZGWus6Ypkt0wcv
 6GJrsg486k642ck8VjsinHHfwUbCaWSbf8IjaMjQksfrFLs5NgFyUHz1C6EM4k4g5XBe
 k1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794871717; x=1795476517;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z5jaxOHOtJEi7JEi5YoAeZWH3CKYMx/3KQaINnHrjFU=;
 b=wl7sWCrsXBoRvTHCe2DtP2JWwS/5xoWSTjt9zuP8f5sowzsATf2Zv7wWa7wNzOX0bh
 CTfBYKQd8ckvFcRmxLWdVochlPN4ktE17jhfwqXCHbOrtn9SHp+3nfIOrHbVdS+McHNF
 LT/rd3+3DCG8drBkHpoRP018NOTPFP06efnfQGpBjpWtmjY75IPK6jGCtuvKDPkYRJXr
 W776orcQMjsZjEoUR0Vo9muR20KLvOiLEukRY6p/jV3V13g5fXN9RZwAGZ3HkUBfOE1A
 ijI+RWsvlHqozgTjmay5DTLT+EKZMgRFPdZ7/3ziSa+P5IfW35BZw2QWbZ7Ms0ej7158
 y9+A==
X-Gm-Message-State: APuU4Z/rve0sU4Vr4nL6QZUbPIDYQfV7ZfZkXXJUI8hFVUK3fK59YjHY
 UCI22nkVGfzPq7P/V4XXdBYt6oW2ONGSVCQFd4xDTJfrLjr+Iz4pXYtrtmGbxP5bin5BM10w3lW
 EWLD3
X-Gm-Gg: AZFdTZf4d8uLbJ6aCsUC9huslgIYKAm11FDc0MogzucxEJPbwl2TojewtboIo7qqcCi
 P5o/JQJauotlrEGW7/qaT3zwpqYGOA3tBjS9AJkEmGrwKyKcFQgqKr2B/1jThdMITJLhULiLFs4
 qNJMjoiUnc6IVupKUm0PZjW1dIDVTeOmeRiyKdgm6T8L52n+cs9abVjdcj3qG8Sj6867FtXl9id
 d0XPuEu4mbZzk6WgxS1znU4NcjG0Ht8TA0+bWHi8VygIPmlk75Gl6wVOrtbsskgi5PbZt1j6y2M
 bpW/HCdCAtSc7U8Sr3q9NpRWZRoSKz+yqHv7LccP1zO813nuQYe6ySLrEjmXK3BywCTDitePr6k
 KIqu081w/Z+Y9v+3TP+M2ycuvf5U/eD04CE3XBo2qALxn8Okfg6h4C+5x7LcqC8a4hG2GuKHQar
 7wrPGTC0gIoPLnIHooMiUdc1NR57DuZDQFdWytiXk9hhq/XikgCncsO9NuBgPsPT6nWgvezdlCs
 7PJgx4WeAHRWEbtNXmrTEolEwpDaiiyVlj1uMHoX1Ibcg2yXWB94QOedr1Ftiocncqn2BTHaUv9
 eh/7sKB3ssSFtwePbYokdFBAM3piGJ/5VirwsEg2aRSsj5GeBTrMrh5RoABczM5P4cbQRwM=
X-Received: by 2002:a17:90b:3146:b0:3a0:e4ce:31fd with SMTP id
 98e67ed59e1d1-3b1b0a42b59mr11733264a91.10.1794871716999; 
 Mon, 16 Nov 2026 15:28:36 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3b3f7ae72sm124923a91.10.2026.11.16.15.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 15:28:36 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] net/pcap: fix handling of transmit errors
Date: Mon, 16 Nov 2026 15:28:34 -0800
Message-ID: <20261116232834.1190655-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The pcap PMD assumed that every error from pcap_sendpacket()
was from back pressure. But in the case of bad mbuf or file system
full or other hard errors, the packet needs to be dropped.

Bugzilla ID: 2132
Fixes: cf91cce204ea ("net/pcap: fix error accounting and backpressure on Tx")

Reported-by: Anthropic OSS scanner (ANT-2026-DLCI8IK6)
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index fb18f0932b..e7a8f007e0 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -607,16 +607,6 @@ eth_tx_drop(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 /*
  * Send a burst of packets to a pcap device.
- *
- * On Linux, pcap_sendpacket() calls send() on a blocking PF_PACKET
- * socket with default kernel buffer sizes and no TX ring (PACKET_TX_RING).
- * The send() call only blocks when the kernel socket send buffer is full,
- * providing limited backpressure.
- *
- * On error, pcap_sendpacket() returns non-zero and the loop breaks,
- * leaving remaining packets unsent.
- *
- * Bottom line: backpressure is not an error.
  */
 static uint16_t
 eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
@@ -666,10 +656,18 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		data = rte_pktmbuf_read(mbuf, 0, len, temp_data);
 		RTE_ASSERT(data != NULL);
 
+		errno = 0;
 		if (unlikely(pcap_sendpacket(pcap, data, len) != 0)) {
+			/* retry on soft errors */
+			if (errno == EINTR || errno == EAGAIN ||
+			    errno == EWOULDBLOCK)
+				break;
+
 			/* Assume failure is backpressure */
 			PMD_LOG(ERR, "pcap_sendpacket() failed: %s", pcap_geterr(pcap));
-			break;
+			rte_pktmbuf_free(mbuf);
+			tx_queue->tx_stat.err_pkts++;
+			continue;
 		}
 		num_tx++;
 		tx_bytes += len;
-- 
2.53.0

