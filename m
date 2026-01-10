Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB20D277C9
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Jan 2026 01:57:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5112840DF5;
	Sat, 10 Jan 2026 02:57:15 +0100 (CET)
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 by mails.dpdk.org (Postfix) with ESMTP id 3128B40DD5
 for <dev@dpdk.org>; Sat, 10 Jan 2026 02:57:14 +0100 (CET)
Received: by mail-qk1-f194.google.com with SMTP id
 af79cd13be357-8bb6a27d390so309305785a.3
 for <dev@dpdk.org>; Fri, 09 Jan 2026 17:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768010233; x=1768615033; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w4NpdyQNSvZKZjFuJi1Eq0jlxRyJmPAxXTvahxUxZSY=;
 b=baYVkeqmU7PTr0RBPw7trvvNtd7+UK32CVd9EzfZTosUC8x7rY0CR4Aref8QH4ySQC
 Yjd8erR0I9t//Qv2mhRIMcSFg2cIMrmKXUVyu9cGc9gydU/Vy9czp7/LwGKdExylegwO
 im8Rm7bhQPXho0VAyffJI84Ix8F08OZfjXpFXk0lzXzuty2hEYYV2pIhI8+ycwUN8xM9
 RNxqvwq+kONgLzl4Nzigpf3uDopS6RUbYyf+5J42Mxo088V5XSU5L1vHMdrEjbA9uDQj
 9edanH2po/Bwjn6Red8TdhHGfyYnWmtZN3Iu+m0dIG6lEM+nErIMtcwmVyaHrag7wTio
 os9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768010233; x=1768615033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w4NpdyQNSvZKZjFuJi1Eq0jlxRyJmPAxXTvahxUxZSY=;
 b=JrpzDW0Om72UjwVlzjmEqg4qm5otkH2V5emLej4AN2eKDPL86QtfTS9l+odqT021Bb
 wlTTsVYWvqRufpCxRGHkQAGchrRW5Ec5sfxpZ8oELokXc0oxdoEqUFDvicuXXkG+Fog6
 xschcElYdr6UnKK2KARsN75sYocxGChu5gt9EZIC/wmTAXem/64TssnCp0yH3xaXzLzh
 jH6qCFqsByiz+v36jmxjYwAGYEsRGkblgHKnK8osyC524vUaCyqve+73fGMpacWm7yX3
 NB+jCCJzdBEbHZQdHMs1IXXlEPPPeKbNQ0+UsgG6yk5IreUCEmLo9DqkbhkViRTEco0Z
 5gag==
X-Gm-Message-State: AOJu0YyiGK+al5EvS1UHPR8bVsj5ZdRQXRsa7GEJZpVUYsBKqbgq0p6o
 4AMQVsLt7tOgMvzMT/zrI370ejdTxEe/NgpeEm5Fi3YJAQ+7+9M80uLUBimPPsiD
X-Gm-Gg: AY/fxX4Rt6INRMukWqtW+bCLfTPmsGWDhv2tSoINpuqSdDr3aqBsHe8EIctVhB1ftUi
 WQksJ0ZNQl/2iU0QZVcBlbmnZqnm4Ip5gk7832BjmLyQdEltXwp8d+DwuUIJDwPfJTFGdOBcocn
 cMlRUU2COaccjNDri8KhL+vAkyU8h+jzVpKyGjbjWz7LoxVKJvnTfzm7hJrBFFTCUZgdVaKucM+
 4wJ/Dm2EwpGXWBYQL5hs5p2FeP5L6EhK66kKstosHlf8l7CG6LDTs3gCBsLiKmaD44X9QAVHP+T
 bug6MuLBgdRMFuLrXCJtvqiWpL3De0ohAsshNXUQbfLFy++eDIvWJNYn2P+aST0IsW7p+lCnL9o
 /rjflHc8ZqSO+3AKdxj86OcNdH0tCdSk7V0bjbtVDxyFKEcj+5wehmZZWU561bScHW6cxw3pcYl
 0S28WBij353J/dZH/ZPHt2Eqbg4BZsIcD/mEl0A7GPVq/RGnLPSLlGYgFhPQ==
X-Google-Smtp-Source: AGHT+IHHIs+nho3JD3x4gI/+EtVSYBaz1xlolsY3j3SusRTFpoMBCst+q45MI7PY6NhVDx2qyWwFug==
X-Received: by 2002:a05:620a:4410:b0:8b2:e179:febd with SMTP id
 af79cd13be357-8c389354cf0mr1486884485a.10.1768010233312; 
 Fri, 09 Jan 2026 17:57:13 -0800 (PST)
Received: from st57p01nt-relayp01.apple.com
 ([2601:182:b80:6a50:314a:3f86:1924:bd42])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c37f4a6145sm939379385a.5.2026.01.09.17.57.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 17:57:13 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 Scott <scott_mitchell@apple.com>, Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v12 2/3] eal: add workaround for UBSAN alignment false positive
Date: Fri,  9 Jan 2026 20:56:50 -0500
Message-Id: <20260110015651.26201-3-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260110015651.26201-1-scott.k.mitch1@gmail.com>
References: <20260110015651.26201-1-scott.k.mitch1@gmail.com>
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

From: Scott <scott_mitchell@apple.com>

The optimized __rte_raw_cksum() uses unaligned_uint16_t pointer access
which triggers UBSAN alignment warnings even though the access is safe
due to the unaligned type definition.

Add __rte_no_ubsan_alignment attribute to suppress these false positive
warnings while preserving other UBSAN checks.

Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
---
 lib/eal/include/rte_common.h | 9 +++++++++
 lib/net/rte_cksum.h          | 1 +
 2 files changed, 10 insertions(+)

diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 9e7d84f929..00d428e295 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -546,6 +546,15 @@ static void __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
 #define __rte_no_asan
 #endif
 
+/**
+ * Disable UndefinedBehaviorSanitizer alignment check on some code
+ */
+#if defined(RTE_CC_CLANG) || defined(RTE_CC_GCC)
+#define __rte_no_ubsan_alignment __attribute__((no_sanitize("alignment")))
+#else
+#define __rte_no_ubsan_alignment
+#endif
+
 /*********** Macros for pointer arithmetic ********/
 
 /**
diff --git a/lib/net/rte_cksum.h b/lib/net/rte_cksum.h
index 8dbe1179e8..9a7fda563d 100644
--- a/lib/net/rte_cksum.h
+++ b/lib/net/rte_cksum.h
@@ -39,6 +39,7 @@ extern "C" {
  * @return
  *   sum += Sum of all words in the buffer.
  */
+__rte_no_ubsan_alignment
 static inline uint32_t
 __rte_raw_cksum(const void *buf, size_t len, uint32_t sum)
 {
-- 
2.39.5 (Apple Git-154)

