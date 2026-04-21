Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A308F94CB0
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Apr 2026 21:24:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C8C64028F;
	Tue, 21 Apr 2026 23:24:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3EF7640144
 for <dev@dpdk.org>; Tue, 21 Apr 2026 23:24:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776806652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iJOxdxu1CTDzopryZUwOPBiT/SUDyFzBJjg4IF6dctI=;
 b=dxHDTgfEPSSa9HKKtnK4RV1mzKbJX3gRuEs9p5ui8yflVrQk+UXrf52Gy80IqHA4upir5o
 TXYgu7zLP2qDM41m6ZTVL0qpbsgFwOSt2HBHhsQ1FUyu5HPJqfYLmHZfk7KrJQLPPKsBbH
 fFDcExD45Q6PeJ7O1x3P1QFUBtFqXSM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-IGprkzUvNG-C1DmP_A4U5w-1; Tue,
 21 Apr 2026 17:24:06 -0400
X-MC-Unique: IGprkzUvNG-C1DmP_A4U5w-1
X-Mimecast-MFC-AGG-ID: IGprkzUvNG-C1DmP_A4U5w_1776806644
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A822A195608F; Tue, 21 Apr 2026 21:24:04 +0000 (UTC)
Received: from ringo.home (unknown [10.44.48.61])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B6963180047F; Tue, 21 Apr 2026 21:24:01 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH dpdk] net/mlx5: add option to reduce Tx datapath compilation
 time
Date: Tue, 21 Apr 2026 23:23:55 +0200
Message-ID: <20260421212356.573976-1-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DaZ-PJZt4lClfbX0J5ihSYjqDaoPZVRzR9r2htmV9L4_1776806644
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

The mlx5 Tx datapath compiles 42 variants of the burst function, each
a specialization of mlx5_tx_burst_tmpl() with a different combination
of offload flags. The compiler must instantiate and optimize the entire
3800+ line template for every variant, which dominates build time for
all the code base.

When MLX5_MINIMAL_TX is defined, only 11 variants are compiled instead
of 42. Two new "full without inline" superset variants (full_noi and
full_noi_empw) are introduced to satisfy the selection algorithm
constraint that the INLINE bit must match exactly between request and
variant. The remaining 9 variants are existing ones that already cover
all reachable combinations of the EMPW, MPW, INLINE and TXPP flags.

The selection function is unchanged. At runtime, it picks the best
matching variant from whatever is available. With the minimal set, each
selected variant may include a few unnecessary offload checks compared
to the precisely-tailored original, which has negligible impact on
performance since modern branch predictors handle static never-taken
branches well.

Compilation times (MM:SS) measured on Intel Core Ultra 7 165U with GCC
16.0.1:

FILE              BUILD          BEFORE   AFTER   DELTA
================= ============== ======== ======= ===============
mlx5_tx_mpw.c     debug          00:31    00:22   -00:09 (-29.0%)
mlx5_tx_txpp.c                   00:39    00:25   -00:14 (-35.9%)
mlx5_tx_empw.c                   01:11    00:19   -00:52 (-73.2%)
mlx5_tx_nompw.c                  01:13    00:16   -00:57 (-78.1%)
----------------- -------------- -------- ------- ---------------
mlx5_tx_mpw.c     debug+asan     03:15    02:45   -00:30 (-15.4%)
mlx5_tx_txpp.c                  *06:28*   03:13   -03:15 (-50.3%)
mlx5_tx_empw.c                  *12:07*   01:55   -10:12 (-84.2%)
mlx5_tx_nompw.c                 *12:54*   01:45   -11:09 (-86.4%)
----------------- -------------- -------- ------- ---------------
mlx5_tx_mpw.c     release        00:12    00:09   -00:03 (-25.0%)
mlx5_tx_txpp.c                   00:31    00:24   -00:07 (-22.6%)
mlx5_tx_empw.c                   00:32    00:18   -00:14 (-43.8%)
mlx5_tx_nompw.c                  00:34    00:16   -00:18 (-52.9%)
----------------- -------------- -------- ------- ---------------
mlx5_tx_mpw.c     release+asan   00:25    00:23   -00:02 (-8.0%)
mlx5_tx_empw.c                   01:24    00:42   -00:42 (-50.0%)
mlx5_tx_txpp.c                   01:32    00:59   -00:33 (-35.9%)
mlx5_tx_nompw.c                  01:38    00:37   -01:01 (-62.2%)

To enable, pass -DMLX5_MINIMAL_TX via c_args:

  meson setup build -Dc_args='-DMLX5_MINIMAL_TX'

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 drivers/net/mlx5/mlx5_tx.c       | 23 +++++++++++++++++++++++
 drivers/net/mlx5/mlx5_tx.h       | 12 ++++++++++++
 drivers/net/mlx5/mlx5_tx_empw.c  | 10 ++++++++++
 drivers/net/mlx5/mlx5_tx_mpw.c   |  2 ++
 drivers/net/mlx5/mlx5_tx_nompw.c |  9 +++++++++
 drivers/net/mlx5/mlx5_tx_txpp.c  |  2 ++
 6 files changed, 58 insertions(+)

