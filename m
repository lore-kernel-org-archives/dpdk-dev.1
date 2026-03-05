Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE822F47CA3
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 17:54:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6470F427A1;
	Thu,  5 Mar 2026 18:53:41 +0100 (CET)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48]) by mails.dpdk.org (Postfix) with ESMTP id 4D4D442793
 for <dev@dpdk.org>; Thu,  5 Mar 2026 18:53:39 +0100 (CET)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-899fb030812so65881126d6.2
 for <dev@dpdk.org>; Thu, 05 Mar 2026 09:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772733218;
 x=1773338018; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iIOpaz/iCa4IaXtKDU80VNBjuXH3LNZl+92g1EdD/HA=;
 b=ZuJVzM2v9GBF6P3bHbZ1NAOZfBX/CHYF8jb7aixXGcM/J+yqaQiJwUkyN4EaIzHptx
 Uteoa+JeKbXQgCs7bCiS8/K2Dr+p/lzIgT9IoRsTlLsuCWPcfci+VZm7VUxm+ezRuAlp
 LV6Xd4n7/Hu8dAHqpJ9HZdCSLPU7hfo3/Cuebs+9fWurnjVnIgWJZLKz5aha2b8Oz7AH
 5Xe8H+sJdhLBzpSaEhGlzbmIOqlh+3HsfxoGNTquivQGRqviRoaxqicI/FLxtrdjPp9e
 1fZpCx41rcG+er9GdEk/YR5mwtmGjwU4VQpx56V5w1K8BmdtYNvvOQU30Qc2YWFmVk6j
 JYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772733218; x=1773338018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iIOpaz/iCa4IaXtKDU80VNBjuXH3LNZl+92g1EdD/HA=;
 b=CqN2jBlEriYLyp8tHPCBMAf0vvuobGbJ5WluFvR3Au8cC/+T1IJYNX3tHCLZiuRzRZ
 EfMc87DSxVpTOwqXsZERKFpf51rN4fyOrirMSIszx3btGPDOHIcrGjdvy7Eey093Fp1a
 v1H3myMAbqhvbiuaQLKROHSB/8qjwlZjIHBL3BTxlrRU7cZ/QXZni3rbvcaMMnmyanhf
 6A4tEESQ+DqQ49gPzXuNbTedPf6mA7rSd0O7rFn3ndR9FFMbUk2l1jnFb/Hxwaz9uV8n
 UCvsudFzVx1wkyjV089kFjTjjyO9l31PIj9Xw2zAfmVksTYMFmd2tnOPFhDkSjmhP0WB
 GCtg==
X-Gm-Message-State: AOJu0YxCr/bh6CapcPYmxhGV0k7UtJ9M5daYeb6LFh9lPzirnyd53dEs
 902H6HOn021tBaaQ5FMFMN1+xkrV+l5TxBNQ9SuSyzd3MU7Zt9hTBK1Gulbm55OmvD4Z5Lxk1+9
 WAT5u
X-Gm-Gg: ATEYQzwZm2ICooVDHffihnYsVkgf+kqZXhz5q8Xzt2wfz2fqf8uSOvoVFQEVCIjvR6O
 kJeeCyOmUAUambfIUY9ZM+JcvN7IP+r/e8tVtbPYeAdCysLLnENnJkqSMmGB4Ewziv+Vl7bdtvE
 O22o0YXdSqbfblsD6EHijSaxHVZna1j/w0UT4reZZETe8r3tO2x9/NRpmXEKRjsy7Bwkhsx0IrN
 icSPoBy4ZZy0WIcCzjk+AeGKOOr3MQtfSapz7YO4Jb5K7GXprjxvN5hHC7I4/6TMVB1ZwWwr76f
 qc3OPwTK6DrkqzOPzq7gD3KeP8YGpxOke543rc6GagI4PipL38iIp8Em8oe0C6lSTz1qTDZyf2X
 N5yphYAltwYL0v5LnEW/lNllzqrnyhWwVQX2PIgJRqJ1gyOyg2SJIw9PVWsZgyqltAgDr661gxt
 72qYx8NwZDbgnnB/keAWCetD3dxGQIM0iMmH2mMWr2UbUpFrcgapzq5StXcctPfw==
X-Received: by 2002:a05:6214:508d:b0:89a:90e:3a1b with SMTP id
 6a1803df08f44-89a2df71999mr12176126d6.25.1772733218554; 
 Thu, 05 Mar 2026 09:53:38 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a05b72186sm80667766d6.50.2026.03.05.09.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 09:53:38 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Marat Khalili <marat.khalili@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 07/11] test: add file-prefix for all fast-tests on Linux
Date: Thu,  5 Mar 2026 09:51:01 -0800
Message-ID: <20260305175326.279891-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260305175326.279891-1-stephen@networkplumber.org>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260305175326.279891-1-stephen@networkplumber.org>
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

