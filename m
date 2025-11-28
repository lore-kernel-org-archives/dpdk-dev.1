Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99CED116EA
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 22:44:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF877400EF;
	Fri, 28 Nov 2025 23:44:31 +0100 (CET)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id 38F39402C5
 for <dev@dpdk.org>; Fri, 28 Nov 2025 23:44:28 +0100 (CET)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-8824a756771so25153596d6.0
 for <dev@dpdk.org>; Fri, 28 Nov 2025 14:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764369867;
 x=1764974667; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MNKd2hEyFhSqzVQ7OOBt1Lj6Yji9f0uL7siww9edlW0=;
 b=if3D4RNHLMmCQBrCy+9PooZBvLBQrbMNuvneTSh/vgg1Ew2e7vC2sY9nIwWR3WSlCb
 GVKQSRPgAu6wWU0dfeStaW9kDaE3jI8TraFs6peEHBPBkboOt04DIN06Zln5phaP9mzx
 acaR1byI+DIEhOhYm+ybz5jgtPQ7yqvKhiV/7uuZVJf+DinBPbPJWdyCMMMM6iIfg/cE
 GbiTmaqhnG9Z3et2NG3q4ItrYrBe2mLRzn+roNND5YuVLre2ripBBFBcUwk+fWaDVJZf
 miPn45NC7vCPbTEQ0NDSQ/MOP7gTLZ6SMB/MED4aCdPfH3x0mG68N0TCQXoJ9wGMPRX/
 RXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764369867; x=1764974667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MNKd2hEyFhSqzVQ7OOBt1Lj6Yji9f0uL7siww9edlW0=;
 b=c2WPYPoeVgiGhbkQTIZ7QYRseg/sKHX9Yv1dgHmQTyo1IKxuOguAflgc8oGEYwcdm+
 Z+X10KrfxNkgjURBh6evhdS3crMJ4NYoS2Sor0yd2kPse5deJyCzRe3UHujBXzlCglcR
 P28sK25VCtDqjYxQkMJhka6lch6/lvaxAY+xuoTFJtb+pt8aAQNx5/Lbrp4lY7hISl82
 e+4Gi7E5qYBfZjT33VMOp4YzDyumCYGjlLd06Vt1g6KYEtoPpqUKuqktSP11uwDRb+7T
 2XmkpuK9Lpmg/qPLryTePs1qlLNCdUK8+pEl8v1zqHNiGUeKjBfcx5+WY/SMkUU6Iq2L
 yQqA==
X-Gm-Message-State: AOJu0YyR/IGc+biAHbA00pq8bvRc3KU+FXjcm5aLlDTTG/8ZpKegOTeo
 PWJEHaNeNJARCFm02FW+cUyXY6ixe5xrDZuOCMleDLmocuPb5pP2/qldVlMt3q9x8cpxFQdFF9O
 YWqiW
X-Gm-Gg: ASbGncue2D+T4v8D0b4PexMh3ZaViDoof6tgAcBG8PA3rPVmywGPkhgriEr7+1xkE1X
 ZZF8ocbx/k4zo+wSV/7k0t0gRH+GXOpZ1AbvJ/CNk9K3MOlgJ7uZZ54p4QFxrx9LkCCUJwxt+K/
 8HBevXacdofP7ZFG12W1jEg2o00vckTXc3Rl6rRPv7fv7ioVfrC4zDoB+VBPwPuZL+qqDLQFf/H
 krkw25/XPXY/N7rreKYG+8f0BFVmxONo9k77DbeyP9WaANyWeoe+kmPdCivOdVIx/Pc2oxs6Tny
 7mgrKbdmdbnHDMiBvNQs+7LEhbVR2qgquv1x5awZa2pVK/at48mO5GeJGs4GM0waDooieTZzd/R
 LK0WxXaO1nKMfwiXKlNsiRylCrQ5uiy4Ns/OAghkjHfC3huDHpPYFHpaBzRDYMd2XKGPHJjhBH7
 ixorvt9XswT5nMFdPR39tjTea9rQVL2XTTuj1D6iqfKaGmWS07nfolrFhnk4AS
X-Google-Smtp-Source: AGHT+IG4G9B2eVggRAxPxDNnJC/uHZ+7kXJX/+tq2ZCr9N1vQvZ4yT+2SzDcJPUM09sHYGfs0yz9iQ==
X-Received: by 2002:a05:6214:2404:b0:880:5883:4d24 with SMTP id
 6a1803df08f44-8847c45daf6mr431906536d6.9.1764369867529; 
 Fri, 28 Nov 2025 14:44:27 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-886524e2b8asm37022216d6.16.2025.11.28.14.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 14:44:27 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 02/10] test: add new function to get current file-prefix arg
Date: Fri, 28 Nov 2025 14:42:05 -0800
Message-ID: <20251128224420.195013-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251128224420.195013-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251128224420.195013-1-stephen@networkplumber.org>
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

Refactor so that there is one function to get current argument
for "--file-prefix=XXX".

The code does not need to initialize all these 4K buffers since
they are directly used by functions that set them.
The maximum sizeof of the current DPDK prefix is NAME_MAX (128)
not PATH_MAX(4096) so save a significant amount of space.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/process.h | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/app/test/process.h b/app/test/process.h
index f948a89786..251262d948 100644
--- a/app/test/process.h
+++ b/app/test/process.h
@@ -199,15 +199,22 @@ process_dup(const char *const argv[], int numargs, const char *env_value)
 	return status;
 }
 
-/* FreeBSD doesn't support file prefixes, so force compile failures for any
- * tests attempting to use this function on FreeBSD.
- */
+/* FreeBSD doesn't support file prefixes, so no argument passed. */
+#ifdef RTE_EXEC_ENV_FREEBSD
+static inline const char *
+file_prefix_arg(void)
+{
+	/* BSD target doesn't support prefixes at this point */
+	return "";
+}
+#else
+
 #ifdef RTE_EXEC_ENV_LINUX
 static inline char *
 get_current_prefix(char *prefix, int size)
 {
-	char path[PATH_MAX] = {0};
-	char buf[PATH_MAX] = {0};
+	char path[64];
+	char buf[PATH_MAX];
 
 	/* get file for config (fd is always 3) */
 	snprintf(path, sizeof(path), "/proc/self/fd/%d", 3);
@@ -216,10 +223,29 @@ get_current_prefix(char *prefix, int size)
 	if (readlink(path, buf, sizeof(buf)) == -1)
 		return NULL;
 
-	/* get the prefix */
+	/*
+	 * path should be something like "/var/run/dpdk/config"
+	 * which results in prefix of "dpdk"
+	 */
 	rte_basename(dirname(buf), prefix, size);
+	return prefix;
+}
+
+/* Return a --file-prefix=XXXX argument or NULL */
+static inline const char *
+file_prefix_arg(void)
+{
+	static char prefix[NAME_MAX + sizeof("--file-prefix=")];
+	char tmp[NAME_MAX];
 
+	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
+		fprintf(stderr, "Error - unable to get current prefix!\n");
+		return NULL;
+	}
+
+	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
 	return prefix;
+#endif
 }
 #endif
 
-- 
2.51.0

