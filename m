Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A27D6CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 04:31:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DE3340685;
	Fri, 23 Jan 2026 05:30:26 +0100 (CET)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id C89DC40672
 for <dev@dpdk.org>; Fri, 23 Jan 2026 05:30:22 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-435903c4040so1115101f8f.3
 for <dev@dpdk.org>; Thu, 22 Jan 2026 20:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769142622;
 x=1769747422; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qb/KtTyI217dkzhM8mOxid9C9M33uCk9m05pPJ+Lajo=;
 b=jSF+FVsE+HAXiTXcM3JLZfKBiZoEgXcqoELKfAnZmJWLsJPAG2zCBVRkCElKgPqSMB
 tFbub1f5MJBz8c3mu86Xb+Wi0SQL7FFgPr5TksLuZQQhi8rG4geMWDkcuvjVNL2C6SqA
 k0RgMVDGgzLb5JtNvd3fZgAW4Ddj1nT/QRRX74jIAb+f2evmNdbx0+siBMlbVbsamMWo
 ajbPJsd8VrITkt7uTCEjbLx81Xz4+ruAv1gef3Yp0+lesOSWI5iLd3QGRSLLzFu0sPYN
 sf/jll6IIYB5wJl3n0qQL1EjxeC9auIsIKGvNHT4GDDtLhlv7ldEvEhpFKzzoLP15DvL
 DaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769142622; x=1769747422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qb/KtTyI217dkzhM8mOxid9C9M33uCk9m05pPJ+Lajo=;
 b=DUdg69FLzF3sRDmV8A6IVDuX6c8J5njZi0FlvmAkqRHPxJIf7RsPWTlGzbzPah4Edd
 +1c1JKV+33OpJ10vcEiIHzgxeOptbITCetlYrkgOw2u9n3re0QfSEF46fjTvcHBWq/rp
 SeJuX9tggrREhQdiyzL+kdFk00Xt8ENF6YvrZ0FXkPDxkaHgGk7o22GKCg1tU++0uk2f
 SuaHQkMSRigPWflEJUH6vK26T/+tHGvMgL0Z1ARrw29YbZetxRORF1HCSqs+TM1W2wnq
 oZBemJx3u0btMT2G6ajbP1xYL8/aLygxsd843G9MOTk86urBIaHZKLSVxqGgzkspycZu
 G8Mw==
X-Gm-Message-State: AOJu0YzVlSCO+tvKaR2jWnloT+gE+YqE8NfBhS3Z1BNgso1tKzkFYOR9
 6ZgeXh0gLQg7rPJOupjaex6Tg3AS7lBeYrD5+q585doUaNNAMW7td8YVgoQHANf4G7n/zcDExqx
 9JVKX
X-Gm-Gg: AZuq6aKsZwrxhdoDyBIu3Y5isAHub5U2B5MsrgsXvbm1oH+Bxa8fxSqFTbB6NRpSHpU
 RKdYDjv88CReE5tSFPkEN57PgTh4PJ+fJnDOHww4inhXCCwnvPBGR/PBimxjqeYrvcRMBC5yghq
 PxQiBpc/J8smGo74RDnIYTzA82Zc2nDyB9M4qGX+/hPGkvEXBV032M0t+OEcC1STR8CGojQImgm
 YkZPb4OjVZMcx7YQTl6/Ff0W/ESVFh9hMqGyBdKzBau2DsHrj9CgbXqLCkr/y3zdPGjGSeLaqYW
 x5uwLW+sfrPq2PAGoqBfEmOaOg4CGNAR3gJ9loNibbMh+BgE5uWn4lbLFBVIiiomC1mavfV503u
 +jWuwmu8a6bS2Tfhfgqxb6kbRfwz+J9+5Lw403fvUFCR87+3e46y4+wOTdgHor6kn6qRlFHqRoQ
 gSh8JSHNRneLEl08uWO8JMu3r2D2G9LJf2yoMX8kKQwzsCAFsSvg==
X-Received: by 2002:a05:6000:220e:b0:432:8504:a383 with SMTP id
 ffacd0b85a97d-435b16132f2mr2689349f8f.45.1769142622361; 
 Thu, 22 Jan 2026 20:30:22 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b41asm3603771f8f.39.2026.01.22.20.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 20:30:22 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v11 14/18] eal: handle long shared library path
Date: Thu, 22 Jan 2026 20:28:12 -0800
Message-ID: <20260123042945.159075-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123042945.159075-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260123042945.159075-1-stephen@networkplumber.org>
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

Instead of a fixed size shared library path that could in theory
get truncated when concatenating, use a dynamically allocated buffer
via asprintf.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_options.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 485655865d..aad676a004 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -572,7 +572,6 @@ static int
 eal_plugindir_init(const char *path)
 {
 	struct dirent *dent = NULL;
-	char sopath[PATH_MAX];
 	DIR *d = NULL;
 
 	if (path == NULL || *path == '\0')
@@ -586,19 +585,29 @@ eal_plugindir_init(const char *path)
 	}
 
 	while ((dent = readdir(d)) != NULL) {
+		char *sopath = NULL;
 		struct stat sb;
 
 		if (!ends_with(dent->d_name, ".so") && !ends_with(dent->d_name, ".so."ABI_VERSION))
 			continue;
 
-		snprintf(sopath, sizeof(sopath), "%s/%s", path, dent->d_name);
+		if (asprintf(&sopath, "%s/%s", path, dent->d_name) < 0) {
+			EAL_LOG(ERR, "failed to create full path %s/%s",
+				path, dent->d_name);
+			continue;
+		}
 
 		/* if a regular file, add to list to load */
-		if (!(stat(sopath, &sb) == 0 && S_ISREG(sb.st_mode)))
+		if (!(stat(sopath, &sb) == 0 && S_ISREG(sb.st_mode))) {
+			free(sopath);
 			continue;
+		}
 
-		if (eal_plugin_add(sopath, false) == -1)
+		if (eal_plugin_add(sopath, false) == -1) {
+			free(sopath);
 			break;
+		}
+		free(sopath);
 	}
 
 	closedir(d);
-- 
2.51.0

