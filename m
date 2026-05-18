Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D71CD4F4A
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 17:54:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B20D7402D9;
	Mon, 18 May 2026 19:54:49 +0200 (CEST)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by mails.dpdk.org (Postfix) with ESMTP id E92E440041
 for <dev@dpdk.org>; Mon, 18 May 2026 19:54:47 +0200 (CEST)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-50e5c7eb565so32497851cf.3
 for <dev@dpdk.org>; Mon, 18 May 2026 10:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1779126887; x=1779731687; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qADP+wJPyD5tRTXpx2d/cGfywBa4kV6qB/63vjM4GB4=;
 b=P2nMO0QXcYaKxcILU2940NO5QTHivxVACxo91UkPKYw0CmCWoqYtyo/nWgL/bBXBjM
 V8jTKW5OcUgCmv5YknpVTkfVRlMX4M1d9/Ww3p1kIJqq5fMKqxWUwzpceNgCW9CeZ+Hu
 8GmUwUCmmCdpZc651TKhCXwo/NsgaJe4H1iBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779126887; x=1779731687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qADP+wJPyD5tRTXpx2d/cGfywBa4kV6qB/63vjM4GB4=;
 b=EgWr2UwRFDmD7jXrEsycQqm349VPffNaFcZz7gOhXefGMkF5X1PSrdePeARTt0Z9sS
 pn8qGzUVFSeqmr26A5vWkCTYWEaPOy4QYRHx0xSXktB6Puh2HOu8t7pnsxTTDTgsHQfz
 2IfjkOH8mGhksXCQciKRLc4hthBaOEKXUOOBx2zK1dcFe6xcbK+mN3pGh8brqdOZRPJT
 l77ZRLsy6Rp89eJp88nTWUlE3KTPGZo7MnJ3ItVBiXr4qR4I99bmDEVIHc9aaGVe5Tg9
 ratwHooL85GBrFOe3WFk4KNw5hSGQ99wyMA5QPAf5vwsk4JbqsyTFwsncKVkxOsp5Kf3
 GsAQ==
X-Gm-Message-State: AOJu0Yx9b7yXGalUQmLcMM/68KdArVHzY6qy7snF1UGi3rZWaT53K+aK
 5kCMNZxbVy//oNaZyXTpAwvfn6USS3KVrmVASberH1jfyBoZTo72H7FipKhKOff3xHo=
X-Gm-Gg: Acq92OFznnqVMJU6yWW2IU+rRFjUUDfJOxhG7+VseJhku2Hcw9KueHmAiOYVHFNh4dL
 Qz5KlAjOsP8OFGn2/k9u+B2/m+m0xkwrbf7Qqxb3uL5lPurdkqFBsI7tKuD6Tky69vk2X5JoB4/
 ijdRMsajM6/I6+iDhT6pA0bJ+iJBUcTZ+gdtv3l23GhbmtacDyoNXBVTsDBoNkPpZXtmUKcydSY
 jssccXUkwaKmWmNgQRxj29II9ew50mPEI5mw9UmrBtACSaQ1m/pkFbhqEEM+050QcBW+znPncw6
 7H1igWiJqgL3j5VCdFZlrSgAhaaVfc5lqqwqhrVEzGpDgKbHKLiBHXKeDZUrMYerI+Nky9SyRUV
 cCkAf3aGZJWfVuXx/sTTFx5PvcSykRWnaauRrbiv/ctV6df2E7KgsB5ogw37+XZX8HW7wIUq7hb
 Hud5hh46OYMSZT01mJKb1Rcnm6DIIRT3aw1op5Mul00bI5Zjwtso4/KpIYVCTQfQAg
X-Received: by 2002:a05:622a:a06:b0:50f:c36a:3826 with SMTP id
 d75a77b69052e-5165a0ae89emr230424031cf.16.1779126887155; 
 Mon, 18 May 2026 10:54:47 -0700 (PDT)
Received: from d122201.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca361ad694sm63171406d6.45.2026.05.18.10.54.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 10:54:46 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb@iol.unh.edu
Cc: dev@dpdk.org, lylavoie@iol.unh.edu, knimoji@iol.unh.edu,
 ahassick@iol.unh.edu, Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v2] dts: add retry loop to trex traffic generation
Date: Mon, 18 May 2026 13:54:24 -0400
Message-ID: <20260518175424.253600-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260515174714.211668-1-abailey@iol.unh.edu>
References: <20260515174714.211668-1-abailey@iol.unh.edu>
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
 .../testbed_model/traffic_generator/trex.py   | 37 ++++++++++++++-----
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/dts/framework/testbed_model/traffic_generator/trex.py b/dts/framework/testbed_model/traffic_generator/trex.py
index 22cd20dea9..daf07355f2 100644
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
@@ -230,15 +233,31 @@ def _send_traffic_and_get_stats(self, duration: float, send_mpps: float | None =
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
+        result = "link is DOWN"
+        attempt = 0
+
+        while "link is DOWN" in result and attempt <= retry_attempts:
+            if attempt > 0:
+                self._logger.info(
+                    f"Generate traffic command failed (attempt {attempt} out of {retry_attempts})"
+                )
+                time.sleep(0.25)
+            elif attempt == retry_attempts:
+                raise SSHTimeoutError("Failed to generate traffic on TREX traffic generator")
+            if send_mpps:
+                result = self._shell.send_command(f"""{self.stl_client_name}.start(ports=[0, 1],
+                    mult = '{send_mpps}mpps',
+                    duration = {duration})""")
+            else:
+                result = self._shell.send_command(f"""{self.stl_client_name}.start(ports=[0, 1],
+                    mult = '100%',
+                    duration = {duration})""")
+            attempt += 1
 
         time.sleep(duration)
 
-- 
2.50.1

