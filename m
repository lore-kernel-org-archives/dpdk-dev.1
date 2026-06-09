Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6EECD8CA4
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 12:42:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7262D402BE;
	Tue,  9 Jun 2026 14:42:19 +0200 (CEST)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id 49499402BE
 for <dev@dpdk.org>; Tue,  9 Jun 2026 14:42:17 +0200 (CEST)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-8ccf887de87so63672646d6.0
 for <dev@dpdk.org>; Tue, 09 Jun 2026 05:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1781008936; x=1781613736; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SyW1KFJaM4HusCru390L6U0hHpOBcsJTGoS4OFDA2GE=;
 b=d8jUnaBzhEuHUdVH0JUggNUpdo8yOVgvgLLCqkeZLzCGKchv2wo6EE5qIVY/2uI/jH
 y7TKDO6NWtyLZphQ1Bjg6IvK5FkomhaUP2eQE1CWaQvR8QiDPYRyqpTcLA31PbmkhhKJ
 CHT3f9hS7qHZtqg1Qptk49Q5MflXFTazqpHFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781008936; x=1781613736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SyW1KFJaM4HusCru390L6U0hHpOBcsJTGoS4OFDA2GE=;
 b=f3LzU2z5DPxslRwZMz8Jl28pDiOpskRGn8un4qkc/yVyZvcE/R+8afY28FOZkoIsMq
 r2AFhYqDEaonVRLsJ9jzLCQDUwZV1BHlThN632oQWMxauvaMjOvuRXpXn8h/2c1pg2X7
 1jIdvzTn3uOVm60sWQ6ygnpIweJxQyP5vuo5xWcLbpTzorGkCVeuGc71dWFXm9TNgGZL
 Kv/FvveMMKKkm//Qgv6EyZXOEyPAZdwhSLpYPVB7B9ZtxVzdvUxp79pDhokeqyhQz/y5
 74HNXDSERjJgdE5ifgCrWOkjHFigydqKX5MT4fTDtndM8lNehWhL3zsObBMdRhMq9rTE
 7gQQ==
X-Gm-Message-State: AOJu0YypJdT1NPXl5oUOXkh07MC6bUdYNUyQypiYDjASkuOZ0pOWQX8M
 hHlV/JqPxmCP21TN/ps5Lo72z1yNkaMX/VHfAvMDCPG9qdb2cMsz2OSSGrqFTPmGojs=
X-Gm-Gg: Acq92OHTbde8ckRRmuUEH1nVnlC7HwxuR2tvPB8klFw2LaxIAq9L01lX7pJj83rDwho
 XmUVrYzM+fg8Ixa/M5Jpwdh7fHRAEbX0f4jTuajfJta+UMtbbeM7XMURAMd4sH7LXf/JK59JH27
 9vokL/AlBBhyLFVkejZYxmZjwxgNbzvJsTWKRaTQUBp/JVjIkES4rdc6XH9p30AA4Ck9v0wUYGW
 4t52KZN3vH1Z5LmGPZv//13mCiVcLY7Sr+OtwmkJg4FB21FudIvMRo+ADf5Qv1m4YY3uNZY9LMv
 IpCuf130Smx8pbpMjGCERKKjV6FkCPfbUHJ6cEO6MoxpVi6n7K2zkgSBN3hf4+eeaDKoYQVpodC
 Qev0bRDeKgdLfv6cbwzVxA9OnUt8EqaqdGEl6qvBD0nnY+ZVv1fCSnOfTXo+/BcAQPYMqXDTkzy
 TGRe0ve30p1ycSDU5ZxGlvTLIFub1Yyhayn1bhgGBAAH9PBviT9+XahgyjWYET1OrTlGhoSEO4u
 ag=
X-Received: by 2002:ad4:4250:0:b0:8bd:6baa:6aab with SMTP id
 6a1803df08f44-8cee5fed3a6mr249504606d6.17.1781008936335; 
 Tue, 09 Jun 2026 05:42:16 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:2a32:2ddf:c455:dafe])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ceccdc6755sm201177666d6.18.2026.06.09.05.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 05:42:15 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, ahassick@iol.unh.edu, knimoji@iol.unh.edu,
 lylavoie@iol.unh.edu, Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v3] dts: add retry loop to trex traffic generation
Date: Tue,  9 Jun 2026 08:41:23 -0400
Message-ID: <20260609124123.221389-1-abailey@iol.unh.edu>
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
 .../testbed_model/traffic_generator/trex.py   | 36 ++++++++++++++-----
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/dts/framework/testbed_model/traffic_generator/trex.py b/dts/framework/testbed_model/traffic_generator/trex.py
index 22cd20dea9..b1a3a6ceac 100644
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
@@ -230,15 +233,30 @@ def _send_traffic_and_get_stats(self, duration: float, send_mpps: float | None =
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
+        link_up = False
+        attempt = 0
+
+        while not link_up and attempt < retry_attempts:
+            if send_mpps:
+                result = self._shell.send_command(f"""{self.stl_client_name}.start(ports=[0, 1],
+                    mult = '{send_mpps}mpps',
+                    duration = {duration})""")
+            else:
+                result = self._shell.send_command(f"""{self.stl_client_name}.start(ports=[0, 1],
+                    mult = '100%',
+                    duration = {duration})""")
+            link_up = "link is DOWN" not in result
+            if not link_up:
+                self._logger.info(
+                    f"Generate traffic command failed (attempt {attempt + 1} of {retry_attempts})"
+                )
+                time.sleep(0.25)
+            attempt += 1
 
         time.sleep(duration)
 
-- 
2.54.0

