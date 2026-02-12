Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAFCECD6F5
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 00:08:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFA514027A;
	Thu, 12 Feb 2026 01:08:42 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 518BF40268
 for <dev@dpdk.org>; Thu, 12 Feb 2026 01:08:41 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-47ee937ecf2so15127005e9.0
 for <dev@dpdk.org>; Wed, 11 Feb 2026 16:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770854921;
 x=1771459721; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kphY8lZ/q8jTd5SXmfnD63j+ytFo6bc8Z7tFeq8gTSk=;
 b=kyPn40q2Rfd9ZtaB2dLCq8YWQJIBvdXl6+KP8cZkB4X9F81pJkijjo3Tv/nI/YGJxp
 QL/9nqToSnbKjwJ/vSETo9QGXFyksnoAXs51SERPykw1eEOZ1seBb8NL48knr1kpy5Nh
 K7XmMq74AE3UKWlcAtvkYMAie8kPf9tDC3LShsXk1cnqynifzRq9gqxwPBz1WzljEmqc
 Vmwn+Ypixhk7IfTx4EHED2U4qsakE1U1hFmPNk/kdTb1zaXnGtNXticpk6v2R4VrGuIy
 cFOBvmY1EG0Y7OLuShciE0tPL6yWHwIyp2wcuxRCsb3OXMPi0FIJa8ZZxESdbVpN0smO
 drKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770854921; x=1771459721;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kphY8lZ/q8jTd5SXmfnD63j+ytFo6bc8Z7tFeq8gTSk=;
 b=W1QF3Najjda/JrXt4rBwNfLr9LNAWJPoPsvsyeKlA2lj/qSZ31de4hKIThmbTBGW8C
 wnoKqfwKROud7sZsDstpWBnQOiAalKotTYJM6COimilsaOvMTchaNsxGngam6e88sV4L
 tOVJtevMq15f2CoEgC8zzxtPNuxd/fUOL2w4GnJS4ysaDOAsyZyQRFDfSKggCGtedS8p
 UgYV2Z8wo26XXmKqDSghCl0jzG192YGveMK83KLGKxI7T3p/tPbAMbcc3rn5stLYUogA
 Bo/piWBikVCKd5Ulb/CgNf6ULLnSpjVjxJ4uZP9e/HKVEmV+3RPMm4FlHWCJMXIULmFN
 N68g==
X-Gm-Message-State: AOJu0Yy64uogBTPiT34GF8hY41KTrQaqIkPw4lK9pXONLbOv/LaiFGly
 IvL5tO4V4B2Ln0eXqWiQ+Iv8dNq/ZzPqGW1KQMm6KqNa8vIUR1R6gLsvxRAxB6+Czy/8wEP+JU9
 FnRlf
X-Gm-Gg: AZuq6aLfV6PhWCZQU64X6JXVaD8j7g4w9t81ot3DnAmj2dkl36ah+RIMSoYk8x01RLI
 YgFosmqLYLmwsuuC3nRXRp75o7eeXgnrYlLlGUhkLlh2oIGKF/TOexDPV+cW7VUTiHNMDAjcoNR
 kISYC+YBKjAgvlFk4sQiH2i+gPxaAlZ8IpW+ZbSdsS20hgLJFJSP6fv06k6UP8xC/5LdXFVqmvz
 amTruhS/tuikCYIRx6ieTMEG/VtDz7FY5hPC89m69k1S3V80oYyf3ZO4qLGLj5yhvsrMjTFwhKz
 QWCSBBv12E95Ptvl4BDDlb7BpjkNu+EsC7fgxCE3k6/C+PLChaPGk/pQbPCPubJoQ1DUNGrS8ES
 FJM/EZVOfH/IWLA0MFxGIbWTmW0S8WqrzeMD3pbrvTJoP/wXuTZx3qt/fG/R2oL1WmQ6FYzjRMH
 QPk6P007/ZI7sDw6xkk26CLekyiQpt+y85kQdvXaigklB/aDeiisa3g595Ws3tvw==
