Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A249FD30CC2
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 20:25:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6AB84067C;
	Tue, 13 Jan 2026 21:24:02 +0100 (CET)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46]) by mails.dpdk.org (Postfix) with ESMTP id B7B0240A6E
 for <dev@dpdk.org>; Tue, 13 Jan 2026 21:24:00 +0100 (CET)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-b874c00a3b3so134198066b.2
 for <dev@dpdk.org>; Tue, 13 Jan 2026 12:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768335840;
 x=1768940640; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1UoBNUoi1+EhVE1t3Dqovg1x7UhVI8Us1tilpBbA6+I=;
 b=dfWjgtsOTwbg7kkJWi0EowJDaU0hkbbPEeX0Tl7tJItbaB4IkdmnFoXDGwGiZzI3ff
 EEz51/gnh0ppm5sP50tSJuTjVQzvOYc2/Z2BD1kwbVjkVZi2LmKGIm7q4NRd4C3yKgdu
 4IGHHSwhCkj/8fNhl4Nh/ViIK5DIHOpoweGLHxNZirKS2LFKPOPK9fbA2sBQtEgjtnll
 Qu0UrhmDs4zWE54pAE+F11HIul2l/cylgb2AbQIElWJpepjWhtK84A4PIM3ZCwboREWR
 M3cRXQbXxmUvfi952mRP2z0M1Z+g0HOWDzyHgPcBehfL+kYWIQLYbLBr2MuxG6HAdbJT
 lkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768335840; x=1768940640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1UoBNUoi1+EhVE1t3Dqovg1x7UhVI8Us1tilpBbA6+I=;
 b=AhQwtIWnbmb5pWW5YhLWiW7m2EvhOSwRXVNsCfZv1intRcwPuYkCKyx8jlaipBTIqC
 oL7UFUvtY5baEsiqPnKki00GqhxCJyo8iqZ5q6ncZLhAimvm3eH697KlhCuYAoHGVsE4
 QXPzwAKQEkptExExdBhE/GY+SuQ/Vht9N41OpegjKswS9QthvduDvgvlz+/NFPHSg9yh
 JjfpSgft/5+r6Y8zFMyXJ+GwRK4DdBmTIS62Wdf3zHKaazKKAMN8jrGAGCyC0GWvEziD
 K25v9TC9fCLLUEWLB2YmNJHcQjQMOBlE5K4+ckLbQbAHixsi+XhRb9PKG1rP9IMFGNJA
 gz5Q==
X-Gm-Message-State: AOJu0YwBwK/rJrBTC/499kxUk1nuXV0cCxfVcM3qPArkq0FjC+B8U47G
 2d5ZAKeJcI3UdgGwqjkX18fCvC6kIljaGu7nJkNVFLl+T18c4u6hdlwipkbhwbmWXUZH8somxt0
 z/aqz
X-Gm-Gg: AY/fxX7+Pn2tmTQksY48KD+hgi+zcYJ04D7fBCzHTvToX8kiP/NUZJ4pGaAlLohXwtY
 CgPuqAAdk/wZzN9w2+iy8h9Obz1kUeCpBjddraJsqAE88sEvR71vSetjhjx/dAaAtBNDhm5QW8r
 HybL3ro6gl2W01LKGeAaBySl65E2tS7f0wWxVoe5FBl47A88aOMCuk7DI6kv3ho16mCcqdsvrQ2
 3EiKDu1GzGty9gVNalf2OaQlqbqIL26YPu/iKjdDL/vRsQl+zMxo8MnHVBh5U5MABw0GFC+ibvR
 quqxbkxSCzXkIhjd8CczdRJVGOYyWT15m+NWBhogCirvNWof5a1XuOSmwH3hxCRlyn51nGbw3QZ
 txjYmjcrrRK9ibUW3gZPfYTxytaY7ptu4KoPitAFts7/3862nemuZ7kWQWBKDFroH1jHOM27X59
 jfvst+9kWvtLXqzg2DySbvmPwOfEMLNSpmEi9yjjp8sJG6hZgG6QSFaD+zXw/J
X-Received: by 2002:a17:907:1caa:b0:b87:2410:594d with SMTP id
 a640c23a62f3a-b87612c96bfmr27816666b.49.1768335840293; 
 Tue, 13 Jan 2026 12:24:00 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a23433asm2314992166b.3.2026.01.13.12.23.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 12:23:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v10 14/18] eal: handle long shared library path
Date: Tue, 13 Jan 2026 12:21:53 -0800
Message-ID: <20260113202329.35190-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113202329.35190-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260113202329.35190-1-stephen@networkplumber.org>
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