diff --git a/drivers/net/mlx5/mlx5_tx.c b/drivers/net/mlx5/mlx5_tx.c
index 94644bc3b9e2..a395577bb7e6 100644
--- a/drivers/net/mlx5/mlx5_tx.c
+++ b/drivers/net/mlx5/mlx5_tx.c
@@ -294,6 +294,14 @@ MLX5_TXOFF_INFO(full_empw,
 		MLX5_TXOFF_CONFIG_INLINE | MLX5_TXOFF_CONFIG_VLAN |
 		MLX5_TXOFF_CONFIG_METADATA | MLX5_TXOFF_CONFIG_EMPW)
 
+#ifdef MLX5_MINIMAL_TX
+MLX5_TXOFF_INFO(full_noi_empw,
+		MLX5_TXOFF_CONFIG_MULTI | MLX5_TXOFF_CONFIG_TSO |
+		MLX5_TXOFF_CONFIG_SWP | MLX5_TXOFF_CONFIG_CSUM |
+		MLX5_TXOFF_CONFIG_VLAN | MLX5_TXOFF_CONFIG_METADATA |
+		MLX5_TXOFF_CONFIG_EMPW)
+#else
+
 MLX5_TXOFF_INFO(none_empw,
 		MLX5_TXOFF_CONFIG_NONE | MLX5_TXOFF_CONFIG_EMPW)
 
@@ -355,6 +363,8 @@ MLX5_TXOFF_INFO(iv_empw,
 		MLX5_TXOFF_CONFIG_INLINE | MLX5_TXOFF_CONFIG_VLAN |
 		MLX5_TXOFF_CONFIG_METADATA | MLX5_TXOFF_CONFIG_EMPW)
 
+#endif /* !MLX5_MINIMAL_TX */
+
 MLX5_TXOFF_INFO(full_ts_nompw,
 		MLX5_TXOFF_CONFIG_FULL | MLX5_TXOFF_CONFIG_TXPP)
 
@@ -374,6 +384,7 @@ MLX5_TXOFF_INFO(full_ts_noi,
 		MLX5_TXOFF_CONFIG_VLAN | MLX5_TXOFF_CONFIG_METADATA |
 		MLX5_TXOFF_CONFIG_TXPP | MLX5_TXOFF_CONFIG_EMPW)
 
+#ifndef MLX5_MINIMAL_TX
 MLX5_TXOFF_INFO(none_ts,
 		MLX5_TXOFF_CONFIG_NONE | MLX5_TXOFF_CONFIG_TXPP |
 		MLX5_TXOFF_CONFIG_EMPW)
@@ -392,6 +403,7 @@ MLX5_TXOFF_INFO(mtiv_ts,
 		MLX5_TXOFF_CONFIG_INLINE | MLX5_TXOFF_CONFIG_VLAN |
 		MLX5_TXOFF_CONFIG_METADATA | MLX5_TXOFF_CONFIG_TXPP |
 		MLX5_TXOFF_CONFIG_EMPW)
+#endif
 
 MLX5_TXOFF_INFO(full,
 		MLX5_TXOFF_CONFIG_MULTI | MLX5_TXOFF_CONFIG_TSO |
@@ -399,6 +411,13 @@ MLX5_TXOFF_INFO(full,
 		MLX5_TXOFF_CONFIG_INLINE | MLX5_TXOFF_CONFIG_VLAN |
 		MLX5_TXOFF_CONFIG_METADATA)
 
+#ifdef MLX5_MINIMAL_TX
+MLX5_TXOFF_INFO(full_noi,
+		MLX5_TXOFF_CONFIG_MULTI | MLX5_TXOFF_CONFIG_TSO |
+		MLX5_TXOFF_CONFIG_SWP | MLX5_TXOFF_CONFIG_CSUM |
+		MLX5_TXOFF_CONFIG_VLAN | MLX5_TXOFF_CONFIG_METADATA)
+#else
+
 MLX5_TXOFF_INFO(none,
 		MLX5_TXOFF_CONFIG_NONE)
 
@@ -460,6 +479,8 @@ MLX5_TXOFF_INFO(iv,
 		MLX5_TXOFF_CONFIG_INLINE | MLX5_TXOFF_CONFIG_VLAN |
 		MLX5_TXOFF_CONFIG_METADATA)
 
+#endif /* !MLX5_MINIMAL_TX */
+
 MLX5_TXOFF_INFO(none_mpw,
 		MLX5_TXOFF_CONFIG_NONE | MLX5_TXOFF_CONFIG_EMPW |
 		MLX5_TXOFF_CONFIG_MPW)
@@ -473,9 +494,11 @@ MLX5_TXOFF_INFO(mc_mpw,
 		MLX5_TXOFF_CONFIG_MULTI | MLX5_TXOFF_CONFIG_CSUM |
 		MLX5_TXOFF_CONFIG_EMPW | MLX5_TXOFF_CONFIG_MPW)
 
+#ifndef MLX5_MINIMAL_TX
 MLX5_TXOFF_INFO(i_mpw,
 		MLX5_TXOFF_CONFIG_INLINE | MLX5_TXOFF_CONFIG_EMPW |
 		MLX5_TXOFF_CONFIG_MPW)
+#endif
 };
 
 /**
diff --git a/drivers/net/mlx5/mlx5_tx.h b/drivers/net/mlx5/mlx5_tx.h
index 016dba0b03c6..db55355abdd9 100644
--- a/drivers/net/mlx5/mlx5_tx.h
+++ b/drivers/net/mlx5/mlx5_tx.h
@@ -244,6 +244,9 @@ int mlx5_tx_burst_mode_get(struct rte_eth_dev *dev, uint16_t tx_queue_id,
 /* mlx5_tx_empw.c */
 
 MLX5_TXOFF_PRE_DECL(full_empw);
