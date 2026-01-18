Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC046C9830C
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 20:13:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A64A427AD;
	Sun, 18 Jan 2026 21:12:44 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 41D8B427AD
 for <dev@dpdk.org>; Sun, 18 Jan 2026 21:12:42 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-47ee4338e01so14641985e9.2
 for <dev@dpdk.org>; Sun, 18 Jan 2026 12:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768767162;
 x=1769371962; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IOTD7rHnQdwM8FTC0sJ8IF5bxmOo1i1qWBcjYH4Y6jc=;
 b=vUck7OuxWVr1PDSPY+ibVg9tp4s/YQ3JlcRcVRq+6g+1+a6/YlVimizbhoTk2GMhce
 VhzEXjLMYNecKBY1pyGh1GupIhj5YLbkB4zvt4IIMzEG5h5gT6tlyYjGAQjAri8PXHTj
 l6isaKDONjZsnYZOqQn2TOs1frDLPEWxP06MxvNk/0Ux/bgGm8wTBkz2O2GBLS7rG7Za
 +u8FCLBZ8gMRwW7obpKrn/nEnP8pkSFlc83UMYa9cVo8AhAK6htpBUD8/EW6nSd8BaAt
 GscWHpMPGzAUJZYvUNja1QOTio+7MYidsrFTJvzHYhl8Eb1K3CstG7P2eUgYLdZw/5II
 bS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768767162; x=1769371962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IOTD7rHnQdwM8FTC0sJ8IF5bxmOo1i1qWBcjYH4Y6jc=;
 b=ag8oV8jKE8P2qjMrfn8R6xzANKHcA4LN+CAnvjzYJubMfldmRTwbA7EzYfpE/3hyzI
 +30a9bSu6Cku1oxjlk5PGMg4QHkof2IpGC0yRdOdzas4x+6rikdo4wRSLOMAk16/VgZx
 UkMf7/t0/cOqtbrGpo3yq2B1ixOo+fuwYjtsu/QExqhVIAe1DMV3TB3XpP7gzyYSO96a
 nXzVYskSnWls1fqsiGAXEX0SroLVZG9caZXjuIrNfp49qnrDwxz7ya9P2BQU4L36w+/2
 gRTKqXtYRuNt7DOK4lVh1j8aMkTPXvI4tlu8pW9WQ3zRuDVCG9iAPcdFeu5586YgusEL
 bKEw==
X-Gm-Message-State: AOJu0Yx3xy5e7waOBR3I13tMiwATK2C2/DZIH/FoTCAl/7npoZUal4XR
 0w7BIMgB/uatWfl9iV6SW81OtfvL77fRYIzxdajd8xqUzwlO1sc+X/vm7Laflhkyv4x2MeGiroA
 Kpni8
X-Gm-Gg: AY/fxX5rAlCAK+iQ5rOSRzHg186e8E+1UOTY1wx79mVvMP7O6NYvcH13TR/8z4AAFnb
 6Y0Lrwa9RNho2OMwZ96XdhvwjKLVI2ncL1HcxxXp+clcOlHnNt9XuxQF5e1B6NfWosYe7wUXHt9
 Q7KKZkiJkH4PPFcZb5KVFJYOnXOoWX9GeFJ+Sl1dHrTJqXwWMCBdXNw2YCNGcS80VmmBg4pve2g
 GUAFvnx1Qvwg0m/ot7xrDjTMo/emyrs3uMcgrslG4xfzTkjrCeI03OKTBKAyX51v52GObqUY7ig
 o78GiRmbaazM5kct2aEGj02YhuhmUy285y+9uqGwkFWd5tQg9JtOOjzCe44YKQttJpfxrCSsreg
 s+hsidEc4FcdRxrQX4hls8boOQy2GD1wNTee6ZxIGPIvCBC1MkXsfR+AG68lQQ8aVZzV0LNW/MQ
 eQlr/mzx3ROjnVPB5i2dyZX05Q15Zq4W+oTCo2k35O3OyF31B9mQ==
X-Received: by 2002:a05:600c:870c:b0:47d:25ac:3a94 with SMTP id
 5b1f17b1804b1-4801eb092demr116784865e9.17.1768767161804; 
 Sun, 18 Jan 2026 12:12:41 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe6d9a7sm66364795e9.17.2026.01.18.12.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 12:12:41 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 6/6] test: fix trace_autotest_with_traces parallel execution
Date: Sun, 18 Jan 2026 12:09:13 -0800
Message-ID: <20260118201223.323024-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118201223.323024-1-stephen@networkplumber.org>
References: <20260118201223.323024-1-stephen@networkplumber.org>
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

The trace_autotest_with_traces test was reusing the test_args array
from trace_autotest, which already contained --file-prefix=trace_autotest.

Fix by building trace_args from scratch for the _with_traces test
variant instead of appending to the existing test_args array.

Fixes: 0aeaf75df879 ("test: define unit tests suites based on test types")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/suites/meson.build | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/app/test/suites/meson.build b/app/test/suites/meson.build
index 38df1cfec2..e62170bebf 100644
--- a/app/test/suites/meson.build
+++ b/app/test/suites/meson.build
@@ -106,10 +106,18 @@ foreach suite:test_suites
                 is_parallel : false,
                 suite : 'fast-tests')
             if not is_windows and test_name == 'trace_autotest'
-                test_args += ['--trace=.*']
-                test_args += ['--trace-dir=@0@'.format(meson.current_build_dir())]
+                # build separate args list to avoid duplicate --file-prefix
+                trace_args = test_no_huge_args
+                trace_args += ['--trace=.*']
+                trace_args += ['--trace-dir=@0@'.format(meson.current_build_dir())]
+                if is_linux
+                    trace_args += ['--file-prefix=trace_autotest_with_traces']
+                endif
+                if get_option('default_library') == 'shared'
+                    trace_args += ['-d', dpdk_drivers_build_dir]
+                endif
                 test(test_name + '_with_traces', dpdk_test,
-                    args : test_args,
+                    args : trace_args,
                     env: ['DPDK_TEST=' + test_name],
                     timeout : timeout_seconds_fast,
                     is_parallel : false,
-- 
2.51.0

