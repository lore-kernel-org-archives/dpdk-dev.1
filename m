Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70215CCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:49:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E718840662;
	Mon,  3 Nov 2025 17:49:27 +0100 (CET)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id C06E240669
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:49:25 +0100 (CET)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-3407f385dd0so2814770a91.1
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188565;
 x=1762793365; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jXc5+A3pYSazKkUb/5eeFynBnRxVA+qqSR8l3VBejDQ=;
 b=ix5X7dtqCczSp163Ktu90VfJ/P1/Eldf/3OVdxZ3iczf8PVO8ZpJXNKtXQHAiyrrpL
 EVrn/bVMLc5oP1mQA+/jLlg678POZ7ckW06QzNmQ28MRj8BAFObiDQFw7BtIoEMlE4M2
 924w8ZRxZlXATIY/U79uwyuh6sNszfRVJTxszl8A6eYCd0zo0A58L8+Ust8dWr0mA52D
 E2X+Gp1m+gC7UobAJcbDu2GcU+N330ep/vzNmRFxjHl1/XTs6NnTUZd35gQYFMyTX80k
 HKCz4oXFKEx03y9bQowFGt0YLfXY9w2oNPWmTXre9vkGq9xg/5FoQ8+H1TBsK6y3w1iw
 VY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188565; x=1762793365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jXc5+A3pYSazKkUb/5eeFynBnRxVA+qqSR8l3VBejDQ=;
 b=WWvFBvTtQI7vDYpy2hxVMwD7wgRtcOndrIGtzF7B0zXOPnyb1xT0j+nZCDD00VxSqz
 7s23QesDqd0cmGdtCFCCEL7ElDiklQ2V3Kkci/njuMHZwfBuXVWcqZG8jxZJKjoracdt
 QR1RclJegWxRFsiw9f3cvXA7x96NkyCFYZTk2fVg41v2cfc3nE6nCZGZRsJpRPq+kj//
 mdVNCrJtiDJRNe18QurePIeyBSfXrbrqIOcPqkxF+b4miuzOabTbs3VU/LAeyrq0dEVR
 /0FZTr8EDeySKmzKSeEQ9R/KZbiINFFlH/4GhFXFmAdNzBYzQlw+VHUL7Bbi5HUT67Hs
 AS1A==
X-Gm-Message-State: AOJu0YxHoG46QyOPjH8UTTcAYh9gmef5DGNM2SYJ73cfxTx9WlM46y7a
 4sYVA2z3EeCheqwer64dfPFvbeTC67MUV4M+zkZr4lh6BV26B2u0Dzb+51ZcNWyYrDM1pyhiJXa
 kzvE3
X-Gm-Gg: ASbGncs8l0QXQNW14WNnjJQMU+stN2GmQrXw3apSIDmvR66wBv0stn3Oc5OS5bRVEdw
 GZlftVUv9OXy2MeFP0h4uTqcC11i/opAqHB5Vf+dS9UgiP9lXciff+HI62BNGRaCAegXtKbozYA
 4evsuyCRGeXqmuiC9V+sPqXDd+iVzBRbTV2KA8jTyIo66j06wneWC3A7KRMyeVwitVEnPohUuVg
 6y005usIEW2byJXftS2xIsA0ScqhN5PGwqn8YN4DsyUc7UG6bFd/YDZAUfEloE15gWlE1vmwqyO
 dxcLwsQcHBr/mNFW5S3uaOKlyUqykLkgYR0cFnCtUhIhMEUJrdxIcVJNw7go3G1iGEbbXDqqUIu
 cc6z6N+WXaHqUIL7ADdQoSc/TViJQCO2+UHFzDlEnkCuaW7dSoeb8yx7ogg0FS669Y955b3LHq4
 kH2BnodZO20b+UHRJcDe5Qy+jyS0Z/SrIW+XYIdSk=
X-Google-Smtp-Source: AGHT+IE+gix+jywV41HRcUz/AqeDsG2UYQNOklHefM9v+sLgvFZBNSfCCj7zurzRn4IaNRYWp0FSVQ==
X-Received: by 2002:a17:90b:3e50:b0:340:ad5e:cd with SMTP id
 98e67ed59e1d1-340ad5e0162mr13066359a91.5.1762188564755; 
 Mon, 03 Nov 2025 08:49:24 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:49:24 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH v3 04/44] test-pipeline: remove unnecessary use of sys/queue.h
Date: Mon,  3 Nov 2025 08:47:09 -0800
Message-ID: <20251103164915.101713-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103164915.101713-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20251103164915.101713-1-stephen@networkplumber.org>
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

Not used directly here

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pipeline/config.c  | 1 -
 app/test-pipeline/init.c    | 1 -
 app/test-pipeline/main.c    | 1 -
 app/test-pipeline/runtime.c | 1 -
 4 files changed, 4 deletions(-)

diff --git a/app/test-pipeline/config.c b/app/test-pipeline/config.c
index daf838948b..61cf3a195c 100644
--- a/app/test-pipeline/config.c
+++ b/app/test-pipeline/config.c
@@ -8,7 +8,6 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <string.h>
-#include <sys/queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <getopt.h>
diff --git a/app/test-pipeline/init.c b/app/test-pipeline/init.c
index 558f0e428d..2ca32db39d 100644
--- a/app/test-pipeline/init.c
+++ b/app/test-pipeline/init.c
@@ -8,7 +8,6 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <string.h>
-#include <sys/queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <getopt.h>
diff --git a/app/test-pipeline/main.c b/app/test-pipeline/main.c
index 4cc098d7ac..dbc1e0d92d 100644
--- a/app/test-pipeline/main.c
+++ b/app/test-pipeline/main.c
@@ -8,7 +8,6 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <string.h>
-#include <sys/queue.h>
 #include <stdarg.h>
 #include <signal.h>
 #include <errno.h>
diff --git a/app/test-pipeline/runtime.c b/app/test-pipeline/runtime.c
index 752f783370..e1d9f8174e 100644
--- a/app/test-pipeline/runtime.c
+++ b/app/test-pipeline/runtime.c
@@ -8,7 +8,6 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <string.h>
-#include <sys/queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <getopt.h>
-- 
2.51.0

