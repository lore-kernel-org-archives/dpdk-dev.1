Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B252CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 18:16:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFC5B40262;
	Fri, 24 Oct 2025 20:16:10 +0200 (CEST)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by mails.dpdk.org (Postfix) with ESMTP id 7366C40151
 for <dev@dpdk.org>; Fri, 24 Oct 2025 20:16:09 +0200 (CEST)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-4e89e689ec7so14789901cf.2
 for <dev@dpdk.org>; Fri, 24 Oct 2025 11:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761329769; x=1761934569; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MhV+QpD4m8p9uAzvLm7m35XVNep3szOVzw+9xYXgapE=;
 b=ZjrSI5WVYa1FtTcKHfSsQz6eeAJXdNAtB9WkvjMXA5HN9L0RUTc+1aMLOE1Eb35HDv
 U8heanMjl48CGwRAR1J/BuvWcrMYHoLhc7IIveCCcG36IyfR6w5Vf5WYBJ8RVnpIfxg3
 i+VbAdASumhd1hwwEdsDIr/Mwk/+YgQc2dPy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761329769; x=1761934569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MhV+QpD4m8p9uAzvLm7m35XVNep3szOVzw+9xYXgapE=;
 b=f4bpa+F+Z8/gOaQTNjRtG0xwrETyrvsNf0ldHh1aokIJj9DV5ibyygvuk8tBGeLvki
 XF1Hu84xogjlIkpqq2z8DQ8995YRh+75V3+UUEaE8t5c9uHlS2bMh0PnLxHwsrAy0ml5
 mynDisNKe41yAoFI7/NCBpGA2aDy/hQ33SOMBnXPd7ilgc4Vc31jzcw3feu6hwJPKXbW
 KvjzQO/GeMLjMB3+NAdXSTwu+J90PmzzAvO0knl0B7Ej/dCY7f2GfvmpMaEFDaqf1aoO
 VEtoRYG+cRSnjiGcp8QNk78rC2cmR0VsBP+t7Jc26zfpEQ8Yc9RIodP+0bqZ6vvaPxd0
 6mQQ==
X-Gm-Message-State: AOJu0YzF9+PQR1101VJI712CqumUWt5pUJMPS80hojCuj+o3ay2w6BSn
 wGSccwcv/UF/38gLQ83XUJB459aLuMF/7EhiDy7DSGqSTcaQqwnKKDn1loG1sIdR8hA=
X-Gm-Gg: ASbGnctstGt45KiFPYUHk0OiARHUqu/RgpYWNqbXJCKOllt2x0DPtaaLqZu1ohxJn8n
 mbdOgvDHlPoRJs50FqSr/2jdVilBzKZNfbtQYWegL8CROdl5ZJhElrx2Tl84FCflxZxv7DKQju0
 DkN68dNphskCU7a87aB2K2U/5y+zdHmr0wp31mnh4g22MUNf0GHFiuNjiNj/eIsqc9nDmrqCUFC
 BzpTWkZb3YHru4X311njtan6FgPsZKGa4QujQUWYl70KxLjqYMZBkPe0zX+zgBVPLg7h3+wvPXT
 cnAAIpa7kIIb7A3j45PoxbaIYWqyBy7bRho7HwUUoeVScxmzYxIdtTin4Pw3dhbqOPzreaoNZJO
 8x3rmLGqLFeT+g2Ew85zx0DyAbr5mdheYWd19lxnZHAyAOcdZgt4GM4NOVy/tqHfT5cWThmJSiL
 snViQ=
X-Google-Smtp-Source: AGHT+IGbzjHENpFNfTMnBY5WsVOg0f0tutr71y6T9K2uyLD/eu7DGUUY8rvM7IVmCYKnuf+PQPi4GQ==
X-Received: by 2002:a05:622a:138a:b0:4c0:5e82:86d3 with SMTP id
 d75a77b69052e-4e89d20848emr355645551cf.1.1761329768639; 
 Fri, 24 Oct 2025 11:16:08 -0700 (PDT)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1257::100a])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89c116989fesm437569185a.36.2025.10.24.11.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 11:16:08 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v3 1/2] dts: add QinQ strip and VLAN extend to testpmd shell
Date: Fri, 24 Oct 2025 14:16:05 -0400
Message-ID: <20251024181606.604135-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017203159.557830-1-dmarx@iol.unh.edu>
References: <20251017203159.557830-1-dmarx@iol.unh.edu>
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

