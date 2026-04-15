Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E96AF43830
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Apr 2026 14:50:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E53E640DC9;
	Wed, 15 Apr 2026 16:48:33 +0200 (CEST)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 by mails.dpdk.org (Postfix) with ESMTP id 11F6C40DCE
 for <dev@dpdk.org>; Wed, 15 Apr 2026 16:48:32 +0200 (CEST)
Received: by mail-oi1-f180.google.com with SMTP id
 5614622812f47-4704fb0d5b8so4428548b6e.0
 for <dev@dpdk.org>; Wed, 15 Apr 2026 07:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776264511;
 x=1776869311; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=POHID0iEyMqBKV+1Qk7zLUcIwsZb75DmvqClv7Tf2jI=;
 b=bz2nj5vkvmVlfC5vizbUq+B3sX1EL6lUpNTuX6a08dlSGso0rtiO3a+XqGOQ/rlFYw
 0kI7qZExqMxrTtTEAIjn2dQk9GgyuEywWWtMcYqGJA5UTt7KTQmq86Iv9dd5VIch5wie
 sWfmhe9KRy8VyJw8VmgXy8FYl9KxH2+w9s2PisjFhiLcHTHU+Ha8WAW3FgyX2+5I1gOG
 QAT0xzzZWLpLwmCje9X/kFBk+LwbCB8nt9PZvE6J1s8qCWFw+Tb1y1rwDWtDO9PQu7Jx
 Xs0XwdqGSESKRiDb6Q2xjsh6oqyb+S/aXUbOET2rtC31BfgFztOWZPjyC4bZRo6wAS2D
 uWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776264511; x=1776869311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=POHID0iEyMqBKV+1Qk7zLUcIwsZb75DmvqClv7Tf2jI=;
 b=qnere69S86kORUcU9+rdKrODydBuM6wrYjWolqITGYdn4Affk0NOh5m+IbwvkRBARG
 hPCGxqm3gqX5rtWBZOmg1FzPH4FRKnaMw+uIm3UzBo5P39hVgmEFG60Olj/ny2PEZiqE
 1semLH+Vk4YVAVzS1bfo5CNwrYJP5JOSWK/MLDM9DSGpaRTGn5cJTTSJmmKRD6Kd34U4
 fBSXFMlRKplf1T8Nl2M9HNiWi5bD8jPHXinsfBJvWNVvH4L6km9Ln9GPjQMqQLKfRcvN
 1Y9ashWKkyXGOFWYGGVG+BaFuXCyMYR/q3tWt4JJlWJxSBe2NSSQkm495si1rWbo7krM
 2BFg==
X-Gm-Message-State: AOJu0YyVvTpR9M5ztZNJSNE6/D1yp1ybsdgcpD/5FlweiSL2vPWRlgQ7
 59TwKWMw3NPR5wwlVJ95Ama96w4vtDVdaDBEK9mmf1EZNz1ELAGBjCZnshl83X4OahFkpkqdr+Y
 8bvs+
X-Gm-Gg: AeBDiesgqPdcA476z9stchjyVCdQsqeIL6jcguFqCgG/qn7y7RVHCi4tRgi2U3rLFIr
 2LCs35qXPYW6DUvhn7/woWq9nB6BD7bo17zo5SbdGrsTGHrbBdvfv/9T48hU2ypPsilxPGoS3Bm
 et/+9mrOs5dcSBxCWqBKwRWARBL/+UbHcrkcujZvA2Y/789pg5hrJMwlZdH+BZb6/4F0zmIPIb3
 5YBeLW3U+KEfCPDh88wMEvsMKZawig3pjOU1C+8Qy8EWR9mOOSSqzNiQ6K2EVfcNtZaNQMmtmH9
 Q/NTLjgq9V33O28h9uY1jbOctxeY3i+wDVHaQT4f+IML1XgmLI2fQuy30bWTLCjeH6olwgZuBmz
 zsy4vl5lNrmQq+2N83nOjypUMCX8UsYzIrw52J0F7RZATbyS5PpTnuxrYnPMCdabnsnYfUymIoX
 Qj9eKd1w4/ONp2rigrpiOUFW2lejD1muIzb6rrOMqwedI=
X-Received: by 2002:a05:6808:5093:b0:467:e1a8:2b92 with SMTP id
 5614622812f47-478b6ea21c3mr9942817b6e.10.1776264511314; 
 Wed, 15 Apr 2026 07:48:31 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4797a53b1fesm945798b6e.16.2026.04.15.07.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 07:48:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v23 19/24] eal/windows: add wrapper for access function
Date: Wed, 15 Apr 2026 07:46:08 -0700
Message-ID: <20260415144717.226161-20-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415144717.226161-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260415144717.226161-1-stephen@networkplumber.org>
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

Like other Posix functions in unistd.h add wrapper
using the Windows equivalent.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/windows/include/rte_os_shim.h | 1 +
 lib/eal/windows/include/unistd.h      | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/lib/eal/windows/include/rte_os_shim.h b/lib/eal/windows/include/rte_os_shim.h
index f16b2230c8..44664a5062 100644
--- a/lib/eal/windows/include/rte_os_shim.h
+++ b/lib/eal/windows/include/rte_os_shim.h
@@ -33,6 +33,7 @@
 #define unlink(path) _unlink(path)
 #define fileno(f) _fileno(f)
 #define isatty(fd) _isatty(fd)
+#define access(path, mode) _access(path, mode)
 
 #define IPVERSION	4
 
diff --git a/lib/eal/windows/include/unistd.h b/lib/eal/windows/include/unistd.h
index 78150c6480..f95888f4e1 100644
--- a/lib/eal/windows/include/unistd.h
+++ b/lib/eal/windows/include/unistd.h
@@ -23,4 +23,11 @@
 #define STDERR_FILENO _fileno(stderr)
 #endif
 
+/* Mode values for the _access() function.  */
+#ifndef F_OK
+#define	F_OK		0	/* test for existence of file */
+#define	W_OK		0x02	/* test for write permission */
+#define	R_OK		0x04	/* test for read permission */
+#endif
+
 #endif /* _UNISTD_H_ */
-- 
2.53.0

