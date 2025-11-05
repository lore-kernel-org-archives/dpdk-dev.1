Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC871CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 19:50:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2E0740647;
	Wed,  5 Nov 2025 20:50:44 +0100 (CET)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id 26963402E6
 for <dev@dpdk.org>; Wed,  5 Nov 2025 20:50:43 +0100 (CET)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-88e51cf965dso25241785a.2
 for <dev@dpdk.org>; Wed, 05 Nov 2025 11:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762372242; x=1762977042; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hq2rlvTQ9k4ZdO8tzEXjYh3m756HRt9kK8awme5X7fg=;
 b=EJ49+rR/xaqtdOEX6zNh64bA6pxRa154MtpXHmGatSe0iHImyITptuyhMgQrR6pEfL
 2w4ev/znSEZ9gepuJOfWMM3GdEufMfkiczL1U12o/wbvQd22UmF0Vl3bI0y1ZE248plK
 m9SnWAgEfRl068+ENMmooZ+D4O1b38DMqaKWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762372242; x=1762977042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hq2rlvTQ9k4ZdO8tzEXjYh3m756HRt9kK8awme5X7fg=;
 b=tQnhAKNTgPn3OCZuUeBWNdDIxyz0Gs3Dk5VLuERb5BvR0heDam1yFdvG6RtBSMLfig
 dlD5cwIrqvaEslpYqP5ylRkEfjOmEA0KR7k+pOudabtPd3Og2AoojW7bB0k3VP6nUH3Q
 3HtZ5I4vgXmY1PAtNz8+f0Tpp7i5Sh0JmQz3DafhmLbBcthobhPbUaXXtDIaWki+ku3w
 OmZds7bS+QcN9hKn8iIBET367u3SlgaIUFPEJdvQuwNtrypWa5S/6emijQn2/rQQwlZi
 PRRBzRha8N4u3opnigpiw7MepNxUEwXr2WVhd/pTJfAbM4loFMrQ02xe/ATF2m/t8hy1
 bOHA==
X-Gm-Message-State: AOJu0YyMlxI9n5L3TxD/g9iXbmPEaWJyk5IvH5hEHdLfshsBToDbTT7P
 Cr3QYMkDTmk8eIbZUzQcUsZrPJeghz0QavGn3tYGq64k/zXYjja+H57TFEADAmVy1B8=
X-Gm-Gg: ASbGncs76OExS25idS6fmCfohhioLJMaKzoYPJsdRUQHmzw+yL+MHPACBheX3fyLSQ0
 beDnmeU8s5nQGOCoOqaQ82pPsfHmO0NdX3ahtZDrac8zxTFx8Ahl7aWhNx73kUxdeuFJBGPw6OB
 bLR3ntH8Vh/HI+JsT+YCmo/3vwlf3Dmeo/5bqMJgjxxIVuMl+xyCJyCOzO3OxjbE740NdvjapNx
 TyDugBqwuCpYyj8djo54mAd3Ya0tsZgy4xdChGA6xzS6HPiAmkSrqIkYF+N1wUzUg3V15AYLfQC
 VTZ+E2GlZfkwVarxxcdvKerRqY/y9LXVLDd2u56FhbD6odZk+WZsavmiCoghLVug0IrWTRfe1qP
 NtY0kdu2/q6g2r6P83gKsWkZhvoKUzdwYAGuVsVAQNgzUr0qMbC1gG8phCBFUgKh9jUgruqi5RZ
 5N
X-Google-Smtp-Source: AGHT+IHw/G/Mzyfp1wRBSYSTPbs8wu6GlGQlIc8iV+fKlxcxCK/uQQa9Z/4+YMyfEwH6dC/FgdO2zA==
X-Received: by 2002:a05:620a:318b:b0:866:a24e:2eb5 with SMTP id
 af79cd13be357-8b220b1db7amr610258185a.34.1762372242292; 
 Wed, 05 Nov 2025 11:50:42 -0800 (PST)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b23580b649sm29469485a.48.2025.11.05.11.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 11:50:41 -0800 (PST)
From: Patrick Robb <probb@iol.unh.edu>
To: Luca.Vizzarro@arm.com
Cc: dev@dpdk.org, Paul.Szczepanek@arm.com, dmarx@iol.unh.edu,
 abailey@iol.unh.edu, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v2] dts: testpmd link check on port start
Date: Wed,  5 Nov 2025 14:49:25 -0500
Message-ID: <20251105194925.1507334-1-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250908014154.82938-1-probb@iol.unh.edu>
References: <20250908014154.82938-1-probb@iol.unh.edu>
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

When running our existing DTS testsuites on a new
NIC we observed packets would not transmit from
the traffic generator to the system under test
even after DPDK testpmd and the NIC under test
had indicated readiness. After investigation, we
determined that the existing readiness check in DTS
for testpmd start (checking that port is started)
is insufficient, because on some systems the link
will remain down for some measurable time, creating
a race condition between the testpmd port's link
coming up and the DTS execution reaching the packet
transmission step. This change will ensure that
testpmd start will block until the port is reporting
that its link is up. In addition, the interval in
between checking the link state has been reduced in
order to speed up the execution.

Signed-off-by: Patrick Robb <probb@iol.unh.edu>
Tested-by: Patrick Robb <probb@iol.unh.edu>
---
 dts/api/testpmd/__init__.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
index aadb7f4e70..49a847494a 100644
--- a/dts/api/testpmd/__init__.py
+++ b/dts/api/testpmd/__init__.py
@@ -93,6 +93,9 @@ def _requires_started_ports(func: TestPmdMethod) -> TestPmdMethod:
 
     Args:
         func: The :class:`TestPmd` method to decorate.
+
+    Raises:
+        InteractiveCommandExecutionError: If the ports has been started but a port link will not come up.
     """
 
     @functools.wraps(func)
@@ -100,6 +103,10 @@ def _wrapper(self: "TestPmd", *args: P.args, **kwargs: P.kwargs) -> Any:
         if not self.ports_started:
             self._logger.debug("Ports need to be started to continue.")
             self.start_all_ports()
+        if get_ctx().topology.type is not LinkTopology.NO_LINK:
+            for port in self.ports:
+                if not self.wait_link_status_up(port.id):
+                    raise InteractiveCommandExecutionError(f"Port {port.id} link failed to come up.")
 
         return func(self, *args, **kwargs)
 
@@ -265,7 +272,7 @@ def wait_link_status_up(self, port_id: int, timeout=SETTINGS.timeout) -> bool:
             port_info = self.send_command(f"show port info {port_id}")
             if "Link status: up" in port_info:
                 break
-            time.sleep(0.5)
+            time.sleep(0.25)
         else:
             self._logger.error(f"The link for port {port_id} did not come up in the given timeout.")
         return "Link status: up" in port_info
-- 
2.49.0

