Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCC2109C05C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 20:46:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0841427B0;
	Wed, 25 Mar 2026 21:46:12 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 4BF55427B5
 for <dev@dpdk.org>; Wed, 25 Mar 2026 21:46:10 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-487035181a7so1894045e9.2
 for <dev@dpdk.org>; Wed, 25 Mar 2026 13:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774471570; x=1775076370; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R69B1bU0BxTDJG2hs+AHh8tOh1wtFY0DwpmuLha/VKc=;
 b=mqsPWwbPK2i6ntBn4Dm/1+xc7Zn9xspypAAK+/e6Mp57XqtD754qFuIwJ6JH07cN73
 vDM83BwdE4AhU8Xqt+xJ8U+c5OhfwvK/utdlpvCr+cJWDR+cg8cne0sXAT2nQj2MyDGN
 WTVM+1FaOqjZgdMefhp7sYPREvfxv7UzblbGJaKPvV6koH2sQfCiVNT7XD0VNhLbne5+
 LQfzvtXeY+J6M5It5YXeVgElbdLKX8L23JiF2dzV6NsoY5ZXK7oppoAOPbE8f32T6lDH
 ojpShbCVSnDTzB0FIdw576iFJGfz0pO6Cho4Fe+BmO1UD84l9hE+2lgOKLscyr9bV7wQ
 SMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774471570; x=1775076370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R69B1bU0BxTDJG2hs+AHh8tOh1wtFY0DwpmuLha/VKc=;
 b=rMfb7Nqp6sEGQmrF73evxcNdMe1j0Umj3da1ZYxaXXRpDztXgT5QKSDVvQv9UrU9Lg
 QixRpHDFoO2U3mEPGpPfAkHhTTQZvHDT3ClnyomPGM4N40dWL0q56NiXy+IECaJRBySM
 iVSFbamOd6u80jfL5/KkNkIxTGZX/U82pQRIuzyJygvZIZO5yeLEk8xlENxeVn7+61w6
 bRckT7ZktRbxOWVBTA6a9IFnCMz9o7i60uQ29nQhkfv6WIoygBE/bzKhFMiL+prm5qPc
 ScYqDBzcAFF6a6JtvlP9XKXrztyO0tmqyJH0tAbqy4ElyvrHouDIWFPhl17lFI5u5BQ/
 vw8g==
X-Gm-Message-State: AOJu0YxQu6VVi64JOl97dPd+jYWhteE9QSLo4jQNAzsOVE5p0Nh2VAsB
 8+dQF+Hp4Iaq07Lfd0IXMWlDzbQTXvOYQ+rER8dW12CrLWSgXOmcEbgkuIFDd1EC
X-Gm-Gg: ATEYQzyRouLebbO45iGYYnuXtgXcyEtlWZQRoh6j3ES3HbR/q2OZHJHnsJ3DBfk+lue
 YpLyBWGehv9sxYEkkPmq1a0mMua00qsYuk8SO1Y+t2Y1+NX/NiC/uSZZup7grBy6wAGV0nv/JSz
 z4KxC8hxD6cEV5662BvIhWrKrz3oYLM+6Wd05C+djZknQ1S4Z/RbqkOpeA2tpQYYfjgPZRtnyjI
 1EPuvTm+qOIvpRRKV0CHQr7i/jI3jTBBIvkPx2B9qG9x7cNQmG48rqYUZaBIFRAAaLBF2Fo+5r/
 61fTCwMDumjIYslddkI/AnmfyGWV3pOFmW7IKCPyYtTC3gz3oYXJi4w/tQswaTyalxX8EOS1e14
 k4hNNQSJxbAqCxl4PgSs9oCFti8ZDhrjb4eK/4Dn/5xJ5Dc/swHGKUbaMS6LF2jc5TjXmGw9zK0
 WkuCBnqR8xUTOjaYX4eQZtiBi37rw=
X-Received: by 2002:a05:600c:83c6:b0:485:9a50:3370 with SMTP id
 5b1f17b1804b1-48715fcc5acmr71207455e9.8.1774471569568; 
 Wed, 25 Mar 2026 13:46:09 -0700 (PDT)
Received: from freepad.. ([2a01:e0a:6f:bdf0:224a:2b64:3d43:500c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b9192e5f0sm2173648f8f.4.2026.03.25.13.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 13:46:09 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v4 07/17] net/dpaa2: fix spurious VLAN insertion on non-VLAN
 packets
Date: Wed, 25 Mar 2026 21:45:34 +0100
Message-ID: <20260325204544.101444-8-maxime@leroys.fr>
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

The VLAN insert check in dpaa2_dev_tx() tested the per-packet flag
OR the port-level txmode offload:

  if (ol_flags & RTE_MBUF_F_TX_VLAN ||
      txmode.offloads & RTE_ETH_TX_OFFLOAD_VLAN_INSERT)

When VLAN_INSERT is enabled in txmode, this causes rte_vlan_insert()
to be called on every packet regardless of the per-packet flag, inserting
a VLAN header with whatever stale value is in vlan_tci (typically 0).

The port-level offload only advertises the capability. The actual trigger
must be the per-packet RTE_MBUF_F_TX_VLAN flag, as done by every other
DPDK driver (Intel, mlx5, virtio, vhost, af_packet, etc.).

Fixes: 0ebce6129bc6 ("net/dpaa2: support new ethdev offload APIs")
Cc: stable@dpdk.org

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_rxtx.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 7cbd3f33ae..5a98f295a7 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -1346,10 +1346,8 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 				    priv->bp_list->dpaa2_ops_index &&
 				    (*bufs)->nb_segs == 1 &&
 				    rte_mbuf_refcnt_read((*bufs)) == 1)) {
-					if (unlikely(((*bufs)->ol_flags
-						& RTE_MBUF_F_TX_VLAN) ||
-						(eth_data->dev_conf.txmode.offloads
-						& RTE_ETH_TX_OFFLOAD_VLAN_INSERT))) {
+					if (unlikely((*bufs)->ol_flags
+						& RTE_MBUF_F_TX_VLAN)) {
 						ret = rte_vlan_insert(bufs);
 						if (ret)
 							goto send_n_return;
@@ -1402,9 +1400,7 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 				goto send_n_return;
 			}
 
-			if (unlikely(((*bufs)->ol_flags & RTE_MBUF_F_TX_VLAN) ||
-				(eth_data->dev_conf.txmode.offloads
-				& RTE_ETH_TX_OFFLOAD_VLAN_INSERT))) {
+			if (unlikely((*bufs)->ol_flags & RTE_MBUF_F_TX_VLAN)) {
 				int ret = rte_vlan_insert(bufs);
 				if (ret)
 					goto send_n_return;
-- 
2.43.0

