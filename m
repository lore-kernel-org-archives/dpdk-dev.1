Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1A1D30CEE
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 23:01:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCD0640689;
	Wed, 14 Jan 2026 00:01:11 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id D17C740613
 for <dev@dpdk.org>; Wed, 14 Jan 2026 00:01:09 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-47ee07570deso4895425e9.1
 for <dev@dpdk.org>; Tue, 13 Jan 2026 15:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768345269;
 x=1768950069; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=moii3MRh3lSxvET+One3okp49MFBriwurrJ9qdGHAJM=;
 b=ejVqKPxe0Ad3gWrBd5dKqPT12q4yqbutaM/EvdAvNEh3iVoc4bdmZj3WfRwcQULQS3
 a3gW2DyBAR7HV0u/WDRDx82reRE1moiU/4gzqQF0qUwM0yMK45AW+aignd1GB38cV7+P
 JPjnMOA/HDVUvB0yLtswZnAnxHCGSlxyccv2B2ULz7q6Mzm6/UbfrLO05WeZhWJ1ML79
 q6BRCy8h+VWjZ/wmi+U3NRG9tqe0mptl+v0zU6pJ+lzSRBTSW11A4gYX6/EGG2jfKyFu
 ke0G9fpr/J0JdHuaaVzNa2XGqQLY/zbh3qLlkrQK3XC1FdVQIplw903hwG/vH4IIuWh2
 /lng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768345269; x=1768950069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=moii3MRh3lSxvET+One3okp49MFBriwurrJ9qdGHAJM=;
 b=waXiX6rM4PnE/fLeLvPOFUJPawgHLLrqwAi/OikvqaSOtCMJJB3WesYcBa773yzGC/
 9D5LBHiUW7wBLf3toXwb1L/AvOzgHXFGXmFrNVs7E5bFr7Kpe0j1maswbJpFuN1m0+hi
 CGn1kAAqRwi+0Bpfis5UEJvtbYRwNE7/9qjA3/4d31ebZYa/MhfeAsSpB6f9kxLLeiCn
 Lt5rpgeQ9j50kB6MWeZhzTP8o8d/SfOAFDAbE73YptomSKdthdtOEUs8Hs6IqDrj5X4q
 UAS4blGFks2/AUGZEJICfA35ZIcxVJtiHVBkrJ4ET3QaU6kVH8WsEs6xNwZFk9fHafyP
 AJ3A==
X-Gm-Message-State: AOJu0YzOyUo2WI8lKrMpP/QHm1Iybzn8vHC4w7yXC8zePaN7NeugZnAG
 fSXL3Opd9fQePamixploKYwUMUsoNA/pyyOFr515WoFfmOoLHkgVKNo4LwCnCFfrkiVt5eEFdzK
 uuRfQ
X-Gm-Gg: AY/fxX65X7ffmE4t2ajGumjmcZl149gjW1gQ5SAv4IjCuMmu8mVo3tzGvJUdLDbb2Zq
 yDY3ts+hERZyXQWvr7tRy8Mcl4F4IH6K56VV7bqroWxBzARWWhbjwQbFiQZSOkRUqxwubFwvLd9
 GXh5KhsbnvcJZY8sreZ7XCi81yJ3VcpE7BXyRfFacmA2GrjeVK101sdTfdCHsS8gDyiBeR83fin
 5WZoPWWVhFRjc0TJ0MGHDsggUl5fbxjmALnDa42sYpyaTgiMnSNGC23CiRyNxzyWS3tA7X5f7/z
 WycW9vhiHQZM+k61J+WJVdQGGf+xIHuPBrFGUUOSRXNu06Gddj1XZvE3s7KlSh+EOhj0u5PHoXf
 ahzeUp8eRejc/lcA1BD9dPL2lMJh0FIyXuWRFmxD9Y2Ir2b8MEnaLa4o2izPR3hibnb14sjAZhQ
 vIkNBZ4UzQZnZK0BsHKQYKVkHdK09fLK410zDtVLmJc28QTtTzltFamlFMbWlS
X-Received: by 2002:a05:600c:34cd:b0:477:55ce:f3c2 with SMTP id
 5b1f17b1804b1-47ee32fcad5mr7855775e9.14.1768345267748; 
 Tue, 13 Jan 2026 15:01:07 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df8besm44977200f8f.26.2026.01.13.15.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 15:01:07 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nandini Persad <nandinipersad361@gmail.com>
Subject: [PATCH v3 05/11] doc: correct grammar in service cores guide
Date: Tue, 13 Jan 2026 14:51:07 -0800
Message-ID: <20260113230052.54435-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113230052.54435-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260113230052.54435-1-stephen@networkplumber.org>
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

