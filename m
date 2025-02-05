Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F252C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:15:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72C4740289;
	Wed,  5 Feb 2025 17:15:32 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id AF74840270
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:15:30 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-21f05693a27so27538695ad.2
 for <dev@dpdk.org>; Wed, 05 Feb 2025 08:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738772129;
 x=1739376929; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qjBam4Z8vl6GAtSxq4gUZikoUqwpqWqP0yoI7OIjNQs=;
 b=ytxKf+aPVumnDiaHYkGme46V2Zf/ZbkrogcZP3HtblUZSZwh2X7bJpy8zF8Hr2hol2
 JECujEwgr7zMT4/nL5eKsakKLZs729pnbCUmsF9ZHkZmnDk+kRxSlfbhhyEBBS4kxuR6
 Gbe5GICdsy+n8t09TgP6sjbHBYxpwiRXx03o8lbpCaHQpLZjw69VdGKQcPQLQN8caWdg
 30SWn/eESquuVIHA4QOybf95BDp0XUHkojkUL0yh0haWR9AfLKMjGlC7419KxXd4qK/G
 n60bgixPeUNu2V9sJlgiaGHBPRBnT5xRfmgB+S6Ykq9zkwcB/ObUOb33W8zRw14mTzjA
 gAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738772129; x=1739376929;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qjBam4Z8vl6GAtSxq4gUZikoUqwpqWqP0yoI7OIjNQs=;
 b=GFr/MJqWU7gzNAyh2mmlmbCQGDhzusGH6fcekWVZd/TO2odQo5bpgRxlKhrKltIbZo
 tOO3HOegB7fKyu50i6RF6Gse0YtLmUR3XT5SK9GvZJjkZh7s+aKBPNEjW4odcC/C6sZR
 E+MtiGE6v1S0UVhEjlATnp3pUj8+7zl50tR9saqbL7iFH4qNlHkp23fwXI3v1ZkfJbuI
 4ZGVZADMgJFG+iGhZwaS2XGhFjdPpP7DeloWDBv/o/JeT5gO9JzHzpMuDNebCXWJYgFl
 L5IgMFiT1pRx+OaBVbZlrjwnawdzbfu1z9kjE5gaoPFijooNRpoEpB3RUWaFOI65FQCd
 EY/w==
X-Gm-Message-State: AOJu0YwaZiP55boMwhPYBdP9v10fX8q7xWnvBnY9SlPra4nPDmCz/Rnv
 tVlR45MTGi7gUFf6ic4MozBQH5xkBDHpIjnqpDYf4bJoCsmRbO+MmFiAhWB/9Hv25EUN385p6yR
 G
X-Gm-Gg: ASbGncuqIuqnupu0ZHNmgncEcujhvwtdEOtP3we2J5MRtCABZo68p0+hQzZrC6fYJp4
 g1Axa4XVt5GmlaR0pQJumDCmxaxPNzqyvztuZwxEzHpNIZIIAeztVG3YgfMh1EV13Zq7mCW4d0K
 DyKdwVfPWkHPnAQoTHaJ5X0GeCrR1bG+i6iAo+34Xb3hvb4RTF//+aaSNNzPcwxSJNZhN1EHODu
 cOD76WAB4rE88EKKMn0cX3LI3vIrpqelHItAtUzMivP7CiJYDu/J3OokXns77ZVJTyHkg/vChBo
 tFfF/FhBMVLGDAyRjWwFeHYjD1c90K7lpfoatmKjQwGPJD485yBXoHpmtug5oYNN3+OL
X-Google-Smtp-Source: AGHT+IGNTs7/bJo8qRefc1G+hIJhjSiLJm+TyE8hO54BWt06EBW+x3cWKYoLZDUM+fF0S97c8EYdyw==
X-Received: by 2002:a05:6a21:3416:b0:1ed:a4f2:8c0 with SMTP id
 adf61e73a8af0-1ede8845ee2mr5748009637.20.1738772129531; 
 Wed, 05 Feb 2025 08:15:29 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe69ce0d5sm13027865b3a.148.2025.02.05.08.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 08:15:29 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] log: avoid call close with negative value
Date: Wed,  5 Feb 2025 08:15:18 -0800
Message-ID: <20250205161518.143865-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
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

On error path, the journal socket code would call close
with -1 which caused Coverity warning.

Coverity issue: 448872
Fixes: 9da0dc6c0331 ("log: support systemd journal")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/log/log_journal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/log/log_journal.c b/lib/log/log_journal.c
index e9b3aa5640..43099649ed 100644
--- a/lib/log/log_journal.c
+++ b/lib/log/log_journal.c
@@ -116,7 +116,7 @@ log_journal_open(const char *id)
 		.sun_family = AF_UNIX,
 		.sun_path = "/run/systemd/journal/socket",
 	};
-	int jfd = -1;
+	int jfd;
 
 	len = snprintf(syslog_id, sizeof(syslog_id),
 		       "SYSLOG_IDENTIFIER=%s\nSYSLOG_PID=%u", id, getpid());
@@ -128,7 +128,7 @@ log_journal_open(const char *id)
 	jfd = socket(AF_UNIX, SOCK_DGRAM, 0);
 	if (jfd < 0) {
 		perror("socket");
-		goto error;
+		return NULL;
 	}
 
 	if (connect(jfd, (struct sockaddr *)&sun, sizeof(sun)) < 0) {
-- 
2.47.2

