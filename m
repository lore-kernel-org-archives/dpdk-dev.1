Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EB8D3CC86
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:25:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D00540E1F;
	Wed, 14 Jan 2026 23:25:10 +0100 (CET)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65]) by mails.dpdk.org (Postfix) with ESMTP id C6A5F4027D
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:25:08 +0100 (CET)
Received: by mail-wm1-f65.google.com with SMTP id
 5b1f17b1804b1-47a95efd2ceso2675285e9.2
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429508;
 x=1769034308; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dYoDLNv+vkvUGsCs4aQd7a41sMOaAhjO2s/Dg6Zr2is=;
 b=cDk3XxIFCq9zJgzCVza0LyrANZeYQe50tI/wDr/Sy3/ELJJjPmhgSacYGhzMi/Uu5g
 0ttTnJtF/rpRYdqZIhUz5lLUACb/enZbmVLUENvvgmDqAPpN88WrwQ6DGB2QnKHMjA53
 QZBtwup6otmJvzB/H6y1bwUQTfW0aovD/alar3cK0WW1i0JwXAGsZP6H7mHi6m0Ia+Mc
 weJjY9gVegiKpeROWsZqSHVk02YgpFDYtQRI83V6ugv/AF+WQA/9XWRBRljVdIgnyX00
 UQkfarS0RNLyppHTPPuWABY9Iuh6DReHpfjbcqe1BvXW7RQUTXGnBYgs5xGy+Qg2elEw
 Z4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429508; x=1769034308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dYoDLNv+vkvUGsCs4aQd7a41sMOaAhjO2s/Dg6Zr2is=;
 b=X4vsYXn2rBWfSfvOCgu4qwMhJ6h13++G47Krc/akFjeNPb6tA1cuvQMo3dwVScilnB
 AaeijgOlYD96f5z0+d5I9pp00PW6wUnUOb2jeUcK6+EAkACuRGTgxniN3v67173O8WUz
 k3Ugzs3u8HFPWjiPxAxPFzEpqXSCdAEVoHQo1ctBvm7iBgF8EVe9RlUgsGPA/1iT6+CY
 e9mgTNAtmBrKXt+EfwC7U5st0JjKyTsUUfKsrikK7R9X1u1cSXzOU5wbBBYkqRRn/Mop
 b89tjqM3lClEuKews4dQXLMkwHoW3JAPyS3o+he5OZZeobnNwqx4aTROiqrZG/8BNIDl
 7mtA==
X-Gm-Message-State: AOJu0Yw8f1if76ojAY7RuBCmW3k3EBS7UDqF0kn2NkexAM/fbNH7rZSH
 qooYwHsXAZOfF0Q25dZ32LR7s+HRtc22nrlB8fwUcpUwDkDQCAZZEHokK2WvcDVy+cebsQWiZZn
 XCfwWzis=
X-Gm-Gg: AY/fxX6FbntuZ5xXsC9mSBvrqIteWcGdJkYRBEux+9E0lnKpqFtNj1m9N/HdWdmo48A
 38M6qZ44bqAAi5R32eE+1WbaL8kdBBAqn4YNRO32lRc6RX4mikeUY89lugIfTgY5656PIN5DVpL
 7pnHH3Toj6kd7AlS7NBNjaUIW34vAxSFcHWspSmkoSaZSyf/OstOp2zqsfWpgZ74UsBMkK9Ano4
 MAgatJIbtWUFt4ebeEYaoC8pU/1RQ1UMX2IGamcajFV7qcfpP7vBuFBuut88jgDalHO1UR36DaM
 OoxlxWI6OTwrwi/hwAWDTGgsIBGEH6iHW9afdOCMl/7d9c2x+XiWv0LQbmaWaN2Y25K4PdQLwyT
 JYfnO6O6F3onMVruCFF+EI6Bpw8HDM+unOY6enmkKEiv5UOno7xMVTtQHbSXAueW0/n+D0z9kQy
 P2de6Sfd8lSOwSYAir0floR/BqY8FhaT1j//COrpaAN7xQechqJQ==
