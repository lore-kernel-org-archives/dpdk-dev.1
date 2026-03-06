Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1125F01832
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 13:32:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AC93427AF;
	Fri,  6 Mar 2026 14:31:10 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id D0B5C427A1
 for <dev@dpdk.org>; Fri,  6 Mar 2026 14:31:08 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-483a233819aso91166765e9.3
 for <dev@dpdk.org>; Fri, 06 Mar 2026 05:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772803868; x=1773408668; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=83IE0Opxpwstt12H2kkixgBG9OglHhr7PUKSO1pSr6U=;
 b=brVhn/NoWh1eSSmB/EDRcwGDOwFYlQ/eyoRcHtOmCPHh+Rd+eRDcrgDxqpcHdmGQ0E
 Wn9vf3C+nBaKTfbV2AZ/nxxHOxTHuRit0lrKoXccomKEGxHsaOS/7tH0bbegNZW3d9Hx
 feYFsHyc/zllp/B8fwXsMeNWD4RjIU6RjDn3SuuVorxuURsA5r77yoH4S8raLj72lFn4
 TyIizs36Va3DFGv6+DmIbVJN2dFDYyx1/GEyG8ScjG24rASKvq+xPtsuiNRAWNR9qMjb
 1pZb/wK1HlyKjS0mnVJuyFyBJyDhgJACUVpqSFCfFM7Gda6NFRK5Ft+1w5gPn1mYNY55
 CQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772803868; x=1773408668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=83IE0Opxpwstt12H2kkixgBG9OglHhr7PUKSO1pSr6U=;
 b=fJouCFmwrM+LyfVTzac4ZF6QiipzBCK7HvOMkVi2TzEoSgoGENYkvgDXksOpToYZtD
 DHlIcvL+IfjASsSHq3M9O4BMzCzCah39t+qTNtniXlFTKzEfBoNVeI7JO5D4dlU/1XdV
 mvujS6DM09YWw8JmA+jv97Kxv13NWKwD2QknLzVdalldHly1LpuB53ExUWcXr69tcqON
 Wa3QmZYDr179ra+1AA7Mdl+/3zA84LaaC0c47peQXuFi2qq/xWw62S4+7GVjn5qVRc71
 xi13+kZN4kN9EdSBj+6lUjwM/nsyRBU8NmjtytDWqFu9L1dOlvEPaWuVR2io++99Il7J
 D+Lw==
X-Gm-Message-State: AOJu0YwOJemzaSz2/BefxgHROR8AAKIjMIHqwViuG4QTEPpw25hXV1Pa
 INafsSE97dYRDPpq8vxabY3ww6oPPXgdECAAljP6Z/J/HOL+Zva52AQT4S/OCDVf
X-Gm-Gg: ATEYQzwN1paJk6V3Yvotzw9wDwkhTPJdpQxh83FEdDDcNhtSdHBhZCKprguK2HQPrQF
 k4rRB05ekjvCcCGGWUw8iTiLHR+ECimsJ3GEqL4vAIpKthqtUsQ0xSbtp6UMLU4eQijSpDdY1AS
 ev5PSHbTY1lNUu86YYvT88QXik0/ErodZRGAp003jpYhxaaugc3B+/3fqWgOmXCnZrk78fsq/b1
 pLslGPYy5o3Hqzzx77QsukNQRJS1x22kU/86KFQZX6hQONKs1F6HMT2RQ02JjUQFvy8DVr25tSu
 1yZ0y6mp987gRav5ONvLifAIeqkZRCfwYLqHsgrmpldpuLT2LOixurMgXwv4aoRvN2k1C6dydu8
 YDCtqnrxpvszNoLlHQieMXYohrSx4DAQNSB4188u4dWL64/dzzKtOX7l1fOqEsPxCEEdzX3fnLM
 7Eq2/RC0i9Cw4avwU56jokktiDvg8=
X-Received: by 2002:a05:600c:45d1:b0:477:7c7d:d9b2 with SMTP id
 5b1f17b1804b1-4852697844emr34017185e9.32.1772803868295; 
 Fri, 06 Mar 2026 05:31:08 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.102])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48527681e2bsm38161915e9.5.2026.03.06.05.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 05:31:07 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v3 11/17] net/dpaa2: fix software taildrop buffer access
Date: Fri,  6 Mar 2026 14:30:29 +0100
Message-ID: <20260306133035.179709-12-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226143341.282188-1-maxime@leroys.fr>
References: <20260226143341.282188-1-maxime@leroys.fr>
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

