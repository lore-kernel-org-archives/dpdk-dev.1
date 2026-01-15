Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A431D46634
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 23:02:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 045AE42DBE;
	Fri, 16 Jan 2026 00:01:47 +0100 (CET)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id 47AD542DB1
 for <dev@dpdk.org>; Fri, 16 Jan 2026 00:01:46 +0100 (CET)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-432d2c7a8b9so1296754f8f.2
 for <dev@dpdk.org>; Thu, 15 Jan 2026 15:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1768518106; x=1769122906; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vxFPtN2A/rRrUebaZoc0yAu7J6sFXkp7ZnUCyDZPA5g=;
 b=w7uYe5SXlNNJFhGS823UianOyHdJr0s0yGn4Nsz8LY2zwn0CmMjsQMmC0xJLXG8A2d
 gtkXaTd6SLzfU46OgMzjNj6j+zrFB8WSodbzC54EiZlYRpwMVKHtkg+eSK1MYax4Q/p9
 k5MZHpaPzUm1Cl2deIAVHHr3jw7WtcTOWKvTqL16iLBipqYGVbBak2TtxYg8n1KWrD8O
 SQs6YApfmNAtAK+eHj6UGo6kUyn5BBKDZJdcxl16RF+95wPMrbRjBgcZ/FwFKKWe7lJQ
 odGjjyqRCaVRuzfe72x5moL0wmkntv3cTf0KkDZbqrpIKUMvyn/8LXbKomUyBErhooix
 WNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768518106; x=1769122906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vxFPtN2A/rRrUebaZoc0yAu7J6sFXkp7ZnUCyDZPA5g=;
 b=kp8TAT1RB3AnV2WwVlwjQYCi4RlmsVKIxig2zj606lu55Cvcwx4SpePZhiS0JLGFeQ
 hIistJIBplzAMy8fvuP3sLAbW2XeZ1CTuA5X9xJywaRhIUxK65B31FNyeFZuwL9licmn
 kQBQD7VresZb5Z0RGNu1QkCJLS7IBS8hGft/CQFFqKNJnOE1XrS09Tj5eXtunVwlUEIr
 K5RvvZEj6EN/deg3iHq+P50PJQIXaS3eu0q1vtHUKlTYgk9z0xGat6UrySv2xWQvsOvj
 +saN9tBp29Oc3yHDL+FazpgMpwivuwh/neds9qbmg3f9tyfD+5HRbJGmSyIDKuUdaN+0
 RTLw==
X-Gm-Message-State: AOJu0Yw0Hf8FpuZDoFncC+Y9wFhpczt7fEsDHusnzwmct97RGao9QNvg
 I1KAjFjn3mqJqgT94jX3dVVu1mwJMjDSU/uz1lA7ZKqpKMfkJ8ExjpxTgtiB4RUNxyhEOFErcj9
 3YbpH
X-Gm-Gg: AY/fxX54lyvBNNr6jJ7ga72UcrxOWOpCtyR/WKiKZ/myGXZvzO+cL3r+u3JDdHTB9vo
 llpJwFyuiTd4Iqol1jY0l9gfhdo03jYiL5NIUbhRyMb0iCtiAsh8IctQTqLa0HqX8OIIO8OzD53
 IU8h1i8D657aQMP+lwmfHad4wpZgCRWzmtnv92Wu/2xOlTmB/Qnt9lzyp5Vr32PqhTSA4eVmD9e
 Xx5w7WYPBA0Oio+rxR2t6gYDs5JTmDuRYkdOtW3Yoyloxx3CyhxiY9NPjQisnmZOxgovSbHlniN
 G3L2Swr6x5oo3WF2Vb1T1LCaKZUabP6wAirIzo2I5GccPTYO0lgrzDuUO8diN/mAQ/XRZ4RtjGA
 M8jjQHjnZgIWZ4tVz0sRTDvSiqLKNaL6AEbvgJL6YyTHb7Fu+PjYEPO7PAc2UeHPgLq8ycnZ4H3
 Nj4hRE4mODW4rRXpG+1pSEELstN/rupHuVAZUssvkxrg7UPSRXT/4=
X-Received: by 2002:a05:6000:2c05:b0:432:84f9:9803 with SMTP id
 ffacd0b85a97d-4356a033304mr931725f8f.3.1768518104988; 
 Thu, 15 Jan 2026 15:01:44 -0800 (PST)
Received: from dpdk-test3.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569921dedsm1572918f8f.9.2026.01.15.15.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 15:01:44 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: Lukas Sismis <sismis@dyna-nic.com>,
	stable@dpdk.org
Subject: [PATCH v3 7/7] dts: fix invalid f-string syntax in testpmd API
Date: Fri, 16 Jan 2026 00:01:13 +0100
Message-ID: <366f384e90cce0867652231494d8c873066b5fe6.1768518003.git.sismis@dyna-nic.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1768518003.git.sismis@dyna-nic.com>
References: <cover.1768518003.git.sismis@dyna-nic.com>
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

The f-string syntax was missing the 'f' prefix, causing
string interpolation to fail.

Fixes: cfd851f264 ("dts: add QinQ strip and VLAN extend to testpmd shell")
Cc: stable@dpdk.org

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

