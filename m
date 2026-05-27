Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D24CCD5BD5
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 14:22:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43B384027D;
	Wed, 27 May 2026 16:22:56 +0200 (CEST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by mails.dpdk.org (Postfix) with ESMTP id 918A74026C
 for <dev@dpdk.org>; Wed, 27 May 2026 16:22:55 +0200 (CEST)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-7bdc947aa88so97060407b3.3
 for <dev@dpdk.org>; Wed, 27 May 2026 07:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779891775;
 x=1780496575; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mfpLP54ZnT1z+kumkiO+VURQKZb8jcRqvybin9D5pek=;
 b=oPxIVTfdePgt8VeoIumXmVj22F0OOsW03FQiP5g7PlKc4u+n/tvSrG6VtqwvGV8EZG
 jCpO7JhTmjizXhjF+x9ZdLSGQqVJhL1oOFAQO/FVUqqHvp+o91IUSH4EfjbCdH1ZGTH5
 T+ClzzwxKhTumgVJceNsIQOBFwWhpQ77osgjzfmO1PzA2rG/xagZ0cdnC/qYtp9D/Uy6
 f9rWrNcsdZS9MLWscx+aKPIqmT3QZYblHFbEjbz6X3+ULbgoE2wOyzS29daZhV0x46Aq
 B6n6nh1VglylA6TSU1EvOzSgljea7tsTet4YY/Qst/kieL4UGidPMpqun+stPTTmWES5
 t5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779891775; x=1780496575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mfpLP54ZnT1z+kumkiO+VURQKZb8jcRqvybin9D5pek=;
 b=Fbm7Vquzs7zJxwapRduMyYb+3ni1AbEyh2O1w7CIsiPEV6OpuXjPAjHARfyh3+qoaN
 YEbkDoODUOdnHWCXdVOjexwBTiKaDDxfBQCZ2CPHWLfMZLjBYUrwfy6hfeTtX/p9anm7
 SPfTaoBuSCJ6atsukFZ3moscRvINADDMZt7IuW+ee9kix9QEc2in0CP0yMeftwqALlfA
 W4j8DjaA6r4BTP6FjRjUDz5CKAfryU7DeIs3IoiHVMWMWiOoPJA+aCd+jrEvqDNrfSIg
 pBvLKCm6BeanfV72CycZkgLWK7cD73QZF4UnPT6SIxrGGJqCkXWYZsvBNFyamtvVdxMk
 10Sg==
X-Gm-Message-State: AOJu0YznCq4Otl7flhk7Op65CyTIpIk7FUPyCgRrqddA4UErvy0n8QLZ
 QTKZ0DLsYzyu9d4+jBcyW7hzzwz+5rJQ/HOvsVM4cJW2nciaM1PXGFJ4NHGBraEwEeg=
X-Gm-Gg: Acq92OEzq2sj14XPWYRax6/E7mhZTyCcltp+DL6EdL+Gc67iRjky34KmmKslfu05loW
 5kFDD9nArjw+UfJra+ZseI0MVYLc1xoqH+vYNfYj2SwzH7YTPd03VD3gKng3II7Ot3WuY021N+0
 pXetHhGSTj0hVj67BGIIHQ8X4Ds4II2I9C+MH4rDQ4ySbUqs9Q0kTxI/MldVfwEqTtcWbBOErl7
 jjrEvn72Qu4Yzzd6sLwqMyX+vXYO7Ql5r9VY/slWLxfK1qT6SF+ZsRdVezMbmGsX8ofvTK7RxKn
 Y67qg2kJEkXTejV/fk9Dp4PVJfCNrrFo/JCKOxhSDxKrLX360RPyMleSHVc+tqRU99KXrQbkx35
 erAF54Ck4JfdfQLMTMW/jFor4hck/cwn/3lzhskkL5jFSaHABzt3HTDD4olsfG5Rc583nri/sim
 oI85Ral7bGtqG8U84VWrqE4vudVGT47N5LngvR7b5eOqIwW26hN1Cq0d56VMDpg/aL
X-Received: by 2002:a05:690c:3502:b0:7c0:de77:f475 with SMTP id
 00721157ae682-7d333ad9b0fmr252618337b3.8.1779891774644; 
 Wed, 27 May 2026 07:22:54 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7d38be30f55sm75257577b3.32.2026.05.27.07.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 07:22:54 -0700 (PDT)
Date: Wed, 27 May 2026 07:22:51 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mattias =?UTF-8?B?UsO2bm5ibG9t?= <hofors@lysator.liu.se>
Cc: dev@dpdk.org, Morten =?UTF-8?B?QnLDuHJ1cA==?=
 <mb@smartsharesystems.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Mattias =?UTF-8?B?UsO2bm5ibG9t?=
 <mattias.ronnblom@ericsson.com>, Yogaraj Baskaravel
 <yogaraj.baskaravel@ericsson.com>
Subject: Re: [RFC 2/3] lib: add fastmem library
Message-ID: <20260527072251.7c53719d@phoenix.local>
In-Reply-To: <20260525103642.55255-3-hofors@lysator.liu.se>
References: <20260525103642.55255-1-hofors@lysator.liu.se>
 <20260525103642.55255-3-hofors@lysator.liu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Mon, 25 May 2026 12:36:41 +0200
Mattias R=C3=B6nnblom <hofors@lysator.liu.se> wrote:

> +
> +static __rte_always_inline struct fastmem_cache *
> +cache_get(struct fastmem_socket_state *socket, unsigned int class_idx,
> +		unsigned int lcore_id)

Do not use always_inline. With current compilers using always inline
makes the optimizer generate worse code. The only exceptions would
be where inline is required to make assembly work or you have good benchmark
data that proves that always_inline generates > 1% performance gain.

To much of DPDK use __rte_always_inline as "cargo cult" it is faster settin=
g.
