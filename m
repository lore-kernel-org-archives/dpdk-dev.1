Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBB3EA719A
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Apr 2026 16:13:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69C4640C35;
	Sun, 19 Apr 2026 18:11:33 +0200 (CEST)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com
 [209.85.167.172])
 by mails.dpdk.org (Postfix) with ESMTP id 5B5CC40A79
 for <dev@dpdk.org>; Sun, 19 Apr 2026 18:11:31 +0200 (CEST)
Received: by mail-oi1-f172.google.com with SMTP id
 5614622812f47-45f053b7b90so1319998b6e.0
 for <dev@dpdk.org>; Sun, 19 Apr 2026 09:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776615090;
 x=1777219890; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=POHID0iEyMqBKV+1Qk7zLUcIwsZb75DmvqClv7Tf2jI=;
 b=xhWcAvUbv+yrhfYBpX9ESGr/erogWvemRs/wWCQr/C/k5iLAbirgebjv6p5JAdaDrr
 KvoBy3AhW0U/b/fGyAipQl+rQ/mydl+X5HGxAC7B/1b21u5PYS0Tcklqrd83jWF40JyP
 8DhYwHb3iqTMYYbw1w3c8co42v/+IRYlaClZZaZ1aUs8T35KKYVYfrCnMXgrKO4Ia8O6
 6wBNRkYkbC2AWzyujpPoNeOs8cgZOXMSd02rxuulh9F0pV9EZxoE5MEbtUtU4//3R7iC
 /EEOEfENFRJTq5UokMvAiB5lxOwbEp46RfXDQFdL6aUj6jseX+xGxdkTQfbBfO6XYs9l
 pPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776615090; x=1777219890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=POHID0iEyMqBKV+1Qk7zLUcIwsZb75DmvqClv7Tf2jI=;
 b=chCsuRqQegKnbPWARBvR17dkq0Q9GxZAPuL7hzC0wqty+3v/EKQXSb++K1KDiYXBaK
 wTPOyLt5puC1iOQzE0JY5pUt8RQWqhqSQdcEbf3HGyeQxaCAl/DT3YkIul2valk+xOS0
 mcvVVELrQsbauYvCaWviyBG/8m5NEP0DruvmBnAnFyRQnK2VpR+29OlZ/mzWxytZ3QhO
 Di5r9CfGPx5XN2cJN1YXnTFeGa1ioDXwqnf5nYOOvP0U7Z6COWC9wjhPYlSMQd+mrP+K
 A6S0yV3j6NkLq4mCknmX6bx1Kl50NbZ2Kb7iUywYLQaG8pPoAIb7IaYHLzgLMRF0QTnn
 8qAw==
X-Gm-Message-State: AOJu0YxEnH8zGKtQnGHnna9xjOnGJAM/elemo8s590vd+jygkGGeVgM1
 UVnpH4HDzLXNwhM80ipWMy6lZ7j2DlVzcVh0gUsQq+Dx0WhX10os8f2rQ5YqQGe34NWLRx1gI9R
 pCUa6
X-Gm-Gg: AeBDieuZ6YM3ct3ehonkDNEnrUeW9N2I+uvCVAXQSwQerPOXMqmYpJtCycOBP+sVqPn
 UkGfpXXfomuWMtA665WaAgllpmD8hj313c0HrAR1U9JFDiTrDWh+325rOI1IOzeD4xgMXp50fP0
 /0FL5fEh7btsHwUN2w4fZfxMk3cXI2jibJEZ/1EdT892yOaFeXUaKSQ7TG6qdUXt3kaYBeo+jso
 12ikLYwdn/5ub6AbEWczrHbjyUBTPCSl/FX6ipG6VVXLAZcv8Qm8VoXXyPY94DsxWd6qjjmoiZU
 1Sd6HvAajJbc9pA2RBOOiyK0Uwjn+M3VZy4vdPo5lqkkrmj0So8jw1MKNBfTdL/4XvZFu5DZCXD
 DlLRSCNcch7ka+hyCqRXYGW7iIXs7RT8biBlu7S+ouRWo/9db0yr/lYvRrKRDmsz5+Wld69nvqt
 cvYG4m3wIOoFhROCJZDS+lAJwO41SuWW49bqMVvbdrSa0=
X-Received: by 2002:a05:6808:690b:b0:46a:746c:2d53 with SMTP id
 5614622812f47-4799c917825mr5227393b6e.2.1776615090682; 
 Sun, 19 Apr 2026 09:11:30 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b930bca47sm5970632fac.7.2026.04.19.09.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 09:11:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v25 19/24] eal/windows: add wrapper for access function
Date: Sun, 19 Apr 2026 09:09:52 -0700
Message-ID: <20260419161059.205954-20-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260419161059.205954-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260419161059.205954-1-stephen@networkplumber.org>
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

