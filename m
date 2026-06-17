Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01B7CD98F2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 15:58:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C94940431;
	Wed, 17 Jun 2026 17:58:00 +0200 (CEST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by mails.dpdk.org (Postfix) with ESMTP id D5EBD40268
 for <dev@dpdk.org>; Wed, 17 Jun 2026 17:57:56 +0200 (CEST)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-915ab38ac14so772652485a.0
 for <dev@dpdk.org>; Wed, 17 Jun 2026 08:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1781711876; x=1782316676; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=czbAxecncIuQeutQrcWmLi04wyRbvwn0iUOr5ZyRqFM=;
 b=O4sTlOMm3r+Y3sZe/XAB8X2U35aUv9KmWIY4tVib2hzzFYQYASrnYnBOx0yM8F30FD
 DNJhBN9WLxTA3to3HdoNb5esBmEAQi+plXvRAVOIcRpXwAOhVRZW5Ic1aaQkmNruLITY
 RMXD2QoSKeutaXWETV9oW4PecTGd8Sr1C9mUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781711876; x=1782316676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=czbAxecncIuQeutQrcWmLi04wyRbvwn0iUOr5ZyRqFM=;
 b=mLUpmDtsGJSq0jhZQH+GgH62LXPw+oRRUiZTBKcqyoM718Bs9g+iCZ2k3Z4OjnV5B6
 ZTS4Rl+gYh1GnqMrcIG8JvVopBGRLGlLpu4Fzb8UJOUEXRC9pcLJdiI9fq4s+kxVC2Wf
 YTu0vUyt+qNW1sI9vEDStb2yby8f6zROQSGADTNb/0DvDfwFofNqbUmvDfUknRigU9wb
 /+25LVLUISkVy4Pbnw9lPrIGbWcmB198Pw948ad9sBPBXm5KuzaDqWkpL1Hu5ZxRcQLC
 YpkfhVUu0YpvGdqP7DQHcctU/SX2ctvbmhSsb2ZSSdBSCpjpLG5tbQk4N9Jf/sKXY1CQ
 I7Fg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8IOTyyP4riDLOCgQJIbXW1o52pUNfFHpwt5Kd7AmadKyJCAAaJBL9M7if6p4x78+ccvFc=@dpdk.org
X-Gm-Message-State: AOJu0YyUZSncuDzFp9DI1nE6VDYLTiAYuTPOo19d3c2/0GuaU+3a+JAa
 eW8f6UZOeJzR56Qc61WfGiEG0xvOukT+Rogc5XWtP1iEwoDk7BruQffjLY34Mi91ZEw=
X-Gm-Gg: Acq92OFHgErVSi3pnwKx1moaSXuHVKGiJItqLCUFgi/6rsC1aDwK6AMdCwDlen9wr34
 JIbiVQcws6aRoHTf18tapzXxvyy0J+1pOr72O+Qb6OGymAIvJN/X0HWJ6cpr8/I2DdF2gwklmBS
 q08xrL+GFaGwd3V8SfgF4WNu4VhfKF9ot1U28GR/SkkAxCVbVGjAFTSvk9fomMhh2pREFSoRWYL
 HI8FEvMrXslG7+6b9X8AFCf7avFkdoI1L42dp+BekXef8szvLH+aSWdtmYxZDSMnM18l4xdKmQ1
 gwRI57MtJ/HjqVnNmTHwNZu5brqC6A4QzcpbP+5Rg+c1ksB1ybQkM1Yf/L5fUttbVQu2+xEAZhP
 Lm66DEc7bIwmhfJ2h7l9/mceVGlUO2gugIIVP+TkX/1mkp80lN6wcL7slGeQMXcbqwO20VY8KGc
 dXnt2z+eWB+OKyKZE8V9wAvUda9wyW9ev+DKsqW/87DjSCZ82KmDU3QjmgnIPFOdu3
X-Received: by 2002:a05:620a:19a5:b0:915:79da:a893 with SMTP id
 af79cd13be357-91d8acdc5b1mr752560685a.32.1781711876034; 
 Wed, 17 Jun 2026 08:57:56 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:2a32:2ddf:c455:dafe])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-91619d2fc0dsm1786068885a.0.2026.06.17.08.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 08:57:55 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: lylavoie@iol.unh.edu, knimoji@iol.unh.edu, dev@dpdk.org,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v5] dts: add retry loop to trex traffic generation
