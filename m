Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2324A606A885
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 18:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=FyQ6MTtW
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 503A6402BF;
	Tue, 17 Nov 2026 19:32:45 +0100 (CET)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTPS id 2F68D402A4
 for <dev@dpdk.org>; Tue, 17 Nov 2026 19:32:44 +0100 (CET)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-cde1479f76fso136245a12.0
 for <dev@dpdk.org>; Tue, 17 Nov 2026 10:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794940362;
 x=1795545162; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ii+Ewqh2TQ8iqosj1vPnsfobjL3cVawVC7E9XT7Yg3k=;
 b=FyQ6MTtWGprtretm9s5Z4F4yt5QJ3wEdpMg1YQbApsvhvZL5FUKDmX8rak2mOutKuJ
 2/xjtUsNxvAPQZA4NKJhes8O4iBSPYZ2TNurkWWukMITVT0Xf5oDbWo/5sL2XZktXhIh
 cL0JQDCAiUR5oO3y4oIiPHYH7IVBlRbj/F+bcVwqHcYD5zF1wFXByEecVitRYlB3aNyf
 C1oNqFH6CNauYhUWdj3lAFlozhE+unmfEqu+zGlzZqqG9pXyhtqsobbccCF9eU6+IPvP
 D8XjScHjZ+KeoKJsA0vqWZrD233/2Zk2V3a3TtAMN7deLL5BTvja6N9uIbmsKaIYLhuC
 ifaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794940362; x=1795545162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ii+Ewqh2TQ8iqosj1vPnsfobjL3cVawVC7E9XT7Yg3k=;
 b=PEtkyC5WTDkdrNLmsdQaMcm5AW8LANGKdi2rVwD01f2nNcyuPH/k4hqDP/QdHY3ZVQ
 eSfDJSIge656pgGZI8Bk6Tq9chjj4KUDXQIVudv+nJ99ZEtZ7Hc455kjCLcGfkdCXVF+
 IkfKvjgmhZ6uOgFfRzOYnQCVtjwKux4foF/BJsFsSkvPgHjCWFH0YVFj3MJV9R0idnvS
 dchf0RT9FJHPwBKUfJ25ozEauLXXrDPmG2DwSrJDLt5dXEB3Wp8qQEbKSeWHV/XpRCsb
 fnLkRRujmOcqEHq4OK/2+Ey2tqr1W5ypVy8mw4EMU5gRRYOlbfLr/N4/7jiKhFY/z1jB
 wfbA==
X-Gm-Message-State: APuU4Z8XDx6mzUEsNkHzJq1RRMx/AReWcIkxjgjuobhKeeqQtF29RS2K
 sTCmCjtE91m5Y2Pjm14oJW7PIUs7OBYRb0qZAkiW/zco9UBF223h4rYGUQWwSt71fBO8iOD1Prr
 yz2lWQL8=
X-Gm-Gg: AZFdTZf7HCiwafaehvJbTsFioj69hCT9LJRpDzxuDwnsKSDKE1BuFEDhnvfq+ClwgrX
 5Q+jlmHM4df8uJ9W68XLuuuVF6T5SBYmbQlW910pXKDkQIkllw9W7d+0Fih/9ZgqA6uiZlcGSjX
 QGHAH2MZQ0w9c4MyO2Y+1DCRrzzIk42pIc+uW5V3KwpAxj6QHwT0CYTKg0NudoOzDSd+/1H1N0U
 rjj8W2aV8/umH40BE+AGd5BualEbhXMISwQ6PxPbsMG4Pu3KDK8JiYSfEQ56gr8Og7xYsCdM1hT
 kSjy0Ef6YfI02q2n05RyAMCQpPkR7xeAbsJkUqMFaNlVcfAXlbb5/FKbvPxakXNzMDesrnh1olF
 oLfJs2BRT18XYg0NH5i/xns8gjuErkfmkAqZ/0nYlrT7dMjYDaaiN4zbS9pQ40idwpLw2UAPLzw
 EJEUyLnopa8//INiuAPDE/4NMBoiqe+YNz2ZRhnr8HBUUmjhxxpv4gznaUZR/1uXe448o7n25b3
 NPWSpe8xNoAGzakQxHY3LFhIoakXb/h2qU12+Lfte3E4O94xPBQV6JKWihLMxYtkt101x3f2hYt
 a/qofA6Lvj0YR5vcJSOYx8rHsaz5s16tvG8Rt9x7/5IhFv/4qUVYCyRG53dBeGNXy58HYtw=
X-Received: by 2002:a17:90b:2241:b0:3ac:a6a5:5743 with SMTP id
 98e67ed59e1d1-3b3d076326bmr259045a91.32.1794940362384; 
 Tue, 17 Nov 2026 10:32:42 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3d1d3316bsm66893a91.1.2026.11.17.10.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 10:32:41 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v2] net/pcap: fix handling of transmit errors
Date: Tue, 17 Nov 2026 10:32:12 -0800
Message-ID: <20261117183240.852179-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116232834.1190655-1-stephen@networkplumber.org>
References: <20261116232834.1190655-1-stephen@networkplumber.org>
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

The pcap PMD assumed every pcap_sendpacket() failure was back
pressure and stopped the burst. A hard error such as EMSGSIZE or
ENETDOWN caused the same mbuf to be returned to the caller on every
burst, stalling the queue.

Only treat EAGAIN (socket send buffer full) as back pressure.
Drop and count the packet on any other error, including ENOBUFS
which means the packet was already dropped by the qdisc.

Use PMD_TX_LOG for the error message, as other errors in the Tx burst path do.

Bugzilla ID: 2132
Fixes: cf91cce204ea ("net/pcap: fix error accounting and backpressure on Tx")
Cc: stable@dpdk.org

Reported-by: Anthropic OSS scanner (ANT-2026-DLCI8IK6)
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
v2 - fix AI review feedback, use PMD_TX_LOG

 drivers/net/pcap/pcap_ethdev.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index fb18f0932b..1b8d6dafa2 100644
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
@@ -666,10 +656,19 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		data = rte_pktmbuf_read(mbuf, 0, len, temp_data);
 		RTE_ASSERT(data != NULL);
 
+		/* pcap_sendpacket() does not document errno, but it is the only way
+		 * to tell back pressure from a hard error.
+		 */
+		errno = 0;
 		if (unlikely(pcap_sendpacket(pcap, data, len) != 0)) {
-			/* Assume failure is backpressure */
-			PMD_LOG(ERR, "pcap_sendpacket() failed: %s", pcap_geterr(pcap));
-			break;
+			/* nothing sent, caller should retry */
+			if (errno == EAGAIN || errno == EWOULDBLOCK)
+				break;
+
+			PMD_TX_LOG(ERR, "pcap_sendpacket() failed: %s", pcap_geterr(pcap));
+			rte_pktmbuf_free(mbuf);
+			tx_queue->tx_stat.err_pkts++;
+			continue;
 		}
 		num_tx++;
 		tx_bytes += len;
-- 
2.53.0

