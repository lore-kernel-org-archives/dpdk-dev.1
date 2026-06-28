Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE62C43458
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Jun 2026 13:57:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24A1240278;
	Sun, 28 Jun 2026 15:57:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 86B6D400D7
 for <dev@dpdk.org>; Sun, 28 Jun 2026 15:57:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782655048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MXm4+VvdumLe9GrbAcbnGGVd6V3N1TwHilo1h6xYf1U=;
 b=Ldt2Tu4gEAyX/NcpqXbtwCrcPUl7eHiIFJEU0pckMLfck7vA6P3C4uJ9P0xi+9+dALn2vN
 mcOCMCGdyYMr9miBGVVyFWFeCRE/6ukN83EFzQ7maXVdptCBmL+x5mun1di1NI35JEsg6P
 0LxoxkXqFnDFAT0WWZBn51bSdIdsvp8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-gbq05OPcNNmM2FS3F29RJg-1; Sun, 28 Jun 2026 09:57:27 -0400
X-MC-Unique: gbq05OPcNNmM2FS3F29RJg-1
X-Mimecast-MFC-AGG-ID: gbq05OPcNNmM2FS3F29RJg_1782655046
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-39afa7cbccaso1941771fa.1
 for <dev@dpdk.org>; Sun, 28 Jun 2026 06:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782655046; x=1783259846;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MXm4+VvdumLe9GrbAcbnGGVd6V3N1TwHilo1h6xYf1U=;
 b=sdgnyLKttkPUeCERrmUYqjemBUA3joUYYx4mBHNgJNb7OXxcdbWvD44ffUjXxeWSju
 Y/ilJcrilnWinAF3HLhj7bAsyMwSIRkZ2rWKrhhnUCmVzpALa+Dg1n3F3kA51AYMTid8
 lzduwUH+lDnOB/JFsHSo7JL1WZbnzRyQQsDirhvuJJYtFSb7rr1rcDfmvuTR4X2laAr1
 77pYDqdh8P5tp2kUx84mB0U6sUUkk/hAqv7ZTsfZazNVzEdu1nPHVW0P+t4QUjM0I41x
 lWc6eEQT4n61wqmKJ4WSOJcDWS9bTJdS++v/OTcXiELGHckQlGhBunE9bAuczfe8L43p
 Xgzg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpe7F2kaMyPrzeS3ULJXghNfvO/ms6AE5REO+Sh/vRLkasw5daAZkKChYLd8TcNjf7PtTw=@dpdk.org
X-Gm-Message-State: AOJu0YzdfXmX9miPDnE4A6KMPpUsglbmAFiRGiu0zrp5JG/MrgEPZRh2
 samwil513oRCm4BSbFTDWnC5nPIwvzPnTJdY1zw0EnqS3V0bGBtFyWDVfd44oBmS0ADD/TxnKOL
 2q+sBfO6yz7FOenHbS4jUCoddnrif4rcmlqmYQRWAsBRT0hD9RrEVgHFA8QQgj84XujVPdy2SGk
 PoEwS1sBoojEXZ3K5kUT4=
X-Gm-Gg: AfdE7cm0pVJ1/pjXlqqdvNrUm8PsU8UBFnE+35/U6GCl/7JZZhlE0iFPHtR8zPLIsAC
 pwcR5ZmaCUejraxw/sMy9DZ/tYB7VMezxb9yf4PY/LWbknDFSuha+WE4Pyg6rgHv1boLRGHXmiY
 7ShtDX96ZA+WrhBDIyr7LLTEHfwoaME/7nHjmqYjUycIOxuvrsFLIRNNZ5W5rMAwP3bVbDmkCNv
 a2EcE+NcvPjeHlQaQzqYzXTR6n8Z4sX/Z1IEebO88/BA7xFh5BaGmR92k8=
X-Received: by 2002:a05:651c:2209:b0:39a:fc4b:ac15 with SMTP id
 38308e7fff4ca-39afc4bc89amr5968061fa.26.1782655045874; 
 Sun, 28 Jun 2026 06:57:25 -0700 (PDT)
