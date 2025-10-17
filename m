Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E40CCD199
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 20:32:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C43642759;
	Fri, 17 Oct 2025 22:32:05 +0200 (CEST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id AC0EE400D7
 for <dev@dpdk.org>; Fri, 17 Oct 2025 22:32:03 +0200 (CEST)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-87c167c0389so35484106d6.3
 for <dev@dpdk.org>; Fri, 17 Oct 2025 13:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1760733123; x=1761337923; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MhV+QpD4m8p9uAzvLm7m35XVNep3szOVzw+9xYXgapE=;
 b=cPRXMg8HZnZevBgLHe1Js5G8kyjDGbpFslmUK75e/R37OFJOGFbsjLvelAgYfcRm6T
 KIuLH0Nf4+QN1Z37VKg/HpnYu/xnezGBUKP57PW161OFowrCG8bTbxXNfLiSutdMZlyj
 wCs4oLf0hz6TJIPELNtVMA5+Q+pUN27zW5qas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760733123; x=1761337923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MhV+QpD4m8p9uAzvLm7m35XVNep3szOVzw+9xYXgapE=;
 b=d9ggdrI4WKwvgapyRv72RWSl3T3igP7jfW3VV0ypwOkT717YXllM3QBwccRoyS3IBR
 2f7HGJU4XwZZ+xQRxs2AYbQKTpJmrSMVZSbA88+GOEQ1xzAcXFNyYenJWvdEf93NRFD4
 PRvJYmGlDFcEdC+6yhj9XkGeKN6iOqHj5YuS7fIINPeXwaPv+2pxNL0BsiFNpCmOv7VH
 JKnrb+nEfu4cbnpA0/LSvPDZD++z+1OMY+08Cl0S/dmUzTbtU6RmsOKe/yTNocKaxElF
 AeEcaz7soQmlvoG7b/Obxbxuwqr3s4X0CYPJtotFxFVgp0dBDWCXFdfDK7W2lvQy+2aT
 ebdg==
X-Gm-Message-State: AOJu0YwXBFizE34D35bsY5nB9SXSbgMcHvBZ7v72SOmrX8HqBrE9vHye
 FueXS23/nf38oEIPjTlB8bmz5XYp9BDw/VfiQ4gg/wvvdkSYQbNed7f2F9dInTipThA=
X-Gm-Gg: ASbGnctKaC8/fWInTZ6+wJtVXOYGcHUXRoEAkexGoLjfp7ugyMNfXWsMRcOkCk/1b3p
 +HwGcVYWvjhbDX1wZbEpb0t9/kMK40d61TDk2dRqXyjIW9M3XZ4A2I3VS3s8bZKp27L2Yb0RM3F
 /e7lGr92l6K77pziI4KrhVqZAI4UrkeWqmcgl3yLvZsAB4/25kRgBgaFJOHwutsM3gKvzQUKZB6
 4NcHSOMUtLi8dy9vWmo13WAA581VEc4JfvchK0xqXPDrciMovK69UBxucZJeShxNoKzHzH3Fxiz
 iU2gcVKvHnRbDon3a1HB/GwaJoVsVcgdh0yn+CA6suHCafRWfwpiDPhJxckd0v/fUlBWPDFyE3s
 pQh23x+TUA2pQ4SOL5F5mGwifK/Yo1qHkxiPRYnadw+IvFBFWn3UfXmBz5efHbEpZ0wZpqDeV1h
 jpcA==
X-Google-Smtp-Source: AGHT+IFAfFTA6QAH1sXiFSPCgbbz4kagbWY6sPrSqkehyqrlMFzqLyJt0LV8hwwX/5p4YedJb2H7FQ==
X-Received: by 2002:ac8:5f91:0:b0:4e8:91bb:2636 with SMTP id
 d75a77b69052e-4e89d3712cfmr68950081cf.52.1760733122954; 
 Fri, 17 Oct 2025 13:32:02 -0700 (PDT)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1210::27b])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e8aaf34307sm5294531cf.1.2025.10.17.13.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 13:32:01 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v2 1/2] dts: add QinQ strip and VLAN extend to testpmd shell
Date: Fri, 17 Oct 2025 16:31:58 -0400
Message-ID: <20251017203159.557830-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250717205718.108826-1-dmarx@iol.unh.edu>
References: <20250717205718.108826-1-dmarx@iol.unh.edu>
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
 dts/api/testpmd/__init__.py | 52 +++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
index a060ab5639..1c5b1d58b3 100644
--- a/dts/api/testpmd/__init__.py
+++ b/dts/api/testpmd/__init__.py
@@ -733,6 +733,58 @@ def set_vlan_filter(self, port: int, enable: bool, verify: bool = True) -> None:
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
+                    f"Failed to {"enable" if enable else "disable"}"
+                    f"QinQ strip on port {port}: \n{qinq_cmd_output}"
+                )
+                raise InteractiveCommandExecutionError(
+                    f"Failed to {"enable" if enable else "disable"} QinQ strip on port {port}"
+                )
+
     def set_mac_address(self, port: int, mac_address: str, verify: bool = True) -> None:
         """Set port's MAC address.
 
-- 
2.51.0

