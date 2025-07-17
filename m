Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2D7C83F1A
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 20:57:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 418004026D;
	Thu, 17 Jul 2025 22:57:23 +0200 (CEST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id 51A384014F
 for <dev@dpdk.org>; Thu, 17 Jul 2025 22:57:21 +0200 (CEST)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-7e344e0212eso165492785a.0
 for <dev@dpdk.org>; Thu, 17 Jul 2025 13:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752785840; x=1753390640; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tVPngXrESHrc9RcmhzGyBeyivXN+RhKymM1EpYOFlVs=;
 b=MgFYxs5H+B5GN9EoPbp+lr9aOiKcNcTqT/wPoDGQ6zCd7N/gD0IraQNAFbeZrhFfHR
 0cKXBXU8ALLg9/+P4kaAg0kaCRbV4RynSf6yE4j0hp5GXWZVQhBemoRPdj8mwCzIFKxA
 7gdWfts2Kp5RsSXtgtfdBsrjWaZLt5grIUzoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752785840; x=1753390640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tVPngXrESHrc9RcmhzGyBeyivXN+RhKymM1EpYOFlVs=;
 b=ZuDcqJL0Kfou3eqBoWQLZE/F6BkE5nsCg7YIVRMxH91WFnmeUQT5ASQcKcjHgSAvEf
 WFwQifXMkxaGyAR+4Rv0Joroek95uLEoT5FQlSFPe0Zj2d/8BDr1mG/FAjZaq3unrDAC
 FBg59mkoNfVB/V0CtD5xkKkk8Y1MQy1MF5EqI3IXpnqY5KFgYZH2mcx8eLM01S6XaZVY
 hKE3652qGmRFgvaWGKFvXOxqh/k9K6R56hpKE6JHDJgYXczriSn1kxSL3ojlO4xZ6gwu
 1PzWrrcHqZKBKrYyabkRRVYc1v/p1ndnSAL0/+5TWlfFgenNQ3Cxn0tWula3SiB24NF6
 q9Iw==
X-Gm-Message-State: AOJu0YykRYROLAXMTflAPyhlF4ociQ1L9pITRRUwAa7y3NreNKA+fJNU
 mvkloAnyI2K+rmZ5x8swVA7rEKt0pEXA7RlNvbNBnKNuqWWGFsQraL1Sq16a6bcRUfPoYepRbdw
 K9ZRS
X-Gm-Gg: ASbGncvXFe434olcZ1igZEJ75Q3LdPE+mRgyp1C6i0O6rlCKRrTs7n0//YR5IJxlGpI
 mMtUabEy481hOTccvQKxA2tqzwW51LDzJdG2dgVKAPQmJ5BRFkk80DTgELLmwUDexzHbr/nvdrO
 YFkJZ1ll4VUH6jM6gVQRocMtnVrOtIT2yJa08afGHnnawIRg19OvJStZPga8Lr6AYbS1FO2C3uq
 jmnOI9RvkSC+P0NvqW5j+qNZzRAdU21ToMPpSWdnUSQ0na2RP5br0YNrlN8D8fP8WWtIT4wVZgV
 pRUyvBsGs3UBF6zh8f3+zoCQxxCYYZGgiaLPXXt5YZQiTdpK/FSa3GvKWqliO5cexWX10M4GDwB
 D4fTEfZt1LTBUp9pXBtL6vY6XrpR3DgZRKmvUrq/fVpByQUVe7RDM
X-Google-Smtp-Source: AGHT+IG1IIQ220Jte2TkX+Nd+SYCBnzwlCKU7FCgSJolKYzhqBav5P3GPKEAay206eErE2AqQl7yxw==
X-Received: by 2002:ae9:e50b:0:b0:7dc:86f1:ee1a with SMTP id
 af79cd13be357-7e34d1385b5mr512426485a.11.1752785840512; 
 Thu, 17 Jul 2025 13:57:20 -0700 (PDT)
Received: from fedora.iol.unh.edu ([132.177.125.198])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356b28a7esm11370285a.19.2025.07.17.13.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 13:57:19 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v1 1/2] dts: add qinq strip and VLAN extend to testpmd shell
Date: Thu, 17 Jul 2025 16:57:17 -0400
Message-ID: <20250717205718.108826-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250605184143.498892-2-dmarx@iol.unh.edu>
References: <20250605184143.498892-2-dmarx@iol.unh.edu>
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
index ad8cb273dc..6caa6b2772 100644
--- a/dts/framework/remote_session/testpmd_shell.py
+++ b/dts/framework/remote_session/testpmd_shell.py
@@ -2112,6 +2112,58 @@ def set_vlan_filter(self, port: int, enable: bool, verify: bool = True) -> None:
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
2.50.1

