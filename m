Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FF1C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 22:53:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0DB640268;
	Thu,  9 Jul 2026 00:53:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id DB9F840697
 for <dev@dpdk.org>; Thu,  9 Jul 2026 00:53:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783551193; x=1815087193;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3jSHOMprfFYQd2txpWBwU/TIMJ9lNjsDLNEfuhLVAA4=;
 b=C9P2l9QuxlSNjwsnQpEgWAFu3L/8LWuUi9v38jxsAnC95MXhUgAJ7y8J
 JmRH54x0zyBkSddTCY7s5TUyP0+Fdft1nPteZ76/uqsCgRYuDFpV4gaCh
 RnvKSFpWFO2yANRXEj4Ea5ujnBZVfuXKPqEg2FrrOFsguGCWuHj5bxuY8
 PMcuAY6cjc2rff49mQpxQmlwff8JTDycpFQUwqaDzpP9thMbzLJDB+4wl
 6+7JI5X8DdAAL+hnMEQY0adf5mYORK4OLl3hyzu4anJrMswimqNoKMQ7W
 l0lIjEAxWQBL5fuuptm2nMEz8rQtfSkD4s8xXbfKxKfXxNmJBuwPlNqx7 g==;
X-CSE-ConnectionGUID: G7XiqyU7QpyRnf0DGoDERw==
X-CSE-MsgGUID: gTKNU0lfTIK7CvKEp6vEYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84342809"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="84342809"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 15:53:12 -0700
X-CSE-ConnectionGUID: J+Qo105lQsiuNwkaGEao3g==
X-CSE-MsgGUID: PFNSz5coTRqwfHhn60hqzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="292608255"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by orviesa001.jf.intel.com with ESMTP; 08 Jul 2026 15:53:10 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, marek.kasiewicz@intel.com,
 Dawid Wesierski <dawid.wesierski@intel.com>
Subject: [PATCH 2/2] net/iavf: disable runtime queue setup during queue rate
 limiting
Date: Wed,  8 Jul 2026 19:19:26 -0400
Message-ID: <20260708231926.1550698-3-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708231926.1550698-1-dawid.wesierski@intel.com>
References: <20260703121952.1277387-6-dawid.wesierski@intel.com>
 <20260708231926.1550698-1-dawid.wesierski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

Runtime queue setup on E810 VFs causes queue state corruption when
queues are dynamically reconfigured while the hardware rate limiter
is actively pacing TX queues. Queue configuration messages to the PF
via virtchnl can race with ongoing TX operations, leading to undefined
behavior.

Rather than gating this behind a devarg that an application would have
to know to set (and could just as easily avoid triggering the race by
not calling rte_eth_{rx,tx}_queue_setup() on a running port), stop
advertising RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP and
RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP as soon as the application
commits a per-queue bandwidth rte_tm hierarchy, i.e. as soon as the
condition that causes the race actually exists. iavf_dev_info_get() is
re-queried by the ethdev layer on every rx/tx_queue_setup() call, so
this is enough for the generic layer to start rejecting runtime queue
(re)configuration with -EBUSY once queue rate limiting is active, and
to automatically allow it again once the rte_tm hierarchy is torn
down.

vf->qtc_map, already used elsewhere to look up a queue's TC mapping,
is repurposed as the "queue bandwidth committed" signal since it's set
by iavf_hierarchy_commit() exactly when a per-queue bandwidth mapping
has been pushed to the PF, regardless of whether the port was stopped
at the time. Fix two related issues found while making it load-bearing
for this check:

- iavf_hierarchy_commit() replaced vf->qtc_map on every successful
  commit without freeing the previous allocation, leaking memory.
- vf->qtc_map was never released on VF teardown, so
  iavf_uninit_vf()/iavf_init_vf() (e.g. across a VF reset) could leave
  a stale pointer referencing freed unrelated memory, and the runtime
  queue setup capability would never be re-advertised after a reset.

Both are fixed by freeing vf->qtc_map before replacing it in
iavf_hierarchy_commit(), and freeing and clearing it in
iavf_uninit_vf().

Signed-off-by: Marek Kasiewicz <marek.kasiewicz@intel.com>
Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
---
 doc/guides/nics/intel_vf.rst           | 10 ++++++++++
 doc/guides/rel_notes/release_26_07.rst |  3 +++
 drivers/net/intel/iavf/iavf_ethdev.c   | 23 ++++++++++++++++++++---
 drivers/net/intel/iavf/iavf_tm.c       |  2 ++
 4 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
