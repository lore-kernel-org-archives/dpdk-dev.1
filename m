Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29355CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 21:50:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28EDD402CA;
	Fri,  7 Nov 2025 22:50:29 +0100 (CET)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id 00AEA40395
 for <dev@dpdk.org>; Fri,  7 Nov 2025 22:50:27 +0100 (CET)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-85a4ceb4c3dso114862185a.3
 for <dev@dpdk.org>; Fri, 07 Nov 2025 13:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762552227; x=1763157027; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3HqGkfKldL4K+c9dyfyKOe4goVALUWuxEKyUjlSsqq8=;
 b=GBQC0BY3f+INeAOfHs5oziORRKGs0EgfwMQonPXKZMb5rtcjCU47lL8G6ggkCLZRmu
 bokdzv3hFd+pM8A9GOu4qCFUGi9bCijtI4g74xp4WL7EVYOuQyErSSIRDFfIPvtbmckH
 MfaLfRItfDY4XbHhsfttultICTrQcZFJtwoBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762552227; x=1763157027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3HqGkfKldL4K+c9dyfyKOe4goVALUWuxEKyUjlSsqq8=;
 b=e6UWbx9evqMrhAI2fr6tAhC+YL7xa4WYwOS8/vsNmluwsPMgbopxvMgdOJ33kVbckB
 hT7u8ZZP40Uwnb+X59qw69c9lhgMORKbIJKJnUIN6t/4VHqXcLg+nB9S+IxX8mEofo/H
 vhg3gRyP0y4Nh4/z3HzieVoKK2Asx7pHv1UDyoiYVuoduC3/wdrpGLmJ7aIEo5GWZlNa
 yK35kUScuEPCQkcu4xDAfSdPt3DVoenYOeHdCe01cg/QYDpOQzz4otK4nOU6RQY0GBxB
 imKfqNYYQFF/ARfd/a2eIWE/5mTJWCRmcRWSPB9LhPmU+kI3xHoCzN8XUQMiM550f6ET
 BLIg==
X-Gm-Message-State: AOJu0YzE1h+O3R0jS6vRlPjS8Pxnq9WhHhh6DVLvsavNDL7EJBLmTgaK
 nyX5vFoqf0fuyntZzQCC/z2fEv0SV5MQ/PtNzVEqSDa0UVB3BWcaVwMkKICOUIm2WUU=
X-Gm-Gg: ASbGncsZoupcg5n83Or/p2NO3Irq3BcxmyGUnNA7bu5FMO2VUUkDAofsZT/SW9BW6xM
 LKsaZ4fr1+E3bR/k11NJWDwdijTqsU2aDqrFkoxlHwTjQ7LaKWeXN8N/FwXr5VYsGchnpHG1sS3
 2y80Vc8eafrkgpr7CPO5uOW2nDMDD5U7sUeKfNDjDofN3BLlzAJ8j75VNte2DfJ7yWKn3xHCgmV
 /GVZvNcPi2D/NBXsVmjqBA6AXhHhwqjqnN1/KOv82eaKf3CN+vD1mEIsdflawRJo8p8211HIMy9
 9+L/9elQFntdbMXpDFe5mSsJmNgEKMf7dHY1PuJ77TDWUM//uo9zauTOszS0SXJ6iN+e6YY/cOr
 p7QBd+h6Cd/ObG8Lin2AJH3VboJ5aXgU1YiZgz1/Hi3J9+UVVuuvJ55tiEB7qWnm6e2jt
X-Google-Smtp-Source: AGHT+IGbTDOd6pk+SUxOT+rRMYphVE+gK1kIT/dNxtRcO04F5TKhJEBr8EIh8UaRtLeSpZN0upRMCQ==
X-Received: by 2002:a05:620a:1994:b0:8b2:21a7:d1c6 with SMTP id
 af79cd13be357-8b257f6a45cmr117795185a.68.1762552227250; 
 Fri, 07 Nov 2025 13:50:27 -0800 (PST)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1210::202])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b23580c7f9sm496607085a.44.2025.11.07.13.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 13:50:26 -0800 (PST)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v5 3/4] dts: add set portlist command to testpmd shell
Date: Fri,  7 Nov 2025 16:50:17 -0500
Message-ID: <20251107215020.255182-3-dmarx@iol.unh.edu>
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

Add a command to the testpmd shell for setting the portlist
(list of forwarding ports) within a testpmd session. This
allows for changing the forwarding order between ports.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/api/testpmd/__init__.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
index 6d70927660..e990c582e3 100644
--- a/dts/api/testpmd/__init__.py
+++ b/dts/api/testpmd/__init__.py
@@ -1429,6 +1429,23 @@ def set_queue_mbuf_fast_free(
                 f"Failed to get offload config on port {port_id}, queue {queue_id}:\n{output}"
             )
 
+    def set_portlist(self, order: list[int], verify: bool = True) -> None:
+        """Sets the order of forwarding ports.
+
+        Args:
+            order: List of integers representing the desired port ordering.
+            verify: If :data:`True` the output of the command will be scanned in an attempt to
+                verify that the portlist was successfully set.
+
+        Raises:
+            InteractiveCommandExecutionError: If the portlist could not be set.
+        """
+        order_list = ",".join(map(str, order))
+        portlist_output = self.send_command(f"set portlist {order_list}")
+        if verify:
+            if "Invalid port" in portlist_output:
+                raise InteractiveCommandExecutionError(f"Invalid port in order {order_list}")
+
     @_requires_started_ports
     def get_offload_config(
         self,
-- 
2.51.0

