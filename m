Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61180C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:28:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D40540F1A;
	Thu, 20 Aug 2026 07:26:43 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id 8D60D40F16
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:26:41 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so2236919a91.0
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203601;
 x=1787808401; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=716YxNguV57y/hkx5tSbGmp2oX8jpIN0MR23cUgCHcA=;
 b=evGBrGEBpcrBuTgqUGrd5HA5OakQvYi9rRBzyM/80XkUSzFKVr72UcJiQsGzzsysIf
 U7PLkhr9GKjFeF/CqDahwwACdiXEkHDSTiLK3vWdpoe8201K9+jihX/FUsW6qfW9HIgw
 uhJV0ADjIDgYzITQp4tObg5JkaOh38nW2QbmOsU5cbG9MFxfAzX6uxZp9FVzUyYX/A1C
 /d28hmoXQE4KOmZ3aXlE6nwmW1/iNedroHjGut1wuS5xrR1X9QHakc6A/bsauTXQYjEi
 bIG/MZeDe2U9s5mgi5J2LBA9Y7uNIJOW4XE+Z42w0JieffbnNROLT6pLqvD4wvx+SDO8
 K3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203601; x=1787808401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=716YxNguV57y/hkx5tSbGmp2oX8jpIN0MR23cUgCHcA=;
 b=ecosWJUKO2pUXCsNTsvm9CPjuoefb+n0k6uEspvHoFWw7yQd1smAihwNbKBD9oI0pq
 xeEHJ2VMCtyBtI9clN0ET8gYGsXTqR/7MUHlQYFIo40PA/TERFVkoP+LimsXdVzzx0e7
 4SXXXRBSxLEsNmMNiIbsbamVgeTle5MHk8hsBsP9MO2UuNUzZwZt90QKCtK1JZHuupcT
 6S1eYgfpAAOBG/9iESiEjm6NrnMw8CYMg2nxjwqrBudfQrQcrBxMFIVPdPBPf79ukFJZ
 Dj9ihOxTd5t7Ls6sRB0gYMGbUbZBYJRB5dCtY0T9HoDA6/G70idno9XKtnIaYt9/fyql
 aP7g==
X-Gm-Message-State: AFuF++n8zrkEjecP8dCFMpCGwt/EO3OQyGTG0OjH7RliDXLSM5YKzIJx
 f7EVWQlZmXwfE8XPCQq7LUCWCKwKFprv96G88aJT7KddPbWR4eWJs5cZZcThip5KzwHxQv+/Tsu
 curE/
X-Gm-Gg: AR+sD124E4h7UzhYAQRYPgVssQUnx4rG0J6Wd7SsbaER6j8pMAOaOxord3itV/LEsW9
 pge1eI1VC65KE9v855AyrnVODHcFvsMrLLPiIC3CfrIREFROd3IPhPJ0nhpKx2GVcKI6ViUgLfr
 ISpOMf4nVrmltZZKCSmWZBeMm7MtIIyzJ83klCaLcUulumF4AmgyTHvKbEfguM+tG38Blw++lnf
 y3BJqdVV0FKKfmY8KpAmprCKwLFN7JamKd5vnvC2QZMIPIYnOpG6KEuwQugibXt6kQqY9BruC8/
 AKVHQO3QToT+ol85dvOkB45PvqOtUCGwJ5Hi3I6y6lerSW54A45qyIfqweii6golTiiVQ+y3Kq5
 ZjYAS035CKT6aD57yAVByn4+iSnKhRnZ7KLI1g2+5UIBsBiqsHMfaDpLYEV8m19DqFk8U5bxblB
 AOM+/JmVQ7dXEuCIYf7UusW/Xq12WHgR3C5UZoyokTV28HGWv3OmpKd8K3borlyZwcoxhWwdo43
 q1VkoiV4W8b+nP3mKCo6ODuDW0=
X-Received: by 2002:a17:90b:5484:b0:37d:f983:7b5 with SMTP id
 98e67ed59e1d1-3958110cfc4mr19139484a91.9.1787203600603; 
 Wed, 19 Aug 2026 22:26:40 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:26:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 60/61] net/pcap: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:50 -0700
Message-ID: <20260820052251.1453273-61-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

The pcap driver is not used for high speed production traffic, so
any marginal performance difference from using regular memcpy() does
not matter. Regular memcpy() gets more compile time checking of the
arguments.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 08d3ab9e91..a22e41200a 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -25,7 +25,6 @@
 #include <ethdev_vdev.h>
 #include <rte_kvargs.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_mbuf.h>
 #include <rte_mbuf_dyn.h>
 #include <bus_vdev_driver.h>
@@ -233,7 +232,7 @@ eth_pcap_rx_jumbo(struct rte_mempool *mb_pool, struct rte_mbuf *mbuf,
 	uint16_t len = rte_pktmbuf_tailroom(mbuf);
 	struct rte_mbuf *m = mbuf;
 
-	rte_memcpy(rte_pktmbuf_append(mbuf, len), data, len);
+	memcpy(rte_pktmbuf_append(mbuf, len), data, len);
 	data_len -= len;
 	data += len;
 
@@ -253,7 +252,7 @@ eth_pcap_rx_jumbo(struct rte_mempool *mb_pool, struct rte_mbuf *mbuf,
 
 		/* Copy next segment. */
 		len = RTE_MIN(rte_pktmbuf_tailroom(m), data_len);
-		rte_memcpy(rte_pktmbuf_append(m, len), data, len);
+		memcpy(rte_pktmbuf_append(m, len), data, len);
 
 		mbuf->nb_segs++;
 		data_len -= len;
@@ -282,7 +281,7 @@ eth_pcap_rx_infinite(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		if (err)
 			return i;
 
-		rte_memcpy(rte_pktmbuf_mtod(bufs[i], void *),
+		memcpy(rte_pktmbuf_mtod(bufs[i], void *),
 				rte_pktmbuf_mtod(pcap_buf, void *),
 				pcap_buf->data_len);
 		bufs[i]->data_len = pcap_buf->data_len;
@@ -389,7 +388,7 @@ eth_pcap_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		uint32_t len = header->caplen;
 		if (len <= rte_pktmbuf_tailroom(mbuf)) {
 			/* pcap packet will fit in the mbuf, can copy it */
-			rte_memcpy(rte_pktmbuf_mtod(mbuf, void *), packet, len);
+			memcpy(rte_pktmbuf_mtod(mbuf, void *), packet, len);
 			mbuf->data_len = len;
 		} else if (pcap_q->rx_scatter) {
 			/* Scatter into multi-segment mbufs. */
-- 
2.53.0

