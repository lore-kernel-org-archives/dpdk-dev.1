Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25250C83F22
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 20:54:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 868994060F;
	Wed, 16 Jul 2025 22:54:09 +0200 (CEST)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by mails.dpdk.org (Postfix) with ESMTP id 3A6CB4014F
 for <dev@dpdk.org>; Wed, 16 Jul 2025 22:54:06 +0200 (CEST)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-4ab8403b6daso2790331cf.2
 for <dev@dpdk.org>; Wed, 16 Jul 2025 13:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752699245; x=1753304045; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n8mKtIBFv21m8qPPNrMQ+j3DpKMOFgChbKSNQgx6MYE=;
 b=aagKQysxS0QqGYOrz4/+ylkfNFJnthb+tmyi8wNRWedeBMdO+/ktuScKWM0ybwxRl9
 94qaCrgQuBXaHZN0xRiGUOTpfjdZbkhicurl5aNiaEw8D8Irzoj2ff0RLZMbLOY1OWIY
 JLDVoHRVtP1mFFCXAMJNATC8BKJjQuG+Y/JVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752699245; x=1753304045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n8mKtIBFv21m8qPPNrMQ+j3DpKMOFgChbKSNQgx6MYE=;
 b=sJ+IYqLvBSwMBcjfJ1aJlutoKeprxgg/XCrKctxhrlSSokFpZCtUs1S5VTnC4hey03
 WbXfn3dnnF4Aaobi8vymOeXQt0GIoZ/itsOr9HEOhbF8fwEeVChGHJa/v61JEZMd6RHw
 6VRzEeD1TaaXOI39HoHWKQUYgiyIrHk78xm7QHzWyZoMhX7nMpt+SvhBTJTUS17wnPjy
 d2FlA7Gssm+CmiXh7UGaYV0y+4np7WuvbgKY7MIKJou3z17J7s86OcenYJzevgf4qutj
 Qb9iefhQJx7vkLjL95ygAEsibXmEjJcg5xSOzX0XlZiUTePOjml4JpH+AydnojCRqZEa
 dQhw==
X-Gm-Message-State: AOJu0YyGuWXs450nW4kaONdrh0Wqu0BNLpXcz2EnivNkL9d/O2w80ume
 cPFHUypYKgDeGiW0mpLUz3WnjsLcwyOTrOc/F/JsbENcKsINkmuY2Ow1Fdj3B7lga2o=
X-Gm-Gg: ASbGncuqvSCy1UQrw5BPhBx7ZAPaDR5TxQlU1kgsKyh55ReqQFAs4LkZa5uz7jjoLdc
 w5jIECIgdW1wk8KN/FjGjgigHFQXox23c4cQLj31cJRvip8nJVPePJ0rBF+smhm4oMj+4/0OLph
 PDk6bcn4umLjd/mBVHrgHeVsNZeYaTEzWI8vxxXsWSb5fnOTqkYohHGwGhunIxWj2fQ1BEAHKKx
 wPulh7N6LLYXNVUGPrGqYQaieM6PcQl+Wmkvk37ePsmx/pYcwAtIaL9jtV0Re+Y5AlkRJmesw8W
 p+oGDnfBOZuwb6MzURVzpjzIUO8e8vjY9VQ8vNIalqhBFZhQQRrc7wIqPHe1f46FpepOr5qu1lZ
 sfYzyvepnXSX5sNkNzzAjmMvIt0EYN3/ywoFiiocvfcZu+TQN17D5
X-Google-Smtp-Source: AGHT+IHB2qoDqy/xKPzBUGOK7oNkokw3VAjC3f1DHCLtoWY/CJgJ+YQtmduw5UVzCFCUZMHzDO8YcA==
X-Received: by 2002:a05:622a:6a8c:b0:4ab:a29f:7e43 with SMTP id
 d75a77b69052e-4aba29f7f2amr8377631cf.52.1752699245543; 
 Wed, 16 Jul 2025 13:54:05 -0700 (PDT)
Received: from fedora.iol.unh.edu ([132.177.125.209])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ab85620d80sm21406531cf.61.2025.07.16.13.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 13:54:05 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v7 2/3] doc: rephrase terminology in dts.rst
Date: Wed, 16 Jul 2025 16:53:59 -0400
Message-ID: <20250716205402.64997-2-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250716205402.64997-1-dmarx@iol.unh.edu>
References: <20250716182546.58567-1-dmarx@iol.unh.edu>
 <20250716205402.64997-1-dmarx@iol.unh.edu>
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

