Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1F0C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 11:40:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF49B4065B;
	Tue, 30 Jun 2026 13:40:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 17B8A4065A
 for <dev@dpdk.org>; Tue, 30 Jun 2026 13:40:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782819624; x=1814355624;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tBrM4bUaF0FYnKoucdZEylGXBhcBpGWw+JPIfla0aic=;
 b=FHfjmH2sLs5xPr6kVkJphnb48rvO4yDhBEUZ5Zv8K/kWyQmqbti7gOjQ
 CY2UrIaOLYs9SXxsQ14B05ZcAXpkP8Uf53l36COjSPAGHDs60U5lxZMSS
 9oTa25Z6caXMHeYMPPHwyU5R0ta2ecbNlzWqgCNLIyTljuzmh/TlvFA+y
 MTh1QjZ+Ca7KixSp1d/VhZP7u1awFm7yqzzYf5IBzxdSEDy4PJwVVkdqK
 xrcHN+mFsx5hNAwfNrymTTTvnjus8DHGrt/zBGsFJ7nkouSthSfp+xpFW
 Ug7MLqTGxZ9bPlertRoPKWKzbUTRgqUNC4FVhXh4pT+IXX01FTitIFf17 w==;
X-CSE-ConnectionGUID: uYZcDAmnS2WRcFdwvXigvQ==
X-CSE-MsgGUID: xmsPpjqFTQq9z2glr8/b7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="82643735"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="82643735"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 04:40:23 -0700
X-CSE-ConnectionGUID: uS6K2pLHR42TnZTGSV9vWg==
X-CSE-MsgGUID: nQCPUgwgSB+DOn4OMXVA1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="245891147"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by fmviesa009.fm.intel.com with ESMTP; 30 Jun 2026 04:40:22 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org, marek.kasiewicz@intel.com,
 Dawid Wesierski <dawid.wesierski@intel.com>
Subject: [PATCH v3 3/6] net/ice: add scheduler rate-limiter burst size devarg
Date: Tue, 30 Jun 2026 08:06:53 -0400
Message-ID: <20260630120657.1046588-4-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630120657.1046588-1-dawid.wesierski@intel.com>
References: <20260618144442.312844-8-dawid.wesierski@intel.com>
 <20260630120657.1046588-1-dawid.wesierski@intel.com>
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

From: Marek Kasiewicz <marek.kasiewicz@intel.com>

The E810 Tx scheduler uses a token bucket algorithm where the burst
size controls the maximum bytes sent in a single burst before the
rate limiter throttles. The hardware default of 15 KB allows
micro-bursts of ~10 max-size frames, which violates tight
inter-packet spacing requirements in time-sensitive networking
applications such as SMPTE ST 2110-21 narrow-sender compliance.

Add a "rl_burst_size" device argument that lets the application lower
the scheduler rate-limiter burst size (for example to 2 KB) to force
near-constant-rate output matching the configured shaper profile.
The burst size is a global scheduler resource, so the override is
applied once at probe time and only when the user explicitly requests
it; the hardware default is left unchanged otherwise.

Signed-off-by: Marek Kasiewicz <marek.kasiewicz@intel.com>
Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
---
 doc/guides/nics/ice.rst                | 12 +++++++
 doc/guides/rel_notes/release_26_07.rst |  5 +++
 drivers/net/intel/ice/ice_ethdev.c     | 46 ++++++++++++++++++++++++++
 drivers/net/intel/ice/ice_ethdev.h     |  1 +
 4 files changed, 64 insertions(+)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 8251416918..187c7e821f 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -158,6 +158,18 @@ Runtime Configuration
 
     -a 80:00.0,source-prune=1
 
+- ``Scheduler rate-limiter burst size`` (default ``0``)
+
+  The hardware Tx scheduler uses a default rate-limiter burst size that favours
+  throughput. Time-sensitive applications can lower this value to reduce Tx
+  latency jitter at the cost of throughput by setting the ``rl_burst_size``
+  devargs parameter, in bytes. The value is clamped to the hardware-allowed
+  range. A value of ``0`` (the default) keeps the hardware default.
+
+  For example::
+
+    -a 80:00.0,rl_burst_size=2048
+
 - ``Protocol extraction for per queue``
 
   Configure the RX queues to do protocol extraction into mbuf for protocol
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 5d7aa8d1bf..db8c4d5b16 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -136,6 +136,11 @@ New Features
   * Added support for transmitting LLDP packets based on mbuf packet type.
   * Implemented AVX2 context descriptor transmit paths.
 
