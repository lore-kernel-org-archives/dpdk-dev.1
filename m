Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4369606A323
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 21:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=OOMEc3Hx
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58B5442D3F;
	Thu, 12 Nov 2026 22:00:41 +0100 (CET)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTPS id 949F9427C1
 for <dev@dpdk.org>; Thu, 12 Nov 2026 22:00:39 +0100 (CET)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-93ece7a73b9so19940685a.3
 for <dev@dpdk.org>; Thu, 12 Nov 2026 13:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1794517238; x=1795122038; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HQhPLQrHZHOYW8Pp6MvVqOBbCLYDJZPbAK5UIhT9R0Q=;
 b=OOMEc3HxNimyoP2HBtM/8s4agoXfZM3qkRfpgwP2oeI0BPQtnVAgEW1weT4/pqwwuX
 Vqxy90FQn1D5zW8ICM1ZOGAqeGVwOFvdgJzDtFnYhcGEfGGj9cAuyrXpnfVmsRoIYqmt
 g/2/lhyUnsgkpBsyDJvYkxLRSgxrVhs9uvpq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794517238; x=1795122038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HQhPLQrHZHOYW8Pp6MvVqOBbCLYDJZPbAK5UIhT9R0Q=;
 b=yYT66hphgrVAFuiq765BWfRymqVCv321DR/WO2jRe562X8pBE8uS6wndut1g6oFa5D
 GjWa6IRDYBG7JMLxOw+XeDzkzQObyRKX03hm412BspUUJwka5PBXi9z8qxSVGy4JX+5Z
 sP7m4+E4uD1iPVerdqG8bYUxjtnIqtbrTVf9zrtIE9XoNr2AYoBuzNyMUQbjXfMFuzAI
 rWZoryD7tCJeEREB5Ygyeq0RYAb+wR8AB+RymYVN52X2t2AKWfY8JDHK9S50HwtJoLY+
 6i0QVBKx9pyc8sGXfhU1fV9TOcSBhBDXxyAbSftg4gtrzOHYkw5WBnmZLk4VE3vjPLyS
 cquA==
X-Gm-Message-State: APuU4Z8Nv+GR+zUFFIgisvlvje3e7bG/j5zUWv6Y3hdgvrcmmDMykoqU
 jKR/17iE5tF8UL8fM7ONb3nPOAmcugLQCUs0RXGqv/RoYG3ONJHn4iu3f4SAbTI3Z04sFECxjBb
 Yq+cs
X-Gm-Gg: AYBFou0axiSUI+R+4NQo70Vixc5C1xc0ArLolUvur7ngwckNtNbzS3j4HT9kQ+Hy5Oo
 UOWDATG7z5zc0hh4+AOI2e2NHMfL26zqmr7RJ/0UKy9nwBrz1tqHJzJmoQXfKhlSJx5wR73VHMs
 oXfS0lQvyEosglVo0+ekVYYYwgynUDNyJFZNDsVnxzdFGfIQrwsjrEUqC1zRsgA8LOa2l2xGRqt
 0M3b5QtwOUTkW5gNjGbjodUgJavDDiinVGdYEPEpbZ+Fa3FSKfa8CTOVRjFl2yWxJk0h0uq6GTt
 5xxznpmhPQIKdvR8Jjkh+XDokOglgHaJIBsERpRMOpojO7E0NkJ7U6gjj7aXG+8KjB4jTGGOiWF
 bO7ZCUZHQP2+itnIewI2Im1R0dw6gCb4w3avQ3yOw9Gh2Tjkvhfu4CqzOgE15dB6+5P9ytae10A
 YIdNVtOWCoXE26rMm+rU+ny3xyYLp4f0D+FpYak3RhQxwKrtFefGPFI/pRNTHTqONTpGFN+VlCk
 7cxH5U2KKGNzutdfVrd+u04VG48q0yTd1ZqcQyzpIkzwadzOQPgUOxHHvvOgBxTOK9cz05SpBbp
 SW003Vq+zDVgALC8oKK/d7FxKKmrgoZhiooclRifmIlNQPPcPvZ2OCV9+QMdnQZrBXgOP7yR+IW
 tKxQApqofHBJl0cl7u0klqxwGhE3ze7HOPx5WnZI9uXQDi2kpYme4khiNpnCAocQVOMJSHTjJtf
 TfphGUZ75h/TUhdYx2cGcc1xw=
