Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A70A109C05C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 20:46:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9FAA427BA;
	Wed, 25 Mar 2026 21:46:15 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id AF8B1427AF
 for <dev@dpdk.org>; Wed, 25 Mar 2026 21:46:12 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-486ff201041so2502805e9.1
 for <dev@dpdk.org>; Wed, 25 Mar 2026 13:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774471572; x=1775076372; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F+wmXijQuNhCfmollS+bE9KOGPM9PxirA5+uOKpvSic=;
 b=coD6p1dFguIk0iJUjlcRZ7JFfYNk1DvCNYyuArTa9v8QXwgzokus6nm8i0HPcWVJyT
 PTmisaZgBXyzTtlCCMpXf1MWwhQudA5WFmWA0lW6KW8lseKCCIhW0X9F9S8YExkxkqCw
 ZQG+2UJ4FvzixfIeROV/QGFR88mwOPJ/F2BBVizaBUMPsHf/AsvNjwfzkeiYVwS9y0kS
 5x/fSD/yEgMIlKsBWodmfBMx/8toU5ckNO9N+dlWU6md1WAHOTK9n8azc+v/iETYpWsG
 okwUJd0MtIdYgWUX9Ax6yoLcFNrax9qVbLzhvwWTT0KEFIwkmbX2ojp3s7BFoxxnvElN
 65Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774471572; x=1775076372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F+wmXijQuNhCfmollS+bE9KOGPM9PxirA5+uOKpvSic=;
 b=H0Ke957szRTbz1X6sXXfI9JbcamQzLY9K+h1XEQuMWs5RctkfkxPATB93BDHV0bsjF
 XmvaDAEDZ6awsBGdQTgwBpk1B0esiVTCT91k+dniR7bJ7nacriDJ259j4HxMGTw9oIbR
 MSeGnAby14DN2w2dhZ3XZ7CxfndwzXQhcURBNYBjt0VkBQD2nQAFQ8PQgOP9jiq5Ew6r
 Vq1iMtbHzNA21c65LvDT/ZggT0L9r1otoGeTzlelp30MEMHqCS2xZIx9zgijP/4jNbBz
 Wt59gMk4y5oZGQ1QzUDRVgvpH1aM8sqpX7Kq4kq8BxiMxxIbTUkBVnrNKNG9e7de5kVK
 X59g==
X-Gm-Message-State: AOJu0YxDiEILYtihqNZG4gUIFdJgkYAae4d9qq0Jc+gMSJks800/IT9e
 dUwc/TE9QcR03Jm0kYSjgfJ9BXV0WYYWWp4yh1AeM8McyULd/CubiSxTS6CLspnY
X-Gm-Gg: ATEYQzyo9QjtEBrKpV/xZdmnFHhd0WPpD/jJkyNuDl/jL7GMCnpFr5hFOz8Hh4a7oY2
 5MU6KQVPMWf1MA8P6eBa2GIbZKVypviIOJSJzg0YZBFF/lbG7+YusXbdriGk5uViCtDb+YMeagn
 jQMOpL2d4oTQjGjyMWRa7x4+FLnbjYW0z0155kBNdo3qivYLqGmhoUi/aHa8z+ezmzTlhm8ioob
 onTIi6hUMyr6CIbuFfLsGffKLgf2RfATC+6R1H4x/z8y8hztznPaSmaN0jWPLvgqCMTpp2OYefj
 JBteEZHM6HtQoeN4hhsATkQ3ARCKWhQKSqzAVl5jmhbD5XYjfP9LMXhbJW4L5UOqXGVwOZeVy94
 MT081FleCHkKEJV6sJMF4FobNOBl/nlcnXEbtMHXq/nnShL2qP12u+yiMUOdH74Y9ZpcwSgeg/g
 fu4SsXDPr+C8GJNNtp
X-Received: by 2002:a05:600c:1f12:b0:487:338:b4eb with SMTP id
 5b1f17b1804b1-487160564f9mr71686695e9.28.1774471572234; 
 Wed, 25 Mar 2026 13:46:12 -0700 (PDT)
Received: from freepad.. ([2a01:e0a:6f:bdf0:224a:2b64:3d43:500c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871fbdd555sm2864525e9.2.2026.03.25.13.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 13:46:11 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v4 08/17] net/dpaa2: fix error packet dump crash and memory
 leak
Date: Wed, 25 Mar 2026 21:45:35 +0100
Message-ID: <20260325204544.101444-9-maxime@leroys.fr>
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

Fix three bugs in dump_err_pkts().

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

Fixes: f9465bdcef9d ("net/dpaa2: fix error frame dump")
Cc: stable@dpdk.org

Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
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

