Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F202E92FD6
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 20:49:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06BC340678;
	Mon, 29 Dec 2025 21:48:56 +0100 (CET)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 5E3CC4067C
 for <dev@dpdk.org>; Mon, 29 Dec 2025 21:48:53 +0100 (CET)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-4308d81fdf6so4425505f8f.2
 for <dev@dpdk.org>; Mon, 29 Dec 2025 12:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767041333;
 x=1767646133; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1UoBNUoi1+EhVE1t3Dqovg1x7UhVI8Us1tilpBbA6+I=;
 b=u4tOGy1KyYmRJ1JVb5C95o2jkGIXjEd0wYDlC8kj6t9OQvJrLXEj7A6Z+8BieNtH9E
 lIc34P6QFU1ViGq/0on7n0g5Ge0fTcQViarc/pFa92gS2sKi1S5+0b7cfrChr61tWWCh
 rA05UXyrl+En862eP7IdrbjCM+dX+dnCqM0LkSlAqiTZT7eH+FqE6jDyvqCcGbHC7Znd
 RTznJZFG1l1NBUfSqWvzIw4mV3bw7rU45v4NHkjgdgWtVUhzWO9hs5aqElu1dU3eCyuR
 4/Xkor2toKEWBKejSqyhh05ihlMEmWUNxhvbaErenhqjqxrcuvH7OquGPe4Sqtzrwx2p
 iQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767041333; x=1767646133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1UoBNUoi1+EhVE1t3Dqovg1x7UhVI8Us1tilpBbA6+I=;
 b=Zz5cUNB2AW++WmLV36VWzNECC3gmKxQ6C/T3AprZ4ul0/bWw/Ol4G27n6WqA+aNpAO
 fxfztkFbAzw0QYPW4IH4nfiWCN91La/qkyYx6jBCZtPYhOMV9IZBU1XukT03B5ZOH/3C
 1MFcrPrTsE06aFDrptDIBPaWhhNBqNwtfgQSOkghE/hEO/sW6OtVRdl4Fqtor6yoNehu
 X9wbf31B1hUzfDquRkQF/FI1Pngz2kiPdMEff42sq7lHjDAY8qUDs2qOvrBmgSg1GumA
 c08eCkvul6/xCprc2NQDWY10qFPa3dkW9iAz0od2bamujBI1w/Aksxp7VJVOZK9h/mEl
 QtFw==
X-Gm-Message-State: AOJu0Yy9rgUEy26iukM1agyErluDitI+LosR72GWKoUARBPHvENd5lq2
 awfR7DDcRX5iRoN/0WLP62MLIq+Mt0s1wxoYhwULBclz7ILV2dDN+6AAo6NgTBxBh/xOBKyCTiL
 RUD9qfmw=
X-Gm-Gg: AY/fxX41qCV/PCqMj+Vtqa4AwpZwVXAh3RE4muFgjVqBOyt96Tcacz/Fg/ZdGR16eJt
 lEsZtrVBobJ/o7QoNey0yZBWo7SPX/RgyAMl/+BnoMwBADq4Qqgja7EhhDWyBvHpAwg5XaW0r+s
 iSQK8lOdy4fQPnqp0xJZ+nQ871AwIi6rvNkiNpocmLaNDZhad9KGW7c3xK09ZMu4f0l9WnmF/Ko
 fRgKVPG2RdwDC7X0qQhhnk+OhurOrsSZfykw5FK+qmmbz0wlkqgcpSkpQPDQCEcM9m2T4VcX0NL
 2/vcV8znuc6HGjegwe0r2nAgHomAHvbNeGegsUlwRwGKq3CwqGUhglXnUF5raRf+wLqNRS5tQpA
 ImjTIDET71/gVPyDUp2UupS1GqlnF5pF15iGtPnVSxOnm3hPmlpv6MXgxOnNjhTZsOTIM81rxSb
 /1deSQKstUxPUYpgsimg3E7N5e8LmSnriLg1OWQL5XYOY/hUu5JQ==
X-Google-Smtp-Source: AGHT+IHbC3+ZPo5ed07uywgD5ipqCIi/g6eGoSCPVR9YtameFMNkJ/Pz5E/RM5yXYes0D5LEkB28Iw==
X-Received: by 2002:a5d:5f49:0:b0:42b:3dfb:644c with SMTP id
 ffacd0b85a97d-4324e4c157fmr37999608f8f.10.1767041332922; 
 Mon, 29 Dec 2025 12:48:52 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2c4fsm64676298f8f.42.2025.12.29.12.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 12:48:52 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 14/18] eal: handle long shared library path
Date: Mon, 29 Dec 2025 11:38:12 -0800
Message-ID: <20251229204818.61231-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251229204818.61231-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251229204818.61231-1-stephen@networkplumber.org>
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

