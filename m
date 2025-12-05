Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACF3D3749B
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 20:16:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7456740691;
	Fri,  5 Dec 2025 21:16:09 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 18D454067E
 for <dev@dpdk.org>; Fri,  5 Dec 2025 21:16:08 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso32243405e9.0
 for <dev@dpdk.org>; Fri, 05 Dec 2025 12:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764965768;
 x=1765570568; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1UoBNUoi1+EhVE1t3Dqovg1x7UhVI8Us1tilpBbA6+I=;
 b=eBp5hJ1nXObGHhbsqZF97FWcv4JfBbliEqpEIctWPYQNzNdkfiVa0aUDnFhSkrqsSm
 86ZC+YdJjS7eobXEWTAs7+HTDwDiv6tSCGbiDzfLMdJUnXfeoCAahSAePtIJCj9yjsSW
 mn4g3pWnEUP9BQ1kQdHEyIWvF3Gp7GbrHH6cunCrdtEEZ7uUtrHrnPQrU242l4xC74g8
 AUPBv/GsD+YRDtOJoCm8ZGroM1BuC3976h6fyFqbNZmGtijGwx2vLSALrVOCgD2GR/ar
 DQ+0vKgZTFiQfeXp2AJ1K1e4jXoDEHOacGQzC+7CvStErHnsq6iE+7Pm3UdPE4RLErrL
 3sgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764965768; x=1765570568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1UoBNUoi1+EhVE1t3Dqovg1x7UhVI8Us1tilpBbA6+I=;
 b=mzI2D10fC7U49vpfVGw1gZyuqrJ2lror6+uPgc39XXgFfJQQ9+OQoR6i7wexjowu6c
 YKb0FK7J+JyaWB7uJIai46QBDpQrMslgN/97TOilJbAif5pnjMocxWEFVcvh5ZbfUT5x
 mPVdWPpuR5XoaKz7j/zYXibz93PVNa4jrJmsWNtzTU69EvlBgHDxeRC4r6o3D0p2yrQJ
 NPFYi0nFXChjFOMAAek8SGH920qv/4I0f2paNiDOra8NiwU/Fw2Y0ruUC5dcu26Oq6pj
 8hFrwQQ0Es48LxI9MaY6Tt8TPhWrfvxyoEXJkP34TvnYzM3WNjTI68z8LgVdcQdznbOe
 BJgQ==
X-Gm-Message-State: AOJu0YzNJxblJm5i/M92hjpVzrI9UNXl7Qg3aaOH/ma2w5fMdrsnpoSh
 vJICxMEoPwhLJQggoPi98m8l6Wmg94J3TwNIaF4O7BiWHV83AI9RwrVM6bPYMoVwqxC+0VIWf69
 018Ht
X-Gm-Gg: ASbGncvGJO1DaZlKI+PHNuTbBCfr/JHU4p5HbFcxR0ypojv/PxmUvttuXy1cZaJBIo3
 l9mRuXVpLr8ceXg3kxxG7TE3EZohVDZ7RPLD99yvS9TWvArtSsk4lAxYuZYT4EoLGsIqszXNuT0
 PYhQf5FiLK3FYcNxOMcpP/3N1Mx8u5Rfw944aNsAoLjxmB5LhmungQFnJl0MxllnNkqKu+G0QHs
 qDo95ukGRrH31E1UeLjg6TV7I5ubYPgYTKHs02o1zjYTGSbMVMS0pSXOT8IQ9YYEOeBJo1rf9nb
 zKAsZd4g1VfpdAOnHBftfHJWmHf0lp73BpzHEEOTPlUMQIq2CBXX1xfViJHZmYEnr5ldQf8NFEA
 0I0QQ3+tDfQD9DygDbfW0NfDJKjtYjyKy119Rd0MZO+6/kWDwAovXc5Tmgt4MUK5fl+PEpjj5br
 niV4VuTLZi/quFPawtSo4w6MFTaIgPuDRr9m2YEieC8/nWKHBDRw==
X-Google-Smtp-Source: AGHT+IEBU8oQtjv88fL57CIPkdJTRrC5T/HoJLJmcOBBdnFct3fXs6BVBVcIfQ+lhlZnnRurPfNs1g==
X-Received: by 2002:a05:600c:3513:b0:477:b0b9:3129 with SMTP id
 5b1f17b1804b1-47939df0050mr5147855e9.3.1764965767645; 
 Fri, 05 Dec 2025 12:16:07 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47935fce542sm45344875e9.0.2025.12.05.12.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 12:16:07 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 13/16] eal: handle long shared library path
Date: Fri,  5 Dec 2025 12:11:42 -0800
Message-ID: <20251205201537.251131-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205201537.251131-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251205201537.251131-1-stephen@networkplumber.org>
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