Date: Wed, 17 Jun 2026 11:57:48 -0400
Message-ID: <20260617155748.59724-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518175424.253600-1-abailey@iol.unh.edu>
References: <20260518175424.253600-1-abailey@iol.unh.edu>
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

There was an issue where the single core forward test would report zero
MPPS intermittently. This was due to TREX reporting that the link was
down when the client was called to start generating traffic. The links
were being reported down by TREX on the tg even when testpmd was
reporting them up on the SUT. Adding a retry loop to the generate
traffic method of TREX gives the tg enough time to set up and send
traffic.

Bugzilla ID: 1946
Fixes: d77d7f04f24c ("dts: add single-core performance test suite")

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 .../testbed_model/traffic_generator/trex.py   | 38 ++++++++++++++-----
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/dts/framework/testbed_model/traffic_generator/trex.py b/dts/framework/testbed_model/traffic_generator/trex.py
index 22cd20dea9..2abfbfc5ab 100644
--- a/dts/framework/testbed_model/traffic_generator/trex.py
+++ b/dts/framework/testbed_model/traffic_generator/trex.py
@@ -13,6 +13,7 @@
 
 from framework.config.node import OS, NodeConfiguration
 from framework.config.test_run import TrexTrafficGeneratorConfig
+from framework.exception import SSHTimeoutError
 from framework.parser import TextParser
 from framework.remote_session.blocking_app import BlockingApp
 from framework.remote_session.python_shell import PythonShell
@@ -220,7 +221,9 @@ def _create_packet_stream(self, packet: Packet) -> None:
         ]
         self._shell.send_command("\n".join(packet_stream))
 
-    def _send_traffic_and_get_stats(self, duration: float, send_mpps: float | None = None) -> str:
+    def _send_traffic_and_get_stats(
+        self, duration: float, send_mpps: float | None = None, retry_attempts: int = 5
+    ) -> str:
         """Send traffic and get TG Rx stats.
 
         Sends traffic from the TRex client's ports for the given duration.
@@ -230,15 +233,32 @@ def _send_traffic_and_get_stats(self, duration: float, send_mpps: float | None =
         Args:
             duration: The traffic generation duration.
             send_mpps: The millions of packets per second for TRex to send from each port.
+            retry_attempts: The number of times to retry this command on failure.
+
+        Raises:
+            SSHTimeoutError: If TRex fails to send traffic in the allotted attempts.
         """
-        if send_mpps:
-            self._shell.send_command(f"""{self.stl_client_name}.start(ports=[0, 1],
-                mult = '{send_mpps}mpps',
-                duration = {duration})""")
-        else:
-            self._shell.send_command(f"""{self.stl_client_name}.start(ports=[0, 1],
-                mult = '100%',
-                duration = {duration})""")
+        link_down = True
+        attempt = 0
+
+        while link_down and attempt < retry_attempts:
+            if send_mpps:
+                result = self._shell.send_command(f"""{self.stl_client_name}.start(ports=[0, 1],
+                    mult = '{send_mpps}mpps',
+                    duration = {duration})""")
+            else:
+                result = self._shell.send_command(f"""{self.stl_client_name}.start(ports=[0, 1],
+                    mult = '100%',
+                    duration = {duration})""")
+            link_down = "link is DOWN" in result
+            if link_down:
+                self._logger.info(
+                    f"Generate traffic command failed (attempt {attempt + 1} of {retry_attempts})"
+                )
+                time.sleep(0.25)
+            attempt += 1
+        if link_down:
+            raise SSHTimeoutError("Link failed to come up, Traffic could not be generated.")
 
         time.sleep(duration)
 
-- 
2.54.0

