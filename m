Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6C5F8D766
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:53:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B9A040E32;
	Thu, 16 Apr 2026 20:52:12 +0200 (CEST)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id C31F3406B6
 for <dev@dpdk.org>; Thu, 16 Apr 2026 20:52:07 +0200 (CEST)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-1274204434bso750726c88.1
 for <dev@dpdk.org>; Thu, 16 Apr 2026 11:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776365527;
 x=1776970327; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=POHID0iEyMqBKV+1Qk7zLUcIwsZb75DmvqClv7Tf2jI=;
 b=nEazXvMDjbyQCyH3q+UeTl8woTS6e/JRuPrLwpqq+J/J49PY2gm+vvW7WAL3+JcgU4
 CgBrxlYnDV3vIJoZDkgd3g9TVxRfsR4bKG1xifCSPsX8UbWVCL61DteJdPEKGda7OpWj
 iCZDrwUYtsaqXSrMcA4uw7E16IB7Uuf+tcvOeJjkqBvG3boQmRvJymRfjSAqsKymlTBc
 s+yAK5CLQKUNJNOSCOE7xwsF8EMdHzwqqD9B73Tywrb1qoDht5BS3kF/cwRXqJRGmNWG
 L9kOzU8yuRm2b4BGJpQmQ2tLXrRxkyVPP+7BLOwSy9lqHsseBJj+12+GbVBkC3H6WXnt
 wodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365527; x=1776970327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=POHID0iEyMqBKV+1Qk7zLUcIwsZb75DmvqClv7Tf2jI=;
 b=B2GibpJYrWk1tuSbE6tAkWbXShOqdm7RozIM62YJPBrJdnuKmYpnYzGUubM+2XS24A
 3QLcGuBYBMnmX6npVU72RPHndlUnE7Juhc87if+d38SOzFyskBGa1FMoZbJIutzx5nO1
 g83R/FpMTbegUeKyadY2Ayax1+OJ08mp8LbebJ5PE/kJJbXfadx3WCJiuWgtO6ROG+NT
 6+3wcQD6AEeB2JU4zDBtavof+b5MoO+HxQkzYfr7QFZiMcrvjPfE/4YpKE2Sqg4cQ2Nj
 1MLaI7GrwrP0ccdnXn4+vF+v4PMC1RvZhUemW2sXM9HpIPffYEpkccQQAab7VKSGgCMW
 YYSg==
X-Gm-Message-State: AOJu0Yy6kkQFLt3dTD3ECGgyItW11Eg8YJ2FdUgkHqxz3uwW7N3RyhRh
 cnSiaH8zZ0GA1jv36VBHWu6AE6PSjuzbz/1d1hF6FvovEmYbsRXkKXto1cyKZVcnrV4bL6DWD3m
 DifFK
X-Gm-Gg: AeBDievA3ewDY66t0Kn/Cdtt3UampMtG4qz3EaC2ILMRXW0OPwV2+eABeAGpjwQVPfG
 Xun9HB47qwikl+BJIOifNe6FAxG9aR660pAv3bmSs+F75BAoPXWSryywCgJe5VVKjjorqUchuBA
 itcFO9M58jjgp3vFYDbrUL8PCFtBSpRx0v/5t5yz/92sU2a5x+XJqh20fMM61slVt4O8Y00TwJa
 oWDq2FkQvl1/WmuGbfORiDO8jt7+59Y7tZljOfmIKjPUNMWA8MZ9UKdTrLEeDZ2AFylgxDa+kic
 xgjCf57hThJCuHwrX1KeFNd0A6wbEv2R0pPVPygqxDQLz6BdwLgCOSYNa4wvkvsIyJRvxLKPquP
 ui10GdrPlfdd9Ic+tBQhJuwSKWgeu/pljVoGqmRtWmyzWSU3407PqJgjretBK0LL8CZIj+ztDkX
 bl1KJOR9iVrJCWq+a4i0QivbkSvYyMcFkEVg6WzGEVT1Q=
X-Received: by 2002:a05:7301:1288:b0:2c1:82c2:bc31 with SMTP id
 5a478bee46e88-2e2e43591d6mr182027eec.10.1776365526861; 
 Thu, 16 Apr 2026 11:52:06 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8f6615d5sm10602510eec.24.2026.04.16.11.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:52:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v24 19/24] eal/windows: add wrapper for access function
Date: Thu, 16 Apr 2026 11:48:36 -0700
Message-ID: <20260416185144.1359260-20-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416185144.1359260-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260416185144.1359260-1-stephen@networkplumber.org>
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

