Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51BBCA0EE4
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 16:27:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6FE840662;
	Fri, 15 Aug 2025 18:26:51 +0200 (CEST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 05CE04065B
 for <dev@dpdk.org>; Fri, 15 Aug 2025 18:26:50 +0200 (CEST)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-45a1b0d224dso10942825e9.3
 for <dev@dpdk.org>; Fri, 15 Aug 2025 09:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755275209;
 x=1755880009; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aPaDuifzsFkB3UHbrzoIuWm8/YQRDpkI4y1Ngd46v1I=;
 b=k5CuR9LpYiJPMJYkvbNRGDs4jOtsVPp+XqWhH9oqk81zXbKp10/b482DMNyAfgB6Vr
 FtV9QEb/KYByVCLT0so0JzBE/ollJ6m42vHIIr30hEzy7qM/7Of5b+ZFwG40kPzW3aIY
 wnr4iVHiVeuawlHGpNkPbThc/vqls/OnWTt7MfwFP4hmAaZ2j3uL0+7dKqzwM5Gd5l6t
 Q7x680rQjjxJ3Uy3+wKZNQFT5r7wC5Wp4CbrcxKkYsZf24eZiyX1jCysyhgjvW0q5nQP
 MMMegPOHxezan2nHZa1R4U2Y5jZ+TGERXQMT77foYGesk3Dvh8xLcE766t6EbNvORLuj
 GivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755275209; x=1755880009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aPaDuifzsFkB3UHbrzoIuWm8/YQRDpkI4y1Ngd46v1I=;
 b=Zu15/WbVTuEeEg16InV8RLwM0qt+KIIUJYFuXL2TQ2MlANiKcv6hEnB45HRuiY7xJL
 CEJzZdc+cREi4KzoeZsIFGYKFj/ARkFFKzVyYOeQ433Wk1hMF+fa7pTTt0UJtXAwXH9J
 /OQz3pDINuKEPo4+CQ3lnUGhfoIHo/PJ7OWHppzGYkYWV31pJ/9lIG9k3g7FZ1BgCJwY
 G/WT+vivKYRu0/KuVqXdGbE1K/lqdpuSgwh4Fe8eyVoLeL6PL6LDea1N36QEGCQmOH0g
 OpQ3woUZt2aC5iFLPzP0r88GmZAadseObTHcQZ6fCbUquPQLy2zO1VXIDFPzYdcB/zIq
 DzPA==
X-Gm-Message-State: AOJu0YyZM8qNnjXUVaKPxJkTQTkjT0a4leUSAj61Qz93/Yyu16FmRFqt
 rvMcAY3QrmcPbbb2FRT+lqYw8+huHsDRuUvbd/j22/D9p20HHTVIFQiqK+rk+SogGADpg9g0EDh
 pXjig
X-Gm-Gg: ASbGncsX00V+yHTtyVWZikHjVpGkP13xUNNjQDm/kHmQ4gfPfs5t7zDGP7r5ajSlSAn
 Q7bAB4CVBisq4SxFRtymie11YzTptqkNz2dsJY9FMebzqgx8TotYd0zefxnJOIrMB41wAM7Saq/
 hG6i772s4Ioe+/4ncuZrRhmKFjMpNooxuRDprw5dRSSKkxbPkuesslAlivP42aQyBG+24lMuPuO
 CPEq5fc6pxpVCIh69d9FnvAQWYDIsVQM5dv9TBLYrb/+UmI6I2HJ+CeHrGbA+9IZcujZDmthGX2
 8HcprZl8RxYVlJP/IIs44l3QqFcs2miF/QjM3emPp58I6KYPZAKmGA0nr03Nv0GVExHp12N7d3S
 kLUBW3inp+9o3YYFVOYhEnkjwbWgc81rRo/BzV4M0jSehjeSyjO8BGllfRo+yOShGMDia1N4N2p
 yYB9VUzrc=
X-Google-Smtp-Source: AGHT+IGVKjMXKTVpCCN6+zNrgrG1x6h/p/lHX60q5ZiYatOgmAF3cM0xjSIzHVbiP1yzEbK2ETRb3w==
X-Received: by 2002:a05:6000:1aca:b0:3b9:1457:df79 with SMTP id
 ffacd0b85a97d-3bb6636cce6mr2438786f8f.5.1755275209624; 
 Fri, 15 Aug 2025 09:26:49 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3bb676c9431sm2665278f8f.40.2025.08.15.09.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 09:26:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Sunil Kumar Kori <skori@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v3 6/7] examples: remove unnecessary use of comma operator
Date: Fri, 15 Aug 2025 09:26:22 -0700
Message-ID: <20250815162629.161782-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250815162629.161782-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250815162629.161782-1-stephen@networkplumber.org>
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

Use of comma as statement separator is discouraged and
reported as warning by clang with -Wcomma

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/l2fwd-event/l2fwd_event_generic.c | 2 +-
 examples/l3fwd/l3fwd_event_generic.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/examples/l2fwd-event/l2fwd_event_generic.c b/examples/l2fwd-event/l2fwd_event_generic.c
index d805264744..73a264d8a3 100644
--- a/examples/l2fwd-event/l2fwd_event_generic.c
+++ b/examples/l2fwd-event/l2fwd_event_generic.c
@@ -207,7 +207,7 @@ l2fwd_event_queue_setup_generic(struct l2fwd_resources *rsrc,
 	}
 
 	event_q_conf.event_queue_cfg |= RTE_EVENT_QUEUE_CFG_SINGLE_LINK;
-	event_q_conf.priority = RTE_EVENT_DEV_PRIORITY_HIGHEST,
+	event_q_conf.priority = RTE_EVENT_DEV_PRIORITY_HIGHEST;
 	ret = rte_event_queue_setup(event_d_id, event_q_id, &event_q_conf);
 	if (ret < 0)
 		rte_panic("Error in configuring event queue for Tx adapter\n");
diff --git a/examples/l3fwd/l3fwd_event_generic.c b/examples/l3fwd/l3fwd_event_generic.c
index d86439df52..3a18001b74 100644
--- a/examples/l3fwd/l3fwd_event_generic.c
+++ b/examples/l3fwd/l3fwd_event_generic.c
@@ -190,7 +190,7 @@ l3fwd_event_queue_setup_generic(uint32_t event_queue_cfg)
 	}
 
 	event_q_conf.event_queue_cfg |= RTE_EVENT_QUEUE_CFG_SINGLE_LINK;
-	event_q_conf.priority = RTE_EVENT_DEV_PRIORITY_HIGHEST,
+	event_q_conf.priority = RTE_EVENT_DEV_PRIORITY_HIGHEST;
 	ret = rte_event_queue_setup(event_d_id, event_q_id, &event_q_conf);
 	if (ret < 0)
 		rte_panic("Error in configuring event queue for Tx adapter\n");
-- 
2.47.2

