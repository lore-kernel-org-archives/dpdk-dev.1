Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB98EA71A1
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Apr 2026 16:12:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05732406B4;
	Sun, 19 Apr 2026 18:11:21 +0200 (CEST)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com
 [209.85.167.170])
 by mails.dpdk.org (Postfix) with ESMTP id 534D74067E
 for <dev@dpdk.org>; Sun, 19 Apr 2026 18:11:18 +0200 (CEST)
Received: by mail-oi1-f170.google.com with SMTP id
 5614622812f47-4756e74f8edso1618516b6e.1
 for <dev@dpdk.org>; Sun, 19 Apr 2026 09:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776615077;
 x=1777219877; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yPc1fgSXnlltXkF34J839WbgX3fCuo7u/z1Pe9ZWQrs=;
 b=ffE7VoAy9rRbuonwk/7PyGzaq9ojm2418ntNxMTC87cLR7o58+ZmMEQ9gzDgEHrBAl
 526hY0SCo0xxs+UsC5BiIUTJ7YAMNKHWJ6mAc2PBVhTYKmtGcNCJMU4FQ3FikYj7vvC9
 J966RMk8WLYj9G8dbpbN/0UV8cVMFfvN+Y0m9buuT0SnW8hLauRZBz3ivdird0qsB5IV
 UhRHqDL1it7V/Mhqp4ZW15CEpYNH8y+LLQT8J4uC8CSbrzd8nox/soChbYJsS94a/ema
 GCsjReVoRKgqgYYZNn//8CU6eYyOOEBLy4UK9uMvBjbgUEkxdadPFkXs8ctjnaBWuT/k
 K71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776615077; x=1777219877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yPc1fgSXnlltXkF34J839WbgX3fCuo7u/z1Pe9ZWQrs=;
 b=diXlj5jhwi5HEkgKuycTdaERApcRW0U2iqMUBTEZaoS8J1ycT4lSVivFeKqdm4LY5t
 nKPVWld2/wQ5GF7r0oeVmI3Rm2z53Nv3+2mzw0PW05J0k2VcfYDy4+pgMfRei+zf5PYv
 Yyt/uHNaLPW6PxE/1I7FwGkWbCUhBmz4H54vjFGKAwiDKVtck1UYG5En82ZnaUT6fHbW
 Mq3x++4GzGI6IgsIzShgx05rrzsLh2v9l9RdDDZRtPfVjlAYXaj4IlRip8XX9SNoUyu4
 AA0wEzgqyYH6QGl+NLCdWx7m8qy53ojrVnsh3j72Eyhhcow+qIP45/UKucjhmImV2y05
 GVVg==
X-Gm-Message-State: AOJu0YyI5LV8X7ZpK/RdbqQi0LEqH3ujj+2982irRdiBt6gOz8/eevNG
 K4D3zNDj/R6qYHb/9ZFnL95Pa+1wUzeugUau4Mywp8z44xk4fNf/iC4kbuZWMzuUkpUYswVzk6w
 VJSvp
X-Gm-Gg: AeBDieuLrC9dm6x6Wpp/52dIsJKhOTJGvbnOjXfO4hUDHdtA/dzG0QUYX2ZqNmeqoGo
 oi+WqZVPaPSq8V1ZXRji3TVi/cE93/gL7uuESD+2/krp3gtTvQgt5MaE0ecHpJj5+StoYcYYmMs
 HZVi7lQkrn0hy8NYWwpyqEsmlTM4G/tWtQNJ73Lq8bUBvHKr1nkEGyM2CzIllBhUwldZpF2IinQ
 EpfPF9rEPh4+v5T88dX07fgfjDqPPe+obzxd6M+iAAiWjsQiQ/q6vudm27UQfDlBsGPdXBNn+nd
 I+qMj+nU5Tx0qFSYUWfu+6GG8GeAik4+W8LNwhpBsVRf3y5Inlrwv+Z8AhYskSv/sy3N7bTM+mE
 nHrrF0nhK0LGxzKxaUsAXaOPE+YTvNxdC0b6RrIzfnNJgcbkR9xHskU770/R57o4p5/V/Pp390G
 r0Z4UXI3ZWovtOurPVbSQh+RUh3PnoCVxO18hzCzXBx0A=
X-Received: by 2002:a05:6808:17aa:b0:467:254:ba8 with SMTP id
 5614622812f47-4799c955a5fmr5423628b6e.11.1776615077526; 
 Sun, 19 Apr 2026 09:11:17 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b930bca47sm5970632fac.7.2026.04.19.09.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 09:11:16 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v25 10/24] net/pcap: clean up TX dumper return value and types
Date: Sun, 19 Apr 2026 09:09:43 -0700
Message-ID: <20260419161059.205954-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260419161059.205954-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260419161059.205954-1-stephen@networkplumber.org>
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

Use uint32_t for packet lengths to match rte_pktmbuf_pkt_len()
return type. Split rte_pktmbuf_read() out of the pcap_dump() call
and add RTE_ASSERT for bogus mbuf detection. Remove incorrect
err_pkts accounting since the dumper loop cannot partially fail,
and return the loop index for consistency with eth_pcap_tx.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index ca08b8e342..edab1723f9 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -29,7 +29,7 @@
 
 #include "pcap_osdep.h"
 
-#define RTE_ETH_PCAP_SNAPSHOT_LEN 65535
+#define RTE_ETH_PCAP_SNAPSHOT_LEN 65535u
 #define RTE_ETH_PCAP_SNAPLEN RTE_ETHER_MAX_JUMBO_FRAME_LEN
 #define RTE_ETH_PCAP_PROMISC 1
 #define RTE_ETH_PCAP_TIMEOUT -1
@@ -407,7 +407,8 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	 * dumper */
 	for (i = 0; i < nb_pkts; i++) {
 		struct rte_mbuf *mbuf = bufs[i];
-		size_t len, caplen;
+		uint32_t len, caplen;
+		const uint8_t *data;
 
 		len = rte_pktmbuf_pkt_len(mbuf);
 		caplen = RTE_MIN(len, RTE_ETH_PCAP_SNAPSHOT_LEN);
@@ -415,15 +416,16 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		calculate_timestamp(&header.ts);
 		header.len = len;
 		header.caplen = caplen;
-		/* rte_pktmbuf_read() returns a pointer to the data directly
-		 * in the mbuf (when the mbuf is contiguous) or, otherwise,
-		 * a pointer to temp_data after copying into it.
-		 */
-		pcap_dump((u_char *)dumper, &header,
-			rte_pktmbuf_read(mbuf, 0, caplen, temp_data));
+
+		data = rte_pktmbuf_read(mbuf, 0, caplen, temp_data);
+
+		/* This could only happen if mbuf is bogus pkt_len > data_len */
+		RTE_ASSERT(data != NULL);
+		pcap_dump((u_char *)dumper, &header, data);
 
 		num_tx++;
 		tx_bytes += caplen;
+
 		rte_pktmbuf_free(mbuf);
 	}
 
@@ -435,9 +437,8 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	pcap_dump_flush(dumper);
 	dumper_q->tx_stat.pkts += num_tx;
 	dumper_q->tx_stat.bytes += tx_bytes;
-	dumper_q->tx_stat.err_pkts += nb_pkts - num_tx;
 
-	return nb_pkts;
+	return i;
 }
 
 /*
-- 
2.53.0

