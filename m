Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B1BCCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 18:47:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F61A40648;
	Wed, 29 Apr 2026 20:47:44 +0200 (CEST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id 8C41A402AC
 for <dev@dpdk.org>; Wed, 29 Apr 2026 20:47:43 +0200 (CEST)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2c15849aa2cso226491eec.0
 for <dev@dpdk.org>; Wed, 29 Apr 2026 11:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777488462;
 x=1778093262; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DmjYwptL7XKguFYZPm0bx1SAj6qanqE9bvBP+mwL37g=;
 b=rKpRxZGIOXQHqivvB2cXV8XMhlgqyVYKh9G+89rUmSu0VVmzfMHpficSRy3k9TG77L
 QVHLWSeGmurRCwRed7fmcYCGPSpx+hGIG0wMzn7VfWiBJZxTToR/9QDxDtWnF3oAUrSr
 lK9FwpypWSlg/zf5U9QPnWjEtLFOsx+sb8LQ7+Vl6WG4/UBKGNuymYSXwcFHF1DzP0Vo
 RUKhguno3z+YDvh5dloGDvVePc8lrdN4sJ44kvUOdPOYMicmJ0+aLpXAHOg/a6zp15hN
 JkrqRTo5Hl27bidZsIyIrHQ8IoahJ+Py3RrL51PVtmi+mUHeEOiuIVHdp9TEV8awvZrO
 /Meg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777488462; x=1778093262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DmjYwptL7XKguFYZPm0bx1SAj6qanqE9bvBP+mwL37g=;
 b=apArkbjP/YLhCK2s6n67ihodQtzdr5zPS75LboIAffaJlqB6VGmhOqf8A4kVWDMazZ
 TOESFRWBbky5eUY3MMU2q1DjfiJYo97RPUAzFJioY+1FLo3tAdWnYLi5M4J5wAfckdHp
 uudrdXVdBFiT3SIEn3B5fELf4DJNsUqnzHNiylupr04NJxF9/v2RnDswCO+XoblyQq3c
 Dm5wdwLAgSaMHS9kzr8i7M8Pq/rhqyu9H9SfAP1x7OcE/tCTDMkLIfhxb7Mgz4NK72Yv
 I5UBciyDanp+6l43AVGy9UNGdKSnt9e5DoiCA9Tec7ZHprWB1BKy/Ix1nDjzQrFiSFjl
 +O6Q==
X-Gm-Message-State: AOJu0Yx8KK8lVLyAThlWK+WzrM1pW/VdyJEv2VEs17hGSkBjGeVZYBtN
 gnHG5ZZV/nZEA+M2ml3be96/fDl5Emwn2QBCGoSo+y7gZMGzQd8zjD2QpeC+TbtqXI53N/bYPNb
 IQCyG
X-Gm-Gg: AeBDiesTOnb7ZGPk/oOTaZjxMmzyfbJHz5wppFvC61zQJQ4X1zLPI+uOH/ruVYIYOMt
 RTEGi7XehWAJo64ZV+5Y6sV5qKLrp1yAxW6GqbiyrP14CaCzdVEL92jSkD7RYNz75FB7fw2e/fW
 9Y0V61vqhSu4fyIDAyQLW4syIrE+HBlqZKri9Wl7QfJm7oLPjBHeH9acKs3aT/WDcU/ztKPhUSY
 GMXTk19IKdwDS4P8Df0GuXtb3cJEIHV/4RrAb6V/S3tNFHtjQQUrHz/2g/47SKrzxrS7F03XHhY
 iGJdiYKJkHMHV9WAIEnfdIiMbNb8h6hIQcebkbSS9d9gql0H/dIYsgUpZn5PBk9M5v5roMk//Yt
 PbzvZ9muKqbSZI1rPCTWLZflvdhEBPdiu4FGRlfA/UHCO8NKgt3ZaUZqRnqGcJDrpaf14nLNG+b
 oNazbo0OFC3YF6AumyM0wJobuQuTdUe1Zi9PjCnCPn2JU=
X-Received: by 2002:a05:7300:ec18:b0:2ea:cd38:f921 with SMTP id
 5a478bee46e88-2ed0a1698a0mr3914846eec.26.1777488462524; 
 Wed, 29 Apr 2026 11:47:42 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c09ca30sm3271027eec.24.2026.04.29.11.47.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 11:47:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 0/7] fix use of pthread mutex between processes
Date: Wed, 29 Apr 2026 11:46:37 -0700
Message-ID: <20260429184739.706250-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413171836.123467-1-stephen@networkplumber.org>
References: <20260413171836.123467-1-stephen@networkplumber.org>
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

Several drivers and the ethdev layer initialize pthread mutexes
in shared memory with default (process-private) attributes.
This is undefined behavior when secondary processes use them.

This series adds PTHREAD_PROCESS_SHARED to all affected mutexes.
All are on control paths (firmware mailbox, hotplug, flow ops,
PHY negotiation) where sleeping is acceptable.

See POSIX spec:
https://pubs.opengroup.org/onlinepubs/009696899/functions/pthread_mutexattr_getpshared.html


Stephen Hemminger (7):
  eal: add helper to initialize process-shared mutex
  ethdev: fix flow_ops_mutex for multi-process
  net/failsafe: fix hotplug_mutex for multi-process
  net/atlantic: fix mbox_mutex for multi-process
  net/axgbe: fix mutexes for multi-process
  net/bnxt: fix mutexes for multi-process
  net/hinic: fix mutexes for multi-process

 drivers/net/atlantic/atl_ethdev.c      |  3 ++-
 drivers/net/axgbe/axgbe_ethdev.c       | 14 +++++++-------
 drivers/net/bnxt/bnxt_ethdev.c         | 11 ++++++-----
 drivers/net/bnxt/bnxt_txq.c            |  3 ++-
 drivers/net/bnxt/tf_ulp/bnxt_ulp.c     |  2 +-
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c  |  2 +-
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c |  2 +-
 drivers/net/failsafe/failsafe.c        | 15 ++++++++++++---
 drivers/net/hinic/base/hinic_compat.h  |  6 ++++--
 lib/eal/include/rte_thread.h           | 15 +++++++++++++++
 lib/eal/unix/rte_thread.c              | 12 ++++++++++++
 lib/eal/windows/rte_thread.c           | 10 ++++++++++
 lib/ethdev/ethdev_driver.c             |  2 +-
 13 files changed, 74 insertions(+), 23 deletions(-)

-- 
2.53.0

