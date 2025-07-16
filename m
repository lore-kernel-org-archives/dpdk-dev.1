Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED10C83F22
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 18:25:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 419D540649;
	Wed, 16 Jul 2025 20:25:52 +0200 (CEST)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by mails.dpdk.org (Postfix) with ESMTP id 74C7F4060F
 for <dev@dpdk.org>; Wed, 16 Jul 2025 20:25:51 +0200 (CEST)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-4ab3802455eso2236011cf.2
 for <dev@dpdk.org>; Wed, 16 Jul 2025 11:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752690351; x=1753295151; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n8mKtIBFv21m8qPPNrMQ+j3DpKMOFgChbKSNQgx6MYE=;
 b=gpt4tejiYM+Jx5XM+MjzGRTx/06RONjl2ka834XXzLlYzEv7kTzwx/UBuPaHwjBK9/
 Yfd2UZN5QTwu1UZYXeczvu2jj+90HawxtyG3ioPFO2Qz47U8EAZpO1x5PmCYEGuRFyzY
 kjPMFVhwKzhdcY+eKbXAY/GSwvys1cqyGGnHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752690351; x=1753295151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n8mKtIBFv21m8qPPNrMQ+j3DpKMOFgChbKSNQgx6MYE=;
 b=n/fGnVuzE2uYMwaBBJQJnfhv8QhBrRfFK2ef3bFO8eK8NoB2Bdh5qP+JZVwd4wkTy7
 hYzegQNVx5QJ8W7iN04zzTwVwf3dkgidBpB+k5dufxynF399KtLd3buVLvEnk2o7mVEE
 EW5zvu+R4o3lKmaa6tTauQ6GLXupUyx/Zvdjf9Hf9SzQ0EpqYjtH0jw8xY7QC5tUlx04
 gvrBro7rOcKz2wtDxlDUxyJkg6SDxmB82OvIgVfQqvU0J2YD4oMQCABbWVVczAtjMnTn
 hYxUaMGWoDVKP62JaDAQkiR1vTjht/OvfATr9pp3PV/g0p5h2ytiauhOn5J1Emv2FJfo
 z9sQ==
X-Gm-Message-State: AOJu0Yxyy1g/f443v9Af8B+OE3CVTspG5kqkZu0TgJwTRXaqvUEAP+WQ
 wktkosjLyNOIjj1QVixS72SlULtydfmepl+1sK3bjRTGdZ9g+4As7W+ic6I1upBFB/8=
X-Gm-Gg: ASbGnctwoCc+QD67hjPPuiT839K0BAGbyHeGaw1x1+4SdnmemfEUVX98XVgTSKgWKVK
 UAkl9CF+cPNULkRUE+8LYqYLT95GFPCJaKjryDmUIJ4FQnfOZ64cjamAuZgYI9zMO6K/9zALyxP
 nadxZE0sJGyu55ayZej1bPxQTe3mqlwpVBGI8t59/2YyDpFORftC2XcPiuKWpDHK2ju/70UV/UJ
 b8HQhgsBG7VjW6tUOS0w3BTeZ3V15ED2AZcI3+MqjVOrHblr5DmGAVNPPj/odEKwGqeiT+4O8bH
 AhjCJ29w5hyNKFcttUdHYKj3k+lpASM6psbUitjrN8TnL8/o4oTkcsGwM6bodyMuwsTUnYyIt2F
 cUoGEueGFgIiAgpGOjyBnSxt6cpFnCEThVcnE4pqG5REyP4A+dJ2o
X-Google-Smtp-Source: AGHT+IHq2ZkbKYto3Fj0Yt4MQQuY8wbABOMavqm4Fr0NW83748961Asi3ErlE9PqMPP1Bs22Vwgtug==
X-Received: by 2002:a05:622a:a6da:b0:4ab:95a7:71d3 with SMTP id
 d75a77b69052e-4ab95a776cfmr45874711cf.53.1752690350527; 
 Wed, 16 Jul 2025 11:25:50 -0700 (PDT)
Received: from fedora.iol.unh.edu ([132.177.125.216])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ab70bc9e76sm33495321cf.64.2025.07.16.11.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 11:25:49 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v6 2/3] doc: rephrase terminology in dts.rst
Date: Wed, 16 Jul 2025 14:25:45 -0400
Message-ID: <20250716182546.58567-2-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250716182546.58567-1-dmarx@iol.unh.edu>
References: <20250716135708.49233-1-dmarx@iol.unh.edu>
 <20250716182546.58567-1-dmarx@iol.unh.edu>
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

