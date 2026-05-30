Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931A6CD6E49
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 May 2026 16:11:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56DDC4029F;
	Sat, 30 May 2026 18:11:57 +0200 (CEST)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTP id 8AD4440264
 for <dev@dpdk.org>; Sat, 30 May 2026 18:11:55 +0200 (CEST)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-134fe980658so17702052c88.1
 for <dev@dpdk.org>; Sat, 30 May 2026 09:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780157514;
 x=1780762314; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1FbQBlpQ3K7YmySV0VgNXSg7hjvSWrD8hLhjw+JPTKc=;
 b=ja8urm2OgXY1dU6APnLp9YgGlAvXeX1qBnBKA/cNImSE3Uh6fzIhgYJHa+D3bk30r1
 n92WGVDsO6sXRAhY7gpxuwoU6TaLp52e3qzsdyz1K9qEKjMz+uGmmLVHAe2KH26AN7wC
 UCsS35wOLER6CklCKk1spEVd2vo1j6nM+cG7bmvwtmUT9PIIJFCCDJWQNvPi+BgQLEOG
 /lOWpCfY2+sn6+SpQTWp1AukaOvwxwEcByRY5z8L1OC813MMe0xj8NXubuvDcy0GiMWg
 xvh3/fGpDpUFvLQ32Q3Nf6fzNMGBhq8MrCkuShCmW+iBEdab/EqW/IEZQvl29pOqZ93n
 buiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780157514; x=1780762314;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1FbQBlpQ3K7YmySV0VgNXSg7hjvSWrD8hLhjw+JPTKc=;
 b=U5OpfbKRCaScnbeH6yiGoZHE5wt1LUMm7E/92b+Fp1R+diFJvlesk5Fkbr4cQe2ez1
 pueS+z2fwSSCTypqUUZcL+dHunpRDmG+W4QLxX2ZlZN4kmQEO2tIjoWlqUZrWvMS3mAZ
 setxpSQKSd5tVKF4zMe5Ju5EVDkj91/P5Z2YTu023IAOJKn+ZcbtH4KtBqO73RC186hv
 oiJQjA79zlMJC+V5oonJ14db/4idgHZmo1q5tmvLlJRcArqNqlf4ehbF4speMTjwSdCs
 q80gne5Rw2MsXrhtsqOp6OoYgQf3RPmhnPF1K9wgQs/YxqNhPjmu3tRS5Lozte4XBcDv
 GYDA==
X-Gm-Message-State: AOJu0YyuyWPRfnbE6lbFMI6Hk8P3KR6Cm7lAaVoUlKoViZsYJU4GIxhl
 W4WONuJPs0DVrTlJIdvhjcCMFkmhIcA19t0OECwUHw6IE+qksTygfHClekRHM09dc36faweil+U
 ut7U9
X-Gm-Gg: Acq92OGj4FfiZhnvJZbRs4Fs/g5Yv0FTxhn3DJi8BnbxE0lNxi38oQXyvTjbQi1QY2T
 Hjnkl567JiteW1rg2c+DCzrtBZAmXikBLYOoCHs0xv1yXcNu2bweYBr94hnRAVexpkXa3plToPT
 9ShN/dxDqp/x6/zFhAbytnY6VAmXqZ/Ipz9YcVpRwq9qsdNnuYmoPU3lqxNJpsHJoqJrR0pqWPF
 M3mR7D1g25Zeq0NOEkO2x1E16BZPWQfXfzvsPMYJr7TYZd3DZk4RRVhbyFMMx2JXylldOv2NhIp
 Ys9DgSNOs59gHgEa1RLzbkMc+eXtE+Qqj036943EEW/X8gyLkFCW71MiYphHtGLFwkykr9UAHQc
 Gsst9pykmeVGCmzdWsv1+qR0FsFRoD7ytmLypxS4gHiA+5Di8bB06dgf0rq9WjasiYiwAUJt4um
 ebgKTu0kh1Tj9qWSxM5eZzSvYX7moj+TJ9QWGpFGUNN5AsUu7+vPYVOzMyX8gBojt91MtPXx/u
X-Received: by 2002:a05:7022:4b:b0:130:c9cc:3395 with SMTP id
 a92af1059eb24-137d413272bmr1575237c88.29.1780157514171; 
 Sat, 30 May 2026 09:11:54 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137b3c69bdfsm3305616c88.9.2026.05.30.09.11.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 09:11:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 0/7] Complete removal of queue stats mapping
Date: Sat, 30 May 2026 09:09:55 -0700
Message-ID: <20260530161151.873199-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

This is an RFC against 26.11, where the ABI break from removing the two stable
symbols is expected. The Removed Items / ABI Changes release notes entry will be
added once the 26.11 notes file is opened.


Stephen Hemminger (7):
  net/virtio: remove unused queue stats mapping
  net/enic: remove queue_stats_mapping ethdev_op
  net/cnxk: remove queue stats mapping
  net/e1000: remove queue stats mapping
  net/ixgbe: remove queue stats mapping
  net/txgbe: remove queue stats mapping
  ethdev: remove support for queue stats mapping

 doc/guides/nics/features.rst           |  7 --
 doc/guides/rel_notes/deprecation.rst   |  6 --
 drivers/net/cnxk/cnxk_ethdev.c         |  1 -
 drivers/net/cnxk/cnxk_ethdev.h         |  6 --
 drivers/net/cnxk/cnxk_stats.c          | 76 ++++++++------------
 drivers/net/enic/enic_ethdev.c         | 11 ---
 drivers/net/intel/e1000/igc_ethdev.c   | 54 ++------------
 drivers/net/intel/e1000/igc_ethdev.h   |  2 -
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 97 --------------------------
 drivers/net/intel/ixgbe/ixgbe_ethdev.h |  9 ---
 drivers/net/txgbe/txgbe_ethdev.c       | 87 ++---------------------
 drivers/net/txgbe/txgbe_ethdev.h       | 13 ----
 drivers/net/virtio/virtio_ethdev.c     | 21 ------
 lib/ethdev/ethdev_driver.h             | 11 ---
 lib/ethdev/ethdev_trace.h              | 20 ------
 lib/ethdev/ethdev_trace_points.c       |  6 --
 lib/ethdev/rte_ethdev.c                | 62 ----------------
 lib/ethdev/rte_ethdev.h                | 45 ------------
 18 files changed, 45 insertions(+), 489 deletions(-)

-- 
2.53.0