+#ifdef MLX5_MINIMAL_TX
+MLX5_TXOFF_PRE_DECL(full_noi_empw);
+#else
 MLX5_TXOFF_PRE_DECL(none_empw);
 MLX5_TXOFF_PRE_DECL(md_empw);
 MLX5_TXOFF_PRE_DECL(mt_empw);
@@ -258,10 +261,14 @@ MLX5_TXOFF_PRE_DECL(sciv_empw);
 MLX5_TXOFF_PRE_DECL(i_empw);
 MLX5_TXOFF_PRE_DECL(v_empw);
 MLX5_TXOFF_PRE_DECL(iv_empw);
+#endif
 
 /* mlx5_tx_nompw.c */
 
 MLX5_TXOFF_PRE_DECL(full);
+#ifdef MLX5_MINIMAL_TX
+MLX5_TXOFF_PRE_DECL(full_noi);
+#else
 MLX5_TXOFF_PRE_DECL(none);
 MLX5_TXOFF_PRE_DECL(md);
 MLX5_TXOFF_PRE_DECL(mt);
@@ -276,6 +283,7 @@ MLX5_TXOFF_PRE_DECL(sciv);
 MLX5_TXOFF_PRE_DECL(i);
 MLX5_TXOFF_PRE_DECL(v);
 MLX5_TXOFF_PRE_DECL(iv);
+#endif
 
 /* mlx5_tx_txpp.c */
 
@@ -283,17 +291,21 @@ MLX5_TXOFF_PRE_DECL(full_ts_nompw);
 MLX5_TXOFF_PRE_DECL(full_ts_nompwi);
 MLX5_TXOFF_PRE_DECL(full_ts);
 MLX5_TXOFF_PRE_DECL(full_ts_noi);
+#ifndef MLX5_MINIMAL_TX
 MLX5_TXOFF_PRE_DECL(none_ts);
 MLX5_TXOFF_PRE_DECL(mdi_ts);
 MLX5_TXOFF_PRE_DECL(mti_ts);
 MLX5_TXOFF_PRE_DECL(mtiv_ts);
+#endif
 
 /* mlx5_tx_mpw.c */
 
 MLX5_TXOFF_PRE_DECL(none_mpw);
 MLX5_TXOFF_PRE_DECL(mci_mpw);
 MLX5_TXOFF_PRE_DECL(mc_mpw);
+#ifndef MLX5_MINIMAL_TX
 MLX5_TXOFF_PRE_DECL(i_mpw);
+#endif
 
 static __rte_always_inline struct mlx5_uar_data *
 mlx5_tx_bfreg(struct mlx5_txq_data *txq)
diff --git a/drivers/net/mlx5/mlx5_tx_empw.c b/drivers/net/mlx5/mlx5_tx_empw.c
index 81c2dc451b14..4cb9965956c5 100644
--- a/drivers/net/mlx5/mlx5_tx_empw.c
+++ b/drivers/net/mlx5/mlx5_tx_empw.c
@@ -9,6 +9,14 @@
 MLX5_TXOFF_DECL(full_empw,
 		MLX5_TXOFF_CONFIG_FULL | MLX5_TXOFF_CONFIG_EMPW)
 
