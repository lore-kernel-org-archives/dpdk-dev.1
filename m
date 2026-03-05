Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A43DF47CA4
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 17:54:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7465D427AD;
	Thu,  5 Mar 2026 18:53:42 +0100 (CET)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id 772094279E
 for <dev@dpdk.org>; Thu,  5 Mar 2026 18:53:40 +0100 (CET)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-8cb3a8494c5so780940685a.2
 for <dev@dpdk.org>; Thu, 05 Mar 2026 09:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772733220;
 x=1773338020; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0wVoHSHSSY4Hepl46iNcs4Wp5J2ylxeuMgRSLGSZt3k=;
 b=lY39iSzGME/tz/n2VrKN+y5Dp8m/jrFCMrCcMPvM6kL73QEUkWx0KI15KFB2h10cjU
 z6gi35ZoAc0/2HO0xcJxpicb+NiQMv5XZlbJ5zHmisGvrX5nxQNGk2PZZTm+ckGOk+8r
 7x/ml4ztsqqAVwoZsY2FAV7KmcpA3J4fU5H1jlRhkPoMsEDuA0eNunYoPiuZetiCoIRh
 mTnI0nPYifJN4VRo2SIIS4zurbPQMt25Rbx8BbiDPbc9C9oMBpbhS6g6PiG9kV3hQZLM
 ab5IJqRh08bOw02N4XQ/x7DHlokC+Q1pHtDbFfCqYusluCjyCEbKugF4ABkKwvwepM7t
 Y0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772733220; x=1773338020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0wVoHSHSSY4Hepl46iNcs4Wp5J2ylxeuMgRSLGSZt3k=;
 b=eXoo34fB3GAMo6lCt5FNg8Mg/s54QHgbUC2fZlgGRERE/ORjIuzQ6ZzfCFkQXlqmom
 xBORzl9KfAaHMBrTfXyov5nBxtlvGfTmy0YUVmNqmsBaVfO0vUnuNTkNPWWPnD6V4+c8
 0xFuUODSW63BscWWNecLP4VaNsDrEfoQwk3dlelBGQxDDbP+NFuGd9a7SNbLqoxwvbQV
 JY7l6o8+rZrLoiYo4E1HMhUplSi2wg/rUJr099IxhnMaiKdyFTH1NQbYKLDJiAD1qMu1
 MWAXkof1WrRLE0P+oEXa+ijk3Db/FTtTHVhgs/NSWy1dXb0fl0MePPsqceDXcXWUaPcY
 +jmg==
X-Gm-Message-State: AOJu0YyHsA77xDQV4SrD2+0/OekAXzu4Vf7EpANRpMzXiS+NIKD88L9m
 mu2eeiIChUqZH3eejC/9vv+7phkyC3wbKufwWPJqiFzsTvu5kBCbSZRb3i87FMS2igyxwBv5QWL
 I6KKQ
X-Gm-Gg: ATEYQzyESyN0eHAtMSNcdqFPHiIV8qDw9Jz6sQiYxocshcH3iRvdAL01uhFJB7hfnc9
 PSsRCt0eyB85H8xMfD/YNWHjTM5Czbre5bPoFepghltm3ivkRME0Sruj6QtXhJwVtrYxRjZIXIO
 aEerM0OKRJ0c2mJhxhMMql1Ttv2WNrsziyHkkOGjsm+FO5MjIHRQ9sNTDuzwuA0hvmc/PwZv0oH
 25aURVH45mSmaTTP0iudY9fFjDG9h2htoX4cJ4f7mBlylI0o1kJo+CRF3owVc9mwWBstXdNGWlw
 0OHqfA3qzsH9R3qTnN5hJyvABrVZOKdjwjGhKnEwHVGtZLUzW5ZgTgnRRKqYuFAFOBk9v6q+Ffh
 HkB/hv8gYDZBJ4aCntQJh2Zww8l5GM+GJ3XwIbubBVmCr3hbvxJLYzCkTHd6gZ3lcVeqQz0v66w
 wXxr20fAsJxdu6H3yD9e9k+Lx3YbpyOp5xdDntU7N+wG5imd8LTxuEmd5qTAJ/7Hu8U0gOpUhO
X-Received: by 2002:a05:620a:4152:b0:8b2:7558:406d with SMTP id
 af79cd13be357-8cd6b01625emr93939485a.61.1772733219832; 
 Thu, 05 Mar 2026 09:53:39 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a05b72186sm80667766d6.50.2026.03.05.09.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 09:53:39 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v4 08/11] test: fix trace_autotest_with_traces parallel
 execution
Date: Thu,  5 Mar 2026 09:51:02 -0800
Message-ID: <20260305175326.279891-9-stephen@networkplumber.org>
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

