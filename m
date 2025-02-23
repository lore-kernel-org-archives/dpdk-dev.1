Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1C5C021B2
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Feb 2025 02:43:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4391F4025E;
	Sun, 23 Feb 2025 03:43:47 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id E59AB400D6
 for <dev@dpdk.org>; Sun, 23 Feb 2025 03:43:45 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-220c8cf98bbso76028195ad.1
 for <dev@dpdk.org>; Sat, 22 Feb 2025 18:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740278625;
 x=1740883425; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fAzA+ZilZMBPgrE5sGt4CW2AEreYmFGvzCi3w9/rAag=;
 b=XNkg+ZQS6G2+bq1oo+3PNeYyvpRFREg8rKYMuEP6kFsg4releCwXL9Nh/kbps32kZ8
 dMB3R04Sd35zuVguAfuY9WYdu99w5pOMDOzpWwPPQ4dM51ct8gmfMCc8X5NAyMh++/M5
 c6BWJ9ltW5P4ocC2tjol/WuOr5aVgOPFi0YxtluJT0xLuSspAFsCyq+Yx7pWiabxopMG
 enrziYy0J7nvMe91LKp5yAQmaAC7EYuPLXwkIXxD2IW/8EwAd7ur6U5Aq/2id6KjE9vu
 W0nI23SgPWFtN2aGGYge84xZVtdrnAntt77I3GnU+M96yee/MDEKwVv+VdR3hYOxrs/d
 XG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740278625; x=1740883425;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fAzA+ZilZMBPgrE5sGt4CW2AEreYmFGvzCi3w9/rAag=;
 b=cNsmtUtmg8DD5PbJDDlNRSKfcRurIgSr9Nd/e033k7DNLgnSU2unyVIDoWI1qP45sm
 Xj8u+exAcm9fp8W366UXhvvbqhsoCF1sHdNbM1PXXpx0PCn8S4X61mktoBg5so//GbOS
 vI/cMDB7IpjOd+Z6SmOedC5P6Kt71nsG0YYNENbbrTudRrsMkztyOQHJ+P1XPP8e2/RL
 6X0pL+qeL9vWEp87w+dRdcmqLRQQ3+JgcinG+uv2XMLOgu5zFT+axLZouT0Sz/D0Y2ff
 SOQCjdXK9BIox4/TqTlqVPreGoTaOyS7lUAGGiRr+4u43AdMum2nDcdQV+pH5X7pkx4N
 ZvxQ==
X-Gm-Message-State: AOJu0YxWrDZy+OcY3Xb0NrPQhhrkTMB03B/wsr8kVL9aqbI0P56WwsxE
 TshZfSmfzcc9PsOmdnd1Ho+eefG//nmO9jvSNfqtUTWRBkwlPE6zVKq1E2otwaOujVTwP20MLjd
 G
X-Gm-Gg: ASbGncuk4uDz4Wg6slOuqVl4X0ItbFRK89qPFDNhu7FdAGfy5Jfckt3IUxvgH0kp7kM
 xYjYEi4c7UpvKoZ5mhmoW+1TjVyyU3r/+RVxhEnTeGFMzxWl4pe8cs4Szf3HhBqpk4FRWHkOIJw
 tu1IUjTdqA9/1fr79JBv6w1/YrE75xHXTtD1UGowDYyKlD4GQOfZvs7HQsJ0y/SKttXSsTs+Baf
 NhbDLWTfNVmpactzvo/eCbA8hB90JcYbFE+ZOCgzSgPBR0CtsOmhLxLQfHoeTA3Dq/XCpTbvZUf
 Me1dgtJgMdgm2Mb/c4EEaQ91FeivWpMXwjP8FfU2jR7NqjGqzhzD6zSZ5US6C95rlooP+1sK8BA
 Ni6s=
X-Google-Smtp-Source: AGHT+IFrbfjtBX7QIeTWNoJ529amy82/hkO5ycUc3iO6huvGq0nk6WM2YO2jApb9h0mCnBO+ly1yqQ==
X-Received: by 2002:a17:903:2441:b0:215:a179:14ca with SMTP id
 d9443c01a7336-221a0ec35cbmr133690075ad.2.1740278624852; 
 Sat, 22 Feb 2025 18:43:44 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d536443fsm156112955ad.66.2025.02.22.18.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Feb 2025 18:43:44 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 0/5] net/zxdh: possible changes
Date: Sat, 22 Feb 2025 18:42:19 -0800
Message-ID: <20250223024334.1216477-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
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

Reviewing zxdh driver these are some obvious things that could
be fixed

Stephen Hemminger (5):
  net/zxdh: remove __rte_unused from function prototypes
  net/zxdh: remove __rte_unused attribute
  net/zxdh: fix RTE_ASSERT expression
  net/zxdh: make callback table const and static
  net/zxdh: fix indentation in mtr get and use assign

 drivers/net/zxdh/zxdh_ethdev.c     |  2 +-
 drivers/net/zxdh/zxdh_ethdev_ops.c |  2 +-
 drivers/net/zxdh/zxdh_ethdev_ops.h | 10 ++++------
 drivers/net/zxdh/zxdh_msg.c        | 24 ++++++++++--------------
 drivers/net/zxdh/zxdh_msg.h        |  1 -
 drivers/net/zxdh/zxdh_mtr.c        | 30 +++++++++++++++---------------
 drivers/net/zxdh/zxdh_mtr.h        |  4 ++--
 drivers/net/zxdh/zxdh_np.h         |  2 +-
 drivers/net/zxdh/zxdh_queue.h      |  4 ++--
 drivers/net/zxdh/zxdh_rxtx.h       |  6 ++----
 10 files changed, 38 insertions(+), 47 deletions(-)

-- 
2.47.2

