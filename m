Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23807CCF9EA
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 13:02:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12D80402EB;
	Mon, 27 Oct 2025 14:02:48 +0100 (CET)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47]) by mails.dpdk.org (Postfix) with ESMTP id AC533402E6
 for <dev@dpdk.org>; Mon, 27 Oct 2025 14:02:46 +0100 (CET)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-87fc4d29301so37681696d6.2
 for <dev@dpdk.org>; Mon, 27 Oct 2025 06:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761570166; x=1762174966; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WDqcxbMsj0sgBiNeN41UqHM+/3Tk6GoAUKjb5NthsM4=;
 b=A/lE6qR15wwmk1wHpMFuaGGbVXgQxQRHxEj/8VhJM1N8GY+oqlI3xhAjoDSQMsQV+D
 ybs21X/cC+nlAaghrwDrYxy84VKxl4nGY/yLEnNLz6Gf8mAyDnlzgtJoEPXf3kZ1eHLV
 8pFI+UPj3oFMnflSFf0UVGLV+nvcvW5Ml8i9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761570166; x=1762174966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WDqcxbMsj0sgBiNeN41UqHM+/3Tk6GoAUKjb5NthsM4=;
 b=xQbuF1axS2tVqjmn8i8n9HPhL8tQ0Sg20KUIzfV6S4wnMcrXL9X1QOg8EHhZBam0k3
 bfHm9S0nlPTrWpyJVOAeXbtrxZfR9DEanrl1tGlvIAxbKaUBVMI7kPAB3m+XJpjh8uoj
 I76aL9ZxEi8o7HMkwgocCZv4xCy/FR9DmU35PoIOnedCwiHe6kb2U3GdrCFQCDTYUv6b
 M6OwdHJciMo1yfeMwt+tMNeVNrbfgM6g59qUpmOoiIe5ZSZ3+2RcUyMWlDebGwjg2Zeg
 EGf4sdrxm2i31kntq33tLIRyi0pXkiN5fw1VrNx0LaYsLb+WoXgHvYExnOilm1Bc5oT2
 //Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ5dEheKywy1aowm9g7y74lSW22QIAZFUP+tx6m3Ekdi3Wq1Tc3E8+gxCW3Z71hfbgZEU=@dpdk.org
X-Gm-Message-State: AOJu0Yyr0BLwk/4dDI8apt7BLKJPcz3sE0oK9In5MoqJlVglxrYluNus
 teJnntV9LBm0dKDlsIL+sZ3VRohMJlJsmT6Jenb/o58Ch69rFHBLjV9NlL5aHkhjvr4=
X-Gm-Gg: ASbGnctelpswngCMJdoWvA/u0EINzvHqPiyhEctPTe+IarmZx9LdmXjmKPlthB8HvJL
 ZAJ+dqDZIMbqMrCgHXfY+jgv4iLvRpRmg4WXsBCdFWk1cMy9cAxEuuKSVQB21/uoLGof6nGLfbU
 IaAcwFlaV3c6GDu0/TfUCDRhkgKJS5eAFlX779Go5QUjLHTkwj0srD65i38ECo3zTbf86WnRjgk
 HvQZwQdPubLDWTBERd3RYE5tWTR9ltJQl4vNf/OiGmSI2yefoti8pfh+X3wsqkMSvKcY+RPfyoq
 ZOoTIGfzETZR0aJlHfBzldbdibkvnRetd4NycdjSRh10vnlHH4Sk/zrF2Es+M3QXj6zzhwgnPb3
 nUNLcYogmrdgegDLZUOP0mU2e5AP5E7UAzGcfapi9w8t3mSgFO7YSCADn3i+w0TFFA31YVlvozh
 O2fM7FTiqoqopk
X-Google-Smtp-Source: AGHT+IHmEvrioIh2aaE9Yl7ULmSgUjd+9RzagQDMmCmBSPMuEIf8NLSi2OqN6IuirqM5gv+sGUS9wQ==
X-Received: by 2002:ac8:598d:0:b0:4cd:601e:9d21 with SMTP id
 d75a77b69052e-4e89d26307fmr480200301cf.28.1761570161348; 
 Mon, 27 Oct 2025 06:02:41 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4eba37b96d0sm51104511cf.6.2025.10.27.06.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 06:02:40 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu, luca.vizzarro@arm.com
Subject: [PATCH v10 1/3] dts: allow mbuf fast free to be set with testpmd shell
Date: Mon, 27 Oct 2025 09:02:13 -0400
Message-ID: <20251027130215.95444-2-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251027130215.95444-1-abailey@iol.unh.edu>
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20251027130215.95444-1-abailey@iol.unh.edu>
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

