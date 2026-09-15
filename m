Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0B7C88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 19:22:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F025342E12;
	Tue, 15 Sep 2026 21:22:32 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 662E342E12
 for <dev@dpdk.org>; Tue, 15 Sep 2026 21:22:31 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2db22383fe8so1021315ad.2
 for <dev@dpdk.org>; Tue, 15 Sep 2026 12:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789500150;
 x=1790104950; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JH42FQpJP8eXzY3mww0SVmmUqFx+pzo+Zx5So3ziQIM=;
 b=xUY7Wc+To9PWTFXwnTuFp+Z7u3Mo1vxrNuqjj+8oinFfEzbUV8TV2q6T1IzSdqYs9E
 UU+3BuXH2dUPpcQhrfDvyqPny04fia727hAmWupC0V7zvTs7jdN9ZvBTYePG8UijrQnM
 OhaumGgmdGdNEf/EdG1XDSFDIgs7YtexmoKjscwNaPF1E8EehTekLdDKueJUvshXnFgh
 DLuQmCpcAyPOxcYccj44hJTeWI49k9Q2Pg0NWl8MZf0nqgrStbJVyXvMWmKc08ZSqRUZ
 yOJcILlSm/Q5UVs0NgVHxH4xVIVcM1KfpPqFyVLLCikQlxvz/q9WyoLQOms0mVnwAHbr
 DylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789500150; x=1790104950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JH42FQpJP8eXzY3mww0SVmmUqFx+pzo+Zx5So3ziQIM=;
 b=sCrylo8i6cKvGl9A23cGjJVcFkqgcmhNzO0CdLTg/bH0zlscRns1Y7BL//mGAXlq1C
 gEpC/bWyAc8Y6YWHxgg4vQbv6f4fBMauzBvhgGyZFgOjdi6l58w+Luf8D2xKx6P77M02
 jvSF0nqmZ6wqQRlna8vYYUgKXk2NdAxhvf/dyA3vxpEiFuviMTXAKAodyIVDsozy9ae0
 e0vR5QGvdme7crCHyP8RCX3n7zmCm+lmAOIJd/b/WD4MnYBGBkg4Ob060jIfY85PesxX
 7Lmo7z84JxTkeUuitEV1hPyAsZ/Wn+/CjnPp1rtGoll1M6DH3zzxol7gTOSdjocIy5OZ
 drDw==
X-Gm-Message-State: AFuF++llknhxMbJwQqPihle1eLUJ7XLzYYSAwNUUOZuWoHX+n24vzmgp
 6HYh4/ngbd80kmanRzFsUB2XO+89kZejdvoCBu+tWcBnsTkvXh2MrHdGBdjsrOyVVNhVdxaaiOB
 9+Nim
X-Gm-Gg: AYBFou2OqjQaQ2l/dfvWeijUIxqkHIfvLU577fkr3NGPG4vw1E84LEwX/8j39Aa4jj1
 ZnHxCnry7CkMLAcuWtuQNFg47+bOOzHKuWmO2dRfZFqgMnqTpTPOjuIvs9qQaJoOfK0uEjglxHj
 O4wa8Qq4CyJRJMuel+nzcMNa3j5VKazHLYSWl2FPqARZWOnbPutdJ7tp5lpVGwq7w05PgwjfbAr
 2McANW/ZIOk2AaGayqyW/0YmxAXSr9I4GHERs0oM4msM8xXf8e9cKPGa/TziCuiTpbreKTIcqQB
 bd+9nrmWTKFaW+wSiMdQwG84RgTJaxt1K6jQP7Qz2VOm34XZDCJTa+nHFJLbU+EJ7kCb2J1rDmA
 bgpwYnuv5grsEzvMLxYuMUOIFWAePmNweiI6wzYbd6k5Z/iPNxaokihkqzuNPkTPn+jITv28PQI
 PcOxHv6GpQeVHQwUa7wHPqKVL0A20EIrDVYke7v2GV3BF1ZPh2QjMpBelziSu9fipI9vWzCPnPw
 QplzVWi24KdBOBYqMI/S6p0T+UFlh8xVdBB9Q==
X-Received: by 2002:a17:90a:e48:b0:39d:ee20:1e28 with SMTP id
 98e67ed59e1d1-39dee20248dmr11227594a91.21.1789500150525; 
 Tue, 15 Sep 2026 12:22:30 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e1bbfdd49sm217535a91.11.2026.09.15.12.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 12:22:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH 05/18] eal/windows: add getrandom shim
Date: Tue, 15 Sep 2026 12:21:03 -0700
Message-ID: <20260915192207.3926217-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915192207.3926217-1-stephen@networkplumber.org>
References: <20260915192207.3926217-1-stephen@networkplumber.org>
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

Provide getrandom() in the Windows OS shim using BCryptGenRandom()
with the system preferred generator, the same primitive as the
getentropy() shim.

BCryptGenRandom() either fills the entire buffer or fails, so the
shim never returns a short count and has no 256 byte limit. The
flags argument is ignored since not needed.

This is needed by the coming rte_random_bytes() change.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/windows/include/rte_os_shim.h | 34 +++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/lib/eal/windows/include/rte_os_shim.h b/lib/eal/windows/include/rte_os_shim.h
index 4f9611d642..87819045e8 100644
--- a/lib/eal/windows/include/rte_os_shim.h
+++ b/lib/eal/windows/include/rte_os_shim.h
@@ -4,6 +4,7 @@
 #define _RTE_OS_SHIM_
 
 #include <errno.h>
+#include <limits.h>
 #include <time.h>
 
 #include <rte_os.h>
@@ -154,4 +155,37 @@ rte_getentropy(void *buffer, size_t length)
 }
 #define getentropy(buffer, length) rte_getentropy(buffer, length)
 
+/*
+ * Windows has no getrandom(), use the same system preferred random
+ * generator as the getentropy() shim above.
+ *
+ * BCryptGenRandom() either fills the whole buffer or fails, so unlike
+ * the system call this never returns a short count. The flags argument
+ * is ignored, there is no Windows equivalent of GRND_NONBLOCK and the
+ * system preferred generator does not block.
+ */
+static inline ssize_t
+rte_getrandom(void *buffer, size_t length, unsigned int flags)
+{
+	NTSTATUS status;
+
+	RTE_SET_USED(flags);
+
+	/* The count is a ULONG, a longer request is served short like
+	 * the system call is allowed to do.
+	 */
+	if (length > ULONG_MAX)
+		length = ULONG_MAX;
+
+	status = BCryptGenRandom(NULL, (PUCHAR)buffer, (ULONG)length,
+				 BCRYPT_USE_SYSTEM_PREFERRED_RNG);
+	if (!BCRYPT_SUCCESS(status)) {
+		errno = EIO;
+		return -1;
+	}
+
+	return (ssize_t)length;
+}
+#define getrandom(buffer, length, flags) rte_getrandom(buffer, length, flags)
+
 #endif /* _RTE_OS_SHIM_ */
-- 
2.53.0

