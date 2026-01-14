Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB418D3CC82
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:27:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 490AD4278C;
	Wed, 14 Jan 2026 23:25:45 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id F114342788
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:25:43 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-47d5e021a53so2357105e9.3
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429543;
 x=1769034343; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sJ/lnkNwLpdlrdVRZ6w783YZgKeBzQ48YRSH6oWps8M=;
 b=EZU41pSBLFG2nniSZPZVVPTeaWeRydXEjsrG18s+jEG7EEG6G2i3mUQhvU8kx5B+DD
 SljYipNW1TgDhCLRTBwPgUpCWiLKhPmK+mdNZ4vJfjVQxiCr28ATcZegkAebql5AEBtv
 DhebxqUhr05fX0n9q31E8apSjYZ5e8aaHzNe+9jDcX+RZW7oY3Hdi33MHjBrGurD+do/
 APBxZb9DOvDWSD90TpsRwZ7vL2f3jkmQi9YWWlIp6hWqafnuTOhQ1oXgTCbFhAhvcryf
 t0IqciG1V/uDYV0XDas9cpAvsoygow3LFJpGdDDEKpzS+rZeRkK0hYQ1LuaOaSSUnW0k
 1wsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429543; x=1769034343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sJ/lnkNwLpdlrdVRZ6w783YZgKeBzQ48YRSH6oWps8M=;
 b=wQGN/ThMGxwiBfXvDE/G1NNJ46Ys+ZnGmgtoWnHdw0RPznpRlLUj44nWMK/aT35uuW
 7KHFW+vJJ7HIDw0tO/0+LEti/b6vSKMXuBmDH0ak96G9x0ucQpYurQ9HPeiGdQ+zMj6v
 FbB/hI4fagl70svNCCxAE2fob46UyaJBzCqxIBmE4y1TWUE/hEyS0vMQqLIgZbhAK9PB
 hf2qw7m0iL1/u/zX6aL4ebmH+3OMFHMDv6/JIuQY78gZfSSsepvu6hbD19cCWgBvYbBU
 Wwxq7tCdAkA9Zeq9PTuX8aAGJaLAjgnSo9KXF1IgoOqvog8ZUrrZoCibOA34y3vBu2qR
 ZO4w==
X-Gm-Message-State: AOJu0YxUwFr2ojooZsTkl6O26c++c6prBi8EydTB4mjNESFA215tMciI
 U7R0DF3pTcwquRyFEcsBmCKVS9T3qPVNdYVVmZg2i1CZ8ndBgfZZuD2ulCQ8AvyKJqRWJBjuzys
 m7+b7
X-Gm-Gg: AY/fxX5/ewMlabvalfJvOrk9Ux8vfBmivaPE9oi6L8oEMyMRo9amBbtYV9Fa+bnRte3
 MR+WNscET54c/VaWLC9vcW45jvywaQq7ovS+OQhmBdXrNMSSVcNtQy1jSdem882TfKemXDbuPba
 egoULAKsiHw+QBTjH0cFVZBsg5dyFhrRkQ0aZMs3u67fsjfMxxmEs90ZQa5OzpdE3mdsyqB8jJ8
 jB/C+0zn5L23Xy+PD/tgB9bzhcyx53lCEZCdKI93EJ11dRXK3l2cr4gYIdt+HOKOZATQ1GMg5vF
 vRAWcDO6yXYskVBnKOHdmFWraPBXieL4G6YJ/3RIFNYAIrEuWQ+KfQv06YdI+tFclvirhXmBF5k
 0Ji2O64ImX5ZUqqdQ0VDOrxZj0ihL4RPY+vOSI14iBn1s/v1ZKP290y48s0J62MGULvsJfeeRrb
 hnRIEv6fk6A+Y9pukr6wgfnxg1QpwCpuGRrYmZi/0+llNd5QcCbg==
X-Received: by 2002:a05:600c:a088:b0:47e:e20e:bbb4 with SMTP id
 5b1f17b1804b1-47ee4825ebemr44552065e9.26.1768429543556; 
 Wed, 14 Jan 2026 14:25:43 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm12040355e9.9.2026.01.14.14.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:25:43 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 23/29] doc/guides: improve link status interrupt sample app
 guide
Date: Wed, 14 Jan 2026 14:22:04 -0800
Message-ID: <20260114222458.87119-24-stephen@networkplumber.org>
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

Improve the link status interrupt sample application documentation:
- fix spacing in command line example
- capitalize Linux consistently
- fix "that related" to "that relate"

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/link_status_intr.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/guides/sample_app_ug/link_status_intr.rst b/doc/guides/sample_app_ug/link_status_intr.rst
index fd4e32560c..133c8d0b2a 100644
--- a/doc/guides/sample_app_ug/link_status_intr.rst
+++ b/doc/guides/sample_app_ug/link_status_intr.rst
@@ -40,7 +40,7 @@ The application requires a number of command line options:
 
 .. code-block:: console
 
-    ./<build_dir>/examples/dpdk-link_status_interrupt [EAL options] -- -p PORTMASK [-q NQ][-T PERIOD]
+    ./<build_dir>/examples/dpdk-link_status_interrupt [EAL options] -- -p PORTMASK [-q NQ] [-T PERIOD]
 
 where,
 
@@ -50,7 +50,7 @@ where,
 
 *   -T PERIOD: statistics will be refreshed each PERIOD seconds (0 to disable, 10 default)
 
-To run the application in a linux environment with 4 lcores, 16 ports and 8 RX queues per lcore,
+To run the application in a Linux environment with 4 lcores, 16 ports and 8 RX queues per lcore,
 issue the command:
 
 .. code-block:: console
@@ -84,7 +84,7 @@ Driver Initialization
 ~~~~~~~~~~~~~~~~~~~~~
 
 The main part of the code in the main() function relates to the initialization of the driver.
-To fully understand this code, it is recommended to study the chapters that related to the Poll Mode Driver in the
+To fully understand this code, it is recommended to study the chapters that relate to the Poll Mode Driver in the
 *DPDK Programmer's Guide and the DPDK API Reference*.
 
 .. literalinclude:: ../../../examples/link_status_interrupt/main.c
-- 
2.51.0

