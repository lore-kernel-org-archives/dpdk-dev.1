Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3299C982FE
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 21:17:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0ECB442EDC;
	Fri, 16 Jan 2026 22:17:18 +0100 (CET)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53]) by mails.dpdk.org (Postfix) with ESMTP id ADAC642ED8
 for <dev@dpdk.org>; Fri, 16 Jan 2026 22:17:16 +0100 (CET)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-b872b588774so376030066b.1
 for <dev@dpdk.org>; Fri, 16 Jan 2026 13:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768598236;
 x=1769203036; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kVeo6HLFmF32rq3SecpgrbH0KBmoste6PA1VquLm6UI=;
 b=LiosN0A0ohdVoqbU6O25edY2KA9ya56ZJdVtR4WWIA0A617d1N28oDckAvmnIUVKPN
 1EN135q6P24/Gxk/Xrl2R6OJEsMLw8oJtBzUyvVswGiGN0ep8oLd+AbLtERRA3m22oqx
 sVJXFOvte7lE6Qf/CCiU3y2bXyHQeo8peBn/1dDJ1MFJwfmwqQ1VkPeiGKKWi5uA8ZeT
 s+2yvm7RATmD2/imPtkHKCpLmQ9WS1TRHpiy5HPpj48sjjHU0TNbj7xfqyZRGIwFvijm
 eQsfK9vC8qOF64Mv3l0JQVVHHruWNT75ykgmwvoD4O6Yf3Tn4OtDMorksjLMqE+G2FHD
 KKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768598236; x=1769203036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kVeo6HLFmF32rq3SecpgrbH0KBmoste6PA1VquLm6UI=;
 b=J6BxkUe+GbGJWsq6vzzIaaHoYfet5/h5hvwlbTKyJXLcpWPfl40wQrXv/nC0gXjPYe
 MmnaJ6V7YasiSJfWIVtwcZ3FhvyB4G45mHjPXr/1xUfLAE5dJFyfz4004z1UspbpAHEm
 Twu5LehaJgZWSuf22BgjRcjQLTs15UnvHM8H5greG2zqpYlX/AKzwcNa0jK2N7tCaA90
 bdFLtBeUGTbmzfCM9UwOF133KoiyGRFil+Eg1e78gjgaHjIs8+zODCVqAQt6Xfjgqq3l
 jRyvZ1kbGNVgTFhcTEu2NMH8ggpURPKeI9CeNP6lw49F7SZFwdPD09qZWkLlnJPCalZ6
 fXXw==
X-Gm-Message-State: AOJu0YxEy3Jf0CsTy5l6O3mu6Csyh23uvjyFZ+3LmB+5h2LFD1TOt1m7
 yMNEB4xtPWIgPXylle2tz9N1g6Ivisrc1c8coBn8YhDkH/InWIAccoEHBZYdrZ/Mx0vqAJhUWZa
 BmQOT
X-Gm-Gg: AY/fxX5q25TTq6y2OudWR+9l7bFxELJgYAHRflGGVYJ05RURCHYVZMIMivSrNMww09q
 wpltlKBkv1WqzMct+KJcg7VxEz8t+HPWWhXKVflXBcuVMomCESf1xE6YOuNlZGBLEJIfzW9qu7a
 vmxW9fMpOinqF3OCE0uS2csRuyF/jrATCEfU/f+lrbXzY9DjiGEx3d9RWZBfz8GcnsJ8JxCw+vJ
 tffoibpOaGYqv8jwu92Z/mbfsacheRubwLHsvIBWXIvyqNCi5B9qV2vLpghGOyxhe/blhw68wLj
 MXSyz9ald0ILSr6Tyf49cgxdAF+swE8xDpO7MzNZiT9qgpMZu434TvphvcuglrTlxLQVRw58cij
 kRMJcdbgJkRq3SYydzTyo/BCy8mmiBVpeYgB5++ywHrQVWHankoGuVOVH+dtBSNMpdGig8uBbLJ
 Q47DE3TVpRxbpHYf0TRFO4DoQZisMW4L0Ji8mqasr+4MyEhfLEkQ==
X-Received: by 2002:a17:907:d1d:b0:b83:32b7:21b0 with SMTP id
 a640c23a62f3a-b8792d65c51mr390404066b.17.1768598236244; 
 Fri, 16 Jan 2026 13:17:16 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795168ca9sm336649066b.15.2026.01.16.13.17.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 13:17:15 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 11/11] doc: correct grammar in Linux drivers guide
Date: Fri, 16 Jan 2026 13:06:27 -0800
Message-ID: <20260116211649.104776-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116211649.104776-1-stephen@networkplumber.org>
References: <20260116211649.104776-1-stephen@networkplumber.org>
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

Add missing space after comma in device list.
Add possessive apostrophe in "distribution's documentation".
Change "co-exists" to "co-exist" for subject-verb agreement.
Correct cross-reference direction from "below" to "above".

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/linux_gsg/linux_drivers.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/doc/guides/linux_gsg/linux_drivers.rst b/doc/guides/linux_gsg/linux_drivers.rst
index 739fc0226c..a7d64d486c 100644
--- a/doc/guides/linux_gsg/linux_drivers.rst
+++ b/doc/guides/linux_gsg/linux_drivers.rst
@@ -90,7 +90,7 @@ To see the status of all network ports on the system:
     =====================
     <none>
 
-To bind device ``eth1``,``04:00.1``, to the ``vfio-pci`` driver:
+To bind device ``eth1``, ``04:00.1``, to the ``vfio-pci`` driver:
 
 .. code-block:: console
 
@@ -120,7 +120,7 @@ To make use of VFIO, the ``vfio-pci`` module must be loaded:
     sudo modprobe vfio-pci
 
 VFIO kernel is usually present by default in all distributions,
-however please consult your distributions documentation to make sure that is the case.
+however please consult your distribution's documentation to make sure that is the case.
 
 To make use of full VFIO functionality,
 both kernel and BIOS must support and be configured
@@ -358,7 +358,7 @@ or PMD name matches platform device name, all in that order.
 
 VFIO Platform depends on ARM/ARM64 and is usually enabled on distributions
 running on these systems.
-Consult your distributions documentation to make sure that is the case.
+Consult your distribution's documentation to make sure that is the case.
 
 
 .. _bifurcated_driver:
@@ -366,7 +366,7 @@ Consult your distributions documentation to make sure that is the case.
 Bifurcated Driver
 -----------------
 
-PMDs which use the bifurcated driver co-exists with the device kernel driver.
+PMDs which use the bifurcated driver co-exist with the device kernel driver.
 On such model the NIC is controlled by the kernel, while the data
 path is performed by the PMD directly on top of the device.
 
@@ -428,7 +428,7 @@ It can be loaded as shown below:
    the Linux kernel may disallow the use of UIO on the system.
    Therefore, devices for use by DPDK should be bound to the ``vfio-pci`` kernel module
    rather than any UIO-based module.
-   For more details see :ref:`linux_gsg_binding_kernel` below.
+   For more details see :ref:`linux_gsg_binding_kernel` above.
 
 .. note::
 
-- 
2.51.0

