Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1067FCCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 14:45:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46E5940671;
	Tue, 21 Oct 2025 16:45:50 +0200 (CEST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id 2F5CC400D5
 for <dev@dpdk.org>; Tue, 21 Oct 2025 16:45:48 +0200 (CEST)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-8915bd01244so878374285a.1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 07:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761057947; x=1761662747; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WDqcxbMsj0sgBiNeN41UqHM+/3Tk6GoAUKjb5NthsM4=;
 b=SK9leT86JkcbybXHQoV6N5c4XhERsIp4BCtWq4Wkxi2e8ZS1i0Gl/0Pe9yrvUhSQup
 1HActgZVczm4cUNxpby9yW1IVpyiuo4gJ2lkCx0nkaETCIMuBRFr5XOx3yK28NG7Wwl2
 GCejWP1lFO70dG3NyCPDR/xO4u91ssTrUCYkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761057947; x=1761662747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WDqcxbMsj0sgBiNeN41UqHM+/3Tk6GoAUKjb5NthsM4=;
 b=JNHbMCWG072WqqNmFd9OefQYj9X17x1BiXyR6R0/jyR2KrMjIUT5bxP3oLEEmVwm28
 x/0JFiihaK8OoVlhs6ZLwnmi1EWACCMDvH9kyGQcYIJjGnNXUOvZT/G5FAF6b7pvLMqp
 JLNDtOgxaj/DYyH0gXI/w/E62mDkSe4g3K4odareSMWXC5YptFRh136yVtpKiO6yKqWz
 cbwiuAPXk9e1KBjeabpk2HPJGmRpWRThuy96mHNlAxsGrMaPVER5tlTq6AGz4hZSiJqy
 sdHdG1BInJlrVUcpBO+fycJarUPQuGentu+Pwr/5AMfeXtPm7QADPZekVUivBZY6iWc2
 ITVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMdGy3ajLjr0xUUHOgcrAcF/FSJMOEPost31eNnlRO7pf+RUI0+vPGTH7B1TB7rmd0FEc=@dpdk.org
X-Gm-Message-State: AOJu0Yy76znlS51KB41ET3KZyiiytlB5mbNSgo226XuUe970EmB+lMJh
 FvucU2/bcERnORswmE5d9tvriu6IV1pV4fAenYRGB5FdpOkob/K5OGeTTV5L8UouXRk=
X-Gm-Gg: ASbGncvtWsu9jTmdRkVOHxppcV8bv17WzoegIRvTgQqxdOPIu228PjhOxNFxcs17io+
 ezUtZ0EkjuqbLd/+7dKBx/sd+b+Cc9frAGQojbLCawH59V6JFSH9RCLh6EDxnYlCUbkmJYFxEjR
 mTERwK/XqKI5qda5vING7WXfEMma//un8nGbraPCUK7AUKUK1gM6kmQKBIuswmFRIEwAdJvHQ+Z
 7CJ40s6mhE/BekUoXrOqZM5QeJkG7W81qBPgwuQeLxia4boRDKS32lj4K+MnyQdB7ehlwhCk3DH
 4vXYkLzxJ45VamXB9Nsjgex286oPSci5ixrjAbqVX+EYueTuRrWc/msSMBUfgryPFM28xRLN5gc
 z5C5XfUda3PqqQyhBGOACa6EtGULXJDLCb3hNJNxTcmExSWN0OHX/cciiR/urD4tdBH5qxkip4H
 D7zhptS0myAQLScLtj32H0A9k=
X-Google-Smtp-Source: AGHT+IGMyjFX4QFObz1VHedUjSi4SdFfAhTpZGryH2f7Lss4HQoOs2QVhX4dkpKFwuYKLkpitDwX+Q==
X-Received: by 2002:a05:620a:a1d5:20b0:891:326f:f6e7 with SMTP id
 af79cd13be357-891326ffbafmr1616012085a.76.1761057947227; 
 Tue, 21 Oct 2025 07:45:47 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-891cd57b780sm770350385a.24.2025.10.21.07.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 07:45:46 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Subject: [PATCH v8 1/3] dts: allow mbuf_fast_free to be set with testpmd shell
Date: Tue, 21 Oct 2025 10:45:26 -0400
Message-ID: <20251021144528.39748-2-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251021144528.39748-1-abailey@iol.unh.edu>
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20251021144528.39748-1-abailey@iol.unh.edu>
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

