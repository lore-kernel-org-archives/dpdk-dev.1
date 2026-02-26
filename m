Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620F5FCE095
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 14:35:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF92A40B9E;
	Thu, 26 Feb 2026 15:34:18 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 53E9440670
 for <dev@dpdk.org>; Thu, 26 Feb 2026 15:34:10 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4836e3288cdso6357575e9.0
 for <dev@dpdk.org>; Thu, 26 Feb 2026 06:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772116450; x=1772721250; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dXv1A3cY2/xa3NeE0pNmcTq0YBOFHiUYbErXnKsThjA=;
 b=DqM0bqrq1UHYowd7v9Ie/5Aj+TTzWuWyT+UfZuTTH27sdd8haPpPcE2K6Z8WqA4v2w
 F2Io7KmteRzqTb4dvT5+GT7X4SlSVfngTx2iWJ0Elb21WqP9xa6k2dEDdeK9RBu3HtpN
 Kjfpi4wzu+LQ6TWjJfAAO/jDs9SEN9CV4y0mEjxCw7I00FqPsDJtqlrS9h+v4udw38fO
 tSX2wMdfQX7GeN7uuv1DGxyE4D5FizyfafsWgelbbs/kqKlxOv8r/lEeEHTHAeZXD/Ns
 1hMaoHWW3CGkbV7bRoBAPth9xfv4BVYZEw3HWRlBqNksOzPHlQPCrYGHRxPP5zEzYZY6
 cB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772116450; x=1772721250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dXv1A3cY2/xa3NeE0pNmcTq0YBOFHiUYbErXnKsThjA=;
 b=IEgV3pXOy00KYq0NAv5TkivybzociHtxRIT19L31UlGdHsW3htVOGhDP0VhoGeQuQq
 v+78miNx3b/4PnwKT4FlNIBGRuIkQrujexeCtO1YZ+RdwfS4ylh9y7Gux4qSqmqRimp6
 VHYwMUCCxSZ6VPWrmCgyhwWaKvLv3HL/NygL2fZufQYN4+m6tqISe6FECCpSQhxUPuhq
 PBDa1tSRTwfcF5zM4dP497PRPH5VYa2W/w55GYWtT4nF576wGOgyWTN0nqe9EmeSvT09
 PLaOWXqHdFrIXBttW1dbt9Il48ASbgaEbOVpV9mV6FAffUUDwY5W0jIlqi7WjdCXq7Go
 HM9A==
X-Gm-Message-State: AOJu0YzXwzL+fUHiyT/ILIisClvpIwWnVK1d1aI894ZKLS7ApTf9lp4V
 JuZU9JOoqyk31GF9Hd/LEf5WErdfGnfpi79ogEUD5GDaue8V3C9klF7O87oTfg==
X-Gm-Gg: ATEYQzzTFt7IZqiQ9NRsL0HGz66lZeMUqqrjMa/tYxOWcX6Qahpe+2ctPNmWuujXFs/
 CeG4/OzTEFC6tjPUkJC61UVJsKMMjwMAmxTcOahFSK2ZSAfQ27PUflN+4qjcFDQIxad2m+HG8dH
 Hnv/bhjaMK7hlK9PBpQRuDyVIb9zizHyL2RTHSczDIbetgrmHI++bEjUIvzFSnYEQt/9gPNN9KV
 y3F0Xy2LlaS08c+lMT7gBTM/qme4HJCTBZ7EHe97JBPah7JTJzWXkLJGnipkhApGA5G36gXskje
 /4xq5wsBS4QtyjPJmGAgnoAPgCveQprTT/l4IX/6Rm1iXtGj9+WF6t1txmq35U22o5DgHVW0Rta
 PDbfXPwJonpnwYZn0P4MPAr1Bat7nEqWr58p4MYHxHH34JNdeaW+ZjTRC4DVw9WExnn2ousdTTd
 mgpHmT+wi3kfuy59e5nPmJ1Kl2JA==
X-Received: by 2002:a05:600c:1713:b0:483:722c:a3d1 with SMTP id
 5b1f17b1804b1-483c33eb259mr34172155e9.16.1772116449791; 
 Thu, 26 Feb 2026 06:34:09 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4398bb96b90sm17993866f8f.9.2026.02.26.06.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 06:34:09 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v2 08/17] net/dpaa2: fix error packet dump crash and memory
 leak
Date: Thu, 26 Feb 2026 15:33:32 +0100
Message-ID: <20260226143341.282188-9-maxime@leroys.fr>
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

Fix three bugs in dump_err_pkts():

1. NULL pointer dereference: mbuf was checked for NULL but then
   dereferenced unconditionally on the next line.

2. Memory leak on multi-segment packets: the while loop walked
   mbuf to NULL, so the subsequent rte_pktmbuf_free(mbuf) was a
   no-op and the packet was never freed. Use a separate iterator
   variable and free the original mbuf pointer.

3. Segment index not reset between packets: variable i was
   initialized once at function scope and never reset inside the
   do/while loop, so hexdump titles had wrong segment numbers.
   Make it local to the multi-segment block.

Not tested, found by code review.

Fixes: 8b49427e73 ("net/dpaa2: add Rx error queue support")
Cc: stable@dpdk.org

Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/dpaa2/dpaa2_rxtx.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 5a98f295a7..0de52cbef2 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -651,7 +651,7 @@ dump_err_pkts(struct dpaa2_queue *dpaa2_q)
 	const struct qbman_fd *fd;
 	struct qbman_pull_desc pulldesc;
 	struct rte_eth_dev_data *eth_data = dpaa2_q->eth_data;
-	uint32_t lcore_id = rte_lcore_id(), i = 0;
+	uint32_t lcore_id = rte_lcore_id();
 	void *v_addr, *hw_annot_addr;
 	struct dpaa2_fas *fas;
 	struct rte_mbuf *mbuf;
@@ -726,24 +726,27 @@ dump_err_pkts(struct dpaa2_queue *dpaa2_q)
 			DPAA2_GET_FD_OFFSET(fd), DPAA2_GET_FD_ERR(fd),
 			fas->status);
 
-		if (mbuf)
+		if (mbuf) {
 			__rte_mbuf_sanity_check(mbuf, 1);
-		if (mbuf->nb_segs > 1) {
-			while (mbuf) {
-				sprintf(title, "Payload seg[%d]", i);
-				rte_hexdump(stderr, title,
+			if (mbuf->nb_segs > 1) {
+				struct rte_mbuf *seg = mbuf;
+				int i = 0;
+
+				while (seg) {
+					sprintf(title, "Payload seg[%d]", i);
+					rte_hexdump(stderr, title,
+						(char *)seg->buf_addr + seg->data_off,
+						seg->data_len);
+					seg = seg->next;
+					i++;
+				}
+			} else {
+				rte_hexdump(stderr, "Payload",
 					(char *)mbuf->buf_addr + mbuf->data_off,
 					mbuf->data_len);
-				mbuf = mbuf->next;
-				i++;
 			}
-		} else {
-			rte_hexdump(stderr, "Payload",
-				(char *)mbuf->buf_addr + mbuf->data_off,
-				mbuf->data_len);
+			rte_pktmbuf_free(mbuf);
 		}
-
-		rte_pktmbuf_free(mbuf);
 		dq_storage++;
 		num_rx++;
 	} while (pending);
-- 
2.43.0

