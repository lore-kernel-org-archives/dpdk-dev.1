Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B00AC87FDA
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 18:22:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C8D34068E;
	Fri,  8 Aug 2025 20:22:21 +0200 (CEST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id E558740270
 for <dev@dpdk.org>; Fri,  8 Aug 2025 20:22:19 +0200 (CEST)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-7e811828b2fso311599385a.0
 for <dev@dpdk.org>; Fri, 08 Aug 2025 11:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1754677339; x=1755282139; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7HX8uShdWKRk8C92Ew7m16lX/yy3di07nmqT9d/AO3c=;
 b=Tl3ayaOSlx7RxJtWmloW4f72I9N5PVVVNORfFfq5Qlh4gEEe5Ns5CE3VRzkIbz1r+y
 +9wNdXmcpiQ70aw1CMFoghMlkU5rEIMWzkT+lSXDSmkxDOl+IHDWh/EFuk8SjPBtWo/d
 UN/DjRLSU2Rew9gJKt7EFYJ8otjs8LWJ4dMdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754677339; x=1755282139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7HX8uShdWKRk8C92Ew7m16lX/yy3di07nmqT9d/AO3c=;
 b=RUQ23+VjOUfFWNndbKFPmvnamWJjEsLGhDIq8dM8AaLlJBwZfxaSIZOZ8UM0FiLvMC
 W+a4IwGjMLUaf82s//PIktVbQsKkeqSkk0TzVvqshYpRv3PikWXrHSalhJf+GnYaEZ0r
 r5PtpVJSPer/GlcMlAaOGtIWTe5L8oNdGEjwpJrOBjNmtxdMesj1VCdo/8WCggcF5c76
 mNBxu/birwxZz1UF+X8G1SnA51wjkvTKAi4hwR4tYywINT7CYw0CkjQkzmtL84HkMbLu
 8dv6eMFlo8/c4MpQXxLGD/S7C9h+iZqdkafYksw6lnLG+VO3l7IUrG9RkfQwQ1moOSPS
 IKyg==
X-Gm-Message-State: AOJu0YwONOOLUe6aU2gEMs7/4aH+B6DcEy9uHQFa4wbxx0U0Ox+d4aeO
 GQlVn2qkMzLiD5BW7GODPNEdaeELOO6k1TiEutjcoIq/ps5kxwfsVX8LJevAQKsjPoc=
X-Gm-Gg: ASbGncuALCVpCaTiAhj3UwnamRape8MDTZav5T8fPor6u02KQhvtV/CGBNh+EElXyBD
 iMSkkKt83t+ttt/qZ2yr34pmqXpv2jGyxSL8ryZmDduZasLzWoLDEQNbxczQ/o79KKB0QLRlHc+
 ShBc7pnJPPVc3JzryXDw3qYTUSJKSbIn8YaWlqjuiTpSOpoP+ZaJEbPcVyrjh3xvvWbsEyH3Phe
 ERz3sU3dpfx7e4dbZhtDTJR2iCGVLuyrnYi6ogXlRzxzAyX7cHuB33psBYiKZUvf/s/pIr1ewm6
 q3sOkGp7h5Asmn4gpiKv2iV18gvkGNsMMmDO7De2N6MrXmZ91LtuU/pdjbzVyRLsTx4l091w9h5
 HcQ0S8TuVo2jRz/N/UTZ2nCj5kFbw1TW4BA==
X-Google-Smtp-Source: AGHT+IHE2s76zMtLEyKoxEXwtTqPdAaajRdKqEcJsQsgBhzB1Alnu8GBC/u5862LBKPCuCeWfmWm2w==
X-Received: by 2002:a05:620a:223:b0:7e8:189a:107d with SMTP id
 af79cd13be357-7e82c64f0admr484951985a.13.1754677339163; 
 Fri, 08 Aug 2025 11:22:19 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:a136:b4d:e75:44c4])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e812e90ee6sm500685185a.49.2025.08.08.11.22.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 11:22:18 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH 2/2] dts: enable port binding on the TG
Date: Fri,  8 Aug 2025 14:21:09 -0400
Message-ID: <20250808182152.356879-2-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250808182152.356879-1-abailey@iol.unh.edu>
References: <20250808182152.356879-1-abailey@iol.unh.edu>
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

Currently, ports on the TG are not bound to the correct drivers prior to
running DTS. This causes DTS to crash if they are not initially bound to
the intended drivers.

Leverage TG runtime environment to bind TG ports to correct drivers
before and after running DTS.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/framework/test_run.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 274dceebfd..16d7781536 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -114,6 +114,7 @@
 from framework.remote_session.dpdk import (
     DPDKBuildEnvironment,
     DPDKSUTRuntimeEnvironment,
+    DPDKTGRuntimeEnvironment,
 )
 from framework.settings import SETTINGS
 from framework.test_result import Result, ResultNode, TestRunResult
@@ -169,6 +170,7 @@ class TestRun:
     ctx: Context
     result: TestRunResult
     selected_tests: list[TestScenario]
+    tg_runtime_env: DPDKTGRuntimeEnvironment
 
     blocked: bool
     remaining_tests: deque[TestScenario]
@@ -203,6 +205,7 @@ def __init__(
 
         dpdk_build_env = DPDKBuildEnvironment(config.dpdk.build, sut_node)
         dpdk_sut_runtime_env = DPDKSUTRuntimeEnvironment(config.dpdk, sut_node, dpdk_build_env)
+        self.tg_runtime_env = DPDKTGRuntimeEnvironment(tg_node)
         traffic_generator = create_traffic_generator(config.traffic_generator, tg_node)
 
         self.ctx = Context(
@@ -343,6 +346,7 @@ def next(self) -> State | None:
 
         test_run.ctx.sut_node.setup()
         test_run.ctx.tg_node.setup()
+        test_run.tg_runtime_env.setup()
         test_run.ctx.dpdk.setup()
         test_run.ctx.topology.setup()
 
-- 
2.50.1

