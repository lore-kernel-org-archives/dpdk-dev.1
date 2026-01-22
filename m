Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92356C44508
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 00:55:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E78140E72;
	Thu, 22 Jan 2026 01:54:28 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 4397140E17
 for <dev@dpdk.org>; Thu, 22 Jan 2026 01:54:26 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4801eb2c0a5so3918325e9.3
 for <dev@dpdk.org>; Wed, 21 Jan 2026 16:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769043266;
 x=1769648066; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0wVoHSHSSY4Hepl46iNcs4Wp5J2ylxeuMgRSLGSZt3k=;
 b=IauokSIKjEaoU0rDAz7gwj7sfd4fo/VBTT0ysWfPG/iAp6NbNdwoYEjfmJsT8reFbo
 E9LcF12ILcmn/nmZUupwkeHmJVuNrqTtm5R7VlVp6Ixcm0DDZ/Iy580MbRghBGwERZ/0
 Q1T9mldrhDVm+OguJDlCv6PQnIsytR9+Udxii7GXICf59grxvio2irEcbVV01MrecsUU
 YkwP9YxrZr/2kPY0VxLQWAsVjV6p2JiC6yuAOrmZJd/tTDIYddfNrFQ+Xo0rKn9EyY/m
 oYFZQN5U+2H+OSfS3/FnXenOXynNaB9bj7vtmw9L990GAUv687a4bMW8l56nDwh+bm/0
 WemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769043266; x=1769648066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0wVoHSHSSY4Hepl46iNcs4Wp5J2ylxeuMgRSLGSZt3k=;
 b=OKCxeFpfc9jkbPODdCdrPqpR1LaFv0OZSAyJqvju7Phd5GGxXSsH6VxKzw18rbzofY
 U2kaA/prwVOu0vQsMbWYvbU6ntW768TgKiiUytd4U2TixPLBWOWcZCQATfHC++j6No8O
 mR7qJ0KI0yP7CXD9WO2j/Q/MxLzV2jxUTo9md66iMS+HbUMjciwZg4oHdY7TD0UaOYw8
 1Zr6qtpeOTPknnKxCBFMl+wsCjR0AMpJxV0hQfNAOz9GsJXFvkGcYjlF6690lMBBVKf2
 UQuDmxlQgy6iDlQVcbuJ/qexeWTii1dg6mTl5Qk7D0ZNoQblAEFvMDjZpPufJWfM7Sfo
 gjog==
X-Gm-Message-State: AOJu0YxElmFQ3AWLXUvS9U8HCNlX25Qd4OFQejNBrP7vFoLDzlEIIMN/
 2rzkB5oR7bPH8s9ak+RB1zxk5cTGRXZHmpY6mTZW0J1tRw/1CTZXLQvmr6jkmjizoqeP9v+ig7f
 yKgJj
X-Gm-Gg: AZuq6aIEkocVIW7Mh5gt61yY7yYvOaf9wkleda8NjPze0dg8a69cWbCr6L3zInhMSPM
 we5l22Xx+JCPR2Z5/erkmvggE0ZOWWNF14uVM62U3BqcqMSlAC3CsbRaO1T3N/4YmoIOl0/qV+L
 waDRyCbNFfHTnCGwIbIwCkfwGeOyynk7HFkBhrKQdcc0rImrj/X69jeYHAglEUF0UuGjUVZEdBA
 eXJgnS4O6uA6lqfVOAvyEUj5cMDzEFL70We1C/a0vnmaBdExFiJZq0fMBHzg81v/6g9X91yYY+O
 tW/HOc1M0ho0LssEMb2hZuvjz6gjXJTHEoHL+w7Qb4UNwtpr46fSZloLDHCO+W9JEZweMmnCb3F
 H4xplEaBydfgnyVfzFqApuISmZUX9BEIw6RgVAevdAXtVmXmXrdTcIRRrVbVX1klQ8xxp6iR2km
 LVIKmJp9xvHTwT8DLAxjwlfI5cYdDuC9kHD5+S+i7ZaMnI6t0gmQ==
X-Received: by 2002:a05:6000:4007:b0:435:95c9:687a with SMTP id
 ffacd0b85a97d-43595c96c1bmr10721966f8f.4.1769043265770; 
 Wed, 21 Jan 2026 16:54:25 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997e6dasm41695104f8f.32.2026.01.21.16.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 16:54:25 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v3 10/14] test: fix trace_autotest_with_traces parallel
 execution
Date: Wed, 21 Jan 2026 16:50:26 -0800
Message-ID: <20260122005356.1168221-11-stephen@networkplumber.org>
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

The trace_autotest_with_traces test needs a unique file-prefix to avoid
collisions when running in parallel with other tests.

Rather than duplicating test argument construction, restructure to add
file-prefix as the last step. This allows reusing test_args for the
trace variant by concatenating the trace-specific arguments and a
different file-prefix at the end.

Fixes: 0aeaf75df879 ("test: define unit tests suites based on test types")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/suites/meson.build | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/app/test/suites/meson.build b/app/test/suites/meson.build
index 4c815ea097..786c459c24 100644
--- a/app/test/suites/meson.build
+++ b/app/test/suites/meson.build
@@ -90,26 +90,29 @@ foreach suite:test_suites
             if not asan and get_option('b_sanitize').contains('address')
                 continue  # skip this test
             endif
-            if is_linux
-                # use unique file-prefix to allow parallel runs
-                test_args += ['--file-prefix=' + test_name.underscorify()]
-            endif
-
             if get_option('default_library') == 'shared'
                 test_args += ['-d', dpdk_drivers_build_dir]
             endif
 
+            # use unique file-prefix to allow parallel runs
+            file_prefix = []
+            trace_prefix = []
+            if is_linux
+                file_prefix = ['--file-prefix=' + test_name.underscorify()]
+                trace_prefix = [file_prefix[0] + '_with_traces']
+            endif
+
             test(test_name, dpdk_test,
-                args : test_args,
+                args : test_args + file_prefix,
                 env: ['DPDK_TEST=' + test_name],
                 timeout : timeout_seconds_fast,
                 is_parallel : false,
                 suite : 'fast-tests')
             if not is_windows and test_name == 'trace_autotest'
-                test_args += ['--trace=.*']
-                test_args += ['--trace-dir=@0@'.format(meson.current_build_dir())]
+                trace_extra = ['--trace=.*',
+                               '--trace-dir=@0@'.format(meson.current_build_dir())]
                 test(test_name + '_with_traces', dpdk_test,
-                    args : test_args,
+                    args : test_args + trace_extra + trace_prefix,
                     env: ['DPDK_TEST=' + test_name],
                     timeout : timeout_seconds_fast,
                     is_parallel : false,
-- 
2.51.0

