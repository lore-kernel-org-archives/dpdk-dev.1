Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF029CCD199
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 13:26:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 523DA4275C;
	Thu, 16 Oct 2025 15:26:45 +0200 (CEST)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53]) by mails.dpdk.org (Postfix) with ESMTP id 0027440269
 for <dev@dpdk.org>; Thu, 16 Oct 2025 15:26:42 +0200 (CEST)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-879b99b7ca8so12935126d6.0
 for <dev@dpdk.org>; Thu, 16 Oct 2025 06:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1760621202; x=1761226002; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7IFIP7VQUvobNfJFQ2kf0HZe2xoMYqiKztGoQSF8iFE=;
 b=JsvBZcynxqtXH2dkXrnJP0jjlhKhmcHcYXgNsbdMLrT0+TgjsjAmfOBMStUPjTE66J
 WUaOT9x7O/i4mZDxtH3I8mW3SSN/Cw0b/Ucl7ibCIushDqAmInGhcG3t68bXNsjg0b3J
 XYLr0ubhiqBXuO0hJ+ngqsL07uNjWpFUAzwow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760621202; x=1761226002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7IFIP7VQUvobNfJFQ2kf0HZe2xoMYqiKztGoQSF8iFE=;
 b=jpsxR/lC0spBmUuBEyZeLwJsuq7jMP2+TSrR07VkzGSBfNoXKPHYMBmmeK4JFW2IiK
 NDjndCj3ODkW+bWF6r9l0U2+9jQujyCEY56JASeH331VNmC1eXLX6Nf2oZurnY5r2c0x
 AnWyqYaCBRCEUy1xoJsXXbwyrkdItv400wOs+uG2pkEzKkl882fIYdRFD61vhPCmIaAJ
 +qQu5n1M4p+q9dDIqxiYZfllPF42hiXp1INMTUthb7mgIUyC/ga2rXkqxOh9ek+yLi7D
 BIIRRyADjWVlx/yDEPop3eJva1SzFgBdWg0CAxXWY2MnzUcySeNUr8IKyvyl/QRg6Zv9
 a6Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVti9+fjKKtqXPVFND1X16v9yVmGwEOLYgALkPtWm3RrYsk3UyUywyofs5V8qonxIyoVRc=@dpdk.org
X-Gm-Message-State: AOJu0Yw6/DqGDyqUow8ba2FPrru1+BIddTtLVAKMgxlRE51RTHSyU2zd
 8ivS46YuByIP+BxMuwHLfTjwJUVO4DLwtR9kHphUuIs9z2iF3mtLFbNP+BqmphR0wtgixsQF1x5
 qNqh6
X-Gm-Gg: ASbGncukGSoiK1Ya1ilmkHONWkVV6jyFVDKvy8MqRaQ2iDdRQosb+ch40eLWT5knmCk
 LoOGgjtQc9sA1AmIfH4TeY8VGvU1oyWG+GXCn1+D4AYabr5UxWXTNn92WpHgBKqfP2Fe2aCJWSL
 XexfDTRa66IrqKED5fJ5o7pzxLc2PRjPWfmsK8i593vlCBTf8Fa3/ItCNAKQ+mi5a3lEz50W5G2
 uloz1J80M58q7f6Xg2mQXQMG56U91ekHk1WUalUPEbOuMV7Y7G6BQj6GCH6x/YbB9dckQOdwwYF
 4UGa5r+3oG1AtJdKop1tPXUyFJzupmnNX98WqSwaz77ZXbYZ2CC59feJ6yIKj9rN2bEMfNDHnai
 eCwcTnLFVV8huvaky+Ffk6tocEkxuuNTSaAC/L4u1wvYJP9aoIIE9MIHWric0JP9BvF7U8hzayV
 XV7QBFJv30dI7NA3oCAvroeSvkBPI/+vtT965gHiM78enEKvHRZSLFrCw2pBUNCA==
X-Google-Smtp-Source: AGHT+IHqbeXjxkgmq4fFE/tbf6Hok+tecs2KtZGR1YeEEQxDI8hkooEfQBYFOhNDdzl2dMwcZAi19g==
X-Received: by 2002:a05:6214:c8e:b0:875:e7f:ecf9 with SMTP id
 6a1803df08f44-87c207df8f6mr435646d6.32.1760621202110; 
 Thu, 16 Oct 2025 06:26:42 -0700 (PDT)
Received: from d122205.iol.unh.edu (d122205.iol.unh.edu. [132.177.122.205])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e89aedad52sm4015661cf.30.2025.10.16.06.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 06:26:41 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Subject: [PATCH v7 1/3] dts: allow mbuf_fast_free to be set with testpmd shell
Date: Thu, 16 Oct 2025 09:24:19 -0400
Message-ID: <20251016132421.12176-2-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016132421.12176-1-abailey@iol.unh.edu>
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20251016132421.12176-1-abailey@iol.unh.edu>
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