+* **Updated Intel ice driver.**
+
+  * Added ``rl_burst_size`` devarg to configure the scheduler rate-limiter
+    burst size, reducing Tx latency jitter for time-sensitive traffic.
+
 * **Updated NVIDIA mlx5 ethernet driver.**
 
   * Added support for selective Rx in scalar SPRQ Rx path.
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index ad9c49b339..465cf07383 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -41,6 +41,7 @@
 #define ICE_DDP_FILENAME_ARG      "ddp_pkg_file"
 #define ICE_DDP_LOAD_SCHED_ARG    "ddp_load_sched_topo"
 #define ICE_TM_LEVELS_ARG         "tm_sched_levels"
+#define ICE_RL_BURST_SIZE_ARG     "rl_burst_size"
 #define ICE_SOURCE_PRUNE_ARG      "source-prune"
 #define ICE_LINK_STATE_ON_CLOSE   "link_state_on_close"
 
@@ -59,6 +60,7 @@ static const char * const ice_valid_args[] = {
 	ICE_DDP_FILENAME_ARG,
 	ICE_DDP_LOAD_SCHED_ARG,
 	ICE_TM_LEVELS_ARG,
+	ICE_RL_BURST_SIZE_ARG,
 	ICE_SOURCE_PRUNE_ARG,
 	ICE_LINK_STATE_ON_CLOSE,
 	NULL
@@ -2147,6 +2149,29 @@ parse_u64(const char *key, const char *value, void *args)
 	return 0;
 }
 
+static int
+parse_u32(const char *key, const char *value, void *args)
+{
+	uint32_t *num = args;
+	unsigned long tmp;
+	char *endptr;
+
+	errno = 0;
+	tmp = strtoul(value, &endptr, 0);
+	if (errno != 0 || endptr == value || *endptr != '\0') {
+		PMD_DRV_LOG(WARNING, "%s: \"%s\" is not a valid u32", key, value);
+		return -1;
+	}
+	if (tmp > UINT32_MAX) {
+		PMD_DRV_LOG(WARNING, "%s: value \"%s\" is out of range", key, value);
+		return -1;
+	}
+
+	*num = (uint32_t)tmp;
+
+	return 0;
+}
+
 static int
 parse_tx_sched_levels(const char *key, const char *value, void *args)
 {
@@ -2448,6 +2473,11 @@ static int ice_parse_devargs(struct rte_eth_dev *dev)
 	if (ret)
 		goto bail;
 
+	ret = rte_kvargs_process(kvlist, ICE_RL_BURST_SIZE_ARG,
+				 &parse_u32, &ad->devargs.rl_burst_size);
+	if (ret)
+		goto bail;
+
 	ret = rte_kvargs_process(kvlist, ICE_SOURCE_PRUNE_ARG,
 				 &parse_bool, &ad->devargs.source_prune);
 	if (ret)
@@ -2662,6 +2692,21 @@ ice_dev_init(struct rte_eth_dev *dev)
 		return -EINVAL;
 	}
 
+	/*
+	 * Override the hardware default scheduler rate-limiter burst size only
+	 * when the user explicitly requests it. A smaller burst reduces Tx
+	 * latency jitter for time-sensitive traffic at the cost of throughput,
+	 * so it must not change for every port. ice_cfg_rl_burst_size()
+	 * validates the value against the hardware-allowed range.
+	 */
+	if (ad->devargs.rl_burst_size != 0 &&
+	    ice_cfg_rl_burst_size(hw, ad->devargs.rl_burst_size) != 0) {
+		PMD_INIT_LOG(ERR, "Invalid rl_burst_size %u bytes",
+			     ad->devargs.rl_burst_size);
+		ice_deinit_hw(hw);
+		return -EINVAL;
+	}
+
 #ifndef RTE_EXEC_ENV_WINDOWS
 	use_dsn = false;
 	dsn = 0;
@@ -7713,6 +7758,7 @@ RTE_PMD_REGISTER_PARAM_STRING(net_ice,
 			      ICE_DDP_FILENAME_ARG "=</path/to/file>"
 			      ICE_DDP_LOAD_SCHED_ARG "=<0|1>"
 			      ICE_TM_LEVELS_ARG "=<N>"
+			      ICE_RL_BURST_SIZE_ARG "=<N>"
 			      ICE_SOURCE_PRUNE_ARG "=<0|1>"
 			      ICE_RX_LOW_LATENCY_ARG "=<0|1>"
 			      ICE_LINK_STATE_ON_CLOSE "=<down|up|initial>");
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 20e8a13fe9..0a9d75b9cd 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -631,6 +631,7 @@ struct ice_devargs {
 	uint8_t ddp_load_sched;
 	uint8_t tm_exposed_levels;
 	uint8_t source_prune;
+	uint32_t rl_burst_size;
 	int link_state_on_close;
 	int xtr_field_offs;
 	uint8_t xtr_flag_offs[PROTO_XTR_MAX];
-- 
2.47.3

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

