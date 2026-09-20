Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0DCC982DA
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:16:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16D6A410D5;
	Sun, 20 Sep 2026 20:14:28 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 616B240ECF
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:14:19 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccd5cef0so1543138a91.0
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928058;
 x=1790532858; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I857dqJTdmXB5Yt/8JuAWulRd897dBwf7b+mkkmEgJ8=;
 b=Xr8fhX7x70YWcTdecfEGQBDwwntWjmFRzk5xdpTHxJdQzEPVj1a7ZWyrCp6XA9OQZm
 qkIFk+1f+PCI2I2IQrnU3UTT6lAowcuIO22dEgWeOCBP0zZD9nNrdmhHS5OWY/QBHkw3
 fS7D5lxMJ08zfWpCV+l3jLqnQ7IIT45TquxrjQlJM4NaewxJ3AcP9Ad4XQ3nUWPYRZDo
 VATSaa1PpxCXWHotKnEQh1CMwkFRFqePcEZ49lG9ByIqBi/mmNRX6ebcRLoD4noj14To
 Epy7AHe0q5xhS3HlOK1DUKCr8RgOUC/NUacfp2zTjFJbyF4X0ZMjiMd4zjD4+16FyW/n
 dWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928058; x=1790532858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=I857dqJTdmXB5Yt/8JuAWulRd897dBwf7b+mkkmEgJ8=;
 b=mo29YLm1APCcxzmuiJDRaua5GzBnS0ll6OsNacD8HDhZWq5PveJz9i7Ixc6/sQuzH4
 XWCWqyQRQE9e9vY567sFbeuQR5RbtyIWSn69h0jMeY4cSN6GsWZoBBDQDDiYSF64YWZ+
 jp+3MYHKRIH6QRkM+8AV1xvtfzRvj65eYPB4ldMsj79+tMOyu3Cv7bLqz0azCpAuaReQ
 XluJ1ForTv0ze2Yr/rwB//GrYVi4x0XUeUvE2OimNclG5SXIkV4Zh8HU9aoIM63/hco5
 N44QSOw6BRhiK+IoB03rGujHqO47wqx7k/tWUnnAB7hSKb427nS8BBs6H6gLBrwMottv
 Y6bA==
X-Gm-Message-State: AFuF++kVi/NBsLLoyTtP/N7svLpF2zWKQcs0uZhAvoJ9lWB0f3bkunTr
 Cbdzv5vavoPYV5YhWjntQ72DWudLmVfKK4jmU7X0TW7LvgZ2tg9H2ajBf6KRXrIi4HH98zzcqK8
 fBYXi
X-Gm-Gg: AYBFou0wiR/0wlfKoIBVo3XhOS6VSU1CcV5kPkwD3x1FEZZSCiI5YvQGYFCU5ekFWGF
 hEYi55pLDrF60TPubKUeaixiEM4LrDbpHn9rtDom0bp75PFajqBlgAiVo3jn4os4837GTOIMtgN
 ZKgyawYAEv8pd097wxHnnNFzlk6bixOGXv79BuJKLq95EEywfDY7xFSbAwhtMxBX9r17Jv7Q8cm
 vtP1mCLsP2hmC/x9Dy+h+jc8bgJpEScKO+dg0o58rF5viUIjSCmdFknItmhUoBINPntaKcdCdfp
 PY9+3wtI9P7y4loRCIHNhJFCvBnXG3WI116i1rbQvyOaHhkx1ooph1ICTvQaLIDtAZa/cXFGbqw
 e//Zpxhmkikijbhy8nmkdA3qy5mdFMDSyp0xDR2xbjgRpv6M+xp2xeudNKgJzJulfCt7iXv3YRn
 JXpcVXqY2PkG96r2kaqr26aRmK0K1I2ge3EA0zqvKKxfst+Bwo79aagm9jPMQ7Q7nA/HqKohJQw
 qhpAEZYf3bmP7oDFAg/Y+KfL4RXYJCRXfH+0Q==
X-Received: by 2002:a17:90a:c88d:b0:39e:4c80:f67f with SMTP id
 98e67ed59e1d1-39e54f3aa58mr13377694a91.30.1789928058483; 
 Sun, 20 Sep 2026 11:14:18 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:14:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v2 24/33] event/dpaa2: replace deprecated barrier in selftest
Date: Sun, 20 Sep 2026 11:10:16 -0700
Message-ID: <20260920181347.747210-25-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920181347.747210-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
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

Publish worker parameters with a release fence before launching the
lcores instead of the deprecated SMP write barrier.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/event/dpaa2/dpaa2_eventdev_selftest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/event/dpaa2/dpaa2_eventdev_selftest.c b/drivers/event/dpaa2/dpaa2_eventdev_selftest.c
index 9d4938efe6..12c1bc9878 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev_selftest.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev_selftest.c
@@ -524,7 +524,7 @@ launch_workers_and_wait(int (*main_worker)(void *),
 	param[0].sched_type = sched_type;
 	param[0].port = 0;
 	param[0].dequeue_tmo_ticks = dequeue_tmo_ticks;
-	rte_smp_wmb();
+	rte_atomic_thread_fence(rte_memory_order_release);
 
 	w_lcore = rte_get_next_lcore(
 			/* start core */ -1,
@@ -537,7 +537,7 @@ launch_workers_and_wait(int (*main_worker)(void *),
 		param[port].sched_type = sched_type;
 		param[port].port = port;
 		param[port].dequeue_tmo_ticks = dequeue_tmo_ticks;
-		rte_smp_wmb();
+		rte_atomic_thread_fence(rte_memory_order_release);
 		w_lcore = rte_get_next_lcore(w_lcore, 1, 0);
 		rte_eal_remote_launch(workers, &param[port], w_lcore);
 	}
-- 
2.53.0

