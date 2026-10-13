Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6792CC6B12
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:37:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98B3840A82;
	Wed, 14 Oct 2026 00:35:27 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 90FFA4064E
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:35:25 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2e934449bb0so1331565ad.0
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791930925;
 x=1792535725; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/cKiv0LyYB3LHh0dXn8ZGwjaF/wSPvoCDDhUe4Hio8I=;
 b=ZcZG/grimkCjO4r1GWXANa1/dX1LpJX/EkTMVDAlChxT4v9zsBCO7A6NbZ6/dFOOO7
 YlQd6uehydr7nbyJekg8aWJmIZXhfpGddkCTnt2irCjajipY1bezcOCkntyvOSkmiSuQ
 M9RFfA7LgrFAo8FMYPRTCjts3iXV83vZiSGSJvumhpbPr4fqRsH6Zy26pzWkYPMXmwTN
 OwKss+z5e6aTMwFtf8tg4ta7JV9Wy9fhBzZJ58iUlYeUccvAdzVmosn6anohxCtMJcKO
 pUFybbMEUfGt0FAk4C9rKAwd0o7TMj+yCIghHfPbvb+ArtvlIr9obEmcI0xcp1bQO3iV
 d7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791930925; x=1792535725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/cKiv0LyYB3LHh0dXn8ZGwjaF/wSPvoCDDhUe4Hio8I=;
 b=wpOppP1nR4hdxwESl1f37IsSwAngbfZ/B1ROKsNjqSDlDZrijQsr2/YuoxiOVJSFwU
 faZnbhTidlxSuu1+5XK4f5cjEHjpP/xSnE/LG+U47aOHD0HmVuwUTwOLgojb3/4PIZM5
 HMkia45ENE6NH+/vlD7VwzcIOmAQeQw+kU0ApjSs2mtWHLmP6qKGMSxpCu9lqUZmEpgL
 O+Ww1ElvfPjrjFVNyNwyT8Kv/EDg+mOxZjjmlaVhQAu+GNX6sFRr2XKoqp1L1nkrmGIF
 GAyM0WHF/1/EbwDQ/YzaxgCxzj0tiFgcAfUHfWxFBk67ldn3g322WaPIwx42RQh99dPZ
 diog==
X-Gm-Message-State: AFq9FYIfgJimWWhI9wzvWcKI+VDdKj/jY2CB3bZsiRSw2DlXOHumxIkY
 OFfawJY6yCb6PFiG7S6xZ2xNna1+v5kIMhwdfWKXGqIfCfD6oWQ+uHm1M2fgUMS0kj4t1yhY7to
 +o0fZwV4=
X-Gm-Gg: AYBFou0UEpmIRJs+xnF8zKDF7UNRepVmoM3T6Zj1LseGgFveefmccpkE5Ndnq0tIFC+
 g5ipSUNi6rG0nJuoPOWA/z5weIueUJJMhbZh/CIwYOvV/fDWLapp/cqBmYcxNBE+RjbnFw6/GOK
 XTSfv5O26jrFj8Hu5bYbTY+ZEEP/y1v5iTtg3JunrlyhjQ5uPN0Y/65VwDKtbdhS/rHMvz2s7YY
 RpFaLOXo6aUtZ66A+tg2PgjmM4sKqVtejz338bb4fbN55MpzX5EKBuHIm38fhVlFUK+V5bWHZNE
 Yf4PtB8F20Bn2Zri6uzCIeI0mIrzrBFjyD0pi9TFTIbArXEaxTc1HxdLim1RntyvXT+Fz3DF2sO
 x7kLFFOHZ049PGOsAnVYpajYDIZ4fsWn87/igFTo2TPMOWGWAe1FQZPl67BXcu+qZY3zxerhKWZ
 Dn8FjfaFcWrXKvB0vwb4NTbF2JwgxJ6iSl7Ecj/AEw45YrntUiDIT6GXA3XuFJ9bieoC9Ddppln
 lBOT4Md94drh/qXye/znKpmUkEwfWVrFzmSjw==
X-Received: by 2002:a17:903:2f92:b0:2e5:98d7:8202 with SMTP id
 d9443c01a7336-2e842cd44b8mr123127535ad.13.1791930924629; 
 Tue, 13 Oct 2026 15:35:24 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421b19a2sm61865145ad.46.2026.10.13.15.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:35:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v4 24/29] event/dpaa2: replace deprecated barrier in selftest
Date: Tue, 13 Oct 2026 15:22:37 -0700
Message-ID: <20261013222410.2257622-25-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013222410.2257622-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261013222410.2257622-1-stephen@networkplumber.org>
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
index 2c688bd194..b1e4bf6855 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev_selftest.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev_selftest.c
@@ -526,7 +526,7 @@ launch_workers_and_wait(int (*main_worker)(void *),
 	param[0].sched_type = sched_type;
 	param[0].port = 0;
 	param[0].dequeue_tmo_ticks = dequeue_tmo_ticks;
-	rte_smp_wmb();
+	rte_atomic_thread_fence(rte_memory_order_release);
 
 	w_lcore = rte_get_next_lcore(
 			/* start core */ -1,
@@ -539,7 +539,7 @@ launch_workers_and_wait(int (*main_worker)(void *),
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

