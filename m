Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16A0C531F9
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Jul 2026 07:39:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B768402A7;
	Fri, 24 Jul 2026 09:39:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id C821C4029B
 for <dev@dpdk.org>; Fri, 24 Jul 2026 09:39:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784878784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pk8tkY4A3DgxjWM/nkvN+3cW6QzmEujqYuWKL4xlfcc=;
 b=WVjz31SZQeKIAvsngeG9ac8K4pN6mAjr1EyvlbOX+N/HZbTmiLA/cmNoxTsaAaOfKZBfh9
 45mDIPv6jLLWgH02Oi2QUwiZUfKse4qBkV2XDi841IdPmVfR9OtKhsPGS3698/2YhgcQXy
 OgMkPpKGtCOw8CVMfRzOIFPmk9iel08=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-3tiJYVwyPmCMvJYHg_rd5Q-1; Fri, 24 Jul 2026 03:39:42 -0400
X-MC-Unique: 3tiJYVwyPmCMvJYHg_rd5Q-1
X-Mimecast-MFC-AGG-ID: 3tiJYVwyPmCMvJYHg_rd5Q_1784878781
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5b2a35b9306so102999e87.1
 for <dev@dpdk.org>; Fri, 24 Jul 2026 00:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784878781; x=1785483581;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pk8tkY4A3DgxjWM/nkvN+3cW6QzmEujqYuWKL4xlfcc=;
 b=HzWIGnLB0KfZFh7OiV4H6116pgEXe0fTmgwcQnE9jMOxhdxbv86ayLzK7SbTGibqAH
 mBU6qKiM8TFVh1i0LFARnDPId7ESUAKF9VGvC05hBxBTAGI/+qOD0WJCP+pnEW6uiuRT
 3AjlU0XWgO9Duv3ZU7Q4sMhosYFhESo4nAGXEirgGmdoAXGhksG4j+AfOpSxlNd0PMRl
 ziaweDgRCWNgyREigJwn0SQOcscpRwzPVqVAtkBXC+PWs0+Bw/Hqf1Ev2oDYjGzrCvCa
 60lntKuMYawDS7zwN5eZyy4UMMnLSBwjeAdqurHrN+4Tw6r390G3GuLvRVkSPCJ3x0dr
 5MhA==
X-Gm-Message-State: AOJu0Yy1t1PC++Sx2De4JJNZEvjM3vwEI0NAqpDA62VH+cYT0reGzyiv
 z7iGxHcaFcKt5cqi9E5wEWH3oqYMG9PKBB7gxZAR8Au2mjnMjxGj4P9NfknAjd0BiJkzNufLbnM
 GRo/7E7n5AUmWZsEyJPs64h49UE+NAkupgf/Zklk+Vk636OqZ9ah6eq8MnJ3v/yMJUTM0pDioYJ
 r6tDe7Uc0/Fn+WLi6jb44=
X-Gm-Gg: AR+sD13VGl+cRXiXreFdnGCtx1n+8xbC/5jB6lw9qFe4ikuSbY1jWapZNSLk3ayNqB9
 4tcdbVZ4R9jaTARXVBFWb6OADAAC8urFHiTZ07S962JlNWykU/JE2RlavrgCT9LsxSqXNZHs+6h
 tnoBx1+XNgnQFe4PKtvxfh+sKJMr/n8yGtIkEK3G5QP5YBh+t9hHk4VWg+gBqCPxqx1Micnczdi
 3ICKdj4BfnOverhBnRDtiIum0WDNbiX/bne4dr4JvDOSVJJ
X-Received: by 2002:a05:6512:3406:b0:5b0:eda:de1f with SMTP id
 2adb3069b0e04-5b2b2e4d197mr1568998e87.6.1784878781144; 
 Fri, 24 Jul 2026 00:39:41 -0700 (PDT)
X-Received: by 2002:a05:6512:3406:b0:5b0:eda:de1f with SMTP id
 2adb3069b0e04-5b2b2e4d197mr1568989e87.6.1784878780651; Fri, 24 Jul 2026
 00:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260723202936.378793-1-stephen@networkplumber.org>
