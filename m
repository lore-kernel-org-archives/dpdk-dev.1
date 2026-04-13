Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A775F34C78
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Apr 2026 17:18:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4900940654;
	Mon, 13 Apr 2026 19:18:44 +0200 (CEST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id DA5C940615
 for <dev@dpdk.org>; Mon, 13 Apr 2026 19:18:42 +0200 (CEST)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2d52c7f92b1so3783467eec.0
 for <dev@dpdk.org>; Mon, 13 Apr 2026 10:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776100722;
 x=1776705522; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+RElhfK797bKlsPZtiA6sS1lAqn1B6jWXLfpJ0qmOLc=;
 b=tQ0Ee73S52yR+m4IhRjE9tn9WjomZn78AdkQXZPleW6nj3Dsw8BHcIlk176Yoxm3ec
 X6OB6ILtp8qpbmag9LQ0T2xTzS58IxvlKZF/4Z927UZEfT1eYhunrLd9JQyLG344vBIJ
 8FkQSn/tzAF8pMgshIG1TUXUEhvkYl1ikRQkzliG21KTrdte88/wRvzLoLTY0EV3bBG1
 8I7Yi1/BiMz6vDLMdpKCw+9f7YV7GkGtYfv5Zgb/87RQLwtyGZsvFdJ54iDI+GAUQ+L8
 M9fM7E/YGavg9UBQEGKvtIwH8J2dIxc+Ipn2exkcLaSTQAwKg8OCfGBCT2+B81e/YOCb
 QcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776100722; x=1776705522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+RElhfK797bKlsPZtiA6sS1lAqn1B6jWXLfpJ0qmOLc=;
 b=Sn5MbsNf/5BgNmA8g/C2n1+zftwZNh304E+PLX0jgNztJBxuzpl7B4TRrjgwjWK78d
 5Hfu2/CjYt9F7P0X9Hsq+AyvHitsPrq5t4Gb8XIqaaL11pFfzOdrGz+E9Lt6deicAsjE
 yHfd2khz8ru0cGxaTdluar3GfUBYMalj6BalrOZ/OZIJtrK4tlRLwh5vLCrgPyUlwKcS
 JZoVyB574MbX1VXR1Ygro1WpEr5M5z/ILRpvHk8LQ/PCFxsh4CjGkSmoSmpaAhq63x92
 /nfoMo0BxSU5WIjubwypSzHeg8EYoeSOgTE70paPJJ8NALaLZgxcInTqCH9wV9EOBRMv
 /FtA==
X-Gm-Message-State: AOJu0YzUc/aq9l6d4NFIEzOJop9cSDq3wQ9vDVAR4IdMOSoI6fNvsFrf
 f10ZK3/4EJGS+7AWW2c/G9Mae0PuJvTQXyT/EdL+joZHrjnggQEjdDNngFM8iB/ORx6WizJ3IBV
 8L0a3
X-Gm-Gg: AeBDievRoG6DspZhwtDLXXweibckl+jbtuX4sSJR6wJkDgkHozE9WeC6kRKx94M27tg
 vWlypHEZbYoNn0mg2IGUhzqcVQDqhAH5uUXXeaWGD3se/0UDJZ82iKNHzyC0e5NMHdcQpMvMI82
 DJRC0m0kU4oRuR1to7qcPeXdNG7HA6x1YtF7p/1I4cabmiIYmyHDIdA62h4tTXy4XN3eZP2NbNF
 nif2DhVEIBNV31j+ed7uumKRXhxERavzZmk31OxuXQx2sV5IVuqNLW925Q9TRZlLNrkabOlYum0
 xDisdGEEKKVPNhkzjE9NgyR/sPJqEHk/9yh4bOnKMNzIAXuWy1zwTGhbQiMvTAvg8Qjym9Z6WAa
 PzVG8zTyRaWRBZEmpfBmvx6A6iRGV+AblvkAoaPcAO8T3095184xPXZE7r8UlaaCiHGicmMMCmo
 zRJmdgVdTRcus4ajWKl+aheOsHSd7wcWdkzNHo4fEw8LE=
X-Received: by 2002:a05:693c:8050:b0:2d6:4297:5fc7 with SMTP id
 5a478bee46e88-2d642976203mr4818472eec.25.1776100721847; 
 Mon, 13 Apr 2026 10:18:41 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d55f5c69d5sm20258602eec.3.2026.04.13.10.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 10:18:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Gaetan Rivet <grive@u256.net>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH 2/6] net/failsafe: fix hotplug_mutex for multi-process
Date: Mon, 13 Apr 2026 10:14:46 -0700
Message-ID: <20260413171836.123467-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413171836.123467-1-stephen@networkplumber.org>
References: <20260413171836.123467-1-stephen@networkplumber.org>
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

The failsafe driver supports secondary process attachment via
rte_eth_dev_attach_secondary() in rte_pmd_failsafe_probe(). The
hotplug_mutex in fs_priv protects shared state but is initialized
without PTHREAD_PROCESS_SHARED attribute.

POSIX mutexes are by default private to the process creating them.
When a mutex protects data structures accessed by multiple processes,
pthread_mutexattr_setpshared() must be called with PTHREAD_PROCESS_SHARED.

Also add missing pthread_mutexattr_destroy() call to avoid resource leak.

Bugzilla ID: 662
Fixes: 655fcd68c7d2 ("net/failsafe: fix hotplug races")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/failsafe/failsafe.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/failsafe/failsafe.c b/drivers/net/failsafe/failsafe.c
index 3e590d38f7..aa3fe53b22 100644
--- a/drivers/net/failsafe/failsafe.c
+++ b/drivers/net/failsafe/failsafe.c
@@ -144,11 +144,20 @@ fs_mutex_init(struct fs_priv *priv)
 	/* Allow mutex relocks for the thread holding the mutex. */
 	ret = pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
 	if (ret) {
-		ERROR("Cannot set mutex type - %s", strerror(ret));
-		return ret;
+		ERROR("Cannot set mutex recursive - %s", strerror(ret));
+		goto out;
+	}
+	/* Allow mutex to be shared between processes. */
+	ret = pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
+	if (ret) {
+		ERROR("Cannot set mutex pshared - %s", strerror(ret));
+		goto out;
 	}
+	pthread_mutex_init(&priv->hotplug_mutex, &attr);
 
-	return pthread_mutex_init(&priv->hotplug_mutex, &attr);
+out:
+	pthread_mutexattr_destroy(&attr);
+	return ret;
 }
 
 static int
-- 
2.53.0

