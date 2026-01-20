Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96420D2ECFE
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 01:58:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8767D406FF;
	Tue, 20 Jan 2026 02:58:19 +0100 (CET)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43]) by mails.dpdk.org (Postfix) with ESMTP id D1D3740A79
 for <dev@dpdk.org>; Tue, 20 Jan 2026 02:58:16 +0100 (CET)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-b7cf4a975d2so856850966b.2
 for <dev@dpdk.org>; Mon, 19 Jan 2026 17:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768874296;
 x=1769479096; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bFarVFCJtpVCqNhUp4fI9ST6+8eVDFU9hQjDX9WPSVM=;
 b=SWbJ7TZPX9ziyyUAR8Yf1YKliFVFaFX/5QBCd7lL8/+9NvP9Nfqts3wSDMGZc/tovi
 6Jpz6TRdTZ1jA7LHDQWNMIThTNDmYVUC2oBteqpyudjwlDxDLMyIhR+Jd7KFYXoMOAw1
 nrU8+/3qpKm9enr4pcg1YrZd5v3HxezP0RjeQGLZETDNdS1s0FdhVkcsLG3QXP+MmMgR
 r4eKBk0lf3MmpOah4MLJNon94OTueNvX1+1CYaw2ITnD4YyLX9IZ82JNIXgZ33QWe3Rx
 ryEN+Q75GrABfeu8eYlCUtRn6MGrK0gr3vjEW9C7Lttq6h/wPuZoIKNsjZp6UXm1Qyu+
 dMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768874296; x=1769479096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bFarVFCJtpVCqNhUp4fI9ST6+8eVDFU9hQjDX9WPSVM=;
 b=fTyW9yyb7DZCxsBk7MrZ7/V2wgiuRB8Dv12facoFJH00ChQRxyHC4rYcUCydyMxic6
 mAEHh84K5b99B/Y5UtohxS79Wy6j2dgoYxn+Q449qZlDzGDKEYYu5r+G6yyQNx2eSlgv
 f3J1eMzGuusrxhQXntaMxxgyYiD9LqovXLZVDwiC3NFOXrzbBVuOC3rHzJQCJyJNQlUB
 R7g6vDXvv0Zga0p2XjH6VP4cARKA32SjBuekDnB1vm2mM5NamOTaSA7rCDJoagLbk1BN
 hRCf5h5jgk2/HjNYJjc0dPJRthIrG/KNxGTqLNH1BE0ojc0+/uoumYFMlByNZ1PbGgkZ
 ewJg==
X-Gm-Message-State: AOJu0YzXDhTwmi0QlhScIGG3hm7OuwIEF6hQrWa8tvzOsNbEUwTothqQ
 MbW8CgQOkYMX6bjH1CtkohbdrTvotw2KY1jF/4N2SV5AfoZU8VcGpPdVjCYWOI87xNTmxrTPWVG
 x15gs
X-Gm-Gg: AY/fxX4ad3mU7yL1OxyjocN3yeLHHFKw+0GDyv9glCAliyVRL48JBy2N0t6/1gTLqom
 vwx7Fqnyyh8l5CbOWEaNTSBf2dOuF9+05suU71FPiWb40iM6N8RPiT9rf3MvrRapxkjZxr0TYCN
 t2j+pRKndsdHVvG7hQjc6GqC4zx9iMQDvNVqu9qziWPwJC8DvFDhsdBnfucDB2HW/O2mpLkNVho
 K6gLGtpGHE5CvN0U1Yc7ENflyPHGE1u89FOFqAOHefeFta+3X44GLuYDgn8YKAM1V8P6kYFqVN1
 lbpbbIY2Zhleta8Ln7c5wizc+Vpmvy6drViEyCxy2rDiCz27CNP+cEUAFPndGdfBguT3yTrXmOr
 g2SSBaCoRNNcf0dT+j7cKo7kaKp8iRmk9f55Y58BkhslAZB64QdX3uxXnflHN1VSwEaG+54kx7f
 ps5DLrJ0GsnjgNR3HdiUL5z/2X/sf1/WCXPWBWu3TMfOCuHpZ+kA==
X-Received: by 2002:a17:907:d23:b0:b76:d734:d459 with SMTP id
 a640c23a62f3a-b8800392265mr22897166b.57.1768874296277; 
 Mon, 19 Jan 2026 17:58:16 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b879516900csm1342225366b.23.2026.01.19.17.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 17:58:15 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v2 6/6] test: fix trace_autotest_with_traces parallel execution
Date: Mon, 19 Jan 2026 17:55:09 -0800
Message-ID: <20260120015759.301155-7-stephen@networkplumber.org>
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
 app/test/suites/meson.build | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/app/test/suites/meson.build b/app/test/suites/meson.build
index 4c815ea097..fdc0b77149 100644
--- a/app/test/suites/meson.build
+++ b/app/test/suites/meson.build
@@ -90,26 +90,33 @@ foreach suite:test_suites
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
+            if is_linux
+                file_prefix = ['--file-prefix=' + test_name.underscorify()]
+            else
+                file_prefix = []
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
+                if is_linux
+                    trace_prefix = ['--file-prefix=trace_autotest_with_traces']
+                else
+                    trace_prefix = []
+                endif
                 test(test_name + '_with_traces', dpdk_test,
-                    args : test_args,
+                    args : test_args + trace_extra + trace_prefix,
                     env: ['DPDK_TEST=' + test_name],
                     timeout : timeout_seconds_fast,
                     is_parallel : false,
-- 
2.51.0

