Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E37D3B7E5
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Dec 2025 20:20:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A779D40A77;
	Sun, 28 Dec 2025 21:20:03 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 7957840A71
 for <dev@dpdk.org>; Sun, 28 Dec 2025 21:20:00 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4775e891b5eso34583155e9.2
 for <dev@dpdk.org>; Sun, 28 Dec 2025 12:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766953200;
 x=1767558000; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1UoBNUoi1+EhVE1t3Dqovg1x7UhVI8Us1tilpBbA6+I=;
 b=nzXtYZzljw36IUtufh6dVOQ8A9Pw8eEjL6Pm+oaWlQfbHbFhMVjjp8YUA2dorT+Oqn
 L29wjwL7ohdK0nE5mmWUrgz81Xg+nfDpXkAIuZjr7J3t+soBMjFv+pJG2BEfh3cvU7Uc
 h9ahLGcDuoXxH3pswd3Q3lD7c66+FD893EZCfwE0oIFsuS3ERskoHvlTq7fHvUqvFzna
 eSBywUOnoyRV33FAj3qZKV7qYdVhaPDhqzQFNqTpqYpHPpZ+UXx7FivGVoTWhl1ukDVT
 3kqz+yalCjTQnjs7PofU+klHErO5JKGnKO4+m4iCVd++Vt1zlf3/Wb8LYb/92tpTbnlW
 bCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766953200; x=1767558000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1UoBNUoi1+EhVE1t3Dqovg1x7UhVI8Us1tilpBbA6+I=;
 b=UwqjycSjOig79jnO9sDvMP3EF4Nt1/F0Dwi74IaDyRNe3tg3wjfL6HiAPSPJ8M7MqE
 /B31PhSuQo5oBzJDAiHdbmYjr/a5iBEjjyRs+P2xJ2sXuG4udUG1RQZOcxEhmUqCCOM1
 8P5DDQUCFiMmWqMPUsrTanJBsT1mms0ktXl6gpYDMxm7OgJz4YmyHKYKhIyj8KBqOQ3/
 kRA1OahDK5vM68ojmwnqSbE9El20p9o1K8cq2Yh0z5WSUhY3u3S38BLazylyJ59wAkM1
 UplP05qOVrbYWl5AodGUidedAUT5QHIIpX+xPihpMP5h7h1PrKb0y15r4sETyRGDQy0E
 kj6g==
X-Gm-Message-State: AOJu0Yy26YwjBBuSB2nQ+jFbaHsHHJD2jHSNmBlUkax5H+3Ixc1ZLpbC
 MvYrqrhopBD4PAncOMVF45EKQRxTRsygYPJDrnwO6pPK7gdemhxyabDcu0qWAT6/P2lp9eo672n
 HMMVEDB8=
X-Gm-Gg: AY/fxX7X2wrGNUF7S6T5rHrEPiiIcYEFXvUK7Rtup2ypPUhOGAWSKfvA2OePpLAsb6R
 vv23cv0Up9PdbP/bXVlVIQtLvgC6pIAhQEOkX0OSw+A9s+OW4vIUmS9a+S5loSjT/Wl7ZeUeLa7
 xlZKW2HRH0jAD0tGLmB8MeGozAtrX+AEOJJUmaBWRLCpH8CG0QKsSt0GgamAbOfA9qg17P7euEd
 DyhuSQSzdVcuWmZFOxICPymBye/+j1Jk7xB1kN8WJa6HrBTvod5HhwYq5/iB04Qoyfu25auxoMg
 AfbdGXmaV6LVclKjqSYhwauo+wT09kx01ZdrZELiAXNBQNdNzV9Xe8SK9MD/KbIaIzatcJ5J8wI
 ghtAUDOq5TgQ1ehSOj1ZtRiDGtyUh6TJA6c4fxS4txZbKiur4EHGncwFlNUjExL42nYgeO7tw24
 LEsMOGpXqUZQqr7NSnucT/pSHY4UkgWJfgjV5hGIISo98G18/AAg==
X-Google-Smtp-Source: AGHT+IGykzW8MfWo3LclwCM8jEEpGDLOf6g0SiOhS5t2DeuR4xAqwy29w1AbK51oYnA/1peMSvxfJA==
X-Received: by 2002:a05:600c:4e8e:b0:477:9f34:17b8 with SMTP id
 5b1f17b1804b1-47d195330dcmr315753035e9.1.1766953200075; 
 Sun, 28 Dec 2025 12:20:00 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3964226sm240319655e9.0.2025.12.28.12.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 12:19:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 14/18] eal: handle long shared library path
Date: Sun, 28 Dec 2025 10:56:17 -0800
Message-ID: <20251228201236.547268-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251228201236.547268-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251228201236.547268-1-stephen@networkplumber.org>
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

