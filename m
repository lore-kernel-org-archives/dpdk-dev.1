Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97F7CA6004
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 21:41:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E4A7427BD;
	Wed,  7 Oct 2026 23:41:24 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 242F2411F3
 for <dev@dpdk.org>; Wed,  7 Oct 2026 23:41:21 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2dd76b1361dso29638885ad.1
 for <dev@dpdk.org>; Wed, 07 Oct 2026 14:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791409280;
 x=1792014080; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=znuZL4YIKcCQ+OzmZXTskLfADE42Ekm0PWs66Gm9EkU=;
 b=UZikmm/IzLxWC2/9+Uwcx4IKPDjshAaU98aVuK84GZi2cCBbK4/XjVGrjuLWdYToIG
 mNkmkJb+ikpM+6kIr4qvB6A/KyGC5fMmesMdfdGXh73Fal1fTpwJU6ydxhUQylniVUH+
 Y59aKPqsA68InE8mkl6LkaO6Di/tCzPVQnY2TI7ShZ8lN8SD9luqUNsdeYkxo+EDiX35
 iRM5TT09+ZtpV/sc/8O00EheIuGaWQIVzmxdBaFRjptOjkbE7Q4Rt+y8h1r8iP3OmK2s
 oyl84ZrXLqwTyxgKym0/cAo30ARUNAV16L+3I7JnuaQkYWLiSHD3HHmDxc2CgDoi8nho
 7jFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791409280; x=1792014080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=znuZL4YIKcCQ+OzmZXTskLfADE42Ekm0PWs66Gm9EkU=;
 b=mqnC6LGpo6X+NnjyKN/jO9Qs9PQBMuyLdCBl2FeOMa5TBdG3/J0BcT2ob24ks0hwkk
 81wJkTzNR9aqKQwSkxIF2gMClhA6PEf2eQmm5u0nUQWSrsF05m79jOHRRwxnCwcmNYd9
 V/PikJirtifQNlL1COZmbUikQZ/fpcFsHc8jiwPqPuZJ2FFGDTYUzPnake9uCNLtJ2lM
 b5oMI1+Kf8g++bTfkthAEwawB+TWfsUGf2AR+PrjkwJrvijYdBZ4XkPjTtFw8kzOMts5
 DTSvyz/DXNYvkKazjGe1qN69OwNrCnPsmgcTURqmYPXr3puwUIMM3fU+/LZdrjanGKrw
 Hp3Q==
X-Gm-Message-State: AFq9FYL1d7u6/17MFeWLQT1D05+Tp00LSTx5IdcE2SyBZVOM6s25IkSP
 +hBbJKcmrSqbQFpdxzAw+cw7pCA1K0gflqfeS47773m5c8/O5C7H5uAW5aZCLaJzupTRCst8zPD
 uKAZrHMw=
X-Gm-Gg: AYBFou0uMjxIT0OM0sfAu17S3P3vVBMz1q7NMsqBfkNbwZuI6vK1TlXBtFUcsGFJeBT
 w7+fMSrM4lZSKmrdq/qtz12oea4nCVxIUUnWt+AnZAbvVVF9a1C+pdWqUamAjkCZR1GxcmC/iD9
 5CGNchuAma/CHL7IJ2kIf77FmUUJR153f0n8lSZ4dQ8ahbHPdEXzj1IouZzZ9HJG00rmSstghND
 NFsM2OXFDdQVLc3x8o3TFQFwxnt3zHufmC3P/Ap/1EPnBsAfXLHsEB7LT08XlstgiIAm1ghSbhD
 xoBBEZosbM95VXE4SS2lfYEF2CF/EX29Exw3U90Zf7zyQlz2Q9W3UYlkLc5pqn7npYr6MeMm/Vp
 IlkrlnS7tbx8vDDSLWnUyOyvOFNcpg+CmLARfQ2/zVfZ9uou/4ie6pALtdZ8OEGP32fG8RRQIbg
 uhqRCDoprWBzHfkOupv9GslPa42WiUGSTRRufLeaN4kK/RGiT/bER5lqYqJ4VBaXIjkXtoPpfqi
 aEooSixYGYlp+i+U+3qt3H33TpGupEZPI+Mcw==
X-Received: by 2002:a17:90b:4f43:b0:3a7:250:3342 with SMTP id
 98e67ed59e1d1-3a8a1d00378mr3091157a91.43.1791409280218; 
 Wed, 07 Oct 2026 14:41:20 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e60484ca89sm16573335ad.57.2026.10.07.14.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 14:41:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH 02/20] eal: promote rte_basename to stable
Date: Wed,  7 Oct 2026 14:39:32 -0700
Message-ID: <20261007214115.3092715-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007214115.3092715-1-stephen@networkplumber.org>
References: <20261007214115.3092715-1-stephen@networkplumber.org>
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

rte_basename() was added in 25.11 as a portable replacement for
basename(), whose behaviour differs between the POSIX and GNU versions.
The prototype has not changed.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/include/rte_string_fns.h | 4 ----
 lib/eal/unix/rte_basename.c      | 2 +-
 lib/eal/windows/rte_basename.c   | 2 +-
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/lib/eal/include/rte_string_fns.h b/lib/eal/include/rte_string_fns.h
index b3b5bdf275..f7cfbf00b6 100644
--- a/lib/eal/include/rte_string_fns.h
+++ b/lib/eal/include/rte_string_fns.h
@@ -140,9 +140,6 @@ rte_str_skip_leading_spaces(const char *src)
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Provides the final component of a path, similar to POSIX basename function.
  *
  * This API provides the similar behaviour on all platforms, Linux, BSD, Windows,
@@ -167,7 +164,6 @@ rte_str_skip_leading_spaces(const char *src)
  *   If the return value is >= buflen, truncation occurred.
  *   Return (size_t)-1 on error (Windows only)
  */
-__rte_experimental
 size_t
 rte_basename(const char *path, char *buf, size_t buflen);
 
diff --git a/lib/eal/unix/rte_basename.c b/lib/eal/unix/rte_basename.c
index a72d6bb3c9..f70c30b0f8 100644
--- a/lib/eal/unix/rte_basename.c
+++ b/lib/eal/unix/rte_basename.c
@@ -10,7 +10,7 @@
 #include <eal_export.h>
 #include <rte_string_fns.h>
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_basename, 25.11)
+RTE_EXPORT_SYMBOL(rte_basename)
 size_t
 rte_basename(const char *path, char *buf, size_t buflen)
 {
diff --git a/lib/eal/windows/rte_basename.c b/lib/eal/windows/rte_basename.c
index ede913e6c1..2c8cc9dc9d 100644
--- a/lib/eal/windows/rte_basename.c
+++ b/lib/eal/windows/rte_basename.c
@@ -7,7 +7,7 @@
 #include <eal_export.h>
 #include <rte_string_fns.h>
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_basename, 25.11)
+RTE_EXPORT_SYMBOL(rte_basename)
 size_t
 rte_basename(const char *path, char *buf, size_t buflen)
 {
-- 
2.53.0

