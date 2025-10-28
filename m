Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358B7CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 10:01:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CE1B40262;
	Tue, 28 Oct 2025 11:01:55 +0100 (CET)
Received: from out-cbk.mail.syseleven.net (out-cbk.mail.syseleven.net
 [195.192.142.27])
 by mails.dpdk.org (Postfix) with ESMTP id C6F204021E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 11:01:53 +0100 (CET)
Received: from 127.0.0.1 (localhost [127.0.0.1])
 by out-cbk.mail.syseleven.net (Postfix) with ESMTPSA id 42EAD3F090;
 Tue, 28 Oct 2025 10:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=syseleven.de;
 s=2022n001; t=1761645713;
 bh=58E3pOF8x1ONpT3p140pC6EGQx6Rr1+LG7Luf7/DysQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XM34PcLIwcOl6yTod4GOvhXw4VcOU6Qf8WxQwyn8u0f9LNUKNtTF5ghcNhHnS0BYK
 yUllwUn83AyTL6qwbxk7QsRWyzOuDIoRApKmVNGZZ3dOr43QN7BB8ygrUAQGffyjTQ
 xe/vgKZa+EgkWbNrsdBmoCdH+wP+z85ezq5WH1nwqdtwYmZ5Zwh/wYLjLPBwhUJ/1b
 0CKebz3EMhqp5SkxOS5eoTyHaYfn/MPjS7VVC8SJP8yFqRuHAxLn9X/p7UPG7Z6HLi
 l/IhsXuX0dV6kVMTkWml9ByieV6kG3JUNH3Ug2AC1E1ExRmS9plTIYwFfH9p8qOzjD
 +uE+DfvfXoFzg==
From: a.schollmeyer@syseleven.de
To: dev@dpdk.org
Cc: Michael Rossberg <michael.rossberg@tu-ilmenau.de>,
 Erez Ferber <erezf@nvidia.com>,
 Adrian Schollmeyer <a.schollmeyer@syseleven.de>
Subject: [PATCH] net/mlx5: store rxq MTU at allocation time
Date: Tue, 28 Oct 2025 11:01:44 +0100
Message-Id: <20251028100144.36284-1-a.schollmeyer@syseleven.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251028095502.1CFB21261CB@dpdk.org>
References: <20251028095502.1CFB21261CB@dpdk.org>
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

From: Adrian Schollmeyer <a.schollmeyer@syseleven.de>

For shared Rx queues, equal MTU for all ports sharing queues is enforced
using mlx5_shared_rxq_match() to make sure, the memory allocated in the
Rx buffer is large enough. The check uses the MTU as reported by the
ports' private dev_data structs, which contain the MTU currently set for
the device. In case one port's MTU is altered after Rx queues are
allocated and then a second port joins the shared Rx queue with the old,
yet correct MTU, the check fails despite the fact that the Rx buffer
size is correct for both ports.

This patch adds a new entry to the Rx queue control structure that
captures the MTU at the time the Rx buffer was allocated, since this is
the relevant information that needs to be checked when a port joins a
shared Rx queue.

Fixes: 09c2555303be ("net/mlx5: support shared Rx queue")

Signed-off-by: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
---
 drivers/net/mlx5/mlx5_rx.h  | 1 +
 drivers/net/mlx5/mlx5_rxq.c | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_rx.h b/drivers/net/mlx5/mlx5_rx.h
index 6380895502..58bc2c9f21 100644
--- a/drivers/net/mlx5/mlx5_rx.h
+++ b/drivers/net/mlx5/mlx5_rx.h
@@ -169,6 +169,7 @@ struct __rte_cache_aligned mlx5_rxq_data {
 /* RX queue control descriptor. */
 struct mlx5_rxq_ctrl {
 	struct mlx5_rxq_data rxq; /* Data path structure. */
+	uint16_t mtu; /* Original MTU that the queue was allocated with. */
 	LIST_ENTRY(mlx5_rxq_ctrl) next; /* Pointer to the next element. */
 	LIST_HEAD(priv, mlx5_rxq_priv) owners; /* Owner rxq list. */
 	struct mlx5_rxq_obj *obj; /* Verbs/DevX elements. */
diff --git a/drivers/net/mlx5/mlx5_rxq.c b/drivers/net/mlx5/mlx5_rxq.c
index 5cf7d4971b..c652204ea8 100644
--- a/drivers/net/mlx5/mlx5_rxq.c
+++ b/drivers/net/mlx5/mlx5_rxq.c
@@ -773,7 +773,7 @@ mlx5_shared_rxq_match(struct mlx5_rxq_ctrl *rxq_ctrl, struct rte_eth_dev *dev,
 			dev->data->port_id, idx);
 		return false;
 	}
-	if (priv->mtu != spriv->mtu) {
+	if (priv->mtu != rxq_ctrl->mtu) {
 		DRV_LOG(ERR, "port %u queue index %u failed to join shared group: mtu mismatch",
 			dev->data->port_id, idx);
 		return false;
@@ -1799,6 +1799,10 @@ mlx5_rxq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 	}
 	LIST_INIT(&tmpl->owners);
 	MLX5_ASSERT(n_seg && n_seg <= MLX5_MAX_RXQ_NSEG);
+	/*
+	 * Save the original MTU to check against for shared rx queues.
+	 */
+	tmpl->mtu = dev->data->mtu;
 	/*
 	 * Save the original segment configuration in the shared queue
 	 * descriptor for the later check on the sibling queue creation.
-- 
2.34.1

