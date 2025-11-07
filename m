Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FED3CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 21:50:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DEFD402E3;
	Fri,  7 Nov 2025 22:50:27 +0100 (CET)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 1476F402CA
 for <dev@dpdk.org>; Fri,  7 Nov 2025 22:50:26 +0100 (CET)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-88f2b29b651so118252985a.0
 for <dev@dpdk.org>; Fri, 07 Nov 2025 13:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762552225; x=1763157025; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rDZk0B/rzbk9sV8jxE0RhxPEum75118ZcahJSnjw6pw=;
 b=ZY+lPAAWNDTjgnfTXjrx0WrRyPSSTCMeA5bfyB1tsuuuvu87VO94ACFZcG1Cz1N/Uj
 +c6onpaBS3YTfNqTYurg7PoT121u5Ebo/32yUGpT6nSgJK7BQ50uN+xdhZSnPP23n2rr
 e0+WQw2EPFb6XBaQiSDTaiDTGYz1sIXLWrTsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762552225; x=1763157025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rDZk0B/rzbk9sV8jxE0RhxPEum75118ZcahJSnjw6pw=;
 b=SFc8oXsvkU9paQQog2OYHamJJkMxBpl86ZMLskSmpckyebQNgvTeD1ODLyav0KDTA7
 nw+UhOLmGqKBH/hvaUobJDmHkvkXSX3onLOBWFZQ+AZppU/zVV9F5HDIebK7chejd/he
 z8DWxzCwZfgTdQ8Pl9/d1Fn9OkFZhGZ0aBnpsW4T+AG3GCSuUN9Nx9bCSuVBE79Jv0en
 4hreFbyCF9Vi0O9Itwu7hiP3ihKqn+TwuIqDnJHTW0HI32KJkBtnFz+A7CjGkUls7wjT
 ewgV5LrTZfvsF5xkEyuDjNmgjKXZfRhlfT6RW/0zIbUk1ujKoritmDzd5T0ZGrTWowTz
 pYOw==
X-Gm-Message-State: AOJu0YxP7amE6DiWownc17FVcVzVCakk4JHXAVxFomSFrbKqXsBzyMnJ
 2LfMXlgy/IDM3GPq4O00laSqOEB2gVE0wWizbTtlbyujKCyN+N1xahrLwXYvIir3/NQ=
X-Gm-Gg: ASbGncvW1FT/uzNPftfqjnIK1C2LH47fKOAyKrvsNZMZrwaPeB1nA3Ndyqb9EGyIsOO
 u3fm8CL957Byjfl7DXSaa2wQhaDCUbqyRz3mAjMUspYl2trl33yL8T7z824T3/pNlunPbDHsx2X
 7Wr+YF44PFP+OJO7mm8jt0Fc1U0uOdvtfEzx1nyZtlP5FQHtdHy61WsrfeYa4Kwfm5VigkhMWn6
 vDMZOdknQwm9vJ+AGNawSNzwBygUd9GZtol7eRrs2sIDnZxM0Wf7YurPB0D1yBe3P23n2zbpl2F
 tuvuObfOLgFRqihxU/MDEpCQxdr4OCEY88981rPu9zfu6oQaZAHdOzG4g7Vp8mHFWLEieH2Wh7a
 bpOQTt4FgjWc7TDGkNtsttu9mrdrUlQZaNlTVzlnp8Ts8+fUVfhLrr/WRNzs4ctcP9wGb
X-Google-Smtp-Source: AGHT+IG2MjsxUB/5QHDmweU8VI31Lg49FPV+oh9UOzpqlnMcj/+VCs6uQAfjldpcJl327rszlHqNFg==
X-Received: by 2002:a05:620a:407:b0:8ab:5cb2:1f68 with SMTP id
 af79cd13be357-8b257f6d6ccmr74125085a.69.1762552225321; 
 Fri, 07 Nov 2025 13:50:25 -0800 (PST)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1210::202])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b23580c7f9sm496607085a.44.2025.11.07.13.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 13:50:23 -0800 (PST)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v5 2/4] dts: add methods for runtime interface config
Date: Fri,  7 Nov 2025 16:50:16 -0500
Message-ID: <20251107215020.255182-2-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107215020.255182-1-dmarx@iol.unh.edu>
References: <20251024185056.607160-3-dmarx@iol.unh.edu>
 <20251107215020.255182-1-dmarx@iol.unh.edu>
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

Add methods to Linux Session class for setting the link
of an interface up and deleting an interface.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/framework/testbed_model/linux_session.py |  8 ++++++++
 dts/framework/testbed_model/os_session.py    | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py
index 1f11c3e740..711d4d97c3 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/framework/testbed_model/linux_session.py
@@ -204,6 +204,14 @@ def bring_up_link(self, ports: Iterable[Port]) -> None:
 
         del self._lshw_net_info
 
+    def set_interface_link_up(self, name: str) -> None:
+        """Overrides :meth:`~.os_session.OSSession.set_interface_link_up`."""
+        self.send_command(f"ip link set dev {name} up", privileged=True, verify=True)
+
+    def delete_interface(self, name: str) -> None:
+        """Overrides :meth:`~.os_session.OSSession.delete_interface`."""
+        self.send_command(f"ip link delete {name}", privileged=True)
+
     @cached_property
     def devbind_script_path(self) -> PurePath:
         """The path to the dpdk-devbind.py script on the node.
diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/testbed_model/os_session.py
index b41bb42205..b94c3e527b 100644
--- a/dts/framework/testbed_model/os_session.py
+++ b/dts/framework/testbed_model/os_session.py
@@ -590,6 +590,22 @@ def bring_up_link(self, ports: Iterable[Port]) -> None:
             ports: The ports to apply the link up command to.
         """
 
+    @abstractmethod
+    def set_interface_link_up(self, name: str) -> None:
+        """Send operating system specific command for bringing up link on specified interface.
+
+        Args:
+            name: String representing logical name of port to apply the link up command to.
+        """
+
+    @abstractmethod
+    def delete_interface(self, name: str) -> None:
+        """Send operating system specific command for deleting specified interface.
+
+        Args:
+            name: String representing logical name of interface to delete.
+        """
+
     @abstractmethod
     def configure_port_mtu(self, mtu: int, port: Port) -> None:
         """Configure `mtu` on `port`.
-- 
2.51.0

