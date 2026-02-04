Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F89EC1EB9
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 13:49:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CA3240FDE;
	Thu,  5 Feb 2026 14:49:45 +0100 (CET)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id 8073E402E1
 for <dev@dpdk.org>; Wed,  4 Feb 2026 19:40:19 +0100 (CET)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2b4520f6b32so81108eec.0
 for <dev@dpdk.org>; Wed, 04 Feb 2026 10:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770230418; x=1770835218; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x7FF8mM5O3hymmP5teOVwft8ZkwyM90IwXIqr/Haxog=;
 b=JNZL1/OS0UkyBEwkDVGgTO2ydG6pd2I7YzWotv7VnuSEiot9c9yc+6V3ECJZt431D3
 w+wLDrIUZtYYaTmddJeyAFusaQJokRtCXHBWsjgeRVT6x9SzbGVKZ9Fc/uFepWJ0py69
 59cGqT9kJqVksFP/gJCVPpCnjNobd73d8BgHAYGEeX/BESwI2UbESAgWFboRsK50W13S
 FE3eJEzg/ho+Uq/Y1WAyWhFy2FpYHhjmoVsy4zMpXspRHeW5LUBnptNzWOVPkbY1IGhT
 bzG2X4GDv9W7yvGmIMuBpnXF2bLxr6qWm42/IS5AypPmUDCr8n6J8SWrdTALXctKU5Cj
 J1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770230418; x=1770835218;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x7FF8mM5O3hymmP5teOVwft8ZkwyM90IwXIqr/Haxog=;
 b=uuTyIy/VKwv3JlvpVAZJW0uJINNxBwkV3TZZaQ1yPR4IjLGeTvMcWxfYaLuWYbjGWb
 P6Pp/Iy38ojtMYYMZntylnI5rIi5PePNFTtwOcWJOLamgxqRM56cvO34TlOL+wwu1faC
 MxymsrHZ4gcw8gXTIxbiFLcR2HkiFwA36o1Icm6nrLz9V3t6XCXoQkrqXWcowrxOxuD3
 bjqoeU/WOWrLAuUwFfEyFUi2StMAXkIQpHkRe6DpUbhTc111pWBEXjB6I4AAYIiOzdms
 gnJ1r9+QZ73LDEpzYrv9JR9/hEkG6LBfPD/JtJXFOVqorNh1lQv2fF2hP1xXXprauPr4
 wC9w==
X-Gm-Message-State: AOJu0Yy3wHWUpxoO83Qz7VvpORpZugrP9d1SKbkKJStcIsp+K/aqIzmo
 Jibr93B5TPv5xZ8Zju0ipG6VLw07TDsGIZJRRSvZiINpk9MoLPcubDBQP/xrBw==
X-Gm-Gg: AZuq6aIILxsY/2nbT/Nl6s6sU6r7H/qi6m3yhn0bDrjQR3iGKrwiCY+F8Jd6ZLynCge
 UHNtB12TAovT3W07Hw8oI6GhZjcmokqrl2KT5IhnvTQqMlwWzaZycKTIr9HXx/YXSv0+KMz3OAj
 Q4g2N9E2zV5x3sPwEgAfZZbPTfza4o05t734gF6AuPX11p2+g72eECFSmKEI+AI8VTkXGaaNGYA
 tBePUHEoAZn3jmy1YkiR9f4BndY/5yAFLrlgxMPa/Xdlv0ttgHBuUR4PLtdGLsgvTZCCCHRNp3G
 cHrYg0prqVbPEYJzHDOcPUuaTIOJmQaP0X0iCkqBPJgNYuc+sErnF3959MkpV7iK+9FXZ0+eu89
 y0j9i0e0iZiDu/Dr+JrdKfDOFjjP51bz5uM7m/0LGCRcJqbF4DIkoP7uHyHebaSIlEA9WxRxWgl
 4iNQYjOWqNmenLisGuyNhAuMWpm+4Lbq7tk8BI7OtCtgSG7Od7W4aGRdM=
X-Received: by 2002:a05:7022:aa8:b0:119:e55a:9c03 with SMTP id
 a92af1059eb24-126f47cbf38mr1649219c88.31.1770230417897; 
 Wed, 04 Feb 2026 10:40:17 -0800 (PST)
Received: from C9HFQX6C61.corp.nandps.com ([130.41.236.144])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-126f4e04297sm2558343c88.3.2026.02.04.10.40.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Feb 2026 10:40:17 -0800 (PST)
From: malikovyehor@gmail.com
X-Google-Original-From: Yehor.Malikov@solidigm.com
To: dev@dpdk.org
Cc: maxime.coquelin@redhat.com, chenbox@nvidia.com,
 Yehor Malikov <Yehor.Malikov@solidigm.com>
