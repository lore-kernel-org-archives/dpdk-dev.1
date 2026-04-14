Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAE0F9D0E2
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 16:12:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E19C840DD7;
	Tue, 14 Apr 2026 18:10:39 +0200 (CEST)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com
 [209.85.161.46]) by mails.dpdk.org (Postfix) with ESMTP id C9D6D4067C
 for <dev@dpdk.org>; Tue, 14 Apr 2026 18:10:36 +0200 (CEST)
Received: by mail-oo1-f46.google.com with SMTP id
 006d021491bc7-68244d317e5so3544017eaf.0
 for <dev@dpdk.org>; Tue, 14 Apr 2026 09:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776183036;
 x=1776787836; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=POHID0iEyMqBKV+1Qk7zLUcIwsZb75DmvqClv7Tf2jI=;
 b=QkYgYmI/OVl05WrQY5SjrC4K/x1ecFsBk8xYz0cv0Oy1PiUw7zOUnJh7i47259AUnU
 5d9mgci0NNoHOFED9o1lJuwF57hNzCvDmCqiuvzvqfT4VvMFZwg9nBVswI1CnUZ4yxpM
 Tni0AqT7MQJK/kCB7wiM1OZBiJWn3Iid32wj2OxPaNshoCCbopkqNHXGJtDSizkkzHxn
 Vu+eFFXtdNvozvmrhuhh3FxqUqest1xFvU7jrNKjcMNGorq8B2nB2eORFA9kucDv/ze9
 BQhpzr6iTFC1gA22DX9353qN/fEUoyO1yx4mQRxkar5H7SWwZxlWLDxECO07Kvrg2+f6
 JRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776183036; x=1776787836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=POHID0iEyMqBKV+1Qk7zLUcIwsZb75DmvqClv7Tf2jI=;
 b=eV1or1kMM1wUJVR2j+BH0akW3rzqu7ApV4ri5Wj7lx8WDE3u4R4wSenS/DpbbJUVs7
 XT+b90DoU268NZiJoctVJ+D5DxXX0qv7cakdzHh/Al39qNDLEeXfwlrymtldXZ+N4RyG
 zkl1oTZIPAJZoE/5qSsfWUNBDCTxCMhqPT4fggHp+bX0/LWlWcEutk2v9Ar6IMIFZ8Ms
 twWIvZ7DzO/IHh4UIR7dzcEGU8x4AIMILBcQ0k+hRCtYrsAxHqNokycq3PKS3ySj7GyS
 jQDRmkYYNqTe05JSQValGsdUeZGv/ESOa+424/kFNR45gKgHXOD+KGwT5pfVjj3Ldwrf
 W1fQ==
X-Gm-Message-State: AOJu0YyWH9MaZcYTuG0YlrvlurvbtCcHBYIhkUgEkWRq/ey6sPX9ATai
 YriDzBdF+C2c8QyB2F6JoSzKpq58vTD+FygucVDPD74pIDUC5hHjZboQ6NtgIxnBIJKf4R8n9QL
 1HM2K
X-Gm-Gg: AeBDietYOQWUQWvX0UBtJxfYmn227ZaENHB5nSiLTQNmhf2exEbqgk6jqmEiuClRw95
 iPoX2bS3JkT1ZDF8zKvvY1KRy5iacwjSHhQgP3iUpQFmVgxAxpJ3y+8qSvmh8h5dMBXFnM9tRqo
 AH9RSCKg0ApcW5O1VqJ3H2iIaAV8F6t3WXZtlPTNNj/QoB3R1JYZHNlA4Mov2pX2PLfUuHyb8i7
 WKy28JT4v1TafpACHziEnDHqSmRNOdCfS5uSpKuHgs2OA9DZ5ZyKofH8vPceR+O5+E1PEwfomu9
 IXypir8p05tyDZd82eVDzfpGoPBPFbmmsnWcJ8MufEuWlW8gH7x+EgUHd+cYhYpkBm7CLaG0RAW
 tPH7Q5Ou1AB6v2LG6kD3DUKEdqR0O/DgVm0wf7Z0MZ+Hj6WEK1BlOYcFZKVHyECvpFP1mnnj2Mr
 vgHxKUCOH8uZ89DpolFXQBCv3W+tyB1SWI2gLb+Wxe6WU=
X-Received: by 2002:a05:6820:7081:20b0:67b:baae:3339 with SMTP id
 006d021491bc7-68be80e3347mr6548616eaf.45.1776183036031; 
 Tue, 14 Apr 2026 09:10:36 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd396960sm11809554fac.2.2026.04.14.09.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 09:10:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v22 19/24] eal/windows: add wrapper for access function
Date: Tue, 14 Apr 2026 09:08:10 -0700
Message-ID: <20260414161011.756101-20-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414161011.756101-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260414161011.756101-1-stephen@networkplumber.org>
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

