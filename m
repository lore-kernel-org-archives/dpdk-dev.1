Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9484CDE002
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 23:07:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96C2940613;
	Thu, 25 Jun 2026 01:07:16 +0200 (CEST)
Received: from fhigh-b8-smtp.messagingengine.com
 (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mails.dpdk.org (Postfix) with ESMTP id AA86440613
 for <dev@dpdk.org>; Thu, 25 Jun 2026 01:07:14 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id F349E7A0097;
 Wed, 24 Jun 2026 19:07:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Wed, 24 Jun 2026 19:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1782342433; x=
 1782428833; bh=F0hNrS+7zILGRSMGEfPp5cwMrZ/VLTGLadDZFXwxk20=; b=i
 d5tAGvoNE/LzUrNChLsuHxeQyprRgzZr7R6xgbvdhRNSAFBbnqnxN8BxZQpj+JcD
 Mf/CQA9CfU/+bGzmdtwCsbd9UfVhooCbtRQ9OIducCaoNCD3o/emrzSV4u1eQbCu
 xbJsEecVFvkf5oKKxDKFl0wajW9VZ7opT1MUbx/fRvLl8Gk0lom9p4YXRynEYgSh
 1SSF69gOaBfVZE7IijGomkjQEsNawA9lLvfEi695JF9+gYtaYQh1fXvtUpN8hQB9
 /7TSc2tdZGNtiy0glp672ooOdXzGpOzw2jlRJpAd5yGyozP2JHbkPmEftCH/dHwb
 px3NTcAhKxCglt/zlWjug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1782342433; x=1782428833; bh=F
 0hNrS+7zILGRSMGEfPp5cwMrZ/VLTGLadDZFXwxk20=; b=BcvQeK7mICxV/Yn89
 l0+JQti4aAM0alRupvQ3hrAWCA7ZwpEMn6swS0BGxcE3hwYFuz97QLMQ/4IkMnOu
 6jNxkNBTDKEALBf6W7QHiOMbcCVWQf7arp91r0+Pk/195b9rqwM0AGqsfq/cbPZm
 BeSHmyom9yCXvOZPtU5cmKpEDu19L9Fh+qiJ6XId+SNTMzBxMEB5xVlPbNCWt8+v
 7G7hebe6Os4bJuYKQOynIuj3ij+GP1TzLFc4CnxtW9tkhEOmap/wqsHNQNGNisXB
 aoIM3kFcfx5Tr0yM2h1NsH4IziL2KFdUowH3hSNmIDMaWh1qI2V746HYcmWuDR7G
 eoCKw==
X-ME-Sender: <xms:IWM8aqkAJu_gVI-qRZmNWc03a8LWDMzLLnBWbJia-hD-q7Q9ZGQHRQ>
 <xme:IWM8ah-fIyzM76p_xOF4hgnudjP4bIR6ewajbu8Hj6docyop6TFA6HZFOwAIc5X52
 BZGj9kxZWMZpnOLHfLPuZCkv28lFvCpGmnOWrsufURyQIUWJPXU-g>
X-ME-Received: <xmr:IWM8agmkh8yYzyfOlbdUs45XPqD8ZuUQ8XJ5gHyr6ACZWwVlz5w5j_PsA-bHttKfqpfYd2INM9QBe8MbLK5ihAeMdwcO05g>
X-ME-Proxy-Cause: dmFkZTEhtg9UVCRFiDadGp4ugRj4DMu/xn9UOxrUO+lpLbS9jBVyxa0tFeOMNFYZb/pm5M
 qRv15y6qVC5FBFMWXcYNP9gEDFTf32AP3O+0GZLevrE8FDXBBAwvLCfxRLAl6uDIbw5FHn
 tAqiqmwUZ1S3nx45aKt8ia2Ulu084gmbEUjFfzPgawFkhtvhxluih6m5wHQuSKakFu/+K1
 vNHwiL1a2YfL04jGKDjrKz4bGViIvt3kiWX3/qiMWsOyJDJWP/Cz3WQVuXeYckI1hNxvPK
 qfCNuEUusEApGWFrbQcvNiIW/Yk4vB3q2FjiQY4Z3fh308e63Y0m0KAL8xXGAwN6c2wTk1
 4bfE30tlhfY5Kz27D6E3TEtoj0FU3vePpxcDQjKGv6WcxIbmo4q/2HohlKlSqNPRK6CkO5
 Sz0kDzBSca83oNW4DoV5txGimNEVBWRs4V6KqFvsUiNf30b/VoqYdW3L3gERmIPKom54dB
 jhxwohOXuvfd4ON1mopV4JOPjYcSgDqBuDpF69TnkOjtho8BEQmjApclAfqoD2vgdYUkFO
 H8tJ1lmLrSfi4X1RCQWuJdTWn8JAXfBNI52qLyLUgitt5qjU+xz/QxSiSV/tHDAKDRK8Fx
 hk6tR1GU9H9UPmkRD0+9wdEUGFcu1AoeQzg68nXfviSB2xNTTwF5JeJwi/yQ
X-ME-Proxy: <xmx:IWM8am2um1xCIDwbvIBvrydP7ix9QyerffolTwdK-FblDEI3sWbicg>
 <xmx:IWM8ajpAZQ2po1n4YB9LvQVYIqXXo-ktXZAZHWgpvOMDnxNsygAJ9w>
 <xmx:IWM8areCaAZtWJhHUjNozGZrcGYuMu2zfDHUkGkVsVku3UmRAbTrMQ>
 <xmx:IWM8aqpH5X9Nq0lR7TtrSpod0LzuUx4xt3RRpay05J-D4zWJ1VWmhA>
 <xmx:IWM8aoCGqdZsA09qAwRXfK5QyyR8mCDRF6uDdRUbmdSuHIkB0d8uEbfi>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 19:07:12 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Song Jiale <songx.jiale@intel.com>, Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>
Subject: [PATCH 1/2] dts: simplify packet check in Rx split
Date: Thu, 25 Jun 2026 01:03:22 +0200
Message-ID: <20260624230656.2172633-2-thomas@monjalon.net>
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

Add shortcuts to the function verifying a received packet
match its expected content.
Previous version worked with a callback function defining
the expected received packet based on the sent packet.
This new version allows to pass a header length,
so only the header is expected, or directly the expected bytes.
If the parameter is None, the full packet is expected.
This is shorter than defining a callback in many cases.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 dts/tests/TestSuite_rx_split.py | 35 +++++++++++++++++----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/dts/tests/TestSuite_rx_split.py b/dts/tests/TestSuite_rx_split.py
index 5f5a2e6187..633ba0bf1e 100644
--- a/dts/tests/TestSuite_rx_split.py
+++ b/dts/tests/TestSuite_rx_split.py
@@ -56,11 +56,24 @@ def _build_packet(self) -> Packet:
         packet = Ether() / IP() / Raw(load=PAYLOAD)
         return adjust_addresses([packet])[0]
 
-    def _start_and_verify(self, testpmd: TestPmd, expected: Callable[[bytes], bytes]) -> None:
+    def _start_and_verify(
+        self,
+        testpmd: TestPmd,
+        expected: Callable[[bytes], bytes] | bytes | int | None = None,
+    ) -> None:
         """Start testpmd, send the default packet, and verify received bytes."""
         testpmd.start()
         packet = self._build_packet()
-        self._send_and_verify(testpmd, packet, expected(bytes(packet)))
+        raw = bytes(packet)
+        if expected is None:
+            raw_expected = raw
+        elif isinstance(expected, int):
+            raw_expected = raw[:expected]
+        elif isinstance(expected, bytes):
+            raw_expected = expected
+        else:
+            raw_expected = expected(raw)
+        self._send_and_verify(testpmd, packet, raw_expected)
 
     def _send_and_verify(self, testpmd: TestPmd, tg_packet: Packet, expected: bytes) -> None:
         """Clear stats, send a packet, and verify received content and stats.
@@ -128,11 +141,7 @@ def selective_rx_headers(self) -> None:
             rx_segments_length=[ETHER_IP_HDR_LEN, 0],
             mbuf_size=[256, 0],
         ) as testpmd:
-
-            def expected(packet: bytes) -> bytes:
-                return packet[:ETHER_IP_HDR_LEN]
-
-            self._start_and_verify(testpmd, expected)
+            self._start_and_verify(testpmd, ETHER_IP_HDR_LEN)
 
     @func_test
     def selective_rx_headers_discard_length(self) -> None:
@@ -151,11 +160,7 @@ def selective_rx_headers_discard_length(self) -> None:
             rx_segments_length=[ETHER_IP_HDR_LEN, len(PAYLOAD)],
             mbuf_size=[256, 0],
         ) as testpmd:
-
-            def expected(packet: bytes) -> bytes:
-                return packet[:ETHER_IP_HDR_LEN]
-
-            self._start_and_verify(testpmd, expected)
+            self._start_and_verify(testpmd, ETHER_IP_HDR_LEN)
 
     @func_test
     def selective_rx_payload_only(self) -> None:
@@ -173,11 +178,7 @@ def selective_rx_payload_only(self) -> None:
             rx_segments_length=[ETHER_IP_HDR_LEN, len(PAYLOAD)],
             mbuf_size=[0, 512],
         ) as testpmd:
-
-            def expected(_: bytes) -> bytes:
-                return PAYLOAD
-
-            self._start_and_verify(testpmd, expected)
+            self._start_and_verify(testpmd, PAYLOAD)
 
     @func_test
     def selective_rx_two_segments(self) -> None:
-- 
2.54.0

