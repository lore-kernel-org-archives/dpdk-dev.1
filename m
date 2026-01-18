Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1540C9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:13:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B00C40676;
	Sun, 18 Jan 2026 20:13:34 +0100 (CET)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49]) by mails.dpdk.org (Postfix) with ESMTP id 7E71C40667
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:13:32 +0100 (CET)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-b7ffbf4284dso473518266b.3
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763612;
 x=1769368412; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x3Oa2m24XW7+9Rz+ym3m9B81Dg3/sQWOiuXf7SLS7vA=;
 b=RVRyDWyUUcPH1rFI6ZXOTkzb3xQMUzSy1HsoAP/TRg7byJ/6RuhbCk+AZAzHO7/r7e
 1BWAIindmcRuoZh0sj2XKVQXSlfMiqf4kD7aUYcIui5C002QTfr91TJ2x1CfA2qsJ3Rs
 H/XfSokXVmeqZ8t6CENWm3yoQ28BdbgO5PrnBJf1VBzBIhQL/vrtIoAgQVeJpWOhzvYj
 X32GD0CFR2+hpqyG4hxfjxgMwKiv1zVttf8q/sFOrCzKCXWbTGr0SntSz8aLDhnjfbwu
 QJHIgavqKhldRkzgPoNBotIqrAHpNPSD8vZsCETkApj6mqVx2aNcBsKcr5NgP0nOW7ZT
 cnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763612; x=1769368412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x3Oa2m24XW7+9Rz+ym3m9B81Dg3/sQWOiuXf7SLS7vA=;
 b=pf9uTGqKJSPAQF+NYd6FO3niFTGRgSkHNBoTfqf64H3dfNmtebauk46rMNYb9XsdF8
 IlVdTIVVLfAIqSV1uRUARp6FpGV1TLMQR/sSw3HG/qkdGjQAWJ68K6NMvqSeY5Jn2IWU
 JkXdE3zq3Pj2Gl+hEdmaA3e10ShicD9Igcqc4U2pTqV0cTmrWMK5J9onylZ8qa7stazp
 G6Buyi+dd7+fQD2YJlm6OmoTUSBwttOpZ7azfzsTM4RdC/9BtesuSDRclirY3Wkkp4lU
 6mWQgV8/6Yple+BnPSfAjfzrhVzA1ClN1QsbhsGxB+7Bm3lcwcnHCa0FxmxzqnHlgM3Z
 szRg==
X-Gm-Message-State: AOJu0Yxt23yYY5ulzuLaRx6J/zQeDYwdG8sjEeaeq7WD/YAMnRRNAZ1+
 X8OO8E9tDTWAc3Al2ndj80JlmZcMgD5LHW6BqPtyyRhBaktOhpZGE0tdM6M4ztM3pbCTGlVYb2b
 2aM9/
X-Gm-Gg: AY/fxX63qbrBeH1Vo+QvVzD1Jc9mWriGulXUh8EMdiQK/tEcMQeYoKRuzcwjQIX/daP
 4vbmR2iexpWpfi9OI6P9FM50KyfE/mb0+bAitpVXtzXcFBHQwwgYQFjUsFlMDLNH5n+jCLJysXa
 gwCgwpw2IVAEajjvqkXajo2Uo7ogcWn0BCvfcuVa8wWAsXEVsKDIUvM14MzXTg+3P7oRAqheLNN
 wOoVo87F/SXw89zizeAyPnb187l5DYoONeZb6p42m7ZA1ITeezlhoNOjnWuQ2l3Jf9vMilMRBe/
 eBwjM9rtbN786Lo23Ub7Gkc+nE8in/TWhBpEcjoVgyoQqY+kb7Fg6Fho1X7gUaZe6fU+dfNhKyA
 Wjc1xl0xrmj/49bQ+i3btd34vWIYZ5lJnjmU6U6Sd+STGYsLyi+yk5yESH/jQLgHuF4BHzqIGx0
 p9L0OAowhGNN5GX2mESE9O3ZyZA2wDHXxxUM1DeG7NVpIO6vZW4AvKUghWM+ZX
