Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E05CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 21:50:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D3A24026D;
	Fri,  7 Nov 2025 22:50:25 +0100 (CET)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id 1C2A340261
 for <dev@dpdk.org>; Fri,  7 Nov 2025 22:50:24 +0100 (CET)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-8b1e54aefc5so103392285a.1
 for <dev@dpdk.org>; Fri, 07 Nov 2025 13:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762552223; x=1763157023; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ngXiy4tRWPituDT/69rgtwWLqP4E+y01wBEGKeH2O08=;
 b=JbYntSiWZOUZEMSmq1cXD6/fWquSAf4n2bAgLU4jk/L8sbwYneKFRGvgJiKhRODg5d
 uVKeUoSyk/5D0h6CGEmjrU8lkQrx2hrOwthA0Jdj1/y8sfhqZfjRWNtTp9RQhet8krjM
 MP7WKYjvhTjHCkfusF0Qd2Gh4PDXcRvsj+yD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762552223; x=1763157023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ngXiy4tRWPituDT/69rgtwWLqP4E+y01wBEGKeH2O08=;
 b=QNP5qSSFvXJ5PsWERp14e421AgOFCg1/UskJJXOuBk3wJbHJhnymb9FV94YWjT3EPN
 PtdytnT3c7hMzDFoPCMkNSWkA22WE3SPSY2inwPcKWI899YdCug7jW+epEs5r772K3yy
 KlN9DG179mJpw8NPFGJ83/g+aydOfElez+ycce/pbvxkh/sTRNxzLVudelZyG2cX54r+
 b5n10NbJAeZ+G0Tw+nB7FrQC3tadUtao4ZsnlSPzRHqdP0elEAl8lXSh7yF69+lXCP9H
 e9+saSWaYBoS8chvDjGdez0XHnNlhz7AuHK5XQOX+ii8dG9g/WRtYRiJ+LIKlqNdoJRz
 2u9Q==
X-Gm-Message-State: AOJu0Yynn5HNldbltIRMMl/8Aa2o4tUAWrE/Nc5Qo1kD9WwZPxQOGis9
 Hof90P+rLwW/mNN0ZSXyICDHqDWWcNTidzQ+ri0hwiQ9XPUKNvKUWcC7kzfb2/QH+Wo=
X-Gm-Gg: ASbGnctmxUXAAdmNYpw4CBahMw5tLDit82/eApfyp6pXnxjX3B4gGv1/TrtaMIxba9g
 b/HTypGY2QoZdgNnU9rShsiG5tHmqCbosW1UtWGRB0funJTxtIWpQHbk8JIW8vXgm+1y5tW3X7C
 5wNeU/+G0htfOu+HTr5+lgAocUkheeTF2k4gkLl83A/LxZH/xr4EH01bmzwt1pa5e0zuQROtD9u
 ZaN3vacwzG2gFUUq4wCoFV+UlZwIWqesTaH4NictWYrXxUhBNJtS+LvsB3xJGQoSIwWGKjT4bj6
 n90/WVSJnAukIsUohY7uglPL4OOLOkWuMyexvklK3yQBUXA0OaKKXjteXGwcEfniUFJ9qHrKr5o
 rgdtBkOPQSDPKmn8k80AI13uEqQOiBRIdMUpZe8khuIQmY0oag1U6wa+YMI6VWkF9cdzScxXnAX
 h1xXw=
X-Google-Smtp-Source: AGHT+IGOMlsiCPWeEuwSXVaaQQN51ipyj9KZvN3I2trlOfcrk6WndEmZPD85zrM8L3IEMQmzyQopTA==
X-Received: by 2002:a05:620a:17a2:b0:892:7dd2:9f14 with SMTP id
 af79cd13be357-8b257f0b421mr107412285a.25.1762552223146; 
 Fri, 07 Nov 2025 13:50:23 -0800 (PST)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1210::202])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b23580c7f9sm496607085a.44.2025.11.07.13.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 13:50:21 -0800 (PST)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v5 1/4] dts: add start Tx first method to testpmd shell
Date: Fri,  7 Nov 2025 16:50:15 -0500
Message-ID: <20251107215020.255182-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024185056.607160-3-dmarx@iol.unh.edu>
References: <20251024185056.607160-3-dmarx@iol.unh.edu>
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
index aadb7f4e70..6d70927660 100644
--- a/dts/api/testpmd/__init__.py
+++ b/dts/api/testpmd/__init__.py
@@ -204,6 +204,27 @@ def start(self, verify: bool = True) -> None:
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

