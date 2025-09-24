Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31113CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 16:55:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2FF340A6B;
	Wed, 24 Sep 2025 18:55:34 +0200 (CEST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id B545D402D8
 for <dev@dpdk.org>; Wed, 24 Sep 2025 18:55:32 +0200 (CEST)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-85322d9c606so11913585a.1
 for <dev@dpdk.org>; Wed, 24 Sep 2025 09:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758732932;
 x=1759337732; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qxrQ09gOfpKoXWY6NtrYBJm5itshbThDudcwx/NV/eI=;
 b=BGL5RzdJmXTT8py/Gt49XO9t1SOTbV/UEz4XukNvp8rBGAfdMxbSM5U4lPB4u+1ShU
 CGLUyHG45zR/zsrZiZimQ3FpS8nxthhZhogDOieKA7sBeK0ZA7WpcImhrcs/tFLgawd/
 4QoWx5creVO9keh42zCL7l3azuKzhh/p0lSlwzWXFbAZr7ABT7xaejTu0D+rRSaL81eP
 HxxsHXto4a1vXKZXAaSSBqqLQR6ZiJwwX+bVH6D50herozjSYnu4wmFRsEDKRv2xnKjd
 7kxdkAIdpwCWwinQdOPw6OrZOvb/OPnCdnERA/6jzUPawYEJQ9qgHWL5/IHTCNPT2MJZ
 MNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758732932; x=1759337732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qxrQ09gOfpKoXWY6NtrYBJm5itshbThDudcwx/NV/eI=;
 b=WmaU/3lzh+kOQGZIHDqNW5Mi578xHQ6xzCxPs22OStsXRJE2d3tlNngKxzuXSnvwK4
 XT4hj/Zqnam+ecmsmCNF1NYiumLRLU/j/XLBFPJne0P8VUqyit1bL0VI5UEyiL2vngbb
 DJXO0sRDGis4wbDMIg96I2ZxKPYz3ADumjtLINYXk/TwxsifH2k9t507M97Uy7Ad3GNR
 2xOSujjsEXONQIdhcYyCCtiSbNNcCdS58INavFbsoj4+GXQdN/GrbQRs3Mn+/B4oGqHw
 kHXb1Ep6cVHzVvyq+F0UFx2beyZR+A1ad7XdVemaoqvywc+c7nc4tQ36Zo1vm4OKThx+
 an8w==
X-Gm-Message-State: AOJu0Yxm9aK3LcekDF08HIFDVXgUGc8jZk8meGykH/2dLgvReA5YwSDs
 5vEZRzpVJfGxcoBeW3+bfMaYa4aNQZsPR87DduZM5Hs77LSM9jMgJcjJsbPN81l2jHk3NfOHyZw
 Pmgo2
X-Gm-Gg: ASbGncvzzJqTdIz9hCti9ngoq5Xt2et3S5L5vuieIuD6ZPdUrhNyiBNXp4CHb1cU6Lk
 bYSteBeXv9WWTdyHsbFwxWahCgMpw7bEyBnPQDdCuPUfQ/dpvqT7kl+G3twe4+75UwvNA54af+M
 gBzTPI0h8KKvUSoTocNRElJGtOZhaRF6F+nXWSluI8gf6tsZ9K9oQxQkG80XCMoNTXcKMA/so9T
 pZEqwx//FJ2vhqwXeBXopQ1KqJwQSk5IagRZmyg9gLASL86xIhEBmhydvOVXXXmYrJCuK+fWsJ5
 JXoYItIbCIvx9+t8q6eW1ovmLr4c9oE8A4H54ckzwIgKO5QdJUNYdrqHMibdJ/PE4haDpK8weWL
 nqzeNQVhBpBnn/5mn0W/FEAHBOm7SXoOuuX/DEWXXJeX5/0yJ4/d+K/Y1r46UpLyiWTFuzhsY
X-Google-Smtp-Source: AGHT+IEaRIHYfQLqXSyBYWseVxleoBw7fXH45OADTOJltgpewpNyzRM9tpYdkjW+BogCL4O8vDp2eQ==
X-Received: by 2002:a05:620a:2589:b0:84a:7191:6d11 with SMTP id
 af79cd13be357-85ae65dd9fbmr47326285a.52.1758732931800; 
 Wed, 24 Sep 2025 09:55:31 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4bda15f91a0sm106052751cf.1.2025.09.24.09.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 09:55:31 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [RFC 1/6] eal: avoid using pthread_cancel
Date: Wed, 24 Sep 2025 09:51:08 -0700
Message-ID: <20250924165527.268645-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250924165527.268645-1-stephen@networkplumber.org>
References: <20250924165527.268645-1-stephen@networkplumber.org>
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

The multi-process handling thread can be managed more safely
by closing the underlying socket rather than pthread_cancel.
Closing the socket in the main thread will cause the read()
in the MP handler to unblock.

The use of atomic for updating the socket fd is not needed.
The fd for the socket is set before the thread is created
and not modified again until handler has exited.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_proc.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index 0dea787e38..8e60e815ed 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -34,7 +34,7 @@
 #include "eal_filesystem.h"
 #include "eal_internal_cfg.h"
 
-static RTE_ATOMIC(int) mp_fd = -1;
+static int mp_fd = -1;
 static rte_thread_t mp_handle_tid;
 static char mp_filter[PATH_MAX];   /* Filter for secondary process sockets */
 static char mp_dir_path[PATH_MAX]; /* The directory path for all mp sockets */
@@ -406,17 +406,9 @@ mp_handle(void *arg __rte_unused)
 {
 	struct mp_msg_internal msg;
 	struct sockaddr_un sa;
-	int fd;
-
-	while ((fd = rte_atomic_load_explicit(&mp_fd, rte_memory_order_relaxed)) >= 0) {
-		int ret;
-
-		ret = read_msg(fd, &msg, &sa);
-		if (ret <= 0)
-			break;
 
+	while (read_msg(mp_fd, &msg, &sa) > 0)
 		process_msg(&msg, &sa);
-	}
 
 	return 0;
 }
@@ -656,7 +648,7 @@ rte_mp_channel_init(void)
 		EAL_LOG(ERR, "failed to create mp thread: %s",
 			strerror(errno));
 		close(dir_fd);
-		close(rte_atomic_exchange_explicit(&mp_fd, -1, rte_memory_order_relaxed));
+		close(mp_fd);
 		return -1;
 	}
 
@@ -670,15 +662,11 @@ rte_mp_channel_init(void)
 void
 rte_mp_channel_cleanup(void)
 {
-	int fd;
-
-	fd = rte_atomic_exchange_explicit(&mp_fd, -1, rte_memory_order_relaxed);
-	if (fd < 0)
-		return;
+	/* shutdown() will cause recvmsg to unblock */
+	shutdown(mp_fd, SHUT_RDWR);
 
-	pthread_cancel((pthread_t)mp_handle_tid.opaque_id);
 	rte_thread_join(mp_handle_tid, NULL);
-	close_socket_fd(fd);
+	close_socket_fd(mp_fd);
 }
 
 /**
-- 
2.47.3

