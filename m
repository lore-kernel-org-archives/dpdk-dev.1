Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88799C36018
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 02:35:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C55D40678;
	Thu,  3 Apr 2025 04:34:59 +0200 (CEST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id 5D6D74014F
 for <dev@dpdk.org>; Thu,  3 Apr 2025 04:34:57 +0200 (CEST)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-7c08fc20194so75302885a.2
 for <dev@dpdk.org>; Wed, 02 Apr 2025 19:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1743647697; x=1744252497; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WhYcIMXd12DqYBGU/mn4zFSrNpuwNyZA+78DySLI5yA=;
 b=JtY5tr5b4qMkITjMNhtV3m9Hs8IsgUo9U5i0Q2wK73AAKcNMDm6Ni++Cpxlz8whAGm
 DjHNr0kissyp++A5OXED0inuuaajlrxDuy1QmxbwvTw0ucqmM+LRFFzviI8vorISiRzB
 PFIOY65enoca8Dt3fGlH9sjOcIhQpRVtzyzas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743647697; x=1744252497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WhYcIMXd12DqYBGU/mn4zFSrNpuwNyZA+78DySLI5yA=;
 b=b0Sy0/9tlUFTS+K/iaX53ur9ZxPjCGKKsEHO6XCEa5twUK3rdc9QGCakO9ibCcbE6y
 clKELEv9/ylGBoJrnd+Pz7Z2/oAkJ2ozpRpxtygZbgXuO6mYrOA8/v1pHzkVdhpZ2w/D
 RuJHQ9FyWvwTg8V2wTepm3pHDOmrd9jXRePsd/G2Vnm4yfMG5yo/D4FMfS8RUIbnPymG
 zX8W6epmygJQ/A+gz3inDfJYhZOmyM0RoTgvfFx50gFKzYZgG+2fbPuzkZLoQFHp/S4q
 r84QfJDqxD2C9DZw68YnFvTBCUO0h0OzJZxQpnDE2Q80dMoKlrCx7kMdQjh8kKpAGjmi
 yOIg==
X-Gm-Message-State: AOJu0YxYvXNeuScgPYsMQOLBewcYtCQnYZn/CMx3Lv83EJzivDT1XN4O
 JC6G5x/of9wiaVp7+gFFCT+iRWJQmG1qSLnLpvtQyJ2Z1vNL4S5Lt/F7RatYrNtJTTYFvyizJVw
 MQs4=
X-Gm-Gg: ASbGncv3UBHy2/K7SFq0UNJQasaA4DU5OQGneFccIC8zJNYDtIYY8HZIGUjSoWLRN5Y
 6j9xw80/fzfwJdSCkrj14O5xsgifVHBxRUeUAEl+bU8yqY9Rv0Gj+3+Ar1xAkSM9xt3fHDn2djB
 zz2fFdEYVmy1senoWgqAMsO5vyzR8e4vawcjZQ8O5C02sn7T6P/KFb7ESRHw9OvA2SXo5eEUJvj
 UKbijVuxFRJTCrxWQ5Jc1MGrSpRMPkhrkVuxenvESjo/a1Ju2KrAVruJvVYaRmTOgGKr8KtWTqO
 F910ekT7fMDuIDI6ONdXHO3tn6j6YqJXi/8vo7tI+WH4JnQNJVQ2k+wAVXvfuyosFcidF2nVJZ0
 =
X-Google-Smtp-Source: AGHT+IFm4Vm7b6W45ryoIhLth/MS34XYjICgaPSk6Ck/FFt/bVMO/WCLel9yVPrf0Gst7uLf6SHipw==
X-Received: by 2002:a05:620a:408c:b0:7c5:4dc4:ae48 with SMTP id
 af79cd13be357-7c76dfc31aemr108154685a.39.1743647696799; 
 Wed, 02 Apr 2025 19:34:56 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c76ea7efebsm23764585a.91.2025.04.02.19.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 19:34:56 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: Paul.Szczepanek@arm.com
Cc: dev@dpdk.org, Luca.Vizzarro@arm.com, dmarx@iol.unh.edu,
 npratte@iol.unh.edu, thomas.wilks@arm.com, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH 1/2] dts: include smoke tests in tests config
Date: Wed,  2 Apr 2025 22:30:58 -0400
Message-ID: <20250403023059.1762841-2-probb@iol.unh.edu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250403023059.1762841-1-probb@iol.unh.edu>
References: <20250403023059.1762841-1-probb@iol.unh.edu>
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
---
 dts/framework/config/test_run.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test_run.py
index 06fe28143c..9bbed10f33 100644
--- a/dts/framework/config/test_run.py
+++ b/dts/framework/config/test_run.py
@@ -303,6 +303,9 @@ def make_test_suite_config_field(config_obj: type["BaseConfig"]):
 
 def create_test_suites_config_model(test_suites: Iterable[TestSuiteConfig]) -> type[BaseModel]:
     """Create model for the test suites configuration."""
+
+    test_suites += [TestSuiteConfig(test_suite="smoke_tests")]
+
     test_suites_kwargs = {
         t.test_suite_name: make_test_suite_config_field(t.test_suite_spec.config_obj)
         for t in test_suites
-- 
2.48.1

