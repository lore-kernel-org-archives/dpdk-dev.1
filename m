Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69247CDE000
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 23:07:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 019F640655;
	Thu, 25 Jun 2026 01:07:23 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id 9A3F24025E
 for <dev@dpdk.org>; Thu, 25 Jun 2026 01:07:21 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.stl.internal (Postfix) with ESMTP id D1FE51D000AE;
 Wed, 24 Jun 2026 19:07:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Wed, 24 Jun 2026 19:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1782342440; x=
 1782428840; bh=vu/6ghP6bigRR4J/8LEh2Ey1abXB3uSr/DuOha8PPXw=; b=o
 tTvDfW0WwU4Y96yEQLT88HngvHqnGoH/0ikEuL8yWyUEyND7w8ZGJ2JauhgXuyib
 bLCCTEw1GI7iy+WVom+vonD9VS7DESyTkctt9C0BSPUUWRUowkZomVAEbC09rhQ9
 8ZlxfKD9384XqPkGkiotXLG8RGLa7JUQXwwjCRDrljUdejNT3+i/imgl5Cm/9Td4
 FiSbCSe6a6FbngnfjNyO9+SSlqE+1zumW0X3Si1cBjAGb8MEDtEjc+B6ACACoNRg
 3+oRZQ46PLHyYvnI8ALvhQz2vPUTFaosMIZ9NCReXi8G0hPJaGl0ze147lPHCl8G
 q5L//1HN6CO/7vxaHXpQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1782342440; x=1782428840; bh=v
 u/6ghP6bigRR4J/8LEh2Ey1abXB3uSr/DuOha8PPXw=; b=eZHV+urIC5XEJpMo7
 8JYzG9m2BEKYoHQB16zsMnfd9EQCEOiRDeu557trxyezKEnxobSn/b8NAfPdKkBy
 I7t0fuDsvaaSzXDfAnAfjIZKxAbTc+Sx6cmel6D9/GhXZm2URS7NEj4EVjaloNWg
 Oy8jx5bQ4YS1kmGjcjVSwqjAlXn67/AGspW8kL1aGXMAHyhwjp+diI8McGC5WAvl
 2vW+1VL5JaydeYrRrEmx/fKf71YB5zCE8SlXsno+8J3DlBRaUhUECzMMDD7gfUHk
 s1e7RYkK5FVzEe9iBh+bwqtAuh7vICLq3g/ej/uyHwewrDwTHxiXw1HyBMr4U/K/
 UZE/A==
X-ME-Sender: <xms:KGM8arkuzQrwojNKEcbz5pGhMft4l2hDkxdu0LFLLIfFxGwEbI1TsQ>
 <xme:KGM8anx033UgEPVOtioMEYH919CHjfA0AIpNZ0MEth_C-UD6apC1pbZEC1yNummEh
 9sBkbzM4csxVyuWr_ReKtbfRSDxPb5CnxFWtrQYz9azRlmJiCHL>
X-ME-Received: <xmr:KGM8atNIVTOLOTEa7H2D6aBTlRtJW4kWm50-Pf4t5YVeKq0LAN3xjkMhYhItepuDlv8Fj24l2NxMAwyNQgSyoDdKvlqEjh0>
X-ME-Proxy-Cause: dmFkZTEhtg9UVCRFiDadGp4ugRj4DMu/xn9UOxrUO+lpLbS9jBVyxa0tFeOMNFYZb/pm5M
 qRv15y6qVC5FBFMWXcYNP9gEDFTf32AP3O+0GZLevrE8FDXBBAwvLCfxRLAl6uDIbw5FHn
 tAqiqmwUZ1S3nx45aKt8ia2Ulu084gmbEUjFfzPgawFkhtvhxluih6m5wHQuSKakFu/+K1
 vNHwiL1a2YfL04jGKDjrKz4bGViIvt3kiWX3/qiMWsOyJDJWP/Cz3WQVuXeYckI1hNxvPK
 qfCNuEUusEApGWFrbQcvNiIW/Yk4vB3q2FjiQY4Z3fh308e63Y0m0KAL8xXGAwN6c2wTXU
 RmnM1hR10M2pJ+AKqMmRUPlOcBS+qB4ekFHuV1ik4pVULs7TaG/RvHCnQMYRmwcIITwXy1
 EG7C0HjSg1dRZjVJcSBLXJsv4JgJngkVFOu1vpM0qyPZOLM+ASqjZ2bXHSETDbeiKgOBdl
 eY5OcHmSNt+w6PKadDfKesIN8IKRjysfR+ie+xxClTpCWpLwdiaTUoMqWb6CRM0d9itEk2
 D+AnRkN+ntWU+u5OVDVnFSZ0dzKe9shXqHBK7KWtexrtQGti9v0WvhJI+B9vtHO5jgPMTQ
 wHfsUVQpN342SYUm/J8S/yMH3X6A4xbF1qdwYlKEkhq7POG1ObvicmEIEEOw
