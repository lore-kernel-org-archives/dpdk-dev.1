Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300E7F532C6
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 00:55:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F82B402D6;
	Tue, 24 Mar 2026 01:55:53 +0100 (CET)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by mails.dpdk.org (Postfix) with ESMTP id 4A41D4027C
 for <dev@dpdk.org>; Tue, 24 Mar 2026 01:55:51 +0100 (CET)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-509217e84a3so5918921cf.3
 for <dev@dpdk.org>; Mon, 23 Mar 2026 17:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1774313750; x=1774918550; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y6+5J4Dq+cNubLbjCJbI4RMNjbuE0sOAoclsMKF90qM=;
 b=X+5lZZuWh51O6JpfrBAkZV1AcFW6mja5EEuw7Fha5Ep7NcReIWFaXrAaFDkZHv2m6c
 DMtNnAPCrUhj8HZNQdsOGWtUZmwH9nNDkqB53CPRAPyvnAdKigOmrpcVjVD7IxF7R5+7
 AfFkS90n78l9Kj7wMB+CMJmbkaq+dk/g8zkQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774313750; x=1774918550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y6+5J4Dq+cNubLbjCJbI4RMNjbuE0sOAoclsMKF90qM=;
 b=pRbk0WdXeuLJV7zFbzjSeQmXOJWxrY98w2+qtYYQNV+fCJYMhOtyjOE38fEOuSQ8ic
 71eEKE5nmwqCSqg8tdvsmze7NdM7H+m+eSumzElNefnJhfblntpBnIUIvkWOZFBrf/HF
 USujYS0d64OjeH2CQqG6KO6O77xCisD/zCuS51bzcFdto1xx/06tUEeH9PYDHb5oiJu5
 ngml5gSyq3TQVduXS9p5cRgHFPXxdpK06rFugH/4FpGPZGxKP6N3je8YFoazu9aidpHH
 qo82mrEm3vOaxFVznjEuHnsAuxdm/koT/aoow1CYZGIGj3oF79r8CbLkvM2yDiyBkt7u
 +1lA==
X-Gm-Message-State: AOJu0YxI6Wq7Z1h5mQwEUgnucnkrsnWMTAvCs859rgdhO015qdtVWyKX
 sP7t/fsFLR5vx/a7BGX/JnJM2feRpKDJLC5UmbkS/2lF51zHbK88pDOMqhzTR3cW5LRbCOfOLSH
 B8QrInyE=
X-Gm-Gg: ATEYQzx3P8cAezi4Rb1D/dSUQrv+icoFNbIgrwOZUeO/4zj22FwGRnbREF5AC3LiK3f
 vOOhdvuoqMGGr/AJtB21i37cg4X/B/cXb7rofLuspt+LYpol0dGOSbyoM0Wsa7TBHserdhAlgmb
 OlbBWibdMAv8G46YYS4L9TS4ChRJHagZJHKz6Y6RoK6csfU2UNP1rJfLJpYuOuGMayCTJn2XvIh
 B6+k42J6hehPC+yCzIjuaEyjsR3RjlDe/36/nfRc4Cukp7c87D6Gyns1YzvwOokrl3sOEOWOq5q
 SIfsCCKLX5nAWLKyS4ddr41ekrSQiqG+iIg0KqSW+qS45D8An+xfj72qKZA6zPX5hQk+/jfGgnO
 Rt52eS85y+X9nZfRn8huMQdokHx2LbSMVvcS9HkZjaZ4H/XPcqEzeDDcLTKg2A1UNB3QtCS0ChZ
 oSrhf9ZtBm/3mrgUMue7w7G/G6Kj0hUViD66x+eKnBa1acb/TPnAeC2o8O81rwbxd1VP7Ol4ON+
 4r5Ly+XDBvcIbuqQH1tiQ==
X-Received: by 2002:a05:622a:4e93:b0:509:2822:670d with SMTP id
 d75a77b69052e-50b373eaec2mr207124261cf.27.1774313750533; 
 Mon, 23 Mar 2026 17:55:50 -0700 (PDT)
Received: from patrick-laptop.hsd1.nh.comcast.net
 ([2601:188:c083:cd0:e674:3b6b:125b:ed1e])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50b36e3d85bsm91913721cf.17.2026.03.23.17.55.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 17:55:49 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, abailey@iol.unh.edu, dmarx@iol.unh.edu,
 Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v3 1/2] dts: always use ethdev ports to check capabilities
Date: Mon, 23 Mar 2026 20:52:40 -0400
Message-ID: <20260324005241.761124-1-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260323180818.674041-1-probb@iol.unh.edu>
References: <20260323180818.674041-1-probb@iol.unh.edu>
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

DTS uses its capability check step to query ethdev devices for
their capabilities, and then run or skip testsuites according
to their respective capability requirements. So, we should be
running the capability check step with the ethernet devices
in all cases. However, when crypto ports are specified, a
crypto virtual function will be used in the capability check
step in error. So, this patch changes the default behavior
when computing EAL arguments, setting the port allow list to
the ethernet devices by default. In addition, as a defensive
coding measure, the capability check now specifies its usage
of the SUT ethernet devices when acquiring capabilities.

Fixes: 76e3fdd7b5c6 ("dts: add cryptodev package to DTS")

Signed-off-by: Patrick Robb <probb@iol.unh.edu>
Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>
Tested-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/framework/remote_session/dpdk_shell.py | 5 +----
 dts/framework/testbed_model/capability.py  | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/dts/framework/remote_session/dpdk_shell.py b/dts/framework/remote_session/dpdk_shell.py
index b94d336d4e..51b97d4ff6 100644
--- a/dts/framework/remote_session/dpdk_shell.py
+++ b/dts/framework/remote_session/dpdk_shell.py
@@ -46,10 +46,7 @@ def compute_eal_params(
     params.prefix = prefix
 
     if params.allowed_ports is None:
-        if ctx.topology.crypto_vf_ports:
-            params.allowed_ports = [ctx.topology.crypto_vf_ports[0]]
-        else:
-            params.allowed_ports = ctx.topology.sut_dpdk_ports
+        params.allowed_ports = ctx.topology.sut_dpdk_ports
 
     return params
 
diff --git a/dts/framework/testbed_model/capability.py b/dts/framework/testbed_model/capability.py
index b166014e0c..960370fc72 100644
--- a/dts/framework/testbed_model/capability.py
+++ b/dts/framework/testbed_model/capability.py
@@ -384,7 +384,7 @@ def get_supported_capabilities(
         )
         if cls.capabilities_to_check:
             capabilities_to_check_map = cls._get_decorated_capabilities_map()
-            with TestPmd() as testpmd:
+            with TestPmd(allowed_ports=topology.sut_dpdk_ports) as testpmd:
                 for (
                     conditional_capability_fn,
                     capabilities,
-- 
2.49.0

