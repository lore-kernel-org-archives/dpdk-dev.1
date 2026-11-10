Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879EB60A5BCE
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f9UgNwDW
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AEFD40281;
	Tue, 10 Nov 2026 18:40:05 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 2E1D74026C
 for <dev@dpdk.org>; Tue, 10 Nov 2026 18:40:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794332402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WlGIOsWgQV4gQAzv/eSLBSJREVakwUsM1DdLitINQVI=;
 b=f9UgNwDW0R/dwPOB7oHObHtFo0t3zWWYcll5E+IyNf1qu/ER8SI7BlowdVqlt8Q/YETeT8
 OTGnKeIegitX667m6AHijxqIXgxxt6FWvA7j+J9TARvVPzNZdIowYbwACHbyz8NEnYfq7I
 Y8CWTxaJUr+M0azQH7vjdbqNglnkRCA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-hK8JOOi5ML2OGtrpNP4I5w-1; Tue, 10 Nov 2026 12:40:01 -0500
X-MC-Unique: hK8JOOi5ML2OGtrpNP4I5w-1
X-Mimecast-MFC-AGG-ID: hK8JOOi5ML2OGtrpNP4I5w_1794332400
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5c1595d5031so518367e87.2
 for <dev@dpdk.org>; Tue, 10 Nov 2026 09:40:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794332400; x=1794937200;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WlGIOsWgQV4gQAzv/eSLBSJREVakwUsM1DdLitINQVI=;
 b=hucG1RJpbgMu++F1jA9aREiWnRyuRqafmj6bmAqVMiu5O2IQ9np6YLx17f4io9Jeq0
 qhEbJkevsMu4e4dcvCn8WXFTydmTyGuIm6Ya/z43oyfyrj6Axjn/424d9oy8FejgFeoy
 I8euGIwDRNbMmBhHPNLrg2EDaeClcLI31IEr6Hs8ojCpmhdhWrMhrC9jcy88yC7ecOOp
 LrEJXwJQ9193BAamNnX79d9FJ9k1HKCSgOcTahxv+H6g6jwyWTzaiqUN/grtAzvurKeL
 8Z0ls0KoYJuYYevrSJ5F5Jc3rKmZ/miu7qPDEJcx9Zg8+r/QLwwn46bm+KIwK443fl/+
 Og0w==
X-Gm-Message-State: APuU4Z/+G6fXlYPCQ2jrDYUXmwHLJHW0EICYCgsMHYKm9RlR6gZRKKCu
 F5DENb+IU8sH3QXeBgZP7P/rmMcnvMXt6DaWFEkcIMrvgqJp04DmnMZxuKRUnkQbQVkZ00ACqoM
 jEt9TtCZEOQNBoqz5B3I0r85OTfyhoSn4RXyUtIQgKb00gUE/ZljyhmRMBkymb4qqtLBK4YY9Uo
 QoV3RuMkrHG4/JucELCs4=
X-Gm-Gg: AYBFou0xUH1wrkG/Vbe3ym6fvIzK+DcWqjL99oq8bOZmDBE9Pu6+h2c0YZg4GFHnTuy
 dH0GNWGp5olpqjoCi+ePzZqFz87/R92bqJ25kjsiinXVNgzoCFPQk7e6TLQuWujpobk0sOnf8bh
 qm4pIWyIlc2MGhz5xAxk26yV5tpk0auK3+aHaTZnyl5RvLTrCcjaFXeGRsi4jrE0qNaVjJeFSGx
 2DjfzqRPDU4+vFiNPnfTp+ELv0zh/YU2Iri0YhJUwaG844N
X-Received: by 2002:a05:6512:3408:b0:5c1:465b:ebe3 with SMTP id
 2adb3069b0e04-5c156e9ed83mr1072788e87.13.1794332399725; 
 Tue, 10 Nov 2026 09:39:59 -0800 (PST)
X-Received: by 2002:a05:6512:3408:b0:5c1:465b:ebe3 with SMTP id
 2adb3069b0e04-5c156e9ed83mr1072774e87.13.1794332399212; Tue, 10 Nov 2026
 09:39:59 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105071710.3640765-1-mkashani@nvidia.com>
In-Reply-To: <20261105071710.3640765-1-mkashani@nvidia.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 10 Nov 2026 18:39:47 +0100
X-Gm-Features: AclHuK9DjT4GVEKfB3rx1UQUuBL463bNN0Gm0uSnZTcrxUHHkCsvUPMucuS7I04
Message-ID: <CAJFAV8ybHYq+Ta10RV5goTUsQy40esX82o59GAUDzZ7uDn+nhg@mail.gmail.com>
Subject: Re: [PATCH] eal/linux: fix dirty flag for reused hugepages in legacy
 mem
To: Maayan Kashani <mkashani@nvidia.com>
Cc: dev@dpdk.org, anatoly.burakov@intel.com, dmitry.kozliuk@gmail.com, 
 stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sEQ_VQIVqLK4zfDMciFH4Qjq5_gFxE6nutmzw9F0TYk_1794332400
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 5 Nov 2026 at 08:17, Maayan Kashani <mkashani@nvidia.com> wrote:
>
> With --huge-unlink=never the hugepage files are kept and mapped again
> on the next run. The kernel only zeroes a hugepage the first time it is
> mapped from a given file, so these pages still hold the previous run's
> content.
>
> The dynamic memory path records this by setting RTE_MEMSEG_FLAG_DIRTY
> in alloc_seg(). The legacy path in remap_segment() never sets ms->flags,
> so rte_zmalloc_socket() skips the memset and returns stale data.
>
> With --legacy-mem --huge-unlink=never, a second process gets non-zeroed
> memory from rte_zmalloc(). mlx5 with sys_mem_en disabled allocates its
> internal structures through rte_zmalloc_socket() and then reads stale
> pointers from them, which crashes in mlx5_ipool_malloc_cache() during
> probe:
>
>   SEGV on unknown address 0x000000000308
>     #0 _mlx5_ipool_malloc_cache drivers/net/mlx5/mlx5_utils.c:550
>     ...
>     #16 mlx5_alloc_shared_dr drivers/net/mlx5/linux/mlx5_os.c:628
>
> Set RTE_MEMSEG_FLAG_DIRTY on segments remapped in legacy mode whenever
> existing hugepage files are reused, matching the dynamic path. Why a
> reused page is dirty is documented on unlink_existing.
>
> Fixes: 32b4771cd8ef ("eal/linux: allow hugepage file reuse")
> Cc: stable@dpdk.org
>
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> Acked-by: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>

Applied, thanks.


-- 
David Marchand