In-Reply-To: <20260723202936.378793-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 24 Jul 2026 09:39:28 +0200
X-Gm-Features: AUfX_mxgQ6Z_X1Lm9gE-xFszra53xuZHvJvfseJmlAf1AyL6cdjhPyJVEjbEd_Q
Message-ID: <CAJFAV8ycF5hQESdDGfkCKCuu+05SAepB6abu7Voks19_=A5Wdg@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Complete removal of queue stats mapping
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uWZSqfDZMpvc_vU6lzltOkaJ14yCSVSU3OuE2WV5RXE_1784878781
X-Mimecast-Originator: redhat.com
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

On Thu, 23 Jul 2026 at 22:29, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> The per-queue stats mapping mechanism (rte_eth_dev_set_{rx,tx}_queue_stats_mapping
> and the queue_stats_mapping_set ethdev op) was a workaround for hardware that
> could only expose a limited number of queue stat registers. It let an application
> fold many queues onto a small set of counters. Since 25.11 queue statistics are
> filled in directly by the ethdev layer indexed by queue id, so the mapping is no
> longer needed; the functions were deprecated then by commit 2863cbd9ee6d.
>
> This series finishes the job. The drivers that still implemented the op are
> converted to report queue stats directly by queue id (bounded by
> RTE_ETHDEV_QUEUE_STAT_CNTRS), and the op, the two public functions, their trace
> points, and the documentation are removed from ethdev. The leftover per-driver
> mapping tables, accessor macros, and init code go away with them.
>
> Also, found some leftover bits from the earlier removal.
>
> Stephen Hemminger (9):
>   net/virtio: remove unused queue stats mapping
>   app/testpmd: remove unused function prototype
>   net/enic: remove unneeded ops initialization
>   net/cnxk: remove queue stats mapping
>   net/e1000: remove queue stats mapping
>   net/ixgbe: remove queue stats mapping
>   net/txgbe: remove queue stats mapping
>   net/sxe2: remove queue stats mapping
>   ethdev: remove support for queue stats mapping
>
>  app/test-pmd/cmdline.c                 |  6 --
>  app/test-pmd/testpmd.h                 |  2 -
>  doc/guides/nics/features.rst           |  7 --
>  doc/guides/rel_notes/deprecation.rst   |  6 --
>  doc/guides/rel_notes/release_26_11.rst |  5 ++
>  drivers/net/cnxk/cnxk_ethdev.c         |  1 -
>  drivers/net/cnxk/cnxk_ethdev.h         |  6 --
>  drivers/net/cnxk/cnxk_stats.c          | 76 ++++++++------------
>  drivers/net/enic/enic_ethdev.c         | 11 ---
>  drivers/net/intel/e1000/igc_ethdev.c   | 54 ++------------
>  drivers/net/intel/e1000/igc_ethdev.h   |  2 -
>  drivers/net/intel/ixgbe/ixgbe_ethdev.c | 97 -------------------------
>  drivers/net/intel/ixgbe/ixgbe_ethdev.h |  9 ---
>  drivers/net/sxe2/sxe2_cmd_chnl.c       | 99 --------------------------
>  drivers/net/sxe2/sxe2_cmd_chnl.h       | 10 ---
>  drivers/net/sxe2/sxe2_ethdev.c         |  5 --
>  drivers/net/sxe2/sxe2_stats.c          | 76 +-------------------
>  drivers/net/sxe2/sxe2_stats.h          |  5 --
>  drivers/net/txgbe/txgbe_ethdev.c       | 87 ++--------------------
>  drivers/net/txgbe/txgbe_ethdev.h       | 13 ----
>  drivers/net/virtio/virtio_ethdev.c     | 21 ------
>  lib/ethdev/ethdev_driver.h             | 11 ---
>  lib/ethdev/ethdev_trace.h              | 20 ------
>  lib/ethdev/ethdev_trace_points.c       |  6 --
>  lib/ethdev/rte_ethdev.c                | 62 ----------------
>  lib/ethdev/rte_ethdev.h                | 45 ------------
>  26 files changed, 53 insertions(+), 689 deletions(-)

I sent two comments but the series itself lgtm.

For the series:
Acked-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

