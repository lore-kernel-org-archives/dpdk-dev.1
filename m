Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD05CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 18:51:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8A2440648;
	Fri, 24 Oct 2025 20:51:04 +0200 (CEST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id 41CE8402EB
 for <dev@dpdk.org>; Fri, 24 Oct 2025 20:51:01 +0200 (CEST)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-89ef0cec908so23261185a.1
 for <dev@dpdk.org>; Fri, 24 Oct 2025 11:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761331860; x=1761936660; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SNf9N+4J3eq7eJxB9KgauMPbAQ4DA+ySXjtIBA41+OA=;
 b=Ez0jeysXlGRkPFad/+pmTPV2RXa1u7e3WxRLN3l+/jw2FJN+j/uvbdpY1G+CZCrGtF
 HnH88CSVRqPhTTWR+vGTY398jzks2ne5VQ917Xk8pCuPW2x7ZKEMd7qpZw6lU+JdZnAD
 tlHOBgt3FG9zncMYxuYE4Gs1CXO51i3oUqk9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761331860; x=1761936660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SNf9N+4J3eq7eJxB9KgauMPbAQ4DA+ySXjtIBA41+OA=;
 b=vLtdydjhr4HiR3y96SjHCdh9r2U0mYAgUqEnyUcJq/pwLWgXOhtEl0YaZ9MBX/YFsj
 /CjSGjh1VtVGE9n6pI/ZuMcx7mrzzVlVlHcbP92NpgHAz1M3LmzeysAnpvb5JHYAqDPj
 lTh17tVGsaw1CkUR1XQJ38I2gCFtdVnwDMlvFuVwOwwiBGCQkUcJoNGIK+fKLXskOJZE
 6ZfrYwcqgHXOLBirNX5psFx2pt3R+KRevOHVnrbb7fqnwTUZx17VUqf2cHmfVZ+8G+3d
 EvgoUd1IATbhQGCCWB9JuBfFHxPA5M4GA6R+y8bA6Hq30SiPX31MVwrab0jcRhuV68WO
 Q6eQ==
X-Gm-Message-State: AOJu0Yzb3g95+tJxFRWWL++B/G+QUW71LVq1rkCUHmfw2m+PJf8eZB7V
 /F6sLXJv5Jk2Y4jWGuMY4gRr2Bwb029QVyCgyOy14XHZ+vwYUSX+B/jjs8vYSxdWKt4=
X-Gm-Gg: ASbGncuucmwgftKJBx4W1W+hkM2sCJnLFKhqGUUDXw2B63l1Ezncdw29kqJEtirZPG3
 +5j4pBWdP8ZmhKs7RQj4zHsvLuhwhAoFghLGAkKIGTqHZ/+iGoQysYcqS2/2p03tfmx5SfVR5CE
 XM9rRK5ymr+XK6R/6i4hKB9UC+dTVw8BaZF1gX4tacZe3dVRImt5x3vIth1UzQ9qTdEctE4cbiC
 rC3VgP/+2Qytuq7gNuL4bzKJonHpu4aQciNWawIzBZTATRsWKNjIPUisBFkvRhX5Ri4t1vqF1Jy
 Qcv0GUUswhIY7zDo/9+OxNNTdv1uTk6/BOo13Np3M1qzJI3VqdJKLjiZuJwtZcRG7NE7hYD9H0c
 sCylwfe1u3Kq781YokqXSapUDS/zv8rmoqt5qd2S8rIrlYmHOiEh6jaWaleBuEam00QuX1NUJXk
 S5w9sVph1M44cWMA==
X-Google-Smtp-Source: AGHT+IGRrUy5Hm8zAHJ4LTLkrMFIl54IZHHUyEE+FGAPsbb35g88iGrNIfwYzZCMTeZ3xZ9knGSvZw==
X-Received: by 2002:a05:620a:4003:b0:88f:ee0a:3d5c with SMTP id
 af79cd13be357-89dc0382fe1mr502603285a.27.1761331860485; 
 Fri, 24 Oct 2025 11:51:00 -0700 (PDT)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1257::100a])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4eb80804d81sm39830751cf.19.2025.10.24.11.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 11:50:59 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v4 2/3] dts: add method for bringing link of interface up
Date: Fri, 24 Oct 2025 14:50:54 -0400
Message-ID: <20251024185056.607160-2-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024185056.607160-1-dmarx@iol.unh.edu>
References: <20251024174702.600147-1-dmarx@iol.unh.edu>
 <20251024185056.607160-1-dmarx@iol.unh.edu>
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

Add set_interface_link_up method to Linux Session class
for setting the link of an interface up. The existing
command most similar to this, bring_up_link, is designed
for use during topology setup within the framework,
whereas the new command is designed for use during
test suite runtime, as is needed for the virtio suite.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/framework/testbed_model/linux_session.py | 4 ++++
 dts/framework/testbed_model/os_session.py    | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py
index 1f11c3e740..bfec2f3339 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/framework/testbed_model/linux_session.py
@@ -204,6 +204,10 @@ def bring_up_link(self, ports: Iterable[Port]) -> None:
 
         del self._lshw_net_info
 
+    def set_interface_link_up(self, name: str) -> None:
+        """Overrides :meth:`~.os_session.OSSession.set_interface_link_up`."""
+        self.send_command(f"ip link set dev {name} up", privileged=True, verify=True)
+
     @cached_property
     def devbind_script_path(self) -> PurePath:
         """The path to the dpdk-devbind.py script on the node.
diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/testbed_model/os_session.py
index b41bb42205..4523679dc1 100644
--- a/dts/framework/testbed_model/os_session.py
+++ b/dts/framework/testbed_model/os_session.py
@@ -590,6 +590,14 @@ def bring_up_link(self, ports: Iterable[Port]) -> None:
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
     @abstractmethod
     def configure_port_mtu(self, mtu: int, port: Port) -> None:
         """Configure `mtu` on `port`.
-- 
2.51.0

