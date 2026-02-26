Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCE8FCE095
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 14:35:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E867840DD0;
	Thu, 26 Feb 2026 15:34:21 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 988B54060C
 for <dev@dpdk.org>; Thu, 26 Feb 2026 15:34:12 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-483770e0b25so8872575e9.0
 for <dev@dpdk.org>; Thu, 26 Feb 2026 06:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772116452; x=1772721252; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JNHxAXhg+1LTd1XjDocL2VFCklIkAYZseGvdrxbgqLI=;
 b=afVQHopNpg4lLI2V7AGPAdcUNFz6nqJbKgnPgDX7QQ5++bjPbK8LxqX/SgNF0X+1wX
 98CNdWVbOWDFX+hzYekE4XljOGPvJCS4zhXm5eLBZ2afL7GMhIHriw9hKW2PSrW+Ey0T
 trahx0mt6ueETIs7UzCAbIf4Yta6yndxhmvJJ0QSgGTaZDEujheZKYlS/O7I+xgBkvtU
 XmqjKRXVARzN3oEMq/wTnPFbrMTKgrS4qgkwK3ZcMvGgI+bUGFKbLqtUbA11+7BIDePX
 iF3zZUUOz4OiAeDPULNJN3mwmGtyzTWA3dBG6LIr+igeS5Mb/51GtIbNwR+WvXHVl/5k
 Biuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772116452; x=1772721252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JNHxAXhg+1LTd1XjDocL2VFCklIkAYZseGvdrxbgqLI=;
 b=JgtTAF1V6C2kNO5jDpokAi4HPCU+taG6RRWuCuQLdAPsJLTEmCYT7iU7upyYdiByaz
 My/5NVm+ZgHYt9uupAWd7Tq94qVMfQab9sfRH2d/0vQzsj9xxt6vvKujD8GUugtmbPId
 m5uibRp4ScS/p41JqHxnzayP692mzQdetEB9XznjAm8J9uZUlUeHO+OVqzByuB7GNEpP
 mhN91Di6lAmcifKUvdLV3CADbZpSX2uYmN8uHA7rrfAi7GgOtdQNe9+mCZ9dsQ+Qrpj/
 j0Y2L1EAVetYjL0dTWyA0TLKD8apZb69ip3BEp9Z/KrewNx5caC7BgemdYvx3vWWNCVW
 YetA==
X-Gm-Message-State: AOJu0YzRusb+EHHGsT8ZS3iYQr4gIU98+NLFj5nTO3JuUikp+IPy6FUs
 +LKGW4P7/gnwxACvKuWydeI/ABK8lCyW/RFcAHw5gnASb1v6lgv+dDZu4ij3pg==
X-Gm-Gg: ATEYQzyK+mQC5HtIvsgeC3p1FclRQlPJmOkOHuou1sczhuyZ8T4g6Vo8QFeo5c+L4ps
 8JUnXN/O+VjTVyR2MvYyf85lh1yt4d3707+Iy/GPpMs9lPAKHjtS+wq6xI4tJAQByEczZbkhz5l
 YJDL+/UAJV6D5/oWmNXN6mSbkK2yIQ/SpJakgnZ4Zdr9U8ZSuAeHBFTuX4UuD7vIT1lWvJj961H
 +6lKMCQQ32bUpASMMx5JDU4Pu8z4dnWmieKmnv6XPhZDybtzUkfWxpmXVqs1d9lT/c7IzDCcOKG
 NdXKHG6Pxp7Fh1jI7dPY7nTLORw54g/DyCWOIREKAiN4Snx48qpJzqymDaC+NkpzJXRcoUpDpVx
 2mhPNv48xwRzvb5oDGH+cTwa7dH4KOMsmkaUrx8efDgd6i2oGJJec+exolhcseH0svbLWcQDAoR
 QGl3nlj0HKi/Bo872dqgNeU2EuVw==
X-Received: by 2002:a05:600c:3587:b0:483:a27e:6706 with SMTP id
 5b1f17b1804b1-483a95fc063mr344511135e9.9.1772116452079; 
 Thu, 26 Feb 2026 06:34:12 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4398bb96b90sm17993866f8f.9.2026.02.26.06.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 06:34:11 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v2 11/17] net/dpaa2: fix software taildrop buffer access
Date: Thu, 26 Feb 2026 15:33:35 +0100
Message-ID: <20260226143341.282188-12-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218160453.142311-1-maxime@leroys.fr>
References: <20260218160453.142311-1-maxime@leroys.fr>
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

Cc: stable@dpdk.org
Fixes: c3ffe74d85be ("net/dpaa2: support software taildrop")

Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
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

