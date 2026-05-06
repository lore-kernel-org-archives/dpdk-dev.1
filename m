Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A752CD343B
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 15:58:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B97B440658;
	Wed,  6 May 2026 17:58:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2098D402B9
 for <dev@dpdk.org>; Wed,  6 May 2026 17:58:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778083122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uHeU25jyJhhII32Bu3sbjyZzxJxUn6CaDHbWXX4HX7I=;
 b=eWfEj+j0JMBHcIAyiUEgr0g9JFgLzSEmG6u2/lZ25z9GKPUx0BWORqzX/exRers64FazjA
 0wniQiKCCTk9K/8jj+LHYcCwnYsEvyfsHIlxXN75j3Fakvzj5TJjRnbMS4IDVbjVi7Bz1w
 c4zsegarTwks+2qa8kQiaoLBIUywx1g=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-LZfIdlOWNByRNFaHaaWtGQ-1; Wed, 06 May 2026 11:58:40 -0400
X-MC-Unique: LZfIdlOWNByRNFaHaaWtGQ-1
X-Mimecast-MFC-AGG-ID: LZfIdlOWNByRNFaHaaWtGQ_1778083119
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5a7437b4ff9so593096e87.0
 for <dev@dpdk.org>; Wed, 06 May 2026 08:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778083119; x=1778687919;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uHeU25jyJhhII32Bu3sbjyZzxJxUn6CaDHbWXX4HX7I=;
 b=EdrUVIMmSCcZx6O1fF8kSx4fK9AljDwuvPtKuQBZPDLj/LgccRtxw6VT70+hjFNBh8
 wgp7xs3jNb/6vS73cPEg2S3SD6AkU5Mbaxlueh1DIu4t+6ViZ3Q54xTp7fcok09x09Ty
 lwh10mF1HU87KDbHX0PnesV3DXV16N3V3u3S+V+8W7ss0Zi3jRYPZN+gsXbco7mjKkzV
 Ys9kKwju6+TtlHbvumksQqKh3fpFIakNzC9XhUAqFqeRbmdYja4dP8aG3ZUckLltBsEt
 xInr5qSQyCIv/2PvVT6vDy7Y1o2m2RjogJpBPWOkhp4SyixL8MZ58T8BArjs2yGt+Xlm
 5Gbw==
X-Gm-Message-State: AOJu0YyDCu0xFXFRD+zRYFgGzL8FH7Q+7MyfEM/zCj7k8odYNJ4EXuhU
 9DJfs+p0ESuEBmYMNXGFlTyfU/X6UUsyfXFvlss1lFyD8RoTa5B3i62nObYE0a/ha/Qk3MijrvE
 VkpyrV0QkmJ74zS+gYzX0gxTQGonZCGdqpUhcHGV6aPTtSFp3aNeZBHqLkPZ5ZNc4Uzkihq+GuL
 1ljWf4NiBFwTMmGiBUp+I=
X-Gm-Gg: AeBDiesUB4IvqAmlu0YFJWYJAWAB0WfIuZIfBNJZohBINgEZ/nroUUDFP9CpUa1otNN
 2vYbdhfqSgrhFHka/sMcVgIlMvxyBCBEmbhNy5F2K6spqRAAkHP/oh0949uSSj3oBo6FGj6hz4I
 yDJgdxTYtJt38huVgl8ze65J5MrhHeG+x8C94IS67PEji5AHopRgYgW+Q86+RJcfhUnTwuXSnKg
 tUnVqExbYQeHfjyTKh59XQxeQCkJ8d/blwI0/CbtGhP5kt0Vc6QpBY6JXlNcQ1yEYAoyAQ263Rw
 w4mD
X-Received: by 2002:a05:6512:318f:b0:5a4:299:285b with SMTP id
 2adb3069b0e04-5a8875db775mr1284179e87.12.1778083118754; 
 Wed, 06 May 2026 08:58:38 -0700 (PDT)
X-Received: by 2002:a05:6512:318f:b0:5a4:299:285b with SMTP id
 2adb3069b0e04-5a8875db775mr1284171e87.12.1778083118278; Wed, 06 May 2026
 08:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <c50ef6c3d4ecaa7902d325d5e8a7fd4c92c8eeb6.1778076415.git.anatoly.burakov@intel.com>
In-Reply-To: <c50ef6c3d4ecaa7902d325d5e8a7fd4c92c8eeb6.1778076415.git.anatoly.burakov@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 6 May 2026 17:58:25 +0200
X-Gm-Features: AVHnY4Kmx6Ff6GLEKEdK8UaVTwjBKVtLTAzCPJIj04aeyjnL1gXPqYy76jEY2hU
Message-ID: <CAJFAV8yNKxSXjmjQ0sM21-6hZDTVrGT9cpZ6aQU_FNTepTP4nw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] net/iavf: fix large VF IRQ mapping
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, 
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5kmXZIILqBBgFJ2uXMuUeXIgiGl_xOJQLMC-VPiBDRQ_1778083119
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

On Wed, 6 May 2026 at 16:07, Anatoly Burakov <anatoly.burakov@intel.com> wrote:
>
> The PF will check buffer size for being too big, and the chunk sizing code
> correctly calls that out. However, the size was actually still too big
> because `struct virtchnl_queue_vector_maps` already had one queue vector
> as part of its definition, so `chunk_sz` was too big by 1.
>
> Fixes: 292d3b781ac4 ("net/iavf: replace unnecessary hugepage memory allocations")
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_vchnl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
> index c2f340db81..dd09b0fa61 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -1528,7 +1528,7 @@ iavf_config_irq_map_lv_chunk(struct iavf_adapter *adapter,
>
>         /* for some reason PF side checks for buffer being too big, so adjust it down */

The comment above can be removed?

>         buf_len = sizeof(struct virtchnl_queue_vector_maps) +
> -                 sizeof(struct virtchnl_queue_vector) * chunk_sz;
> +                 sizeof(struct virtchnl_queue_vector) * (chunk_sz - 1);

- did you make sure you did not break compat with previous version of
Intel out of tree PF driver (since this concerns configuring "Large
VF")?

- all those virtchnl list struct have the same elems[1] issue.
Kernel side did some cleanups some time ago, maybe time for DPDK to do
the same...?


-- 
David Marchand

