Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD3CCCF9E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 17:47:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 284A94021E;
	Fri, 24 Oct 2025 19:47:08 +0200 (CEST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42]) by mails.dpdk.org (Postfix) with ESMTP id 083F640151
 for <dev@dpdk.org>; Fri, 24 Oct 2025 19:47:07 +0200 (CEST)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-87dcb1dd50cso31795516d6.3
 for <dev@dpdk.org>; Fri, 24 Oct 2025 10:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761328026; x=1761932826; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4LmnGS1A9CR1LubXqAmgJJ0QAWM1qnHWL42eZyx3rWs=;
 b=iq5cx3pQt5zidO93istQ/bOU9uVabVIyFYsB3n6/8kdeVHeUmfMvBQs8v99zBB10Ot
 a892H/JTtQGqgnzv2yBH/v00QTDs4iO7QEVoHukMbfuap5oy7Cp0oXlfp5OCax7znIO+
 H4QTbE3Z7hnmUg4YxXEvfNBsrNHiqWrfYn7r8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761328026; x=1761932826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4LmnGS1A9CR1LubXqAmgJJ0QAWM1qnHWL42eZyx3rWs=;
 b=WlyZWdvfRAldNJapU+lo8bibWEUPcbRQs3Kp5reTm+68U1enjI84Aji1NK01QCDiLD
 mCmJHsTsxA/P3ZcPcMx8YwFObSajgH1v2HIaHk0xvonFDJuDbHytBpLyTuNtUBNVlGSw
 viCjU25VU4NXH8NO+t03nnvNviEraDPiT2a0dJDTw07qJtpfD/jZLmIlFHTtKpU/Xw4N
 dKQD5RV5Rcj5a7vfoTBETt/5pB1bbLsmr2mNAXDB2CkddZlcGBBSIAU+QBF8iZig41nh
 ubO0IbwZngpx9yTBQqIIJNgzwxmkiOfoFxkegwYZDskGlMhDXe4Z5Qmq3SjpY+Ll+TsR
 lXlA==
X-Gm-Message-State: AOJu0YzYMysQYgD1dx9iJoZsSVbq5heuU4PLQOkruuBD3diVaUD/3JfD
 Jj68/fs+z01t367zfj9asPO/XZvWeRLKqyGV/ciDvyHxRlHPxsWAwi2qExDB30HGguE=
X-Gm-Gg: ASbGncsx/VY+GMbwPW0n6Sn0gFaiW749KImb++dz09yBmUekyNFP8QMllEgM0necXaN
 IQgGf4MIFi1MkQU00OCc6+YVWzyeuzV7r2MQk4NARTxOn5mSJh3UBs10DbsjllIaSLlW2IMP4hn
 BnP2zmFV6ij3GC3OMEGYGwh/Jq6k5YySFo5MMRrCBDacXrIB9QEJ3rclpvgw5ncJDOaU7bAs+wu
 2t9L3ltN7k7qZqWhUji3ACYE6kZjoTeEgONCnviVo5CyDwFD07f+y/VI6IBHKhvgF4+391Km2Cg
 pvCfEoPJYIJiQCvWFN4a3lPNISjF06RIb04+tnFiO1p0jPf0Hp4K5A7uylIkQWxTfOCcHYqRwWO
 gUZMBfOQYaC3TET6wai5PTrJEQ7MxqbWNBumAEgn2TLu2mDKDZRfl+LAiBdBQ19bt1UfI
X-Google-Smtp-Source: AGHT+IGEnMExiWKDI394l10NoZ6gT3hokGq3PkRXvK0eTUr4/mbpmJwOFtMKQLFXTGk1fYjwb5I8FQ==
X-Received: by 2002:ad4:5bcd:0:b0:87d:ff71:8fe6 with SMTP id
 6a1803df08f44-87dff718fecmr114132826d6.24.1761328026240; 
 Fri, 24 Oct 2025 10:47:06 -0700 (PDT)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1257::100a])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87f9de816a2sm40527256d6.24.2025.10.24.10.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 10:47:05 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v3 1/3] dts: add start Tx first method to testpmd shell
Date: Fri, 24 Oct 2025 13:46:58 -0400
Message-ID: <20251024174702.600147-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003192717.444490-1-dmarx@iol.unh.edu>
References: <20251003192717.444490-1-dmarx@iol.unh.edu>
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

Add start tx_first method to testpmd shell, which sends
a specified number of burst packets prior to starting
packet forwarding.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
---
 dts/api/testpmd/__init__.py | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
index a060ab5639..5cf1ae7fac 100644
--- a/dts/api/testpmd/__init__.py
+++ b/dts/api/testpmd/__init__.py
@@ -199,6 +199,27 @@ def start(self, verify: bool = True) -> None:
                 self._logger.debug(f"Failed to start packet forwarding: \n{start_cmd_output}")
                 raise InteractiveCommandExecutionError("Testpmd failed to start packet forwarding.")
 
+    @_requires_started_ports
+    def start_tx_first(self, burst_num: int, verify: bool = True) -> None:
+        """Start packet forwarding after sending specified number of bursts of packets.
+
+        Args:
+            burst_num: Number of packets to send before stopping transmission.
+            verify: If :data:`True` , a second start command will be sent in an attempt to verify
+                packet forwarding started as expected.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True` and forwarding fails to
+                start or ports fail to come up.
+        """
+        self.send_command(f"start tx_first {burst_num if burst_num is not None else ""}")
+        if verify:
+            # If forwarding was already started, sending "start" again should tell us
+            start_cmd_output = self.send_command("start")
+            if "Packet forwarding already started" not in start_cmd_output:
+                self._logger.debug(f"Failed to start packet forwarding: \n{start_cmd_output}")
+                raise InteractiveCommandExecutionError("Testpmd failed to start packet forwarding.")
+
     def stop(self, verify: bool = True) -> str:
         """Stop packet forwarding.
 
-- 
2.51.0

