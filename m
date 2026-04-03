Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D54F3D5E1
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 07:06:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CE5E4025A;
	Tue,  7 Apr 2026 09:06:26 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id B0B844028B;
 Fri,  3 Apr 2026 14:41:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
 s=s201512; t=1775220061;
 bh=jM9VFRfZduXLTAL0yxNoyDNpfnuhxgnBySi/W0bhDTs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=rXPsNMIL5aVC/CtqGGut2EN3tRqp86eXRnrV3iAwcUhZReFtTkV4o/fxiGmdkDAoJ
 wRn6i95XGOq6jrVor5IL25v74UMvNCrf9XFRrDDXrEcsNUql7GxdTe2tt730oFSRWI
 eL4s6SvryYWzDXnFIlTVdN3Aa2uwDej0wHm5UMVM=
X-QQ-mid: esmtpsz21t1775220057t66fe1715
X-QQ-Originating-IP: jZFFJ1lYIhxZHhocxyBsLjcPqB/gMwmEEJepRXelRho=
Received: from spikeouyan-PC1.tencent.com ( [113.108.77.55])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 03 Apr 2026 20:40:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3575969522151362747
From: "=?gb18030?B?T3V5YW5nIEhhbw==?=" <ouyanghao@tencent.com>
To: dev@dpdk.org
Cc: ciara.loftus@intel.com, mtahhan@redhat.com, stable@dpdk.org,
 Ouyang Hao <ouyanghao@tencent.com>
Subject: [PATCH] net/af_xdp: fix resource leak in eth_dev_close
Date: Fri,  3 Apr 2026 20:40:53 +0800
Message-ID: <F8BAB5327DFA4F53+20260403124053.1354-1-ouyanghao@tencent.com>
X-Mailer: git-send-email 2.45.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:tencent.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NGe+v6b5AUNWRtVXK68rQQxHApjgetCSzVItQujn6XfFsF7ISgVAwM+M
 ibGnJnwsYjaTI+gBxM1ucQOHlimjBkfAM/BUjLjS+WCY636lM2tvmv7YNNseWrt3usJj4fy
 Ku8BPIS4mhulvk4XpZHDpjUBqP6/WrqyPF9rRjegCPKA/uLq1ryD1qrCWejrjmKheKuwtYB
 0guZUzZhMFLCjBi3RgifrMX14h9mx/rMu4242ztG2NIOEdcpftw4wb6t9nKfljuIzNKcwYt
 AjyE+vaQ8FyznTTUDQc5fdPH6TNEMWjwKmOuwT5ObUr2ueyndNVoyhsFM0ViikzOmZxqkEW
 9YcSPtdpEj6Ck4p0gARglJCgWftok+WMhBHWdvj60NZwzNSXUbfZbJ7zQ/3rxvSf0PZUs2i
 Wxa7wWO1vDagH2pPs4/vencuaUXuCb9KjjG6gpxVdlONnUrRvs7AjFbF9ukThfNpjS7XtKZ
 qkjTdWdXjaIVWo7Mqx+sapGuRqvafR/l4T3sYUHUtfc3GvHTZf0CA5f2uKUWzQahWK1kK48
 Jk0TFFb4uYgCvcuE1sVelMhSA+f2JCym58QFbYVFQHv1QeGqPwPZkwUWUXS78nDYz3msoGp
 TLrLaLxN5a3hhViKp2pWgcrvUWQDYfo9370mprOi4xLy4nnM5z8+ENk2b14D/StI91DPOaN
 T6kGveI4s+S1O2gKgfvKneRCgtVDs7j77Yj3WiHsByvwd0+rrCRgoEoSy1QYWm2rsjlu6/L
 q6NnE5/JwYHSQ0dRpoE5sKICnUtJ32hKm4UHve/6uCsXILHWWBReg5HTdzjhNmuCl1lH7Fy
 2gGLeyCzJF5LMC8av6oSBpmCu4ro1a54C/GQ5841x+T4kM8okpgTkHFKmri72LBjdQjPxKr
 ZkzIA1mgtN45jAcl25uyf14AuOdSCYN167AMRtxqQAcC8hHcwutOMc/+5Qqok1yaU99KWnT
 CB0aETaKwxQsfzimG93jVDMqfvoUV+MERsV3qOBduqNxTlqEmx8G5c023n/V1MlQNPwPu50
 Y01lyPDmznSmwAdM4XHn3KSlfHh9mHXb/W7rzQB3AtwGpTew4KM3rQfcpFMHdy7qhRu7xKi
 spaUm/k/OjnOrss8cHeU2I=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Tue, 07 Apr 2026 09:06:25 +0200
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