X-Received: by 2002:a05:600c:1d99:b0:46f:a2ba:581f with SMTP id
 5b1f17b1804b1-4836603adfdmr8485425e9.16.1770854920199; 
 Wed, 11 Feb 2026 16:08:40 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835b958b6csm90427325e9.1.2026.02.11.16.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 16:08:38 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC] net/ring: add veth-like peer link state tracking
Date: Wed, 11 Feb 2026 16:08:33 -0800
Message-ID: <20260212000834.585423-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The ring PMD currently reports link-up unconditionally when a port is
started, making it impossible for applications to detect whether the
other end of a ring-based virtual link is ready.

Add an optional peer-awareness mechanism modelled on the Linux veth
driver's carrier semantics.

Introduce the experimental API rte_eth_ring_attach_peer()
which pairs two ring PMD ports so that each port's link state
reflects whether its peer is started and administratively up.
Unpaired ports retain the existing behaviour.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pmd_ring.c               | 191 +++++++++++++++++++++++
 doc/guides/nics/ring.rst               |  42 +++++
 doc/guides/rel_notes/release_26_03.rst |   8 +
 drivers/net/ring/rte_eth_ring.c        | 205 ++++++++++++++++++++++++-
 drivers/net/ring/rte_eth_ring.h        |  26 ++++
 5 files changed, 468 insertions(+), 4 deletions(-)

diff --git a/app/test/test_pmd_ring.c b/app/test/test_pmd_ring.c
index cb08dcf1d9..c0ebc4fe29 100644
--- a/app/test/test_pmd_ring.c
+++ b/app/test/test_pmd_ring.c
@@ -425,6 +425,196 @@ test_pmd_ring_pair_create_attach(void)
 	return TEST_SUCCESS;
 }
 