X-ME-Proxy: <xmx:KGM8ajrVso4dGXSk4LVV_jY242GQ6AbVJy4QwU1WOCGFSwYwL3656A>
 <xmx:KGM8amFA8pOv1iywOMDJo3Aia_tXnEsA7Jw_APNwmhW5seiV0q61lw>
 <xmx:KGM8agr_Vf-1VW-M_aTnFlwu8XQ51NOCRyuB-qxNghww0xGM5J91xA>
 <xmx:KGM8anZibirZrwYHYAxQKwD7TszMO5ULBunOFOvAUtB5-jXo8U-b4Q>
 <xmx:KGM8auRMoJGqB_FSsVfuX6UWqpFdNeCUkOEI1as8YHeu8hX_ca4MhFHX>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 19:07:19 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Song Jiale <songx.jiale@intel.com>, Aman Singh <aman.deep.singh@intel.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>,
 Gregory Etelson <getelson@nvidia.com>
Subject: [PATCH 2/2] app/testpmd: fix runtime config of Rx split
Date: Thu, 25 Jun 2026 01:03:23 +0200
Message-ID: <20260624230656.2172633-3-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624230656.2172633-1-thomas@monjalon.net>
References: <20260624230656.2172633-1-thomas@monjalon.net>
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

When adding selective Rx, it was assumed that the queue configuration
was set when starting testpmd via the command line options.
But it should be possible to configure mempools with --mbuf-size,
start Rx, stop, and configure later a split in the testpmd CLI.
In such a scenario, a regression prevented to start
with more than 1 mempool without configuring a split:

	Configuring Port 0 (socket 0)
	ETHDEV: No Rx segmentation offload configured
	Fail to configure port 0 rx queues

It is fixed by considering having multiple mempools
is not a condition to trigger Rx split.

A test is added in DTS to validate this use case.

Bugzilla ID: 1956
Fixes: 0be0ad196b52 ("app/testpmd: support selective Rx")

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 app/test-pmd/testpmd.c          |  3 +--
 dts/tests/TestSuite_rx_split.py | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index fcd8a90967..b241a7025b 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -2750,8 +2750,7 @@ rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 	uint32_t prev_hdrs = 0;
 	int ret;
 
-	if (multi_rx_mempool == 0 &&
-	    (rx_pkt_nb_segs > 1 || mbuf_data_size_n > 1)) {
+	if (multi_rx_mempool == 0 && rx_pkt_nb_segs > 1) {
 		unsigned int nb_segs = RTE_MAX(rx_pkt_nb_segs, (uint8_t)mbuf_data_size_n);
 
 		/* multi-segment configuration */
diff --git a/dts/tests/TestSuite_rx_split.py b/dts/tests/TestSuite_rx_split.py
index 633ba0bf1e..5117a569e2 100644
--- a/dts/tests/TestSuite_rx_split.py
+++ b/dts/tests/TestSuite_rx_split.py
@@ -210,6 +210,30 @@ def expected(packet: bytes) -> bytes:
 
             self._start_and_verify(testpmd, expected)
 
+    @func_test
+    def selective_rx_runtime_config(self) -> None:
+        """Configure selective Rx at runtime after initial startup.
+
+        Steps:
+            Start testpmd with two mbuf-size pools but no rxpkts/rxhdrs.
+            Stop ports, configure buffer split offload, set rxpkts, restart ports.
+            Send an Ether/IP/payload packet.
+
+        Verify:
+            Initial startup succeeds without error.
+            Received packet has Ether + IP headers only after runtime config.
+            Port stats show expected rx_packets and rx_bytes.
+        """
+        with self._create_testpmd(
+            mbuf_size=[512, 0],
+        ) as testpmd:
+            self._start_and_verify(testpmd)
+            testpmd.stop()
+            testpmd.stop_all_ports()
+            testpmd.send_command("port config 0 rx_offload buffer_split on")
+            testpmd.send_command(f"set rxpkts {ETHER_IP_HDR_LEN},0")
+            self._start_and_verify(testpmd, ETHER_IP_HDR_LEN)
+
     @func_test
     def selective_rx_no_offload(self) -> None:
         """Configure selective Rx with buffer split disabled.
-- 
2.54.0

