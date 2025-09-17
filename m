Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66705CA0EE8
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 12:43:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0FFF40431;
	Wed, 17 Sep 2025 14:43:00 +0200 (CEST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id 21D85402A9
 for <dev@dpdk.org>; Wed, 17 Sep 2025 14:42:57 +0200 (CEST)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-81076e81a23so863621385a.3
 for <dev@dpdk.org>; Wed, 17 Sep 2025 05:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1758112976; x=1758717776; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QMbaFb80NC3ehX6xGBkEjy3LZ8m4YQBTVPHh/jCZkSs=;
 b=ZYiihVwvuS64HuHIit1Q3MyogfrVR2FJ3Szk76y/kL3Cw3uNt+jiexv4YiSFHSu4p2
 a59DPdLLAbpSAuQdv0mIVPe28XD5GnXQhfot+rKIarTlQoHgSQgaNa0zQ7XiNOAjY0rU
 vUo5aTyeX9S2iCfhElVEJbX0udg8RHRslx+yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758112976; x=1758717776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QMbaFb80NC3ehX6xGBkEjy3LZ8m4YQBTVPHh/jCZkSs=;
 b=Zntz/Ifk+2U57KYpibB2xwG4JvV7XdIKp5km8rHs6Zbvw6qdMQcM9/3nmDDiKpfEZm
 C4nYYWVh1xv40rr+jG8zgue8IwktXqh+0mWjP/v0bc0ankgO6Qmf+qi6s1Y2qSo3E/TN
 aS6XbAYmVmdFh9Q2Vm3POiTojKfnWKBD9or4KPFbIEzcR9EGyOfmv54hZOksO7HZSd+G
 Jn/rqrisiz89jw+u5ghI3tyCO9QPXU1By+oN9s+oIyxZVGWoQb/IMXnrsuLfgKgTOBfe
 27NbkiWaWZN4sFhEyvrvP3sNjP+yjGKYH9c7lyyF/fwRT8HTILI8/Hqqv1NHNANvHd7+
 hhoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD0Fiagevul8kN/89mJE88qQ3o3TlqZGcpVqoLO2Q4Pw1dFoBKKQFF0B/6zLPcRY35pmA=@dpdk.org
X-Gm-Message-State: AOJu0YwHRznrXVF77WmhmqLrvaxWR4/pKljpmSgan7/tzDhyavR0y2WC
 9ctMulmV/cB1szkhPoDVn8j7Gp1syHZblIWq7BCaFbqsNtiFMG2VmppBTf7A3NKJri4=
X-Gm-Gg: ASbGnctir2cSLWz8ggjIErKNM8l3Xhb/Lt52QgR0sgz8aJsO9eXoXjzIXVKqzrV9SYI
 TtZPw9wavRTD9oZt0OZoUA61VQ2rAEVgpzuw0Ee4vMznWmz4f0TpAzvXlMQlvhz0Qh3mFIgnUYX
 zzI7GEcEkRMN64Uy1Nwuue/fYiw6wKu3AXjNKWM2T2B0b3WcERteKJzDopjmvH+a1A2+AIYYVah
 n+eOEMFDkpi/aXBnF4M7e1UfR9r8KXzkY3S9F+BUuBPWnKWDMKYMGvPTNr1j0eh1aUjiGv8TyE2
 yeqWyWUdbmfndKkW2XKPXpRPCr/iXo+2dRuFR/JcltHqn0a2xRjoB+boMmmRgcFRFzhwm2H0piK
 bs6pOQOlUBK1raOkMoFmKni5UCRANLokbJEc=
X-Google-Smtp-Source: AGHT+IGnvgUz6/rOPmfm8TikIzz2ybgd2aBEObJ/WvM+zPNTFdWdvLb2g2JPPztK5FoL896PVYzOog==
X-Received: by 2002:a05:620a:4413:b0:828:769f:b166 with SMTP id
 af79cd13be357-8310b5993e9mr192504385a.3.1758112976386; 
 Wed, 17 Sep 2025 05:42:56 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-825abc11db2sm908046285a.45.2025.09.17.05.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 05:42:55 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu,
 ivan.malov@arknetworks.am
Subject: [PATCH v3 1/3] dts: allow mbuf_fast_free to be set with testpmd shell
Date: Wed, 17 Sep 2025 08:42:41 -0400
Message-ID: <20250917124243.31567-2-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250917124243.31567-1-abailey@iol.unh.edu>
References: <20250902142725.56736-1-abailey@iol.unh.edu>
 <20250917124243.31567-1-abailey@iol.unh.edu>
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

Currently, there is no way in the testpmd shell class to set the mbuf
fast free offload configuration for queues or ports. This prohibits any
test suites to be written utilizing this offload configuration.
Introduce methods that support calls to testpmd in order to allow
the configuration of mbuf fast free.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/framework/remote_session/testpmd_shell.py | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
index 1df3d5f792..ecbdd66edd 100644
--- a/dts/framework/remote_session/testpmd_shell.py
+++ b/dts/framework/remote_session/testpmd_shell.py
@@ -2672,6 +2672,66 @@ def get_capabilities_physical_function(
         else:
             unsupported_capabilities.add(NicCapability.PHYSICAL_FUNCTION)
 
+    @requires_stopped_ports
+    def set_port_mbuf_fast_free(
+        self,
+        on: bool,
+        port_id: int,
+        /,
+        verify: bool = True,
+    ) -> None:
+        """Sets the mbuf_fast_free configuration for the Tx offload of a given port.
+
+        Args:
+            on: If :data:`True` mbuf_fast_free will be enabled, disable it otherwise.
+            port_id: The ID of the port to configure mbuf_fast_free on.
+            verify: If :data:`True` the output of the command will be scanned in an attempt to
+                verify that the mbuf_fast_free was set successfully.
+
+        Raises:
+            InteractiveCommandExecutionError: If mbuf_fast_free could not be set successfully.
+        """
+        mbuf_output = self.send_command(
+            f"port config {port_id} tx_offload mbuf_fast_free {"on" if on else "off"}"
+        )
+
+        if verify and "Error" in mbuf_output:
+            raise InteractiveCommandExecutionError(
+                f"Unable to set mbuf_fast_free config on port {port_id}:\n{mbuf_output}"
+            )
+
+    @requires_stopped_ports
+    def set_queue_mbuf_fast_free(
+        self,
+        on: bool,
+        port_id: int,
+        /,
+        queue_id: int = 0,
+        verify: bool = True,
+    ) -> None:
+        """Sets the Tx mbuf_fast_free configuration of the specified queue on a given port.
+
+        Args:
+            on: If :data:`True` the mbuf_fast_free configuration will be enabled, otherwise
+                disabled.
+            port_id: The ID of the port containing the queues.
+            queue_id: The ID of the queue to configure mbuf_fast_free on.
+            verify: If :data:`True` the output of the command will be scanned in an attempt to
+                verify that mbuf_fast_free was set successfully on all ports.
+
+        Raises:
+            InteractiveCommandExecutionError: If all queues could not be set successfully.
+        """
+        toggle = "on" if on else "off"
+        output = self.send_command(
+            f"port {port_id} txq {queue_id} tx_offload mbuf_fast_free {toggle}"
+        )
+        if verify and "Error" in output:
+            self._logger.debug(f"Set queue offload config error\n{output}")
+            raise InteractiveCommandExecutionError(
+                f"Failed to get offload config on port {port_id}, queue {queue_id}:\n{output}"
+            )
+
 
 class NicCapability(NoAliasEnum):
     """A mapping between capability names and the associated :class:`TestPmdShell` methods.
-- 
2.50.1