+static int
+test_pmd_ring_link_status(void)
+{
+	struct rte_eth_conf null_conf;
+	struct rte_eth_link link_d, link_e;
+	struct rte_ring *ring_de[1], *ring_ed[1];
+	int portd, porte;
+	int ret;
+
+	printf("Testing veth-like link state via rte_eth_ring_attach_peer\n");
+
+	memset(&null_conf, 0, sizeof(struct rte_eth_conf));
+
+	/*
+	 * Create two cross-connected ring ports:
+	 *   portd TX -> ring_de -> porte RX
+	 *   porte TX -> ring_ed -> portd RX
+	 * Then pair them so link state reflects peer status.
+	 */
+	ring_de[0] = rte_ring_create("VETH_DE", RING_SIZE, SOCKET0,
+				     RING_F_SP_ENQ | RING_F_SC_DEQ);
+	ring_ed[0] = rte_ring_create("VETH_ED", RING_SIZE, SOCKET0,
+				     RING_F_SP_ENQ | RING_F_SC_DEQ);
+	if (ring_de[0] == NULL || ring_ed[0] == NULL) {
+		printf("Error creating veth rings\n");
+		return TEST_FAILED;
+	}
+
+	/* portd: RX from ring_ed, TX into ring_de */
+	portd = rte_eth_from_rings("net_vethd", ring_ed, 1, ring_de, 1, SOCKET0);
+	/* porte: RX from ring_de, TX into ring_ed */
+	porte = rte_eth_from_rings("net_vethe", ring_de, 1, ring_ed, 1, SOCKET0);
+	if (portd < 0 || porte < 0) {
+		printf("Error creating veth ethdev ports\n");
+		return TEST_FAILED;
+	}
+
+	/* Pair the ports for veth-like carrier detection */
+	ret = rte_eth_ring_attach_peer(portd, porte);
+	if (ret != 0) {
+		printf("Error: rte_eth_ring_attach_peer failed\n");
+		return TEST_FAILED;
+	}
+
+	/* Configure and set up queues */
+	if ((rte_eth_dev_configure(portd, 1, 1, &null_conf) < 0) ||
+	    (rte_eth_dev_configure(porte, 1, 1, &null_conf) < 0)) {
+		printf("Configure failed for veth pair\n");
+		return TEST_FAILED;
+	}
+
+	if ((rte_eth_tx_queue_setup(portd, 0, RING_SIZE, SOCKET0, NULL) < 0) ||
+	    (rte_eth_tx_queue_setup(porte, 0, RING_SIZE, SOCKET0, NULL) < 0)) {
+		printf("TX queue setup failed for veth pair\n");
+		return TEST_FAILED;
+	}
+
+	if ((rte_eth_rx_queue_setup(portd, 0, RING_SIZE, SOCKET0, NULL, mp) < 0) ||
+	    (rte_eth_rx_queue_setup(porte, 0, RING_SIZE, SOCKET0, NULL, mp) < 0)) {
+		printf("RX queue setup failed for veth pair\n");
+		return TEST_FAILED;
+	}
+
+	/*
+	 * Test 1: neither side started – both links should be down.
+	 */
+	printf("  Test 1: both stopped -> both links down\n");
+	ret = rte_eth_link_get_nowait(portd, &link_d);
+	TEST_ASSERT(ret >= 0, "Link get failed: %s", rte_strerror(-ret));
+	ret = rte_eth_link_get_nowait(porte, &link_e);
+	TEST_ASSERT(ret >= 0, "Link get failed: %s", rte_strerror(-ret));
+	if (link_d.link_status != RTE_ETH_LINK_DOWN ||
+	    link_e.link_status != RTE_ETH_LINK_DOWN) {
+		printf("Error: expected both links DOWN before start\n");
+		return TEST_FAILED;
+	}
+
+	/*
+	 * Test 2: start only one side – that side should report link down
+	 *         because the peer is not started yet (veth semantics).
+	 */
+	printf("  Test 2: start portd only -> portd link down (no peer)\n");
+	if (rte_eth_dev_start(portd) < 0) {
+		printf("Error starting portd\n");
+		return TEST_FAILED;
+	}
+	ret = rte_eth_link_get_nowait(portd, &link_d);
+	TEST_ASSERT(ret >= 0, "Link get failed: %s", rte_strerror(-ret));
+	ret = rte_eth_link_get_nowait(porte, &link_e);
+	TEST_ASSERT(ret >= 0, "Link get failed: %s", rte_strerror(-ret));
+	if (link_d.link_status != RTE_ETH_LINK_DOWN) {
+		printf("Error: portd link should be DOWN (peer not started)\n");
+		return TEST_FAILED;
+	}
+	if (link_e.link_status != RTE_ETH_LINK_DOWN) {
+		printf("Error: porte link should be DOWN (not started)\n");
+		return TEST_FAILED;
+	}
+
+	/*
+	 * Test 3: start the second side – both should now have carrier.
+	 */
+	printf("  Test 3: start porte -> both links up\n");
+	if (rte_eth_dev_start(porte) < 0) {
+		printf("Error starting porte\n");
+		return TEST_FAILED;
+	}
+	ret = rte_eth_link_get_nowait(portd, &link_d);
+	TEST_ASSERT(ret >= 0, "Link get failed: %s", rte_strerror(-ret));
+	ret = rte_eth_link_get_nowait(porte, &link_e);
+	TEST_ASSERT(ret >= 0, "Link get failed: %s", rte_strerror(-ret));
+	if (link_d.link_status != RTE_ETH_LINK_UP) {
+		printf("Error: portd link should be UP\n");
+		return TEST_FAILED;
+	}
+	if (link_e.link_status != RTE_ETH_LINK_UP) {
+		printf("Error: porte link should be UP\n");
+		return TEST_FAILED;
+	}
+
+	/*
+	 * Test 4: stop one side – peer should lose carrier.
+	 */
+	printf("  Test 4: stop portd -> both links down\n");
+	ret = rte_eth_dev_stop(portd);
+	if (ret != 0) {
+		printf("Error stopping portd: %s\n", rte_strerror(-ret));
+		return TEST_FAILED;
+	}
+	ret = rte_eth_link_get_nowait(portd, &link_d);
+	TEST_ASSERT(ret >= 0, "Link get failed: %s", rte_strerror(-ret));
+	ret = rte_eth_link_get_nowait(porte, &link_e);
+	TEST_ASSERT(ret >= 0, "Link get failed: %s", rte_strerror(-ret));
+	if (link_d.link_status != RTE_ETH_LINK_DOWN) {
+		printf("Error: portd link should be DOWN after stop\n");
+		return TEST_FAILED;
+	}
+	if (link_e.link_status != RTE_ETH_LINK_DOWN) {
+		printf("Error: porte should lose carrier when peer stops\n");
+		return TEST_FAILED;
+	}
+
+	/*
+	 * Test 5: restart the stopped side – both should come back up
+	 *         (porte was still started).
+	 */
+	printf("  Test 5: restart portd -> both links up again\n");
+	if (rte_eth_dev_start(portd) < 0) {
+		printf("Error restarting portd\n");
+		return TEST_FAILED;
+	}
+	ret = rte_eth_link_get_nowait(portd, &link_d);
+	TEST_ASSERT(ret >= 0, "Link get failed: %s", rte_strerror(-ret));
+	ret = rte_eth_link_get_nowait(porte, &link_e);
+	TEST_ASSERT(ret >= 0, "Link get failed: %s", rte_strerror(-ret));
+	if (link_d.link_status != RTE_ETH_LINK_UP ||
+	    link_e.link_status != RTE_ETH_LINK_UP) {
+		printf("Error: both links should be UP after restart\n");
+		return TEST_FAILED;
+	}
+
+	/*
+	 * Test 6: admin set_link_down on one side – peer should lose carrier.
+	 */
+	printf("  Test 6: set_link_down portd -> both links down\n");
+	rte_eth_dev_set_link_down(portd);
+	ret = rte_eth_link_get_nowait(portd, &link_d);
+	TEST_ASSERT(ret >= 0, "Link get failed: %s", rte_strerror(-ret));
+	ret = rte_eth_link_get_nowait(porte, &link_e);
+	TEST_ASSERT(ret >= 0, "Link get failed: %s", rte_strerror(-ret));
+	if (link_d.link_status != RTE_ETH_LINK_DOWN) {
+		printf("Error: portd link should be DOWN after set_link_down\n");
+		return TEST_FAILED;
+	}
+	if (link_e.link_status != RTE_ETH_LINK_DOWN) {
+		printf("Error: porte should lose carrier on peer set_link_down\n");
+		return TEST_FAILED;
+	}
+
+	/* Clean up */
+	rte_eth_dev_stop(portd);
+	rte_eth_dev_stop(porte);
+	rte_vdev_uninit("net_ring_net_vethd");
+	rte_vdev_uninit("net_ring_net_vethe");
+	rte_ring_free(ring_de[0]);
+	rte_ring_free(ring_ed[0]);
+
+	return TEST_SUCCESS;
+}
+
 static void
 test_cleanup_resources(void)
 {
@@ -582,6 +772,7 @@ unit_test_suite test_pmd_ring_suite  = {
 		TEST_CASE(test_get_stats_for_port),
 		TEST_CASE(test_stats_reset_for_port),
 		TEST_CASE(test_pmd_ring_pair_create_attach),
+		TEST_CASE(test_pmd_ring_link_status),
 		TEST_CASE(test_command_line_ring_port),
 		TEST_CASES_END()
 	}
diff --git a/doc/guides/nics/ring.rst b/doc/guides/nics/ring.rst
index a6b2458a7f..caa461a2f2 100644
--- a/doc/guides/nics/ring.rst
+++ b/doc/guides/nics/ring.rst
@@ -104,6 +104,48 @@ the final two lines can be changed as follows:
 This type of configuration is useful in a pipeline model where inter-core communication
 using pseudo Ethernet devices is preferred over raw rings for API consistency.
 
+Peer Link State (veth-like Carrier Detection)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+By default, a ring-based port reports link-up as soon as it is started,
+regardless of the state of any other port.  For use cases that model a
+virtual Ethernet cable between two ports, this can be changed by pairing
+the ports with ``rte_eth_ring_attach_peer()``.
+
+Once two ports are paired, their link state follows the same rules as the
+Linux veth driver:
+
+* The link comes up only when **both** sides are started.
+* Stopping, closing, or administratively setting link-down on one side
+  causes the other side to report link-down as well.
+* When the stopped side is restarted, both sides regain carrier.
+
+Pairing is supported for any two ring-based ports, whether they were created
+with ``rte_eth_from_rings()`` or via the ``--vdev=net_ring`` EAL option.
+
+.. code-block:: c
+
+   struct rte_ring *ring_ab, *ring_ba;
+
+   ring_ab = rte_ring_create("AB", 1024, 0, RING_F_SP_ENQ | RING_F_SC_DEQ);
+   ring_ba = rte_ring_create("BA", 1024, 0, RING_F_SP_ENQ | RING_F_SC_DEQ);
+
+   /* Port A: TX into ring_ab, RX from ring_ba */
+   int port_a = rte_eth_from_rings("veth_a", &ring_ba, 1, &ring_ab, 1, 0);
+   /* Port B: TX into ring_ba, RX from ring_ab */
+   int port_b = rte_eth_from_rings("veth_b", &ring_ab, 1, &ring_ba, 1, 0);
+
+   /* Enable veth-like link state tracking */
+   rte_eth_ring_attach_peer(port_a, port_b);
+
+   /* At this point both links are down.
+    * Starting port_a alone still shows link-down (peer is not ready).
+    * Starting port_b as well brings both links up.
+    */
+
+Unpaired ports (the default) are unaffected and retain the original
+behaviour where link-up is reported immediately on start.
+
 Enqueuing and dequeuing items from an ``rte_ring``
 using the ring-based PMD may be slower than using the native ring API.
 DPDK Ethernet drivers use function pointers
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 5c2a4bb32e..33fd354be8 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -82,6 +82,14 @@ New Features
   * NEA5, NIA5, NCA5: AES 256 confidentiality, integrity and AEAD modes.
   * NEA6, NIA6, NCA6: ZUC 256 confidentiality, integrity and AEAD modes.
 
+* **Updated ring-based PMD with veth-like link state.**
+
+  Added peer link state tracking to the ring-based PMD (``net_ring``).
+  Two ring PMD ports can now be paired via the new experimental
+  ``rte_eth_ring_attach_peer()`` API so that each port's link status
+  reflects whether its peer is started, mirroring the carrier semantics
+  of the Linux veth driver.  Unpaired ports retain the existing behaviour.
+
 
 Removed Items
 -------------
diff --git a/drivers/net/ring/rte_eth_ring.c b/drivers/net/ring/rte_eth_ring.c
index b639544eab..d7a8ee8796 100644
--- a/drivers/net/ring/rte_eth_ring.c
+++ b/drivers/net/ring/rte_eth_ring.c
@@ -59,6 +59,9 @@ struct pmd_internals {
 
 	struct rte_ether_addr address;
 	enum dev_action action;
+
+	uint16_t peer_port_id;	/**< port id of the peer, or RTE_MAX_ETHPORTS */
+	uint8_t link_admin_down; /**< true when set_link_down has been called */
 };
 
 static struct rte_eth_link pmd_link = {
@@ -111,13 +114,41 @@ eth_dev_configure(struct rte_eth_dev *dev __rte_unused) { return 0; }
 static int
 eth_dev_start(struct rte_eth_dev *dev)
 {
-	dev->data->dev_link.link_status = RTE_ETH_LINK_UP;
+	struct pmd_internals *internals = dev->data->dev_private;
+
+	internals->link_admin_down = 0;
+
+	if (internals->peer_port_id < RTE_MAX_ETHPORTS) {
+		struct rte_eth_dev *peer = &rte_eth_devices[internals->peer_port_id];
+		struct pmd_internals *peer_internals = peer->data->dev_private;
+
+		/*
+		 * Veth-like carrier: link comes up only when the peer
+		 * is also started and not administratively down.
+		 * When we start, we also give the peer carrier if it
+		 * was already started.
+		 */
+		if (peer_internals != NULL &&
+		    peer_internals->peer_port_id == dev->data->port_id &&
+		    peer->data->dev_started &&
+		    !peer_internals->link_admin_down) {
+			dev->data->dev_link.link_status = RTE_ETH_LINK_UP;
+			peer->data->dev_link.link_status = RTE_ETH_LINK_UP;
+		} else {
+			dev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
+		}
+	} else {
+		/* Unpaired port: link follows admin state directly */
+		dev->data->dev_link.link_status = RTE_ETH_LINK_UP;
+	}
+
 	return 0;
 }
 
 static int
 eth_dev_stop(struct rte_eth_dev *dev)
 {
+	struct pmd_internals *internals = dev->data->dev_private;
 	uint16_t i;
 
 	dev->data->dev_started = 0;
@@ -127,14 +158,30 @@ eth_dev_stop(struct rte_eth_dev *dev)
 		dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
 	for (i = 0; i < dev->data->nb_tx_queues; i++)
 		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
+
+	/*
+	 * When this side stops, the peer loses carrier,
+	 * mirroring Linux veth behavior.
+	 */
+	if (internals->peer_port_id < RTE_MAX_ETHPORTS) {
+		struct rte_eth_dev *peer = &rte_eth_devices[internals->peer_port_id];
+		struct pmd_internals *peer_internals = peer->data->dev_private;
+
+		if (peer_internals != NULL &&
+		    peer_internals->peer_port_id == dev->data->port_id)
+			peer->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
+	}
+
 	return 0;
 }
 
 static int
 eth_dev_set_link_down(struct rte_eth_dev *dev)
 {
+	struct pmd_internals *internals = dev->data->dev_private;
 	uint16_t i;
 
+	internals->link_admin_down = 1;
 	dev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++)
@@ -142,13 +189,47 @@ eth_dev_set_link_down(struct rte_eth_dev *dev)
 	for (i = 0; i < dev->data->nb_tx_queues; i++)
 		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
 
+	/* Peer also loses carrier when this side is forced down */
+	if (internals->peer_port_id < RTE_MAX_ETHPORTS) {
+		struct rte_eth_dev *peer = &rte_eth_devices[internals->peer_port_id];
+		struct pmd_internals *peer_internals = peer->data->dev_private;
+
+		if (peer_internals != NULL &&
+		    peer_internals->peer_port_id == dev->data->port_id)
+			peer->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
+	}
+
 	return 0;
 }
 
 static int
 eth_dev_set_link_up(struct rte_eth_dev *dev)
 {
-	dev->data->dev_link.link_status = RTE_ETH_LINK_UP;
+	struct pmd_internals *internals = dev->data->dev_private;
+
+	internals->link_admin_down = 0;
+
+	if (internals->peer_port_id < RTE_MAX_ETHPORTS) {
+		struct rte_eth_dev *peer = &rte_eth_devices[internals->peer_port_id];
+		struct pmd_internals *peer_internals = peer->data->dev_private;
+
+		/*
+		 * With a peer, link can only come up if the peer is also
+		 * started and not administratively down.
+		 */
+		if (peer_internals != NULL &&
+		    peer_internals->peer_port_id == dev->data->port_id &&
+		    peer->data->dev_started &&
+		    !peer_internals->link_admin_down) {
+			dev->data->dev_link.link_status = RTE_ETH_LINK_UP;
+			peer->data->dev_link.link_status = RTE_ETH_LINK_UP;
+		} else {
+			dev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
+		}
+	} else {
+		dev->data->dev_link.link_status = RTE_ETH_LINK_UP;
+	}
+
 	return 0;
 }
 
@@ -277,8 +358,38 @@ eth_allmulticast_disable(struct rte_eth_dev *dev __rte_unused)
 }
 
 static int
