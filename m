Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75399CD8CAA
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 13:33:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94A3E402B8;
	Tue,  9 Jun 2026 15:33:56 +0200 (CEST)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by mails.dpdk.org (Postfix) with ESMTP id 5B2434025E
 for <dev@dpdk.org>; Tue,  9 Jun 2026 15:33:55 +0200 (CEST)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-5177945a22eso37780331cf.1
 for <dev@dpdk.org>; Tue, 09 Jun 2026 06:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1781012034; x=1781616834; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C8Gm6Nj/kiLTI+FJwbA4pPDUjaz+8sC3Ju9WSy+ENqQ=;
 b=bjjIaxsuce+Crzd+/42jm/R9ss96Ykr7kx5W7UyFeahEYLAp1rTyQc0897BvHBHDFC
 SyWqpU3r8N0TnkptEdWPA7EjsocHg/dEZt52oPYY7RpynU2trxgfiJjdDKMTY7OZJz9M
 oIAF46l8Wt1nRq0yzduZFE4sJq04+AD8RbQVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781012034; x=1781616834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C8Gm6Nj/kiLTI+FJwbA4pPDUjaz+8sC3Ju9WSy+ENqQ=;
 b=Klbybs7ugleEU+u5lA58o52xb4mdLcPQ04Qb1outcf494ynZD1qlzfULMTfOQSbHm3
 YobLFcXgfX8GAwBhkCtDdTZbZwgx8VTwPXTeChJKTayHXS1xjeEmoRNQAtezjMhLgF1Z
 Tvg25XpllQlGkqYkOcZu2vvBx1RS2fRIq1bSEDKAWNtYrPtRXKa5xcDzjNR4Jymk6//t
 57OaebStEQf0MZWvmCpRPnLdXj7mKu+pDBCJJkq8x9qpbirutXq6qK82fgTw61mXoN47
 Uuw6L5CjVjkxU+JB/AROXqamPe86XIGhvQdxdc5dSatlR+hGz9NlN5UyiFZ6vT9ZP/+j
 nY4Q==
X-Gm-Message-State: AOJu0YwWkv3cpcWukxScDHSVSo/bMbciktgGoKNbjFv/WrW9xqpz3+1L
 q9PA5GfA3OsylxGUK+ULg7l5pQWdzPLrGTcoD9m+/K1GnACkUz+DNnh3JpMdIyxOPps=
X-Gm-Gg: Acq92OHYvfs9n3KASKqji+xERdAPKZ63xpyAD30AZyLU3e7U/j+Q0HkDO43gmYr8aJQ
 REu+Ss+829BHJyQ1DmXUFmxkw+0n8bMf92k470WdlWXIHp01I9GjrqlpwZTCF+KpsuoWDZUuUmj
 uDrgBlPQ2CriLPwW6/hrGEnOvHF6kbjwCV50TW5J7cjDLb6b3kGWDwDIOsUhFfP4b9fq7yeul1i
 y3hblm/a20IW9qpohhyN0+XUhlLfmMPJqg4H3QoERQcFMdeyIIY3ayGxnO1orBMWgq1AKUmJMGs
 y5HQOWBfVWtTE8S3Bg/2h4Zb5MdwjmR7zhN1BAuZRgQ8/FvFNN1aHseId66wkbjS1p6ta4rUel7
 KHbAQyfvA/IX69hsc5Rp2RlXLvrTDIadsBrGRFA1q4gDDXnMcslcGlVcRtOzJfBvCb78qKdSK9+
 UebVaZAie4zTG1KH8HBMclsJZoGF6+WWHumWWojdPzXW7k2yEEvlYAkPJeBtgMbm7k9+MLUQp4r
 AEAslIRASsZMw==
X-Received: by 2002:a05:622a:20e:b0:50d:a8f5:1bf8 with SMTP id
 d75a77b69052e-51795be10dfmr298493011cf.37.1781012034432; 
 Tue, 09 Jun 2026 06:33:54 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:2a32:2ddf:c455:dafe])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51795d46f12sm132146711cf.16.2026.06.09.06.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 06:33:52 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: patrickrobb1997@gmail.com,
	luca.vizzarro@arm.com
Cc: dev@dpdk.org, knimoji@iol.unh.edu, ahassick@iol.unh.edu,
 lylavoie@iol.unh.edu, Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v4] dts: add retry loop to trex traffic generation
Date: Tue,  9 Jun 2026 09:33:49 -0400
Message-ID: <20260609133349.242758-1-abailey@iol.unh.edu>
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
 .../testbed_model/traffic_generator/trex.py   | 35 ++++++++++++++-----
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/dts/framework/testbed_model/traffic_generator/trex.py b/dts/framework/testbed_model/traffic_generator/trex.py
index 22cd20dea9..f21892e396 100644
--- a/dts/framework/testbed_model/traffic_generator/trex.py
+++ b/dts/framework/testbed_model/traffic_generator/trex.py
@@ -220,7 +220,9 @@ def _create_packet_stream(self, packet: Packet) -> None:
         ]
         self._shell.send_command("\n".join(packet_stream))
 
-    def _send_traffic_and_get_stats(self, duration: float, send_mpps: float | None = None) -> str:
+    def _send_traffic_and_get_stats(
+        self, duration: float, send_mpps: float | None = None, retry_attempts: int = 5
+    ) -> str:
         """Send traffic and get TG Rx stats.
 
         Sends traffic from the TRex client's ports for the given duration.
@@ -230,15 +232,30 @@ def _send_traffic_and_get_stats(self, duration: float, send_mpps: float | None =
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

