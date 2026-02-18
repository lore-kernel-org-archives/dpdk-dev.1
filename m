Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A79E9A03E
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 08:02:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A4A740299;
	Wed, 18 Feb 2026 09:02:06 +0100 (CET)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by mails.dpdk.org (Postfix) with ESMTP id C2CD14014F
 for <dev@dpdk.org>; Wed, 18 Feb 2026 09:02:04 +0100 (CET)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-12713e56abdso516028c88.1
 for <dev@dpdk.org>; Wed, 18 Feb 2026 00:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771401723; x=1772006523; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vISCSz5dtEP2AkQYfDzdugBwJZyTfQW+qfAxg147WP4=;
 b=k/a9qn1E48mxFi31N0bv2AKgQCHT4aN+7WqNRGdUS6Ve3An7WswmR5cX0vU0nnXtbb
 qiNQ6RmlCB7vxd2IgSyuv4KpaA7FES17VrvHBKHlk78jI2S/YNau94R4z/mhGb/k3NWu
 I7iAj5ogXX6k0Yz9pq53KXoHGqrnuHByEHvYQYIu/y9kKYw5PvFdK8urxRjovUZ760Di
 vm8AHlbgCovpwqd4tHrz9QypXZVKxLyb3WjWG65/sp0MSaIb5zvQtQyUTgvZHffKKcQ3
 LuHTs36eQ9rcAe3TQhpXf5yJrhU7ZoyyfzHrz4kRwtS5kfO7Wjh+gsRjmom23pmZNzwZ
 KSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771401723; x=1772006523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vISCSz5dtEP2AkQYfDzdugBwJZyTfQW+qfAxg147WP4=;
 b=Ad8w2RGQ/zETBcwsca6VuD4TzRIiJS7ITuvo9otNCNbL7Iy83kLVXqYGrR4l191X5Q
 Yv7BBUxggupHfEXPeYGBepMpzq2ruPwpI/vBG172ds90/rptr93ysGgR0PfQ9STlRWa5
 QxMKAL8O3HA5o0douSNAh+7bWfGlDg7ezGl60yZo+SHoT4+XUcPKualDUA6a9C+EDvQF
 irU9hQCTWC5d1EQw79ghL4VflS7Okh/dbvUIaNHK939DMxrmDia8owLCwwUu1wTWvw+N
 OyO8A/NsHDqVQ65r1rCZYTry1UBrS33sgc6InYKQQ62segCppkELSPmaJr4H5WisuA+x
 /CAg==
X-Gm-Message-State: AOJu0YwP9I71sV3xskooHFnIHxQXTV5kpsMj4mgvdW9YkRl40aHVhH7p
 B7HDpStdr+ooVGLib1PNvBNlPwU/JXdroQRXhLFgRTUh5CW+zvDUaurh7/zl/A==
X-Gm-Gg: AZuq6aLognXKhT48Vk3IEXQY1XV7sPtrfS+y8xqTIPCVhFbylorpU8f4RoT6Fq7UgX/
 x3bbwS7u5wGXDxHuM53dfimKUWsWO5Bvp9UXXxjInK7yMqpJrQVdHkRWOHGkLlVz8fOJseyI/wM
 XdvUK7RTy1he/dv9SQpstMd86u9N0U3T/if8XNiQ+6/Mzjy2cweopRZYl6TyZcJGbC1fKEQkAgx
 NtmX6qIlM+AIm23FFchCysQYB44BNgcYSxUMvm1WBdtKDeMMSnJqbAWSCyzvTzQzZU8DKPqJuK3
 Y38A6s9Nymste9nEo47csrjs4ec6AIqMjjeuUtKDrkSoHDevGVnQLgWeOGDzGER7PHjGCPrwQLN
 I2s3kSLIBZa67lR6j6sYya1cdwyfFW2DFGofcefbdaYUAQygEUiGUMDSaHGh2fD72I9wSobEFgo
 KSGwmFWr2n7Jb7/CDK2GWM3CgbESHIzhQrHJCk0Ey8U5r0rDdKzB4fq08PKs+sAg==
X-Received: by 2002:a05:7022:6198:b0:123:3301:a718 with SMTP id
 a92af1059eb24-127598a7b72mr389358c88.1.1771401723096; 
 Wed, 18 Feb 2026 00:02:03 -0800 (PST)
Received: from C9HFQX6C61.corp.nandps.com ([130.41.236.144])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12742cbc900sm20971326c88.14.2026.02.18.00.02.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Feb 2026 00:02:02 -0800 (PST)
From: Yehor Malikov <malikovyehor@gmail.com>
To: dev@dpdk.org
Cc: maxime.coquelin@redhat.com, david.marchand@redhat.com, chenbox@nvidia.com,
 stephen@networkplumber.org, Yehor Malikov <Yehor.Malikov@solidigm.com>
Subject: [PATCH v11] vhost: fix use-after-free in fdset during shutdown
Date: Wed, 18 Feb 2026 09:01:55 +0100
Message-ID: <20260218080155.67111-1-malikovyehor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260218075016.65429-2-malikovyehor@gmail.com>
References: <20260218075016.65429-2-malikovyehor@gmail.com>
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
 lib/vhost/fd_man.c | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

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
index f9147edee7..fae6d787b6 100644
--- a/lib/vhost/fd_man.c
+++ b/lib/vhost/fd_man.c
@@ -8,9 +8,10 @@
 #include <sys/epoll.h>
 #include <unistd.h>
 
+#include <stdlib.h>
+
 #include <rte_common.h>
 #include <rte_log.h>
-#include <rte_malloc.h>
 #include <rte_string_fns.h>
 #include <rte_thread.h>
 
@@ -94,7 +95,7 @@ fdset_init(const char *name)
 		return fdset;
 	}
 
-	fdset = rte_zmalloc(NULL, sizeof(*fdset), 0);
+	fdset = calloc(1, sizeof(*fdset));
 	if (!fdset) {
 		VHOST_FDMAN_LOG(ERR, "failed to alloc fdset %s", name);
 		goto err_unlock;
@@ -142,7 +143,7 @@ fdset_init(const char *name)
 err_epoll:
 	close(fdset->epfd);
 err_free:
-	rte_free(fdset);
+	free(fdset);
 err_unlock:
 	pthread_mutex_unlock(&fdsets_mutex);
 
-- 
2.52.0