index e010f852cf..a47e3f6736 100644
--- a/doc/guides/nics/intel_vf.rst
+++ b/doc/guides/nics/intel_vf.rst
@@ -150,6 +150,16 @@ Intel\ |reg| E800 Series Ethernet devices:
   for example: ``-a 18:00.0,quanta_size=2048``.
   The default value is 1024, and quanta size should be set as the product of 64 in legacy host interface mode.
 
+* Runtime (post-start) Rx/Tx queue setup can race with the hardware Tx rate
+  limiter on E810 VFs and corrupt queue state.
+  Once an application commits a per-queue bandwidth ``rte_tm`` hierarchy,
+  the driver automatically stops advertising
+  ``RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP`` and
+  ``RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP``,
+  so ``rte_eth_rx_queue_setup()``/``rte_eth_tx_queue_setup()``
+  are rejected with ``-EBUSY`` on a running port for as long as queue rate
+  limiting is active.
+
 * When using the Intel out-of-tree "ice" PF/kernel driver v1.13.7 or later,
   to create VFs with >16 queues (aka. "large VFs"),
   it is necessary to change the rss_lut_vf_addr setting in sysfs from the default of 64 to 512.
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 6352ef27ab..7ea80112f4 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -143,6 +143,9 @@ New Features
 
   * Added support for transmitting LLDP packets based on mbuf packet type.
   * Implemented AVX2 context descriptor transmit paths.
+  * Runtime Rx/Tx queue setup is now automatically disabled while a
+    per-queue bandwidth ``rte_tm`` hierarchy is committed, to avoid
+    corrupting queue state on E810 VFs.
 
 * **Updated Intel ice driver.**
 
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 80e740ef29..5d0c361978 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -1160,9 +1160,18 @@ iavf_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->reta_size = vf->vf_res->rss_lut_size;
 	dev_info->flow_type_rss_offloads = IAVF_RSS_OFFLOAD_ALL;
 	dev_info->max_mac_addrs = IAVF_NUM_MACADDR_MAX;
-	dev_info->dev_capa =
-		RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP |
-		RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP;
+	/*
+	 * Runtime queue setup can race with the hardware Tx rate limiter on
+	 * E810 VFs and corrupt queue state. Once a per-queue bandwidth rte_tm
+	 * hierarchy has been committed (vf->qtc_map is set), stop advertising
+	 * the capability so the ethdev layer rejects further rx/tx_queue_setup()
+	 * calls on a running port with -EBUSY. The capability is re-advertised
+	 * automatically once the rte_tm hierarchy is torn down.
+	 */
+	if (vf->qtc_map == NULL)
+		dev_info->dev_capa =
+			RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP |
+			RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP;
 	dev_info->rx_offload_capa =
 		RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
 		RTE_ETH_RX_OFFLOAD_QINQ_STRIP |
@@ -2756,6 +2765,14 @@ iavf_uninit_vf(struct rte_eth_dev *dev)
 	rte_free(vf->qos_cap);
 	vf->qos_cap = NULL;
 
+	/*
+	 * Drop the committed queue/TC bandwidth mapping so a subsequent
+	 * iavf_init_vf() (e.g. after a device reset) starts with runtime
+	 * Rx/Tx queue setup available again (see iavf_dev_info_get()).
+	 */
+	rte_free(vf->qtc_map);
+	vf->qtc_map = NULL;
+
 	rte_free(vf->rss_lut);
 	vf->rss_lut = NULL;
 	rte_free(vf->rss_key);
diff --git a/drivers/net/intel/iavf/iavf_tm.c b/drivers/net/intel/iavf/iavf_tm.c
index e3492ec491..c9d856e937 100644
--- a/drivers/net/intel/iavf/iavf_tm.c
+++ b/drivers/net/intel/iavf/iavf_tm.c
@@ -905,6 +905,8 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
 	if (ret_val)
 		goto fail_clear;
 
+	/* replace the previously committed mapping, if any */
+	rte_free(vf->qtc_map);
 	vf->qtc_map = qtc_map;
 	if (adapter->stopped == 1)
 		vf->tm_conf.committed = true;
-- 
2.47.3

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

