Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A845FCA0EED
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 17:47:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84F154025A;
	Thu, 28 Aug 2025 19:47:52 +0200 (CEST)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49]) by mails.dpdk.org (Postfix) with ESMTP id 47F97400D6
 for <dev@dpdk.org>; Thu, 28 Aug 2025 19:47:51 +0200 (CEST)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-70dfd18a27fso4302156d6.0
 for <dev@dpdk.org>; Thu, 28 Aug 2025 10:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1756403270; x=1757008070; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GEgVIgaMeXaKmzN0wOJJGUk/kMX1Lf1WToEp8ABV6t8=;
 b=jTw3tJnR0CqdrvT4AXEn7gF6RE5lM6+uJonWkR0/TCWNt5UjVm6c+5qd0/vMDBiRJ+
 r/bbjq4vcSmnJf59Fd1QxuvSo3HqOVgxMHnv8r/lZJXamKm/3XWwlORe37ATKVvXzQgJ
 NqJbuVXMwqwZ2KZRs05A5x0YNZXWhfVz8e210=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756403270; x=1757008070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GEgVIgaMeXaKmzN0wOJJGUk/kMX1Lf1WToEp8ABV6t8=;
 b=JLmczPF/hXVpGyXw+3hF0Bp+f+kisqmT7Pyt7VaExExooBpgJFtiWJ8UoY3g0+PYTe
 F3JzWMYyqOcZEm4aZNCaUOM4NbnYFvjGRqiBc5A4/Twt8y464FMEugOtLFlhMUedemmZ
 6sCzD9cA8/PHnMtAlsTxYjQ9bJ5OI3DGfN07+cL5L3ezPCtA4TqNfarB+RdYS8eUNQPA
 8t0amd5iGXQD/GwKbvTdFBEQQ+45GhPKjrI6N1voDW4jY+U44OIPAft3c9jNz7uM8NYx
 Aqd0PlBN8l1UIKeT+oAn4sompH+C5WkNFkv2lufn9zLp9hctBQaS/Tj+jSIvAwE+3tE2
 U2vg==
X-Gm-Message-State: AOJu0YyaRuSVaUloZRyDYpqOyuY+FR35hdxk9p4Edw9EgIcPX/bkqr1O
 aar7mLLzazH3ZcxjpCskhpnoOIJDj0pSxvXDRjdlxsRgx/ewNgIR/FRBm26Ng/MFjNY=
X-Gm-Gg: ASbGncvd6APwLcsR8k0M8oFjbF/mufpVXq2eAKxJz98dDinlw4zHncZOxxG9mzWkI5S
 +/OeQjmcIA2URJyO2Uv7Y/Zree3K7/3ycrc7b+65HJRoUjP2W26uHsbt0mWgkjK86ot+1U3qcns
 XR4BTGgXDmh6e8f1Fvao0APOqKBtR/Gf6JenvdFDelMdnCq4JF9CqxyLcYfoWhsks/Ih8jt7ODj
 3u8txcei5whmG4A2Xrwcaq5q897TIWsXaSodbJwXqWCmPZbntZhFTzqC5ljstsmWy34wt3aZyTY
 EQ+15Fcp3nb7UO7tLb8Iza3uIiklPn6WtJXCqdFGtCeuN12JEy/L3byls51ahnvDCnP+tS8OeXC
 zLLNhly9OslBIdg==
X-Google-Smtp-Source: AGHT+IH971Ijd90a9aq089yhIofkgAjeED3vnN2jXdLjJ7CuKGdTHCk9M+XY0jc5dMVp8G53Kv3NVw==
X-Received: by 2002:a05:6214:2528:b0:70d:f64e:d4a5 with SMTP id
 6a1803df08f44-70df64ee6a0mr32715786d6.10.1756403268889; 
 Thu, 28 Aug 2025 10:47:48 -0700 (PDT)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1210::202])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70df22533a9sm18506586d6.23.2025.08.28.10.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 10:47:48 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v4 1/2] doc: add test case docstring example to dts rst
Date: Thu, 28 Aug 2025 13:47:45 -0400
Message-ID: <20250828174746.114300-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820143922.42596-1-dmarx@iol.unh.edu>
References: <20250820143922.42596-1-dmarx@iol.unh.edu>
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

Add a section to the dts rst under How to Write a Test Suite
which provides an example for how to write a test case
docstring, including a steps and verify section.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 doc/guides/tools/dts.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
index 3837b398cf..be346ca8bc 100644
--- a/doc/guides/tools/dts.rst
+++ b/doc/guides/tools/dts.rst
@@ -414,6 +414,22 @@ Test Cases
    A test suite may include any number of functional and/or performance test cases.
    Each suite should focus on testing a single feature (one feature = one test suite).
 
+   Test case docstrings must include a Steps and Verify section. For example:
+
+   Example::
+
+      @func_test
+      def test_basic_link(self):
+      """Tests basic link status.
+
+         Steps:
+            * Launch testpmd.
+            * Check port info.
+
+         Verify:
+            * Port info shows link status is up.
+      """
+
 Setup and Teardown Hooks
 
    Setup and teardown methods can be defined at both the suite and test case levels.
-- 
2.50.1