Subject: [PATCH v2] vhost: fix use-after-free in fdset during shutdown
Date: Wed,  4 Feb 2026 19:40:11 +0100
Message-ID: <20260204184011.8722-1-Yehor.Malikov@solidigm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 05 Feb 2026 14:49:44 +0100
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
rte_eal_cleanup() frees hugepages memory while the fdset thread is
still running, causing use-after-free when accessing the fdset
structure.

Add fdset_deinit() function to properly stop the dispatch thread
before freeing resources:
- Set destroy flag to signal thread exit
- Wait for thread completion via rte_thread_join()
- Close epoll fd and free memory only after thread exits

Add RTE_FINI destructor to ensure fdset cleanup runs before EAL
cleanup frees hugepages.

Fixes: e68a6feaa3b3 ("vhost: improve fdset initialization")

Signed-off-by: Yehor Malikov <Yehor.Malikov@solidigm.com>
---
 .mailmap           |  1 +
 lib/vhost/fd_man.c | 33 +++++++++++++++++++++++++++++++++
 lib/vhost/fd_man.h |  1 +
 lib/vhost/socket.c |  8 ++++++++
 4 files changed, 43 insertions(+)

diff --git a/.mailmap b/.mailmap
index 34a99f93a1..6fb87ca810 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1800,6 +1800,7 @@ Yaron Illouz <yaroni@radcom.com>
 Yaroslav Brustinov <ybrustin@cisco.com>
 Yash Sharma <ysharma@marvell.com>
 Yasufumi Ogawa <ogawa.yasufumi@lab.ntt.co.jp> <yasufum.o@gmail.com>
+Yehor Malikov <Yehor.Malikov@solidigm.com>
 Yelena Krivosheev <yelena@marvell.com>
 Yerden Zhumabekov <e_zhumabekov@sts.kz> <yerden.zhumabekov@sts.kz>
 Yevgeny Kliteynik <kliteyn@nvidia.com>
diff --git a/lib/vhost/fd_man.c b/lib/vhost/fd_man.c
index f9147edee7..4c759d44a4 100644
--- a/lib/vhost/fd_man.c
+++ b/lib/vhost/fd_man.c
@@ -149,6 +149,39 @@ fdset_init(const char *name)
 	return NULL;
 }
 
+void
+fdset_deinit(struct fdset *pfdset)
+{
+	unsigned int val;
+	int i;
+
+	if (pfdset == NULL)
+		return;
+
+	/* Signal the dispatch thread to stop */
+	pfdset->destroy = true;
+
+	/* Wait for the dispatch thread to exit */
+	if (rte_thread_join(pfdset->tid, &val) != 0)
+		VHOST_FDMAN_LOG(ERR, "Failed to join %s event dispatch thread", pfdset->name);
+
+	/* Close epoll fd */
+	close(pfdset->epfd);
+
+	/* Remove from global fdsets list */
+	pthread_mutex_lock(&fdsets_mutex);
+	for (i = 0; i < MAX_FDSETS; i++) {
+		if (fdsets[i] == pfdset) {
+			fdsets[i] = NULL;
+			break;
+		}
+	}
+	pthread_mutex_unlock(&fdsets_mutex);
+
+	/* Free the fdset */
+	rte_free(pfdset);
+}
+
 static int
 fdset_insert_entry(struct fdset *pfdset, int fd, fd_cb rcb, fd_cb wcb, void *dat)
 {
diff --git a/lib/vhost/fd_man.h b/lib/vhost/fd_man.h
index eadcc6fb42..c9e51badaa 100644
--- a/lib/vhost/fd_man.h
+++ b/lib/vhost/fd_man.h
@@ -15,6 +15,7 @@ struct fdset;
 typedef void (*fd_cb)(int fd, void *dat, int *close);
 
 struct fdset *fdset_init(const char *name);
+void fdset_deinit(struct fdset *pfdset);
 
 int fdset_add(struct fdset *pfdset, int fd,
 	fd_cb rcb, fd_cb wcb, void *dat);
diff --git a/lib/vhost/socket.c b/lib/vhost/socket.c
index 9b4f332f94..e953dd1849 100644
--- a/lib/vhost/socket.c
+++ b/lib/vhost/socket.c
@@ -1209,3 +1209,11 @@ rte_vhost_driver_start(const char *path)
 	else
 		return vhost_user_start_client(vsocket);
 }
+
+RTE_FINI(vhost_user_fdset_fini)
+{
+	if (vhost_user.fdset != NULL) {
+		fdset_deinit(vhost_user.fdset);
+		vhost_user.fdset = NULL;
+	}
+}
-- 
2.52.0

