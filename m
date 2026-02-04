Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB18EA7940
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 18:48:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AAFFD402F2;
	Wed,  4 Feb 2026 19:48:58 +0100 (CET)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id 03C7B402E1
 for <dev@dpdk.org>; Wed,  4 Feb 2026 19:48:57 +0100 (CET)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2b72e49776eso66781eec.1
 for <dev@dpdk.org>; Wed, 04 Feb 2026 10:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770230935; x=1770835735; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x7FF8mM5O3hymmP5teOVwft8ZkwyM90IwXIqr/Haxog=;
 b=g1rfYr5cssmVy+FEUwMSe2DODmNVzVm6O60c2P0YyR5A54xyghsvzkw+hQE46xSVCx
 /I6s7XIVJyBMRyQq/HdfPBdLf4OdKeVxBrAjSmC3cy4yBiontaoG0BZYVlKLNZZlRCdI
 8gsO3ulVEuHRw1mlsb/142CPTXQDMH8fYlyQXIlnbfs7RuFRhMHFj2gbhchYtoXZ368v
 WZ7snj//NkHyGB44IWibeXcKIHVgP1EXiQUnQuExrshSYpMuKw6trZm1sWXmRxuMsoTP
 2GFAe7/yGFeOdOACELEdmpdEB6EieDhsLry4AJSe7ZJT6FZTpWoy56EH0QARrW+tzoj3
 hT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770230935; x=1770835735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x7FF8mM5O3hymmP5teOVwft8ZkwyM90IwXIqr/Haxog=;
 b=NzGtQZ6UKd8e0x9e+tUc9pcwa7ZSg1AbQruV64gHWTNrK2VCPEfQQnaFTPVvrrfKBR
 /wa3Bq6mfd9iCfmEFMIk3Yf6rHMxoLd0zgIktPG2JJ+tBn8oHHQiiGNr5YxXoB7RfA1B
 rTmpt0Y6R3TfNxu8LNG0vbubrnBfraNDA0jCo80MQ/VGoUoNcXOLYNI9vfjeLA4NuC8p
 68+YO/MqsAe3TagkVuJ5ASUIXLXUSjM8a0yDdFwBKJk8OECnckeZeaZ2RGS/tk7qtl5Q
 Z5sLRv2m91f6hpOR4xRxVdy01V8cOE3HuTaQAhwatTpBTI3UaE1c6PeNjVly/F58KS+a
 QPQA==
X-Gm-Message-State: AOJu0YzylXglLBotfRRK0lxM+kcooYXrpg4CinQUpgO4FN4R2ZVRC6E0
 wh0jXxx77Us1JSqnmoIi5MkjDG5/1rfjxYdgB6eKVFoN43lQA/s9aemRXc4KTQ==
X-Gm-Gg: AZuq6aJ4qNm5hdTrKI0IPKeBmr3omKWQ9QvK/oi0nmNLTNjRMD8dGcHeZKcb1mQPYos
 thv8b3dC9Ig2mvoLcw0zoM/r8Fz0wiJNcjotLyALWcwZ2aDlndGYOMb88P++C2Yrgb4EOHAiB9K
 WAuKRK6zpEydFXkrPR7GEDbmlElhQg0ie9K2z9RJZKnxFfIx5tKTRklCgwDasC4R/H7iyAtpnim
 aE5knS/m3FmVbh8QG+x7PVWqRj79WLgpRyPj9ZyFi05nqw07EnVXuQhxhtyrMZqEok8a3ylL7cB
 +osMNIqF2txARGULwmTcQP0q61bs7aVwaF/yzpH0Evpi5Z8ZEcXOz00y1gbi9Iz2UZc6QfhPY2e
 rvwbTSHLLkIOzPFcCHxXbZPKNNkutZTYVnArQ5XI0xwWlx+q6EPJWWqtXXNCaeCH5+Uurl1+zNU
 lxl1E345uBz0WO4fBLPWqdusEygeE4ocu9MdF0Yd3UftEwY0DnXFTQYRM=
X-Received: by 2002:a05:7300:dc86:b0:2b7:97a:75fb with SMTP id
 5a478bee46e88-2b83289d5ffmr1810812eec.11.1770230935441; 
 Wed, 04 Feb 2026 10:48:55 -0800 (PST)
Received: from C9HFQX6C61.corp.nandps.com ([130.41.236.144])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b832fd62acsm1930019eec.30.2026.02.04.10.48.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Feb 2026 10:48:54 -0800 (PST)
From: malikovyehor@gmail.com
X-Google-Original-From: Yehor.Malikov@solidigm.com
To: dev@dpdk.org
Cc: maxime.coquelin@redhat.com, chenbox@nvidia.com,
 Yehor Malikov <Yehor.Malikov@solidigm.com>
Subject: [PATCH v2] vhost: fix use-after-free in fdset during shutdown
Date: Wed,  4 Feb 2026 19:48:48 +0100
Message-ID: <20260204184848.9104-1-Yehor.Malikov@solidigm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <DM3PPF6AE862AC6D49FBCC8B8702D368CD19798A@DM3PPF6AE862AC6.namprd10.prod.outlook.com>
References: <DM3PPF6AE862AC6D49FBCC8B8702D368CD19798A@DM3PPF6AE862AC6.namprd10.prod.outlook.com>
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

