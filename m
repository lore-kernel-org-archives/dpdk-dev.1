Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4B2E784BE
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Dec 2025 20:20:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9587240684;
	Sun, 28 Dec 2025 21:19:55 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id D8E5740689
 for <dev@dpdk.org>; Sun, 28 Dec 2025 21:19:50 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4775895d69cso35687855e9.0
 for <dev@dpdk.org>; Sun, 28 Dec 2025 12:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766953190;
 x=1767557990; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FxsF3XY0l0IbGwp44EoJybmMHW80EKZOrZApeykoPeU=;
 b=RRbQe6ytqvsG1KaDouQ6cp7g0rR3eN7tdfPHJbKvgg/ge0c7aigflDO/OKCIk5VMox
 pJNcyjmVbH0XeFijprxJrvwXqRhLGhsibfNXCXVazbF2CMJe31jO2k7lj/N+lg9Fsjz7
 qrzfWF6kzKp//1AJFrDd0WVG10TuFiQ9Bd5NLuWiX78Bl4hFrsoZLChwePbin8C91a5W
 NGrwoKcWydpL85dDNMPKrj21vRTCmCUh+1lzU1jY1yDEJrF7fZq1paiiOK5XC1vBW1m1
 YgWXOhtZ2kzI3bcgr33rpa+1CVrVAyRsr0LY+4KoNVzK0kA0kxOVx7NnR82xkVWsvVno
 FEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766953190; x=1767557990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FxsF3XY0l0IbGwp44EoJybmMHW80EKZOrZApeykoPeU=;
 b=SX+5EQS8qjmyUQZSLf50cw8AyF1IvsXbiHuJdptm2AA/jKV0MYQjx4dKuBXH4mibA4
 1q2vAybVlzx6WYHgHx/nJ93zdKAsoDRn7pvSpehkMYXrnKOcOwV4fi0I//sY5njcA/l/
 Z5wAz1qrzXQ9A3Jtt2CEH++r93TQemVkxHJYs9dxkxQ/glJlm19L14Ahh5k3imKul6Ns
 jp8G45Zw1ONrvFkrcAo7NTp0adktAtlcDrMWdW2mz6KHv7uJj6AqSi3pPfeyG0ZgFfaq
 gp+TIQVuWgk+T5lEP2+q/Kui0ScuBatoKhoTU02zHZGUsubiiDFnsLU0p2up8falMjoq
 5AKA==
X-Gm-Message-State: AOJu0Yy2pLx1VW3nXR4QQAvnIIcolWvCXB50TlgSDzQVKLdyIgt+mmDj
 EgKMRU5uPHgXXGDbYOPmfo/pZ3nEWIq83FjJ20o0YCyl+m3Z5BXltkC4sLHVOaum7hj8q2isZCZ
 vzvQ8MEw=
X-Gm-Gg: AY/fxX5DD53c/bDfai35J4LrO6ZFj+2B1TeCEM13Lpgiy7KPimcMkUCRP67JvOYSxaW
 eIc9ANj+zkmqqk7HjqTtzmYMcoE9swdBV4Ksmk9xe0C8jseksNiW6d+AUENCKjc1xrdxbpaXjM/
 kUpUVOfqaRp3qLMHtIYkNUSKY4kbCYSxiQA4XJAKCHSrYNblZanJlyfXoH1rvogkbB1t35+rWTF
 Oh89ftB700cwUPVMvvzs28GwEVUSExLv2cdwgCdVJ08ysYSn2xo5pq7saOM6vla4qKVgEVVRgn8
 VTiqbcOePovRGDh7hz7hj+sFWQLdV9Y0QEV9soICliupNn4CRAIpD0FG2LTJLcd7V7sWy1UOf2R
 NwVfx2UORsE6HMAA09XFWzizRhm1AhGDKIlo+MYXrWnyeOT3+Y22TqhAy+yWl0WJTFDLA5hKm8r
 ABh9Z6pRAy6dGEdEL6NHak/t+K1xGN18ku97PgYkzWTWbSrT0OBQ==
X-Google-Smtp-Source: AGHT+IERgHvAi1fQow9kQk0FtKY1BmmJvUXdLaOiV6s6U2zCsmddnyUBElZ9vrMtMPbxTMdir02KBQ==
X-Received: by 2002:a05:600c:828d:b0:477:73cc:82c2 with SMTP id
 5b1f17b1804b1-47d1954a14dmr334137665e9.9.1766953190457; 
 Sun, 28 Dec 2025 12:19:50 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3964226sm240319655e9.0.2025.12.28.12.19.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 12:19:50 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 10/18] eal: add check for sysfs path overflow
Date: Sun, 28 Dec 2025 10:56:13 -0800
Message-ID: <20251228201236.547268-11-stephen@networkplumber.org>
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

Shouldn't happen but in theory sysfs socket could overflow.
Add a check for it.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/linux/eal_hugepage_info.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/eal/linux/eal_hugepage_info.c b/lib/eal/linux/eal_hugepage_info.c
index 7161b1a2fb..fe3351259e 100644
--- a/lib/eal/linux/eal_hugepage_info.c
+++ b/lib/eal/linux/eal_hugepage_info.c
@@ -150,8 +150,12 @@ get_num_hugepages_on_node(const char *subdir, unsigned int socket, size_t sz)
 		return 0;
 	}
 
-	snprintf(path, sizeof(path), "%s/%s/%s",
+	if (snprintf(path, sizeof(path), "%s/%s/%s", socketpath, subdir, nr_hp_file) >= PATH_MAX) {
+		EAL_LOG(NOTICE, "Socket path %s/%s/%s is truncated",
 			socketpath, subdir, nr_hp_file);
+		return 0;
+	}
+
 	if (eal_parse_sysfs_value(path, &num_pages) < 0)
 		return 0;
 
-- 
2.51.0

