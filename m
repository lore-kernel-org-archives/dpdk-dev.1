Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18878CD98C7
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 21:21:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9794433C6;
	Thu, 11 Jun 2026 23:21:29 +0200 (CEST)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id 1E431433B7
 for <dev@dpdk.org>; Thu, 11 Jun 2026 23:21:27 +0200 (CEST)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-304f590dd91so450389eec.0
 for <dev@dpdk.org>; Thu, 11 Jun 2026 14:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781212886;
 x=1781817686; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJB2AFKIjmjGcJUw2RSI0Ygzh1K8blTy2pqzU2UWFks=;
 b=teEwqlIBxVyjZgTjyhL2uAEUHG+QdP0oA18gYefRs6g7HyqnhhYfheBmZ24pWfnuj7
 ABzzg5FOEbao0J4b+PFRW0TfwfWXER6Lh3Hh89c4aDKkddoCjUkczyMXqV9TnPn3q0SP
 Ka/G7U5sdOC6uaE/gjFem54FpJvHhmYAsai7irnqQh02F1P4TUfD4RuL9hNoSVmsoC5N
 eHOqrz38JqkiavDp2XF5nZz/Mn7Myo9hLkBv1Mgrer9/QTMwvdVVvGOoKAjgzvVCMY9o
 Rg1MLAv806iQI5DSUVRSFtgml8GtyS9Mg/Vg+nNiZEAl+SCkP6k8vXhnAn0vUYXyfRqU
 Rn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781212886; x=1781817686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YJB2AFKIjmjGcJUw2RSI0Ygzh1K8blTy2pqzU2UWFks=;
 b=IMd2tVaLqRFhQMprcI0mRhIIDxAl2oyRc7AtbpnJlKbmrNZJz32icYHzNlJJO+K4jl
 rBLgH/1PDgXOOUpNWg8iFvnSl1yK8EZHqhaJWS9bF433xCy3b2QFsfJdE9MFeCj8918T
 py8jNfzeEaRIPBFXkF0FEca79dFujxGAZrz+f9V/sI2X19Qk6MomiZI7k31QhBtntmsi
 MESnFBP94LD6Cx9l4IeW51TMQGIPE65dTAM/1HzPBWfyIJ6g3XPhHqr/KjurVPNPdTlE
 SFPUOyNxk6EOyEEYvn+bARs/LGxJBuG5JyIB5k3yL+893+6AcYXRLJR5k/Q0IBEiJIn9
 OtSg==
X-Gm-Message-State: AOJu0YwIiu9YJAb3BYUOLL4Mw3S6lA5sEwkzcq/4G9m7jdDTrFN2wFHe
 TEUsSYuMY6gB5Qdp1VzjLDxapZVxy4VU5dVx+on+Wcpzn8OkmxI2m6VhXf08qNkA72qkKk62bZu
 P1PFm
X-Gm-Gg: Acq92OGAV/rXG1Aiodi+Vdj0ks7KYB0p80y0kiM6LlbtMi+Bw6TDt8mOJ61wavh/cUC
 3pTzpPA13VPH8tt7y9H56RAwzZiAXXqb1asMuIT3KUpDX32Uafi9PIt9duGaliBu43qH8asjq6b
 /NZYRKSd+vLUuT7wdc4fFRc+0fbKZ0sQx3qQrfcYuPNnzw5asU6QYdFKPCk6ZgsjN/q1EucGri0
 JeRR9zmBUx77zbayMMECOmalJi0v+CZ2Cw2BLanHdRBgqrthP1aGravpJjNzdc5MkQaafb7yrKW
 EfCAzI23P5GJM6n3I5Q84d/cCxaIDIgxH+r//2Mm1IDqkRSMVLOpHO5YoWZs7wgSvawRsKRiIHB
 xiAEM5dmr+R9Spw0tDgXdhPSkZOQPcVLC3mPEW5qFoSlGOvyMBlg/2Xk/4qaOlDD/klBd5iMSnz
 qPTNswi4MoNP0TyZmeY8bsWbyFhB7Z05CdJnnCNGtJ/0vum5SvhzSSrhPRuUP8kA==
X-Received: by 2002:a05:7300:238b:b0:2f5:3fb3:4a76 with SMTP id
 5a478bee46e88-3081ff73b6fmr48338eec.10.1781212886080; 
 Thu, 11 Jun 2026 14:21:26 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081eb95450sm546238eec.28.2026.06.11.14.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 14:21:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 04/15] doc: improve structure and clarity of compiling guide
