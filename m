Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE82D19523
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 23:25:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D70DB40DD7;
	Tue, 27 Jan 2026 00:25:01 +0100 (CET)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 61E6A40BA0
 for <dev@dpdk.org>; Tue, 27 Jan 2026 00:25:00 +0100 (CET)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-432da746749so2704509f8f.0
 for <dev@dpdk.org>; Mon, 26 Jan 2026 15:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769469900;
 x=1770074700; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qb/KtTyI217dkzhM8mOxid9C9M33uCk9m05pPJ+Lajo=;
 b=urEJ+/K2wm+fdlf/N4pxR5JCtXsYsf9IefeWQra72z6xj4bp5QJOkwOz4zykTJLgSR
 912ic3G2FCr4bGyTX3HApSu+m4/szKG9yckG3TMBN+qu56Fia/YTgCxDfeUja/SP71Gs
 vY3iNN4MOhr9cSI3ggLhu0GMZSeQEVelFcJ6w3OLsp2z1e7SZapCBkIEMYom7TRS6qzD
 O/3ncu2YZgYqbXdBl4U2MMiQqMZkKYoBlvRbKcucGn/Zn0xCZAeuZ3ZG3RqESZmyUR7A
 1f9tioYu8zbufhZfz2U0jjwfexq3m0NQsj22SzNzzMbucS5nFdfUlFn4rpV8/qFLIus/
 EYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769469900; x=1770074700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qb/KtTyI217dkzhM8mOxid9C9M33uCk9m05pPJ+Lajo=;
 b=nuC7o7/gIyNnliwlFlIk8rL30/hghOyKJbqmuzaE5b6CWMcPUNJ4BCl3vbpXgwN1cL
 uPqjSFoRX2K9Ok7ezPUe0Wtv73nu9ZtqTJLIOFeDJEbtdVo1S7nOBk1Ay19s4HmE4kGQ
 pPXJ8H0bzg5+b1yb4Np4iZXfzTq+0lidDSXb6lK5bNR2tBTupwp7K+N1yzB1cAuobqGA
 BDqevJs2rZzcuerZkwPbP3GJoT/I9h/5i6eTfaW8Zz0uOzwZfvKxo+PvRoG2t1Dkr9Yh
 /SKqhTaczkdpCVAAiquogRvy/Yl0tgx2j5gsUsI7o95DnovOthFjCc9mT6SibJcgI52h
 /i7A==
X-Gm-Message-State: AOJu0YxxzkjzLe4uNZ6oc8srkm7VnugfGssJ4LY4ZiqKk+ZTzT4MxMFK
 FxH++T2W76Fh5K6t1F1GncXgMrcJMujNVT8Xa04KKy0sLdRh0r5KKaNMQWy7O7wCqAwBwJpeehp
 fbFpq
X-Gm-Gg: AZuq6aJTxGW8EOasMSXyioSs1HihQ9ZEB28SLL0AOJgbHyH0qzEvjsmzZP4xURSDRZh
 NUMgExynDxjHuc4dxMtmiq7S0jhb6qRqkEqDEU/CGNUgRfqoj+kPIpCuh7nkWtKQflW/RWRih+x
 alv+B+NhNcw74MSyew/4ncQEKmuQkE3CaRY2ogwm0moAvQXNF7gA/Co3GMf4q5n0Smn8DzocnmT
 N/dvPQQNKfCK2Z9MIK7RoMCEyYXgClFXDFXIsg1dR0CJ7grmdfhkB8uXKBkv6gBHPztaskqdA0V
 Ko5KjsVNKQdQjuePTPLCBpn0wRWBHTzztpvqYC9qBQ9ogt+MFQXcCH8oRm/+P9KMlUz9XHsqoPn
 7Tl9HtTHlUkvo/yPNdyW5oKbohQJbnmwIx1mwxMfjrC37UnmEtliIeO+9rX6LJokYhcWGJnMU73
 eJpzTRYdOml9V1ogR1mq9VyDftb3SwKtKVevBiEnIRmZwzkFzDow==
X-Received: by 2002:a05:6000:178b:b0:42f:b0ab:7b48 with SMTP id
 ffacd0b85a97d-435ca124530mr9200911f8f.1.1769469899947; 
 Mon, 26 Jan 2026 15:24:59 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24a6fsm33711846f8f.16.2026.01.26.15.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 15:24:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v12 13/17] eal: handle long shared library path
Date: Mon, 26 Jan 2026 15:22:21 -0800
Message-ID: <20260126232428.276534-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126232428.276534-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260126232428.276534-1-stephen@networkplumber.org>
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

