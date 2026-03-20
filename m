Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5777A1099B30
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 21:05:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55200402BB;
	Fri, 20 Mar 2026 22:05:33 +0100 (CET)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52]) by mails.dpdk.org (Postfix) with ESMTP id 94B58402B2
 for <dev@dpdk.org>; Fri, 20 Mar 2026 22:05:32 +0100 (CET)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-89c4f7f8650so15813036d6.0
 for <dev@dpdk.org>; Fri, 20 Mar 2026 14:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1774040732; x=1774645532; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Rb+ZuMFckO+kFgb2p9Z6v0IhkhIsd2EdSrz+CLIKN1s=;
 b=g+l24JS7AqYP2AAfZWuU/x9RCCOdg+jSrVttGjOc3HuG3ToE283NxHlFPaMcg/qfu9
 Cti8LSbvUW1kmPZ9/x/8pzhIn+XrsYgAmRkYKc+jptixF7V6NhOXixKJnSvfrhaPFjab
 T3HDYsD8qjQgMwZ4rcP0ocZ615s1Yhkj3sl+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774040732; x=1774645532;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rb+ZuMFckO+kFgb2p9Z6v0IhkhIsd2EdSrz+CLIKN1s=;
 b=CZkCguB14gvxc07nW+W54OzSb9BAN5jUbT8Yf+/GDFOuwNOdl4qbCF0Lcj8yn1OT+7
 vIBj1JMufOX4VSpIUoIeqjSqJWYeynN8da+x/YhV5GV+sxAIW2jVTY2BqIosdgtRrqOq
 Of3Iht+yKG2x8i53YbMTAFC9HIDo5OQJamRgnYTmUTN/ScWs3k+29mSVHfj2uzedNwKZ
 q/OSXZfolAt3T8tUsBc+2KqJdyT3oOEsY/w5CeQ4BpZaPzRAss6N9ji9WIIh8E+TYXr1
 BwGajgiXqoVOjI+2VOD9ZGberMC5TW2uDrJ3q37/S3rA8ZxfENRruDOguHLnJZN9kGXR
 vv5w==
X-Gm-Message-State: AOJu0Yy9U3HRgdPQRLwhPNRrNhj9pjwSA5DnHfAJ8rXKARWraIGp3KnQ
 oj3KRH+MYEh3AfblyALXCbaoDRunMAs+N1ssmivnW+gvlvnzeR30vX/YmqZZiQHaQ0k=
X-Gm-Gg: ATEYQzyNjj/8BLKon/SnsjoVPTlk4ec1ARNsVqFLa6ZlQOiP41aX9AQ7JcYtWOAqZPN
 oKAntWairFWiG9ScWljRx5+XV1DktlgSRsvCwvesNdbDkT2looSNJ2ozVLZkSaXTffpUwtiqUWb
 pnl1n9PWbnjNO+g1YEMcAzgelVjA9h3HFpUPXdsZ2tfauVNpBXvDGOIUAzUDrtLkpvP6l0eOT6B
 J3683tyVzDOZn5yDyI/a6LlGewtl7iywKkttAnJR+6fbNxT05YrLsre1BsK6FW2ButBbgK27YH1
 cG4ozDGVmNEp14L4dafa/rHncoLxO0SVZKLyleVItLIFboysPb5eukKQn79xOI1WliqgGQyTjfd
 +tpqzBJ/5StjKnQU7hbGmwU4qSDTS2Nk0PEH/LGQhEIVzgsiF/Vkzke2BmHPbuWopQFgWz7mZ/s
 QVHfw3Rizyq8RSFxo6zV6wvgAo7Z2cVhVuvt7zIWn0+je0qM//yESx4oY/Os/0ynZTMWXFqUyBB
 DwMfx3aGcT8
X-Received: by 2002:a05:6214:21ae:b0:89c:8671:10a with SMTP id
 6a1803df08f44-89c8671033dmr61883946d6.0.1774040731702; 
 Fri, 20 Mar 2026 14:05:31 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1210::224])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c85348934sm27843266d6.38.2026.03.20.14.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 14:05:31 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.edu, abailey@iol.unh.edu,
 Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v1] dts: fix test suite filtering
Date: Fri, 20 Mar 2026 17:02:16 -0400
Message-ID: <20260320210216.259728-1-probb@iol.unh.edu>
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

When a user includes a testsuite in their config while also
disallowing all of its respective testcases via the func,
perf, or crypto fields, the testcases will get filtered out
of the testrun, but the testsuite will remain as an empty
testsuite in the results summary. This patch enforces
filtering out testsuites which have had all of their
testcases filtered out.

Bugzilla ID: 1907
Fixes: ba648fb1a66a ("dts: isolate test specification to config")

Signed-off-by: Patrick Robb <probb@iol.unh.edu>
---
 dts/framework/config/test_run.py | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test_run.py
index 39f2c7cdf6..76e24d1785 100644
--- a/dts/framework/config/test_run.py
+++ b/dts/framework/config/test_run.py
@@ -515,17 +515,18 @@ def filter_tests(
         else:
             test_suites += self.test_suites
 
-        return (
-            (
-                t.test_suite_spec.class_obj,
-                tests_config[t.test_suite_name],
-                deque(
-                    tt
-                    for tt in t.test_cases
-                    if (tt.test_type is TestCaseType.FUNCTIONAL and self.func)
-                    or (tt.test_type is TestCaseType.PERFORMANCE and self.perf)
-                    or (tt.test_type is TestCaseType.CRYPTO and self.crypto)
-                ),
+        filtered_tests = []
+        for t in test_suites:
+            test_cases = deque(
+                tt
+                for tt in t.test_cases
+                if (tt.test_type is TestCaseType.FUNCTIONAL and self.func)
+                or (tt.test_type is TestCaseType.PERFORMANCE and self.perf)
+                or (tt.test_type is TestCaseType.CRYPTO and self.crypto)
             )
-            for t in test_suites
-        )
+            # Only include test suites that have at least one test case after filtering
+            if test_cases:
+                filtered_tests.append(
+                    (t.test_suite_spec.class_obj, tests_config[t.test_suite_name], test_cases)
+                )
+        return filtered_tests
-- 
2.49.0

