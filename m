Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DB8C88E7F
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 14:35:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3ACDD427C3;
	Tue, 15 Sep 2026 16:35:09 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 15D4440B91
 for <dev@dpdk.org>; Tue, 15 Sep 2026 16:35:08 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d90ba1d807so44238995ad.3
 for <dev@dpdk.org>; Tue, 15 Sep 2026 07:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789482907;
 x=1790087707; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x/64hVsegxCqU/P3uS7hTnhYLMZ6/iYGrauTuqHZsTw=;
 b=rOuoYyEa3h5JeFPsLUY6Cvm4w975jUYxHrC6UFXmZmTE5CTXD+rBeOhy2TZuVJXNCD
 Ul0hu/JuX9ukfco5/Ibma34C4LNHv6e0zXhMHPGOAQJbynRR0R5+p7k0BEfrJcjsE6I1
 xNlrBhuyEHFtaPewNn6Zu539wCIgf9xKYAnN5MeaE+kGfAJ7QHJidE925/IQyts3hwce
 JQv8oN5OACTG+eu2BQ0O4C0NApdh/mAd2DaFnjdkF4INLIW2iiu0Yqowo6TfOVGggQTw
 pN2qRXpveWNP7Z/jAFuXT54N4mAD2TbjoRh/JgNkb/tLtN4cq93PHLrEoafRj6WOyytf
 zmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789482907; x=1790087707;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x/64hVsegxCqU/P3uS7hTnhYLMZ6/iYGrauTuqHZsTw=;
 b=vUPe/62HOx7wTvgJj7S4qFTD1kiHeOVXVvsI3+3ReKc095qVRLSU08Jb2qZCVtIsGq
 2t3KXIVdr/60ZfWluxJoJZsteU5l1KUkcwu9YMtyvTQG70nybY1e4XuXXsLDshXzeYAN
 VGsdTH5lJNJD944TaxR0fWgtEBPHLjZAOLUjtfXdHgBaX0A1sZ2Co7MVV2TzEF3xKP8q
 kx2qiEUBBHC5ufceLgp3CFDczk/TEfzSAnrj2HVbZmHA9u+2DD3BYxUoEpQkW6q5ZwnL
 UFDbLqNjEHGO0v9KGYHZpgpm+vb1IlzoB+5rfGa8ZjFMwrvTMVmi3ZORoqsG/XvvikpD
 Fh2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxr0uIQaj+fSnDjpPUqO/fM5783wTUJHq75IiVI+JH2SWk+6ZngI5sjbznuDnECIqks5W0=@dpdk.org
X-Gm-Message-State: AFuF++mgxiYp9FifebFZOaoTfzxTOLtWr3hhW/ZAPAI7Q0PSstu5vGvC
 2gZLywN+rHIWy9a0tV62dY3DqOEtlZ4r+ofGQRLaEPhLJi0aBncuWKWrKVVfDAjty3o=
X-Gm-Gg: AYBFou0UHYxtY1Tclxj64phDjOnULj4zFylQomPjbC0WkMbRH9lepeJqeU0rQ0T2YVy
 HPHd6s3RoS4KCLo3cgfiAQPzyFUBIkMdCxoyjQVJqd/8+bEsQjqKVt5mkgLOkd17fooapgL053M
 2J0BnWg/FIiP6tZN5z9PI9qn8Et/PvsN5huQAcsBzras5SyB8KEHZJyMBvWJST6oUfmmXBCXD3a
 ojuNmme+HILVzVBEcdze/JSWBexhMi7Jxd6tSfQ2ntMGUyk2vUdZEq5bB7Cy838Uv/mcm8vU5Xy
 GY+DIemNCxByrawj0zoQVFxMrjhiag1064j1oHp1d74/uCmVTVNWIwz4YJW0Z3wsX9BTPEyhmAj
 QKD0eFC9791A0an2hqb9R5ZvERDudONxVpHizJTyQIxhj7crpOO/9rlvtVfOAXvSXAINYr9AuuA
 7QR/b5o46522/t33jZr5vdUYeFZAr7/6M1b1PeCjDILmVagWl2mqmNJ43ncXOLQ1EIB5N2hg4UD
 glENtowjpyYqbiVTXpuxQ2RRyPBb46xOuYXNrtO
X-Received: by 2002:a17:903:32cc:b0:2db:3d84:effc with SMTP id
 d9443c01a7336-2dd6c5d600fmr144395125ad.6.1789482907072; 
 Tue, 15 Sep 2026 07:35:07 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd2cfc300bsm66552955ad.47.2026.09.15.07.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 07:35:06 -0700 (PDT)
Date: Tue, 15 Sep 2026 07:34:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
Cc: Kishore Padmanabha <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Damodharam Ammepalli
 <damodharam.ammepalli@broadcom.com>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/bnxt: fix ctx_dma_arr allocation size
Message-ID: <20260915073459.106fb066@phoenix.local>
In-Reply-To: <20260915085606.430987-1-Evgeny.Sokolov@infotecs.ru>
References: <20260915085606.430987-1-Evgeny.Sokolov@infotecs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 15 Sep 2026 08:56:06 +0000
Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru> wrote:

> From: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
> 
> ctx_dma_arr stores rte_iova_t entries, but the allocation size was
> calculated using sizeof(rte_iova_t *) instead of sizeof(rte_iova_t).
> 
> Use the correct element size when allocating the array to match the
> actual data type stored in ctx_dma_arr.
> 
> Fixes: 4371b402c7b ("net/bnxt: fix array overflow")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
> ---
>  drivers/net/bnxt/bnxt_ethdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
> index a2429561b9..2754725566 100644
> --- a/drivers/net/bnxt/bnxt_ethdev.c
> +++ b/drivers/net/bnxt/bnxt_ethdev.c
> @@ -5054,7 +5054,7 @@ static int bnxt_alloc_ctx_mem_blk(struct bnxt *bp,
>  
>  	snprintf(name, RTE_MEMZONE_NAMESIZE, "bnxt_ctx_dma_arr%s_%x_%d",
>  		 suffix, idx, bp->eth_dev->data->port_id);
> -	ctx_pg->ctx_dma_arr = rte_zmalloc(name, sizeof(rte_iova_t *) * rmem->nr_pages, 0);
> +	ctx_pg->ctx_dma_arr = rte_zmalloc(name, sizeof(rte_iova_t) * rmem->nr_pages, 0);
>  	if (ctx_pg->ctx_dma_arr == NULL)
>  		return -ENOMEM;
>  

Maybe use rte_calloc() instead but fine as is.

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
