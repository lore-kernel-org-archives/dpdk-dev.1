Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4D2C3601B
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 23:25:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9E1A40687;
	Thu,  3 Apr 2025 01:25:02 +0200 (CEST)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47]) by mails.dpdk.org (Postfix) with ESMTP id 3B4B340667
 for <dev@dpdk.org>; Thu,  3 Apr 2025 01:25:01 +0200 (CEST)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-6ecfbf1c7cbso5169786d6.2
 for <dev@dpdk.org>; Wed, 02 Apr 2025 16:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743636300;
 x=1744241100; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tvvQ+GO4Ve/0j3NQZCqxCqtAkmABcp1kqRW975ztAd8=;
 b=L5W2TkhdDBB5Prv4afMr4aY3l283v0js/eNKcqGqSQ4nbwDVaDOeZWiANX2MgC9kbZ
 mRPAE9FWRpIR9S2BMIhMZv/8n0Wg9b287dU2brdHBO9y5A9LBdveGAmK58d0d8Yv7FRh
 1O69QdWqR6qaL35eQDXhIctC9ZQ6/yIGx64ELXomdeMJhL3tME7fphgnejkxIUfdCL+n
 lfK8bBUxLTb6Mn1Qt+K4EJBye+S1BzbfahUm0tgN7kgk7oauSViAz/0APL0QI6wpY6F7
 JQ80sSc1WDxJmSNTgSjFlDa0QKbytYw1Xe7zpCg0M96emMF/HxjOz1bWmsxwcIA9P8q1
 iCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743636300; x=1744241100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tvvQ+GO4Ve/0j3NQZCqxCqtAkmABcp1kqRW975ztAd8=;
 b=hsyowk1qQi1CAo6TDyPohGTeKl70LDgWPsttD7COmyjtGQiH22RZtCWAZFC91rkPSt
 rt7Fz2yU/uaVPIICE8Q8Cx5T1NLl4+YJ1TEQQpwnUY1mij0Ta761iW/9e/dtl+h1uxrN
 wtnYifVVxFd48AXsaq7szeCCnTEl9MNma+WC7ANPnCqKzS7VvRF/1IZESXNm3zAeJq3L
 1ktFS7DFqlIT9UT954Dgd2VDN5vZSBMMy0ub122BmiEhZbAh7/ERxF6J1jUqdS7ywM5a
 vtH4zUacSTHeXcZuVBcoris3ug3bE2XgCK9bEocQW3MjQJU6ID8qMeemZpaQXRNaEd4G
 GecA==
X-Gm-Message-State: AOJu0YykX+1eHGUop+1I75TPLepKoFqdwwELpyu0b3sMzPeeKZrS/mA7
 HdGVC6ze8RRTSzByB5/Df59wGzNEU95nK+whAbMwS/L9lMuff8/QhPNF4zuzrIkJWPj94KB2O2a
 h
X-Gm-Gg: ASbGncsx5ffHyzT+FXTTEnmVjAapqgG29r0DmOcPlRGpY/T6TDCoBAbMocg9/NzmWTg
 wcQd4LP5vXEqzicRIhfmeM+4nY+gm65IUePfpJecGbeIg90tBO9XvLP0CwECVhdg5jKrlCrjtmS
 ZMNAZk0qdBDPg0tKiWCdl43lJi6Ra0YC/1jfUQ9hGDkfYZWOYGfQmU1+zv2ohyKUDB3b0XrfxA9
 KY7Ts9h3lWqehelYsVLSbEPHWtht1rDEsaicPH4WDdorcbSaxgczhmQk/Ree59131yWRpW4Jc0D
 ULQ2ktbJGnF6dqWcwtZbyl0PaSxadg8HmpWU/IMlKccDVzeHZqyQmUr22K5SJFRG4hLIEnamDpo
 18eMIX6DF7NRpf0cnpw==
