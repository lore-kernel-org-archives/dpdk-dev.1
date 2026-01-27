Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DBCD340A1
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 16:34:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77DC1410F6;
	Tue, 27 Jan 2026 17:33:33 +0100 (CET)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id 7C1DB410FC
 for <dev@dpdk.org>; Tue, 27 Jan 2026 17:33:31 +0100 (CET)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-42fb5810d39so3872288f8f.2
 for <dev@dpdk.org>; Tue, 27 Jan 2026 08:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769531611;
 x=1770136411; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qb/KtTyI217dkzhM8mOxid9C9M33uCk9m05pPJ+Lajo=;
 b=jUH7tRUFrDxFogPl2+ZDHi8vrTdFYsOKGuL3DCH02qhXXT6DdsVzASvPFZjItRgntK
 /aUF/mOQhVklCmLT2vqX85Z7GZVXjvFN9NrEVADrVz7v/XVwgRzWdytC9AKx+rhv4sM/
 P+Z/MzXPg8QS8yFoUpvb9MAhq/6TTE7H3sOJp5GwjSJNp33RvHdUsdRhxXeaLfbXTwew
 ocEgD9Fj3dpV3WsYeAw7s0HitwX+HNAMPuYyadq2XZjXMehmAgJqzIaIgr8wlW7cUWDi
 imvcSuIjOXi0+lYY6oNJ7VDIlIIs7WvxnDb6LgK+xsTANqZHGpPaR1kttfcDYwnS4tAg
 qEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769531611; x=1770136411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qb/KtTyI217dkzhM8mOxid9C9M33uCk9m05pPJ+Lajo=;
 b=cfrtqewj5D7X0GzvF2gZL8uTm134zlEwh9NCQB438XAxbIkmVhcCnM0cw/l2EgzDfM
 cFHafUuPDGe4y+P3ZTn/lTRJeCgRDZBCJZw798XD1ShMQbGocP3dQk77ow4EPKlW/Xvm
 gIvrzKWVovO8pyNIiUXZr49/rxlNSL2WGUH64OrpN7VxjaIcJwsxw7tNBxKcWQgTwopR
 6cxVq1ofa6l24L+2sGQlD0+BXeYxWjABuuDQHPKEKaT32RjEXJINNGKjVPQDFsHj1pma
 sZ0pUPqDKV9r1h/e81+kQZV0LrFKPxijgVBwhWoUeFYyYmKNct+JO/c1+hXaG4iTJ0Wy
 mf/A==
X-Gm-Message-State: AOJu0YyBpOvntmWwfDLOaaoQq5SehDT6ruegacs6OK4YqMWO5wauuAua
 ltcxoAqd2vAvHXkjrYs+xU/VlqicBC7PWhrrZh47n+z/5MNqTMTsHr62DwwgBstIa2+T/zrq99T
 hC6C0
X-Gm-Gg: AZuq6aI6N+Z/yFIVeiKMED1qWKf35t2Rus1nSaXAiQMvoB8jJekDZLQNKwX2KmbLWzM
 VVWNGl2VF5fWORmIHptS8Mu4ZGpM7gWFDGYrA9mOKQ4TED4IPW4mylzKh2YHUxkduuxAG4spWPt
 cHbVVaGO8W7K/Yf8DXe/M3UW51ZsiEey5Vjgui8xp1bZBdxntMzlTKJMx/7W8YeWwUBU8knFDSM
 W5rr4+bovbAfUK434uPpL7YGPbMJtHfaQ4+V/3WDjyYREDBp0AJsl1sNX4fgRKSypMG/zB6KA3j
 3DNczyT1wjJsNGYWijFZBcu78Hg9JSYXV6Yl7RQJ0vnjY7aqWQ/YDsZ5VWgmhXZtJ6CpEExiP04
 qIJVMbp8EcCrsYHgwpqW6gLu/xcLidI1zlvHXvGvnM0Zis0fdsJp7pxuz+n3JdmrU6pR6tpi1Jm
 /4QfEVqMxHok7Vo5+G8OK5A2FbzykMzgfxgmx9Qx6p5HyCZ6A8Cg==
X-Received: by 2002:a05:6000:40cd:b0:435:9cd5:bb2a with SMTP id
 ffacd0b85a97d-435dd06f765mr3122569f8f.24.1769531611031; 
 Tue, 27 Jan 2026 08:33:31 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f745dbsm39978513f8f.34.2026.01.27.08.33.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:33:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v13 13/17] eal: handle long shared library path
Date: Tue, 27 Jan 2026 08:30:27 -0800
Message-ID: <20260127163258.75566-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127163258.75566-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260127163258.75566-1-stephen@networkplumber.org>
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

