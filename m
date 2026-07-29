Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1FBC53219
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 17:59:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 339C340E0F;
	Wed, 29 Jul 2026 19:57:51 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id 682BA409FA
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:43 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-cbb973e6749so1462732a12.1
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347862;
 x=1785952662; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W1exr1pGa5aYLIcRFg20YaLQGpUWBDBAWPmTKZYOAfU=;
 b=O4BEXoWDL6kii+zYr3h4FToDG8M3CgriHDkNugWqh/vd6pnrueHoGzVPUJoIerzCKM
 yPRzyIn287dlkfcJi0sF9jekVyGhPvznlP9eSRuFFmdRakV8nJAhko/nZDkH2a9vCCDE
 8AlNfEdBHfUX1jMpougUbxHbuutFd7Yl4vgG8RDeajbyEEMka2H8Q2u+93qPA9UAdRvr
 kCcQYBjuLxcNrDWJSMRdxNRVEfEiBR9p4Pq42gCUhpe45aUylSJaUmk2FdXphf6nVzEQ
 yslQ/6NSV4PBvrdTQdSjdJxYqzigCGLkdPQCXzVJrA8U9tsDw5JeFUffzBvYf0hawitc
 V9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347862; x=1785952662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=W1exr1pGa5aYLIcRFg20YaLQGpUWBDBAWPmTKZYOAfU=;
 b=VET6XRNt/tTUmEPaFaM3GiQoOyO3DVTGBZjnr23TGKAxIfbR3QylYyW4iOfuLKPXsh
 RXQsFO3aOeppF2HITTtgmj+Eqzhynri9lW2VbxMN1pDPR0GEy0pvSRlTAKcsEdGwZEfx
 qoaMAOLFvO7RGcu/LuLXaJzLxUIzUTafwhmqY0QKtR/rTvstJ6IaXPMj/Hiax5VjYPB5
 an4A8pXmcHWyYOPoA/SX+o2raeluS34HHXdhAElfIaN9wszwARD5MzaXyLLe5P7imsnn
 25DgJGpRnFzx8/nb38VpC7WlYJ+Lmlr6hhQIIwgZNSZRi440JRleQ2W9GHgFhw8sQGNy
 XN7Q==
X-Gm-Message-State: AOJu0YxUg0FGqWoAyUqJP578PQTQzB4KrzSYWIwvamyt45+E8cDyvTgO
 mapMtULRVYalWlhEdqI4KIJ2bhNZNzRPLASaDWGmnJASSIC6rQawbhbSpICnUhsqgENWwHM858N
 f6nTb
X-Gm-Gg: AR+sD13KTQnNsommrwXQvWL2j0eqGzKTinY4a7/mGIg9FlZ5wMhNsP4klqerb3jti/T
 RO41MH6JvRQL0PGYTmUzdp0FOveSevKwBlvI/+yN/ILmAXmhBXYxiZRag4i+r0Ube20BGLY50rV
 iBP1QIQ8K4/j0JFYjuy6Lp6cm6zad3aMT0ESJhCp5oNrmDVXwoBcBtR84rrqKQBIVDSwdz1CYTk
 keUxh0Nk8gPMF4/IowP3t9ubYIORj4q+limftfjxhqLcwVhrbvw5U/v5O8vTKravltQWAGD++0s
 fwIRy3XsW5mbA28wvf4v1/jQAQ3c+Nfkciv91ulKv4NN+BZXKFDCiBED90VvhvzBH+Jrrr+tltq
 ixaixkvHapkUq4lXBssYSLVJyiI5Ir2YwqAr5BG91LH4aktFmN8jNeHhaLxhBjNnZDOcdlmvPZB
 LyiS/vQ8kT789aXMbhEzf05X0FVEYophUd1048HKgflM0D9ekP1nl50WxqITtaLoI+lH55byZHM
 aEVEDN/9khG6qXaT3Nk0YRo0eIKiLFl5HMliA==
X-Received: by 2002:a05:6a21:6cc4:b0:3bf:6c08:2844 with SMTP id
 adf61e73a8af0-3c8ba61303cmr9459532637.51.1785347862624; 
 Wed, 29 Jul 2026 10:57:42 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [RFC 23/32] event/dpaa2: replace deprecated barrier in selftest
Date: Wed, 29 Jul 2026 10:54:16 -0700
Message-ID: <20260729175715.165120-24-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729175715.165120-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
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

