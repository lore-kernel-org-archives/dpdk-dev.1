Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD4DC5AE59
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 18:41:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03BC840608;
	Thu,  5 Jun 2025 20:41:50 +0200 (CEST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id 5AA29400EF
 for <dev@dpdk.org>; Thu,  5 Jun 2025 20:41:48 +0200 (CEST)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-7d0a0bcd3f3so155765085a.1
 for <dev@dpdk.org>; Thu, 05 Jun 2025 11:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1749148908; x=1749753708; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PgwPRMvQMuS9W3JsWXQ5sz7iOpfg5xoiP3QUwu09zEs=;
 b=KXuk1g1EHMqrxgR22aUjX8RDGuY3EGaDlWzdl0xzLsc8RNmOxOtGSakaW88DsBjtOB
 QQyg2dKsTXbQlAyIMH3N4fmHbZxODTIhAS2kduSUnOV8kl1jPbtiuzH3j1YOaSuB8ift
 VjTjheOtOVhUerej+2T5IvCBJxfCoG/J4qxB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749148908; x=1749753708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PgwPRMvQMuS9W3JsWXQ5sz7iOpfg5xoiP3QUwu09zEs=;
 b=xRpP8ZhlS/5LKyRTSGDCeOWl1W4SrRu8FDfWA5NE5P6tDEMG7trg7Xpa/Hhf7Rj8Lh
 8wWzIUUDIVzSEmZ7uyxCttGzUrYpzZoVYjVsl+UiMmKOYivkRGswnJuiE5KO7fyo9EmZ
 2NNz86eRSBPgK+HAg9fcU/fne/m0/2AfjOozH6pGu9rluHh0oKDFrg4DUAtYxjEF2lk6
 OOR3LjIl4KxyK9JIFD0TUHTmepPgEWTw9Q0AWtShRrWLfLiY+0GOfP73anw6rSQKplUF
 f/JHB3RN7rjl3JKjTOL+34Op5Bi6iTu9BitvJYOKRHGXd5qTJ11qbk6XgPDsOnJ8MTKg
 PrEQ==
X-Gm-Message-State: AOJu0YyaJtGWbR0F9WLBZeJNFZecAIFXAOhC7Rha/HLVcqkY0G4KTp7c
 iL4papvngqmd831WRskIngBIMC4QObfpmxOZ09UI9zpsQxF+YoDmr7OtIwY8DsS9oR0=
X-Gm-Gg: ASbGncsIpK0fYYFcm6VRdn7baeKlGn4NbiCZwJI1iBNrgxdGJX7HCb6b1pAjCr/9zNH
 ublFhrE6/9EiqWiAWuHvsWv6Xvd1s/fLhUoubduJUY80eQbUYbWyobb43f4/Tcw7JdNMAzZnOd1
 RfM9HDoA5Q0IlTFX2cGgqoqFCEi9/KsWxAuX8ndqSZeJ7rZ0EAk5QuO3C1RoeVl1EWMFpWe3AFZ
 gYmNY+t0Yc5pJ04nNb1pUteI9enljOhFDycjUns0VHnuWttCkqx2eiMAzC48e8ip0QvswUv1tZr
 MB3g7mTTi4jECJN7H3mBtmBX/gYV9uXLdIKbL2o5ZJ0sVwU+rGqwgQ==
X-Google-Smtp-Source: AGHT+IHdjShCWkBmavrpgO6PIqTD1/EW9D6+FLIMTRS56MP2FjzfhMTLdvmaYASy4MZlgsZxEiqRyg==
X-Received: by 2002:a05:620a:4387:b0:7ce:eae9:43a with SMTP id
 af79cd13be357-7d2224239a2mr659150785a.19.1749148907693; 
 Thu, 05 Jun 2025 11:41:47 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1257::100a])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d250f64b8bsm3865385a.8.2025.06.05.11.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 11:41:47 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [RFC PATCH 1/2] dts: add qinq strip and VLAN extend to testpmd shell
Date: Thu,  5 Jun 2025 14:41:42 -0400
Message-ID: <20250605184143.498892-2-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605184143.498892-1-dmarx@iol.unh.edu>
References: <20250605184143.498892-1-dmarx@iol.unh.edu>
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

Add QinQ strip and VLAN extend methods to TestPmdShell class.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/framework/remote_session/testpmd_shell.py | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
index ac99bd09ef..aaab267a54 100644
--- a/dts/framework/remote_session/testpmd_shell.py
+++ b/dts/framework/remote_session/testpmd_shell.py
@@ -2099,6 +2099,58 @@ def set_vlan_filter(self, port: int, enable: bool, verify: bool = True) -> None:
                     filter on port {port}"""
                 )
 
+    def set_vlan_extend(self, port: int, enable: bool, verify: bool = True) -> None:
+        """Set vlan extend.
+
+        Args:
+            port: The port number to enable VLAN extend on.
+            enable: Enable extend on `port` if :data:`True`, otherwise disable it.
+            verify: If :data:`True`, the output of the command and show port info
+                is scanned to verify that vlan extend was set successfully.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True` and extend
+                fails to update.
+        """
+        extend_cmd_output = self.send_command(f"vlan set extend {'on' if enable else 'off'} {port}")
+        if verify:
+            vlan_settings = self.show_port_info(port_id=port).vlan_offload
+            if enable ^ (vlan_settings is not None and VLANOffloadFlag.EXTEND in vlan_settings):
+                self._logger.debug(
+                    f"""Failed to {"enable" if enable else "disable"}
+                                   extend on port {port}: \n{extend_cmd_output}"""
+                )
+                raise InteractiveCommandExecutionError(
+                    f"""Failed to {"enable" if enable else "disable"} extend on port {port}"""
+                )
+
+    def set_qinq_strip(self, port: int, enable: bool, verify: bool = True) -> None:
+        """Set QinQ strip.
+
+        Args:
+            port: The port number to enable QinQ strip on.
+            enable: Enable stripping on `port` if :data:`True`, otherwise disable it.
+            verify: If :data:`True`, the output of the command and show port info
+                is scanned to verify that QinQ strip was set successfully.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True` and QinQ strip
+                fails to update.
+        """
+        qinq_cmd_output = self.send_command(
+            f"vlan set qinq_strip {'on' if enable else 'off'} {port}"
+        )
+        if verify:
+            vlan_settings = self.show_port_info(port_id=port).vlan_offload
+            if enable ^ (vlan_settings is not None and VLANOffloadFlag.QINQ_STRIP in vlan_settings):
+                self._logger.debug(
+                    f"""Failed to {"enable" if enable else "disable"}
+                                   QinQ strip on port {port}: \n{qinq_cmd_output}"""
+                )
+                raise InteractiveCommandExecutionError(
+                    f"""Failed to {"enable" if enable else "disable"} QinQ strip on port {port}"""
+                )
+
     def set_mac_address(self, port: int, mac_address: str, verify: bool = True) -> None:
         """Set port's MAC address.
 
-- 
2.49.0

