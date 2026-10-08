Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E15CA6017
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 23:39:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20D3740DD0;
	Fri,  9 Oct 2026 01:37:46 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id 01A2240B91
 for <dev@dpdk.org>; Fri,  9 Oct 2026 01:37:42 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-cc758830601so3903108a12.2
 for <dev@dpdk.org>; Thu, 08 Oct 2026 16:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791502662;
 x=1792107462; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/cKiv0LyYB3LHh0dXn8ZGwjaF/wSPvoCDDhUe4Hio8I=;
 b=IJwqm/djJN6+5qL1rXiDS/H7ZlLYKYJzGj419Bw2qct2RYThnuqXZg8Le+31JvbG3i
 VnGXGGYH+7vX5xkw1p1maU3hXRpRP0udtwZc/74N+gEBwSsFPneFVH8kTC1LLMRVywSK
 +0g+n6x5Q4dFLpJtYeRdRcskFyCUc+CwlVJV5dR58Ua9Z2SEQQy39O6SNy2ZQ3pgzqS9
 v01tzVE/gYMZcghYa139WWdZq1X8oxid0q/XyWh+CLJA5ymBH6rkH8P1GfCw6r1/8Cok
 2/JHFJiGxtwDwburU2X5Oi+45p1Su2fck4duPjMVM1AoiE0Z+PTsC6VHjs4x9YIXXp/w
 A+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502662; x=1792107462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/cKiv0LyYB3LHh0dXn8ZGwjaF/wSPvoCDDhUe4Hio8I=;
 b=BzmbBrozjENvbX3g/xlfzLWZXmcXh4qhu9MOjc9K+x1NRI/dR0J1A6Q6mQsKKXs/M1
 8q+6me/YP8dXLXz1x9x0sgRqYFHAt+ymLHDHjBbRDq6hQb60K5BczOPj3zI+JGfl01aU
 7Htti/GPqyI7yzHKDEYryzyuXRnjw+R1eftI/HQzUzbcVR7BAYH0z5UjDfoL1zGFMVkW
 wmM8REJtWoqAm327EP5l1/er8iCM8qHXZrBofASPvmkYHv35vNxEldJ517LYARyuEBZV
 E9qQGO5IdK/3CFpqQIq4yk9Vzf1wIMwb0BIjiynXMlmYuk7cvcs9K7O+Z9+uF6L7D4oT
 b8tA==
X-Gm-Message-State: AFuF++mYoH9ro4ywWFl7AHVQi2OG06ZUgm7UBXzjeLBSx54UagSlVVnM
 F5ArqGavOXmCmq7uOiJgcbWCe/ASpqrLfb1RMLt9hn5Eh9tattjyjfQlmbpf5bIgEU9qVtNnHjf
 O6JZOWio=
X-Gm-Gg: AYBFou2+BBryEWwuRiTd0A/hwEgthtvVCexM8JXe1KBOyRq8ixe1J3Il45EesBOe8Kh
 NQy/9BZs++Aro54JMZ46STFSqzycHQWxYEajbAKf6FJd4kZu8IDnw8nUf9nV6t9o65lqXxun+NZ
 U0Mh9qNXoVWYEhDAHdFSElgX7BKUULWPjMakrj9zUmgUE/XY2/UEOqE3EhvZG+Gj8sDtorCsjDR
 +wG02AB2M5GErqryL15HiH8U7R0k/D/NzZEtqySLP9R5lF262uKgEeXr262TsddG0WoAwHERemz
 DTcNKxeMsbohfF8THkEcx92OqUmJJhKw6z6jpW9C1NgRLZQpYKHMeqXUi/R+1RNfnA8BXuHa6uT
 EJkDs7Z4NjZx+HT442R0723h4YiT3SA2hhH0VAR2XrJiYi56rUReNNdWPVHmdRvEVFnExRHhGhR
 AV5qJH2wU0znh6GWecr0V7Z0aVGF7Ll+1Mi4UOofNWfeJ6P1KcgF787+34JNqmYGrJ0sQf6O7aj
 rgWD602eUEEHM1r/jFi2JPdv0HXorfoYW5w+gmHOmNgUUk9
X-Received: by 2002:a05:6a20:6a1d:b0:3e1:1d49:ab3d with SMTP id
 adf61e73a8af0-3e16bdd13d3mr22909637.23.1791502662019; 
 Thu, 08 Oct 2026 16:37:42 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c42b06e9sm187909b3a.42.2026.10.08.16.37.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 16:37:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v3 24/29] event/dpaa2: replace deprecated barrier in selftest
Date: Thu,  8 Oct 2026 16:35:17 -0700
Message-ID: <20261008233649.1260843-25-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008233649.1260843-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
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