-eth_link_update(struct rte_eth_dev *dev __rte_unused,
-		int wait_to_complete __rte_unused) { return 0; }
+eth_link_update(struct rte_eth_dev *dev,
+		int wait_to_complete __rte_unused)
+{
+	struct pmd_internals *internals = dev->data->dev_private;
+	struct rte_eth_link link;
+
+	link = pmd_link;
+
+	if (!dev->data->dev_started || internals->link_admin_down) {
+		link.link_status = RTE_ETH_LINK_DOWN;
+	} else if (internals->peer_port_id < RTE_MAX_ETHPORTS) {
+		/*
+		 * Paired port: carrier depends on peer being started
+		 * and not administratively down, similar to Linux veth.
+		 */
+		struct rte_eth_dev *peer = &rte_eth_devices[internals->peer_port_id];
+		struct pmd_internals *peer_internals = peer->data->dev_private;
+
+		if (peer_internals != NULL &&
+		    peer_internals->peer_port_id == dev->data->port_id &&
+		    peer->data->dev_started &&
+		    !peer_internals->link_admin_down)
+			link.link_status = RTE_ETH_LINK_UP;
+		else
+			link.link_status = RTE_ETH_LINK_DOWN;
+	} else {
+		/* Unpaired port: link follows admin state */
+		link.link_status = dev->data->dev_link.link_status;
+	}
+
+	return rte_eth_linkstatus_set(dev, &link);
+}
 
 static int
 eth_dev_close(struct rte_eth_dev *dev)
