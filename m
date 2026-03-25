Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A7E109C05C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 20:47:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A045427D2;
	Wed, 25 Mar 2026 21:46:23 +0100 (CET)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41]) by mails.dpdk.org (Postfix) with ESMTP id 61E50427B8
 for <dev@dpdk.org>; Wed, 25 Mar 2026 21:46:19 +0100 (CET)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-439d8df7620so175210f8f.0
 for <dev@dpdk.org>; Wed, 25 Mar 2026 13:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774471579; x=1775076379; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rri0mcifg3R1IE4NoxLIxjmByHTJxxzDQK21jYqDVKI=;
 b=JI+PqJe1fBTbg3sqdmWs7zT85fDKH4YMgumqCxxRm1DHGWZFrEvjHnwsij5n0C3ITL
 /FbN9cNVMTmdjO2hT/38ehzHzMqKi9iP0lR1Nl6pA3lxao1b1gxG2WDmiMYHjScFJK/S
 w6E/nNYWpZ7jWwcg7O8SrLewGb9gWeefcLqqBWG9VnCfQWW9vEKwbmqiw2Mc1ieuMyuZ
 4/gWEwPwlcr1RztB4xo2TxtYd1ox46OUkUYUHHnRLnyTv/YX/FVOsYG9tKkf1PPS7Wb9
 5G+K5D1WsfAVkHYnP5nqe/CStWHN7DBQS2Q9xhyFP8Y/dDhOZOuhB+UrWSiM3PF7WhI2
 PtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774471579; x=1775076379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rri0mcifg3R1IE4NoxLIxjmByHTJxxzDQK21jYqDVKI=;
 b=emBCGe3BjAiTAb622zFF1mVi2u2xL4mbOZLY9W8W0roz/VQY21XMnoOzzjRFJ0mjd8
 /dONBqrvsxHvCw43NuvPhaUodSDAkRB/i5wJ+cVkyiExlgZOjrPpnIB4YZxEUecFIe1L
 1JM9FBbAUK/1nYjyiGjyMXUqpo/9/AfOtKLaE28GBdQqRVC1IvrJK9u/cuIyMUclqErD
 0XHXEZAKPNbEL9IjvrS/o96xCizc7LsP4cD3A0JSmFnMs7Ow/KmsbVMut/1gh1Di7qR/
 y6I7Jv+4wfPwc2K/cLoiSQu0TCyJUTDOx5U6lC/0YL70roPn5w7PEGA7Y71GrKpOHJk7
 IpZw==
X-Gm-Message-State: AOJu0Yzi199iRDPJAeiE7BgUHxuYosygLhMyZNFnwbK/Z1RY342KE1EJ
 zUnfSJz3ggiLhVmunTlHy8+7/E7gXyr0FmIJ6PGRI2FHmKUJkHUe46GZA5xQXvX4
X-Gm-Gg: ATEYQzwXfTd5DhSvRwwrPATgb8NbHXqvEGljW92t5tXDqtJJjhLmKzDgScfsczBFCz7
 IlCWSTd5q+/mXspHOXtl+ar5WflD0f67W6Qk+32M9InoTi1ySvd9G47PJCHihQecf0v1A7Dfdk1
 AabbwQwhreCk0kXFc3ZYEHzPeWHbFAb7sRvsXWk7WdIN35uqwVBP17mVLVx0v2nbvfJ0frP0QPn
 3HIHzW3GzCo/vi2fOM91kmtd5FXxjTQvVcqA9chPBec0T0a9tI/wvp4SVyMojeAweIJSWLY9CLq
 +ghPg/THGBEM6OctZP7zdm35V39hWCRmS8aLD+3QWQq9DU+qa+4N47a3XA5vB3uTtZOJhZmzkz3
 Y+NzzTeYrnbwQvCZGce2hrlseMBa2mg6sQqbAO0piFk0JoCaMPTje/bPuvdI6z3WoPBvDiCLpCp
 Q+UfwDCh23LUnOcC94OHZzdXtnZZU=
X-Received: by 2002:a05:6000:2f86:b0:439:bcc2:bf0a with SMTP id
 ffacd0b85a97d-43b889af1eamr7114618f8f.23.1774471578772; 
 Wed, 25 Mar 2026 13:46:18 -0700 (PDT)
Received: from freepad.. ([2a01:e0a:6f:bdf0:224a:2b64:3d43:500c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b91943312sm2677047f8f.12.2026.03.25.13.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 13:46:18 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v4 11/17] net/dpaa2: fix software taildrop buffer access
Date: Wed, 25 Mar 2026 21:45:38 +0100
Message-ID: <20260325204544.101444-12-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325204544.101444-1-maxime@leroys.fr>
References: <20260306133035.179709-1-maxime@leroys.fr>
 <20260325204544.101444-1-maxime@leroys.fr>
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

The sw_td path in dpaa2_dev_tx() reads from the wrong position in the
bufs array. When the goto fires, bufs has already been advanced past
the num_tx successfully sent packets. The first loop then reads num_tx
more entries starting from bufs, going past the end of the input array.
Additionally, the buf_to_free segments for already-enqueued packets
are never freed, leaking memory.

Replace the buggy sw_td code with the same pattern used in
dpaa2_dev_tx_ordered(): free buf_to_free segments first, then use
rte_pktmbuf_free_bulk() to drop remaining unsent packets.

Not tested, found by code review.

Fixes: c3ffe74d85be ("net/dpaa2: support software taildrop")
Cc: stable@dpdk.org

Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_rxtx.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 689e5e7ee7..8275ba9780 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -1517,21 +1517,15 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 	return num_tx;
 sw_td:
-	loop = 0;
-	while (loop < num_tx) {
-		if (unlikely(RTE_MBUF_HAS_EXTBUF(*bufs)))
-			rte_pktmbuf_free(*bufs);
-		bufs++;
-		loop++;
+	for (loop = 0; loop < free_count; loop++) {
+		if (buf_to_free[loop].pkt_id < num_tx)
+			rte_pktmbuf_free_seg(buf_to_free[loop].seg);
 	}
 
 	/* free the pending buffers */
-	while (nb_pkts) {
-		rte_pktmbuf_free(*bufs);
-		bufs++;
-		nb_pkts--;
-		num_tx++;
-	}
+	rte_pktmbuf_free_bulk(bufs, nb_pkts);
+
+	num_tx += nb_pkts;
 	dpaa2_q->tx_pkts += num_tx;
 
 	return num_tx;
-- 
2.43.0

