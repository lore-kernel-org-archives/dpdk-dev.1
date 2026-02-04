Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAFEEA7942
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 18:43:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2834402F2;
	Wed,  4 Feb 2026 19:43:05 +0100 (CET)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id 8AF4E402E1
 for <dev@dpdk.org>; Wed,  4 Feb 2026 19:43:04 +0100 (CET)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2b740872a01so70111eec.1
 for <dev@dpdk.org>; Wed, 04 Feb 2026 10:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770230583; x=1770835383; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x7FF8mM5O3hymmP5teOVwft8ZkwyM90IwXIqr/Haxog=;
 b=DyWGfmH8IbTnlL/Wb/8O6IxfjCndZ3zuc9k1FRBXllms1H2Q6uYe2Z+S4kTykqoU/F
 kmz5YxBhQFJDP1SpDyn5zvMIrnOLzs05yADR1Izt8WT2lYvMdln7+6VntG3Wn0dvyThl
 HuUQ7jPYLHgbGRZCwQj/f0jd8mpD1PUySioou1/GbTJS10I4IX1jeniKMPqiblMd3+m2
 9q1FAW5KubZACyRi9JwmgE3HYHmYQXv+yZMV6MTKf8o/w9noOjASb021uGagy5IG5hOo
 aoWon7BP57spOZaR4/g2qYCAO4bWriQWmlvoKBEElJx7QLL95H1og65UazAyvtPUxA1F
 rgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770230583; x=1770835383;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x7FF8mM5O3hymmP5teOVwft8ZkwyM90IwXIqr/Haxog=;
 b=MCsVd5V+3MEwuLxpCEuWUxW0Xbz0CqsrNDLejQy29R7rOXy8s4rp51gzRXDHKkUBfP
 HMW7Dqnng2iwd9WqUmmfwVXlo6cgxk6lYkrM/IBhqNvoW0usxJJ9nlFp0TCebLNFPsVP
 9DJxyEqxum/JCPKyquSA6kNJbzBMiCX1xesL7bLXekjNwcyWCNw7MZHEsk8qNlkWhkv6
 Z7Y6+LvrCz3NETOmnziY9K3goXuK90wmorbBCFgDZ2BPWuxC6APrNIw/i74t1WHkatAo
 q9QuiG6RJHd5/dhw+XmbVX2ygw3Y7DYRhz6hh5xs7y0QWiJeTxcxQWcpfFnpmT5dDAX+
 GAsA==
X-Gm-Message-State: AOJu0YwtcWblB/er3l0hz7T8SbynEpyG02if50krISTQNboP8gVGvDvD
 o1SQNRTUslPzUMcHWYiwuvAGV872wNs0zC4/Fcin/rniI6pci46tJCxKxYAg7g==
X-Gm-Gg: AZuq6aLOrvzwg99I4YnGu0rNEMrI0vDGZ7VBrrFSV4w+jFkfCvtjmaakHPgkU+kRYY0
 T/bLMGmrbmf84ZLSMjfgVa5jUDoeG+hvmj/h7WFVSF0dkTctp7rzdE32ktf0ARtEbntGO7V13ap
 2CfllwlIL9QgFbnX09vA9k+WcidZeSyYq+Ck6f9z3wo7WENf0te4WDIaYa/UIKYJXOodnr4wOdb
 mQBY/6NGO9rmWbKMNW0yNuWMlhg66l/0eXcS1oNTiYSppcAZy2EcOGOgwvv9RDBJZ/8eavfVb6l
 injQt/CV+/POK2zrLi3I8ZBSZirogeKPDPPh+CN+UUfeg1BCKYfwGavTeyjIzU3Q+U+493okZW9
 Pd+eK3TV8kAo7NYlmFIJVV+y28V43iFoNwc/K6ObUiE4zU6Iv15pEI0fsBFxCRY/jMl20ZYy0iX
 xCEA5+MArvaY5oIfAH30aQ4rrOlw56En7DSnz1ff1J7F0dGtBaUKqUThk=
X-Received: by 2002:a05:693c:3618:b0:2b0:542a:227d with SMTP id
 5a478bee46e88-2b83287d775mr1923014eec.2.1770230583002; 
 Wed, 04 Feb 2026 10:43:03 -0800 (PST)
Received: from C9HFQX6C61.corp.nandps.com ([130.41.236.144])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b832e12845sm1988998eec.5.2026.02.04.10.43.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Feb 2026 10:43:02 -0800 (PST)
From: malikovyehor@gmail.com
X-Google-Original-From: Yehor.Malikov@solidigm.com
To: dev@dpdk.org
Cc: maxime.coquelin@redhat.com, chenbox@nvidia.com,
 Yehor Malikov <Yehor.Malikov@solidigm.com>
Subject: [PATCH v2] vhost: fix use-after-free in fdset during shutdown
Date: Wed,  4 Feb 2026 19:42:56 +0100
Message-ID: <20260204184256.8809-1-Yehor.Malikov@solidigm.com>
X-Mailer: git-send-email 2.50.1
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

