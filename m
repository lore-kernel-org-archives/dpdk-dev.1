Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E59CD98CF
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 10:48:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14FC840E1C;
	Tue, 16 Jun 2026 12:47:54 +0200 (CEST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 7538F4026A
 for <dev@dpdk.org>; Tue, 16 Jun 2026 12:47:52 +0200 (CEST)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-490ace40f4bso41568945e9.3
 for <dev@dpdk.org>; Tue, 16 Jun 2026 03:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781606872; x=1782211672; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JoWru0902VU6D9M192MGnDyFnfXoLczh39IHlkQPPeo=;
 b=G8/ze2kJoQCx1vQIamalDCEZ2FyMgc8WPpz3Id9Edf6YDm9B2qjW8zTfimSnLXDcVb
 ImuGxhfkp59MMGM3aDle2OpyxvH2YJZqlwutm0+16b5fnORfM9yZJ+EXucAo3bTdpoc2
 8sY3jktB/xW1cr7+yjDnQHc9QgA71fKRpz+VPIZPjV31/ra6g93RcUW8t6nTlum/D1zN
 8uc0uW6phT2JCVod5rmmwx9dFa6jKo94aoLFmxIlPPLkjXDC+HWAmIxG47p3u0sGvAdN
 2ld9Mohd7OdA+xBtnYaZvVfdhQeOhHJCAQDJYo72cUMiTVVF0tXmieIgX0px6DQgi5iQ
 F2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781606872; x=1782211672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JoWru0902VU6D9M192MGnDyFnfXoLczh39IHlkQPPeo=;
 b=QWrhps0DPVSijnOzh8YdDlLfP8aq1a6ecXnZh1gxe+osf+SEK0Sfl/H/J9SgeS9pUO
 vyEEghOC2A2v4CgrFnlJ5lbITLLC1wcsR9vX66PHRNyvFUVuqOJa59glUpsuWXSK0V3d
 2W8hFn1uyucM4n6N6qPzs47MxqC99CSyzPIShFBt/hbwrbsiAW4+i59D/6NuKq8Tp4aT
 1kKIwxSVVbB6hVa4EAYJFBJkSkcSkRzwf0a3cIXY9/Fpflgo8CdYAE7fIylD7zxRaJXu
 wGoS7I4HjOqlQridRzH/u4uG15fLIVqf8Sy0Mg+uQ5Sk3oIeOeT3qr2u+btHaays11pi
 MRag==
X-Gm-Message-State: AOJu0Yz1fG5U3+M8C8/CD23KYHERAOQjcdHRVaKrkHSYQ6rpXQs1B0F1
 /KK1Wep+WLeQHD+S1dapvWyHwUwyBWN5VNDRXe9c7TupmqHywtbFWCPV2aeUujxy
X-Gm-Gg: Acq92OHBUKdZpljYxQLX9L0qlO1IEmf/cFkkApD4fz9fxfFBDKU3a98/Q0R8aoKrEv2
 Aoei01dneVNlZHrsVKrdMl8RKQ8kKDn/57RL+mrrJL8EvdTg8uIsOcgqrt8aNPa12561fo3xRhp
 2sfItzYxQMIkvSRK49BDJKoPhIurWpycJtv4jJnTOie/El7vgs+BT4RCRAhLDI4Y/VuaMJqDSh1
 xOk4RdeHnydt7GHBU1GzjN9+1odgu0sWh6cZfpsxnd5M18N/+jMwquDBo2l79Zpm3HWvTJCXF+d
 eiBjhdWjbeO8YEM02xeQgCjqIQ7zjaoCUSK1b7eCkUkD2ByKtU9O7JcI1xfRJ7zl2OpgsjAmHc9
 bl9lbTqzGKoUvhPDoXsSKl6+Ebjjts8aRcXwJVXdiBz0zI6JaCKtNAAGeSEUFfelRM/njjo/NWq
 D+MP2Dbri9sPTGf7QB0KyghIBmNZqmKw4Y+UNGTirsM+Vs2LknDBWhYHv6JG7jdAc=
X-Received: by 2002:a05:600d:8446:20b0:492:1e36:4271 with SMTP id
 5b1f17b1804b1-49220149873mr142623945e9.37.1781606871853; 
 Tue, 16 Jun 2026 03:47:51 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa3a4easm70429965e9.3.2026.06.16.03.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:47:51 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Maxime Leroy <maxime@leroys.fr>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH 6/6] net/dpaa2: implement RSS RETA query and update
