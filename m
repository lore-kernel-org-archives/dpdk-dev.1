Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A719CCE9D66
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 15:39:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 368F340BA4;
	Tue,  6 Jan 2026 16:39:05 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id C350840A79
 for <dev@dpdk.org>; Tue,  6 Jan 2026 16:39:00 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so9163005e9.3
 for <dev@dpdk.org>; Tue, 06 Jan 2026 07:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1767713940; x=1768318740; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gfhAPmTQ6Zj8G6RmvTQ1QcrHj1Z/grbgzffoGIVCHqQ=;
 b=Qy2DboHsZCGgT40rN98b/sYh9Ckh3aUT2Iu7ev5hZoipZgJ67hvN11f3iKgbzhe1GJ
 65Z8TaUOsj4D7awWkTWbInN3EIw1UADDt4V1b26QOrgaY3fJROMNvDudBeFQIEr0NdKV
 50qp8GoSF739dnGE1+I1IaCVyk6ivLU/XuGsL2FA98ah1F3nkeWySpgPL0l5y6epR0YH
 f/sqceXIZ0I46waRmEaJr+YH0OkGSkkIPY2KxbY/CZsyEs4yjaDmYacjnb+N2plMtqLP
 8uwYftEuQOQPkUggq15t4H16ohzT/lIW1XptcHKRvwzWXSPtCqWtEH355XGx8FbNDe2U
 MiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767713940; x=1768318740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gfhAPmTQ6Zj8G6RmvTQ1QcrHj1Z/grbgzffoGIVCHqQ=;
 b=XMTZxlmlTDiaXZDTg+jb/Do5dzrSXsU6o19DcPLMLL0dsidXkI8rMET4odvQ2BFXki
 obBTmaj/s+1dxIZ/qP18Um272sp3onmw1FF6TAjslAv2994sa518aPftPkiJdLDzLYsc
 a6RuWboqurSs+y5v+yLexslygPTGnzty1RG64heVIzmrtueNif6zT5aXr6aUoVRncNgB
 3vSsyR5k/hIeDu04OA84WGWPTJL69yvlbvB1gK8X5UaCu4f5iyFhUZk6Z5iXIPU4lQBn
 aMiPKVfbE1hDXSJsXhdAgt5EoEfnAZuwCYrg3tq3H1IEB9SglGpvJ6HwdTCmPR3tZN9T
 ftpg==
X-Gm-Message-State: AOJu0Yzmb0SrW7rPvxTlD0A8kLLkXRJ8AfOdR+ia0Lw5Mvfm0t+7gdvG
 lwsWEThMkwAg3Wn46ZvA0afRajJzr/NxHB6BcjYLCZxlm+Wgx3TOdbkLEqvymm2L7rvb7PCJkco
 e/t4m
X-Gm-Gg: AY/fxX6j7/+XYPT81fRnkh1wx5tVoWIRfnyVRzz4lklc3slHtsjLiCPsWKzUhK+y5/i
 srSFtAuxeoovOsVKVWTPXhVYzghch08qt9NWXnFUvG/DgSD1ZXfLq+skVx1pfwmddLXffbSusym
 hhgptJxv2U0HY1PuoTp1XtqJX+vB7fLMTkdrJonYFw62tQPodpt5It+5H3DaQnwmjmtn3NL8I3j
 9yUj1+q6mkRYwqhD71yfIeHBBze4ysibnJkhbutBFNe1+1Ieiq/EMoiOMEmZkV6ETWmQr5qBlVS
 YNBzodE5Ed4egAQ61/vANx2vqXNhRG+zacHzTOivMS261wuKIljBu2jQeYP2OYzaWXZhZrwaaMF
 HhnHhaw1VwdosVXP88G4E02hgznpUWqxcubcFKKlrRF7Opqr8sQRfL0UvUXzFsvJyckM+q+b+iu
 ioUG+VdNcs2bsdMa+KcHzNgFQuyGwKTlvzTOQeDlU9RyLPKw==
X-Google-Smtp-Source: AGHT+IF0YmkgFruxfwQHN+xsETS6QWU0aD6vCaVWIFOQSBh7zlZjjoQuoCDb5Z++FEq2PhWodsCKxg==
X-Received: by 2002:a05:600c:8b70:b0:477:63db:c718 with SMTP id
 5b1f17b1804b1-47d7f0761edmr39968295e9.16.1767713940213; 
 Tue, 06 Jan 2026 07:39:00 -0800 (PST)
Received: from claret.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7fad882asm20975265e9.1.2026.01.06.07.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 07:38:59 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v2 6/7] dts: fix invalid f-string syntax in testpmd API
Date: Tue,  6 Jan 2026 16:38:36 +0100
Message-ID: <20260106153838.398033-7-sismis@dyna-nic.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260106153838.398033-1-sismis@dyna-nic.com>
References: <20260106153838.398033-1-sismis@dyna-nic.com>
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

Fix Python syntax errors in f-strings that used nested quotes
incorrectly. The pattern f'{foo['bar']}' is invalid Python 3.11
syntax and breaks Sphinx autodoc during documentation builds.

Use f"{foo['bar']}" with outer double quotes instead.

Signed-off-by: Lukas Sismis <sismis@dyna-nic.com>
---
 dts/api/testpmd/__init__.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
index a20dedc25a..703cae487e 100644
--- a/dts/api/testpmd/__init__.py
+++ b/dts/api/testpmd/__init__.py
@@ -227,7 +227,7 @@ def start_tx_first(self, burst_num: int, verify: bool = True) -> None:
             InteractiveCommandExecutionError: If `verify` is :data:`True` and forwarding fails to
                 start or ports fail to come up.
         """
-        self.send_command(f"start tx_first {burst_num if burst_num is not None else ""}")
+        self.send_command(f"start tx_first {burst_num if burst_num is not None else ''}")
         if verify:
             # If forwarding was already started, sending "start" again should tell us
             start_cmd_output = self.send_command("start")
@@ -898,11 +898,11 @@ def set_qinq_strip(self, port: int, enable: bool, verify: bool = True) -> None:
             vlan_settings = self.show_port_info(port_id=port).vlan_offload
             if enable ^ (vlan_settings is not None and VLANOffloadFlag.QINQ_STRIP in vlan_settings):
                 self._logger.debug(
-                    f"Failed to {"enable" if enable else "disable"}"
+                    f"Failed to {'enable' if enable else 'disable'}"
                     f"QinQ strip on port {port}: \n{qinq_cmd_output}"
                 )
                 raise InteractiveCommandExecutionError(
-                    f"Failed to {"enable" if enable else "disable"} QinQ strip on port {port}"
+                    f"Failed to {'enable' if enable else 'disable'} QinQ strip on port {port}"
                 )
 
     def set_mac_address(self, port: int, mac_address: str, verify: bool = True) -> None:
@@ -1535,7 +1535,7 @@ def set_port_mbuf_fast_free(
             InteractiveCommandExecutionError: If mbuf_fast_free could not be set successfully.
         """
         mbuf_output = self.send_command(
-            f"port config {port_id} tx_offload mbuf_fast_free {"on" if on else "off"}"
+            f"port config {port_id} tx_offload mbuf_fast_free {'on' if on else 'off'}"
         )
 
         if verify and "Error" in mbuf_output:
-- 
2.43.7

