Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C974CC83F1A
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Jul 2025 17:25:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89A0B402C6;
	Fri, 11 Jul 2025 19:25:42 +0200 (CEST)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id 585ED4013F
 for <dev@dpdk.org>; Fri, 11 Jul 2025 19:25:41 +0200 (CEST)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-7da6ca0f1acso253664085a.1
 for <dev@dpdk.org>; Fri, 11 Jul 2025 10:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752254740; x=1752859540; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ky6oCtJGDZcRc7AHLvn3emyl/f358FJT43DSKZ6n6Go=;
 b=An5IFduEA01JpfYW3rPt610dM0TeXwbqMrLd2kQgXJxw+5P290g619nEtO6FkxgCc/
 q2Zh6kengvR76H5zBpqqwqprl7+kieq5g+MoEmgKW290Hd7pe88NpCm0PGfRDkan1THp
 xsxsYq+k4RL4xBoY8BrbCOk2zj5UKQRWsGFg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752254740; x=1752859540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ky6oCtJGDZcRc7AHLvn3emyl/f358FJT43DSKZ6n6Go=;
 b=vbhk2tlVFfvxbnRwjuftlenkX8HDEbBkZXlpmj9znwt1kPtWdXgyG2oWXkt4AiaMG2
 xSGTeDyR7waTYu6F12WdnN2Pf3XELRsy2jCdVZXOiqEt4ZFSdXmktslW+3g3uKw/cuoo
 uhKCsIJBJ9E9Zvg34Um2QgF5x3LtYdZiEYFIWGCMGjXU/GJ5qlNpTKDUhsG1NE/02A+4
 +SfmKZPjS4PayW1jsfOpv+v6hhksh/SPPvQIIGBRhWrgXS88c3ZIl4rF+wMfLWsF0Db1
 SIq8D6jliEgaeBIxLUnOxfJBhXDd+eSaWC542zkgARo+YbEpd+bvc2/QLIMcsxvdMxK3
 DrGA==
X-Gm-Message-State: AOJu0YzYS42KIUPqEf0ZvOSeXAywjnrzqFI+nNvexEQdXbePlrE0NEjj
 ofLfnXPluzXezmldhEbzJRyGOS6lyClmDdQtjZ3yHitPXCttSB60ELcYL/Z4EQt6A0E=
X-Gm-Gg: ASbGnctmfITtkUOoVTyPf831FG/EESWJDObqcUxR/TmthlJgYnBGdnP2E1V/hlh/GGr
 FI+5NmZPoiEEtmmZA1bQcSaZJjQY6xLHi6yOolmvLia/58fNzC4M/239LIoTfb9sGNhscbmQrF3
 yiqcu/+6w9cJKH0LVqevonLdFksbE+Irlx7/fS8yGOuCmX7++UapruoJAIzEjoquZxxRtEXb+SP
 1QPAywC8OMxArKK0T176w+ObF6XGkQpEAT4vs9DzRXq3rwGn4meth4cNtRqfqu/Wngh9jRrNw7e
 wapHiv9Ii3z/qeOwisBb40o+CdBWktUobJHRbrCBtBKFd1uKZbI6wQH1jbfbdv+19FgJvyOWEOf
 M5+UktcG0itALdg==
X-Google-Smtp-Source: AGHT+IEr1kNcEuJUyFn8rKX1Rq/o5Fm4tt0RRyOe55DxMpIG7z3Hx0d1h6W23GMbMdHxxuiJH06/Jw==
X-Received: by 2002:a05:620a:294a:b0:7db:2fcb:1202 with SMTP id
 af79cd13be357-7dde9952fb0mr624857085a.11.1752254740464; 
 Fri, 11 Jul 2025 10:25:40 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1257::100a])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a9edc65720sm23329341cf.30.2025.07.11.10.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 10:25:40 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v3 2/3] doc: rephrase terminology in dts.rst
Date: Fri, 11 Jul 2025 13:24:54 -0400
Message-ID: <20250711172534.540416-2-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250711172534.540416-1-dmarx@iol.unh.edu>
References: <20250603172827.458725-1-dmarx@iol.unh.edu>
 <20250711172534.540416-1-dmarx@iol.unh.edu>
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

Rephrase some of the DTS tool/term definitions to be more concise.
These sections were unnecessarily verbose and can be conveyed
in a clearer way.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 doc/guides/tools/dts.rst | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
index 016dc5e374..7f6f7c1db5 100644
--- a/doc/guides/tools/dts.rst
+++ b/doc/guides/tools/dts.rst
@@ -1,6 +1,7 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright(c) 2022-2023 PANTHEON.tech s.r.o.
     Copyright(c) 2024 Arm Limited
+    Copyright(c) 2025 University of New Hampshire
 
 DPDK Test Suite
 ===============
@@ -20,31 +21,22 @@ DTS runtime environment
 
 DTS runtime environment node
   A node where at least one DTS runtime environment is present.
-  This is the node where we run DTS and from which DTS connects to other nodes.
+  This is the node where we run DTS and from which DTS connects to other
+  nodes.
 
 System under test
-  An SUT is the combination of DPDK and the hardware we're testing
-  in conjunction with DPDK (NICs, crypto and other devices).
+  The system which runs a DPDK application on relevant
+  hardware (NIC, accelerator cards, etc) and from which the DPDK behavior is
+  observed for tests.
 
 System under test node
   A node where at least one SUT is present.
 
 Traffic generator
-  A TG is either software or hardware capable of sending packets.
+  Node that sends traffic to the SUT; can be hardware or software-based.
 
 Traffic generator node
   A node where at least one TG is present.
-  In case of hardware traffic generators, the TG and the node are literally the same.
-
-
-In most cases, interchangeably referring to a runtime environment, SUT, TG or the node
-they're running on (e.g. using SUT and SUT node interchangeably) doesn't cause confusion.
-There could theoretically be more than of these running on the same node and in that case
-it's useful to have stricter definitions.
-An example would be two different traffic generators (such as Trex and Scapy)
-running on the same node.
-A different example would be a node containing both a DTS runtime environment
-and a traffic generator, in which case it's both a DTS runtime environment node and a TG node.
 
 
 DTS Environment
@@ -481,17 +473,12 @@ DTS Developer Tools
 
 There are two tools used in DTS to help with code checking, style and formatting:
 
-* `ruff <https://astral.sh/ruff/>`_
-
-  An extremely fast all-in-one linting and formatting solution,
-  which covers most if not all the major rules such as:
-  pylama, flake8, pylint etc.
-  Its built-in formatter is also Black-compatible
-  and is able to sort imports automatically like isort would.
-
-* `mypy <https://github.com/python/mypy>`_
+ruff:
+  - Linter and formatter (replaces flake8, pylint, isort, etc.)
+  - Compatible with Black
 
-  Enables static typing for Python, exploiting the type hints in the source code.
+mypy:
+  - Performs static type checking
 
 These two tools are all used in ``devtools/dts-check-format.sh``,
 the DTS code check and format script.
-- 
2.49.0

