Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B6B103A99F
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 02:42:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F37140EDD;
	Wed, 25 Mar 2026 03:40:48 +0100 (CET)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id 035D540E68
 for <dev@dpdk.org>; Wed, 25 Mar 2026 03:40:45 +0100 (CET)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2c160308a54so871708eec.0
 for <dev@dpdk.org>; Tue, 24 Mar 2026 19:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774406444;
 x=1775011244; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=POHID0iEyMqBKV+1Qk7zLUcIwsZb75DmvqClv7Tf2jI=;
 b=hpOUl/NeGtXVv3rmRSwZUSy2MifU5MUkS1FHJO4+cH14uuMrQqEkzk4ts0L/ZMO09T
 VIs6KWL7p3gmdGlSq79EAw7fkGPasP9Kij6ymktu3OjKYG46MaLC7akmXdMlleKQN1AY
 A0jMCBJw0p9CstEEDdVOz6X/fSbp8N+3vLYN9uUAPwhNCDJZrTY/JnGmuUzAEsNs6lvk
 d2ONZDmT4X1EelOtLUWB8iMLaRtP6vN2+NDc7RcosNGX9yP4Ml0Xe5K3mOJuFmUUPzlP
 UfsDNEP7s0TCLHQPpMkSfuT4/kdotZh6taZOLDGhXGXTYnkVLG7rtJzO3tVt6nNQEViy
 WC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774406444; x=1775011244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=POHID0iEyMqBKV+1Qk7zLUcIwsZb75DmvqClv7Tf2jI=;
 b=RQhLbdVnahs05pr9kRUZu7fagj4rHME7TZScfE346Fvqg8UMbYIBHgg1sDRR38n/Fm
 gyjL+/yEHTNRBD19NF3/cwyUqGt+nlwHeocRy/0dfoO4h10QVW2My6N6v2y5KJSMYF/F
 C3PqmtfcrRyyeQLZ46pjc89UbIv3aKIzlxEX1eonZHQKdDJnUkKt0AWKLkdLxMaHNRPh
 GQio6aIPtkYpp8fmUdGR/bnGJ2FEG1lCdwLcAQzKM7g7VXZBg4PIudb6dBDAU0zbEQd4
 /6T+D3w1gf7Y0jFaitxp+hVnuuxwoMcEk2Tt4+rIfFRWoVbfD+r2sQQeczQPe1os4Bh/
 xezg==
X-Gm-Message-State: AOJu0YwoWk5ys0GoketR463WIFdrL85CDvY1S2Iiz/vXcKrqoAk4B9jh
 QzY1PVRjdvKCi6w8hLPuYPTcRxlWqPSsNXvprYnMkT2DkH95a2DJsnsG45819NISb0b9/menNMx
 HnNDk
X-Gm-Gg: ATEYQzxNWfryrpSq1s/oxSbnxPxFGB+yqMNqdpcGurpKMESXy0SpH3E97dv3qSMljB1
 Ba/rQ50Mw1F2y5GPhsOmndfQfpC3fAxBkgpdw5OQxnq65/skQQohluYJMOFlojwZXwI3G9RelzI
 oFwAk72TqRu0GC3+WgxPIockGmLE2bGF8KkZVovzuj4ueRZM03i8jEgnewbDoQUOFAjBgN1aJOc
 RQHacTPwNEUK94l9zf37435+v5cmpeywb/bgW05pmReWFBT2LE+jClRMmZQhFy8m8vQYxY1QS2q
 jcWmGCUj2WSuz3/ZdwY+EKVUlqsGb8m+YVMSTtEiwe/APJ5ZCvDOknpZgsjFLUVrRMR1spW7TCf
 zMwVZsaiyjUtWrIxU+CxMo7jfMaJELv4P8Kk3YVkGW97hfx5c2884DPO7u+vIRyYLS/AaRXa/5Y
 8aqNTAMpMABel8Rowku3Dz5cGFMb/YXG3o
X-Received: by 2002:a05:7300:50b:b0:2c0:d690:7bc with SMTP id
 5a478bee46e88-2c15d381154mr937657eec.22.1774406443993; 
 Tue, 24 Mar 2026 19:40:43 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b29b447sm17209452eec.16.2026.03.24.19.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:40:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v21 20/25] eal/windows: add wrapper for access function
Date: Tue, 24 Mar 2026 19:37:51 -0700
Message-ID: <20260325024018.1275209-21-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325024018.1275209-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260325024018.1275209-1-stephen@networkplumber.org>
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

