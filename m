Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270C3C369A2
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Apr 2025 22:42:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9639A40668;
	Thu, 10 Apr 2025 00:42:32 +0200 (CEST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 170C940288
 for <dev@dpdk.org>; Thu, 10 Apr 2025 00:42:30 +0200 (CEST)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7c5568355ffso18822085a.0
 for <dev@dpdk.org>; Wed, 09 Apr 2025 15:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1744238549; x=1744843349; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JCgXXkP9lmHnZvCLxCLdE5/SV54tmuVOXclVSDOSvc4=;
 b=GCkG36JKd1oc2bRvQW8cN8Ae4w8aS4chhoRKKTa61iHQxdNbQ1NNa9Q0pASSpqcKK5
 q6Edx1Usso1TGSp3nr7pVfd7Bn58Gp8oOF0CHAWWCSRiIqyXwwwpG6wqckR9e0PYNc+x
 AeuV2ZbH47HuAhnBsMcjwHhP9MZvHAMqnXsuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744238549; x=1744843349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JCgXXkP9lmHnZvCLxCLdE5/SV54tmuVOXclVSDOSvc4=;
 b=xMFzVLqJFXTXVTAP/TfjV+MxbWpuSJleCGFELszXCO4o/ueBScKY9IUGvpjsHXt2JX
 NOlfklNyxh4wdLRz/MzJjRuAf3YkIuyhzhSbrkKMcgLG1/Rc2ueUYYIIjFOAPa0smRWI
 19qf5jyD//R7d/4Qy3KFfUkup50n/Le6XtfdTJdt4YwWVre26FptYhzGasWZLtNOyBym
 Qz+lZDSxjwXTzJSlUp5sdpHPWzQjqw6pioEqqojN0FCfHrCBUzzy/V+sRkHrLcqpoD8n
 CvvL0Vfftoth5NHvfZx2obEZ/uUS9/fytyuGIDW0XGj6q1eS37b/Dwf62/ANIsafoEmS
 Csbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhkcOK6baFdRNFar9IttU+FdyYZWHwVcW8womLw8ocM1XCESzrkILK1Vg07zzDbUtzbvQ=@dpdk.org
X-Gm-Message-State: AOJu0Yyu71wHqeuWqKbulAMG6WOSjh4DlHOEnoWBO323yLUnY/08SBV8
 bRiHKZxCkd5hxKh6po5Yf3t7LhVYaqt4N9tW+6nfKUy6ocjltoy3fmq2iiftNAEbQNMUsS2uI8G
 t+qQ=
X-Gm-Gg: ASbGncsbprL7rZAmEQamJbSNQFkcSCkrcU28nsdbTnHfKDITyBojABC7ubZ97NT/wKM
 TZnjdU6renqX9HGP4fjq6CcK723lRIuhxgi149uhiEfiniysMz4aiOheNjUyXgRCyhHsiAz0oLA
 gQnSGTMpzR4qBOBZv1rQ/QzkRKCTjsKj21QInxHlumvu79f/Dj3j/ymrSPuQS6ggR+Y/omSo+ei
 lEYgfvKfpHYinWjLz3l8UyzZIO67TXn5FOLBy94H0MUuf3sdZQe5/cLQ8Ze2MnXOsoOpJ1G6Ah2
 4uWBQUKvJI3Tsmv0QmOWPXmv+Er85SEAJOdv48X/fAkYaCrnLy1XwackCRskQkk3qO9Pg6Z1opU
 /cvYP0P4wLQOkEw==
X-Google-Smtp-Source: AGHT+IEmpKWYgi7MHPAL/Mmcn4Pmq7/sYChpg/LDlVQyWjShtAg0R+Zs8KY2Mbjl+oBE+oxD1C2XDw==
X-Received: by 2002:a05:620a:270f:b0:7c5:94a1:7975 with SMTP id
 af79cd13be357-7c7a73f1fcemr106119385a.0.1744238549385; 
 Wed, 09 Apr 2025 15:42:29 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu
 ([2606:4100:3880:1271:8c70:5b9e:ecd3:14e])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c7a11ca015sm125949985a.82.2025.04.09.15.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 15:42:28 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: Paul.Szczepanek@arm.com
Cc: probb@iol.unh.edu, Luca.Vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.edu,
 npratte@iol.unh.edu, Luca Vizzarro <luca.vizzarro@arm.com>
Subject: [PATCH 1/4] dts: include smoke tests in tests config
Date: Wed,  9 Apr 2025 18:38:22 -0400
Message-ID: <20250409223825.1579256-2-probb@iol.unh.edu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250409223825.1579256-1-probb@iol.unh.edu>
References: <20250403023059.1762841-1-probb@iol.unh.edu>
 <20250409223825.1579256-1-probb@iol.unh.edu>
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

The tests config is created by parsing the testrun config
earlier in the DTS execution than when the smoke_tests
testsuite is added. This situation causes a key error
on the tests_config dictionary when smoke_tests is enabled.
This commit creates a placeholder TestSuiteConfig for
smoke tests in the function which is responsible for
creating the tests config model, resolving the issue.

Fixes: 184d21f08db4 ("dts: add per-test-suite configuration")

Signed-off-by: Patrick Robb <probb@iol.unh.edu>
Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
---
 dts/framework/config/test_run.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test_run.py
index 06fe28143c..b6e4099eeb 100644
--- a/dts/framework/config/test_run.py
+++ b/dts/framework/config/test_run.py
@@ -301,11 +301,14 @@ def make_test_suite_config_field(config_obj: type["BaseConfig"]):
         return config_obj, Field(default_factory=config_obj)
 
 
-def create_test_suites_config_model(test_suites: Iterable[TestSuiteConfig]) -> type[BaseModel]:
+def create_test_suites_config_model(test_suites: list[TestSuiteConfig]) -> type[BaseModel]:
     """Create model for the test suites configuration."""
+    complete_test_suites = [TestSuiteConfig(test_suite="smoke_tests")]
+    complete_test_suites += test_suites
+
     test_suites_kwargs = {
         t.test_suite_name: make_test_suite_config_field(t.test_suite_spec.config_obj)
-        for t in test_suites
+        for t in complete_test_suites
     }
     return create_model("TestSuitesConfiguration", **test_suites_kwargs)
 
-- 
2.48.1