X-Received: by 2002:a17:907:928c:b0:b87:35f:fa3 with SMTP id
 a640c23a62f3a-b8792dcdfb7mr724214266b.16.1768763611859; 
 Sun, 18 Jan 2026 11:13:31 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:13:31 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nandini Persad <nandinipersad361@gmail.com>
Subject: [PATCH v5 02/54] doc: correct grammar in service cores guide
Date: Sun, 18 Jan 2026 11:10:05 -0800
Message-ID: <20260118191323.241013-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118191323.241013-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260118191323.241013-1-stephen@networkplumber.org>
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

Changes:
- Use "abstract away the differences" instead of unclear
  "simplify the difference"
- Change preposition: "two methods for having" not "to having"
- Change reversed phrasing: "Disabling that service on the core"
  not "that core on the service"

Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/service_cores.rst | 30 ++++++++++++-------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/doc/guides/prog_guide/service_cores.rst b/doc/guides/prog_guide/service_cores.rst
index 5284eeb96a..ee47a85a90 100644
--- a/doc/guides/prog_guide/service_cores.rst
+++ b/doc/guides/prog_guide/service_cores.rst
@@ -4,12 +4,12 @@
 Service Cores
 =============
 
-DPDK has a concept known as service cores, which enables a dynamic way of
-performing work on DPDK lcores. Service core support is built into the EAL, and
-an API is provided to optionally allow applications to control how the service
-cores are used at runtime.
+DPDK has a concept known as service cores. Service cores enable a dynamic way of
+performing work on DPDK lcores. Service core support is built into the EAL.
+An API is provided to give you the option of allowing applications to control
+how the service cores are used at runtime.
 
-The service cores concept is built up out of services (components of DPDK that
+The service cores concept is built out of services (components of DPDK that
 require CPU cycles to operate) and service cores (DPDK lcores, tasked with
 running services). The power of the service core concept is that the mapping
 between service cores and services can be configured to abstract away the
@@ -18,24 +18,24 @@ difference between platforms and environments.
 For example, the Eventdev has hardware and software PMDs. Of these the software
 PMD requires an lcore to perform the scheduling operations, while the hardware
 PMD does not. With service cores, the application would not directly notice
-that the scheduling is done in software.
+that the scheduling is done in the software.
 
 For detailed information about the service core API, please refer to the docs.
 
 Service Core Initialization
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-There are two methods to having service cores in a DPDK application, either by
+There are two methods to having service cores in a DPDK application: either by
 using the service corelist, or by dynamically adding cores using the API.
-The simpler of the two is to pass the `-S` corelist argument to EAL, which will
-take any cores available in the main DPDK corelist, and if also set
-in the service corelist the cores become service-cores instead of DPDK
+The simpler of the two is to pass the `-S` coremask argument to the EAL, which will
+take any cores available in the main DPDK coremask. If the bits are also set
+in the service coremask, the cores become service-cores instead of DPDK
 application lcores.
 
 Enabling Services on Cores
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Each registered service can be individually mapped to a service core, or set of
+Each registered service can be individually mapped to a service core, or a set of
 service cores. Enabling a service on a particular core means that the lcore in
 question will run the service. Disabling that core on the service stops the
 lcore in question from running the service.
@@ -48,8 +48,8 @@ function to run the service.
 Service Core Statistics
 ~~~~~~~~~~~~~~~~~~~~~~~
 
-The service core library is capable of collecting runtime statistics like number
-of calls to a specific service, and number of cycles used by the service. The
+The service core library is capable of collecting runtime statistics like the number
+of calls to a specific service, and the number of cycles used by the service. The
 cycle count collection is dynamically configurable, allowing any application to
 profile the services running on the system at any time.
 
@@ -58,9 +58,9 @@ Service Core Tracing
 
 The service core library is instrumented with tracepoints using the DPDK Trace
 Library. These tracepoints allow you to track the service and logical cores
-state. To activate tracing when launching a DPDK program it is necessary to use the
+state. To activate tracing when launching a DPDK program, it is necessary to use the
 ``--trace`` option to specify a regular expression to select which tracepoints
-to enable. Here is an example if you want to only specify service core tracing::
+to enable. Here is an example if you want to specify only service core tracing::
 
   ./dpdk/examples/service_cores/build/service_cores --trace="lib.eal.thread*" --trace="lib.eal.service*"
 
-- 
2.51.0

