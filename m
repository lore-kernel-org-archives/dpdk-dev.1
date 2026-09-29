Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BFEC9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 13:49:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 079D740E36;
	Tue, 29 Sep 2026 15:49:26 +0200 (CEST)
Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com
 [74.125.230.205])
 by mails.dpdk.org (Postfix) with ESMTP id 7C6014026E
 for <dev@dpdk.org>; Tue, 29 Sep 2026 15:49:24 +0200 (CEST)
Received: by mail-qk2-f13.google.com with SMTP id
 d75a77b69052e-530d0d5ae11so49504361cf.0
 for <dev@dpdk.org>; Tue, 29 Sep 2026 06:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1790689764; x=1791294564; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IvljbTx1PfDXOSgGfkNoOqktZlX43hNDt3ooW73GvQg=;
 b=EIdE3zQ3wYBInqrt0E0PDpj1Xe/683cuXBrc2FyTlOzIMeggL8e99WYos5ecCsMsfJ
 Zm2cC/15E8HfN9PxjXCWhHWY+7ArWc1rNKjzAZKtaEWXT5i+wToJ84TCUFjob7mD7HFK
 3R+0a2hzFiAKVwmlJqbNQNVARSmfZAwqMmUac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790689764; x=1791294564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IvljbTx1PfDXOSgGfkNoOqktZlX43hNDt3ooW73GvQg=;
 b=F95amocUP5WCQn42uk6lGFIyLm5zOTkGYJCzJSjxO80R2Ra0rGrHc3Z+XY2yu/EmYx
 YFcA4WBquNvNdOjoF928JyoR6tUGNKMjXmT1qL4LBTm4Q2mpKcQO1xY82efdSGlp9epU
 9vrf3peGpffVpZjucKu+iHWDHxR9tPnd8oUOrHJoc5M7D5CR9pzqaxub9IyFQkyuk+Ss
 2/GWUxqj0N5U4+DWqqendAKUYwqG80j2HSSnNS16mACL77FiZF19PYobUXeokaXg1llc
 DMiS03BF7+ssi9jrHfdTH8E8RgckMEJt21E0xSrAsY7Ax8ioUxuA7oT37gntlI4bxXx4
 RZUg==
X-Gm-Message-State: AFuF++nW/wuz+E0EVyDdHb1ZdsMXwGSVQiAwnqCw+HTIK6NgCPhqCKjj
 OLpt6qxpdgHM4ahUy47WTMnSRfQacWW/7TnZeTrcbRPifQcJh/lXxvFEr1tT018i1l94rthqchP
 1CSb9
X-Gm-Gg: AYBFou1/EBM4Whd+dBJLKlQaI/p28qz0VElcScLz5mAVPtE7DbPyOuJmny7ZNbsWuKC
 6v4ciUsHiLKEKOWx3m7r53njfNkbiwgyzbGpta5TTHdaLve3gUF/h0qwEa+GpNCG9daNFUoETS3
 xpO6cUWc3ZZDZ+Yvdqs0DrKpLapynhVIYYYUUBlLxNfOdmoh3H9xz5Gg919Pq+6OffBImd6fafD
 ZTzY6UhDzGAksQgr/tWF97ti7XcfmgYzy9g56lDmbw518wkuzEB88J+86NGIQTE34MGAwM2lpbT
 8N/4lOKzbb/lNkPFc8uHMNMPfzFHg19idLR9xmvQDVlaxLv7DIydkGZ5dbAw2GhRZEC1KIaThqA
 mRGNBbcCIs+h9/0qAD+5Nh7trCV4rB0QpQ1BYZ99pYatBuA6ZznCRyVc9vjHD/0PPy+2sKelY01
 TR/ZlWOCcEI4yFsF0JpFB7ptfQkZ96Nv94R9+s/x78I0xCDi7dzVEkWiig96lhiLi/43hAXNQ0m
 nPb+jaXyU7NeQezeUlpfBxAgNCiP5n2qhH5s2bYU84CsnznBz61cc1Yd1+hpKavttkmI1kXSSST
 ybKk2bI5K+C733B8YgJuhFVnbaL7iuMzD5iqKkSETIt2aPZMtVnqjLjK68ybi9+SIB1j
X-Received: by 2002:a05:622a:e443:20b0:533:3fc2:8b15 with SMTP id
 d75a77b69052e-5333fc28ff6mr97218411cf.58.1790689763775; 
 Tue, 29 Sep 2026 06:49:23 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:79a6:f2bd:f6a:842d])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5332238d545sm86632001cf.17.2026.09.29.06.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 06:49:23 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, dladd@iol.unh.edu, abailey@iol.unh.edu, lylavoie@iol.unh.edu,
 Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [PATCH v1] dts: restore unbinded ports to initial state
Date: Tue, 29 Sep 2026 09:49:20 -0400
Message-ID: <20260929134920.330389-1-knimoji@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812194428.296334-1-knimoji@iol.unh.edu>
References: <20260812194428.296334-1-knimoji@iol.unh.edu>
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

Bugzilla ID: 1983
Signed-off-by: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
---
v1:
    *Added Bugzilla ID to commit message
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

