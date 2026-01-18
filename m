Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FCDC98315
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 20:13:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0EF8427A5;
	Sun, 18 Jan 2026 21:12:41 +0100 (CET)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id 1E4174275A
 for <dev@dpdk.org>; Sun, 18 Jan 2026 21:12:40 +0100 (CET)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-42fb6ce71c7so3247415f8f.1
 for <dev@dpdk.org>; Sun, 18 Jan 2026 12:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768767160;
 x=1769371960; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tXmjPdcMoNkOkA4T2o7g71XEVw6gx3RKLcXtgFNuN3E=;
 b=NOkRgwO/3PxX+8lXafExp7yynck9daKORRLKU+r/BcwuLCXMTLOIC172mSCTUJUloL
 KM5q6/8kSF/lYbR45NZd6wos8gGR2wd4S+l/PjRMgHq04Xff9RV2xwrksI1Vs6fl+QRK
 zyHxFfyOv48Ap3Lkjnn2QWTwkToKUCx7cY94JniCPh70E/wPufzvVkcIB/RmMGLaNPXo
 GvC5l/RmJb9jXe0GL21GHIJRKz2qj6JEJjlboiN3MqGMC+8tAu12DpBimFdyumyO18hl
 jYusEil6/SBQHLKa9kAzm5Ypz9QGxc5zwYOZ6PMs9HfDER8m85daUkjXvaKAWFaewuok
 u8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768767160; x=1769371960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tXmjPdcMoNkOkA4T2o7g71XEVw6gx3RKLcXtgFNuN3E=;
 b=cLcfE7+78frErnXyvISYxZUfLZIIcH/HkRY7gqk9tovYxB8I97YXP205X/+y4WQps4
 MWwiozI/QosXg/UQw+xFmyUuym7C1qIoLbBjbZLVDGTnDcbJx4yWon2MxgL7LybJbPST
 PvAsIbdS4ZX9uIzBQ+lyscThuC5Ws8YYOrrzUBjzSLVGKYNzjnuRY5etrAfG3f+DxifA
 1v5ioscrktrqYlDssl2cWDnfLWfyp9ahv9W4Jx1t2U6Pk87Fly2RbGnCB41cal7SzzQz
 ewJXrrfQz4BFKPhx9wbwMssNZAtMi7SJrQ71kYt5YI98MgXqkSBLT9xxCJrS5Er7N+qX
 NC5A==
X-Gm-Message-State: AOJu0YyBNnyJhkys6nwKihfa5v+wVWeHcBxE9HERmJKsKyf8HjorzLdq
 LtnGsP5zpCAxkmQRZ4nu9E9elFDk7jVpkGVudJe9d2MUoCvKDak3p570jnTK3lS9bt7pkki8tWf
 d5xoB
X-Gm-Gg: AY/fxX7GnlOPuROV1FkGPXgaRPTUbq2Shx9VVdn12T7AdAW2CqZ/jH0/7AJOW4UiZ9K
 hUsr47IgMU4/YqL48FxO+tlQ6s98QUy6SL6IOlADJrsCo7Q8dpKCdeidJuCR9qyrxxW5AXzYUJ+
 IycyM6ciB+ER4lzabSOL3/YdAQU7YqVtwX6hulOtfwp2GTbFPQP/x2z8JpPrL/hRfaW9yvKeGVD
 +6Mf+22HPIytLmwaSZP8obLU3rn1vjz7EsPgW0IwFpTT3KjHNrOfWFbIVwxuFGV5+cgImP68uOw
 eEOELpPovAVnHCreevJ9p8H/qydtTzIBs307o88CSRFlBQ4G1VzqcpRCyKUoRFxDXIYyP01p/Dm
 uPKGe5jVAlpHv1D0V3XPIY8lQCg7EPXQwdFdLS52NlzX0OOMU16IbSNMK/9F4sjbNJ7Msn2Eg4N
 paLdb4Ah2BbAycOtAPT2h5UlnYIGr97bTc2ntnq4nedpAWuuoGaA==
X-Received: by 2002:a05:600c:8816:b0:479:1ac2:f9b8 with SMTP id
 5b1f17b1804b1-4801e334379mr94321105e9.21.1768767159711; 
 Sun, 18 Jan 2026 12:12:39 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe6d9a7sm66364795e9.17.2026.01.18.12.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 12:12:39 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH 5/6] test: add file-prefix for all fast-tests on Linux
Date: Sun, 18 Jan 2026 12:09:12 -0800
Message-ID: <20260118201223.323024-6-stephen@networkplumber.org>
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
---
 app/test/suites/meson.build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/app/test/suites/meson.build b/app/test/suites/meson.build
index 1010150eee..38df1cfec2 100644
--- a/app/test/suites/meson.build
+++ b/app/test/suites/meson.build
@@ -85,7 +85,11 @@ foreach suite:test_suites
             if nohuge
                 test_args += test_no_huge_args
             elif not has_hugepage
-                continue  #skip this tests
+                continue  # skip this tests
+            endif
+            if is_linux
+                # use unique file-prefix to allow parallel runs
+                test_args += ['--file-prefix=' + test_name.underscorify()]
             endif
             if not asan and get_option('b_sanitize').contains('address')
                 continue  # skip this test
-- 
2.51.0

