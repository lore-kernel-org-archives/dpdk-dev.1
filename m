Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43168EA7941
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 18:58:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5014D402F2;
	Wed,  4 Feb 2026 19:58:11 +0100 (CET)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 7431A402E1
 for <dev@dpdk.org>; Wed,  4 Feb 2026 19:58:09 +0100 (CET)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2b785801c93so120298eec.0
 for <dev@dpdk.org>; Wed, 04 Feb 2026 10:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770231488; x=1770836288; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x7FF8mM5O3hymmP5teOVwft8ZkwyM90IwXIqr/Haxog=;
 b=l8sz2ff9GomG8yXB53xYnG+HlWA7BbCZrLv5u3NVj+TILVNFGj7Yc1B8b21bMmlPXZ
 6a9AxLH3CwU1Gl78HrLHNhn6THsR6XL7Nd48lOCzn4DH5mf6zpEXIhis6koBqRO9bl0/
 F1fI8LQRfaJSjaFJLhr0NOO56W1d/OPXF7Kybj+9b9uX45gsHKMn34aWfXFcFilV/gso
 zRxIykrrKC/3w9XBatau3Zyy/axQJEYWMcu/LhH8ef4Kr5Yg3g/GRwUJPiT8emGdO/nd
 isMgS+2vD+Vc1hpSltD53v1AilfwGDrR9VHXRFIX0cmmVrQYjfcBMrzAbm1Y52nO7OHH
 hBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231488; x=1770836288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x7FF8mM5O3hymmP5teOVwft8ZkwyM90IwXIqr/Haxog=;
 b=FHp6EFoqnYRnXYOj0dq5ifKdVvxdf2nxLYBKEBGb47oKyogV48K9wXpOGYwlCDw/Ws
 YU8iM+Fs7A33EWHhtqPYsRjACFeA4u0mJODcr5yBE4skYSk0wEt34prAjliy26aK9m8Z
 bg9hl3uteTle1jyyFleTpMzkaDKsokolHhTgG5jGJrugt1OkkmJqbKg/1bjdx8Ly4/Hy
 BOSAau8uMntwndI4Pk2oaLv9dlhhgL783JMLqLrgGyfBCO6JA7gz6lF8mV//XKFPV8fa
 sa0BiPfOmHislzQLWt9fuyK4S1/S40xXIe8xrm0cqVrKcLzWdkfa8VwK2btD8L/uIIZX
 zkXQ==
X-Gm-Message-State: AOJu0YwVOvyvqtZTqzNkAVNX2n3OV+RZpRdE2cegcGdJsohVVceWRSRh
 bAFfDLXsY0bRTY6jk7OHSCOcOG8kQtOpd6EyNjKG/gGSrXuMHGscG96czWAcYQ==
X-Gm-Gg: AZuq6aJCL9tnlNWT4EOtOTdd0znoqCe0/1wiCw2om/OEXpljrk2rByesUYjcN70VxKo
 HvN6npqA0Dojhrl1Xud8VdV2PFnIXllC8M2AhLL2WTfslVrwiwKJgMaf+xxeS6/2HXaL1WIZD9X
 Ay1hlfLvAtpGBlqw64GtdfIOQbetBW8YjPxX89nhjGP3uTNsyyLjjW8HQ1EJ5QZ149U5XEhn2PT
 Zh/IVkJavS5LKsLt1VnzQf73Ddyc1coE9lc1eNxYJiFufjSqgZd1KcSabWAgWyg0xWVLHNoPNax
 riHoal9FCo8qlV8HFQ6ab3xYnJ9JIhyvN5b+7S3XJeSdzMmYY+zti8zbRZdXwOdCUqn5RcibC9D
 Q7CCx8PyBuo+jXiLJWcPg1S2tGvQxGwzLKi3veIdBiKM41jnUvIeuKe3OAg9CgSH5wHMZUnK0CP
 0c29bJEvAHVxfZOOo+L8WtpcLhST5c3Pc16LUA52RbvmJvlGMUuA==
X-Received: by 2002:a05:7301:1e89:b0:2ae:55ac:3ff6 with SMTP id
 5a478bee46e88-2b83287d3b0mr1475781eec.1.1770231487881; 
 Wed, 04 Feb 2026 10:58:07 -0800 (PST)
Received: from C9HFQX6C61.corp.nandps.com ([130.41.236.144])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b832f93808sm2090744eec.19.2026.02.04.10.58.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Feb 2026 10:58:07 -0800 (PST)
From: Yehor Malikov <malikovyehor@gmail.com>
To: dev@dpdk.org
Cc: maxime.coquelin@redhat.com, chenbox@nvidia.com,
 Yehor Malikov <Yehor.Malikov@solidigm.com>
Subject: [PATCH v3] vhost: fix use-after-free in fdset during shutdown
Date: Wed,  4 Feb 2026 19:58:00 +0100
Message-ID: <20260204185800.9299-1-malikovyehor@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260204184848.9104-1-Yehor.Malikov@solidigm.com>
References: <20260204184848.9104-1-Yehor.Malikov@solidigm.com>
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

