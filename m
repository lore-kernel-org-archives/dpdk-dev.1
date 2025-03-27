Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26E2C3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 08:00:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA9C740275;
	Thu, 27 Mar 2025 09:00:39 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id DBCB140261
 for <dev@dpdk.org>; Thu, 27 Mar 2025 09:00:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743062437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ma2BIt5hpXpJc/H+4MBtSssuoJuPM0AwhQY2WgJ7Wlo=;
 b=QAUJC+PtroTKOsjPRxApsVyVm7wkGh55syWGuVuIKBRr/kAvCzP0Xb/R/OHX6DNamATGSf
 AeDpQPzzCaul/KvkY5g973h0xrlg8b5/ptSEkYBH8EE8FN3K1Ar4XEMXhNBpsduhMZF4oZ
 N6W9Wba1ZRl5SR+FictXwXSY/RdQmEE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-y3qAPiDWNOmA7ifvEYtRUQ-1; Thu, 27 Mar 2025 04:00:36 -0400
X-MC-Unique: y3qAPiDWNOmA7ifvEYtRUQ-1
X-Mimecast-MFC-AGG-ID: y3qAPiDWNOmA7ifvEYtRUQ_1743062434
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5496d38f725so423496e87.2
 for <dev@dpdk.org>; Thu, 27 Mar 2025 01:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743062434; x=1743667234;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ma2BIt5hpXpJc/H+4MBtSssuoJuPM0AwhQY2WgJ7Wlo=;
 b=NUfE6q1uqehEgXbcGj0N7l2NyZb3jnwbtHvpE6lSHTQdaGYpa54YyBbREAtHePWNBk
 dA/+xe0i5eBxq7NI1FWbYl7rjWOHpkDnH8HPoFpgilMA/jMbvfB0caJRr4dMUain6lit
 vsfG/1pXKp/iiGin5aTtMbLgA5nbz7XQ/i9nb2GpLt1dw5JxQF34ya3siP3Bgtkqf7FT
 +mXy/+5ishaAIxzg0ark8R056+R/bBS0RPOO5sMJuGeZTWEAaRmM9V9dK6jELWRY8qqt
 kpFWZM2vxM+fcrz+NXdrIPZ+h/ZISpBTcWU0qZOK6um9YeaDTNI7cHhRZ+CwEUiNpP7M
 EMOQ==
X-Gm-Message-State: AOJu0YxlB8WIBgnnWEVzZVwFpevBizXLaY0+HUTsSwWJ5Dne/OFR4Hiw
 2DeSSI2JNll8Jt72UoGj3sA5dsBD0k2Z6oDTngubAjl/1ntQBXqg41VfbIVixofRf+mBMLzfAcH
 FXfSoo2I/2azNhIaUHqN5J9Qnzy4piqc8emHM9bjzm5fAvNzsXdARtxZs6xK2iA5B7PFghQRFK9
 zHTMjdRuK56FaA3ME=
X-Gm-Gg: ASbGncv9RlxAiI6+fa7aucvc56jSFYOahFlj1HDT4eSBVbRW7ulAtbZfLoeLQVvx/BJ
 93xBa8R+mYoeU+DrVPzOeXD2gkgGSYL0cs+6RnIP40iOqbWNZ5lMvQxHZkQ0b0sjUqeG9Zz2I/6
 0=
X-Received: by 2002:a05:6512:3f22:b0:549:4e80:5c83 with SMTP id
 2adb3069b0e04-54b012201e5mr903095e87.38.1743062433609; 
 Thu, 27 Mar 2025 01:00:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+Giq/EhM/RlQmKYs2lhpOT7LJghiwkZ4emihm6uu//i+A5RpIZOyYDrTVwEkVoN/k/tUFYCLuszoXWnhWaCc=
X-Received: by 2002:a05:6512:3f22:b0:549:4e80:5c83 with SMTP id
 2adb3069b0e04-54b012201e5mr903083e87.38.1743062433166; Thu, 27 Mar 2025
 01:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250314172339.12777-1-bruce.richardson@intel.com>
 <20250319172942.2992053-1-bruce.richardson@intel.com>
In-Reply-To: <20250319172942.2992053-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 27 Mar 2025 09:00:21 +0100
X-Gm-Features: AQ5f1JrZlCGXct59FIkuEI9z0bg67VA7cq-FygNnrAs4G0KdEdVDmWzFj8rQioA
Message-ID: <CAJFAV8xwq8KtxbqC7Te9RoiC8RmS9CNBh-dYbC5D-=+_pVUrrg@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] remove component-specific logic for AVX builds
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OPJQsDQv9ZU80p-LCOXlUm-Gco1TTaOjTEpToqu9G98_1743062434
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

On Wed, Mar 19, 2025 at 6:30=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> A number of libs and drivers had special optimized AVX2 and AVX512 code
> paths for performance reasons, and these tended to have copy-pasted
> logic to build those files. Centralise that logic in the main
> drivers/ and lib/ meson.build files to avoid duplication.
>
> v4: rebase on latest main branch
>     minor fixes following feedback
>     limit use of -march=3Dskylake-avx512 to when we don't already have a
>       -march flag supporting AVX512.
> v3: add patch for event/dlb2 AVX512 handling.
>     add common code for libraries as well as drivers.
> v2: add patch 4 to remove use of unnecessary CC_AVX2_SUPPORT flag
>
> Bruce Richardson (11):
>   drivers: add generalized AVX build handling
>   net/intel: use common AVX build code
>   drivers/net: build use common AVX handling
>   drivers/net: remove AVX2 build-time define
>   event/dlb2: build using common AVX handling
>   lib: add generalized AVX build handling
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

Series applied, thanks Bruce.


--=20
David Marchand

