Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1DBCD98C7
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 15:50:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D92414332C;
	Thu, 11 Jun 2026 17:50:15 +0200 (CEST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id 210354331C
 for <dev@dpdk.org>; Thu, 11 Jun 2026 17:50:15 +0200 (CEST)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-45ee5cdbd28so726889f8f.1
 for <dev@dpdk.org>; Thu, 11 Jun 2026 08:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781193015; x=1781797815; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=No0224kbL29x41lqqXsAifHyVLhb7rbMhZbUBraefIg=;
 b=majOL+qRXdyEm7UKKXiRpcJSELNWwX/T/rKDjyLkiRBjpsgvzrbIhMnFpHuj3XLZtm
 X5hdEl+0xONHkiJF4ymYmHDYmnx3vzM91mRAD3P2tyro89Y6NFLYBhCGLUCeCZJSZr1P
 +vhs0BW/11UDFiOVZAbPJ4b/7C7MO1dhoOV5lbwGi2QxlEHAE9PH9JlXJhIwDOGqvh/7
 nKL/H1GigSbgX8Ck5SclM2gPoNxMSmTTTvuJBny+BOuVXZkQwHVVpSl5aWjRsrD39IwW
 M7eKIvrSBuyq60rpMFukq6XgorCPjoVKFADUdaQCt3yc1HJBOUd1LdT4BU7+QnKglBSr
 Fe1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781193015; x=1781797815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=No0224kbL29x41lqqXsAifHyVLhb7rbMhZbUBraefIg=;
 b=sQQDHgNE9quJRrwImE7QOqDz7MC+t4P/fE7iRI7Ea32jXlF9n+JCw+9lcmi+Yb7N0F
 nW6WwL/jpDxhJmWyhNKOrPrS8qJQpd5dmawylXbysmVEvVTufKLxDWS0aKoUL5jATCrw
 xJ//qruEOSOAbOGMB/O7Nk2qdk429hDuMFjj4CsUz5nwTWBv3XV69/onmdr7AkhyjIr8
 dudg1V/J3bxrQ+5rzr/ZfBFlSJ/zgW+MlgDVu70d2b5Vd5mlrOzpRr5Og3G7qRrc/kEW
 XGcG4HhapyXZmXEhH8yPQSMiNdRgu/BkRzFNXbV+9xVxeOqiR9ZLit490w9qURJ+Etl2
 l8cA==
X-Gm-Message-State: AOJu0Yy2sI5n8X0AsoU4BZO3uA/uzKiErwaziJDWT+c1DdxzbsMovQMu
 57T4Cq2R5Yp193HF/3Lg8X0lUGFxRRNBAnUAGvC8iBhrnxxuTcRBO73C
X-Gm-Gg: Acq92OHdABFw7YEdq/pogCGx4adPr9u2J9urZGYbtMqE+TdGsfSZAmibA51ACcO2axR
 JKwMYgDxdVAEwODrlh15x8hyXnRiNidqJZA13yorUwQrWpHNcglpCdw7+7ebTLb0t0YsRN9oEus
 vRBCTLWIHI4G3QrMQaC12OnfdNfH0cWASCxm+SwtYDgc1w9arnFKB0dU7MZsbdCZSFu4A7+njnf
 6RCE+U90w+CEuaVKQ8Mk2l1QxdkZFxNahlkmonkQ7Fk/llYMFL6J/v7y0r4BOzgZ4MqLn3Mpqnf
 bNUA/7vBGHWyejHCoTyHdBRKpklP5qlUZm+S5BkeQYuMHiB5fzRSpLjID+iQhoCC8XO0DCmbwLj
 kS5GAgLQ5TN4O3XT+fuBGPz23ZZ1aB2D5VNCvh61IG1UdLWcqi+XknPlujT24bf8xSdhO6P6ebC
 0nkkBRBlO4DH9ROJ1o9TUhqiAYeo+nluxCKTyJDMuBXP5XjlxgKtpQMr8TDsI1dDA=
X-Received: by 2002:a05:6000:22c6:b0:460:d18:865c with SMTP id
 ffacd0b85a97d-46067bd5376mr5002337f8f.1.1781193014495; 
 Thu, 11 Jun 2026 08:50:14 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f2710sm64190064f8f.14.2026.06.11.08.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 08:50:14 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: hemant.agrawal@nxp.com,
	sachin.saxena@nxp.com
Cc: dev@dpdk.org, Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org,
 Harman Kalra <hkalra@marvell.com>, Cunming Liang <cunming.liang@intel.com>
Subject: [PATCH 2/9] eal/interrupts: keep real errno on epoll error
Date: Thu, 11 Jun 2026 17:49:17 +0200
Message-ID: <20260611154926.392670-3-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611154926.392670-1-maxime@leroys.fr>
References: <20260611154926.392670-1-maxime@leroys.fr>
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

Some interrupt users have several vectors backed by the same eventfd
(e.g. several Rx queues behind one DPAA2 portal eventfd). Adding the
second vector to the same epoll instance then fails with EEXIST.

Upper layers such as ethdev and bbdev already treat -EEXIST as a
non-fatal duplicate registration (if (ret && ret != -EEXIST)), but
rte_intr_rx_ctl() lost that information: rte_epoll_ctl() returned -1 and
rte_intr_rx_ctl() flattened every failure to -EPERM.

Return the negative errno from rte_epoll_ctl() (its documented contract
is already "a negative value") and stop rte_intr_rx_ctl() from
flattening errors to -EPERM, so EEXIST reaches the upper layers that
already handle it; other failures carry their real errno.

Fixes: 9efe9c6cdcac ("eal/linux: add epoll wrappers")
Fixes: c9f3ec1a0f3f ("eal/linux: add Rx interrupt control function")
Cc: stable@dpdk.org
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 lib/eal/include/rte_epoll.h    |  3 ++-
 lib/eal/linux/eal_interrupts.c | 18 +++++++++++-------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/lib/eal/include/rte_epoll.h b/lib/eal/include/rte_epoll.h
index ae0cf20853..0c7b510563 100644
--- a/lib/eal/include/rte_epoll.h
+++ b/lib/eal/include/rte_epoll.h
@@ -104,7 +104,8 @@ rte_epoll_wait_interruptible(int epfd, struct rte_epoll_event *events,
  *   Note: The caller must take care the object deletion after CTL_DEL.
  * @return
  *   - On success, zero.
- *   - On failure, a negative value.
+ *   - On failure, a negative errno value, e.g. -EEXIST if the fd is already
+ *     registered on the epoll instance (a fd shared between vectors).
  */
 int
 rte_epoll_ctl(int epfd, int op, int fd,
diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
index 5d0607effe..4cfaeba7fe 100644
--- a/lib/eal/linux/eal_interrupts.c
+++ b/lib/eal/linux/eal_interrupts.c
@@ -1443,7 +1443,7 @@ rte_epoll_ctl(int epfd, int op, int fd,
 
 	if (!event) {
 		EAL_LOG(ERR, "rte_epoll_event can't be NULL");
-		return -1;
+		return -EINVAL;
 	}
 
 	/* using per thread epoll fd */
@@ -1460,13 +1460,21 @@ rte_epoll_ctl(int epfd, int op, int fd,
 
 	ev.events = event->epdata.event;
 	if (epoll_ctl(epfd, op, fd, &ev) < 0) {
+		int err = errno;
+
+		/* the fd is already in the set (e.g. shared across vectors):
+		 * keep the event valid and report -EEXIST, not a hard error.
+		 */
+		if (op == EPOLL_CTL_ADD && err == EEXIST)
+			return -EEXIST;
+
 		EAL_LOG(ERR, "Error op %d fd %d epoll_ctl, %s",
-			op, fd, strerror(errno));
+			op, fd, strerror(err));
 		if (op == EPOLL_CTL_ADD)
 			/* rollback status when CTL_ADD fail */
 			rte_atomic_store_explicit(&event->status, RTE_EPOLL_INVALID,
 					rte_memory_order_relaxed);
-		return -1;
+		return -err;
 	}
 
 	if (op == EPOLL_CTL_DEL && rte_atomic_load_explicit(&event->status,
@@ -1518,8 +1526,6 @@ rte_intr_rx_ctl(struct rte_intr_handle *intr_handle, int epfd,
 			EAL_LOG(DEBUG,
 				"efd %d associated with vec %d added on epfd %d",
 				rev->fd, vec, epfd);
-		else
-			rc = -EPERM;
 		break;
 	case RTE_INTR_EVENT_DEL:
 		epfd_op = EPOLL_CTL_DEL;
@@ -1531,8 +1537,6 @@ rte_intr_rx_ctl(struct rte_intr_handle *intr_handle, int epfd,
 		}
 
 		rc = rte_epoll_ctl(rev->epfd, epfd_op, rev->fd, rev);
-		if (rc)
-			rc = -EPERM;
 		break;
 	default:
 		EAL_LOG(ERR, "event op type mismatch");
-- 
2.43.0

