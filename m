Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39A3C43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 04:07:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A791D4028C;
	Thu,  9 Jul 2026 06:07:43 +0200 (CEST)
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com
 [209.85.214.201])
 by mails.dpdk.org (Postfix) with ESMTP id 508EB4026E
 for <dev@dpdk.org>; Thu,  9 Jul 2026 06:07:42 +0200 (CEST)
Received: by mail-pl1-f201.google.com with SMTP id
 d9443c01a7336-2ccbb61893fso13695425ad.0
 for <dev@dpdk.org>; Wed, 08 Jul 2026 21:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783570061; x=1784174861; darn=dpdk.org;
 h=content-type:cc:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4165vKpXcvYWAiI3MqmygFQmFN6s3YGCfEyy3Rv7OuM=;
 b=CB3ocFfRqGzsGAieC5psD4w6MRWJPa+MuoxwbelEQOeweV8l9f5sts1lZmJUPHmT6N
 7N3cvJJUkTHMGKMYkQ3mAiHn4UIJ9hflRMd5iI8QQ7S3bb7vjomNLW5mWJUD0zyvdefx
 D3iFsFs5vll+KOE+aRxdNc0g8ZVnbLCsZCtqNWabxMa1xZ17M8MXs6clsiX3GQnzQ+PP
 /8iS4ROiJ2ndLeEWVDKOu+jTYsMs1r/1SUBzxtuNh2MwwXDu4WWQTS1rWRt9v5p/jjkM
 JAilZcMXoBrHYaFePBhC4/EOAy3l8QNEchRO2Jctsd6BopSn0bbLa+ckR4C2Hd6JxoZa
 I0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783570061; x=1784174861;
 h=content-type:cc:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4165vKpXcvYWAiI3MqmygFQmFN6s3YGCfEyy3Rv7OuM=;
 b=VCMKcjwzQPy9kXDUxo72Ma2ZqoTt9Bys1BspXgiGEY7fJD0Dmb+WBYAbNTwtIzynHU
 /iHebbEdmx3Wy/LOxT9syCsojjwVHuxjBp5dEuqRA4GHCkLKnoAgLm1dhBK4L08qtlnE
 nwBN+BvGC9oGwTb4eS0hIeecbP5FxjekrpgpV2X48cHy8ij5+x/p1R5ZpctCaI/KPljr
 5NDGvZjUi72IVdP8uW58MF22+RZdgW+DRh7BE9HR+wpvc425KqcjTP9Vp//tr9W4uCLI
 qAbs7fEWYu8jHyv6z0HfMGxAiaWEzSFpotPBYDN2WeenZtNfI6JUevYsZs8OfNxp7Ba1
 gvLA==
X-Gm-Message-State: AOJu0YzuJYVm3kfHAJsLRNOx/icMQ5uycTimTFD6ib4xICGgpQhmuCvu
 WxpvVMZum945sKIayZUEDzVuJExRcOuaD/GcUQ+/qQU+jeJh9Gb/3FUHK/6T+ecdEMDKRXFI8f1
 xmf81V2DryuFYbfXsq1vafuvC/+qe7ftGB5gqY0lRGQ29t+JHOTBQzBQbWbYrB3DV2JszFeOzxu
 QNC23tfVFlvs6J49iaFYVnnLZCSMBvdWkGqg==
X-Received: from plbkc12.prod.google.com ([2002:a17:903:33cc:b0:2ca:d667:90e3])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:120f:b0:2ca:53e9:1277 with SMTP id
 d9443c01a7336-2ccea37df7bmr58512135ad.1.1783570060661; 
 Wed, 08 Jul 2026 21:07:40 -0700 (PDT)
Date: Wed,  8 Jul 2026 21:07:28 -0700
In-Reply-To: <20260707164020.2936476-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260707164020.2936476-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709040739.3184955-1-joshwash@google.com>
Subject: [PATCH v4 0/9] Stability fixes for GVE
From: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Content-Type: text/plain; charset="UTF-8"
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

This patch series consists of mostly unrelated fixes in the GVE driver.

v4:
  - Remove unncessary include
v3:
  - Fix 32-bit compilation issue
v2:
  - Remove unused definition

Joshua Washington (9):
  net/gve: clear out shared memory region for stats report
  net/gve: delay adding mbuf head to software ring
  net/gve: copy data to QPL buffer when mbuf read does not
  net/gve: validate buf ID before processing Rx packet
  net/gve: set mbuf to null in software ring after use
  net/gve: free ctx mbuf if packet dropped after first segment
  net/gve: increase range of DMA memzone ids to 64 bits
  net/gve: don't reset ring size bounds to default on reset
  net/gve: restrict max ring size in GQ QPL to 2K

 drivers/net/gve/base/gve_adminq.c | 11 ++++++--
 drivers/net/gve/base/gve_osdep.h  |  4 +--
 drivers/net/gve/gve_ethdev.c      |  8 ++++--
 drivers/net/gve/gve_ethdev.h      |  1 +
 drivers/net/gve/gve_rx.c          |  3 ++
 drivers/net/gve/gve_rx_dqo.c      |  6 ++++
 drivers/net/gve/gve_tx.c          | 46 ++++++++++++++++++-------------
 7 files changed, 52 insertions(+), 27 deletions(-)

-- 
2.55.0.795.g602f6c329a-goog

