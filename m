Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46532C83F34
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 13:57:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFC0340664;
	Wed, 16 Jul 2025 15:57:14 +0200 (CEST)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by mails.dpdk.org (Postfix) with ESMTP id D544640144
 for <dev@dpdk.org>; Wed, 16 Jul 2025 15:57:12 +0200 (CEST)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-4ab3d08dd53so37999021cf.1
 for <dev@dpdk.org>; Wed, 16 Jul 2025 06:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752674232; x=1753279032; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n8mKtIBFv21m8qPPNrMQ+j3DpKMOFgChbKSNQgx6MYE=;
 b=ZOHb4ZrbbqJ88FBYrmmgoWcGIk6yozkIvt3erIcuFHQgioiCfBfuHt6ZNwTVsZR9WX
 ieaoe4oNXv8Qlhy/d5A6qF1xEsIXfRVOVcbvZ7y3MUwY7aSYdS9DFReKapgCOYKzwnXJ
 A7g3PJkCiD1SRp0QFKgEpIta17WbcLOgOvCrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752674232; x=1753279032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n8mKtIBFv21m8qPPNrMQ+j3DpKMOFgChbKSNQgx6MYE=;
 b=IMCagvZGR9by1W5rGOHLQF34rGVi+6DAQF9LCLUw9NoE6k8Awn5goO1gbWP12lnvFF
 ryBBXVQb/jZ1t/rPhjmfiU+HOKhsU25psO5UW2hRn8r02m9cqYZVBI0qCmzYndLzt2Yn
 BiCufQeOjeHPJE/owjWZoIKiqitMU4k9RTUSaHk0OMC4e9sWive42M2MKbv0w/pjwCCd
 t1AhzSecxgUtTSDfXSGJKwS8XmMKyp/vB4og8GBy2Zo1bwXf6w9YNIlJDgh1hmjS+Lq1
 R6ixtm2okZZ2QNhWeiuPC0aDnWKv6mKVLnimRGoUd+fTe+RT5mG3x3ZSomqEJsaXvf3/
 /1og==
X-Gm-Message-State: AOJu0Yy4dq02+jqaABKTVz4Vti1f87a1hBLodW5eHS/H2XJx3N9CC+8M
 MjLD6ewjdd6OwN9wYe33l+JXzB2jCsCWoBFbaqVbyKlby9cREtFIupInxq1KHPJYVKA=
X-Gm-Gg: ASbGncsqUoJ8/KodfBSEwZFrQW8um9HsiDhuf3RpKIMB1r70doaSm+ypC6yro/kes0Q
 sCgqVk4avpl+1JXof5DkxYmc96+jtzevYlCxIjojKZVd5x3OjQkRPmBCXgozCACAAaotqjjPSKz
 OmKplVri9nUWp/WJGu1t31o7Qb/Iux36EMYOvR2q7ZzQDoWw2zrDUnA3grUUYw6EoUyrAksMzR1
 gsRdX7dVt9n7Vmc94aWsP+QYGjveblTDyKtYisnOQ0HAQKyDDnCoDbPYmXu21ukEaaVnApohp6J
 gWjY2X+6dNW3YD4vhGodXnjS5BBNCz5eYLRtztuRbR/2yCi74kDzN5c8gHZO8mLezB0N32H9rLA
 EqfhemS7L5iBdTITSsOz1cVgiNw2o6FIRO70jCdCP5bApQ1WDS9ndgZne1usTp34=
X-Google-Smtp-Source: AGHT+IHrEpFWYop35pu3jDTicsvwKKJO1OlJF6IhjpWXCmNhNaaOIgcJzKKjcsSeHAq53Rnf3Hm+Ww==
X-Received: by 2002:a05:622a:13cd:b0:4ab:7d96:6a28 with SMTP id
 d75a77b69052e-4ab93db90demr35429371cf.46.1752674232067; 
 Wed, 16 Jul 2025 06:57:12 -0700 (PDT)
Received: from fedora.iol.unh.edu ([132.177.125.221])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ab5427925bsm46608061cf.7.2025.07.16.06.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 06:57:11 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v5 2/3] doc: rephrase terminology in dts.rst
Date: Wed, 16 Jul 2025 09:57:05 -0400
Message-ID: <20250716135708.49233-2-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250716135708.49233-1-dmarx@iol.unh.edu>
References: <20250714171346.564267-1-dmarx@iol.unh.edu>
 <20250716135708.49233-1-dmarx@iol.unh.edu>
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
Reviewed-by: Patrick Robb <probb@iol.unh.edu>
---
 doc/guides/tools/dts.rst | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
index 016dc5e374..8ba855c6fc 100644
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
+  Node that sends traffic to the SUT, which can be hardware or software-based.
 
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
2.50.1

