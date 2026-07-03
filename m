Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2712C43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 13:13:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BBBB40A7F;
	Fri,  3 Jul 2026 15:13:21 +0200 (CEST)
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com
 [209.85.214.201])
 by mails.dpdk.org (Postfix) with ESMTP id AD62940A76
 for <dev@dpdk.org>; Fri,  3 Jul 2026 15:13:20 +0200 (CEST)
Received: by mail-pl1-f201.google.com with SMTP id
 d9443c01a7336-2c825562f8bso11127655ad.2
 for <dev@dpdk.org>; Fri, 03 Jul 2026 06:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783084400; x=1783689200; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Rj4KCs8B3o4jz+ud9hwdG0BppzIfIi5ePThlnHYXGwA=;
 b=A8tAYFP0uIfeudoIbuL1+NxkmKQ5yRKK92xyIDST6cFHdQUTmNpmfsmYzegVZPPxpg
 BV4CwUEC3GLiJHpKnhONuZcpHdQJrbSkxIsXU4wFxmLKiSEkE1pAUXupokrRhHL9jgnk
 V8MlxzIWeZU4728uuqBwLby3Oz5vglF2MXswxC/8vEx3sH76kRYWvDQpDcg23NoEv9gg
 wH+p09//oEcjTh+f4hr7dJCssS0GPj5hgviVJbVv4VGaIb81fIp3Zmqe21lrCGlARsL3
 SDwint4hqoCB78Qr+uWbwFK6u3XMOxMQSkQEuWXABfvyGjAN6avx9WaFCgYhEZKgx11c
 cK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783084400; x=1783689200;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rj4KCs8B3o4jz+ud9hwdG0BppzIfIi5ePThlnHYXGwA=;
 b=fg483+2Zn5q9IaKiVESui9IJVmRok7soyhrxKSczW8FKy27CTO6+GnoLGyZCdeB8Sm
 g7ychAgigvrBVy3SCb1rykqOeivy62YMb84Ec2IhwW4B5k1hLYzReMTCXMSm/7+zrnuS
 Fx44HoRSHsFaP+5k1pU2rCyoWKz9qXzR1ik+yCXSh+h/oWXOgBnD7WEJ8zW1ap8/2ZkR
 N5bRCORMXZZiZO8sOcRcXk5eZteB3qVdLKicrAi+MRMrEcW65zbFtftYH5o5JHorZtbf
 Q4UNdwc0OtaycWbehswm1XRRDbpfuzy1JJTAQswKyOWkJebVEiQmPm3WnHzEJk44U6CF
 8QOg==
X-Gm-Message-State: AOJu0YxPQVaDztCiTKkxrkxWJjR9vpMHD8nID8S+nAdspK/7YmyK7l/1
 HpdB3Zho+yYF7IwRybXaoxSgNgJ8KB8Xf05nFWnWX7ky9w0X2J0qKEQQRpVuVcImTfUjIV+amih
 ++84lTNELpwxLAw==
X-Received: from plsa11.prod.google.com ([2002:a17:902:b58b:b0:2bd:9e00:f173])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f652:b0:2bf:1cda:29ce with SMTP id
 d9443c01a7336-2ca7e65473fmr109415165ad.6.1783084399558; 
 Fri, 03 Jul 2026 06:13:19 -0700 (PDT)
Date: Fri,  3 Jul 2026 06:13:02 -0700
In-Reply-To: <20260703131308.2507403-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260703131308.2507403-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703131308.2507403-6-joshwash@google.com>
Subject: [PATCH v2 5/9] net/gve: set mbuf to null in software ring after use
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, 
 Junfeng Guo <junfengg@nvidia.com>, Xiaoyun Li <xiaoyun.li@intel.com>, 
 Rushil Gupta <rushilg@google.com>
Cc: dev@dpdk.org, stable@dpdk.org, 
 "Jasper Tran O'Leary" <jtranoleary@google.com>
Content-Type: text/plain; charset="UTF-8"
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

Currently, it is possible for mbufs to be uncleared in the sw_ring after
being returned to the application. This causes an erroneous
dual-ownership over the buffer until GVE cleans the buffer queue and
posts new mbufs, overwriting the older pointers. It is possible in such
a case for a double free to occur while tearing down rings, as both
the application and the driver could attempt to free the same mbuf.
Release ownership of the mbuf from the sw_ring as soon as appropriate to
avoid such a scenario.

Fixes: a46583cf43c8 ("net/gve: support Rx/Tx")
Fixes: 45da16b5b181 ("net/gve: support basic Rx data path for DQO")
Cc: stable@dpdk.org
Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Jasper Tran O'Leary <jtranoleary@google.com>
---
 drivers/net/gve/gve_rx.c     | 1 +
 drivers/net/gve/gve_rx_dqo.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/gve/gve_rx.c b/drivers/net/gve/gve_rx.c
index 625649cdcf..cda87af294 100644
--- a/drivers/net/gve/gve_rx.c
+++ b/drivers/net/gve/gve_rx.c
@@ -152,6 +152,7 @@ gve_rx(struct gve_rx_queue *rxq, volatile struct gve_rx_desc *rxd, uint16_t rx_i
 
 	rxe = rxq->sw_ring[rx_id];
 	gve_rx_mbuf(rxq, rxe, frag_size, rx_id);
+	rxq->sw_ring[rx_id] = NULL;
 	rxq->stats.bytes += frag_size;
 
 	if (is_first_frag) {
diff --git a/drivers/net/gve/gve_rx_dqo.c b/drivers/net/gve/gve_rx_dqo.c
index c4e2d32067..3665d9e4cd 100644
--- a/drivers/net/gve/gve_rx_dqo.c
+++ b/drivers/net/gve/gve_rx_dqo.c
@@ -207,6 +207,7 @@ gve_rx_burst_dqo(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 
 		rxm = rxq->sw_ring[rx_buf_id];
 		gve_completed_buf_list_push(rxq, rx_buf_id);
+		rxq->sw_ring[rx_buf_id] = NULL;
 
 		/* Free buffer and report error. */
 		if (unlikely(rx_desc->rx_error)) {
-- 
2.55.0.rc0.799.gd6f94ed593-goog

