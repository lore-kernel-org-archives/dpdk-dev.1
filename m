Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E26CC87FCA
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Jul 2025 20:12:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A1AA40144;
	Fri, 25 Jul 2025 22:11:59 +0200 (CEST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by mails.dpdk.org (Postfix) with ESMTP id 2D8AB400D5
 for <dev@dpdk.org>; Fri, 25 Jul 2025 22:11:57 +0200 (CEST)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-7e33d36491dso340070885a.3
 for <dev@dpdk.org>; Fri, 25 Jul 2025 13:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1753474316; x=1754079116; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jc9+Tz6UOWFpbeUziCb2H9fs2hBdna+jqL4f9K+vVvU=;
 b=MMFxZYcn8TIKbsM3GK7Zd6qHnlr1aN6/h6sjGwaLhCn9cknjlYWtTaAM6dkfI13MQn
 Q+DzSmKBzL/jVpm3cvYNSzld/zyRihE1f3hraZ25U76UbYv4jFSaaWxAb46BoqRgCY/6
 ojdw8p4H10nBgSfWi+6n4MeFi6tSW6FyVadbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753474316; x=1754079116;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jc9+Tz6UOWFpbeUziCb2H9fs2hBdna+jqL4f9K+vVvU=;
 b=h8leKcHIkciUI7lRsw4z+2cP+s5qyQ/uvfMJsP1M/piI0kiLBZzqkZt9p2oALY9eDV
 eCu4C7Kt0IKJXQgFQDfohVKSUw2H4eG8rx238TyqIzbiDVCZOtAtKzTSTfTPyiPRWcI4
 /1HcPqC9c/5hxfpw3FdvTezbGEQzjJF9Xeu/jY/2ADeHnpIB/uTo22+TP9IP0uAuiR5U
 8kxCRSk5JgOh9GJcjTOo5eXLNiRy8RcN6XTcltYX1Kg91VK1+/QEH8BINbkUqLu1Kckk
 8bHVrm9viLLtpStAUYmGH5+FPq43jP+BTlMwJlU4aei/VzEogrO+4MCLJeiCl350BmmF
 5ynA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7hwBDZffQNcXLGbVFRLqRcwzEOCwN1hesQ67O3i++7KbxrBW+9GDMWKkyAItKwdUeImE=@dpdk.org
X-Gm-Message-State: AOJu0YyJLCbr3214GzoTBCaNGI8a8rL2ZXLH1R6vncs3Jao3QnGLcMfp
 bkBS+YkwHI4QqqDLvxrN3KGViUgd/J56f6qgSAZu4nED5SiC8UrnidzNkEgQaCPPVik=
X-Gm-Gg: ASbGncsN38fXyhsC10oHf4dZX7naiqkOanNIuZ2WNl4AiorG6zi0rOoqPx5qbI0yCtV
 Wlydyj1tdfyIDTI+fYOGi0P8CiCEfYKJPprnYP10VseIaug5+dxz4ANn7L+vkbA0PF37+ujPaQU
 p5XDzqYHThkOfZZajEZSWVf1bHEy/A4OUCyyrDbzUQPXZFV4djbC2Ep+tTb5RrbFS6tXbd3sRsp
 sZ8EWL9F+hVTtnrwVyVw935iJjket/Fiizhd1sIHBCnS8oMVOjUWYXc2PX9S8kKeCZeuoNhejk5
 cBY/kl6QInwGr/H7ZxO25TuMMXth8OZ25RJDIqnlgLlQfYRFIFE6cuEqqzWkrlLgZlPjPok1G+c
 Gq/cqjPV3CG7dLu7XsKG/f5G6QvAtWxjl8g==
X-Google-Smtp-Source: AGHT+IF+cK7HS0Rd6hC/G2PUmEgOF249OaqoX3xKTiROITR1mlh05Y+M6tfiIuUU4zt57918Fv5fkQ==
X-Received: by 2002:a05:620a:a81b:b0:7e6:31f3:eabc with SMTP id
 af79cd13be357-7e63bf53dbemr388043885a.5.1753474316326; 
 Fri, 25 Jul 2025 13:11:56 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e6432ada98sm36240185a.39.2025.07.25.13.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 13:11:55 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: Luca.Vizzarro@arm.com
Cc: dmarx@iol.unh.edu, Paul.Szczepanek@arm.com, abailey@iol.unh.edu,
 mmahajan@iol.unh.edu, thomas.wilks@arm.com, dev@dpdk.org,
 Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH] dts: call hugepages configure at testrun setup
Date: Fri, 25 Jul 2025 16:05:53 -0400
Message-ID: <20250725200553.1262542-1-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
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

The node class contains a _configure_hugepages method to be called
on the sut node if the user has specified a hugepages config value
in their nodes configuration. However, the commit referenced below
removed the code path to this function, making it unreachable. If
the user has configured hugepages already via kernel parameters
this is harmless, but if they haven't, this bug will cause the DTS
execution to fail. This commit adds a call to configure_hugepages
in the testrun setup, and necessarily makes configure_hugepages a
public method.

Fixes: d77a4a27bd24 ("dts: remove node distinction")

Signed-off-by: Patrick Robb <probb@iol.unh.edu>
---
 dts/framework/test_run.py           | 1 +
 dts/framework/testbed_model/node.py | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 4355aeeb4b..5f4fc0d2bb 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -338,6 +338,7 @@ def next(self) -> State | None:
         test_run.init_random_seed()
         test_run.remaining_tests = deque(test_run.selected_tests)
 
+        test_run.ctx.sut_node.setup_hugepages()
         test_run.ctx.sut_node.setup()
         test_run.ctx.tg_node.setup()
         test_run.ctx.dpdk.setup()
diff --git a/dts/framework/testbed_model/node.py b/dts/framework/testbed_model/node.py
index e6737cd173..dbe8daa68b 100644
--- a/dts/framework/testbed_model/node.py
+++ b/dts/framework/testbed_model/node.py
@@ -166,7 +166,7 @@ def compiler_version(self, value: str) -> None:
         """
         self._compiler_version = value
 
-    def _setup_hugepages(self) -> None:
+    def setup_hugepages(self) -> None:
         """Setup hugepages on the node.
 
         Configure the hugepages only if they're specified in the node's test run configuration.
-- 
2.49.0

