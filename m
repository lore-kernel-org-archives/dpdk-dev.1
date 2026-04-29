Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4E0FF8867
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 14:46:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6E0B40151;
	Wed, 29 Apr 2026 16:46:38 +0200 (CEST)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by mails.dpdk.org (Postfix) with ESMTP id A576B400EF
 for <dev@dpdk.org>; Wed, 29 Apr 2026 16:46:36 +0200 (CEST)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-12c45281a06so17626605c88.1
 for <dev@dpdk.org>; Wed, 29 Apr 2026 07:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777473995;
 x=1778078795; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O+rQJWS9xv0ywjqIdDx4RZ0s3Yv+o6eUcGHBHmfgSdU=;
 b=BKbEavIuD82a7Ux2vwBWfLF9YKR2QLiKHorWjQBbDF1/3yQcc+6jgOT9gAP7FG8QQb
 fSE2o6C+KqldZ/BnVDA2sxSj0ACEstp4o2ncszYOBROARfNIuw+vRmUX9rXaX7NCYFlp
 4PtiksbYOirZUBIFfJhLn5oslrqBbVmG3UGioAI5Zm8R3BIMuqjYweLeW8ITtM1xlnhR
 fLnM81CuLglSrH3LbhB2gin0OGY2S5niRNkje7fBvZBNsv5Ppiw0lFGnWQQo1clHtIIq
 MLHtJCftF8hSQHu0il8EM46T2DqhzE+k+S9s0jqzshbu33yrYZeLeVQ1kXZNptP/ZG6C
 8u3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777473995; x=1778078795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O+rQJWS9xv0ywjqIdDx4RZ0s3Yv+o6eUcGHBHmfgSdU=;
 b=a52EdFCJu9JW+me0pbFFJNwK/tTc3rzJeK+dCvJBqgXFJH0d2+NdYkcdYUKuFw0wTW
 hKm2jUmxxTuOIinwVPqzF3MiGkwuS/2wnpeACXD6WcuHD+8I60Ytq/hPa483iCRJZa22
 5e94fxems6H6FwnNsFCtnjHg55Qm6e470rQyahzw5v8ZqnJKgPjqKGAiz9QvP9byrufK
 REKIz7BXFrgcS7Xi3RD0Rqju5BBf5cAe3mt71tUx+58eJcPzpiZ0eajEFYV635lOQanx
 PLjXxLtja1fQTILrPHWUYvgpL6PsudXw2tfjtFKnaw9abt2tMOHiJ7qBQuBQMqZ6xHfZ
 Yy/w==
X-Gm-Message-State: AOJu0YxTF/zXgjPV/m2+eGJkABPvmPbPcjn8sXkVbzJLTcBi9H0p4f4C
 iZb+MIm1/r+xwDeJhx9IBUxl5JSImEHOB5wP+qnyMpdrahC4DLBpu639rMPxaW2Glb/7zQUeFNf
 MDotU
X-Gm-Gg: AeBDieulmQAAQhpi/F2pZ2HmJwpKT+fLJW4b4qt7eo5UVtIvLGoitIZVijP5RD9N2/A
 0Xghfhns8MIYsH2byIMLRQrDWbofcDsYKk+j1W+MWMtS3i2s5MYWLU9Lo5OK9Tv0SJLn5lnlEkD
 9Z/JnzB4x02t8/I283c1zHsI5kLCeRbdsD4cf6V7HekytebRIP+5x3qxckaNdkkiFMRfvCk7FlW
 8JRwX8FrgIdbEP4G2s8FvFJsmdLVRPVXIQmsm3VqrfyvNrTjS0rSA9Er0oQ91r5MgeQSx8UO91n
 V99hn4oXvH9UgTYZrCDj4OpUHLd+ooJdOLZWa6cLB1ZhnQBeJ/XWR6u5h2XgcPA9gduS/4TplPp
 hSHndxpp3/E3iK1vRcZtwagnUATf18Mh0rsigkD1SaR1AA/31i0PAP96MOyYjIc7XY0Nsqhqbpa
 DT5mTfWHa/rjn4ZgWmfoZhTk0f+H93RDfMtce3YA/SIx7cSLHIcF1/cA==
X-Received: by 2002:a05:7022:eacd:b0:12c:2cf8:2f30 with SMTP id
 a92af1059eb24-12ddd9614a5mr3642293c88.15.1777473995294; 
 Wed, 29 Apr 2026 07:46:35 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de3269b41sm2631166c88.13.2026.04.29.07.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:46:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/2] test: clean up assertion macros
Date: Wed, 29 Apr 2026 07:42:27 -0700
Message-ID: <20260429144632.164970-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260419164818.20609-1-wpan36@wisc.edu>
References: <20260419164818.20609-1-wpan36@wisc.edu>
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

Two patches addressing Bugzilla 1925, which reported missing
parentheses around macro parameters in the DPDK test assertion
macros.

The TEST_ASSERT_BUFFERS_ARE_EQUAL family in app/test/test.h turned
out to have additional issues beyond missing parens -- multiple
evaluation of arguments, no type checking, and a dropped
__VA_ARGS__ in the _OFFSET wrappers -- so patch 1 moves the
comparison logic into static inline helpers.  The macros are now
thin wrappers around the printf / TEST_TRACE_FAILURE / return
TEST_FAILED boilerplate.  Existing call sites need no changes.

Patch 2 is Weijun Pan's original rte_test.h paren fix carried
through unchanged.

Stephen Hemminger (1):
  test: use inline helpers in buffer comparison macros

Weijun Pan (1):
  test: parenthesize assertion macro parameters

 .mailmap                   |   1 +
 app/test/test.h            | 147 ++++++++++++++++++++++++-------------
 lib/eal/include/rte_test.h |  12 +--
 3 files changed, 102 insertions(+), 58 deletions(-)

-- 
2.53.0

