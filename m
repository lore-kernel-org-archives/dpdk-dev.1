Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C68FF483DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 18:11:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CCDF40648;
	Mon, 23 Mar 2026 19:11:30 +0100 (CET)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id 8F95940647
 for <dev@dpdk.org>; Mon, 23 Mar 2026 19:11:29 +0100 (CET)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-8ca01dc7d40so44704985a.1
 for <dev@dpdk.org>; Mon, 23 Mar 2026 11:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1774289489; x=1774894289; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N1z7X9fG8xhQQMkhs+fDuMVGoBZkpjIZ2mAVnvylx8c=;
 b=JomfN8WnePXSsV+zYwSnBcev2FPpSXj0c7ke3lLA+g2D0TDlmqw97jebL9RoslfNw8
 00PcSTdrVTAlZJU9PCSwQSe9C1Wcki3FHxk3CYiTkw5T2AT20XJFYLH9DJp/oyxzwbWK
 vqhnoROJ1u+KhV0hLk6Ef45c8jlBZSXx2asrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774289489; x=1774894289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N1z7X9fG8xhQQMkhs+fDuMVGoBZkpjIZ2mAVnvylx8c=;
 b=ejNLwT9Y5jxbgbYwaT408lDRdCQt2gtjPpmJcSWjmsuliGnyWPNfatsTAfNYNG7UMS
 o+uD5H7+/acU3Si2HmWEHBVyMvslZKSfN+NabbCijxS8goR12OjUc/bmMYPQgI6DKHRo
 2v6GfL9tducDZ6tFv6u7rx2pgjX9T6wkfWX56Tpkx1ZRiJRM3nbtZ5DH1ShVgOTbs/2D
 gPb0ewUqvNmg+ULMGGJDuteZBDnlVlW4VYE7kXn7RD1PD6/5dFzxsiB/e9N8Q6A1Cx70
 GsiwXTHkOM24KAcNZ156gNMQL8v1+f6G4M47GxjE1RlpUHz9DveFllXuKQk4mudUSLxy
 aXfw==
X-Gm-Message-State: AOJu0Yx/V2rRpw4/fjDj17ZHn4QIRTDe5rny8u2VT8pyM2PQv+NVVRyK
 1+6evXDZH/dkpYLt8Tyz8Y8K3Ku74BGJytV01m/j4EpiSXpNVXdT9a5hfTjdR9hrZCA=
X-Gm-Gg: ATEYQzzolbMaVzc5zguWOCwJKozA2vRWr9WWNdk3NKzNSr3NyI6NcRIdNv6XR2jUswe
 upu8ZZv0n+PqzgfRnka7J3zpMnbjctnNeryNeWxgWsCPlE93erp+AurpKV5Jas9Vzu34xObVX9O
 Re8Vt/dyBtxxvYbEyeRQblxf2c/rMrD+zEFJ7lkg1mn6aF4/Hn/f4zrG+z0FYOmM27OafkplseA
 j1778J544eUF2+ItPWmvSzbfGJ/JjuPPWM/0ovOCZMRjdvci4DWyh9SeYcuVnNbaYnSdr2EhDDK
 ma6lC0IIb55PKZswNcjOabqfhaGB6haM2ftwi41ekqZUb+juhCj3NICVdsVM7CfV1mK/Mtmazqf
 bh8O/NVLCDur4IP05idDZZh6EDy9DYL5hfpxyjjmQq0YP1/PjGfxsQZ0vbUgeeRH5PZqg6XmdgI
 vHU+uXzXuHmUAqv4K1XX4q2B+uwUCGU8sJTB6y1HbyeuLaC3eMMxQABFa1BbkELKPo+G14ycL4h
 K/szwT6aiY8
X-Received: by 2002:a05:620a:4505:b0:8cf:c1c2:908 with SMTP id
 af79cd13be357-8cfc7e8c3f7mr1982714485a.23.1774289488884; 
 Mon, 23 Mar 2026 11:11:28 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1210::224])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cfc908d8cfsm841462885a.28.2026.03.23.11.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 11:11:28 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, abailey@iol.unh.edu, dmarx@iol.unh.edu, knimoji@iol.unh.edu,
 Paul.Szczepanek@arm.com, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v1 1/2] dts: always use ethdev ports to check capabilities
Date: Mon, 23 Mar 2026 14:08:17 -0400
Message-ID: <20260323180818.674041-2-probb@iol.unh.edu>
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
Tested-by: Patrick Robb <probb@iol.unh.edu>
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