@@ -294,6 +405,19 @@ eth_dev_close(struct rte_eth_dev *dev)
 	ret = eth_dev_stop(dev);
 
 	internals = dev->data->dev_private;
+
+	/* Unlink peer so it no longer references this port */
+	if (internals->peer_port_id < RTE_MAX_ETHPORTS) {
+		struct rte_eth_dev *peer = &rte_eth_devices[internals->peer_port_id];
+		struct pmd_internals *peer_internals = peer->data->dev_private;
+
+		if (peer_internals != NULL &&
+		    peer_internals->peer_port_id == dev->data->port_id)
+			peer_internals->peer_port_id = RTE_MAX_ETHPORTS;
+
+		internals->peer_port_id = RTE_MAX_ETHPORTS;
+	}
+
 	if (internals->action == DEV_CREATE) {
 		/*
 		 * it is only necessary to delete the rings in rx_queues because
@@ -420,6 +544,7 @@ do_eth_dev_ring_create(const char *name,
 	internals->action = action;
 	internals->max_rx_queues = nb_rx_queues;
 	internals->max_tx_queues = nb_tx_queues;
+	internals->peer_port_id = RTE_MAX_ETHPORTS;
 	for (i = 0; i < nb_rx_queues; i++) {
 		internals->rx_ring_queues[i].rng = rx_queues[i];
 		internals->rx_ring_queues[i].in_port = -1;
@@ -527,6 +652,49 @@ rte_eth_from_ring(struct rte_ring *r)
 			r->memzone ? r->memzone->socket_id : SOCKET_ID_ANY);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_ring_attach_peer, 26.03)
+int
+rte_eth_ring_attach_peer(uint16_t port_id_a, uint16_t port_id_b)
+{
+	struct rte_eth_dev *dev_a, *dev_b;
+	struct pmd_internals *internals_a, *internals_b;
+
+	if (port_id_a >= RTE_MAX_ETHPORTS || port_id_b >= RTE_MAX_ETHPORTS ||
+	    port_id_a == port_id_b) {
+		rte_errno = EINVAL;
+		return -1;
+	}
+
+	dev_a = &rte_eth_devices[port_id_a];
+	dev_b = &rte_eth_devices[port_id_b];
+
+	/* Verify both are ring PMD ports */
+	if (dev_a->dev_ops != &ops || dev_b->dev_ops != &ops) {
+		rte_errno = EINVAL;
+		return -1;
+	}
+
+	internals_a = dev_a->data->dev_private;
+	internals_b = dev_b->data->dev_private;
+
+	if (internals_a == NULL || internals_b == NULL) {
+		rte_errno = EINVAL;
+		return -1;
+	}
+
+	/* Neither port may already have a peer */
+	if (internals_a->peer_port_id < RTE_MAX_ETHPORTS ||
+	    internals_b->peer_port_id < RTE_MAX_ETHPORTS) {
+		rte_errno = EBUSY;
+		return -1;
+	}
+
+	internals_a->peer_port_id = port_id_b;
+	internals_b->peer_port_id = port_id_a;
+
+	return 0;
+}
+
 static int
 eth_dev_ring_create(const char *name,
 		struct rte_vdev_device *vdev,
@@ -564,6 +732,35 @@ eth_dev_ring_create(const char *name,
 		numa_node, action, eth_dev) < 0)
 		return -1;
 