+#ifdef MLX5_MINIMAL_TX
+MLX5_TXOFF_DECL(full_noi_empw,
+		MLX5_TXOFF_CONFIG_MULTI | MLX5_TXOFF_CONFIG_TSO |
+		MLX5_TXOFF_CONFIG_SWP | MLX5_TXOFF_CONFIG_CSUM |
+		MLX5_TXOFF_CONFIG_VLAN | MLX5_TXOFF_CONFIG_METADATA |
+		MLX5_TXOFF_CONFIG_EMPW)
+#else
+
 MLX5_TXOFF_DECL(none_empw,
 		MLX5_TXOFF_CONFIG_NONE | MLX5_TXOFF_CONFIG_EMPW)
 
@@ -69,3 +77,5 @@ MLX5_TXOFF_DECL(v_empw,
 MLX5_TXOFF_DECL(iv_empw,
 		MLX5_TXOFF_CONFIG_INLINE | MLX5_TXOFF_CONFIG_VLAN |
 		MLX5_TXOFF_CONFIG_METADATA | MLX5_TXOFF_CONFIG_EMPW)
+
+#endif /* !MLX5_MINIMAL_TX */
diff --git a/drivers/net/mlx5/mlx5_tx_mpw.c b/drivers/net/mlx5/mlx5_tx_mpw.c
index bd7d5d2e533f..15061cde5bb1 100644
--- a/drivers/net/mlx5/mlx5_tx_mpw.c
+++ b/drivers/net/mlx5/mlx5_tx_mpw.c
@@ -29,6 +29,8 @@ MLX5_TXOFF_DECL(mc_mpw,
 		MLX5_TXOFF_CONFIG_MULTI | MLX5_TXOFF_CONFIG_CSUM |
 		MLX5_TXOFF_CONFIG_EMPW | MLX5_TXOFF_CONFIG_MPW)
 
+#ifndef MLX5_MINIMAL_TX
 MLX5_TXOFF_DECL(i_mpw,
 		MLX5_TXOFF_CONFIG_INLINE | MLX5_TXOFF_CONFIG_EMPW |
 		MLX5_TXOFF_CONFIG_MPW)
+#endif
diff --git a/drivers/net/mlx5/mlx5_tx_nompw.c b/drivers/net/mlx5/mlx5_tx_nompw.c
index ad23aab5d37b..a4d9ac8c576a 100644
--- a/drivers/net/mlx5/mlx5_tx_nompw.c
+++ b/drivers/net/mlx5/mlx5_tx_nompw.c
@@ -9,6 +9,13 @@
 MLX5_TXOFF_DECL(full,
 		MLX5_TXOFF_CONFIG_FULL)
 
+#ifdef MLX5_MINIMAL_TX
+MLX5_TXOFF_DECL(full_noi,
+		MLX5_TXOFF_CONFIG_MULTI | MLX5_TXOFF_CONFIG_TSO |
+		MLX5_TXOFF_CONFIG_SWP | MLX5_TXOFF_CONFIG_CSUM |
+		MLX5_TXOFF_CONFIG_VLAN | MLX5_TXOFF_CONFIG_METADATA)
+#else
+
 MLX5_TXOFF_DECL(none,
 		MLX5_TXOFF_CONFIG_NONE)
 
@@ -69,3 +76,5 @@ MLX5_TXOFF_DECL(v,
 MLX5_TXOFF_DECL(iv,
 		MLX5_TXOFF_CONFIG_INLINE | MLX5_TXOFF_CONFIG_VLAN |
 		MLX5_TXOFF_CONFIG_METADATA)
+
+#endif /* !MLX5_MINIMAL_TX */
diff --git a/drivers/net/mlx5/mlx5_tx_txpp.c b/drivers/net/mlx5/mlx5_tx_txpp.c
index 4d2a4c65f752..3e48a2bbe23c 100644
--- a/drivers/net/mlx5/mlx5_tx_txpp.c
+++ b/drivers/net/mlx5/mlx5_tx_txpp.c
@@ -25,6 +25,7 @@ MLX5_TXOFF_DECL(full_ts_noi,
 		MLX5_TXOFF_CONFIG_VLAN | MLX5_TXOFF_CONFIG_METADATA |
 		MLX5_TXOFF_CONFIG_TXPP | MLX5_TXOFF_CONFIG_EMPW)
 
+#ifndef MLX5_MINIMAL_TX
 MLX5_TXOFF_DECL(none_ts,
 		MLX5_TXOFF_CONFIG_NONE | MLX5_TXOFF_CONFIG_TXPP |
 		MLX5_TXOFF_CONFIG_EMPW)
@@ -43,3 +44,4 @@ MLX5_TXOFF_DECL(mtiv_ts,
 		MLX5_TXOFF_CONFIG_INLINE | MLX5_TXOFF_CONFIG_VLAN |
 		MLX5_TXOFF_CONFIG_METADATA | MLX5_TXOFF_CONFIG_TXPP |
 		MLX5_TXOFF_CONFIG_EMPW)
+#endif /* !MLX5_MINIMAL_TX */
-- 
2.53.0

