Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BBA606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 11:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cpL0PD+4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F14E540659;
	Tue, 20 Oct 2026 13:53:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A865140144
 for <dev@dpdk.org>; Tue, 20 Oct 2026 13:53:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792497217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z+xxJynNo+yuXprTWPXySvxMSV55KWoqsT8VWi43W6w=;
 b=cpL0PD+4q+6U+zeJ9Ejo39IRbVw48yrH83JkakaOJ0jKvt0+l0EtNnh9DyY3J6XewZkjWX
 Is0TUfrk5OOm8ww5nW/HMzq0tzSQ9t+rqCSAT19YLUMWyB4BozvWCreRogAqWGQTgV5ctB
 sZodEoHy/Z/JOXWeO9sZ1ArE/c2FMaE=
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com
 [74.125.82.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-VNiukC9_OeGbCP5LDesLMA-1; Tue, 20 Oct 2026 11:53:36 +0000
X-MC-Unique: VNiukC9_OeGbCP5LDesLMA-1
X-Mimecast-MFC-AGG-ID: VNiukC9_OeGbCP5LDesLMA_1792497214
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-18eb2616974so452222c88.1
 for <dev@dpdk.org>; Tue, 20 Oct 2026 04:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792497214; x=1793102014;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z+xxJynNo+yuXprTWPXySvxMSV55KWoqsT8VWi43W6w=;
 b=kIJduC5zYnrq1ijtJwIinvkVKn4mLbsn/cSDgbrYpiKIm2GousbFnQDHz+huHYpA3T
 VaZon/5OMy1k3Vtbn41MH2aLisbNEhwRa1skteMQ9MWcdLLEjqhx3+oXI/QmTmPbb+z9
 yyIKtDorFCR6v9/bGiKZJrY65c4uQmiXN4IewXuo6HTcgvLBr52qk90hC/Zt55TRpij8
 yBEWy6XkDsacC7kN372A2SXZ69XXZ0+BpjdOQvq5qVq9X+suKuJY//yMm/5xrZbxToCS
 PKNaza8awcdGao5N0y9Q5XzGSOkf5CeEGlR2SaNJgGm+pyQ0V2febSAxhVKMMojwMQpJ
 58Yg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7cQFWhKtrDnWFX2lruWujJySyzqO+Ikv1O8CpN5AQape1n+POWtj/IOZF8iuXP3GVizQ=@dpdk.org
X-Gm-Message-State: AFq9FYLASpnKV1qKP7KAVSBCWvPYu4H5A/9BBLpy+reetw8SHtruzOYA
 O9Lgs1FiVbJjfO1GO6KnWcLVF2skU+fAEVRixNkzwst7dSDTkMcuHsvRu9ydgRaidmj6vpAbnXn
 naY5MbKv3guc6Edxt6CQMLbDh6tJyGr2EBYxLZg/XVBFRPNm9914uEW7h6PXdNd0nwAinUjzddS
 zS4sOwkOth6vND9TPUSXI=
X-Gm-Gg: AYBFou0OEe9q5n2gmivIL3CeF+j2WqZKP+W68M64Pvez2V3bhaFiXUVWGlshzk+QnOm
 LuCN/LZT1FBZfTgZzHapbvX9oGS+bPgcIDWhg5aK5boGlxDTW9gjOvpwKrpYF5lgvCRTzQJyW/W
 gDXIrDNzz6YXfIRRdwOxtTQm1khP7+Sm3CgykGeKEF1PLVrvCgFvaCXDREmMcibR2mHSJN7h25n
 nqw+q/lQf7VOStR3FXxDOzuWW/2EVN60axA97qWCF5V8XQpi03//sJgUFHXqOT/pdmW9PPAoFF7
 7R/ZipCUj0pyHzaeeh5v6jlFILokNZQj8AfDdN+Md8w=
X-Received: by 2002:a05:701b:4641:b0:184:5f2e:aa52 with SMTP id
 a92af1059eb24-1851238b3f3mr13791861c88.16.1792497214141; 
 Tue, 20 Oct 2026 04:53:34 -0700 (PDT)
X-Received: by 2002:a05:701b:4641:b0:184:5f2e:aa52 with SMTP id
 a92af1059eb24-1851238b3f3mr13791834c88.16.1792497213589; Tue, 20 Oct 2026
 04:53:33 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260707135044.7488-1-avanda@ptsecurity.com>
In-Reply-To: <20260707135044.7488-1-avanda@ptsecurity.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Tue, 20 Oct 2026 13:53:22 +0200
X-Gm-Features: AclHuK_9bqH2gRkli2w2Cq82yrZLcA-LeZZyd1lxaOMdE01EeWySAKcPE9cv3Yk
Message-ID: <CAO55csztbsEZue4JgVzaSr54aNfFN-m=6VDn+WWCDN=k_tMCbw@mail.gmail.com>
Subject: Re: [PATCH] vhost: fix null dereference in async packed dequeue
To: Anton Vanda <avanda@ptsecurity.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, Chenbo Xia <chenbox@nvidia.com>, 
 Yuan Wang <yuanx.wang@intel.com>, Cheng Jiang <honest.jiang@foxmail.com>,
 dev@dpdk.org, stable@dpdk.org, cheng1.jiang@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pYDY5lG0GLwiI78Lp6B2XsgRhi0c0w3YjWQGsUbFUjs_1792497214
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Anton,

On Tue, Jul 7, 2026 at 3:59=E2=80=AFPM Anton Vanda <avanda@ptsecurity.com> =
wrote:
>
> In the batch path of the asynchronous packed ring dequeue, the address
> of the virtio net header is obtained from vhost_iova_to_vva(), which
> returns 0 when a guest-provided descriptor address cannot be fully
> translated.  The batch check only validates that the descriptor address
> is non-zero and that the length is consistent. A malicious or buggy
> guest could therefore trigger a NULL pointer dereference and crash the
> vhost application (denial of service).
>
> Check the translation result and leave the batch fast path with an error
> on failure, so the single-packet path handles the invalid descriptor, as
> is already done for the non-batch async dequeue path.
>
> Perform the header translation before the DMA iovec setup so that the
> early return cannot leave the async iterator state partially updated.
>
> Fixes: c2fa52bf1e5d ("vhost: add batch dequeue in async vhost packed ring=
")
> Cc: stable@dpdk.org
>
> Signed-off-by: Anton Vanda <avanda@ptsecurity.com>
> ---
>  .mailmap               |  1 +
>  lib/vhost/virtio_net.c | 26 +++++++++++++++++---------
>  2 files changed, 18 insertions(+), 9 deletions(-)
>

Thanks for your contribution, but since async support is being removed
in v26.11,
your patch is no longer necessary.

Maxime