X-Received: by 2002:a05:651c:2209:b0:39a:fc4b:ac15 with SMTP id
 38308e7fff4ca-39afc4bc89amr5967941fa.26.1782655045339; Sun, 28 Jun 2026
 06:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260625133311.1299705-1-dsosnowski@nvidia.com>
 <20260625160645.1341914-1-dsosnowski@nvidia.com>
In-Reply-To: <20260625160645.1341914-1-dsosnowski@nvidia.com>
From: David Marchand <david.marchand@redhat.com>
Date: Sun, 28 Jun 2026 15:57:13 +0200
X-Gm-Features: AVVi8CfVmT4aBrexKEO42VBkKzBdc8isFEhFNVYrVm38Sbtzj7Kg-ULKwp83E0M
Message-ID: <CAJFAV8zwKcABUr5kWV429+k_r=Wr=eSkGTLDymogtysobXMAwQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] add versioned symbols for recently stabilized APIs
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, 
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, 
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 dev@dpdk.org, Yu Jiang <yux.jiang@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -1vlw5MF69NbdN7gqXg6wKatMH6bSa1o-GbzNgZ7K_I_1782655046
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

Hello Dariusz,

On Thu, 25 Jun 2026 at 18:08, Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:
>
> Main goal of this patchset is to address https://bugs.dpdk.org/show_bug.cgi?id=1957
> but it also handles other recently stabilized symbols and has some minor fixes:
>
> - Patch 1 - Fix RTE_VERSION_EXPERIMENTAL_SYMBOL macro on clang.
> - Patch 2 - Allow function versioning inside drivers.
> - Patch 3 - Version the function symbols stabilized in
>   https://git.dpdk.org/dpdk/commit/?id=e8cab133645f5466ef75e511629add43b68a5027
> - Patch 4 - Version the rte_flow_dynf_metadata_register() function stabilized in
>   https://git.dpdk.org/dpdk/commit/?id=4ee2f5c1cedf9ee7f39afa667f71b07f4004ba5c
>   Restore EXPERIMENTAL version on global variable symbols
>   rte_flow_dynf_metadata_offs and rte_flow_dynf_metadata_mask.
>
> v4:
> - Fixed build with older meson versions.
>
> v3:
> - https://inbox.dpdk.org/dev/20260625133311.1299705-1-dsosnowski@nvidia.com/
> - Added rebuilding of drivers with -DRTE_BUILD_SHARED_LIB
>   whenever function versioning is enabled.
>
> v2:
> - https://inbox.dpdk.org/dev/20260624131337.1127323-1-dsosnowski@nvidia.com/
> - Drop patches introducing versioning macros for symbol aliases
>   and their usage (patch 4 and 5 from v1)
> - EXPERIMENTAL version on global variable symbols
>   rte_flow_dynf_metadata_offs and rte_flow_dynf_metadata_mask,
>   as discussed under v1.
> - Change commit title prefix in patch (2) from "drivers" to "build".
>
> v1: https://inbox.dpdk.org/dev/20260623113752.1100072-1-dsosnowski@nvidia.com/
>
> Dariusz Sosnowski (4):
>   eal: fix macro for versioned experimental symbol
>   build: support function versioning for drivers
>   net/mlx5: fix stabilized function versions
>   ethdev: fix promoted flow metadata symbols
>
>  drivers/meson.build                  | 21 ++++++++++++++++++++-
>  drivers/net/mlx5/meson.build         |  2 ++
>  drivers/net/mlx5/mlx5_driver_event.c | 22 ++++++++++++++++------
>  drivers/net/mlx5/mlx5_flow.c         | 18 ++++++++++++------
>  lib/eal/common/eal_export.h          |  2 +-
>  lib/ethdev/meson.build               |  2 ++
>  lib/ethdev/rte_flow.c                | 13 ++++++++-----
>  7 files changed, 61 insertions(+), 19 deletions(-)

LGTM.
Series applied, thanks Dariusz.

Please send the patch to drop this compat in 26.11.


-- 
David Marchand

