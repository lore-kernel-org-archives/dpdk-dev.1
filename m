Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97D9606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TmBVIZki
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DA2940276;
	Fri, 23 Oct 2026 16:42:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 672A340265
 for <dev@dpdk.org>; Fri, 23 Oct 2026 16:42:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792766519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=08AobnvrXy81RxnWm49OWnn6w1HO/bpH9Wzh6w9iopw=;
 b=TmBVIZkiM7NUsH1wj36guf1Oz3TD26B7iiU0D6buRneporM01EC/CbtDUsvVFmuqvLFNzA
 zbnX2YYhMmbqnJy52rCOeWddLR40cZo0k593FheuzgtLGjhgNjqXeJGZ2biM3UIaq5gd6W
 Kjx31sAesABO4jh36Fsmd7mLZBmLLCE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-8QcRFKtaNPSrIdIQLqiU2w-1; Fri, 23 Oct 2026 10:41:58 -0400
X-MC-Unique: 8QcRFKtaNPSrIdIQLqiU2w-1
X-Mimecast-MFC-AGG-ID: 8QcRFKtaNPSrIdIQLqiU2w_1792766517
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3ab3089df39so3990081fa.0
 for <dev@dpdk.org>; Fri, 23 Oct 2026 07:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792766517; x=1793371317;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=08AobnvrXy81RxnWm49OWnn6w1HO/bpH9Wzh6w9iopw=;
 b=ej1rTr4iYljfVsPcpCxHw3leZBMW3Txk2WKUqCybnT/xwo8giTM5C2GmSXh2tsHu8q
 BG5Q91IP2x2JNw63Vkk2gnlFkizGslpU7pDOn6mkgj+kLagJoEDd0PBSkvoeVLznmQm0
 eR+D224zRL9ZbeZnsmnj3qpZSwwgy/zfGcRLkRKsUmTDehwKFmPZXydq2d5ytQglKsca
 CLtbPCfLZMAxK8B7qdr6iPpj+TOq23TC81Dhe0JD8waDBvdmsh9mLd4iteVKOZoSJygW
 z+ZrKqwhO2N860oJkZI/8dGxgxjU4eswQCf8kx24kjO818LJfcSy/qv/y2KYV2QT8tt3
 3oxw==
X-Gm-Message-State: AFq9FYIZXaSYSce5G9C6sD0TUrIRBhHlct6wIVuUzuNKkRs+IbnFrlIl
 XP3WuTVbZoQNPjs98Q1heRWEyi6a6zIQV3bta0SznsmaulkN06j37AZCgtISXcdclRg/EoGcVY3
 +BV+TyvHUhZaSNsnA0BFYoedPuzWxc4M1bTzlR0dsDOnod9+8WsKP+6DGv3R3bfIoJcUY1mBnCz
 GiSP2t234CIoXm6GSTWTY=
X-Gm-Gg: AYBFou3K5VlUaWf26XNBrxHclyRSnlandMvu0k63h3W6QamTn5hTJ3xErA/0SWLXOVl
 tYG0tC2RV64UuhYT40g2RqMJwFUbh28aNYjg70ID1YTFfqPsiPZLyayF5oScXpG7E+IIcdNCaVj
 1o9/woJFhT/vw+KMz5vUcpxo2SjOwy0Hua0pJoQk0ee3z0KciYkaCJhBgxCieu9z5CWlZaGC6Oj
 SQfOrkjzbtpp+n+MhoXw6XM3u+RkN0fQ6Z6A4p7wbtatT43
X-Received: by 2002:a05:651c:1b0f:b0:3ab:48e6:6789 with SMTP id
 38308e7fff4ca-3ac6632e1fcmr6181621fa.8.1792766516741; 
 Fri, 23 Oct 2026 07:41:56 -0700 (PDT)
X-Received: by 2002:a05:651c:1b0f:b0:3ab:48e6:6789 with SMTP id
 38308e7fff4ca-3ac6632e1fcmr6181531fa.8.1792766516235; Fri, 23 Oct 2026
 07:41:56 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <5766e02ea3243de1f63eb68efc210719f11815b6.1792763492.git.anatoly.burakov@intel.com>
 <6313a2be1e6288e2844cb13e0c8523f7296c5b98.1792763492.git.anatoly.burakov@intel.com>
In-Reply-To: <6313a2be1e6288e2844cb13e0c8523f7296c5b98.1792763492.git.anatoly.burakov@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 23 Oct 2026 16:41:44 +0200
X-Gm-Features: AclHuK_wycYYhKY43atK-vNSJqU_9l2ORHylkBPI1sctTuKvM7XvQ-hrXYCVPw8
Message-ID: <CAJFAV8zHmbL99Xi3REFd6P0WEewstUZ29=imnbVoxym9KTWA+w@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] interrupts: warn on leaked event FDs
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Harman Kalra <hkalra@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7zov71JlJkb_RGg963CY-ShzLbfz26uGkWN5If1doyM_1792766517
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 at 15:52, Anatoly Burakov <anatoly.burakov@intel.com> wrote:
> diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
> index aadb7b84a22..f6f51ba53c0 100644
> --- a/lib/eal/linux/eal_interrupts.c
> +++ b/lib/eal/linux/eal_interrupts.c
> @@ -1667,6 +1667,8 @@ rte_intr_efd_disable(struct rte_intr_handle *intr_handle)
>                 for (i = 0; i < (uint32_t)rte_intr_nb_efd_get(intr_handle); i++)
>                         close(rte_intr_efds_index_get(intr_handle, i));
>         }
> +       for (i = 0; i < (uint32_t)rte_intr_nb_efd_get(intr_handle); i++)
> +               rte_intr_efds_index_set(intr_handle, i, -1);

We don't want to waive for types != VFIO_MSIX, do we?


>         rte_intr_nb_efd_set(intr_handle, 0);
>         rte_intr_max_intr_set(intr_handle, 0);
>  }

The rest lgtm.


-- 
David Marchand