Date: Thu, 11 Jun 2026 14:18:43 -0700
Message-ID: <20260611212119.1026721-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611212119.1026721-1-stephen@networkplumber.org>
References: <20250216230903.124496-1-nandinipersad361@gmail.com>
 <20260611212119.1026721-1-stephen@networkplumber.org>
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

Restructured the sample applications compiling guide:
- Added clearer section headers with proper capitalization
- Improved command block formatting and indentation consistency
- Added setup instructions for build directory creation
- Clarified the distinction between meson and make approaches
- Enhanced explanations with better context for each step
- Added note about flexible build directory naming
- Improved overall document flow and readability

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/compiling.rst | 84 ++++++++++++++++----------
 1 file changed, 51 insertions(+), 33 deletions(-)

diff --git a/doc/guides/sample_app_ug/compiling.rst b/doc/guides/sample_app_ug/compiling.rst
index adde775d4e..a68a9e713c 100644
--- a/doc/guides/sample_app_ug/compiling.rst
+++ b/doc/guides/sample_app_ug/compiling.rst
@@ -5,79 +5,97 @@ Compiling the Sample Applications
 =================================
 
 This section explains how to compile the DPDK sample applications.
+Sample applications are located in ``dpdk/examples/``.
 
-To compile all the sample applications
---------------------------------------
+To Compile All the Sample Applications
+---------------------------------------
 
-Go to DPDK build directory:
+Set up the build directory (if not already done):
 
-    .. code-block:: console
+.. code-block:: console
 
-       cd dpdk/<build_dir>
+   cd dpdk
+   meson setup build
 
-Enable examples compilation:
+.. note::
 
-   .. code-block:: console
+   The build directory name (``build`` in this example) can be chosen freely.
+   Replace ``<build_dir>`` in subsequent commands with your chosen directory name.
 
-      meson configure -Dexamples=all
+Go to the build directory:
 
-Build:
+.. code-block:: console
 
-   .. code-block:: console
+   cd build
 
-      ninja
+.. code-block:: console
+
+   meson configure -Dexamples=all
+
+Compile:
+
+.. code-block:: console
+
+   ninja
 
 For additional information on compiling see
 :ref:`Compiling DPDK on Linux <linux_gsg_compiling_dpdk>` or
 :ref:`Compiling DPDK on FreeBSD <building_from_source>`.
-Applications are output to: ``dpdk/<build_dir>/examples``.
 
+Compiled applications are output to ``dpdk/<build_dir>/examples``.
 
-To compile a single application
--------------------------------
 
+To Compile a Single Application
+--------------------------------
+
+A single application can be compiled using meson during the DPDK build,
+or standalone using make with an installed DPDK.
 
 Using meson
 ~~~~~~~~~~~
 
-Go to DPDK build directory:
+Go to the build directory (after ``meson setup`` as shown above):
 
-    .. code-block:: console
+.. code-block:: console
 
-       cd dpdk/<build_dir>
+   cd dpdk/build
 
 Enable example app compilation:
 
-   .. code-block:: console
+.. code-block:: console
+
+   meson configure -Dexamples=helloworld
+
+Compile:
 
-      meson configure -Dexamples=helloworld
+.. code-block:: console
 
-Build:
+   ninja
 
-   .. code-block:: console
 
-      ninja
+Using make (standalone)
+~~~~~~~~~~~~~~~~~~~~~~~
 
+To compile a sample application standalone using make, DPDK must first
+be installed on the system and pkg-config must be configured.
+See :ref:`building_app_using_installed_dpdk` for installation instructions.
 
-Using Make
-~~~~~~~~~~
+Go to the sample application directory:
 
-Pkg-config is used when building an example app standalone using make, please
-see :ref:`building_app_using_installed_dpdk` for more information.
+.. code-block:: console
 
-Go to the sample application directory. Unless otherwise specified the sample
-applications are located in ``dpdk/examples/``.
+   cd dpdk/examples/helloworld
 
 Build the application:
 
-    .. code-block:: console
+.. code-block:: console
 
-        make
+   make
 
 To build the application for debugging use the ``DEBUG`` option.
 This option adds some extra flags, disables compiler optimizations and
-sets verbose output.
+sets verbose output:
 
-    .. code-block:: console
+.. code-block:: console
 
-       make DEBUG=1
+   make DEBUG=1
-- 
2.53.0