Date: Tue, 16 Jun 2026 12:47:15 +0200
Message-ID: <20260616104717.723087-7-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616104717.723087-1-maxime@leroys.fr>
References: <20260616104717.723087-1-maxime@leroys.fr>
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

DPAA2 dispatches RX frames to FQs using 'queue_id = hash % dist_size',
where dist_size is set per-TC via the dpni_set_rx_hash_dist MC command.
There is no software-visible indirection table, so the standard DPDK
RETA API has never been exposed by this PMD.

Implement reta_update / reta_query as an emulation on top of
dpni_set_rx_hash_dist. The emulation accepts only the uniform pattern
'reta[i] = i % N' for some N in the HW-allowed set (1, 2, 3, 4, 6, 7,
8, 12, 14, 16, 24, ...). Non-uniform or weighted patterns are rejected
with -ENOTSUP, as the HW has no arbitrary indirection table.

Changing N sets the size of the contiguous queue subset that RSS
spreads traffic over; the queues above N are left out of the hash
distribution. This covers the patterns that matter here, e.g. growing
or shrinking the active subset to scale CPU cores with load, or
reserving the upper queues for specific traffic that rte_flow steers
there for dedicated polling or QoS handling on its own core.

Refactor the existing dpaa2_setup_flow_dist() to delegate to a new
helper dpaa2_setup_flow_dist_size() that takes the dist_size explicitly
and caches it in priv->dist_size_cur[tc] so reta_query() can report it.

reta_query() returns reta[i] = i % N: this is representative, not
bit-exact, as the HW maps the hash to a queue through its distribution
size encoding rather than a plain modulo. reta_update() takes the RSS
hash set from dev_conf (rx_adv_conf.rss_conf.rss_hf); a prior
rss_hash_update() with a different hf is not re-read.

The advertised reta_size is 64 (one rte_eth_rss_reta_entry64 group), the
smallest legal value and enough for all HW-permitted N values up to 64.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 doc/guides/nics/features/dpaa2.ini     |   1 +
 doc/guides/rel_notes/release_26_07.rst |   1 +
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c |  34 +++--
 drivers/net/dpaa2/dpaa2_ethdev.c       | 201 +++++++++++++++++++++++++
 drivers/net/dpaa2/dpaa2_ethdev.h       |   9 ++
 5 files changed, 237 insertions(+), 9 deletions(-)

diff --git a/doc/guides/nics/features/dpaa2.ini b/doc/guides/nics/features/dpaa2.ini
index 5f9c587847..5def653d1d 100644
--- a/doc/guides/nics/features/dpaa2.ini
+++ b/doc/guides/nics/features/dpaa2.ini
@@ -15,6 +15,7 @@ Promiscuous mode     = Y
 Allmulticast mode    = Y
 Unicast MAC filter   = Y
 RSS hash             = Y
+RSS reta update      = Y
 VLAN filter          = Y
 Flow control         = Y
 Traffic manager      = Y
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 39f3988198..b22ba4d6f0 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -143,6 +143,7 @@ New Features
 * **Updated NXP dpaa2 driver.**
 
   * Added inner RSS level support for tunnelled traffic.
+  * Added RSS RETA query and update support.
 
 * **Updated PCAP ethernet driver.**
 
