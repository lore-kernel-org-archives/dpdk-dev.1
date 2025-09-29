Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BE0CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 17:27:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DD1C4068A;
	Mon, 29 Sep 2025 19:27:43 +0200 (CEST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id C67F140613
 for <dev@dpdk.org>; Mon, 29 Sep 2025 19:27:39 +0200 (CEST)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-855d525cd00so665588285a.2
 for <dev@dpdk.org>; Mon, 29 Sep 2025 10:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1759166859; x=1759771659; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7IFIP7VQUvobNfJFQ2kf0HZe2xoMYqiKztGoQSF8iFE=;
 b=LG/FFvgX4HLUx6bTWlmVN7kY5ykkC3P2EAVKSkwPDgC1HBaWkJfUeNkiirZA8E3MjZ
 2MESDW4VneelBvo+AqV6LwAY3gt61iiMty/2T4Ciy7xnrz6UzMVr8jSWed0N7+f4Ak7e
 JQVsW4K0ooeSOWOG32XzV1hbzQLWYvDa9bkcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759166859; x=1759771659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7IFIP7VQUvobNfJFQ2kf0HZe2xoMYqiKztGoQSF8iFE=;
 b=I0tQzGyBJN/MrZbbz2sqC92tY8ljgJsM8i25rqOE1jU9OBZoFfFGg1QGpeEBQtYQPn
 lZh/u6pPlcxBJJIWnbhgbzD/rNMC75zvri+VCGgsn5SoXq+fY2dcradY/05wotdqHGN4
 90GPlCNcdVOaO4nEmuGkzM+vOR0rZ64nIQN6M1LMm+SZ3lJptg+Dy/t9/MoeQYAGpRP4
 YCkgSA5VtmHSNPJDp8B0JvPMG/jRU9AOFUkWEW1SbTTpwYX0WtRR/PnlwDeLQgaYdryC
 uJuJoDSmeoLH7casleV94EMg5pohIf9Ax9Z/vMrWjqde267XVi6E6iSbsiwd3miYw8b6
 KtDg==
X-Gm-Message-State: AOJu0Ywa4QIxqHbC92pey0KWBS3rInjtW7lCdlA1XZRUyuDmr2gyveRg
 isEyVLTEBjoEC/vGE0DprZQGDrf0U41wW8GrdWn0cSFGzALPmY8reW4ebp63Oiof6cs=
X-Gm-Gg: ASbGncvmeWQUNy+TYgIdKiJtmwEUXAWYpY1+nWrHEUH1XK2nfEQf67NIejRXofezcXz
 sPcPrO495kLZYzGWGJRR676UO+Yh45+2xVApgf/rkafTCODrD2oPpXEQc9tLSamnWIN/Te+6lC8
 2YT2Z3DRadzLl2vvuMODXj8Z6j0Zrjo16KzQ1J3fwquO5SEQv1M8OiIfUYFR9vQK3kTWJnom+qa
 9SrsA6k1PVknWYjgEPmeLW4W9hW04FAhT7iqsKhPTvGD/59taRx4cjkOb/591Ow3bvMZu5O2kl+
 89rVS40FMnoYt85kmoPAfAdJAQRzYPEt5rxPH/axRDs+XcyFVwyQXDvbloxqzxgtytXpi4kFVts
 r7GS7AW0tMaK++4R+hXLkEfq22ITmsXYxOa4=
X-Google-Smtp-Source: AGHT+IGEY4WpBRFJCygzbjv1Esf51FVelvDrqgtT6Ijg1okJZYEJaEEXwUj/OJu2Ahc6Dpn0XlE48g==
X-Received: by 2002:a05:620a:4016:b0:863:9683:b99 with SMTP id
 af79cd13be357-86396830e72mr1563454285a.41.1759166858937; 
 Mon, 29 Sep 2025 10:27:38 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-85c337a1c97sm838586585a.55.2025.09.29.10.27.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 10:27:38 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.edu, ivan.malov@arknetworks.am,
 probb@iol.unh.edu, Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v6 1/3] dts: allow mbuf_fast_free to be set with testpmd shell
Date: Mon, 29 Sep 2025 13:27:32 -0400
Message-ID: <20250929172734.218467-2-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250929172734.218467-1-abailey@iol.unh.edu>
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20250929172734.218467-1-abailey@iol.unh.edu>
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

