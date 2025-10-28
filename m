Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF275CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 12:22:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 946294060A;
	Tue, 28 Oct 2025 13:22:54 +0100 (CET)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by mails.dpdk.org (Postfix) with ESMTP id 5E5BA4021E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 13:22:52 +0100 (CET)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-4ecf9c2c9acso22648821cf.2
 for <dev@dpdk.org>; Tue, 28 Oct 2025 05:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761654172; x=1762258972; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WDqcxbMsj0sgBiNeN41UqHM+/3Tk6GoAUKjb5NthsM4=;
 b=VdpVitZQegPylPpXahMHXUt7xWzUOnvnP24ezeE/S8dnMMS8m8hvGcx8YmmcThGbvw
 ecgmspq6aa+mlER6qv0B5h/URk56g2Vl5p6LlUqQVEhkTk1cOm+QcT8bEKYYv/ep3rmQ
 S04clmVS7A4wQ1A0ZQEZa3pWPP6qQvMAQUiic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761654172; x=1762258972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WDqcxbMsj0sgBiNeN41UqHM+/3Tk6GoAUKjb5NthsM4=;
 b=nmVRSD+aY9rR+erFT0vzq9Pi0OfP6C8w4HmuJ5AatwPLyLvd9QtQJvQ4gzqHV2GDId
 ASWkuPQ5fGeoKt2MjpAvFInprXJtE0jaIQuy6Qd802thhLnXqlBucMhK02aFIryYUhvu
 QpIK/+/JFl4aqoWC0Y9evmQvoPLCDfjwwVuI3v3rRJmu6X3nTBNlLKP0aMHx/m8UiLEv
 HJh92sFUqRsk5j9sPKePs1m30THDUyal29hwhfLf4eKculJFphJw8EzoBLjmHV1Ai2dM
 9TXYROuaL4Vj8TZVpVXi9mTDNlp712mSQpJPhffIs2nlsQaQ2p1LPIhYiZShFgOSBDVC
 EPCw==
X-Gm-Message-State: AOJu0YzK2H3yGcBpXRswDHOBmToroHX4Ma5emknYjfDSGj/zIRXiEaRM
 h1IhY6QTruFZHqS/BWyJibqQcFjytnMEKsz9W5eUZOOK1c1NFCYs77JMC/3ICWhMGGZG2+uq5l2
 vPBGp
X-Gm-Gg: ASbGnctahpIIpujroT/uTGYJsIey3uooY0pnrryI5NlITmKazz1Ub7sEq+bI4FX9zkC
 aWorc8VvPOlYlJzygARySl+ennvhShN7AFZ2fgparabdr7rx3JJQrlM91oM/PM/dz0EtFbgWrsZ
 5i4dSxQTaZf9LBi/Mw95YNGiXxmr1jAVEM9HUbiI7qwTDsHgP8ZR/nt9t5fOB/EKxFaycyfWH+v
 oYsGSTSXZwyyDik+RTxy6c0tex3ho6pzl43usB6uFVAh10CfHHvIXdDC0cGlW+Vtx0lZsgBVGp7
 b2BXlroGOW0uYZjM1N3O78hgXGLhlElqjbSPljnXk5RDxRBXvN0NvI0UN+/f59Oz52R0SN2qf9p
 LNpZZNv6NqELuW6Rjy0bOm3xR/5/C8UvdfB43ug5vAExDTxj39UcxgkRKgdEcXJ7OvxdVyJnztE
 C5wj7OFeeavbo4
X-Google-Smtp-Source: AGHT+IHPs+PR3Uj9GVkQf1V/o4OE3MLIOY9i2VjAn1zFdPoNDzzI0Q9pbb1X5PNSZxefbuua46JCWA==
X-Received: by 2002:a05:622a:900f:b0:4eb:9ee8:354e with SMTP id
 d75a77b69052e-4ed091d7673mr32917411cf.5.1761654171651; 
 Tue, 28 Oct 2025 05:22:51 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87fc4969008sm75450306d6.42.2025.10.28.05.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 05:22:50 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: dev@dpdk.org, luca.vizzarro@arm.com, dmarx@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v11 1/3] dts: allow mbuf fast free to be set with testpmd shell
Date: Tue, 28 Oct 2025 08:22:38 -0400
Message-ID: <20251028122240.112773-2-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251028122240.112773-1-abailey@iol.unh.edu>
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20251028122240.112773-1-abailey@iol.unh.edu>
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
 dts/api/testpmd/__init__.py | 60 +++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
index a060ab5639..9e9cbaf495 100644
--- a/dts/api/testpmd/__init__.py
+++ b/dts/api/testpmd/__init__.py
@@ -1292,3 +1292,63 @@ def get_capabilities_physical_function(
             supported_capabilities.add(NicCapability.PHYSICAL_FUNCTION)
         else:
             unsupported_capabilities.add(NicCapability.PHYSICAL_FUNCTION)
+
+    @_requires_stopped_ports
+    def set_port_mbuf_fast_free(
+        self,
+        port_id: int,
+        on: bool,
+        /,
+        verify: bool = True,
+    ) -> None:
+        """Sets the mbuf_fast_free configuration for the Tx offload of a given port.
+
+        Args:
+            port_id: The ID of the port to configure mbuf_fast_free on.
+            on: If :data:`True` mbuf_fast_free will be enabled, disable it otherwise.
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
+    @_requires_stopped_ports
+    def set_queue_mbuf_fast_free(
+        self,
+        port_id: int,
+        on: bool,
+        /,
+        queue_id: int = 0,
+        verify: bool = True,
+    ) -> None:
+        """Sets the Tx mbuf_fast_free configuration of the specified queue on a given port.
+
+        Args:
+            port_id: The ID of the port containing the queues.
+            on: If :data:`True` the mbuf_fast_free configuration will be enabled, otherwise
+                disabled.
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
-- 
2.50.1

