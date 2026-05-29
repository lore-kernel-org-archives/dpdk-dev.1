Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C50CD4F54
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 17:14:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89A9B40698;
	Fri, 29 May 2026 19:14:31 +0200 (CEST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id E076840678
 for <dev@dpdk.org>; Fri, 29 May 2026 19:14:27 +0200 (CEST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-304e83724bfso1636757eec.0
 for <dev@dpdk.org>; Fri, 29 May 2026 10:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780074867;
 x=1780679667; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HvHXwg8BE8T12HztHIGK1nG9UKOimgeRyHue6SUXaHQ=;
 b=BIMYDu+T5Ot/HwHYX2ZI2oELRc3wc+AyRbrtxlorc+/mCCcii+yoGyMsNjRAl661w2
 oFw1+PGfud5+kpnx6KkOcSMcFmYCgvDJynfMysdwJoDqWAwT2X4DVs7XknaxxXmA513v
 SIxP4kEVCJpR271z8lKpUigmsreRR2eKl+jxTVBjGD+gZBm0YM6PDV94mtwuhNVuGmmf
 GcLk/4ot/UBGsSVBzaFIPivRHs9MLz7G+gwNd3CBd4lAH78SyKkX07w0/0zGz2uvBJw5
 CNX2hzn9ei0yfwnJf8FrqMc8gzeWBBwDok2DY5JkHjRvXpn/TwEZSa9csN4Socbk2x4h
 aymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780074867; x=1780679667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HvHXwg8BE8T12HztHIGK1nG9UKOimgeRyHue6SUXaHQ=;
 b=dPE/doqae7VcCw/0msMBBsCopvtifMZbbhMzs57WUZTm7VZyu5ZzsgAGblswBptjNs
 hHLzQVWhHY8dcXrwUtK4jZqZqBTW7XgCJRKm5VIH40qWjJUkgBQ7XGbVqsYZBck7zXKC
 C6EDs2Eyweic9U6uM5r3Z3ghnX1bETav1aCrirLl+FQh8OPTm5ZkZQC05LANak6/4Mxx
 wxGZRWRQqXiqnrc33IVzD/VvCzdctln40hDSoWJnyHQDDID/iTZUnkclCJlnsYOP4Pa6
 G3pQbMU3f22daPJvbNtp5seP1hpYYwIf5yJkktfSVSdExqWxJ8WzAL2kYllrTLKK+IYS
 UGFw==
X-Gm-Message-State: AOJu0Yxg4bxSQHK3NX4/pbbpZwynPNI1HxENbngc3i2Rp6OgckYKM10m
 DG4+yTEKBAeMhDCL19nJw3UE6zgbm7CCNlgYjRTumYXSy06+BBxRpdOieSytAP3b3uE/pT54bkY
 NtXcJ
X-Gm-Gg: Acq92OE6KeQ8Ud56iaJLpwKlsF07u4qmfgemjNuhgvED3TZ6gN+KeRizbNdVpZ6T/+0
 0FqqnLXNGpvcxtGwuahlZ5B/YEnYB4PVyLqt4nnonaKaKo0q1swbiVTO9IszPIZe8V1cN2MQsBf
 0VNOOZZ1b4ft85z3CFzyd01CjXxRyyfLR3gMqO5/hsy1GDX/7RQxXFv4dfrrL3rD0caRwTgks7u
 w2+iKnrLm6pUj7WgW0Dq+LFbdOm7e7y3T6VJLbpwQ9OEKB9Qp0PS0797e5KBGJ3IMD+0Cx1K7eo
 C7DKuC64mmrjiHrVsk+yFBSNM4FOGaR1K4VS4DaP0duAs5HFlsAU6klYz60WpkAEUsqxB4rC3yn
 f6lVZv3zn07ehf+6ca/6TOAb+iqKsdfA5Z5vQ+risgvyIMK/71LhHbzS/p+NjsOig6JeRhBxoHI
 Tsv8tgQTAnMyhTz818G/OTJq5PNvVCysRujMCkMcSHNXKz55vEza/J+cDmN4p605CwoJ89mVdx8
 0+pmfWBg4c=
X-Received: by 2002:a05:7300:3b05:b0:304:df0e:9dba with SMTP id
 5a478bee46e88-304fa6a755cmr336306eec.31.1780074866801; 
 Fri, 29 May 2026 10:14:26 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2c120csm1880350eec.4.2026.05.29.10.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 10:14:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
Subject: [PATCH 6/7] app/test/test_rcu_qsbr_perf: call quiescent more often
Date: Fri, 29 May 2026 10:10:59 -0700
Message-ID: <20260529171417.526892-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529171417.526892-1-stephen@networkplumber.org>
References: <20260529171417.526892-1-stephen@networkplumber.org>
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

The performance test would generate large backlog of quiescent
actions which caused test to take excessively long time.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_rcu_qsbr_perf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/app/test/test_rcu_qsbr_perf.c b/app/test/test_rcu_qsbr_perf.c
index bdffd64e60..8768a9ce1a 100644
--- a/app/test/test_rcu_qsbr_perf.c
+++ b/app/test/test_rcu_qsbr_perf.c
@@ -313,9 +313,8 @@ test_rcu_qsbr_hash_reader(void *arg)
 					pdata[thread_id]++;
 			}
 			rte_rcu_qsbr_unlock(temp, thread_id);
+			rte_rcu_qsbr_quiescent(temp, thread_id);
 		}
-		/* Update quiescent state counter */
-		rte_rcu_qsbr_quiescent(temp, thread_id);
 		rte_rcu_qsbr_thread_offline(temp, thread_id);
 		loop_cnt++;
 	} while (!writer_done);
-- 
2.53.0