X-Received: by 2002:a05:620a:880a:b0:93e:c12c:f147 with SMTP id
 af79cd13be357-9494bc341aamr101316285a.81.1794517238451; 
 Thu, 12 Nov 2026 13:00:38 -0800 (PST)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:79a6:f2bd:f6a:842d])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c8d8298sm25178585a.38.2026.11.12.13.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 13:00:37 -0800 (PST)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, dladd@iol.unh.edu, abailey@iol.unh.edu, lylavoie@iol.unh.edu,
 Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [PATCH v6 1/3] dts: create default performance test configuration
Date: Thu, 12 Nov 2026 16:00:07 -0500
Message-ID: <20261112210009.1620168-1-knimoji@iol.unh.edu>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261008191139.1094155-1-knimoji@iol.unh.edu>
References: <20261008191139.1094155-1-knimoji@iol.unh.edu>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Previously, all performance test suites in DTS shared the
same test parameters but created their own configuration.
This patch creates a centralized configuration that can be shared
by all performance testsuites and provides default test parameters.

Signed-off-by: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
---
 dts/api/test_suite.py | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/dts/api/test_suite.py b/dts/api/test_suite.py
index 8a96a5cbad..1be9efd95e 100644
--- a/dts/api/test_suite.py
+++ b/dts/api/test_suite.py
@@ -107,10 +107,10 @@ def make_decorator(
         determine the type of test suite.
 
         Args:
-            test_suite_type: A functional, performance, or cryptodev test suite.
+            test_suite_type: A functional or performance test suite.
 
         Returns:
-            The decorator of a functional, performance, or cryptodev test suite.
+            The decorator of a functional or performance test suite.
         """
 
         def _decorator(test_suite_cls: TestSuiteClassType) -> TestSuiteClassType:
@@ -499,6 +499,39 @@ def discover_all(
         return test_suites
 
 
+class PerfTestParameters(FrozenModel):
+    """Generic performance test suite parameters.
+
+    Attributes:
+        frame_size: Ethernet frame size in bytes
+        num_descriptors: RX/TX ring descriptor count
+        expected_mpps: Baseline throughput target
+    """
+
+    frame_size: int
+    num_descriptors: int
+    expected_mpps: float
+
+
+class PerfSuiteConfig(BaseConfig):
+    """Default test configuration for performance test suites.
+
+    Attributes:
+        test_parameters: Default performance test parameters
+        delta_tolerance: Default allowed performance delta variance
+    """
+
+    test_parameters: list[PerfTestParameters] = [
+        PerfTestParameters(frame_size=64, num_descriptors=1024, expected_mpps=1.00),
+        PerfTestParameters(frame_size=128, num_descriptors=1024, expected_mpps=1.00),
+        PerfTestParameters(frame_size=256, num_descriptors=1024, expected_mpps=1.00),
+        PerfTestParameters(frame_size=512, num_descriptors=1024, expected_mpps=1.00),
+        PerfTestParameters(frame_size=1024, num_descriptors=1024, expected_mpps=1.00),
+        PerfTestParameters(frame_size=1518, num_descriptors=1024, expected_mpps=1.00),
+    ]
+    delta_tolerance: float = 0.05
+
+
 AVAILABLE_TEST_SUITES: list[TestSuiteSpec] = TestSuiteSpec.discover_all()
 """Constant to store all the available, discovered and imported test suites.
 
-- 
2.56.0

