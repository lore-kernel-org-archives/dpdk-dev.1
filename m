Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B0DE92FE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 22:01:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DCC4402DD;
	Mon, 29 Dec 2025 23:01:04 +0100 (CET)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48]) by mails.dpdk.org (Postfix) with ESMTP id 32FA340611
 for <dev@dpdk.org>; Mon, 29 Dec 2025 23:01:02 +0100 (CET)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-b7277324204so1411696866b.0
 for <dev@dpdk.org>; Mon, 29 Dec 2025 14:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767045662;
 x=1767650462; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MNKd2hEyFhSqzVQ7OOBt1Lj6Yji9f0uL7siww9edlW0=;
 b=dWKL5uUeuZU+h18Obeiszlzg20RRPT3N+S8GqSySfy/SiZRS0FcvLhZVxWTL5B90w+
 TesrYNTe8rPZTvC3ZXvUfaWH5KN5R580JIlVc7wjFwcL10lhKcWOrUbR58k1L0teccrc
 HDwq+PNfMSQhFKLwHKavDKLSmvLugPOMOXIxYhIXDBHsX06Z35lHu3Wn57i/J66SAXqh
 jvcSRa37MopRHqgYETkSCokPmQwl10ZaePQvdf3HzcmClJ/961md3RvfyicpbIxIteqQ
 Q3totA1pzyvbEkqQQ/syJS1nN9onG748yGUkQpMTW6VaTIw8aaKvEU7m46J1+DDV86jD
 r17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767045662; x=1767650462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MNKd2hEyFhSqzVQ7OOBt1Lj6Yji9f0uL7siww9edlW0=;
 b=vVKfde/EkX1xwZin9J+aq/BWmDEt81AMcENYhY8Bimu9VOC6Z+EgfE3sSEPK6538ut
 YByEfkgHgbtbWEo2az4hkugQK3kUm5hu6hgaSBVR5YjaCEUoONOG0jRHwH0hz1kgfoRB
 wZ6EyWw/xoZzg6N2qDz28hUWe1DH/IPxqTKNO5LZsS3gCPPm+obMzupGuLtLsBLdBc4p
 k4NSFT47T8Hg8/rXiygWA/iHjjZ/i+JLE0i5cpTPvuj9diZshggmu1tqwgc0AvU+689e
 STdDbM4kp/x5F+IbCNDdAi2gYh+gQ7dpIgE3XEzUcgcQL893ZO4imfgvVuvu2hWAf4Yp
 8HNA==
X-Gm-Message-State: AOJu0YyqutoG691yhBrLkdMAFCY3tInkdg7kB7iEh6W8JgTu9ibfVPZ0
 iSLp65fO+VDzggjgEKcG5W2g+3V0TG5rNi0gVqbXdjJzp/dWHYKhFC5DgrYoi0SD0WBfb7dYREq
 d4p+WgK4=
X-Gm-Gg: AY/fxX7ymknbrdxzmhYUokQYu+Tt3BgSAJ4bmM8W+I4Vc0gYPNgiZYM7P5ogsgxYjNx
 nQFQIKsJjkMfZehOCbbqKRZCWC6wZOoPD1LlwpJMLYqh2Ro9fnX9+iMbjOuvKv93NZYD+AaCHDi
 HXviqjuL9K4sU5KE+xhQB7M0qy5fWF2mRQX4GnCWVc378c2y+QpFgxsmg+K4CxLT0NxpV9Nt/8c
 XbHj7JNdkf30+BQAaiQSpqXoIcr4AtWoMIjJZhgJPnxe8d6LyQjoYuokl3O4wYG0Nv/OyqnKQ4g
 EmpYUNwb7E7U8nHY4TZQy93/7o3X4NAjlx9XOVGMl6DWN27IZTlcAPjxMPg49Cg+z5TZvPicXcy
 dEP4GZ8Lk+yg5SCWG6RmZzjQru8qtf8hRsNFU35FWFHKYz2CmUVhnWVDRUy0adxNq8QWEd4SeH/
 7ZBK7khylYay4TLuC0B1+gXGT3MeZjswYzXGMatEbLDWaqQDM0KJAuWmdmzrQG
X-Google-Smtp-Source: AGHT+IEKnPsTe/spp1NDtr7cA0q+LHyMCWxgnPoRiXqKhNNsNPBs73fnXnjKbnb9VUdGQ8nRaJeDMA==
X-Received: by 2002:a17:906:f598:b0:b79:cf10:a17c with SMTP id
 a640c23a62f3a-b8036f2d2e9mr3046908866b.10.1767045661652; 
 Mon, 29 Dec 2025 14:01:01 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037a62973sm3496359366b.6.2025.12.29.14.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 14:01:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v10 2/9] test: add new function to get current file-prefix arg
Date: Mon, 29 Dec 2025 13:59:02 -0800
Message-ID: <20251229220053.21981-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251229220053.21981-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251229220053.21981-1-stephen@networkplumber.org>
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

