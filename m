Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89F9C36008
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 10:13:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0174A402DF;
	Wed, 26 Mar 2025 11:13:14 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 495CE402DA
 for <dev@dpdk.org>; Wed, 26 Mar 2025 11:13:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742983992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AVyHE+ECr8iGWtlMYG9uHlruBgNhilzOpuSWfdJfVNg=;
 b=d3UefIAEVfP3R8Cb+e/y5uOYNbBqfhiZnxLr/6/YiH7whGw6BQZOxhprfIp5KjtSNh41/O
 C5mZ8VXvLVatWqoeh4Z+bwZYSQU9UrV7TZk3KdsdmuMQiZ2tTS9w4ZfOMEp3zU2A5OKpSu
 RRCPnPVIY5b61VPcZKpYS9qg1Iawotw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-yS8vJVYkPLGaws4e8gYXGw-1; Wed, 26 Mar 2025 06:13:11 -0400
X-MC-Unique: yS8vJVYkPLGaws4e8gYXGw-1
X-Mimecast-MFC-AGG-ID: yS8vJVYkPLGaws4e8gYXGw_1742983990
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-30bf6cdaf17so30985721fa.3
 for <dev@dpdk.org>; Wed, 26 Mar 2025 03:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742983990; x=1743588790;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AVyHE+ECr8iGWtlMYG9uHlruBgNhilzOpuSWfdJfVNg=;
 b=YfHDwPm9qBc93Ecbqcc6gjKug+XqDyYQUeimyUkiz6vayw/5feyHQF1xL4PAbYmc1U
 M62IltL2ejrTPffvccAPDSThIi31KoqPJUenEJqANnTeShTYis+zmsWdXTSEwid37cxT
 9R/Atm9LBFhzDkOwm/Mqgjtld3gIu0Ls1ZFDdqfp2uGLQvBBnh66ayCJFS3EjXQVonCr
 XvNrCE5prcgJCgH4m1afAxhVg8cjpHmnpwrMaP03R/t4vbYFH78HfeSOjDZ5uP7HTD3i
 nZmtEWn2dY05dshiCtBiiyiSiinC0mwnyvUISLxuraYjwW83H9t7+zp1X18EoxXOpR4V
 3qWQ==
X-Gm-Message-State: AOJu0YxeZzr8hq9RCMgpxX5V1u9XA07VFPVBxSAuOnYsCBGtqTfjXwWT
 rgmyNYZFoNOs0l1qvVi+Tfnzg2l85UVILdFFRVASxOmMWch2/4AnMTjGHUfO+yfRonm0/TB2/jO
 ziKo67/6N+gDvvDTkbTProqXvVg7ToSq/7LhzBalcS47wo+7Uv/6LranPBH+bbl1ni5eu7sicHc
 qeCkD4emg+38TA9jrCtsdEF7U=
X-Gm-Gg: ASbGncvk/CBdYmZYPYXR4/BWsrfMyYHXJi43o1BWcmGRBiiMAcduqIDNZSZg3gWMbZp
 GtihvVEcYRZl3JUlZnwX7MKVIxt//fMNEqrsgdVLMmOsu63fQiPub+1e5omEFaaaXEWcPp1k2+D
 o=
X-Received: by 2002:a2e:bc21:0:b0:30c:2d44:c212 with SMTP id
 38308e7fff4ca-30d7e222a59mr74653901fa.9.1742983989945; 
 Wed, 26 Mar 2025 03:13:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3MnaX08Ek95+9sXxneCkYWHUrRW0lz4/UZnyJ70sxaj0p/nS4+Dg9MA2yXUuCW5WIYPtPuxr9Ap7eFmJmKNI=
X-Received: by 2002:a2e:bc21:0:b0:30c:2d44:c212 with SMTP id
 38308e7fff4ca-30d7e222a59mr74653751fa.9.1742983989527; Wed, 26 Mar 2025
 03:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250314172339.12777-1-bruce.richardson@intel.com>
 <20250325160254.1724560-1-bruce.richardson@intel.com>
In-Reply-To: <20250325160254.1724560-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 26 Mar 2025 11:12:57 +0100
X-Gm-Features: AQ5f1JoDr47D-HH7aDmv6X2R0FK2m3sz3bMJUdgciA5gwpWOKoTpiQIh6t16US8
Message-ID: <CAJFAV8zhNmSujARaW+UfFt2hn_szBqTZiCJoBqymOEGxvfWtwQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] remove component-specific logic for AVX builds
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iYRIEKtEyN0-F9hUp_rO5qoPpkcJe_tG0fn6pIAo3Sw_1742983990
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

On Tue, Mar 25, 2025 at 5:03=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> A number of libs and drivers had special optimized AVX2 and AVX512 code
> paths for performance reasons, and these tended to have copy-pasted
> logic to build those files. Centralise that logic in the main
> drivers/ and lib/ meson.build files to avoid duplication.
>
> v5: fix RTE_ARCH_X86 macro, which broke crc library
> v4: rebase on latest main branch
>     minor fixes following feedback
>     limit use of -march=3Dskylake-avx512 to when we don't already have a
>       -march flag supporting AVX512.
> v3: add patch for event/dlb2 AVX512 handling.
>     add common code for libraries as well as drivers.
> v2: add patch 4 to remove use of unnecessary CC_AVX2_SUPPORT flag
>
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

Thank you Bruce, this series lgtm.


--=20
David Marchand

