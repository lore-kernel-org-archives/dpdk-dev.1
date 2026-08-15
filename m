Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AC9C5CFDB
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Aug 2026 15:32:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B33FE40278;
	Sat, 15 Aug 2026 17:32:48 +0200 (CEST)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7252540272
 for <dev@dpdk.org>; Sat, 15 Aug 2026 17:32:47 +0200 (CEST)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-8486ac3f347so2744363b3a.1
 for <dev@dpdk.org>; Sat, 15 Aug 2026 08:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786807966;
 x=1787412766; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KAA8qwUXRbP2HjziXVyu/l2bwbzJNGssT9jAbWeRtTU=;
 b=zqG71I1QOa37KoL30LPf+ySyrK5iQsT+aiAlTkhAKHslsqhfFXA74iYb85IkJpV0VO
 jQQWgWtbDJ6j51rF4D1YKEZD/6mo16ILJVKu49rJvaDL0UxQE7dEZSPiCeBoBdOpar/M
 xG+4HXkpMhimhmNYj4KZUn7sqJKioQd1jB75GBVFLPPIDRzohz49xjwNC9SCxjW2w0Yz
 fAlUL6ChbyI4CKCt0mx04SBBC5zM0b7IB/M4inTRJZ+JCmL3q4Eu/+ZEf2qTd0mVzPSM
 5cwqSkHw0qRJeTADdgN6RjHBe1Q7NpD5jzmQpAlywrI83aPVcaaq+nTKJ+P9FXUdHBIA
 Y1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786807966; x=1787412766;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KAA8qwUXRbP2HjziXVyu/l2bwbzJNGssT9jAbWeRtTU=;
 b=qyQhpg6cFOiJNW2mllwHOPjw9cgYDkuXLHt8xAp13DnEw7P4YfNo8G8g1ABs75XeAX
 KQE7zkQY6AYwrp1wDaNjCpODFbfIWxoPCLYGC0cNRU8mVAsKQZe4qLH9nb6ux8G5IHct
 VY8iNEsqHki7Bnn2NBgxyD8VWAmDTagAIco5Ue350ELXuzruSjym1r98tRRv8Mi8l0mX
 LAroUtWvs6I81MRRBwYeMiaqiJkxpw+XvD4OCnq0En4Iquizv1pV9zei4PkET0jKNXRe
 QaLqlWu9psZSlw/7PTYBpPhsWbrECHA5ahB1zszpMY7xMbKPeBi3gfMzyhVYhAMoqs/q
 IIyA==
X-Gm-Message-State: AOJu0Yxf7Hs/11jX/q+FcjIyijoyQLrL1kcVwLfRu5VSA4X9fK2SqVet
 xRJ0o2hX5NGWZoRDXfSkfYusdRlA+7lAMCADNUshnqecjLfRnnKttfUZtlC7yQ9a2ww=
X-Gm-Gg: AR+sD11LRpZnQ3cWzwHV5Xn9mZTlxvMZOCVdZ0cEIRNxNYPgBdYsOVNkphvfa+wGaFW
 LmWhyySEEXnqnSrAdbU3oBLm86bcYNz+pqXYeRY3xvDwBuv3xhu9lgJzquv59at74HQ6/uurp0R
 t9E3hhv3bTu6/z+6zNqNd94vUxqHpvELxNLEaGZoCQIA7I+3YIC8IsgU4EEjZL32ecBC96wA4XC
 9+9G2mbR40M+t3NuGx1cj3UcP1u6F/r2MjbMjaKpTVjfvh6uihxsgY5GhrpWP+mOtW9XGA6mBLS
 MiRJOL9yvMSMHj41FNHcj2GFK+2mWmI35m3xokTX1IfmdgUp21vDQpF5VxkyjG3KW1f5WIfyp1q
 3rYcBvaIpRJ5lg4qOiMcp9Y6+iy57gJd/fDoMpx1HIiGIz4CNuoWfn5cAd84Y/f9xxTmaHuiCMX
 qnWs1Q7kn2o0HjJjBlfWaW9E5cfaP6ztHw6y72zgOYaRURwVw8vfffw6dRHso0i0kHd0/tYxpkv
 DF8EDoGBAtjAfuuhnn2AedFDHolEo2IbpY=
