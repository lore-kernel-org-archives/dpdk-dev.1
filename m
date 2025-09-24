Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF48CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 16:47:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6296140A6B;
	Wed, 24 Sep 2025 18:47:40 +0200 (CEST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id AAEE94067E
 for <dev@dpdk.org>; Wed, 24 Sep 2025 18:47:36 +0200 (CEST)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-84d0bdc64abso10151585a.3
 for <dev@dpdk.org>; Wed, 24 Sep 2025 09:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1758732456; x=1759337256; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QMbaFb80NC3ehX6xGBkEjy3LZ8m4YQBTVPHh/jCZkSs=;
 b=TIVhvcKS/aIeZWXe/sFFlnAnLGRJXhuwF9pHPb0Otzke1OAnV5uohE/fCaHYtHZdNk
 iIB2DtNe+PqXUFvcdHfzWhkRYb8qajznqSgAEipegj5o+WQjcmb9oJ8SC3lvUSCJdHsV
 3Mzm2LjfHRA0Ez1S5eBWUia1c5OClIy1A37gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758732456; x=1759337256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QMbaFb80NC3ehX6xGBkEjy3LZ8m4YQBTVPHh/jCZkSs=;
 b=rK2Aet0JdkkOlNwFd2gBYQaCAjpi/lVRmHRxAUiPIumyCkiZuk+LQqpnK8Xtn/QKq4
 vaUmpeQKzroi/7Rr/U52gTOsrRAQA/XKFCzEoZz2wjyHCBo3NFl9Z0Zu16VndJwisaz5
 2fNth2F1ONu91VPyOCkd5kK341RaeNr9QwtbMovGGtrKrPI5oiUMI/XtapUUvVZJDiZC
 VYQBhLUGzC7F1IkR/rzXOkpjCavhPpWwE4pWOSHliTZasR81aDM86dHONb+KYXbXAxgg
 G3PeD+18bqYwQoUIcgmpoDE17oQFuXkJg/JnHz30Wo2SgZuTZJ+SYhZHtl3zGcf1tLmI
 avOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJXaAH1054lpSsXjo2hqv433RTRFLgFA4oXqGhGEUr5WCi4oT+b4EyG2zt7uEhLbDxU/k=@dpdk.org
X-Gm-Message-State: AOJu0Yxj5XP5D0fXj4qtUWfr5HAzY8sfAPpqKylIVKoMDDDed+2Jsh2L
 CkRWfeogascjHNZiN++6+piVYgQ5MUoWRct2Ef/DHnnq2UAVqYoYXwTdq+jC6diEgz0=
X-Gm-Gg: ASbGncvXGBDDPBzp/jJn90bwWDh24utXiLbFO7DNK28ElM3NAXWjhs2mlh7O3FcuIRS
 07CkgmnShVli/ObQcmu03hdKR+rGcqcSnUE2zx1QtC6jUUl+nD0O2x3P/LffIbVxIVOBZbGcRXv
 bJycmXljmgVXZ43SvNsRn/mCA/we3bna1Dkp+aKWJfJBpn8Nkb6x/ahD7QkKkJH2h+G4O8Fn9Cp
 SrNvz9YnRgPiEUMBHHPS4MhOKOy+bOzIGUlN8NPCU3m39v8NauJMoJAIUXxWvonf01qJpMI9TL4
 Ln6NzKFV5x2FouAMYXwzRcvmJ8928uBzzNrNtxZ8vLjlNweGxJ2zas6k+lbV8aKrkptaXIcqe60
 WK87m8/haPJibGhySMU1A5eft97FnI7fSdng=
X-Google-Smtp-Source: AGHT+IE1cSgNsyo7GN/9EPkp/KVkpOwag7zJoxjlewNnOpnH0M3JJLA6FG4E10smdtWHI7rnwhCHhA==
X-Received: by 2002:a05:6214:1c0c:b0:795:3dff:55b4 with SMTP id
 6a1803df08f44-7fc2c8a4f5fmr9938956d6.28.1758732455923; 
 Wed, 24 Sep 2025 09:47:35 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7a4c5785d49sm76849996d6.63.2025.09.24.09.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 09:47:35 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu,
 ivan.malov@arknetworks.am, probb@iol.unh.edu
Subject: [PATCH v4 1/3] dts: allow mbuf_fast_free to be set with testpmd shell
Date: Wed, 24 Sep 2025 12:47:23 -0400
Message-ID: <20250924164725.168773-2-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250924164725.168773-1-abailey@iol.unh.edu>
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20250924164725.168773-1-abailey@iol.unh.edu>
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

