Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26661D2CE17
	for <dpdk-dev@archiver.kernel.org>; Sun,  7 Dec 2025 19:14:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BA5B406BB;
	Sun,  7 Dec 2025 20:13:17 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 037914069F
 for <dev@dpdk.org>; Sun,  7 Dec 2025 20:13:15 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-47778b23f64so23064055e9.0
 for <dev@dpdk.org>; Sun, 07 Dec 2025 11:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765134794;
 x=1765739594; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1UoBNUoi1+EhVE1t3Dqovg1x7UhVI8Us1tilpBbA6+I=;
 b=2RNK3cLRFu8ZnraahcFH0oFHSHAvmVxcB36HJREJjamnr4OnYoeUGNDIiH2hIgoWCZ
 /bvpEV5N96KtDD6BvmI5mV5ovwvMobjUackqn6E3xPk1qWbHwXv1hLEbHBh7c/GE439J
 L/nTNHIJcAXTqyLoDilx1ruukXK+rmWglzfCbRYxjcV3AT8bG2J/5AeJOH0ftZDGws/I
 YiwshT3VwBmfqHAVAgN4UM9zvMU6OlfLOXpGi/WOgDTUGHvrYpR7JHr0a1Z1JwbhIWZr
 qfzGoU7VOb5yXdwgrNxRyCs54j3mtPPo9wcFW8dNTs+hQ/cyVG28AbXDMEnBAMkKiN53
 V33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765134794; x=1765739594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1UoBNUoi1+EhVE1t3Dqovg1x7UhVI8Us1tilpBbA6+I=;
 b=YsMZBDCiBCOmNhy+buwBfLS/8SJr2/c4uGQNUPgNTbaPLB8ew8s7oojmQ6CmDMUAEM
 RUMmDUoSbsrEhtd8XKU9A83mU9AGxD692VeaDoXbGuUQvPmBsDXyjrW10SZg0CVtG5MU
 g7UZ6SC5GWC5JBhXQgHJCQ8tIEbmYen8UBB8SEUFHsUvbbGwAGT2WyB7Y0HFOSYPDdsn
 5UbdVfYogmrDYE2ZTppLKdctqVP+wCnyu5OOuBNtysIgMVcZP7x2DM/YuzFIpDDsSBjO
 mQ8JuIstWEwE2nAl7Z0HUDTYG6jEz3ioL9GRcKe6LPMdAfajL65YqExx2632W18OpS75
 ldlg==
X-Gm-Message-State: AOJu0YxqTDdNBEZqAC0dxYsj6TlbOuDVKPaLjHV+5T/lSD0fY19pbK3x
 MNuJdwc7WMUtyIVXtF51TyNleRONYA5jZ7Z/jVMLR4y4M3I+J49mqwabiP5Wwkrm9TRIkwyGN98
 9FVic
X-Gm-Gg: ASbGncuYPtf8ZNWBnER0IDiBD2aXqcaW6cgvnS/onz/FhBrRUVRnmvd66hrxiDTO3QX
 K5vAfLYQ0HXTU6MvQqH43FY1Hu6HJsWMPiage+O0hc5b9wZ77bP8dLROcGlUAwUdPPRaXtbKDW3
 CuhUtEi/nxWO0FvgjJ3jFTC33wInhOt2O4hfTj9iAXUDksN0G1QdXjuJcwF1QTVY4RVZjjc3WyD
 Cj/IwjziubnyIiwgVBLiGOkr2freUwjIvvzYDwjzj1uqeEcEsnYt9VCf6ZsCpfAArxj6oCx0PFn
 KOUhGT4JBA73b2EXlqXSbcv+CYuPPJKz997djyRMbpidhS0VzqLfIVHy0GHCoPItLecoyz+LP9g
 pk5UKao9Udlgmv4dB0EbNL+UtAiMt0U6SRSTG5mSkds9AK3jCz5qWWChLgM1gs/0qo2oCIJd2pZ
 2zxlEIjEvrIWR+2i2h3deP6YufT+RcuqHprLmdeRMlGkoBswTNnQ==
X-Google-Smtp-Source: AGHT+IHVnAOsQycE+WHwdXBfeEsTlg4fcKsEfQYpuXH1kVvISPEqoX4XaPstEz1ytFxdWOoLiKppnw==
X-Received: by 2002:a05:600c:3b07:b0:477:1ae1:fa5d with SMTP id
 5b1f17b1804b1-47939e27b85mr55622105e9.20.1765134794602; 
 Sun, 07 Dec 2025 11:13:14 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479310b8e70sm205124205e9.5.2025.12.07.11.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Dec 2025 11:13:14 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 14/17] eal: handle long shared library path
Date: Sun,  7 Dec 2025 11:12:05 -0800
Message-ID: <20251207191242.165619-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251207191242.165619-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251207191242.165619-1-stephen@networkplumber.org>
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

