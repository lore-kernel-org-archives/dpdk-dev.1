Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CF2C35FFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 10:27:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54B0240648;
	Wed, 19 Mar 2025 11:27:26 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B1B54402EF
 for <dev@dpdk.org>; Wed, 19 Mar 2025 11:27:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742380044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=glbBWBq9j8JhgkIJeoNML3mQKhh4XVPpj3yLOivF+W4=;
 b=Qp3SNGntKALgMM2JFgUf4WS9PmyC5tv2mUmpvcXsYUt0JvxaVtvnPQjHFZngvEOdk+Td76
 bOQNodWC8uxH/2zelmlG7lSYo5rI2w+c9sSH+yCBbqDDjiWEQR+T2pkeKS8Akh6BvRJ9CJ
 ngnABu4/IROQ/aDEhGcYV2VweZCmxyk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-ItIyGn2ZN5eUUwykzzpOEw-1; Wed, 19 Mar 2025 06:27:22 -0400
X-MC-Unique: ItIyGn2ZN5eUUwykzzpOEw-1
X-Mimecast-MFC-AGG-ID: ItIyGn2ZN5eUUwykzzpOEw_1742380041
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5499b98c870so3286164e87.3
 for <dev@dpdk.org>; Wed, 19 Mar 2025 03:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742380041; x=1742984841;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=glbBWBq9j8JhgkIJeoNML3mQKhh4XVPpj3yLOivF+W4=;
 b=R5J7NGDDg67+FcZtqycqz98/LEArLgESCMtJKLFxl0x6GfUmIMW/HoElBdGteFRntc
 cabQIM4oQziPW90eLcba8yLE6AOH2Wp/ifn2xUrWtfLl2WC7bT0YqTe192lu/rxnHT1R
 3Wu7LvGMYU8512YMS92ZYF2cwpdS1JVBu7Fkfq4EvyWbIXT+4yBhP0U82JofK2B97yNL
 1+zlVGjqKZVD623GroGLTqr4aTTtV1mf0VFhT3PzVsDfg+BJhL3Rm24DcHVZPW4P0Jq+
 j1UNovI5gQyfjNgK01wAW3ypMfKzNR/nICOWdu5OdGd05mQncEe1lEJjDA0vQOAFZhhK
 0qDA==
X-Gm-Message-State: AOJu0YzXUCumrs4sMnWoqgw4+Vm38pufGiN3a+A2pPTKgJcRg2UzFqsT
 /JPZD2lqQJsAR7dkR+OWDj2z9Ge0kEbETPkPMfiRVfAY2nI3Qt7TMgj9dCgBTi38PNzQIxTxNSQ
 kwYJZ7hypBfKjdgIQwYLvOfbcHAQ83aA9dPN2h0ytsy0JgOTvSyeDFLDl0ilZazFoyxv8BpBOTg
 qNAzSc9nQ5W89MBMc=
X-Gm-Gg: ASbGncv1OEEh6JeLv4o0YgOgsgB+KKk8pxlHUmPRYavctExbCMRHsp4nYDHD3f/+Hvr
 N+GyQZtLKzQbMH3OPMcwczi9qHWaZ+Kw3OxPr4VSu09+nCi+dGIc0bo1ODynjZFoYceJ+8e33Tk
 Q=
X-Received: by 2002:a05:6512:31c9:b0:545:62c:4b29 with SMTP id
 2adb3069b0e04-54acb1bd545mr635672e87.22.1742380041012; 
 Wed, 19 Mar 2025 03:27:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM13Wzy2GAIRjD9M3PtLpkDgseAmRLgKHA9LVz3Z30L4qIVijdWBjFlQoamdtWiwbpurGvOXMHTPhTwFI94xM=
X-Received: by 2002:a05:6512:31c9:b0:545:62c:4b29 with SMTP id
 2adb3069b0e04-54acb1bd545mr635664e87.22.1742380040552; Wed, 19 Mar 2025
 03:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250314172339.12777-1-bruce.richardson@intel.com>
 <20250318173505.314529-1-bruce.richardson@intel.com>
In-Reply-To: <20250318173505.314529-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 19 Mar 2025 11:27:08 +0100
X-Gm-Features: AQ5f1JrlUMpJIUgMUn8Rl7cBFo9zkmE1IR8VnVMqyo_xGu6WJtVCkV7o95w8UV0
Message-ID: <CAJFAV8x02BOM-dZHdrRyGFLLHqxb+6hpPL0+wYDXqSedLa1z6w@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] remove component-specific logic for AVX builds
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rzUOL5Bc6fXWDtIM6lyE6vQPW0E4CBDwtcYBjIslbhA_1742380041
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Mar 18, 2025 at 6:35=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> A number of libs and drivers had special optimized AVX2 and AVX512 code
> paths for performance reasons, and these tended to have copy-pasted
> logic to build those files. Centralise that logic in the main
> drivers/ and lib/ meson.build files to avoid duplication.
>
> v3: add patch for event/dlb2 AVX512 handling.
>     add common code for libraries as well as drivers.
> v2: add patch 4 to remove use of unnecessary CC_AVX2_SUPPORT flag
>
>
> Bruce Richardson (11):
>   build: add generalized AVX handling for drivers
>   net/intel: use common AVX build code
>   drivers/net: build use common AVX handling
>   drivers/net: remove AVX2 build-time define
>   event/dlb2: build using common AVX handling
>   build: add generalized AVX handling for libs
>   acl: use common AVX build handling
>   fib: use common AVX build handling
>   net: simplify build-time logic for x86
>   net: use common AVX512 build code
>   member: use common AVX512 build support
>
>  drivers/event/dlb2/dlb2_sse.c         |  4 ++
>  drivers/event/dlb2/meson.build        | 16 +-------
>  drivers/meson.build                   | 30 ++++++++++++++
>  drivers/net/bnxt/bnxt_ethdev.c        |  2 -
>  drivers/net/bnxt/meson.build          | 10 +----
>  drivers/net/enic/meson.build          | 10 +----
>  drivers/net/intel/i40e/meson.build    | 26 +-----------
>  drivers/net/intel/iavf/meson.build    | 25 +-----------
>  drivers/net/intel/ice/meson.build     | 25 +-----------
>  drivers/net/intel/idpf/meson.build    | 25 +-----------
>  drivers/net/nfp/meson.build           | 10 +----
>  drivers/net/octeon_ep/meson.build     | 13 +-----
>  drivers/net/octeon_ep/otx_ep_ethdev.c |  4 --
>  drivers/net/virtio/meson.build        |  9 +----
>  lib/acl/meson.build                   | 54 ++-----------------------
>  lib/fib/dir24_8.c                     |  6 +--
>  lib/fib/meson.build                   | 18 +--------
>  lib/fib/trie.c                        |  6 +--
>  lib/member/meson.build                | 46 ++++-----------------
>  lib/meson.build                       | 34 +++++++++++++++-
>  lib/net/meson.build                   | 58 +++------------------------
>  lib/net/rte_net_crc.c                 | 16 ++++----
>  22 files changed, 114 insertions(+), 333 deletions(-)

I just have some nits (and we need a rebase), otherwise this is a nice clea=
nup.
Thanks Bruce.


--=20
David Marchand

