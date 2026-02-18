Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2FEE9A03E
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 09:05:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA32D40299;
	Wed, 18 Feb 2026 10:05:51 +0100 (CET)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id BAC964014F
 for <dev@dpdk.org>; Wed, 18 Feb 2026 10:05:49 +0100 (CET)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2b785801c93so56966eec.0
 for <dev@dpdk.org>; Wed, 18 Feb 2026 01:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771405548; x=1772010348; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wOUtxMPzOJN7wSdnZew5D+Bka69wj7/1vlx4V5bWXHk=;
 b=i0z55DHXYzjdsa+XgOlBld7ZBX9TN2KVqMeDJVXR0sYPu/eovmJocs0fPQhBFb6thI
 Z1C9MCL6IE265d0wbArXc2W+qYDv1smzsHHgs1eU2aovBwDb/6PgUqBknpQk44JrVl18
 WUwWQZ7EVbm/5d4dUNi6nO3E36fat3GHs1WG02Nu2o0gSJbMBfzZeehFQepyHZV0MTKI
 P8pysiqdfEXuBYMII5IFVp1Yd162GGWZp1ZvoCvrLrwyAMKphoGk3HaRoaSc2aUcnYPM
 N3Iykl8M627tVP96tIsexotJIgROcjd4wXHKn2wFPF3A9U6cwfMJl5uS1x2ZYx381Cgo
 Q/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771405548; x=1772010348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wOUtxMPzOJN7wSdnZew5D+Bka69wj7/1vlx4V5bWXHk=;
 b=HwWvaFerjbO9LW8OrCHVgaCG38drY3cVd3cCSiWBNEfWvWOLRGQups6fMAaad2XZjm
 eyQnp1TWuvu/HoQ90vYOM4IVhyTCIpexFW9SuRvvfmZ0DwhQyIGR79YdYfkogUFP7/op
 kM23//R4udNSKqR2Krfn/RDHyfilKHHO4/a39anflzBzrn8fZNwqHhlC0OdRHS85zEG0
 K0QPSef8AbisA4sb/uN0CNN2pLM4s1BiMnwSEtWEVsRLfdIPabOvCxsWi82WLDssrLmb
 XYMRlCOwWGIFlAkQKuVBsplseL6As1TfY5T7BQ0rqGbxjE6T8rzgGrpk1DtsmRX4iUIu
 yO9w==
X-Gm-Message-State: AOJu0YzUKYm6YthHfeczUCDRpqE5Ji1sYpp8jB/OFO7VKBpctnzZ3S9u
 ZzNWvd4hs/40YDetKhzxpCbqwKIXamiqYU+Oo47Ja3JKvmFmbzSw0byDG43MdQ==
X-Gm-Gg: AZuq6aIYWpy8l0V9crhgPP+U1GICtrOFN6bQxgtHHUgO+Igam0/zt3/sXjviQ+/mcoP
 xxgLSi7CqujvNeS+bCBo+saNopQ+upLiK23Bxs2crcibatB6y/xkow/a/MEdX6+a+5tD0Vgi8HX
 08NX+tTHYEGL7gPFbo+qbn8SzQ3UDsvhKnM3e1GTF5aG4mAUa0vj2yAHn7RMpXWqcWtVdqZSXXq
 13hoU1nz64V5Cggryv1Vj0of/Bkt4KMsmaU7t6+MqpZfcLaSRvLlagIg0yVjTfTY/acmQ05qzEu
 DiXMRBkPimpkQW2iN/DwyIibD3kcN/3/1F6npnGXkSG7G1MDWAJorfXsCowgMaHGUQQKkwGnecP
 AEFJ243iInd+dmflAidXOrU54n8QMOdP9x0xwYHfBgafi0RwpKd1eR3SF5ZPDGoDQWtPGojy4S+
 2Z8Vhbsd+ReV7mYuQCaIm0Fy78kTSJqnFIxaPrfdomFOC1M9WPze+mn5tWHLWd3w==
