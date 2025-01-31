Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F753C02193
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 19:38:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D06240278;
	Fri, 31 Jan 2025 20:38:14 +0100 (CET)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 by mails.dpdk.org (Postfix) with ESMTP id E8364400D7
 for <dev@dpdk.org>; Fri, 31 Jan 2025 20:38:12 +0100 (CET)
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-4674fc24130so766121cf.2
 for <dev@dpdk.org>; Fri, 31 Jan 2025 11:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1738352292; x=1738957092; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ej5PwgI+UZ//bK1zplg+HkPMK9f2N2voiD12PS7r7Uk=;
 b=KOZIBtUeOkDOxtVY12Pg7cdspCnD4mFxQSLiilMod6UjmTkgwfClILLAKS1NC2n5sH
 EmM1VZ1gGzAU6j3HuQ8UJ9E3xoefOnjetFfcBvuKOP4ArVj/OdoV2RJvB9BdbZ7zIFw6
 gQ4bt0MJXjRtDnNxsklXG598M/f6ZXJuK2L/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738352292; x=1738957092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ej5PwgI+UZ//bK1zplg+HkPMK9f2N2voiD12PS7r7Uk=;
 b=xDmACjsP633HIZFlU510l1T68fbJdqowTNZIe7yAKshHFOSzmCz4cna4rLwVlahHeh
 ixJjh+NGIkTxDlMFAT7sm4nRi6yjE3eDXXs4fJCP4HCUjcTSDPbylQfst2g12geD9tfX
 bFP+JufGApyr2WOWC6XlB8HPORCM8ifZcM2TSkbhAs5lQiUsdjInnV2ks01EsQd0I8Gi
 S9dcRjvUrvb8gK0IYoJ1p7mQEWDHK/1Ir0Yw12pO8OInyIjHziond1alKMr2ak/4H2rA
 XTaBvnZB3yl2r9rErZZpcWZK8s/bZNArnvwFD03VPHKp+2jsKD+H1xvyTRHym2oBwjp8
 aOSQ==
X-Gm-Message-State: AOJu0YwMNPB8z9ZOhMaLu7avDYh0keSekCo5ZZTOV9KIUiWU16KT9wiO
 zqVXK5uHR+jdvwxMIi8r5QTYXF/rzqR9dvksO6seoscKqiUW0eHG9yhfp8+byxM=
X-Gm-Gg: ASbGncuIV6qslW1g6JUGwjRbYMZfevp46NAXawGvP1L0PvTEmvrl9v3mfGbN4CAgQEW
 EvyaRib/ywbBlrnKxilN1q5t6ViR974vBlXuuXl/xMrafZLdkECr/DJD6phh+Q0yykAawIvOWWL
 IzL3KvauF5RG3NaK3r7c9N/zfhGEFc1PFhRKQtSLcyUdTO9rbSM2Z5YdqBLF+VIR4JjtACJhV6E
 Pn88YSdR7KgJIbR0sG4LtogDJe1USFNSILkklmV07T69qhnt/pbEqHCp9GtRujxBdnd/Svb3mfp
 aDI6bwSrGr1ig5SXbSEr9d3IPGjVYtUrsnCbwnAMj6i35yDUVvc81dq0
X-Google-Smtp-Source: AGHT+IFAzGq+zN9GO9MyWinA8E/lx00Y6gibbq+zmbcHzC6XCOIWYhG40RPNoIjd5aBxoAxIqH3SFw==
X-Received: by 2002:a05:622a:190b:b0:467:5fd2:9963 with SMTP id
 d75a77b69052e-46fd0a81214mr63690791cf.6.1738352292297; 
 Fri, 31 Jan 2025 11:38:12 -0800 (PST)
Received: from localhost.unh.edu ([2606:4100:3880:1271:e2f8:4ec3:8bf3:864c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fdf18a67dsm20743411cf.72.2025.01.31.11.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 11:38:11 -0800 (PST)
From: Nicholas Pratte <npratte@iol.unh.edu>
To: yoan.picchi@foss.arm.com, thomas@monjalon.net, luca.vizzarro@arm.com,
 probb@iol.unh.edu, Honnappa.Nagarahalli@arm.com,
 stephen@networkplumber.org, paul.szczepanek@arm.com, dmarx@iol.unh.edu,
 thomas.wilks@arm.com, ian.stokes@intel.com
Cc: dev@dpdk.org,
	Nicholas Pratte <npratte@iol.unh.edu>
Subject: [PATCH 1/2] dts: remove 'requires_forwarding_restart' from framework
Date: Fri, 31 Jan 2025 14:38:02 -0500
Message-ID: <20250131193803.168498-2-npratte@iol.unh.edu>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131193803.168498-1-npratte@iol.unh.edu>
References: <20250131193803.168498-1-npratte@iol.unh.edu>
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