X-Received: by 2002:a05:6a21:3a93:b0:3ba:d7b0:fcac with SMTP id
 adf61e73a8af0-3cc57351902mr22557315637.5.1786807965660; 
 Sat, 15 Aug 2026 08:32:45 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320d61e5cdfsm17854138eec.12.2026.08.15.08.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 08:32:45 -0700 (PDT)
Date: Sat, 15 Aug 2026 08:32:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 00/14] Introduce RTE_DIV_ROUND_UP
Message-ID: <20260815083237.5a6d5fae@phoenix.local>
In-Reply-To: <20260813172241.964736-1-joshwash@google.com>
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260813172241.964736-1-joshwash@google.com>
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

On Thu, 13 Aug 2026 10:22:25 -0700
Joshua Washington <joshwash@google.com> wrote:

> Numerous drivers independently define the DIV_ROUND_UP macro, using the
> same definition. Attempt to commonize by introducing RTE_DIV_ROUND_UP to
> rte_common.h and replacing usages of DIV_ROUND_UP with RTE_DIV_ROUND_UP.
> 
> Changes in v2:
>   - Split single patch into series.
> 
> Joshua Washington (14):
>   eal: introduce division round up macro
>   net/i40e: use common division round up macro
>   net/idpf: use common division round up macro
>   net/ice: use common division round up macro
>   net/qede: use common division round up macro
>   net/rnp: use common division round up macro
>   net/hns3: use common division round up macro
>   net/hinic: use common division round up macro
>   net/bnx2x: use common division round up macro
>   net/cxgbe: use common division round up macro
>   net/ena: use common division round up macro
>   raw/ifpga/base: use common division round up macro
>   drivers: use common division round up macro
>   app/procinfo: use common division round up macro
> 
>  app/proc-info/main.c                        |  3 +--
>  drivers/common/nfp/nfp_platform.h           |  2 --
>  drivers/net/bnx2x/bnx2x.c                   |  4 ++--
>  drivers/net/bnx2x/bnx2x.h                   | 11 ++++-------
>  drivers/net/cxgbe/base/t4_hw.c              |  4 ++--
>  drivers/net/cxgbe/base/t4vf_hw.c            | 10 +++++-----
>  drivers/net/cxgbe/cxgbe_compat.h            |  3 +--
>  drivers/net/cxgbe/cxgbe_filter.c            |  6 +++---
>  drivers/net/cxgbe/cxgbe_ofld.h              |  4 ++--
>  drivers/net/cxgbe/sge.c                     | 14 +++++++-------
>  drivers/net/ena/base/ena_eth_com.h          |  4 ++--
>  drivers/net/ena/base/ena_plat_dpdk.h        |  1 -
>  drivers/net/hinic/base/hinic_compat.h       |  5 +----
>  drivers/net/hns3/hns3_ethdev.h              |  2 --
>  drivers/net/hns3/hns3_fdir.c                |  2 +-
>  drivers/net/hns3/hns3_regs.c                |  8 ++++----
>  drivers/net/hns3/hns3_rss.c                 |  8 ++++----
>  drivers/net/intel/i40e/base/i40e_osdep.h    |  3 +--
>  drivers/net/intel/ice/base/ice_osdep.h      |  3 +--
>  drivers/net/intel/idpf/base/idpf_osdep.h    |  3 +--
>  drivers/net/nfp/nfdk/nfp_nfdk.h             |  5 +++--
>  drivers/net/nfp/nfdk/nfp_nfdk_dp.c          |  3 ++-
>  drivers/net/nfp/nfpcore/nfp_nsp.c           |  2 +-
>  drivers/net/qede/base/bcm_osal.h            |  2 --
>  drivers/net/qede/base/ecore_chain.h         |  2 +-
>  drivers/net/qede/base/ecore_cxt.c           | 20 +++++++++++---------
>  drivers/net/qede/base/ecore_init_fw_funcs.c | 21 ++++++++++++---------
>  drivers/net/qede/base/ecore_mcp.c           |  6 +++---
>  drivers/net/qede/qede_debug.c               | 16 ++++++++--------
>  drivers/net/rnp/base/rnp_osdep.h            |  5 ++---
>  drivers/net/rnp/rnp_rxtx.c                  |  2 +-
>  drivers/raw/ifpga/base/opae_osdep.h         |  3 +--
>  lib/eal/include/rte_common.h                |  5 +++++
>  33 files changed, 92 insertions(+), 100 deletions(-)
> 

Looks good, the only feedback from AI runs were noise
about blank lines etc.

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
