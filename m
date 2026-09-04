Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669F4C624DE
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 07:10:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 358D34279D;
	Fri,  4 Sep 2026 09:10:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id E04A340297
 for <dev@dpdk.org>; Fri,  4 Sep 2026 09:10:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788505845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/dwQL3HwJM93VwvHQaYJ3F2mVdblmV8l0FAZc8zQD28=;
 b=E7B+Ep0QE2CHmPY0xjaojJiyQnBC1BoT+qDuSZH59dEXQvAZYDr9sIM4wkO/1RLcK+rQEv
 a6dowCBUGFgrEbjycL4/BfNL6KF3UbZaB09mmL1oeZmsh/fW0umKJolTBYgQt2SaO1Exk3
 tEbt/H6jTE883VLzPk8x/SAx0Y4QhFU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-9ViRa3cTO3etNPAoRJ5qqA-1; Fri, 04 Sep 2026 03:10:43 -0400
X-MC-Unique: 9ViRa3cTO3etNPAoRJ5qqA-1
X-Mimecast-MFC-AGG-ID: 9ViRa3cTO3etNPAoRJ5qqA_1788505842
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-39d93d95a21so6009641fa.0
 for <dev@dpdk.org>; Fri, 04 Sep 2026 00:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788505842; x=1789110642;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/dwQL3HwJM93VwvHQaYJ3F2mVdblmV8l0FAZc8zQD28=;
 b=gmVKfKD6+CznrPCn+CPAHqCiV3F+ytAf9mAk8i1KTh1UbRGiq1/U8nXJFtv2Vpxhfa
 x53gI8nkMZJIVUQdtXkGunAZDC12MW4y7+buS9az6HyzaIN1yOFFeBLX9Rt843XQznX4
 raHZ4hKNN9apf5imTJfRZfh2zw5I9UlFdQSqCrvXq0q1L73enDvxqdvIi6PwB/Bg1ns0
 IpQnEf/LMRneRmdZA7IaxJy3+mV3neZAWeBPgLaCIPkxfAws1ZS0QfpiPeLpublHOPC/
 RrhOR4sJYmNH4AHDT4EN9ieafHaRzedj28JZdbWbEr3yEkoy3INst9X77JnQ74P6f0jl
 9xkg==
X-Gm-Message-State: AFuF++mzjf3KwJhQ+f7bvWGBIR/8BH70WyiE7GiDWByOs9NormoS34tx
 BqkUnI0LmLhAiwaXAiY62uVOdcrv+qTOXAVb+I6hLixmZVWXeh8LszYupYk7tJ8nQDO8rF/mr32
 bdL5/E/HJVxg5e5p+4Cxl83vj3WAakHR8SyHU9cpcQAfbMvkC7Z6Ry7fGGLbAN/3fGwt1xqOJDf
 EzmL6s7/XwQyxbmVKgjuc=
X-Gm-Gg: AYBFou0aIozzP5UAKpxlUfmRpNzGSCiwZsx+ShLWZeonYUo16Sq+TxZTY1SI1/PU3Ps
 /8GdXFnzKIMpnU023gcVLBwmHu1aP3rsMF14Oz7p4WZw0pY1UCR+LFN5+iOExJarWtKqSdswQZD
 8qB5IqYP3reroN6YPdUUE4buN+33/tA+K+Dm1zKn/of7ILNtTHVIWbmUXa+CGxzbITblLLrztrk
 G03V4SchC4fmJ1qTCQ/cSvpx+xf4mxCP5FOLvLdWye8oOHT
X-Received: by 2002:a2e:ac13:0:b0:3a3:7682:49a7 with SMTP id
 38308e7fff4ca-3a376824d46mr1153681fa.28.1788505842156; 
 Fri, 04 Sep 2026 00:10:42 -0700 (PDT)
X-Received: by 2002:a2e:ac13:0:b0:3a3:7682:49a7 with SMTP id
 38308e7fff4ca-3a376824d46mr1153621fa.28.1788505841622; Fri, 04 Sep 2026
 00:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260903170140.360477-1-bruce.richardson@intel.com>
In-Reply-To: <20260903170140.360477-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 4 Sep 2026 09:10:29 +0200
X-Gm-Features: AcwNN1XegGmZCQsaO6qbYS8ZcFj0ZYZBM4lRtDy0V6cYL5uegftXnDzZyUrsTL0
Message-ID: <CAJFAV8ySotPb+TMEJo=_8nRdOcb9y6nnCJ=be2zq5fPn8k-O2A@mail.gmail.com>
Subject: Re: [PATCH 00/13] Consolidate ice and iavf vector Tx paths
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: __BEEQn8m_LFcYF0YERDBSPSP70IKE78jeOdVHGhHA4_1788505842
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

On Thu, 3 Sept 2026 at 19:02, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> This patchset consolidates the ice and iavf vector Tx paths, moving the
> code to net/intel/common. The iavf code is used as the basis for the
> move, because it has a superset of the features. When the common code is
> adopted by the ice driver, it then gains features such as QinQ support
> and tunneling support.
>
> Depends-on: series-39162  ("VLAN and QinQ fixes for iavf")
>
> Bruce Richardson (13):
>   net/iavf: remove unnecessary alignment calls
>   net/intel: make Tx context flag common
>   net/iavf: use separate params for VLAN and QinQ position
>   net/iavf: deduplicate tunnel field fill functions
>   net/intel: define common macros for tunneling bit-shifts
>   net/intel: move iavf descriptor writing functions to common
>   net/intel: use function callback for lldp
>   net/ice: use common descriptor creation functions
>   net/intel: move vector Tx paths to common
>   net/ice: use common AVX Tx functions
>   net/intel: add common vector Tx fns with context handling
>   net/intel: improve Tx path selection logic
>   net/ice: enable context desc offloads for vector Tx
>
>  doc/guides/rel_notes/release_26_11.rst        |   6 +
>  drivers/net/intel/common/tx.h                 |  77 +-
>  drivers/net/intel/common/tx_vec_x86.h         | 783 ++++++++++++++++++
>  drivers/net/intel/cpfl/cpfl_rxtx.c            |   3 +-
>  drivers/net/intel/i40e/i40e_rxtx.c            |   2 +-
>  drivers/net/intel/iavf/iavf_rxtx.c            |  76 +-
>  drivers/net/intel/iavf/iavf_rxtx.h            |  34 -
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   | 496 +----------
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 495 +----------
>  drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  76 +-
>  drivers/net/intel/ice/ice_ethdev.h            |   3 +
>  drivers/net/intel/ice/ice_rxtx.c              |  34 +-
>  drivers/net/intel/ice/ice_rxtx.h              |  11 +
>  drivers/net/intel/ice/ice_rxtx_vec_avx2.c     | 159 +---
>  drivers/net/intel/ice/ice_rxtx_vec_avx512.c   | 154 +---
>  drivers/net/intel/ice/ice_rxtx_vec_common.h   |  59 --
>  drivers/net/intel/idpf/idpf_rxtx.c            |   3 +-
>  17 files changed, 1025 insertions(+), 1446 deletions(-)
>  create mode 100644 drivers/net/intel/common/tx_vec_x86.h

I do not have the time to review in detail but this series looks good to me.
My bench setup is unavailable and I am busy on other topics, so I
won't be able to test it soon.

But in any case, thank you Bruce, nice cleanup again.


-- 
David Marchand