diff --git a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
index 8a05253bbd..07f4a3d414 100644
--- a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
+++ b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
@@ -103,15 +103,10 @@ dpaa2_setup_flow_dist(struct rte_eth_dev *eth_dev,
 	uint64_t req_dist_set, int tc_index)
 {
 	struct dpaa2_dev_priv *priv = eth_dev->data->dev_private;
-	struct fsl_mc_io *dpni = eth_dev->process_private;
-	struct dpni_rx_dist_cfg tc_cfg;
-	struct dpkg_profile_cfg kg_cfg;
-	void *p_params;
-	int ret, tc_dist_queues;
+	int tc_dist_queues;
 
-	/*TC distribution size is set with dist_queues or
-	 * nb_rx_queues % dist_queues in order of TC priority index.
-	 * Calculating dist size for this tc_index:-
+	/* TC distribution size is set with dist_queues or
+	 * (nb_rx_queues - tc_index*dist_queues) in order of TC priority index.
 	 */
 	tc_dist_queues = eth_dev->data->nb_rx_queues -
 		tc_index * priv->dist_queues;
@@ -123,6 +118,24 @@ dpaa2_setup_flow_dist(struct rte_eth_dev *eth_dev,
 	if (tc_dist_queues > priv->dist_queues)
 		tc_dist_queues = priv->dist_queues;
 
+	return dpaa2_setup_flow_dist_size(eth_dev, req_dist_set,
+					   tc_index, tc_dist_queues);
+}
+
+int
+dpaa2_setup_flow_dist_size(struct rte_eth_dev *eth_dev,
+	uint64_t req_dist_set, int tc_index, uint16_t dist_size)
+{
+	struct dpaa2_dev_priv *priv = eth_dev->data->dev_private;
+	struct fsl_mc_io *dpni = eth_dev->process_private;
+	struct dpni_rx_dist_cfg tc_cfg;
+	struct dpkg_profile_cfg kg_cfg;
+	void *p_params;
+	int ret;
+
+	if (dist_size == 0)
+		return 0;
+
 	p_params = rte_malloc(NULL,
 		DIST_PARAM_IOVA_SIZE, RTE_CACHE_LINE_SIZE);
 	if (!p_params) {
@@ -150,7 +163,7 @@ dpaa2_setup_flow_dist(struct rte_eth_dev *eth_dev,
 		return -ENOBUFS;
 	}
 
-	tc_cfg.dist_size = tc_dist_queues;
+	tc_cfg.dist_size = dist_size;
 	tc_cfg.enable = true;
 	tc_cfg.tc = tc_index;
 
@@ -168,6 +181,9 @@ dpaa2_setup_flow_dist(struct rte_eth_dev *eth_dev,
 		return ret;
 	}
 
+	if (tc_index < MAX_TCS)
+		priv->dist_size_cur[tc_index] = dist_size;
+
 	return 0;
 }
 
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index c19736fb80..56682717cf 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -80,6 +80,33 @@ bool dpaa2_print_parser_result;
 #define MAX_NB_RX_DESC_IN_PEB	11264
 static int total_nb_rx_desc;
 
+/* Size of the RETA (Redirection Table) we expose to the standard DPDK API.
+ * Must be a multiple of RTE_ETH_RETA_GROUP_SIZE (64). DPAA2 has no actual
+ * indirection table in HW; this is the granularity at which uniform RSS
+ * patterns are inspected by dpaa2_dev_rss_reta_update().
+ */
+#define DPAA2_RETA_SIZE		64
+
+/* Values of dist_size accepted by the DPNI 'dpni_set_rx_hash_dist' MC command.
+ * Source: fsl_dpni.h, "struct dpni_rx_dist_cfg::dist_size" documentation.
+ * Used by dpaa2_dev_rss_reta_update() to validate user-requested patterns.
+ */
+static const uint16_t dpaa2_dist_size_allowed[] = {
+	1, 2, 3, 4, 6, 7, 8, 12, 14, 16, 24, 28, 32, 48, 56, 64,
+	96, 112, 128, 192, 224, 256, 384, 448, 512, 768, 896, 1024,
+};
+
+static bool
+dpaa2_dist_size_is_supported(uint16_t n)
+{
+	size_t i;
+	for (i = 0; i < RTE_DIM(dpaa2_dist_size_allowed); i++) {
+		if (dpaa2_dist_size_allowed[i] == n)
+			return true;
+	}
+	return false;
+}
+
 int dpaa2_valid_dev;
 struct rte_mempool *dpaa2_tx_sg_pool;
 
@@ -426,6 +453,14 @@ dpaa2_dev_info_get(struct rte_eth_dev *dev,
 	dev_info->max_vmdq_pools = RTE_ETH_16_POOLS;
 	dev_info->flow_type_rss_offloads = DPAA2_RSS_OFFLOAD_ALL |
 		RTE_ETH_RSS_LEVEL_OUTERMOST | RTE_ETH_RSS_LEVEL_INNERMOST;
+	/* DPAA2 has no software-visible indirection table: incoming packets are
+	 * dispatched to FQs via 'queue_id = hash % dist_size'. We expose the
+	 * standard RETA API as an emulation that only accepts uniform patterns
+	 * 'reta[i] = i % N' and translates them into a dpni_set_rx_hash_dist
+	 * command with dist_size=N. See dpaa2_dev_rss_reta_update().
+	 */
+	dev_info->reta_size = DPAA2_RETA_SIZE;
+	dev_info->hash_key_size = 0;
 
 	dev_info->default_rxportconf.burst_size = dpaa2_dqrr_size;
 	/* same is rx size for best perf */
@@ -2509,6 +2544,170 @@ dpaa2_dev_rss_hash_conf_get(struct rte_eth_dev *dev,
 	return 0;
 }
 
+/* Emulation of the standard DPDK RETA API on top of DPAA2's
+ * dpni_set_rx_hash_dist MC command.
+ *
+ * DPAA2 hardware dispatches incoming frames using 'queue_id = hash % dist_size'
+ * (no software-visible indirection table). To expose the standard
+ * rte_eth_dev_rss_reta_update() interface, we accept ONLY uniform patterns of
+ * the form 'reta[i] = i % N' where N is in the HW-allowed dist_size list. Any
+ * other pattern (weighted RSS, non-contiguous queue IDs, gaps) is rejected
+ * with -ENOTSUP. This is enough to support dynamic RSS scale-up/down across
+ * a contiguous queue subset, which is the main use case for adaptive
+ * dataplane CPU usage.
+ *
+ * Applies the new dist_size on every configured RX TC, mirroring the
+ * behavior of dpaa2_dev_rss_hash_update().
+ */
+static int
+dpaa2_dev_rss_reta_update(struct rte_eth_dev *dev,
+			  struct rte_eth_rss_reta_entry64 *reta_conf,
+			  uint16_t reta_size)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct rte_eth_conf *eth_conf = &dev->data->dev_conf;
+	uint16_t i, max_q = 0, n;
+	int tc_index, ret;
+	bool any_set = false;
+
+	PMD_INIT_FUNC_TRACE();
+
+	if (reta_size != DPAA2_RETA_SIZE) {
+		DPAA2_PMD_ERR("Invalid reta_size %u (expected %u)",
+			      reta_size, DPAA2_RETA_SIZE);
+		return -EINVAL;
+	}
+
+	/* dpaa2 cannot merge a partial RETA into the live table, so only a
+	 * full update (every entry of every group) is accepted.
+	 */
+	for (i = 0; i < reta_size / RTE_ETH_RETA_GROUP_SIZE; i++) {
+		if (reta_conf[i].mask != UINT64_MAX) {
+			DPAA2_PMD_ERR("partial RETA update not supported; set all %u entries",
+				      DPAA2_RETA_SIZE);
+			return -ENOTSUP;
+		}
+	}
+
+	/* First pass: validate queue IDs, find max, and require at least
+	 * one slot to be selected via the per-group mask.
+	 */
+	for (i = 0; i < reta_size; i++) {
+		uint16_t grp = i / RTE_ETH_RETA_GROUP_SIZE;
+		uint16_t pos = i % RTE_ETH_RETA_GROUP_SIZE;
+		uint16_t q;
+
+		if (!(reta_conf[grp].mask & (1ULL << pos)))
+			continue;
+		any_set = true;
+
+		q = reta_conf[grp].reta[pos];
+		if (q >= dev->data->nb_rx_queues) {
+			DPAA2_PMD_ERR("reta[%u] = %u out of range (max %u)",
+				i, q, dev->data->nb_rx_queues - 1);
+			return -EINVAL;
+		}
+		if (q > max_q)
+			max_q = q;
+	}
+
+	if (!any_set) {
+		DPAA2_PMD_WARN("reta_update called with empty mask, no-op");
+		return 0;
+	}
+
+	n = max_q + 1;
+
+	/* Second pass: enforce the uniform pattern reta[i] = i % n on every
+	 * slot the user has selected. dpaa2 HW cannot honor any other layout.
+	 */
+	for (i = 0; i < reta_size; i++) {
+		uint16_t grp = i / RTE_ETH_RETA_GROUP_SIZE;
+		uint16_t pos = i % RTE_ETH_RETA_GROUP_SIZE;
+		uint16_t expected = i % n;
+		uint16_t q;
+
+		if (!(reta_conf[grp].mask & (1ULL << pos)))
+			continue;
+
+		q = reta_conf[grp].reta[pos];
+		if (q != expected) {
+			DPAA2_PMD_ERR("Non-uniform RETA pattern at slot %u "
+				"(got queue %u, expected %u). dpaa2 HW "
+				"only supports queue_id = hash mod N with "
+				"contiguous queues 0..N-1.",
+				i, q, expected);
+			return -ENOTSUP;
+		}
+	}
+
+	if (!dpaa2_dist_size_is_supported(n)) {
+		DPAA2_PMD_ERR("dist_size %u not supported by HW. Allowed: "
+			"1,2,3,4,6,7,8,12,14,16,24,28,32,48,56,64,...",
+			n);
+		return -ENOTSUP;
+	}
+
+	/* Apply on every configured RX TC, matching rss_hash_update behavior. */
+	for (tc_index = 0; tc_index < priv->num_rx_tc; tc_index++) {
+		ret = dpaa2_setup_flow_dist_size(dev,
+				eth_conf->rx_adv_conf.rss_conf.rss_hf,
+				tc_index, n);
+		if (ret) {
+			DPAA2_PMD_ERR("Failed to apply dist_size=%u on tc%d (err=%d)",
+				n, tc_index, ret);
+			return ret;
+		}
+	}
+
+	DPAA2_PMD_DEBUG("RETA updated: dist_size now %u on %u TC(s)",
+			n, priv->num_rx_tc);
+	return 0;
+}
+
+/* Synthesizes a RETA snapshot from the currently-active dist_size on TC 0.
+ * Since DPAA2 always uses uniform 'hash mod N' distribution, the returned
+ * RETA is reta[i] = i % dist_size_cur[0].
+ */
+static int
+dpaa2_dev_rss_reta_query(struct rte_eth_dev *dev,
+			 struct rte_eth_rss_reta_entry64 *reta_conf,
+			 uint16_t reta_size)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	uint16_t i, n;
+
+	PMD_INIT_FUNC_TRACE();
+
+	if (reta_size != DPAA2_RETA_SIZE) {
+		DPAA2_PMD_ERR("Invalid reta_size %u (expected %u)",
+			      reta_size, DPAA2_RETA_SIZE);
+		return -EINVAL;
+	}
+
+	/* Use the cached dist_size on TC 0 (representative). Fall back to the
+	 * default (nb_rx_queues clamped to dist_queues) when never programmed.
+	 */
+	n = priv->dist_size_cur[0];
+	if (n == 0) {
+		n = priv->dist_queues;
+		if (n > dev->data->nb_rx_queues)
+			n = dev->data->nb_rx_queues;
+	}
+	if (n == 0)
+		return -EINVAL;
+
+	for (i = 0; i < reta_size; i++) {
+		uint16_t grp = i / RTE_ETH_RETA_GROUP_SIZE;
+		uint16_t pos = i % RTE_ETH_RETA_GROUP_SIZE;
+
+		if (reta_conf[grp].mask & (1ULL << pos))
+			reta_conf[grp].reta[pos] = i % n;
+	}
+
+	return 0;
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_eth_eventq_attach)
 int dpaa2_eth_eventq_attach(const struct rte_eth_dev *dev,
 		int eth_rx_queue_id,
@@ -2737,6 +2936,8 @@ static struct eth_dev_ops dpaa2_ethdev_ops = {
 	.mac_addr_set         = dpaa2_dev_set_mac_addr,
 	.rss_hash_update      = dpaa2_dev_rss_hash_update,
 	.rss_hash_conf_get    = dpaa2_dev_rss_hash_conf_get,
+	.reta_update          = dpaa2_dev_rss_reta_update,
+	.reta_query           = dpaa2_dev_rss_reta_query,
 	.flow_ops_get         = dpaa2_dev_flow_ops_get,
 	.rxq_info_get	      = dpaa2_rxq_info_get,
 	.txq_info_get	      = dpaa2_txq_info_get,
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 4da47a543a..3f224c654e 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -412,6 +412,12 @@ struct dpaa2_dev_priv {
 	uint8_t max_cgs;
 	uint8_t cgid_in_use[MAX_RX_QUEUES];
 
+	/* Current hash distribution size per RX TC, written by
+	 * dpaa2_setup_flow_dist_size() and read by reta_query / reta_update.
+	 * Zero means "use default" (= nb_rx_queues clamped to dist_queues).
+	 */
+	uint16_t dist_size_cur[MAX_TCS];
+
 	uint16_t dpni_ver_major;
 	uint16_t dpni_ver_minor;
 	uint32_t speed_capa;
@@ -468,6 +474,9 @@ int dpaa2_distset_to_dpkg_profile_cfg(uint64_t req_dist_set,
 int dpaa2_setup_flow_dist(struct rte_eth_dev *eth_dev,
 		uint64_t req_dist_set, int tc_index);
 
+int dpaa2_setup_flow_dist_size(struct rte_eth_dev *eth_dev,
+		uint64_t req_dist_set, int tc_index, uint16_t dist_size);
+
 int dpaa2_remove_flow_dist(struct rte_eth_dev *eth_dev,
 			   uint8_t tc_index);
 
-- 
2.43.0

