Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD727D46C16
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 01:44:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9789F40B99;
	Thu, 29 Jan 2026 02:43:50 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 2057C40662
 for <dev@dpdk.org>; Thu, 29 Jan 2026 02:43:47 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4801ea9bafdso1664395e9.3
 for <dev@dpdk.org>; Wed, 28 Jan 2026 17:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769651027;
 x=1770255827; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qb/KtTyI217dkzhM8mOxid9C9M33uCk9m05pPJ+Lajo=;
 b=UoGW4ftdnHTnL+Lfef55tuaWxZjfFKZZEAMDV+OntiODUZjDnir1Yz6mg+++in2cWr
 vqRWAghzrcZ8sUfqYeCPUdP4IjMltRU0NMS++/+16ik79z7SxzbTTejmsm1s1BllZPeu
 nM7kg+MGPNAxgUB/3lUVh001xFPkxuCOw3WcrgaTwN0NF2N0VbAiid9nrr4H9FlfnjmS
 xG+hpCCty+seS9K+aTcnPID2S/cx8lsTOLELHIc5DxNASH5yq/hHoZ2zb/5c+pxdcm0l
 oEPfcC7nipMVu0t5Vzev/Iajs9Q7yAUoUWr90QlspVG2y3KVylPwgUzSj5Uu81GBA8Dw
 KelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769651027; x=1770255827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qb/KtTyI217dkzhM8mOxid9C9M33uCk9m05pPJ+Lajo=;
 b=eyrQkLVZXXr3Fzc5bcWKxbiiriD8grFmEKBgmLK1SWCy6IEFo+pPlZMnpfN3NXylCI
 qFu77Oedk/j36geJWIJv2Gisjs2Fe9rMD5eT2nlvjP0c0xfEb4mvF0KM537y2UW8Zh8T
 dSGN3za/CaTQBDzhzAeyFR1VyR0cXbMHaKE8VCfPwpO5DGr0oEB7jlQX6YJaR45+EGN0
 UgWdi6DOKr4iKyWOrwF3HQ3ivZHIFabcgD4ADi13FbPUj90vKb7oh1G5+mkn+8K/W2ZA
 xrbxC1/FVy6+182rQj2Z01zKgNmCk8wMR3DJB/G47BMX3ZaeTk0K8KoTViKVEgdzRBdG
 nimg==
X-Gm-Message-State: AOJu0Yxl2TNtQLFHaCkH4g23YTOenvReK8rH9UWSr+nAVqwMlda56cU4
 H1b7JhP6x60+nzL3bcoc2DirU7niZ0ymAyGbnSMCdaO7/s6oR8H0W6atTeWanJK+p9To76gC3Mk
 3/ul5
X-Gm-Gg: AZuq6aLruqUs33EzTZieVEfCkUmWBCdcWr+aoRbru7xPLpEfo8avFNHQlviLeRkpOyW
 Vnf3iyJ5W++V3WEc/W+hKqimYRdHza4RHddwE+xfNiEKdR9eyP8a5cWhV2LArxps3XK4LLbZr4d
 bKQVpn47JrQU3gePp1zA2mVZ6eotitT2LL7Y+87bBXy0X4uzK/3nKHKQYqo/CGZvT4sIUemJBt4
 S4rZmmP5jSAO9U/J3wxQRA0kJ4brCgfPIZ4yPJvaabgg0Xomb6Xp90HsGsHoy3ky84hGZY4rCtc
 jkxWGqsxcKlNSbTVCW9Nu0qH18ILuCTuNGP2NgZQby5xrncvkxN6kmafLuP3ZJ6wl5wCf2yEZsg
 2H1x2a+/Xc3gGRoUiDnwHBSprQNktZBb1OS3nmozB8WvuwQ1dd6v9VciYU0qEGRjCmdZ6zrCz/r
 QGzRklqZPvMvkaKseqBq4UYP0R82ZpWc7Wk4Rp0gq/ZsZk/9pduA==
X-Received: by 2002:a05:600c:3b24:b0:480:4c20:6a06 with SMTP id
 5b1f17b1804b1-48069c486a7mr100734035e9.17.1769651026689; 
 Wed, 28 Jan 2026 17:43:46 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e18427sm3217985e9.16.2026.01.28.17.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:43:46 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v14 13/17] eal: handle long shared library path
Date: Wed, 28 Jan 2026 17:41:16 -0800
Message-ID: <20260129014313.939831-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260129014313.939831-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260129014313.939831-1-stephen@networkplumber.org>
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

