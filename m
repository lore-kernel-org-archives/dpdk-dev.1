Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53022C5AD5A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 19:44:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25C624026E;
	Wed, 12 Aug 2026 21:44:35 +0200 (CEST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by mails.dpdk.org (Postfix) with ESMTP id 3765840264
 for <dev@dpdk.org>; Wed, 12 Aug 2026 21:44:33 +0200 (CEST)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-51c0006ea8eso11248661cf.1
 for <dev@dpdk.org>; Wed, 12 Aug 2026 12:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1786563872; x=1787168672; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mmjGeJtN7T8izGlgCcqZAyNSw1cdgm0xuOhU7ul+Dns=;
 b=OIzngwlExgj9qgmJ803nw/CwlWU4sEDyCAkHYhNq3sMeXL0IHgi7KGBhkaXGJJbZaW
 Xq814GxM8lusbFUerLhFvprHWIUkB1DLAU6EW4sWItU2Xo/nOyxyQHMwUdJ/aeNq8EbJ
 nVoHKF+uiveiSBBmGTogoorXweHW2kzZx2dtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786563872; x=1787168672;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mmjGeJtN7T8izGlgCcqZAyNSw1cdgm0xuOhU7ul+Dns=;
 b=IBoxrUHwIpS/cJ8o6eGKobd9S9fhIs35pG7Ue8UakXgHVciFzZwkMWABCXHf/pAVyq
 X34EwFCF0KsZnocAHJmc/C5Xve0LLU5I5TzjlvXt+BSKfFXW36eOumF7Ni2+tIcXjS+Q
 +6Hcj7/+Yzn/wHZOhwmZ/4JTGJFShDmMGza7KNkPFCwJpkRnqM/zWGJyKORpQtAKCgzW
 Z9Imar6xEMO0cOyepJ6NtwiSUIxVR6uupFiPk9j2PNDg1947XAFITYccTi83WdzA1Eyj
 ZQEX/czJZYP5zLuPOe2py4Fj1piA2LEAUQb+OmQA0ekIxT8lDYNHZpkwx6PQyIQI4RfN
 DefA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqgXd7wqT0RXC3czhfCeURehsgT+sfK3HXDZwJBWSNdEzLhXwD7cMCGuRn/QgLPl4CMBps=@dpdk.org
X-Gm-Message-State: AOJu0YwKNaHseVw9kI+nlo3ZxJ+KlMYT10Rt8NioGlce9Tl+b8uYGoNQ
 bMU3ukxVr3x2Da/B+EPk5ISdotjCUnx8mepjy6V/eHGh9/QQmtARlgNQwRrYw5RpyVo=
X-Gm-Gg: AR+sD11sBuuLAQeOL5vq5xzGbMilS2I0BnYtPXZn1MebGidBzIRZOoYgGmrZXbldTfV
 BVG89VhYp350zS8vtci3wDg7Yvh0sd+1Ys2TYNb16GPo6SHSYJ/HvHra5wEfilNY7sa8RJb50AB
 MVag2FvRhZba0T0FInBNDsQFAaLTGa8sdMQ+q49F3W83++VENnx8iOrQUe2WrjXza8y+ZwLBYJL
 u5tNaGhWhx/zcgAsyykgHNbnC2fW1HMIjVDkMDixpxGd6InOR9EwuWTKtA1EQ/0qqYVcJJdBrbG
 He++QsREbUS1q4Rlz40V3+5W3pStN+6jdruT9YcC33gZcC8AGId2iyqNAuk+Rh8sh/PZSplIkzB
 9u+VktiPeaM3MHkEnornW2oKn1qLGM7RpTBItYfBZN0Evz7xbBY2FyP/LUaBG8rKVPKJt3cGohC
 jRbKqLwhA43mFT+GYUB9ZHQVAgCbXR0Wa3xrl2bnvUU7yNzvkWx1OONit156lLbSofucolizQxm
 7wlujZOzNMvCRyvHMP+SqVzxVP/bAaQMxSow47hqyGipnU3ZMRLrxPEVAMcpcJLXapxIUeqKo3u
 xBvQNmU+IyNFsxZmVbXFlrklyr2FW1KwdcxxpPAl5zqVwRPX5rk3avinE7gq
X-Received: by 2002:a05:622a:228f:b0:51b:fb82:67d1 with SMTP id
 d75a77b69052e-52d73db0571mr6222011cf.20.1786563872446; 
 Wed, 12 Aug 2026 12:44:32 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:af2f:903c:2ca9:975f])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d73fde326sm1409381cf.22.2026.08.12.12.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 12:44:32 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com,
	dev@dpdk.org
Cc: dladd@iol.unh.edu, abailey@iol.unh.edu, lylavoie@iol.unh.edu,
 Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [RFC PATCH] dts: restore unbinded ports to initial state
Date: Wed, 12 Aug 2026 15:44:28 -0400
Message-ID: <20260812194428.296334-1-knimoji@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
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

Once DTS completes execution, it re-binds ports to the drivers
they were initially bound to. However, when a port was not bound
to any drivers, it would raise an error when the bind command was
run. This patch resolves this issue, and properly unbinds a driver
if it was unbound before DTS execution began.

Signed-off-by: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
---
 dts/framework/testbed_model/linux_session.py | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py
index c118f803b6..1297c301b5 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/framework/testbed_model/linux_session.py
@@ -272,13 +272,19 @@ def bind_ports_to_driver(self, ports: list[Port], driver_name: str) -> None:
         """
         ports_pci_addrs = " ".join(port.pci for port in ports)
 
-        self.send_command(
-            f"{self.devbind_script_path} -b {driver_name} --force {ports_pci_addrs}",
-            privileged=True,
-            verify=True,
-        )
+        if not driver_name:
+            self.send_command(
+                f"{self.devbind_script_path} -u {ports_pci_addrs}", privileged=True, verify=True
+            )
+        else:
+            self.send_command(
+                f"{self.devbind_script_path} -b {driver_name} --force {ports_pci_addrs}",
+                privileged=True,
+                verify=True,
+            )
 
-        del self._lshw_net_info
+        if self._lshw_net_info:
+            del self._lshw_net_info
 
     def bring_up_link(self, ports: Iterable[Port]) -> None:
         """Overrides :meth:`~.os_session.OSSession.bring_up_link`."""
-- 
2.55.0

