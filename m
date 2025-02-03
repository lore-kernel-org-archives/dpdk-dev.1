Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5142C02192
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Feb 2025 16:39:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9BA440661;
	Mon,  3 Feb 2025 17:38:58 +0100 (CET)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by mails.dpdk.org (Postfix) with ESMTP id 74DFE40615
 for <dev@dpdk.org>; Mon,  3 Feb 2025 17:38:57 +0100 (CET)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-46782358d5cso2609841cf.1
 for <dev@dpdk.org>; Mon, 03 Feb 2025 08:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1738600737; x=1739205537; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ej5PwgI+UZ//bK1zplg+HkPMK9f2N2voiD12PS7r7Uk=;
 b=OOtM2b1SbCCDhfr3PH/9pO3M8lAm6yrpCT3OysjPfAKTO0GQT+6GXM+5zrkrPSraGa
 LyIAFFuORsHPwmoxOqIETROZX1soi8qxDst0h5Ue1FUh6FXaa9+B///Ez0kprznr6xgY
 djOcbLYopvHaNnVcc+UyVK4Sv5y8d0cb84+R0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738600737; x=1739205537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ej5PwgI+UZ//bK1zplg+HkPMK9f2N2voiD12PS7r7Uk=;
 b=E6ftHOUbhCiUUEFPRNe6L3ZSnRZc+qrx6S4XRlftVKruOFiFD9DPyoelI7axDtuHK6
 IjyAaMRkdF2gBuJoSA5fB6ckn7zhHzBVLHbYv/JoJL6hazCCwp20e1fSdDJ2uK2GWJJk
 DW+G1gOgkbDQ20GFJH5jGec0N07n5nPkMza0X3GhAQUbVNyfe+q+rM9tYSRBglAHspSh
 jkUiRQMWtPEOthPyWuaeplG/qGh/7EY58F5lZDGeuiYOS2lLv7yJUHM+na+cXiyHA968
 wOgikQwhCE4ERDdS1VbyIO+pdVdDzTA54AVp1M8QohZ0QHsMdC356U2fWfv86XV4bDoo
 5IUA==
X-Gm-Message-State: AOJu0YwEOSay9thUhogQy2R/ywe2KUUsNeJt9meelwYRVORuLHMP+PDV
 wvbm4UuOIpylD1po2iZb2axl/2Lw+4fJKfkM3s5LQBSAMt/3Syln5qG5kypWNII=
X-Gm-Gg: ASbGnctZ5il34NrDkCANsYEjMlpIgcC70VeNHaJfRhIA4hyVB9hfqKsbnmdF7vvQRjD
 G3ewTs4FA0vaKol+dPoz3QboaUpVkZaon/4P5FH7ThhjjAVAy6gXpTCE+xbWdUIPR39KYvUcXMN
 72o7Th98He7N9/sOiFOFc/UawaBuFZXfn0M9iQbBtC0Ik5k/1AxsYdsVE17A4wxD4MexbJp47Hx
 rqarGP96RQpT7IlM43WO+FlyERB5PDnFlfs6535uKxBs016Tn89CmqNRMAk7iQkG8x6/C6R3yGU
 d91ZV4yJxsUsl1dCQXGmMfrX+WtMgMaB0MfB8CorCbM+J0p+4AQlCya+
X-Google-Smtp-Source: AGHT+IEGmsdYEeufLZYtOlkqCrENOthEAe0UD4p77FwTVLbhYlJ1yQM7kThxac6BYM725t9N1BmUHQ==
X-Received: by 2002:a05:622a:10d:b0:467:613d:c9bb with SMTP id
 d75a77b69052e-47017e7200emr1258571cf.8.1738600736637; 
 Mon, 03 Feb 2025 08:38:56 -0800 (PST)
Received: from localhost.unh.edu ([2606:4100:3880:1271:e2f8:4ec3:8bf3:864c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fdf0e0bfdsm51566711cf.41.2025.02.03.08.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 08:38:56 -0800 (PST)
From: Nicholas Pratte <npratte@iol.unh.edu>
To: Honnappa.Nagarahalli@arm.com, stephen@networkplumber.org,
 thomas.wilks@arm.com, probb@iol.unh.edu, luca.vizzarro@arm.com,
 thomas@monjalon.net, dmarx@iol.unh.edu, yoan.picchi@foss.arm.com,
 paul.szczepanek@arm.com, ian.stokes@intel.com
Cc: dev@dpdk.org,
	Nicholas Pratte <npratte@iol.unh.edu>
Subject: [PATCH v2 1/2] dts: remove 'requires_forwarding_restart' from
 framework
Date: Mon,  3 Feb 2025 11:38:49 -0500
Message-ID: <20250203163850.249461-2-npratte@iol.unh.edu>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250203163850.249461-1-npratte@iol.unh.edu>
References: <20250131193803.168498-1-npratte@iol.unh.edu>
 <20250203163850.249461-1-npratte@iol.unh.edu>
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

This implementation conflicts with other bug fixes implemented in
earlier patches. The decorator was devised as a mean to make suite
writing a bit simpler, semantically, but the addition of this adds too
many complications for it to be worth implementing.

Signed-off-by: Nicholas Pratte <npratte@iol.unh.edu>
---
 dts/framework/remote_session/testpmd_shell.py | 26 +------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
index 9f07696aa2..e15fc0ee8f 100644
--- a/dts/framework/remote_session/testpmd_shell.py
+++ b/dts/framework/remote_session/testpmd_shell.py
@@ -1433,28 +1433,6 @@ def _wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs):
     return _wrapper
 
 
-def requires_forwarding_restart(func: TestPmdShellMethod) -> TestPmdShellMethod:
-    """Decorator for :class:`TestPmdShell` commands methods that requires forwarding restart.
-
-    If the decorated method is called while a :class:`TestPmdShell` is actively forwarding, then
-    forwarding is ceased, the wrapped function is executed, and forwarding is started again.
-
-    Args:
-        func: The :class:`TestPmdShell` method to decorate.
-    """
-
-    @functools.wraps(func)
-    def _wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs):
-        if self.currently_forwarding:
-            self._logger.debug("Forwarding needs to be restarted to continue.")
-            self.stop()
-            retval = func(self, *args, **kwargs)
-            self.start()
-            return retval
-
-    return _wrapper
-
-
 def add_remove_mtu(mtu: int = 1500) -> Callable[[TestPmdShellMethod], TestPmdShellMethod]:
     """Configure MTU to `mtu` on all ports, run the decorated function, then revert.
 
@@ -1503,7 +1481,6 @@ class TestPmdShell(DPDKShell):
     _command_extra_chars: ClassVar[str] = "\n"
 
     ports_started: bool
-    currently_forwarding: bool
 
     def __init__(
         self,
@@ -1528,7 +1505,6 @@ def __init__(
             name,
         )
         self.ports_started = not self._app_params.disable_device_start
-        self.currently_forwarding = not self._app_params.auto_start
         self._ports = None
 
     @property
@@ -1926,7 +1902,7 @@ def csum_set_hw(
                                                            {port_id}:\n{csum_output}"""
                     )
 
-    @requires_forwarding_restart
+    @requires_started_ports
     @requires_stopped_ports
     def set_port_mtu(self, port_id: int, mtu: int, verify: bool = True) -> None:
         """Change the MTU of a port using testpmd.
-- 
2.47.1

