Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64D1C83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Jul 2025 17:14:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49B6D40608;
	Mon, 14 Jul 2025 19:13:54 +0200 (CEST)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com
 [209.85.166.44]) by mails.dpdk.org (Postfix) with ESMTP id EA8AD402E3
 for <dev@dpdk.org>; Mon, 14 Jul 2025 19:13:51 +0200 (CEST)
Received: by mail-io1-f44.google.com with SMTP id
 ca18e2360f4ac-8760d31bd35so171514339f.2
 for <dev@dpdk.org>; Mon, 14 Jul 2025 10:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752513231; x=1753118031; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4z7tPNBKn3upeSldUstppYeOsVSyiSV88DGQ6JVspXQ=;
 b=dQWmxGp+uAtoj2K3Eg0JyLJfpLWxPqtbWrUIawqxCeMKb8ThDeYEcq22aqWRExQr8r
 1baFyK1EjAMzOObVMVcFAnGTpWPufLcq6CFjiP/K3JKAjMK3vGphYJDZEjqB8i4yFiHA
 j98VrIjhX1HHq17gZt320D16pBmF4mKKyii6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752513231; x=1753118031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4z7tPNBKn3upeSldUstppYeOsVSyiSV88DGQ6JVspXQ=;
 b=EhcHdO3e9PYQjARtZlxKyzX4cBFn7r3nd05LJzH9KBHyA+xkwXJTMn0Els1siYf9Gq
 /RKXnRNjSWRSGOhuheIx3d4xFS/yMu5tl5c6KaH4XCPdwObPcL6TE2XgjMXlYkel9b2t
 FFZ2xqhbsnGvJPdgpj5kju3VY1FaY4c363i3LA6gDmyMhVeK0RnBauIXG1BdlQ6FfhWx
 T60mhyHWVem1YzhusCGum3XWExvQ3Ib/wpmyyKpPakxE/6+CWrP8g6zXMs7mCyreIbp3
 l+y1ri8CkuIyIy6EPezN0ctURP2DNINUABPZoNCtshukSiyVpxPneuOQZqyNDHPCxONk
 B4RQ==
X-Gm-Message-State: AOJu0YxMhxt5sWRfluGLpi9mWwg6j80myMwcj2T0OxgVWwvh3XXW3nI8
 LMPpab8xDE2brgbAhIbrTfOoifP3Haoz87wMzPe7wXzxd/j9I0iTM33nEUuIh4XTJdI=
X-Gm-Gg: ASbGncvqiYiPjJKdLAHrXI7llPEEfwyJkOscIjCK5ToO7zv/BcCddCllPnU3mxQpYBm
 5vu5ZfyAF+YIO9aPwA7nTSTal+H3eliyzvNP+lsAvfq4EX9iBHAQRqLTMJuU2UXxNga8O7IuN49
 V9f9qSV0V53EEhaI1HFIV5Qw+HT2uLIt31LMWQ4dlGaY1k7lFci0zjcImpslmX/9mlm7q2N+QHt
 xyYeFNCJlu6XMvpTL++I1+wABEZ2hI+vfrZPcbTTi58bRKIPS6FZKHQFzlCgQgJnTgAJ4rE25EJ
 zVrmazkEkhjAXIVnIr3chYuA/jvrbh/UN0plJOilAXvuvY6wkOPRdscBr6HA09Z6j0aTavaRyPF
 PxLu/YA2t
X-Google-Smtp-Source: AGHT+IFVHL+zy2Oz0YJm3mXY09G6IlFMMlrJncLNCnnnIQ0pDjo4oOplkrzimtgSUftnuq4nyO+Syw==
X-Received: by 2002:a05:6602:3f8d:b0:876:19b9:1aaa with SMTP id
 ca18e2360f4ac-87977fcfe5cmr1375351139f.9.1752513231082; 
 Mon, 14 Jul 2025 10:13:51 -0700 (PDT)
Received: from fedora.unh.edu ([2606:4100:3880:1257::100a])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50556b14167sm2111784173.131.2025.07.14.10.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 10:13:50 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v4 2/3] doc: rephrase terminology in dts.rst
Date: Mon, 14 Jul 2025 13:13:43 -0400
Message-ID: <20250714171346.564267-2-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250714171346.564267-1-dmarx@iol.unh.edu>
References: <20250711172534.540416-1-dmarx@iol.unh.edu>
 <20250714171346.564267-1-dmarx@iol.unh.edu>
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
2.49.0

