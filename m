Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A19D3B7E0
	for <dpdk-dev@archiver.kernel.org>; Sat,  6 Dec 2025 18:45:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CAA9840678;
	Sat,  6 Dec 2025 19:44:41 +0100 (CET)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id C87A740673
 for <dev@dpdk.org>; Sat,  6 Dec 2025 19:44:40 +0100 (CET)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-42e2e445dbbso1531887f8f.2
 for <dev@dpdk.org>; Sat, 06 Dec 2025 10:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765046680;
 x=1765651480; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1UoBNUoi1+EhVE1t3Dqovg1x7UhVI8Us1tilpBbA6+I=;
 b=3Nyi2oknVssdN5+us1oCBEJJCisU2wq1leUiTyp7Tpy268WrH8zmdK2cmFXz2p5TX4
 anEYnZguLmEQu3IAG3yQtYZkoxjnXJDFYSLQGaQfnUAO6/nl2TmVE1yPm6qobZEoFPTK
 fWDBPIQuPVTZU3ZLiufnsArCPvI1wU9LBN5AAFXli5/94flkATYlJeyCnEo+U2D+aWBC
 n8yNI6o+IHyivIAF/MBESlbT2AwuAkGCzeAYFtZvBgKp7T98Eu1FcWOArA8WgU8eDYxI
 JN26ehN/8RvZyjD7gM8jN1bh8RpkQrHXKhCf7k7mUJCXI1KY+oSeClIgGMvpPKV5kdFI
 I/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765046680; x=1765651480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1UoBNUoi1+EhVE1t3Dqovg1x7UhVI8Us1tilpBbA6+I=;
 b=IBr/PFXD3xlFzKoO3bsRB1uUoO85qX9uIcSBKpxBwcwBAVV183IsF49dgXRmgk/q0H
 7wYwyJ2bIVvq+0NRGgyv6vTwJpUuqJmzFy1gck5JI4w72taQ6k3ooZxZux4qbkBEyTnW
 GyMGaCjyWQg1XBZw3+4VxXem+zC8XJ6HQXci3SJjJZgpGBnPoI8YypzME7RazK0d19bA
 ZwKoD6WGmntCaW+B0vFXppunZasln7H3517fTp78E6vG983NDCotbqvI+WESKl7NeMNN
 lPyuJAindvyGB4HloLWsvq/xOR9boMpGb7DDdY98s1bw8K2yHLuHVmcyUaQ8eNedag7+
 0NxA==
X-Gm-Message-State: AOJu0YzhXj/YjOQkCjl0BR6Bbf0GF1E6ZwSIhvznLPTHaB8h8sCKBBY+
 1ixGtfK5oCC+t9ZwD9cduVGaMmzHnWjvufNMBx+U18X0yyTQuLFl6fszYXtOj7IsIXYHc1gcRWe
 uTIDQ
X-Gm-Gg: ASbGncusrhFlRHmJHVwVIPKbBSSp6dZQpbSc1c0tsz3spcOz0vsegb8IXMBVKkJ6/bH
 OGPmzccaaUQxuYuwyet5f4R8AGDIcEt79QWXi93PcbFg+GeFwtzWsYrN91HPHG9qplJlg39Lrqo
 en9d2QjlURj5XNp4gICXUuzete61N2Uooo/3yg2bKdCYCnXmbH/xhn1m9nix5KTYqpTxlCmkMrH
 OqEftLds1xq8+ycSFFs/5Gphxuk2ZN1LaLo3UlXhdSb6apSqgAMgdeR50MqOTCphKEBDpUZKKWs
 jupoBF7M7oxdxBH3nYCh1P2ntjGknrnVRAWvfaI+/0UCnBpXwqOsmV3gebk1BJslQV6oCvM8vYo
 l0G67lsVrxFjUmmYbbhQvpPIPqWNpQ/WznqdHdV2aA3avObWs3WU0NtuVjRnWyVc93npMxm/nPf
 B+vEnVr4G91M4KTiWoXDxij/EwLbsjh25QtisqfU1TkEGUGconHw==
X-Google-Smtp-Source: AGHT+IHryDAzG1++npa1D32TxjoCUP5DwMqOyIeE2zwsTnV71+eVbirZSVl66Qp6+ZYdbpsGqCrpoA==
X-Received: by 2002:a05:6000:178b:b0:42f:8816:a504 with SMTP id
 ffacd0b85a97d-42f89f8ac33mr2674097f8f.61.1765046680279; 
 Sat, 06 Dec 2025 10:44:40 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe90fdsm15281616f8f.3.2025.12.06.10.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 10:44:39 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 13/16] eal: handle long shared library path
Date: Sat,  6 Dec 2025 10:43:14 -0800
Message-ID: <20251206184410.542725-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251206184410.542725-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251206184410.542725-1-stephen@networkplumber.org>
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

