Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7F4CE8D4D
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 16:40:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F421440657;
	Fri, 14 Nov 2025 17:40:06 +0100 (CET)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id A807C40151
 for <dev@dpdk.org>; Fri, 14 Nov 2025 17:40:05 +0100 (CET)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-8b26be00d93so218873585a.0
 for <dev@dpdk.org>; Fri, 14 Nov 2025 08:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1763138405; x=1763743205; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2bwiiNLQkiXHgjVrc/LL+AE05Jqphl7eqv1GN52Jtfo=;
 b=D7XHbBDvac9XA5tDbPK8poHxugV+YU3sd8+M8hNR++gihk6qAGY3OR+q1EuSQir7HC
 3+Kz1qVh8UOAPy1wm6EdWT54V6b6DiccMEEZggaoQFO2Iw5DCNcn0RdfvwWkkjxLEXTy
 BHNpWRZuAZETbgCl6G/C+9TOuY0F96Dy/PzZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763138405; x=1763743205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2bwiiNLQkiXHgjVrc/LL+AE05Jqphl7eqv1GN52Jtfo=;
 b=aNl3ruryTNGG4lN+u34OvFtdiB1HoO4BmsGMAi8uDAJhzb4MyZlbvb5KLg67Wo8FKb
 ztXBfPFk7enT5WhQaDDrl/L6+fmFuFXEmmTkyq+eJaIi9Xjq1AqQaK5IP+6Xtk6lEbgY
 8RUPQF0VmgSXHR9SNOcodTfWqOs9dm1sNDb4c2xe/NoNTtaoEL1/jMlfIvWUMeDCywjr
 RjEwJR/Gq6rBilGspQZy8xkAdJRuPwEGDkbVem2Z70LV3MBtB3Zsy7fiWkAFs1hSoRjb
 JOjzbUzAs2PdOlw5GYs2K5m2l5sgwstyR9WJ3zzQkzvyTpDb/esmlcQ0luiqT1nMYr/a
 taIQ==
X-Gm-Message-State: AOJu0Yw2g1Z2jRQBF0ceQ7fezS8TR33ht+PO1Mqwqt6tTSALGBq12lmb
 nf8TBuY1l0dpFh83FnxneJGXT467MDHKk7PjFz/hVf+81TyjB5TXe2RvJZnBDYhx/x8=
X-Gm-Gg: ASbGncug3YCtQ5bstEdcV+/c7C0ngQOfPWCS5rvajdXU/trQeiKIV6+a7Spp+r68+fi
 w8g6rp3kBW5maJw2cXPYwaDIdJnqtUbqNY9Pn++kYWs8a2QEJ3DiO+//Im1rkv9ye7LhnTGZ1+J
 EixbGqYKRbV81uwwFoKnWvujqln3XQxGVKvDwFOpqw49TbNpMB+m/D2EgyfWHJQVJRrpRS1fKNA
 1glF9eFexyHOWxLkSg5yiHO8rQJNLLDfT0xaK/UQela2X8IlEmXFJxQAzExvT2ect+Y6IIRxjAA
 ytMttXaOP4zPpyST0n0ipzvKtcXrDwEV+p3B17U3T+2DXMYw7Ott3fMfq2PqwC6ZkchuD5UeciC
 lYCggc+zvLwl37VO2MzsSnbUUGiioGVV6loLbfxheeFNVNSurgXFbaS2nQhOBVvIL5NyVsGfb0e
 FhwqE74wzmiEg3171AqmhSIPb5
X-Google-Smtp-Source: AGHT+IGPMcC4Fe57ZNcF6BmmuM503TNmnPE/l8N8+1SWu5QkVyho3qJ7otlgWkLC4P1Q+RYCqAwpWw==
X-Received: by 2002:a05:620a:414e:b0:8aa:f08:bed0 with SMTP id
 af79cd13be357-8b2c31e8b53mr462749185a.79.1763138404882; 
 Fri, 14 Nov 2025 08:40:04 -0800 (PST)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1210::202])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2aee9e9f0sm365867585a.3.2025.11.14.08.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 08:40:04 -0800 (PST)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v5 1/2] dts: add QinQ strip and VLAN extend to testpmd shell
Date: Fri, 14 Nov 2025 11:40:02 -0500
Message-ID: <20251114164003.327455-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251113190309.310821-2-dmarx@iol.unh.edu>
References: <20251113190309.310821-2-dmarx@iol.unh.edu>
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
index 893479fa73..a20dedc25a 100644
--- a/dts/api/testpmd/__init__.py
+++ b/dts/api/testpmd/__init__.py
@@ -853,6 +853,58 @@ def set_vlan_filter(self, port: int, enable: bool, verify: bool = True) -> None:
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