+	/*
+	 * For ATTACH, find the CREATE peer that shares our rings and
+	 * establish a bidirectional peer link. This allows veth-like
+	 * carrier detection: each side's link state reflects whether
+	 * the other side is started.
+	 */
+	if (action == DEV_ATTACH) {
+		struct pmd_internals *internals = (*eth_dev)->data->dev_private;
+		uint16_t pid;
+
+		RTE_ETH_FOREACH_DEV(pid) {
+			struct rte_eth_dev *candidate = &rte_eth_devices[pid];
+			struct pmd_internals *ci;
+
+			if (candidate == *eth_dev)
+				continue;
+			ci = candidate->data->dev_private;
+			if (ci == NULL || ci->action != DEV_CREATE)
+				continue;
+
+			/* Check if the candidate shares our rings */
+			if (ci->rx_ring_queues[0].rng == internals->rx_ring_queues[0].rng) {
+				internals->peer_port_id = pid;
+				ci->peer_port_id = (*eth_dev)->data->port_id;
+				break;
+			}
+		}
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/ring/rte_eth_ring.h b/drivers/net/ring/rte_eth_ring.h
index 98292c7b33..5bb619198a 100644
--- a/drivers/net/ring/rte_eth_ring.h
+++ b/drivers/net/ring/rte_eth_ring.h
@@ -5,6 +5,7 @@
 #ifndef _RTE_ETH_RING_H_
 #define _RTE_ETH_RING_H_
 
+#include <rte_compat.h>
 #include <rte_ring.h>
 
 #ifdef __cplusplus
@@ -50,6 +51,31 @@ int rte_eth_from_rings(const char *name,
  */
 int rte_eth_from_ring(struct rte_ring *r);
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Attach two ring-backed ethdev ports as peers.
+ *
+ * After this call the link state of each port reflects whether its
+ * peer is started, similar to how carrier is handled on Linux veth
+ * devices.  Stopping, closing, or setting link-down on one side will
+ * cause the other side to report link-down as well.
+ *
+ * Only ring-backed ports (created by rte_eth_from_rings or the
+ * net_ring vdev driver) can be paired.  A port that already has a
+ * peer must be un-paired first (by closing or removing it).
+ *
+ * @param port_id_a
+ *    port id of the first ring-backed ethdev
+ * @param port_id_b
+ *    port id of the second ring-backed ethdev
+ * @return
+ *    0 on success, -1 on error (rte_errno is set).
+ */
+__rte_experimental
+int rte_eth_ring_attach_peer(uint16_t port_id_a, uint16_t port_id_b);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.51.0

