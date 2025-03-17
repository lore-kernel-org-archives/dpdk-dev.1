Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BAEC282EC
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Mar 2025 09:50:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BDC2402D1;
	Mon, 17 Mar 2025 10:50:43 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id D0096402BB
 for <dev@dpdk.org>; Mon, 17 Mar 2025 10:50:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742205040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4X5VU7C03YMzbK1dLtP6UMDZuZaj1VN17MOXWhBW5Z8=;
 b=Nma4qMHn1HIG1JNZsHxMeA5ba0rzA5n0vJWe2wZGaeUDLJmUtJro5QJS9YKBnIzFNo3Uh2
 DbMBsNx3kfAID5zZ/QuQNrpuryGfEX7i1gSeqOLPaQguZmhC5sn444ppfGKsllXWgobveb
 uQFkmrqvf54kgmHcOvayLrgMZsmGwMs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-N5cEJISqNzGWYrQdHi_ZOA-1; Mon, 17 Mar 2025 05:50:38 -0400
X-MC-Unique: N5cEJISqNzGWYrQdHi_ZOA-1
X-Mimecast-MFC-AGG-ID: N5cEJISqNzGWYrQdHi_ZOA_1742205037
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5496d38f725so2286653e87.2
 for <dev@dpdk.org>; Mon, 17 Mar 2025 02:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742205037; x=1742809837;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4X5VU7C03YMzbK1dLtP6UMDZuZaj1VN17MOXWhBW5Z8=;
 b=a2nFOw30OkgakzCTGUoA9sWo/p0zBh2wTWe2FfnRd7ZuwdKP9wmQRkLZNUy/Rg8w0v
 v0HuVqbTa1bahmvFxF0BqqOiHfHVKZ/bIqGdPM+2J/4BSrdtEoKgHALTpOhm6pGSyhvm
 WFBoc7As9Q9rnmL25ZsdeT5RkBqz2WE6EMDVgQXndInLQ5q9/dc1DEWs2XZHlNIy5XKf
 D03ynubFlevgd7fPUcB3PhHjkBZ28mlC9tbeWVOYgk4DVASSjPdE6GUNZY9oheLy5jkq
 aczk+TBG0UAMGvbx37yyelxtPPhbaHum2iyma7eJzLvZP22zhNIXNTuxsWkMKg0vC5Jl
 11yg==
X-Gm-Message-State: AOJu0YwWB4uslHe+xb73p9JXFE7TV8B2FPBuzanL2W3HTxzyp/QZgows
 6JUggrk04ZmA5oCSBUSmsrDglORkz6OH65RgCiB3a0EaIzdVMWKKpe7c73j8//G/OGHca4jddPS
 0lByJK8reBELq3+eFxt2LSUo5OdI4Mpt4pBmrVFg0/jnJNfGVzj/Po8dVj/ZqCnPOE6tZmu1lBu
 FHmEdK0zIhRn8Syqk=
X-Gm-Gg: ASbGncvS+RuID7cVXaUoHQfc74fJ/ww5BkvDu0E2/tJibjYHKbAGJ+B+7TksRLV6H0u
 tnP6FJzOtlZRAeVXec2Ppu2Q2F8Eh6/yfD2tvxHUQovACedFb9CNC7wKiRhShIYL/XacCizO/BZ
 0=
X-Received: by 2002:a05:6512:3f16:b0:545:60b:f38c with SMTP id
 2adb3069b0e04-549c396eed9mr5542889e87.41.1742205037335; 
 Mon, 17 Mar 2025 02:50:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExzyO1DHnn3thdnW6pAjNmsXVXcNLhjfq2Ez4Xs9esg3tEDRtfjGrUDmc1CnpNzXdd97vqVMi1uPuLT+J7DgQ=
X-Received: by 2002:a05:6512:3f16:b0:545:60b:f38c with SMTP id
 2adb3069b0e04-549c396eed9mr5542877e87.41.1742205036955; Mon, 17 Mar 2025
 02:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250314172339.12777-1-bruce.richardson@intel.com>
 <20250314174439.112658-1-bruce.richardson@intel.com>
In-Reply-To: <20250314174439.112658-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 17 Mar 2025 10:50:24 +0100
X-Gm-Features: AQ5f1JqJ7ehwfqzVeqeH4YUq5nVwCJJZk6tHkw-e1CVZnDO4pbzatB_IgwmWoT4
Message-ID: <CAJFAV8w_gdDZ49nJNMxaxvk-Sv8v6T_FK6nWbVyaoKELjaJRUg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] remove driver-specific logic for AVX builds
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7sxneGsTfSAl3AlsgRqu0C-YS0_62GQeSgBecpVIYR4_1742205037
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

On Fri, Mar 14, 2025 at 6:44=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> A number of drivers had special optimized AVX2 and AVX512 code paths
> for performance reasons, and these tended to have copy-pasted logic
> to build those files. Centralise that logic in the main
> drivers/meson.build file to avoid duplication.
>
> v2: add patch 4 to remove use of unnecessary CC_AVX2_SUPPORT flag
>
> Bruce Richardson (4):
>   build: add generalized AVX handling for drivers
>   net/intel: use common AVX build code
>   drivers/net: build use common AVX handling
>   drivers/net: remove AVX2 build-time define
>
>  drivers/meson.build                   | 30 +++++++++++++++++++++++++++
>  drivers/net/bnxt/bnxt_ethdev.c        |  2 --
>  drivers/net/bnxt/meson.build          | 10 +--------
>  drivers/net/enic/meson.build          | 10 +--------
>  drivers/net/intel/i40e/meson.build    | 26 ++---------------------
>  drivers/net/intel/iavf/meson.build    | 25 ++--------------------
>  drivers/net/intel/ice/meson.build     | 25 ++--------------------
>  drivers/net/intel/idpf/meson.build    | 25 ++--------------------
>  drivers/net/nfp/meson.build           | 10 +--------
>  drivers/net/octeon_ep/meson.build     | 13 +-----------
>  drivers/net/octeon_ep/otx_ep_ethdev.c |  4 ----
>  drivers/net/virtio/meson.build        |  9 +-------
>  12 files changed, 43 insertions(+), 146 deletions(-)

event/dlb2 can be converted too, or is there something special about
this driver?


As part of the discussion on the base drivers, and seeing this series,
it would be cool if we had a generic framework to specify a set of
cflags for a set of sources.
But at least this series lgtm and is a first step.


--=20
David Marchand

