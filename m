Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6402CA5FE0
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 19:44:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 607D342E99;
	Fri,  2 Oct 2026 21:44:12 +0200 (CEST)
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net
 [31.44.14.17]) by mails.dpdk.org (Postfix) with ESMTP id 8D2FD42DD6
 for <dev@dpdk.org>; Fri,  2 Oct 2026 21:44:09 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:31a0:0:640:75ad:0])
 by forward501d.mail.yandex.net (postfix) with ESMTPS id 422EE86808;
 Fri, 02 Oct 2026 22:44:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (smtp)
 with ESMTPSA id hhroUtamROs0-BH8xYVgz; 
 Fri, 02 Oct 2026 22:44:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1790970247; bh=zb7zMIkUu+BfH7+wdrOUCSVFIbFPgJtLvIbeUseEVj0=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=g1eneMjJK4sYJ1ZXbtJ/QPEG1hLn+QNWY79bsZte1ADcAz644OKgxhP59AeXfpdAA
 KMMorHBpeViI3chPXHpSrOQ+724S/n2yNvdq6OrRm+t2ojWPErX4GecWscIu8gORv9
 GT8sSFWNdofmzkxi0HKaQGjq6u2DQCa5v2xwktKM=
Authentication-Results: mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 1/3] net/ice: make link state configurable on device start
Date: Fri,  2 Oct 2026 21:43:36 +0200
Message-ID: <1a251ce8e790debb92e420f9b5732a4dbb332a72.1790970122.git.roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790970122.git.roma55592@yandex.ru>
References: <cover.1790970122.git.roma55592@yandex.ru>
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

The device start always brings the link up, so the port shows up
on the link partner as soon as the application starts it, even if
the application wants to enable it later, for example only after its
configuration is applied.

Introduce the device argument link_state_on_start, the counterpart
of link_state_on_close:
1. up: bring the link up (default, unchanged behavior)
2. down: bring (or keep) the link down; the application brings it up
   later with rte_eth_dev_set_link_up().

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
 doc/guides/nics/ice.rst                | 13 ++++++++++
 doc/guides/rel_notes/release_26_11.rst |  2 ++
 drivers/net/intel/ice/ice_ethdev.c     | 36 ++++++++++++++++++++++++--
 drivers/net/intel/ice/ice_ethdev.h     |  1 +
 4 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index ba598742c5..1a78760ff1 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -324,6 +324,19 @@ Runtime Configuration
   * ``up``: Leave the link in the up state.
   * ``initial``: Restore the link to the state it was in when the device started.
 
+- ``Link state on start`` (default ``up``)
+
+  The user can request that the link be kept down when the device is started,
+  so that the port does not show up on the link partner until the application
+  calls ``rte_eth_dev_set_link_up()``::
+
+    -a af:00.0,link_state_on_start=<state>
+
+  Supported values for the ``<state>`` parameter:
+
+  * ``up``: Bring the link up.
+  * ``down``: Bring (or keep) the link down.
+
 - ``Low Rx latency`` (default ``0``)
 
   vRAN workloads require low latency DPDK interface for the front haul
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index e8905f5533..a7fda78c5b 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -90,6 +90,8 @@ New Features
     enabling QinQ tag insertion and outer IPv4/UDP checksum offloads on those paths.
   * Added support for getting and setting link (802.3x) flow control.
   * Added support for Tx rate limiting per queue.
+  * Added ``link_state_on_start`` devarg to keep the link down
+    when the device is started.
 
 * **Updated Intel ixgbe driver.**
 
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 163304ba1e..51a82830af 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -45,6 +45,7 @@
 #define ICE_RL_BURST_SIZE_ARG     "rl_burst_size"
 #define ICE_SOURCE_PRUNE_ARG      "source-prune"
 #define ICE_LINK_STATE_ON_CLOSE   "link_state_on_close"
+#define ICE_LINK_STATE_ON_START   "link_state_on_start"
 
 #define ICE_CYCLECOUNTER_MASK  0xffffffffffffffffULL
 
@@ -64,6 +65,7 @@ static const char * const ice_valid_args[] = {
 	ICE_RL_BURST_SIZE_ARG,
 	ICE_SOURCE_PRUNE_ARG,
 	ICE_LINK_STATE_ON_CLOSE,
+	ICE_LINK_STATE_ON_START,
 	NULL
 };
 
@@ -2265,6 +2267,27 @@ parse_link_state_on_close(const char *key, const char *value, void *args)
 	return ret;
 }
 
+static int
+parse_link_state_on_start(const char *key, const char *value, void *args)
+{
+	bool *link_down = args;
+
+	if (value == NULL || link_down == NULL)
+		return -EINVAL;
+
+	if (strcmp(value, "down") == 0) {
+		*link_down = true;
+	} else if (strcmp(value, "up") == 0) {
+		*link_down = false;
+	} else {
+		PMD_DRV_LOG(WARNING, "%s: Invalid value \"%s\", "
+				"should be \"down\" or \"up\"", key, value);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int
 lookup_pps_type(const char *pps_name)
 {
@@ -2529,6 +2552,11 @@ static int ice_parse_devargs(struct rte_eth_dev *dev)
 
 	ret = rte_kvargs_process(kvlist, ICE_LINK_STATE_ON_CLOSE,
 				 &parse_link_state_on_close, &ad->devargs.link_state_on_close);
+	if (ret)
+		goto bail;
+
+	ret = rte_kvargs_process(kvlist, ICE_LINK_STATE_ON_START,
+				 &parse_link_state_on_start, &ad->devargs.link_down_on_start);
 
 bail:
 	rte_kvargs_free(kvlist);
@@ -4856,7 +4884,10 @@ ice_dev_start(struct rte_eth_dev *dev)
 
 	ice_get_init_link_status(dev);
 
-	ice_dev_set_link_up(dev);
+	if (pf->adapter->devargs.link_down_on_start)
+		ice_dev_set_link_down(dev);
+	else
+		ice_dev_set_link_up(dev);
 
 	/* Call get_link_info aq command to enable/disable LSE */
 	ice_link_update(dev, 0);
@@ -8118,7 +8149,8 @@ RTE_PMD_REGISTER_PARAM_STRING(net_ice,
 			      ICE_RL_BURST_SIZE_ARG "=<N>"
 			      ICE_SOURCE_PRUNE_ARG "=<0|1>"
 			      ICE_RX_LOW_LATENCY_ARG "=<0|1>"
-			      ICE_LINK_STATE_ON_CLOSE "=<down|up|initial>");
+			      ICE_LINK_STATE_ON_CLOSE "=<down|up|initial>"
+			      ICE_LINK_STATE_ON_START "=<down|up>");
 
 RTE_LOG_REGISTER_SUFFIX(ice_logtype_init, init, NOTICE);
 RTE_LOG_REGISTER_SUFFIX(ice_logtype_driver, driver, NOTICE);
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 8d5e17e2df..8794870c34 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -640,6 +640,7 @@ struct ice_devargs {
 	bool source_prune;
 	uint32_t rl_burst_size;
 	int link_state_on_close;
+	bool link_down_on_start;
 	int xtr_field_offs;
 	uint8_t xtr_flag_offs[PROTO_XTR_MAX];
 	/* Name of the field. */
-- 
2.47.3

