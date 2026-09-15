Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3322C88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 13:26:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03ABA40DDC;
	Tue, 15 Sep 2026 15:26:38 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id D822940DDC
 for <dev@dpdk.org>; Tue, 15 Sep 2026 15:26:35 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d91c22d27dso17990405ad.1
 for <dev@dpdk.org>; Tue, 15 Sep 2026 06:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789478795;
 x=1790083595; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6wGDRwwUpGcLq5/SorGli4/3EcEI7E1OWzuhdxl+ero=;
 b=m4Oyl8JyTvGl9w70W8VQQ338gGheLjjao+vBxdtBWGpXBtY/8yCzxPz4XWKp1VjUQl
 itjqM13wVz4fiSmffunOvWbq/L7ctbuaL+UsCTOSBTDQQ/zzcv27UAHJVp2Qb/SEqMJD
 ynMlUYx3xOh3bGbmrWWLUg4sS3jVWM3Zz4Fma5wpe2lD/rXd+4clKdTl9UyeyHLQEArJ
 NpTp3LwHHUVhRCeFtO6JMUoeYyrRwtDZQ2b4fNb63guzWedB9rvUnSdbighP1HuTAlGP
 v9KB6fJoTPt1tP6RXRFEkX8zZb8dNpJaeZ+PFVKFZTMz1oXqIquxK/87keRn+SCFkgIf
 Iqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789478795; x=1790083595;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6wGDRwwUpGcLq5/SorGli4/3EcEI7E1OWzuhdxl+ero=;
 b=Y/Is/sUG4XSHqY+dS4V4taD+lMi9I5nyOddsLaxekwPqHuaJglmM1TjLcEYwwVHnLY
 GHm8FCFJeX5Zs1S2ELGj/bSX7mvy3DrNniEEhuvrqZh+yrOJEZCmJY6U74d5SSVVHuJU
 /FoUBuv7chlBSAkHKLhdGdcm+QSJBhxYteoJXSrDstJlGeX1f+WhMnzdirCA5tZZCuLR
 7KX5l8Fx13zl7Eo4zIGZSZz+jZUCvmDQ1wO5IVm8Y5ih+ItbkaThpl4fS+1oVuc6SCjh
 Xupy2GU52cNTKEOK4jrBYcdneqiGTClEcg//pTH5InJwCD03osCjBiGdHhm+JapSAYuH
 Xsyw==
X-Forwarded-Encrypted: i=1;
 AKwUvByadwx0vf6QEqmtR0lml9mQyyvFPZuWeZAVDkPrIC4KwRMkuvP+Z0LITRuvdMYxw2ZUzis=@dpdk.org
X-Gm-Message-State: AFuF++k3FAGJjVvSLJYLx9qpH4Z3SKAuSxVh/lX+X3TEEPZOXCfNRCa8
 9FRBQAzV70jf5SO+WRT//8oYU4tq/n2U/9toPYF7RZ/pho1Yh+ncqdD2125WDn3/Uc0=
X-Gm-Gg: AYBFou0xo1VzF/KlWQ5nLkNHfqh9Hu//sNsNSOnNgNclrnieWBGp6AmaY5cd5Rx4Ulu
 aPaMMIgKsOfmL8YNDJInl+eJnQPhwpEYTWOEvduFd3mf0C+L1h+nBI1uLLNE/bruW7gSTvRnNtC
 O6HYfC9r2Ihn7abvPN/JXyDtdNjBW/geuX2fK2IIocPMGax1eK2Bn3+rYxyAEhlKdOgOXlkoE2X
 VisUxfXf2U6J9T4kJpEZN145d9OgjGNct+0micKMKP/CFLxXS22jPwAB1PqNeIZENHBU/KY8TqW
 LTq+MVTZ+716acoVxta7A3mtiUON/4kQYKkNm2LuTdjQSnfZU4KzzEyKgUyqFKW4BQKnQqvCgeG
 EjU2Ogjy9n5seqjy2+Uny2pdLNKZWLJc0izu+UexW7L46DabxdUrcmJKBoBE3N+bHjGouLYXshf
 wsj0z3J3V0kz09t9vrHQr0gwihCFaqrJm316s2JucDNa22SAxUPTh3gfSbaKHvfP3EBrj6PIyXT
 Q24m7dEFyLsKhSY+It9l4lJaKPNefCwTQk3dyg8
X-Received: by 2002:a17:903:244d:b0:2d9:438e:b70d with SMTP id
 d9443c01a7336-2dd6c5c1352mr152935985ad.1.1789478794734; 
 Tue, 15 Sep 2026 06:26:34 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd2cfc5c7bsm67308405ad.51.2026.09.15.06.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 06:26:34 -0700 (PDT)
Date: Tue, 15 Sep 2026 06:26:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
Cc: Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>, <stable@dpdk.org>,
 <mukawa@igel.co.jp>
Subject: Re: [PATCH 5/5] Replacing the unsafe strcpy function
Message-ID: <20260915062623.1bd5041b@phoenix.local>
In-Reply-To: <20260915095846.432214-1-Evgeny.Sokolov@infotecs.ru>
References: <20260915095846.432214-1-Evgeny.Sokolov@infotecs.ru>
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

On Tue, 15 Sep 2026 09:58:46 +0000
Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru> wrote:

> From: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
> 
> ---
>  lib/ethdev/rte_ethdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
> index 55ea8fe808..b040f9fa84 100644
> --- a/lib/ethdev/rte_ethdev.c
> +++ b/lib/ethdev/rte_ethdev.c
> @@ -718,7 +718,7 @@ rte_eth_dev_get_name_by_port(uint16_t port_id, char *name)
>  	tmp = eth_dev_shared_data->data[port_id].name;
>  	rte_spinlock_unlock(rte_mcfg_ethdev_get_lock());
>  
> -	strcpy(name, tmp);
> +	strncpy(name, tmp, RTE_ETH_NAME_MAX_LEN);
>  
>  	rte_ethdev_trace_get_name_by_port(port_id, name);
>  


This has already been addressed for 26.11 by 

https://patchwork.dpdk.org/project/dpdk/patch/20260806174755.890910-1-stephen@networkplumber.org/