X-Received: by 2002:a05:7301:3e19:b0:2ba:8018:cc53 with SMTP id
 5a478bee46e88-2bac97ce44fmr6067780eec.35.1771405547993; 
 Wed, 18 Feb 2026 01:05:47 -0800 (PST)
Received: from C9HFQX6C61.corp.nandps.com ([130.41.236.144])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bacb582bebsm16727463eec.15.2026.02.18.01.05.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Feb 2026 01:05:47 -0800 (PST)
From: Yehor Malikov <malikovyehor@gmail.com>
To: dev@dpdk.org
Cc: maxime.coquelin@redhat.com, david.marchand@redhat.com, chenbox@nvidia.com,
 stephen@networkplumber.org, Yehor Malikov <Yehor.Malikov@solidigm.com>
Subject: [PATCH v12] vhost: fix use-after-free in fdset during shutdown
Date: Wed, 18 Feb 2026 10:05:40 +0100
Message-ID: <20260218090540.89215-1-malikovyehor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAJFAV8yjTs8inmZqYyPrTubc_oaKfEi=nv_58HzyXf9f+pPg0Q@mail.gmail.com>
References: <CAJFAV8yjTs8inmZqYyPrTubc_oaKfEi=nv_58HzyXf9f+pPg0Q@mail.gmail.com>
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

From: Yehor Malikov <Yehor.Malikov@solidigm.com>

The fdset_event_dispatch thread runs in a loop checking the destroy
flag after each epoll_wait iteration. During process exit,
rte_eal_cleanup() frees hugepage memory while the fdset thread is
still running. Since the fdset structure was allocated with
rte_zmalloc() (hugepage-backed), accessing it after rte_eal_cleanup()
causes use-after-free.

Switch fdset allocation from rte_zmalloc/rte_free to libc
calloc/free. The fdset is a control-path structure that does not
need hugepage memory. Using libc allocation ensures the fdset
remains valid after rte_eal_cleanup() releases hugepages.

Fixes: e68a6feaa3b3 ("vhost: improve fdset initialization")

Signed-off-by: Yehor Malikov <Yehor.Malikov@solidigm.com>
---
 .mailmap           | 1 +
 lib/vhost/fd_man.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index fc53ed2a55..711a6ceff5 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1840,6 +1840,7 @@ Yaroslav Brustinov <ybrustin@cisco.com>
 Yash Sharma <ysharma@marvell.com>
 Yasufumi Ogawa <ogawa.yasufumi@lab.ntt.co.jp> <yasufum.o@gmail.com>
 Yelena Krivosheev <yelena@marvell.com>
+Yehor Malikov <Yehor.Malikov@solidigm.com>
 Yerden Zhumabekov <e_zhumabekov@sts.kz> <yerden.zhumabekov@sts.kz>
 Yevgeny Kliteynik <kliteyn@nvidia.com>
 Yi Chen <chenyi221@huawei.com>
diff --git a/lib/vhost/fd_man.c b/lib/vhost/fd_man.c
index f9147edee7..5748bc31e2 100644
--- a/lib/vhost/fd_man.c
+++ b/lib/vhost/fd_man.c
@@ -4,13 +4,13 @@
 
 #include <errno.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <string.h>
 #include <sys/epoll.h>
 #include <unistd.h>
 
 #include <rte_common.h>
 #include <rte_log.h>
-#include <rte_malloc.h>
 #include <rte_string_fns.h>
 #include <rte_thread.h>
 
@@ -94,7 +94,7 @@ fdset_init(const char *name)
 		return fdset;
 	}
 
-	fdset = rte_zmalloc(NULL, sizeof(*fdset), 0);
+	fdset = calloc(1, sizeof(*fdset));
 	if (!fdset) {
 		VHOST_FDMAN_LOG(ERR, "failed to alloc fdset %s", name);
 		goto err_unlock;
@@ -142,7 +142,7 @@ fdset_init(const char *name)
 err_epoll:
 	close(fdset->epfd);
 err_free:
-	rte_free(fdset);
+	free(fdset);
 err_unlock:
 	pthread_mutex_unlock(&fdsets_mutex);
 
-- 
2.52.0

