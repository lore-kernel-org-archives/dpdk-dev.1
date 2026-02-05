Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40946ECD996
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 18:48:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6244D4279C;
	Thu,  5 Feb 2026 19:48:52 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id E03AF42670
 for <dev@dpdk.org>; Thu,  5 Feb 2026 19:48:51 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so19299405e9.0
 for <dev@dpdk.org>; Thu, 05 Feb 2026 10:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770317331;
 x=1770922131; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rlU1BHZezmI6JCE+j26sQlE4doapX+jX7kbQub7kw+Q=;
 b=TgmPoEQLTaTr9HBlRg2is7W/6aoVuH35Trf6Tp+dZBkETLqqN0l1s8xujwN4UPQ9H6
 EnGLXCl+4ufmKGs9mDZ5NXXaGbwG5P2XlJ7njdFUC16yZ7JYkAR7NuNlmA7bWXreu7I1
 RS3oEXVF5QEzQnGiNePHLTeIhVCm2BHGiby0c6OfVNOSdZ7PpIZRZ6aZWkbtP/0wES+w
 RiCoInq4jokyPPdVrOLuIJPru0a85qVxIJQHVYsGkPoH3wQIeo1f78R5sAdPJXn2sQxN
 k9/gBxioji+c9A90A5V+kn9MeiOMYOgiWvAAGuL6x9PAtslZcKBkGX13dDMKrjGN4ynX
 KGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770317331; x=1770922131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rlU1BHZezmI6JCE+j26sQlE4doapX+jX7kbQub7kw+Q=;
 b=mEL4ZA0VaWnp/wrKX1clZUpgMpz8Wopgq/Q20Ptza/V6oYDCTyuFnxohfL5ozdpTcD
 Ihomm12mCghoN1pRqGBJU6ZPEMTtbISWji4CteSGohFryTQzLguhGDoYyGOpmGq8IH0H
 OHMFKwduQdj4L/J3LDVo8F6fp7ZIkZdjIjgGrtjjr07s/oUrmvTAUmb53Sf0oIkyJaU5
 DFDH4Q1aLPK/mLffTM2RCHD4bvgvqd3JnIyKFm2Vbq+0or7HEFmyvqma3xc69ndMHZ6s
 DMfiNk0OegnrFwY/rFKSjCiAx4eXBnGpv8YuQgfFGJnpsmGs8uH2OJ7z82kMiqjZDHyt
 5UAg==
X-Gm-Message-State: AOJu0YwS0/5kbZEvS4HtmGdU1/p5gXJ1Q+mCryNcHpw0VIi9/bHX53rG
 trrO8WU/G78CEXeVYtzWscCPgDfBC2TLXwLphobI011fCQNlMVefcbujpnJH2ANFIUs=
X-Gm-Gg: AZuq6aLDF0ucybKLLcV0tJgvXrDaYhpBFRkV7hevoevS+AVSbnxKpgDMbEcL5774cK3
 6caWg6RxXNOMhGzIj4U+RqG2V+W2N0Qag2BODEI/8+TsFDgr7ayoS5fay/5UUwcnYuF/oK86/gK
 +pAmDOq+4fSx6sN69u9YKH4V//uTN5z7GXgjqW3AV50haiJfd7h4cOTbQxerPJ7qnvhnc+akQFV
 GlFDTk3RMLAJoEanul7reb/sYfD+/Ppor5Yuh++/ASorGeoYWe7QQr1hcaL9bc89i0U9N6kAxbY
 efgbM9U3XJ6AiqLDVz+JMaM3Bgbb6hYGwTUVmVQKd+CWb/EbN7ET5epf9JwXSTfSSqK/2Mn+mZA
 x6mFxo8v1o5f/P2N2HLlcrdqYZLib+gMjDJGmLNtGDmILvsuooNuvAGm6oPprqkthoVjGhLYEIK
 IzpRNTHDYl67sqU611WDCn8qq2WV7G5JWobqekB4bLhOv1TIh9hUml
X-Received: by 2002:a05:600c:4fc8:b0:480:19ed:7efa with SMTP id
 5b1f17b1804b1-483203397fcmr5635435e9.36.1770317331204; 
 Thu, 05 Feb 2026 10:48:51 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830ffbd1f8sm54226155e9.16.2026.02.05.10.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 10:48:51 -0800 (PST)
Date: Thu, 5 Feb 2026 10:48:44 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Cliff Burdick <cburdick@nvidia.com>
Cc: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH v4 0/2] support dmabuf
Message-ID: <20260205104844.6d2ffd9a@phoenix.local>
In-Reply-To: <20260204155206.2345189-1-cburdick@nvidia.com>
References: <20260203230338.1066297-1-cburdick@nvidia.com>
 <20260204155206.2345189-1-cburdick@nvidia.com>
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

On Wed, 4 Feb 2026 15:50:07 +0000
Cliff Burdick <cburdick@nvidia.com> wrote:

> Fixes since v3:
> * Fixed version in RTE_EXPORT_EXPERIMENTAL_SYMBOL
> 
> Add support for kernel dmabuf feature and integrate it in the mlx5 driver.
> This feature is needed to support GPUDirect on newer kernels.
> 
> I apologize for all the patches. Still trying to learn how to submit these.
> 
> Cliff Burdick (2):
>   eal: support dmabuf
>   common/mlx5: support dmabuf
> 
>  .mailmap                                      |   1 +
>  doc/guides/rel_notes/release_26_03.rst        |   6 +
>  drivers/common/mlx5/linux/meson.build         |   2 +
>  drivers/common/mlx5/linux/mlx5_common_verbs.c |  48 ++++-
>  drivers/common/mlx5/linux/mlx5_glue.c         |  19 ++
>  drivers/common/mlx5/linux/mlx5_glue.h         |   3 +
>  drivers/common/mlx5/mlx5_common.c             |  42 ++++-
>  drivers/common/mlx5/mlx5_common_mr.c          | 113 +++++++++++-
>  drivers/common/mlx5/mlx5_common_mr.h          |  17 +-
>  drivers/common/mlx5/windows/mlx5_common_os.c  |   8 +-
>  drivers/crypto/mlx5/mlx5_crypto.h             |   1 +
>  drivers/crypto/mlx5/mlx5_crypto_gcm.c         |   3 +-
>  lib/eal/common/eal_common_memory.c            | 165 +++++++++++++++++-
>  lib/eal/common/eal_memalloc.h                 |  21 +++
>  lib/eal/common/malloc_heap.c                  |  27 +++
>  lib/eal/common/malloc_heap.h                  |   5 +
>  lib/eal/include/rte_memory.h                  | 145 +++++++++++++++
>  17 files changed, 612 insertions(+), 14 deletions(-)
> 

Any new library like this needs standalone tests so that it gets
covered in CI etc.
