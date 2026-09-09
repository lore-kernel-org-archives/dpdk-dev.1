Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47907C79FB7
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 15:05:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 940CE4279B;
	Wed,  9 Sep 2026 17:05:08 +0200 (CEST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 83BA842796
 for <dev@dpdk.org>; Wed,  9 Sep 2026 17:05:07 +0200 (CEST)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49cf4f81d86so46909055e9.2
 for <dev@dpdk.org>; Wed, 09 Sep 2026 08:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788966307; x=1789571107; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sln7w9ZFvApkVEmMSurikqJuzLqQgGMUu3SnUouNrp4=;
 b=SNVJr+V1f7MVi8tAoIhFxKJOGkQ18OhTykWVmjvUp49BNsF/ZaXQOVV8xXkfrQ/t1w
 jLBrOgAgjho/pvSzWNqfDLWmAJx/iQxbXFmnxRDfEHnrttAITpx6hLr/8AQwd3sk8lsX
 q6wA4GK3QSRH8zWDrL9N3M505KDMI3IDqW4Lo6oltBs7rzHt/OmWpB1ENr5vW4LmGRuw
 mMZM4DSUAoYl54Z8P9mw4xLfb4CmLM/GRmBaS8c5T47RWrK4TDa6wWT7su76buf+3JLz
 XUkDbLqXhY8eSb4YIX6CQoUawTP9/OkPUirzb7EcPiP929wMNvv2XkBONNuLT46EBGK2
 Rd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788966307; x=1789571107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sln7w9ZFvApkVEmMSurikqJuzLqQgGMUu3SnUouNrp4=;
 b=Ctp0PtK8QVAl/z6qIU5MXzabmfbQSYZ2ZLJLjqbLPsQvHvU7q6Xz9Kh1H/OjzDXj8O
 gO68j+J7JD96T3aezGS2/TU88wGohedvoRKNa1730OjqeOlGJ35zjhVsz740X4Dq31Y2
 y59lkVqWxBfj40w3vYojmivaXU01TWVH29MwB69Bj45nF6xsBYAlKgZ3YlkxVxCskFxb
 pXuwEDPEx4P1DmHMrsRn2s2Y84FrmQgTBoeEBIniTk+0kiZWpdIMO3UGlcNocxVLugmU
 QSd7rjUv7Ek/QhebOyc+J/0sY4NWR0MBcAYcF9QI2+ruEwqpBlAuAr226vth7sbmWyja
 H0cA==
X-Gm-Message-State: AFuF++mmbVRcdkXCRKraJIigdWuV/EOihUgYHvH8gn91u1qrm44hFKkw
 gyIq6lhFz+v0IBwjR77qUmRD5Cq56rCLjNNHx7IIpwPweXjNYEf19mMmTBaVhA==
X-Gm-Gg: AYBFou0q6UwPBGfqJFTjS7z3QjsJ3UK5+LzBKsfLpFNhsnX7d9XZW9Rxa5HebJYpGBB
 9n4SUWwrDJvMJx6kbSfsZWaInwgZbW9bs+59vU/yb11dYf6AVbTVYeSFF/V/AKoi24KlK/mYOqn
 JsUD1NP7aQEbgz2r2/7p37jMV5QLSM/OI19DjJHGmEu49ICng4V+UMsBoU/ziqZfGJ+msNd8G2Y
 V+rA6iReo5/jc0QdNKn25jOABdaQk4MnSkTj65g3qayP2TxJnlcf4WX3xbFmjxqTNA+bfErj/kP
 GS/9LWxzL2ft2ai8B6tTGSVCioOGERoKfrx/KHxR/geeXRWPF2LNDRDskHeEvstTG6vP3+UkZOk
 1qX4p5VZ5zR1AXVwc3xNqMFQjTLFIHPq+3+8uuNDVrXnKrbBrzITER3PqyKWy26E80cpXALLXKX
 fmvo7Jho8e2sKohy1HBcjMqy/U2Lbhul8Y8tBsdrJsdcIgIxueLkMme4E4AXxLZy2VFPSWG8scx
 8tX1AaIG3WlGTEhY+Afip4loK7gij+mSNU0oJtvJlXaLPrsXiRem+WoKuo6hc40G7vWTdE=
X-Received: by 2002:a05:600c:620e:b0:49c:fc6c:be19 with SMTP id
 5b1f17b1804b1-49cff2078b8mr339139875e9.31.1788966302977; 
 Wed, 09 Sep 2026 08:05:02 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d20fb2b95sm40751685e9.4.2026.09.09.08.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 08:05:02 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, anatoly.burakov@intel.com,
 sivaprasad.tummala@amd.com, Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v2 5/6] examples/l3fwd-power: recheck Rx queues before sleeping
Date: Wed,  9 Sep 2026 17:04:48 +0200
Message-ID: <20260909150449.856295-6-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909150449.856295-1-maxime@leroys.fr>
References: <20260720080035.673782-1-maxime@leroys.fr>
 <20260909150449.856295-1-maxime@leroys.fr>
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

After arming the Rx interrupts rx_interrupt_wait() sleeps in
rte_epoll_wait(). A packet that arrived between the last poll and the arm
can be missed on PMDs whose interrupt is edge-triggered on an empty to
non-empty transition, such as dpaa2: arming a queue that is already
non-empty raises no notification, so the lcore sleeps until the next
packet.

Before sleeping, check whether any queue already holds traffic and, if
so, skip the wait and go back to polling. NICs with level-triggered
interrupts are unaffected: a pending packet keeps the interrupt asserted,
so rte_epoll_wait() would return immediately anyway.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 examples/l3fwd-power/main.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index 5638d43826..c1ecf118f5 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -950,6 +950,26 @@ static int event_register(struct lcore_conf *qconf)
 	return 0;
 }
 
+static bool
+rx_queue_pending(struct lcore_conf *qconf)
+{
+	struct lcore_rx_queue *rx_queue;
+	uint16_t queue_id;
+	uint16_t port_id;
+	int i;
+
+	for (i = 0; i < qconf->n_rx_queue; ++i) {
+		rx_queue = &(qconf->rx_queue_list[i]);
+		port_id = rx_queue->port_id;
+		queue_id = rx_queue->queue_id;
+
+		if (rte_eth_rx_queue_count(port_id, queue_id) > 0)
+			return true;
+	}
+
+	return false;
+}
+
 static int
 rx_interrupt_wait(struct lcore_conf *qconf)
 {
@@ -969,7 +989,12 @@ rx_interrupt_wait(struct lcore_conf *qconf)
 		qconf->intr_registered = true;
 	}
 
-	sleep_until_rx_interrupt(qconf->n_rx_queue, rte_lcore_id());
+	/*
+	 * A packet that arrived during the arm window raises no new wakeup on
+	 * edge-triggered PMDs, so skip the sleep if a queue already has traffic.
+	 */
+	if (!rx_queue_pending(qconf))
+		sleep_until_rx_interrupt(qconf->n_rx_queue, rte_lcore_id());
 	rx_intr_disable_all(qconf);
 	return 0;
 }
-- 
2.43.0