X-Google-Smtp-Source: AGHT+IERUov54XI5r+X5Taw2Pbe1etMCvvYMZ9pJIWkkzm19Df48GBUglGYmKhBDHWNwr8aUVnbyFw==
X-Received: by 2002:a05:6214:dab:b0:6ec:f51f:30f6 with SMTP id
 6a1803df08f44-6ef0dc53be4mr12421216d6.31.1743636300460; 
 Wed, 02 Apr 2025 16:25:00 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ef0f14e993sm672826d6.112.2025.04.02.16.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 16:24:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Elena Agostini <eagostini@nvidia.com>,
 Harry van Haaren <harry.van.haaren@intel.com>,
 Nicolas Chautru <nicolas.chautru@intel.com>
Subject: [PATCH v12 08/10] doc: remove sanity
Date: Wed,  2 Apr 2025 16:23:18 -0700
Message-ID: <20250402232441.440346-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250402232441.440346-1-stephen@networkplumber.org>
References: <20240529233811.663211-1-stephen@networkplumber.org>
 <20250402232441.440346-1-stephen@networkplumber.org>
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

Don't use the word sanity in the documentation

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/gpus/cuda.rst                       | 2 +-
 doc/guides/sample_app_ug/eventdev_pipeline.rst | 2 +-
 doc/guides/tools/testbbdev.rst                 | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/doc/guides/gpus/cuda.rst b/doc/guides/gpus/cuda.rst
index 6520c17c3e..c523da1f3e 100644
--- a/doc/guides/gpus/cuda.rst
+++ b/doc/guides/gpus/cuda.rst
@@ -80,7 +80,7 @@ Similarly to CUDA shared library, if the **libgdrapi.so** shared library
 is not installed in default locations (e.g. /usr/local/lib),
 you can use the variable ``GDRCOPY_PATH_L``.
 
-As an example, to enable the CPU map feature sanity check,
+As an example, to enable the CPU map feature check,
 run the ``app/test-gpudev`` application with:
 
 .. code-block:: console
diff --git a/doc/guides/sample_app_ug/eventdev_pipeline.rst b/doc/guides/sample_app_ug/eventdev_pipeline.rst
index 19ff53803e..e7787fb266 100644
--- a/doc/guides/sample_app_ug/eventdev_pipeline.rst
+++ b/doc/guides/sample_app_ug/eventdev_pipeline.rst
@@ -50,7 +50,7 @@ these settings is shown below:
     ./<build_dir>/examples/dpdk-eventdev_pipeline -l 0,2,8-15 --vdev event_sw0 \
     -- -r1 -t1 -e4 -w FF00 -s4 -n0 -c32 -W1000 -D
 
-The application has some sanity checking built-in, so if there is a function
+The application has some internal validation, so if there is a function
 (e.g.; the RX core) which doesn't have a cpu core mask assigned, the application
 will print an error message:
 
diff --git a/doc/guides/tools/testbbdev.rst b/doc/guides/tools/testbbdev.rst
index ddb8d787be..baaf9d115d 100644
--- a/doc/guides/tools/testbbdev.rst
+++ b/doc/guides/tools/testbbdev.rst
@@ -9,7 +9,7 @@ dpdk-test-bbdev Application
 The ``dpdk-test-bbdev`` tool is a Data Plane Development Kit (DPDK) utility that
 allows measuring performance parameters of PMDs available in the bbdev framework.
 Tests available for execution are: latency, throughput, validation,
-bler and sanity tests. Execution of tests can be customized using various
+bler and basic functionality. Execution of tests can be customized using various
 parameters passed to a python running script.
 
 
@@ -97,8 +97,8 @@ Test Cases
 
 There are 7 main test cases that can be executed using testbbdev tool:
 
-* Sanity checks [-c unittest]
-    - Performs sanity checks on BBDEV interface, validating basic functionality
+* Functional checks [-c unittest]
+    - Performs checks on BBDEV interface, validating basic functionality
 
 * Validation tests [-c validation]
     - Performs full operation of enqueue and dequeue
@@ -232,7 +232,7 @@ vector name refer more explicitly processing specificity such as
 is purely read/written for external DDR, lbrm when limited buffer
 rate matching is expected, or crc_fail when a CRC failure is expected.
 They are chosen to have a good coverage across sizes and processing
-parameters while still keeping their number limited as part of sanity
+parameters while still keeping their number limited as part of functional
 regression.
 
 Shortened tree of isg_cid-wireless_dpdk_ae with dpdk compiled and output
-- 
2.47.2

