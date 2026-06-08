Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F278CD8C9F
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 15:49:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85D0F402A9;
	Mon,  8 Jun 2026 17:49:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6E657402A9
 for <dev@dpdk.org>; Mon,  8 Jun 2026 17:49:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780933771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TT1aapD1CLRw61G0NJNjY3Jcrk14adl5Q3c6IxqYlGU=;
 b=iEnqTD49bp3loWJGyuXi7jepiYDex7yqSxZ4qgGsUAz6+BLeVHs0WbXSbRN8jv7uI+OzN2
 t0HvApmrjcgbEwkMOXZdY8vpob93GrkaMp9OA0EJgY7fCW9s5ay/Bplh/ejAgsjxZSDW4H
 QvbaaDMGzCGQM4yrTFmfOEgEi3zWTUw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-bZhUUHfVNTm5cShKvIWAmQ-1; Mon, 08 Jun 2026 11:49:24 -0400
X-MC-Unique: bZhUUHfVNTm5cShKvIWAmQ-1
X-Mimecast-MFC-AGG-ID: bZhUUHfVNTm5cShKvIWAmQ_1780933763
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5aa68d012dbso3090412e87.0
 for <dev@dpdk.org>; Mon, 08 Jun 2026 08:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780933762; x=1781538562;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TT1aapD1CLRw61G0NJNjY3Jcrk14adl5Q3c6IxqYlGU=;
 b=j8z8Bc1BUIiBM720ygjwN5B6LrRNOUluTCi5gV/tTodDCeLU36xWwH8GgmZVxbR06O
 9xZicUIYdOc5X9CbUC/YYc3EKedxUAXxSb6bibVVZmqxZ+z69WLJN4HOJ0qYByE2zoiN
 FXk4JZL5P0g5DYrBsa/ovHtlbRJ6feyWGWRkXKdY98YCzCEgUyTeEtatnbpdkuy6wckB
 OuHJ7jROrs2Tetf66qllCeK8gFd5O1VrIKW2bC+Ezx4XHOJgpCVqVMyX7dBTzSHCuIQE
 7bdxZrBebeYNDlstG8BTGA3QEglJITBHNN04mTcC0eN5EDAWBXDful618x7LNDSuiD4U
 pO0Q==
X-Gm-Message-State: AOJu0Yy7FyEl1fgERtyWBzz7SIo6vPBbKLcNBG45hMW0nezGks0XqsYd
 qoTZpZG6kgLb6DdWX6AGUMTnaXDY96/UGGv2vEOeGukvcon//meJf5XQ5DdqDfEaqS5GzAnu5gC
 jt/4ORI0dB8cQ8Tw+KudkV1o1WV0FN9C0gt+mijy8N6rWw0uddn6l35CE9VATW47olRkO3vH8Wy
 SfT8mdBISrEBCz8DuLvP0=
X-Gm-Gg: Acq92OHYHFqxYS2uGxHeR0wNjtKuweo6wtpH7s5KN9GKhlNE8U7IDLgaT2GoQUDMX+I
 pxy4XIpL1VEZTIkS9+ycJ4wIsdMeJ8tUi3GtnzkWkDQ86pMJOZsYpNIlaosanyhQXMyHdZ9hB4k
 Qs8JIylN2A41ijG07WTiqy/EYV2nkz813NgNS0fyZ7MboR2sJDhRiR6sfi0zDLxFP+eBCn1dP6z
 cYVT/oYY0oEoiVgXU8wdf2UbD2m7q7Oo3QSzG+JKzxSqOoYZf4hOwM1E1CVZoL4+n7qiWJFU+bj
 ycDQ
X-Received: by 2002:a05:6512:1501:10b0:5aa:71de:74ca with SMTP id
 2adb3069b0e04-5aa87bddd26mr2879644e87.28.1780933762454; 
 Mon, 08 Jun 2026 08:49:22 -0700 (PDT)
X-Received: by 2002:a05:6512:1501:10b0:5aa:71de:74ca with SMTP id
 2adb3069b0e04-5aa87bddd26mr2879631e87.28.1780933761860; Mon, 08 Jun 2026
 08:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260422075414.2528455-1-maxime.peim@gmail.com>
In-Reply-To: <20260422075414.2528455-1-maxime.peim@gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 8 Jun 2026 17:49:09 +0200
X-Gm-Features: AVVi8Cek8UegEw5jwOdpFEgWPvncFET85WGUkXxB_WVrAqYlm1KKsfSGISv0-D8
Message-ID: <CAJFAV8wd4Odtghr1qYHo0j+WZFdFTRHnjYOFrovjQbWwOH6zOQ@mail.gmail.com>
Subject: Re: [PATCH] eal: fix core_index for non-EAL registered threads
To: Maxime Peim <maxime.peim@gmail.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, 
 Slava Ovsiienko <viacheslavo@nvidia.com>
Cc: dev@dpdk.org, Matan Azrad <matan@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dxBOUY74ASqJPQMbAtZbomN-IPhnkOh4FMqCSohGwbU_1780933763
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

Hello,

On Wed, 22 Apr 2026 at 09:54, Maxime Peim <maxime.peim@gmail.com> wrote:
>
> Threads registered via rte_thread_register() are assigned a valid
> lcore_id by eal_lcore_non_eal_allocate(), but their core_index in
> lcore_config is left at -1. This value was set during rte_eal_cpu_init()
> for lcores with ROLE_OFF (undetected CPUs) and is never updated when the
> lcore is later allocated to a non-EAL thread.
>
> As a result, rte_lcore_index() returns -1 for registered non-EAL
> threads. Libraries that use rte_lcore_index() to select per-lcore
> caches fall back to a shared global path when it returns -1, causing
> severe contention under concurrent access from multiple registered
> threads.
>
> A concrete example is the mlx5 indexed memory pool (mlx5_ipool), which
> uses rte_lcore_index() in mlx5_ipool_malloc_cache() to select a per-core
> cache slot. When core_index is -1, all registered threads are funneled
> into a single shared slot protected by a spinlock. In testing with VPP
> (which registers worker threads via rte_thread_register()), this caused
> async flow rule insertion throughput to drop from ~6.4M rules/sec to
> ~1.2M rules/sec with 4 workers -- a 5x regression attributable entirely
> to spinlock contention in the ipool allocator.
>
> Fix by setting core_index to the next sequential index (cfg->lcore_count)
> in eal_lcore_non_eal_allocate() before incrementing the count. Also reset
> core_index back to -1 on the error rollback path and in
> eal_lcore_non_eal_release() for correctness.
>
> Fixes: 5c307ba2a5b1 ("eal: register non-EAL threads as lcores")
> Signed-off-by: Maxime Peim <maxime.peim@gmail.com>

Thanks for the fix Maxime, it looks correct though I am a bit
skeptical about usage of this API with dynamic thread allocation.

In the net/mlx5 context, for example, I expect no memory saving from
using the lcore "index": mlx5 is allocating an array with
RTE_MAX_LCORE+1 entries.
Using rte_lcore_id() would probably be good enough.
Dariusz, Slava, any opinion?


-- 
David Marchand

