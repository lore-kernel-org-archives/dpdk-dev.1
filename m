Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D5AD2ECFE
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 01:58:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5506240A80;
	Tue, 20 Jan 2026 02:58:17 +0100 (CET)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54]) by mails.dpdk.org (Postfix) with ESMTP id 8A9F14069F
 for <dev@dpdk.org>; Tue, 20 Jan 2026 02:58:15 +0100 (CET)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-64d4d8b3ad7so7866285a12.2
 for <dev@dpdk.org>; Mon, 19 Jan 2026 17:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768874295;
 x=1769479095; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B4kWzGBNTgoP7T5IFzmBjcLBHaYX6QcKf+v/APkDAYM=;
 b=Yf2whl2NLTCUuFG9Y5OCokTCNOkXgOuZXbOMR5daQjaEkIHSuEpz++O+Vf4Vnk1xH8
 Ra1kfvprPP8k9UgnkqG0GXi5wbfBswn+CPMgkUZOfs3OvNICpsGNukthds4g2e05VObO
 2xYuqXmz49zH6qjarJQMx/niF3JXEEPzBf8vbnta1sr5unFmVm9yUAqrmQD6Kly6lteW
 4IVL9E3nGKQgM0DWKpCyBYbcchDQlkJVGuQyk+g8Mnv0Xql3ULEa9v4xrb8PFdaGzSL4
 YOt86GyKeEWcoM+thK/xUoCtIJLBtXUzyo3mo2fCaPfrSfICn0hyO2e/il0wMcGftU2T
 Q0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768874295; x=1769479095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B4kWzGBNTgoP7T5IFzmBjcLBHaYX6QcKf+v/APkDAYM=;
 b=MWe96FDbciH3ephG7vX/5eMnCus2asaZeBYxiCRviIucnqqwkgYW5Yq0FhAxUGXrZU
 Hs0UxML7a/pyJCYUkOeDBPqi8FvpOZiA1UAn7BIP0b6e6eeougZjIwhN/keGuTThzdzP
 73zi9jJDHMgZ37tnpYoQ8/bLtS4I0+KR8rGjA+mGVs6+1nQYj4ETgpu47DcqksnXzTpW
 E4AYT1al06nIVfQn1rSOSRdwz9nIALs2k9Z1I2t0ooWVqK70So0gyWBxZMAmgLA6yC95
 BGxlQ1YHc2SPtEVXugFtKG4RT6bHmIo//xJx9uISjQ07iwu+8JdVQvQixhkHCEeYCId4
 Fixw==
X-Gm-Message-State: AOJu0Yw3vnuoSMi2CzTZ42bmhK067NNjDY0F/b7uVsWecq4o/Dd2H3gX
 61xeYe7R8bTcTvA1Moy/3wD/7Cp9WRLWtgb0ZxPSqnAMzCLsOYNpPksbFxVtJJIci9ukZyQdRH1
 3T5j6
X-Gm-Gg: AY/fxX78M5sSx/xTwT4T3uPkD8pj9kC+vDTg+yNXkQ2pt03r/l/m4LKg0w3GaW/gMrk
 /5qIsZHZpD4EVgRPrqKCfWh7TxpezvHZWFx7ZrfYTf2VO1aSrKxHr0I6+/pT8Uu6z77hwQvz3RZ
 4D91MYfAuhKnYVpdyRbCXNVVc8AnM16uWQlSJNdoTQhVph0fnGOZSdJsbOo/RK4r2qDXfCk+8X+
 Id4lUArfs7UkU5yyuaKDzuI829a/VVu9PUJAOJwyZa1Jkvit/gz5gNec/v+2tqSisPhZpLv5hLu
 5pKt8ItDmSTunGcwJ5ky4qT7atBaU7qK/Gv4GnJNeHWuX773dlSfPtA4dCXRFMgrBQyVeT9grbo
 39QLrvw6w2EKpKWzGZC7xGNuXMqcyT7yOnGbA2ZYv0IDyHKJ9QCDE2HlqG0ena7CTIwKMjXMslv
 bp/OoT5ssMQXYRfmY4bxaFS4ESoKVefr0Q8/FzUF4OJMG+B3Lceg==
X-Received: by 2002:a17:907:8e96:b0:b87:716:8b15 with SMTP id
 a640c23a62f3a-b8796bc8082mr1050879766b.60.1768874294689; 
 Mon, 19 Jan 2026 17:58:14 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b879516900csm1342225366b.23.2026.01.19.17.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 17:58:14 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v2 5/6] test: add file-prefix for all fast-tests on Linux
Date: Mon, 19 Jan 2026 17:55:08 -0800
Message-ID: <20260120015759.301155-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120015759.301155-1-stephen@networkplumber.org>
References: <0260118201223.323024-1-stephen@networkplumber.org>
 <20260120015759.301155-1-stephen@networkplumber.org>
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

