Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D58CD98D0
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 19:03:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C53D640B9B;
	Thu, 13 Nov 2025 20:03:13 +0100 (CET)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id 2142940151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 20:03:13 +0100 (CET)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-87c13813464so16310316d6.1
 for <dev@dpdk.org>; Thu, 13 Nov 2025 11:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1763060592; x=1763665392; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2bwiiNLQkiXHgjVrc/LL+AE05Jqphl7eqv1GN52Jtfo=;
 b=Itsr6opuXQQgjMiNBI4tgH/yjhQFRrpK44Hz3JWmG5iiIUxLY+/p2mrIrbTE6SEW1h
 Xfd1va9jWn9Hr0XbLFUZOEJSNqD7A0kM8tzDFw94FC21JMXp87i6vRuHG9ybqLF6PhpF
 okdSUHNm0DeQ7d5tt0WRW1FGlgRlzEzCVuGS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763060592; x=1763665392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2bwiiNLQkiXHgjVrc/LL+AE05Jqphl7eqv1GN52Jtfo=;
 b=P7WQqalerwTLKE9Yh8fyTjEQLDxf2Qfk/zrBKsNbCG8EHIqgjs5M9phOthuNLH82k8
 /RghliNiZ9pg10f6nW3h+OYP6op/sKtNr87v+jbTtI6YXG+Brr+XFoiJTKv4NHXpd15w
 ohYhBGCBTvzj1PUok12L0f6oWIL8gPzmOedAWLTfvBrgcz/sFV4E/Uhz7WPZvMcTMjDr
 X/P+Wwp9fWr9NyBcebXuGDO0XbQDiGtb9UHNt/aE/xazS3wd2Q6sZxBAR5wGP0tUXiD2
 rZOfKcmOWAxvFYcG7PrU182hWOQcgQk0ZIhXcxc/QJ4+FzdOPeaJURFNQy0NjkZgLVCW
 0azg==
X-Gm-Message-State: AOJu0YxCym7jxVEaOi+9Ud+0NvPprYmpze1JkSGwoNEacubURiaow2iH
 kYLM3Gi7Dm/jtSf/262/pOGamzqu7MysjdR6PjpMYEXPBDRSJ3ht/W6taPaLJ7Vd0CU=
X-Gm-Gg: ASbGncsGbu4nshzmkGd8On8Eulc1vFCeKlUZsc6yISEJIA3jC3so2qaWLNS+Q+Jfjzr
 EXHjdvN5dK0wnJtczmkuOEPWY8yDTc4tCAZphbia27OUO1EG5yowWpon/6Ngr95FZynPut7Fhb5
 xdUuP2x3ivxAtrHaF/517I5M8+YohftsAHoMM1vAA+QPal6FmdA+Y4tNNXQSJef8a30GsgU8Kox
 MUuZEnwqOPbySf8d2LRR59UGUsu4xGFTGGWz+dyB6BKU8DPzGt/S8b93PExkKtkRdw5Dt0PMmoc
 ydZFWYA5KUjYghXw5ksfpRn7366LFLLlQXwTigetNDT0pyDeQfMCTZYt43XokP0GP0mrnAYajyB
 hVx9YtrH9OWuoOQfuyZPth9OIAQGdqTYY1bD3vd8/yvH37dwhctPnca2ECcVN7uPb1ac5kmkfwc
 p7mJwbbTO4oAdTvg==
X-Google-Smtp-Source: AGHT+IFShH4kLgQETzoVN5ZxB6pFKOxviSWqU6y4ve756oRfvl05it9DXH2loiNWb/XXyoF4M8LNDA==
X-Received: by 2002:ad4:4eac:0:b0:882:5e6e:9cd3 with SMTP id
 6a1803df08f44-882926cbae1mr2963586d6.60.1763060591890; 
 Thu, 13 Nov 2025 11:03:11 -0800 (PST)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1210::202])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-882865d3e25sm17248076d6.61.2025.11.13.11.03.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 11:03:11 -0800 (PST)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v4 1/2] dts: add QinQ strip and VLAN extend to testpmd shell
Date: Thu, 13 Nov 2025 14:03:08 -0500
Message-ID: <20251113190309.310821-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024181606.604135-2-dmarx@iol.unh.edu>
References: <20251024181606.604135-2-dmarx@iol.unh.edu>
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

