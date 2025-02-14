Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15F9C021A4
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Feb 2025 17:22:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5914140A71;
	Fri, 14 Feb 2025 18:21:55 +0100 (CET)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 6C5944067E
 for <dev@dpdk.org>; Fri, 14 Feb 2025 18:21:52 +0100 (CET)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-220d601886fso31102495ad.1
 for <dev@dpdk.org>; Fri, 14 Feb 2025 09:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739553711;
 x=1740158511; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D1GXH9VXd0owb32qRKJE3Gdw4of2uF3ErSKi+1agzEo=;
 b=x5YQoLI1h5+dnKZt1b4kVMrj/uIdgyOzW5a/DZeMmpy/537XLRe0z1j3g7bZRm9067
 H+TiTd8sh/gxAB6afCIoLMBGzk1OiFcpOLYIZnEoPTEu4Z5M9/HI6iWz9YMaNZMXSAt8
 It1DBAuPVGM0d9TtqsfsQ1+jzUge5AC6xXHOOLa631qLLbwYk6ubmkzN+GMDeCMjSFKv
 UnKufHSu5S+cxOk7fqQ7Wi62yAR5RVuUnNwRoukUJQSn/DJut5rAAZJkD+PYSRpjiLGi
 vwoD5bC4UvG2H2jW+nZScV/4h5isQRw97YKSdf/Bwxygh1ydqBzO5ib1FoJXB7mPsXRt
 Mm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739553711; x=1740158511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D1GXH9VXd0owb32qRKJE3Gdw4of2uF3ErSKi+1agzEo=;
 b=TOxxHPm63XkG9mAU605cnQlX1/L/zCVl/HS+szYTP2u/zj7TVsfDXrbnoSruStNzso
 3LFIFU/k5UHR2WecUBFQrSvO6EGW9rQhh1RH9NbxcZ3DeVGzDyIhAeBTkbP6X/XSeu5A
 f5C7wyDlMysbMKfzKS+zLLY39cSzjHBm1I8gNwrpmPwoPXbxiPW9M+2bZS4yPbe5RP39
 amD1pTQg5UbBDBPiu1timBCHX5QU8rA9xvI0mrX4BFTw8ZGfrQNSLQcTfNBo7prfYqd0
 HlCSxY41HbcBXA+ej0dvd9eg9k0nWPtyqwxszcblF0OqWWi9i8269JV/Fah3FsIet6zO
 cFYQ==
X-Gm-Message-State: AOJu0Yw4j1rSGVYkKzeM7CypVBxYIyWHbDOiN43n/HkM+YJSSRRx08FC
 b8ew3v4sGotMI6c7xMI0XptKoDs+1FZqzfBPqHNvg9M2KdCeSASt2U8IOHT1CLwaIXOLXD/fTL2
 4kkg=
X-Gm-Gg: ASbGnctLzlGR+QwXEygpr2vqrlV3QO8aKRcOmgPs7y463LiXvfo7nK4XgtLJ11HlDCW
 qWCbgSDPbbNLnosVBjtbC0b9hW6/H4lKWvq+g9NxAxgYpgJh04u3yVob4DZZdH+fPyLP6niXfOg
 tspaDnd1sPxgfVzYuegz0sJhtfFwxxMYzliES8Io2BgQC7JV7K7tQ8kWG5AxZ5NKGuAGhpUyK46
 m026UJrPRYTsKLE89wnqEpQUXPtaKRHKmxPDq6q8JvKxk0u0HQWuHKXrlcrDRqVV+XknZo2iJCz
 yOYbdZsQcbL8BsGgxRZu/QHdXj/kzgzDAlV4H7G15+bNqNp6d7JcpBC5uoEPCE8daRsk
X-Google-Smtp-Source: AGHT+IHFkXka/vWXG41GEkvf8IE5Rkw92zTI4yHGBzlJvWPPp8xJwSjQdn1HAC3/+URibDe68nAAWQ==
X-Received: by 2002:a05:6a20:1586:b0:1e1:aa24:2e58 with SMTP id
 adf61e73a8af0-1ee8cb1f646mr398405637.7.1739553711645; 
 Fri, 14 Feb 2025 09:21:51 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb5a52af8bsm3134264a12.50.2025.02.14.09.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 09:21:51 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v2 6/7] vhost: replace open coded TAILQ_FOREACH_SAFE
Date: Fri, 14 Feb 2025 09:20:14 -0800
Message-ID: <20250214172134.73908-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250214172134.73908-1-stephen@networkplumber.org>
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <20250214172134.73908-1-stephen@networkplumber.org>
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

Proper macro is now in EAL rte_queue.h use it instead.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/vhost/socket.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/lib/vhost/socket.c b/lib/vhost/socket.c
index 4c6c551c3d..dc9c9da9d1 100644
--- a/lib/vhost/socket.c
+++ b/lib/vhost/socket.c
@@ -10,10 +10,10 @@
 #include <string.h>
 #include <sys/socket.h>
 #include <sys/un.h>
-#include <sys/queue.h>
 #include <errno.h>
 #include <fcntl.h>
 
+#include <rte_queue.h>
 #include <rte_thread.h>
 #include <rte_log.h>
 
@@ -456,14 +456,7 @@ vhost_user_client_reconnect(void *arg __rte_unused)
 	while (1) {
 		pthread_mutex_lock(&reconn_list.mutex);
 
-		/*
-		 * An equal implementation of TAILQ_FOREACH_SAFE,
-		 * which does not exist on all platforms.
-		 */
-		for (reconn = TAILQ_FIRST(&reconn_list.head);
-		     reconn != NULL; reconn = next) {
-			next = TAILQ_NEXT(reconn, next);
-
+		TAILQ_FOREACH_SAFE(reconn, &reconn_list.head, next, next) {
 			ret = vhost_user_connect_nonblock(reconn->vsocket->path, reconn->fd,
 						(struct sockaddr *)&reconn->un,
 						sizeof(reconn->un));
-- 
2.47.2

