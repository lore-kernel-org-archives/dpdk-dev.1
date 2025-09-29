Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BCACAC5B0
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 17:06:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89C6A40674;
	Mon, 29 Sep 2025 19:06:26 +0200 (CEST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id 95A4A40289
 for <dev@dpdk.org>; Mon, 29 Sep 2025 19:06:19 +0200 (CEST)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-854585036e8so509493985a.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 10:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1759165579; x=1759770379; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7IFIP7VQUvobNfJFQ2kf0HZe2xoMYqiKztGoQSF8iFE=;
 b=a16jQUC36iYUdFnZsF5GApQe7ZtCTaEW0F6UzbeUttezSUnlkBJkmtlsBBWkcJRIf4
 8VaiV1rXSqWwQynJUHnmyOhf4C5D0w/eGYDIthOR9+Uu0fzzpMcsnDvl7Llu/tKhaH6D
 SIvSz0x/wpBEsCa3jUGPLuKyKvpbr4/ev/YSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759165579; x=1759770379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7IFIP7VQUvobNfJFQ2kf0HZe2xoMYqiKztGoQSF8iFE=;
 b=rTQePlrh28qv3xfaQ9OYpZFR4hlpuwrl36IIEm3/q9PJvoyO+rNAa7KPbWraHZ7+rI
 a9LC7hRCwxdvRyxuj+drcf5k8VER3rLxya5FbMjkmkjkERdgHR0QB2n8k/MC/qkYcktn
 ySKaG+yxZQzR+Vb726lblQeWRGm2PrHKQue5Fxhq+cU3VFTvncQL7r3KFI6MRARBzRyv
 MyXJt65sntGvWzMwrrPXzbl24EjZ3VZS6UyKlEdbmo6b8ZJv0tf37AmwTaXTuIvzpSPU
 b9/+CxiZq+q47sbOLY5h3SX8iobVMM/5395muoxH/UkVyOH/E8tjCIog/g5uJ6LAqlu7
 6uPA==
X-Gm-Message-State: AOJu0YxPt64WakCEy7yqngpHrMfYeWXMnDtUQgiEKQirVCUYEo9oKr3D
 NkdYBrlLMK7kSv4IckmQ1gihzrTH1ncbvaPce7JnljrTsabu8fvI4ytiiYIzftPhrVE=
X-Gm-Gg: ASbGncvoGtQ/HKFUdVK0FdgCAzQwRRafYqw/FYOjL6IsxYPaXAUR4vGZ7/Nu5Z94Vve
 Eb7aDbBU56LqGSBzXxGFgBKzD/iCUFlkyXJvlK3DH0R18jmcGnDnIWQ88l/SqiubbdDWb5tCCaI
 eflJW3wVZ9DtrG5MxDd+sbB2YkTFPl9Nk/0VFtdIVm16Jk4NMreN4DfkvF7xWynNaWqXeBscCrl
 awkNf4DBT9jiblBXgwznbhMS6u6OzW57gVnOVBNGLJLq7utXGKa9sWR9qQrB0f99roDWVp2MpnT
 6v+MIb+HcowHdrNoGqeDJIsqi5+PCzdYPQIU+AOk04MlLzSc0YXeK95urvbICAZzlK4zBXrUZ9c
 t7ddpX7C86Bxrw/AfREG2ndaT+YYf3Z7pQH8WtVeuutVgFzSQF5Jbza9L
X-Google-Smtp-Source: AGHT+IE43WIAqXzaYRUObaF5x6D0kKyKtCfBYjQi45TMF3x2nP1OdCn+zL97RrAHaX51rzrePmktfQ==
X-Received: by 2002:a05:620a:a817:b0:85b:3baf:9fb7 with SMTP id
 af79cd13be357-85b3bafa1f4mr1798716085a.60.1759165578885; 
 Mon, 29 Sep 2025 10:06:18 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-85c28c76f69sm869843885a.27.2025.09.29.10.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 10:06:18 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.edu, ivan.malov@arknetworks.am,
 probb@iol.unh.edu, Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v5 1/3] dts: allow mbuf_fast_free to be set with testpmd shell
Date: Mon, 29 Sep 2025 13:06:03 -0400
Message-ID: <20250929170606.216623-2-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250929170606.216623-1-abailey@iol.unh.edu>
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20250929170606.216623-1-abailey@iol.unh.edu>
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
index a060ab5639..39696ddde2 100644
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
+    @_requires_stopped_ports
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
-- 
2.50.1

