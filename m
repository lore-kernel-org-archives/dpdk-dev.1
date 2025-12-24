Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DF0E78497
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Dec 2025 22:14:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6745C406B7;
	Wed, 24 Dec 2025 23:13:49 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id 4F12F406B7
 for <dev@dpdk.org>; Wed, 24 Dec 2025 23:13:48 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso60923395e9.3
 for <dev@dpdk.org>; Wed, 24 Dec 2025 14:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766614428;
 x=1767219228; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1UoBNUoi1+EhVE1t3Dqovg1x7UhVI8Us1tilpBbA6+I=;
 b=dx2Enp0DqZcjWvVu5q1gjFtjpZ1e1BpiExBAZ2FdpQSF7iyiD2Bd/hZjjdjGHhgXXw
 oIJaWaolj9v1qZ2uJPQbYQ4Y6meUu+mmE0rsDRNbYNTj2z+SkcN7Ph5lfyZoGRcvH5Ap
 vKVTTIvZ3662b/Aa7lEx+XyyVd/gutH32ybRgTHPQYG2YflY8JoU5AoBrEjyOGG9qeVh
 E5BEJhwz/FlJvcFIggHheIEeoECj6RDD+0qXjfHC7mfK7GhljLzYWw39wyksd+0Mxgdn
 6uGlAOSY7WeCUzuHnBtMm0J9jQXhIgyNZftL9TFJmgY/86osEjxoWa5kdWgyc0p5x6Ho
 78Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766614428; x=1767219228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1UoBNUoi1+EhVE1t3Dqovg1x7UhVI8Us1tilpBbA6+I=;
 b=ApQ3zdos3AXwwm/IVAJs3+WI/VsAuDYgZmqhv5VidJDZQ98LMysOfe/Q3skbG/n12E
 tzaRkap2x7XtmTdDaZL8WT4sLGKbWiV2/y73Ji2sYVtyqo9EawIoK2ItYnHK6KyP2aQQ
 nJI6ldLZ/t/wKPkwK65pyedK6ZI+XYgQxJ+kbJz8BNdZx222LrBv1IQnMyAu5WXZw4Y5
 FG2oxHjfZ2grqrlUDH/xzoGoX2INpG1of6oJVaxNZXUFCT+zQiLnrd2lX+edDh6uNKE8
 PWfz9GE1nEKBaJJu7aUA7rKQUPbEfnZOaylgPs3hGZj75VgZvN7pOfBWCClnzHHOrEEe
 vgUw==
X-Gm-Message-State: AOJu0YzETctKSQpJwqiLpXTPIqO4XhkOPF5Us+Z/DhSfCw0ArqDc6VJu
 yhF6YYT3TL1i+MXYzjU9yQTLW+P/x8Jw5PxvuclIJwy/3hYRekV5hponDjqkR1IpNRGymcbdqGv
 npy4yJKo=
X-Gm-Gg: AY/fxX6BeqCr0ECXDu6j0yl2pXZ3HhD9apVzTIpLHcrJYioGFuFcdMzVqQrOF+MnNTD
 9QjvRHp3AQgrnbqGsNw22YPQWV6KUSxl5Y54H+9k6Tc8cSm9+gZHTJUzUaxk6hUwxuoO01/ZxnN
 aTu9b1IY47u6qAx6UK8HmKkeLQUAtg07ocE2UniL8uaWEHGwukPW6MkPvs7H92mIXnH+6ohtZI9
 53fvvTo3ms+5wz3PeQ9S4MfbghWzgney/To+V8qPIc3CQH1l/ZJE0l4GSbOU2IEppiz21D/2Rst
 ZkRh0MHEsQmNH+OIeFRWu9zC/D+B+PpXR5rc6a3Ey26scREoUm04YaRxcDouK7wxoJM9izTBpdZ
 wM4d6hct4sA1ZiChB/GQ5462JC4PqQXe9gEN+mre6EWhJxNZdJItDsawKsjT4++tzhtB7kDasZE
 Sst4g5bT8iEW9qZduk6QUdr0KIthyXKjBLjLj7r3uvn4FkrMVtGG8yCg+GIbOl
X-Google-Smtp-Source: AGHT+IGAh/yeV+vaefusKB9aXn/7YWBsZlq5vKjU4B5LNo4Ycd4U5qaHwxo2Io8d0ALu2R6HN4QMHA==
X-Received: by 2002:a05:600c:1c1a:b0:477:5cc6:7e44 with SMTP id
 5b1f17b1804b1-47d195780eemr211195855e9.11.1766614427828; 
 Wed, 24 Dec 2025 14:13:47 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830fesm36796622f8f.20.2025.12.24.14.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 14:13:46 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 14/18] eal: handle long shared library path
Date: Wed, 24 Dec 2025 14:11:55 -0800
Message-ID: <20251224221301.52714-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224221301.52714-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251224221301.52714-1-stephen@networkplumber.org>
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

