Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD04D3CC86
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:28:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 693EB41143;
	Wed, 14 Jan 2026 23:28:38 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 0EBE841149
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:28:37 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47ee3da7447so1952575e9.0
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429717;
 x=1769034517; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=moii3MRh3lSxvET+One3okp49MFBriwurrJ9qdGHAJM=;
 b=SJee9lIVhJ/W/uQ4TJPaH6wtCpapQJ2Y6wyd22KhKbJj9/0N01vuxoHJ/753sxdLIE
 ysRBi7yTAIivVgv8RNsMEjk/qbpu3wpGCCnqW725RA4MCFw31xD2UKsTEPnq5xxK9hY3
 aKGjUjWxRCMltKEKXg4a1X3rG89yjnfWnBlgClzTwL9HWf6yecU8hv6tGis37DS5TBg9
 KFeGn2KV7rXVBOf3rWuQJuwpHR+y/09zqiX8pwDzlY5t4aNDYkw9vdkZQ6r1VlDDimhR
 /8vpY9Iqn4x3pwSzRVcJMHyfjbjVnYz/HQsXSYgHAGrf5vv8B8d3hsABU4fBRd1Q+IRA
 QsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429717; x=1769034517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=moii3MRh3lSxvET+One3okp49MFBriwurrJ9qdGHAJM=;
 b=D1In/D0snaQ7DJFNcMyXIkk1xUPa1uLTdEc4j2HmaDZAia7VZZHONZkvbo5Eh115KX
 1lvGGCpc5CV+eYeuPifT4J4Z4pRQg0+px8XvhEeYRgLaktec95DOc85wnKUeX5tLxctW
 gjuLqooUJAZvWb05Rmc1x9bchLu+TUe7Dw8xJ472lxgdp2ie5Ca/qD0uExkIcmjFquH9
 +ot8WsldXl33TS2LbxbtuLiy0uUO+mQ9QkiMFxYC1WYQ6eY4W5JDYUWQ5okvjdBNHZ//
 Km/X/XjB7/gLlRm8qVrJESTZ+uMpbXWmDzYRSzvwN4nZmb+rxtWnr1wxIBvyvZokD0jR
 zpeQ==
X-Gm-Message-State: AOJu0YwvtazPSibajlAtjJ3x+Ig3NUyKq86wgjy2uz+lceBv4z0MAkG8
 xlq/Wp0FAvk9h/NaEYOJsk3w8PPk1CCJKFbkRoRqAvaeWBpo+O6uOOFdvIqPd1FlA6+BxrSx114
 JGlU6
X-Gm-Gg: AY/fxX4u6asRHXy/vJh3cJRI0GcV3wHPSX5RBvRApvQ8Wc0jJ6t3a79dqbHs6PL1VpW
 d7E6cshzaWYLVeeDtc2293QipaBpM8r6iMvRa7tmm8wO+wQ8oS9hDvPdJMGEHYAYXTog0NCVm7D
 xht2KKPy36ZqehZapfgRJPPh2G+8+CBDqMYLNNlfMYXDETeK/v7rNNYRNNeGgMfpnWbPipL4Y9U
 8/q0bCZuzF9MTrRnMDe1scGQ2DE8kR9E/UqkNpSSnqYrEQmKO4GXzssnLwM40URcK5DRNLs838q
 GKS5o5IMBom8FOQbTCOQbmthN7eERV8FlFbsU+X+h4h/NjV43ZhZQpt7DpRDXN0MkNXRhqm7zJL
 N626rUj3H4GaceCa1HkX66DG2FKmQNj+tYKVVnV56Txk22C4k0jr+OtG3MoxcFqoGS46F0Ingc+
 vy6YYG8k+efHjmGmvC7q+oFdxFuW7vKE/KfiK6IyjX54TYS8CIEw==
X-Received: by 2002:a5d:64c5:0:b0:430:fbe1:382a with SMTP id
 ffacd0b85a97d-4342d5d949amr5090670f8f.54.1768429716642; 
 Wed, 14 Jan 2026 14:28:36 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434af653632sm1757198f8f.11.2026.01.14.14.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:28:36 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nandini Persad <nandinipersad361@gmail.com>
Subject: [PATCH v4 05/11] doc: correct grammar in service cores guide
Date: Wed, 14 Jan 2026 14:26:57 -0800
Message-ID: <20260114222821.87920-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114222821.87920-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260114222821.87920-1-stephen@networkplumber.org>
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
- Fix preposition: "two methods for having" not "to having"
- Fix reversed phrasing: "Disabling that service on the core"
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

