Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0B0CD8C92
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 16:10:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4116140666;
	Mon,  8 Jun 2026 18:10:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8CAC04029D
 for <dev@dpdk.org>; Mon,  8 Jun 2026 18:10:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780935019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CGnqNu3HPFYI1sQcvTafOxUWUvtZMrkVQqENKw8/Wb8=;
 b=ILHawZvBFU71JIDFIpibJP7GNaSquf+FtFkkjNhoCZ8aYXkWPgKOG9htL8lX+Om45EkMUu
 8utL546PyBIO2tBKZ6NG1aMQWQAZmvs8p2JRPCCgz04YpS5NndwcKYDhipk5ODjIHKbbs6
 wbJGaFSOThk9Euak4Nfq+ABV8H73DsA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-EVinYzgCOCmtIQTKLadIsA-1; Mon, 08 Jun 2026 12:10:18 -0400
X-MC-Unique: EVinYzgCOCmtIQTKLadIsA-1
X-Mimecast-MFC-AGG-ID: EVinYzgCOCmtIQTKLadIsA_1780935017
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5aa68daac65so2668339e87.2
 for <dev@dpdk.org>; Mon, 08 Jun 2026 09:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780935017; x=1781539817;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CGnqNu3HPFYI1sQcvTafOxUWUvtZMrkVQqENKw8/Wb8=;
 b=rLm4aEeYsIcm2ee5iRDV1uh7ljHzR9f3vuqpr/QO+F5aWDauTCt3gms5NVyqjJJ9xt
 dNbDk724NvymIqDdXtexV3im1WTJ/hPdzFqH92LkNb8H0tHTSVAVL/TARMUYkrBEJmSj
 g1vecdnL7F0X3BS3BtOox330l72i1xU7o63LP1EgXHjRDgz73CwCbEMya82TrIMmx13K
 wJmmiZO3x/pEB6Us74hl0YXrtEsUV/Ll/IiqENPSNBO189FQcKbAAwFOd44pY1VnotrJ
 Utz2xJYGe/1yodKxZk544kIGT4+wcpf1God1elP21KUJEULvaQZ1H7hVJzKMsCe/b46x
 6c1Q==
X-Gm-Message-State: AOJu0Yx4XcS8yAbzuVoXMWgVHI09gNDbsK0/4QC9ILeqRYUGECRlR+/h
 ih7leSt0qHQ28+yF2Xd2JaD39OleMxjLoLW1Ng2RZCrGu/2OS28GGmjCxMGiQ9GMRwW9EP12IsV
 R356f+q2KK65xXJFbvXT0jht5yjelnp6SJQcLku9kqSC/OavDt69ZrN7ot6vmVpo53bs11FbbX2
 AaALrXF61AjUYAY5dd1j0=
X-Gm-Gg: Acq92OFI3e7xDA4VvYJuC8ioGZTKVQXxeecwLV2wiAvw8xi87oEqfBSjRBXEhkVoqGH
 BYjnhOp9INpHp4svR9aqBj/lrBh6qCf1TGjVI6heikMAmsRHlFsAgzIf5Yzx53urxM2O9bMR3Ix
 jIGLOFyeNKledRH9qPGc2J07UcoFhXmHcCK1LwLYG+8KJExWEAuGehJVAEG8fzUPXtL5jzo6GuV
 c690/Q8EeNQPeU8f1LbJFnKx0cVHfen7Ykf9Pe8tfU9pK/dmKQbAzKbKwh7qGXMjwDUWHZIcfSQ
 FrDQ
X-Received: by 2002:a05:6512:130e:b0:5aa:7126:c663 with SMTP id
 2adb3069b0e04-5aa87b62d6cmr4947216e87.5.1780935016743; 
 Mon, 08 Jun 2026 09:10:16 -0700 (PDT)
X-Received: by 2002:a05:6512:130e:b0:5aa:7126:c663 with SMTP id
 2adb3069b0e04-5aa87b62d6cmr4947194e87.5.1780935016169; Mon, 08 Jun 2026
 09:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260422075414.2528455-1-maxime.peim@gmail.com>
In-Reply-To: <20260422075414.2528455-1-maxime.peim@gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 8 Jun 2026 18:10:03 +0200
X-Gm-Features: AVVi8CcVI85-cPpSpHaZCKo4qHEz3hgtZHAglI0XpMXCoov0Lv81xW1gQoTyc8s
Message-ID: <CAJFAV8wn26hRUTzCG4ai+apT8+bWL7+cEE1N-gV1tJt8B9a4hQ@mail.gmail.com>
Subject: Re: [PATCH] eal: fix core_index for non-EAL registered threads
To: Maxime Peim <maxime.peim@gmail.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yJkFrAvUiMzpiPOiVvEH-ynig9ztqqTBTo1kv23rcfE_1780935017
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
Cc: stable@dpdk.org

> Signed-off-by: Maxime Peim <maxime.peim@gmail.com>
Acked-by: David Marchand <david.marchand@redhat.com>

Applied, thanks.


-- 
David Marchand