X-Received: by 2002:a05:600c:19cb:b0:477:93f7:bbc5 with SMTP id
 5b1f17b1804b1-47ee47c91camr37228685e9.10.1768429508236; 
 Wed, 14 Jan 2026 14:25:08 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm12040355e9.9.2026.01.14.14.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:25:07 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 03/29] examples/service_cores: correct documentation errors
Date: Wed, 14 Jan 2026 14:21:44 -0800
Message-ID: <20260114222458.87119-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114222458.87119-1-stephen@networkplumber.org>
References: <20260114222458.87119-1-stephen@networkplumber.org>
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

Address errors in service cores sample documentation:
- Change "registering applications" to "registering services"
- Add missing word: "can CPU cycles to" becomes
  "can provide CPU cycles to"

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/service_cores.rst | 41 ++++++++++++----------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/doc/guides/sample_app_ug/service_cores.rst b/doc/guides/sample_app_ug/service_cores.rst
index 307a6c5fbb..cc44857d41 100644
--- a/doc/guides/sample_app_ug/service_cores.rst
+++ b/doc/guides/sample_app_ug/service_cores.rst
@@ -4,23 +4,26 @@
 Service Cores Sample Application
 ================================
 
-The service cores sample application demonstrates the service cores capabilities
-of DPDK. The service cores infrastructure is part of the DPDK EAL, and allows
-any DPDK component to register a service. A service is a work item or task, that
+Overview
+--------
+
+This sample application demonstrates the service core capabilities
+of DPDK. The service core infrastructure is part of the DPDK EAL and allows
+any DPDK component to register a service. A service is a work item or task that
 requires CPU time to perform its duty.
 
-This sample application registers 5 dummy services. These 5 services are used
-to show how the service_cores API can be used to orchestrate these services to
+This sample application registers 5 dummy services that are used
+to show how the service_cores API can orchestrate these services to
 run on different service lcores. This orchestration is done by calling the
-service cores APIs, however the sample application introduces a "profile"
-concept to contain the service mapping details. Note that the profile concept
-is application specific, and not a part of the service cores API.
+service cores APIs. However, the sample application introduces a "profile"
+concept to contain service mapping details. Note that the profile concept
+is application-specific, and not a part of the service cores API.
 
 
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``service_cores`` sub-directory.
 
@@ -39,8 +42,8 @@ pass a service core-mask as an EAL argument at startup time.
 Explanation
 -----------
 
-The following sections provide some explanation of code focusing on
-registering applications from an applications point of view, and modifying the
+The following sections provide explanation of the application code with focus on
+registering services from an application's point of view and modifying the
 service core counts and mappings at runtime.
 
 
@@ -48,7 +51,7 @@ Registering a Service
 ~~~~~~~~~~~~~~~~~~~~~
 
 The following code section shows how to register a service as an application.
-Note that the service component header must be included by the application in
+Note: The service component header must be included by the application in
 order to register services: ``rte_service_component.h``, in addition
 to the ordinary service cores header ``rte_service.h`` which provides
 the runtime functions to add, remove and remap service cores.
@@ -80,7 +83,7 @@ Removing A Service Core
 ~~~~~~~~~~~~~~~~~~~~~~~
 
 To remove a service core, the steps are similar to adding but in reverse order.
-Note that it is not allowed to remove a service core if the service is running,
+Note: It is not allowed to remove a service core if the service is running,
 and the service-core is the only core running that service (see documentation
 for ``rte_service_lcore_stop`` function for details).
 
@@ -88,9 +91,11 @@ for ``rte_service_lcore_stop`` function for details).
 Conclusion
 ~~~~~~~~~~
 
-The service cores infrastructure provides DPDK with two main features. The first
-is to abstract away hardware differences: the service core can CPU cycles to
+The service cores infrastructure provides DPDK with two main features.
+
+The first is to abstract away hardware differences: the service core can provide CPU cycles to
 a software fallback implementation, allowing the application to be abstracted
-from the difference in HW / SW availability. The second feature is a flexible
-method of registering functions to be run, allowing the running of the
-functions to be scaled across multiple CPUs.
+from the difference in HW / SW availability.
+
+The second feature is a flexible method of registering functions to be run,
+allowing the running of the functions to be scaled across multiple CPUs.
-- 
2.51.0

