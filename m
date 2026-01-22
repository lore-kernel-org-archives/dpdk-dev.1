Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC88C44508
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 00:55:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45E4D402ED;
	Thu, 22 Jan 2026 01:54:25 +0100 (CET)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id 26DFA40E0F
 for <dev@dpdk.org>; Thu, 22 Jan 2026 01:54:24 +0100 (CET)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-4359108fd24so233396f8f.2
 for <dev@dpdk.org>; Wed, 21 Jan 2026 16:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769043264;
 x=1769648064; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iIOpaz/iCa4IaXtKDU80VNBjuXH3LNZl+92g1EdD/HA=;
 b=uRSWD20bqKY5P9Xj6jEeNaDuWZxm3FvUn5vsUS5TWw4yAxyVKf5DU4WtL70mXp6lIn
 OolVpVr+LfZOI9o1EzxF2MZ3bXmFYe2A+8BIajWjFvglVyZAGMB3q2F7yRTJ0FGaRVwj
 cVnxJ+Cg70wx/oFwyQNy6GVQ55AdN4miZIE7SjjoM2S6PV7xlLfbwceFPEaisyGF0Yuo
 GlV6RGDG8Zy+5fp3ro5NiDg/K4aOdcA+Fj1QbffNoSMDG9aaNFE9z1rp0l17QU9hH9Ox
 s7MvdLOw5JF9ZdYf1WGE8HmDcWnCzBRiJ0hIiIyusC9vqHv3szz3VBLQfzuH2ABWAsjC
 6Oyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769043264; x=1769648064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iIOpaz/iCa4IaXtKDU80VNBjuXH3LNZl+92g1EdD/HA=;
 b=p6CF8/wliBN4oF+kDZpTNmhDwrq0zgZJeDpY1zzRSW4w8nSNj7noQK+dKllLilCG72
 RCQAsN8F7mW6KZghq0wr0yzozQ5ir/+qj7xvKk3Y1ZAqY75G1yFZFpfMsC1lLUkR86Su
 5PLC/b+EVHwJyb3iFn4mXM+E/ZCs2VlV4GBhgVN0KJu8+4mtYGXJIZOG0UsyAopPgqNG
 0OXLdCEIhzRAuLxuIkx4sBcP3lINa/yTokTg0eNCrwoup8notU8zxgHD7GBWEfEh64vJ
 QwBuUuNwL/bEicQ+Q2JAB/JNT7OA2Tx/ZaLMduZwbYWs0S/9paEd8DjBPljs+VrF2icD
 WiSw==
X-Gm-Message-State: AOJu0Yyk9SAq+/ziFmYiZwZhS5YeVvqOBd7bCAH9oEnsiFoii7kDYMkL
 PyVFOw4R3x4dNlSbXOObsyaL3fub3JB3XFCnyEZRTIksePgjAmxlc8BmhtmNTXtq73qMFN2FSOh
 nnIUV
X-Gm-Gg: AZuq6aLpjBzkZL1ZA84bQJrKNUbKOYlv71LPcqGIShp+Dj2OMEI7qbtroSDa5JwuQQl
 fLvHsueOZFOXyxfWqcf9kEJbj7fnuZkI2XCB+GiGgiTpSZyrvxMcdb+a9glc0Zcx61LJovCoGtQ
 NHo/ksg33VPQCc1JUijvreF7EtlAGR9jEosRdM3932v6F/vy5ZG/+6BypWAnzWQnzQWfXV9lKyj
 BmlzRq1/KzyU8SXiVPJU9MjIwzwbYZ6xeK+F+zFwUKDx6CCjn+mrC7DbNtXPUCqNgKv0Lg52A2+
 iMTQxwKa+9B3AFodht4NBV/YIeFKh16/awrTX2KsqHrxT+Ufd6A6A/2PfWaXoaCNRoJR78o53Us
 4DgXcj3QjMZUy0mrlVlQ7ccXd8DBXfxpQg6eufWu0RjmZ9N88tIVr3pYJ7Sr672r1hYa6i4D3YJ
 htGgf8KyrhNkdlB7P80tzUEa2PI1YhUmA31AofxesaNEM9T8y9RIBJcLjhTj1S
X-Received: by 2002:a5d:64c3:0:b0:42b:3131:5437 with SMTP id
 ffacd0b85a97d-43569bc17f6mr25149852f8f.34.1769043263740; 
 Wed, 21 Jan 2026 16:54:23 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997e6dasm41695104f8f.32.2026.01.21.16.54.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 16:54:22 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Marat Khalili <marat.khalili@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v3 09/14] test: add file-prefix for all fast-tests on Linux
Date: Wed, 21 Jan 2026 16:50:25 -0800
Message-ID: <20260122005356.1168221-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122005356.1168221-1-stephen@networkplumber.org>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260122005356.1168221-1-stephen@networkplumber.org>
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

When running tests in parallel on systems with many cores, multiple test
processes collide on the default "rte" file-prefix, causing EAL
initialization failures:

  EAL: Cannot allocate memzone list: Device or resource busy
  EAL: Cannot init memzone

This occurs because all DPDK tests (including --no-huge tests) use
file-backed arrays for memzone tracking. These files are created at
/var/run/dpdk/<prefix>/fbarray_memzone and require exclusive locking
during initialization. When multiple tests run in parallel with the
same file-prefix, they compete for this lock.

The original implementation included --file-prefix for Linux to
prevent this collision. This was later removed during test
infrastructure refactoring.

Restore the --file-prefix argument for all fast-tests on Linux,
regardless of whether they use hugepages. Tests that exercise
file-prefix functionality (like eal_flags_file_prefix_autotest)
spawn child processes with their own hardcoded prefixes and use
get_current_prefix() to verify the parent's resources, so they work
correctly regardless of what prefix the parent process uses.

Fixes: 50823f30f0c8 ("test: build using per-file dependencies")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/suites/meson.build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/app/test/suites/meson.build b/app/test/suites/meson.build
index 1010150eee..4c815ea097 100644
--- a/app/test/suites/meson.build
+++ b/app/test/suites/meson.build
@@ -85,11 +85,15 @@ foreach suite:test_suites
             if nohuge
                 test_args += test_no_huge_args
             elif not has_hugepage
-                continue  #skip this tests
+                continue  # skip this test
             endif
             if not asan and get_option('b_sanitize').contains('address')
                 continue  # skip this test
             endif
+            if is_linux
+                # use unique file-prefix to allow parallel runs
+                test_args += ['--file-prefix=' + test_name.underscorify()]
+            endif
 
             if get_option('default_library') == 'shared'
                 test_args += ['-d', dpdk_drivers_build_dir]
-- 
2.51.0

