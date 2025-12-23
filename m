Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C66E6FE23
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Dec 2025 18:15:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74CFA40698;
	Tue, 23 Dec 2025 19:14:48 +0100 (CET)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41]) by mails.dpdk.org (Postfix) with ESMTP id B28BD4068E
 for <dev@dpdk.org>; Tue, 23 Dec 2025 19:14:46 +0100 (CET)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-b735487129fso943861166b.0
 for <dev@dpdk.org>; Tue, 23 Dec 2025 10:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766513686;
 x=1767118486; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1UoBNUoi1+EhVE1t3Dqovg1x7UhVI8Us1tilpBbA6+I=;
 b=zVX6mevluZFZXviITAvWzdQbmi8J4EjBeiX4e+OaizCoGKsRFEYoW7Xj2TuuHy1U4d
 KrLRGCzf0Q4EJSUukwiv2cv7wxh3E8QOdtDgmv62HFn+KqTSR8kkkHykdQhdQ0mB/W2D
 wKbFUs34rFNEWlydAV5iPTJw+VFcSKmS5lILGHi1fdsOn3dZG2pNuk9Moq22xFonk8Wh
 NRW+pj7uk0AzW6K9L0oUFr0WZUiPfMgBW3juRXL7Zw7nJShR0BaQAbNo4dYw8SRG484m
 FR1GA1EkkBDhO3oPSoAFlnttA7OsO2B3Gy5xlBY5Bt6kLuTlNZkv3qOFHIK2+ES4Fzw+
 a3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766513686; x=1767118486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1UoBNUoi1+EhVE1t3Dqovg1x7UhVI8Us1tilpBbA6+I=;
 b=a+NQypSQaHA8oy857jG8Ntf/lZTN2uSUw657VJ+BMaTqUhICDlgEOy+nxi0C9Zxk5+
 B7phDlizg2jnObQKuY9wMUj75yo+YGaQZ8UGBm3rULWcLodviW9XwSzC9n7GIe/M/rXQ
 9hdbavoNgdkzsn9cUsjWwVpYinvFTghmHQu/VUjpEoDmAHw0NdlU1BHvP57kBCXQlOuO
 DoizzJNfaWZYdvmOtklxW/a+zSLDapEY6wFlVTIwicCel0cWS6X5tJQWCMwC8NaW1Dky
 gWtL+STu/VYeDb9Wwc9v0kC8lwWWl1EcG4NKYtvh3IUOC85rAuUYW5fFXDvXyOj9hERd
 iFVA==
X-Gm-Message-State: AOJu0YysSMqfgAQcSxsu+HEVZhKAnlqmorFyC58PyfbL6drLicMX5Hdv
 G+8oI9TLQVO0OWHK3mzNhtVo5i15SyYMGureXeNr7fsGTHt9tTIXqpCGE3SC3t1R4S0SFxDAfOJ
 Ujv4skpU=
X-Gm-Gg: AY/fxX6EzGdfz8F+eBy8wI+vadb2MXKovrhHkaG9/mvKFOTDwpcm89TAsfeR5QzsuuL
 u+OJ69Iz//aoP9Dwx/YhM/NXvzf7PY/koxOvBvhE/VfEdoUCP9DCR2/K8u+8ewCWGv/A+F5QQil
 f6nW3dyXsHFn3OhrqDG4Aw+h36xwnqFdiI1MBWrgN0PbNMuvXoeavdmzaS9w1Mm1JKNni6WOI53
 dF2+dKJ6rrOGhkGwhipMVD7YvZPvEiZZBEyNW+KoFLaQagcRPIyFKvFbUg9RtIlOgsIt4F1loLE
 Sx7DmNAdZux0/HtCbRk/NQH3P67+odPvS9uzYlRKer/5mElwna48W/BxW2YIUKDDKRAIoINsPaL
 NsUYcPIuFIHBaKV9tRhduEUifsKqB0PM432AZT0liilizKZliGAsr4T1j5RaEoq5F4UHae3Zior
 jfx2mUHTFSpz1VHlfQYFGEGsIIaSIG03K7cSNbKpXS9VqUJs4WIVJIkJ692KJ3
X-Google-Smtp-Source: AGHT+IErF2X9If6zGtc1LOXq3RLL2rrRmRJZiX1tu21IIFEoHd7er9FWQ1TNnhjggzucdexl+h73zQ==
X-Received: by 2002:a17:907:3faa:b0:b79:fcc9:b00d with SMTP id
 a640c23a62f3a-b80371f353bmr1735880666b.59.1766513686219; 
 Tue, 23 Dec 2025 10:14:46 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037f3e271sm1495302566b.60.2025.12.23.10.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 10:14:45 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 14/18] eal: handle long shared library path
Date: Tue, 23 Dec 2025 10:13:12 -0800
Message-ID: <20251223181418.40834-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251223181418.40834-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251223181418.40834-1-stephen@networkplumber.org>
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
index b1fb670ea0..6aa078e135 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -570,7 +570,6 @@ static int
 eal_plugindir_init(const char *path)
 {
 	struct dirent *dent = NULL;
-	char sopath[PATH_MAX];
 	DIR *d = NULL;
 
 	if (path == NULL || *path == '\0')
@@ -584,19 +583,29 @@ eal_plugindir_init(const char *path)
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
 
-		if (eal_plugin_add(sopath) == -1)
+		if (eal_plugin_add(sopath) == -1) {
+			free(sopath);
 			break;
+		}
+		free(sopath);
 	}
 
 	closedir(d);
-- 
2.51.0

