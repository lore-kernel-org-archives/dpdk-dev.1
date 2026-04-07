Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9508FB5183
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 02:14:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C67754025A;
	Tue,  7 Apr 2026 04:14:41 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 0A9164014F;
 Tue,  7 Apr 2026 04:14:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
 s=s201512; t=1775528077;
 bh=jM9VFRfZduXLTAL0yxNoyDNpfnuhxgnBySi/W0bhDTs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=SRV2ECFYrKfpL3LB1r6QQmhY+Dn8/PtH6VAm8QKR75vlPmN6iHYnXScOMPePt2M8b
 HKuBThIKsW9FlNj8Kg3TUqhWxDrNvJ0gbjUW1izc2hyTKsOpsf56CH+p4Ate+xLmFm
 u3CZUk7/W15q+0gXWrhuZ/CofNqu9nIll764qLLY=
X-QQ-mid: zesmtpsz3t1775528073tebd08913
X-QQ-Originating-IP: QHK7rQLA7QjjzmcWcW7wYnTT4+6eK8gaFQejqhMDkac=
Received: from spikeouyan-PC1.tencent.com ( [119.147.10.194])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 07 Apr 2026 10:14:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14260860049649245537
From: "=?gb18030?B?T3V5YW5nIEhhbw==?=" <ouyanghao@tencent.com>
To: dev@dpdk.org
Cc: ciara.loftus@intel.com, mtahhan@redhat.com, stable@dpdk.org,
 Ouyang Hao <ouyanghao@tencent.com>
Subject: [PATCH] net/af_xdp: fix resource leak in eth_dev_close
Date: Tue,  7 Apr 2026 10:14:28 +0800
Message-ID: <FEA1D5B98F367DFC+20260407021428.620-1-ouyanghao@tencent.com>
X-Mailer: git-send-email 2.45.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:tencent.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NxTUUilgc1vawIotF97/hcO3GM9+HbCuzkssd16H3ojiUEY+UBXygnGe
 I5wQLQhQwnW9GA7A97CEvEEC8aP4vPmPZMDzX0dWqtYvWGp5zRxG++WwcnBClGtB8+1tHQW
 sWsyDfrmLrhaptGaJqnNclQVGdE6R+Bhx2TLgCyBQNScJJv83G38IXS5L8jdHG+j61vD9Fw
 6+9BZ1YPI1irrid2UO/uvrlge4BbaOz01WlpISVHYqj/V7efTqGWOz7bGO+jR39Z6Mx749W
 No5vsCLyzinC6diy+mtVlwnDFBJbRLH/imGAhC/PpJSHhZGstjm0vbOUlU5MVtB7fwwfSga
 7TCCzgkED2fxpbPGKd4w1h+4/EHlWjeenLlI2jXgJGwsdyvZLUgRZQ7BRHm6OH2UAkMpc9p
 yQPS4Vr5PoAgLcXrbl8Kj8Mjfrm7fuRAPRxnf0cOKw0Rj7ejScSFsiUwGm3b9iC/jHuGQZL
 4MfF5hHwlQ37yof7z82jlDPI9bA36tQBl5gCNUnM2FdzlIaWwpgqRyk+fQDtpc9Xsj7+xMB
 ESq5N9z7GHmb8Gn4qIixaxSQZ29t3MROSPo2yASRjEukejnUuvfJ2ulxNiSHSgsjAFYHbwK
 il3TTqw/7vC7NpKdrMf5VlrBdykou659PvU32b1K7SfTnv1aihuxSw12QH8nCCHCWkByo8v
 LRI5AvB6WP4anrj4W4lqUVKAY6igmB69ZkW4nLRRDqYfEgyXvw0gbXwAEc5iRsgjQZb5pio
 s2ctSVyrw3o5k0nxwlK6yd2X6rqtfCFtihk73pXLIA5gE+ePiFv6N622arq+IPBmCIReifF
 Py1mnvcIe05KOOIPekxvuQnRNcF3ORkJRO7aWZCv0qXhLtkEMx8IWyGqgNP1AP0b+pWswFO
 mUrHom/5RQBRHz7eGpGPdzwMYI4Dlnw99tqp4VUP6YUNrdGBeUjJm7e4sbih4eSOFs4jHU8
 8JVowUGLXz65gwhuDOYHqQNXkS4AXum9g3KlZ9NH1SzmIL5hJYyyHrFuMIMbFM+XsfEwo2t
 ELdz/0qathaGRMDcR4rLSPNw0R/Mg=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
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

The rx_queues and tx_queues arrays are allocated as contiguous
blocks via rte_zmalloc_socket() in init_internals(). However,
eth_dev_close() incorrectly calls rte_free() on individual array
elements (rxq and rxq->pair) inside the per-queue cleanup loop.

Since rte_free(&rx_queues[0]) releases the entire contiguous
block, the memory backing queues[1..N-1] becomes invalid after
the first iteration. On subsequent iterations, accessing the
freed memory may read NULL (or garbage), causing the loop to
break early via the (rxq->umem == NULL) check.

This results in:
- XSK sockets for queues 1..N-1 not being deleted
- UMEM reference counts not being decremented, leaking memory
- Potential use-after-free if freed memory is reallocated

Fix by removing the per-element rte_free() calls from inside
the loop and instead freeing the entire tx_queues and rx_queues
arrays after the loop completes.

Fixes: 339b88c6a91f ("net/af_xdp: support multi-queue")
Cc: stable@dpdk.org

Signed-off-by: Ouyang Hao <ouyanghao@tencent.com>
---
 drivers/net/af_xdp/rte_eth_af_xdp.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index 10dbcf1333..2cdb533276 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -1069,12 +1069,10 @@ eth_dev_close(struct rte_eth_dev *dev)
 		if (rte_atomic_fetch_sub_explicit(&rxq->umem->refcnt, 1,
 				rte_memory_order_acquire) - 1 == 0)
 			xdp_umem_destroy(rxq->umem);
-
-		/* free pkt_tx_queue */
-		rte_free(rxq->pair);
-		rte_free(rxq);
 	}
-
+	/* Free Tx and Rx queue arrays */
+	rte_free(internals->tx_queues);
+	rte_free(internals->rx_queues);
 	/*
 	 * MAC is not allocated dynamically, setting it to NULL would prevent
 	 * from releasing it in rte_eth_dev_release_port.
-- 
2.37.1


