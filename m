Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38599C531CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 20:29:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEF29402EA;
	Thu, 23 Jul 2026 22:29:41 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id 4CE4940280
 for <dev@dpdk.org>; Thu, 23 Jul 2026 22:29:40 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-38e69bdb0fcso867482a91.1
 for <dev@dpdk.org>; Thu, 23 Jul 2026 13:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784838579;
 x=1785443379; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wB0sQJ9N20Cx1te9gjm0JZaa/mPef/F7mJvlfZy4ACE=;
 b=MwO5HBnsYI9LGdZALhQ+cZVjGJa20qqxtW6EIb3pyjthQx2F7o363CbmRsQpbqfMTR
 GKJSwGq045zehDSbq4JEHxdbZ0XCz5ugoFA28aQS+cUhQZbkA7eyssu9d7rSA54mFXc3
 i1EXRxCpJtzlqSVNEq/rsTTsDfTMkn1fTyMfAyDCh0Y0ZDcup2Ncpxgpi9NNw+pxhNLq
 gslm3Wa5ru2oFWfbAGpwUTGeeRbgpmjyZl9mDUEQB/SGTjmkKVnKoEoFKaCatJkXbpkT
 UJj1UBzrfHB5phWTUKKmQFPBq8OiCmbhSEqd2Fmq2zTdqEDHaXTZhe/NGCF2Zdwf6Q+q
 QogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784838579; x=1785443379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wB0sQJ9N20Cx1te9gjm0JZaa/mPef/F7mJvlfZy4ACE=;
 b=RNurmxf0b9jZZI71lNypF7KCRDEIPq05pdZuRwYjiiidTiKv/HKneUNOeXkcsfcffz
 rfXp5n9pzkpvHqd1NXWMdmtZeMCRyFU0CbRVYdtuanCakj6WyLcuCl9p8k0dA5alEm87
 B9ew1wdUhqP4mhbBbIIklc7qzqzFdFRBatMfS5bSF31UnU2vboyNynoaZxfllHumabQi
 uTfLxGln0VBzvi92Rewet1pP3UurSy3AOj+MCYNXSTIYCie7SwhrVO/vPQMqgV21dzS3
 eK/7O2QDBxVJqwV+D5kaIZ+SFgfRmP4S0tXKlbKVLC8mTJiKSBjaEqHEcS49SXCkKdt9
 YCVg==
X-Gm-Message-State: AOJu0YwmSFf8r7MhX7869S0JV7buXr64+GMS3+o1sPv88M3wPVLUQSC2
 9uWlWqHmwMiDG/rItSOtvYSOTIvhofgPZmx60GpYM6W7oGyX7xyXI8gci0Wvs9IhSycTG6szp+G
 r3QAj
X-Gm-Gg: AR+sD11LQGuVFft4zl6mUe+kkMi6z0HOmcMz8fT6dvtRi2yDVJFpX384BV6go87qZGo
 JcTHJsQa9rT/I6ZrER3yVlzDAL1v7lOpWQM0K/x3GAC/8uRxeVhwiDi/rXdjcLcf2CKJvKBLrpR
 QRevkMXaZMKxS99xbsVCR2TUnT7kK6FKHE6kKNiHoNb/pmXGdU1a+D0+YDm9hAV4eMwRWgfmb9B
 W/2EH/9zAjNqku3RraJJa12uAW62xYg2FWI16qfGeLSLJ7nsJdmMKASldIbhc5azRZOAX+QMKyd
 iFKsGV5/rKEbSRtcOGX0xaihfBc58tu6H7zZgbTriqKQ1V0QM9Ir6V7kygaY4Q9V8+gMnTxk7nA
 HCkHbazAzmsUhEmVOv4dMzJG/KDmjLlszpnaDUFo/Fs9ejDKORXKiH73IobKeQJxm5WOdN8ClmX
 4GiS+vKq/dLMQVMwSJjl6sM89tMOiZMheUzkARpTda
X-Received: by 2002:a17:90b:1642:b0:37f:f4ae:5f25 with SMTP id
 98e67ed59e1d1-38ec6a51c61mr4203103a91.20.1784838579063; 
 Thu, 23 Jul 2026 13:29:39 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d12f267fdsm18864877c88.0.2026.07.23.13.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 13:29:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/9] Complete removal of queue stats mapping
Date: Thu, 23 Jul 2026 13:28:05 -0700
Message-ID: <20260723202936.378793-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530161151.873199-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
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

The per-queue stats mapping mechanism (rte_eth_dev_set_{rx,tx}_queue_stats_mapping
and the queue_stats_mapping_set ethdev op) was a workaround for hardware that
could only expose a limited number of queue stat registers. It let an application
fold many queues onto a small set of counters. Since 25.11 queue statistics are
filled in directly by the ethdev layer indexed by queue id, so the mapping is no
longer needed; the functions were deprecated then by commit 2863cbd9ee6d.

This series finishes the job. The drivers that still implemented the op are
converted to report queue stats directly by queue id (bounded by
RTE_ETHDEV_QUEUE_STAT_CNTRS), and the op, the two public functions, their trace
points, and the documentation are removed from ethdev. The leftover per-driver
mapping tables, accessor macros, and init code go away with them.

Also, found some leftover bits from the earlier removal.

Stephen Hemminger (9):
  net/virtio: remove unused queue stats mapping
  app/testpmd: remove unused function prototype
  net/enic: remove unneeded ops initialization
  net/cnxk: remove queue stats mapping
  net/e1000: remove queue stats mapping
  net/ixgbe: remove queue stats mapping
  net/txgbe: remove queue stats mapping
  net/sxe2: remove queue stats mapping
  ethdev: remove support for queue stats mapping

 app/test-pmd/cmdline.c                 |  6 --
 app/test-pmd/testpmd.h                 |  2 -
 doc/guides/nics/features.rst           |  7 --
 doc/guides/rel_notes/deprecation.rst   |  6 --
 doc/guides/rel_notes/release_26_11.rst |  5 ++
 drivers/net/cnxk/cnxk_ethdev.c         |  1 -
 drivers/net/cnxk/cnxk_ethdev.h         |  6 --
 drivers/net/cnxk/cnxk_stats.c          | 76 ++++++++------------
 drivers/net/enic/enic_ethdev.c         | 11 ---
 drivers/net/intel/e1000/igc_ethdev.c   | 54 ++------------
 drivers/net/intel/e1000/igc_ethdev.h   |  2 -
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 97 -------------------------
 drivers/net/intel/ixgbe/ixgbe_ethdev.h |  9 ---
 drivers/net/sxe2/sxe2_cmd_chnl.c       | 99 --------------------------
 drivers/net/sxe2/sxe2_cmd_chnl.h       | 10 ---
 drivers/net/sxe2/sxe2_ethdev.c         |  5 --
 drivers/net/sxe2/sxe2_stats.c          | 76 +-------------------
 drivers/net/sxe2/sxe2_stats.h          |  5 --
 drivers/net/txgbe/txgbe_ethdev.c       | 87 ++--------------------
 drivers/net/txgbe/txgbe_ethdev.h       | 13 ----
 drivers/net/virtio/virtio_ethdev.c     | 21 ------
 lib/ethdev/ethdev_driver.h             | 11 ---
 lib/ethdev/ethdev_trace.h              | 20 ------
 lib/ethdev/ethdev_trace_points.c       |  6 --
 lib/ethdev/rte_ethdev.c                | 62 ----------------
 lib/ethdev/rte_ethdev.h                | 45 ------------
 26 files changed, 53 insertions(+), 689 deletions(-)

-- 
2.53.0

