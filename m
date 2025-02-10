Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1575C0219E
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 20:27:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2F73402AB;
	Mon, 10 Feb 2025 21:27:07 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id A5DCF402A1
 for <dev@dpdk.org>; Mon, 10 Feb 2025 21:27:05 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-21f818a980cso29827375ad.3
 for <dev@dpdk.org>; Mon, 10 Feb 2025 12:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739219225;
 x=1739824025; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=15aKtzv878sjxdDO4d8wQkv0lg9McpIL7bbDtWzn4GQ=;
 b=LO80r04SgIzSAD2oPJJ2ZiUa34UxKiyHvvQsH/HK2qxD4526WfEk3htB3uIvw4+ccs
 +YXsXRvPgQM4k6GS7Jb2oW+PkHX42NQRUjbW4Z5pGkQCIq6EffwlddTwqa3oX/w1aI9T
 w+ATFR1oNURZMapQD8/NnH7zI187Lk9tIYXiCx5GXk0/ckPF0Xfy2pvf6QRrH5HFGIeY
 6X/6Ej4yWJpJPIkYq1xGnOkOfnX+UUSI2oHNC3vwwhnhVDeEGuy7vxS2EFvWSknPIz6l
 F2rgaSA6O3h3E0+QWM7WRpVIpkdWLkrh8ajCaCS2O+qpEfGNZ7K5WWIc5lKWRFRL74U+
 RQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739219225; x=1739824025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=15aKtzv878sjxdDO4d8wQkv0lg9McpIL7bbDtWzn4GQ=;
 b=VwLYfENPIdfJZL9In2Cj3AgjQS4ley0A+vinepzBJdSPbuRVc1VOdQqeO+M3HRaXdD
 p3t5KCIYgzfS0Gh/wqUl8Uw0HFEoQffB6tztunbL3MKGhvgxoRdICq3DMSbhMrS2GE0d
 z9y/w8IfKnTvmbL4SI5hUXo7X6m2wxNYSMJ97NGhBuUEc5VwGufSB5fQwREQRs7oi1MR
 HJB3RRvFwsbWSYv8MMNX4fD52yDktVF34aGeZdi7dIC6mVv9tNTfSzXRuuseYuwtW2ru
 wnc44mMnOZDHnpGHjTF7FVs2euIu9WfbbbqSXa734q69rQ2H+zHxYpafRiyHZhjrqrS3
 smGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7/Lh5doQRL7EJelUSaMEVlwDqruc458uTumg148SM3QlrkBx3DXFryMSdNHGZLU8lnck=@dpdk.org
X-Gm-Message-State: AOJu0YyqqhDUUoE4fUEzQQmINR+CBb9oYQYq0GOKAT/jrov3es1/nAhq
 sKizOJq6SAjXBXllFa6pya8weq8BKHqpOtUOGdnbJ6Ytb7qlXeCJskVxCcHipfc=
X-Gm-Gg: ASbGnctnM7wHqvgzEuy7t1fxASVNRqBTYMNcFKFOWKxQaGhZugMLuFoobfNcbb2uB+h
 QbSZipSBj7PMls2o2lBdzTqpKzoj0KdPTocC1Ds4UDMQGBZGpeR4vqsc50RRcCTPVFVko+VirrT
 oJ38ObNLdEI7aspT2+MEzd0Ikb4GxyU+LfRUHhQkpl35VCU8Rp1BBIsGEbtNyKVhyjMOhzpAfpS
 fWntbfovcYuaQM3aagsZJEGt3ur/0EBwbwwI4xa7olUFBwK+Dw5OlMcpgLxVa8HNvTX0UNg7KaV
 awnsSmf6C3VXvSn2viuRripSsyBRhMTJcOBVxwNuKqP7FynGn2dR17vbWPExB/DQMOBE
X-Google-Smtp-Source: AGHT+IFYPbjOaPjW/l/2zy4DFSLpJY7U60EIShjtpcZltRSbEj1xOdvMpGZ4tnJpln+wmP1WxpvwrA==
X-Received: by 2002:a17:902:f60a:b0:21f:3e2d:7d48 with SMTP id
 d9443c01a7336-21f4e129872mr248390265ad.0.1739219224687; 
 Mon, 10 Feb 2025 12:27:04 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f368ba864sm81661035ad.233.2025.02.10.12.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 12:27:04 -0800 (PST)
Date: Mon, 10 Feb 2025 12:27:02 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <thomas@monjalon.net>, <david.marchand@redhat.com>, <dev@dpdk.org>,
 <mb@smartsharesystems.com>, <anatoly.burakov@intel.com>,
 <dmitry.kozliuk@gmail.com>, <jerinjacobk@gmail.com>,
 <hofors@lysator.liu.se>
Subject: Re: [PATCH v19 1/6] memarea: introduce memarea library
Message-ID: <20250210122702.39f83617@hermes.local>
In-Reply-To: <20230720092254.54157-2-fengchengwen@huawei.com>
References: <20220721044648.6817-1-fengchengwen@huawei.com>
 <20230720092254.54157-1-fengchengwen@huawei.com>
 <20230720092254.54157-2-fengchengwen@huawei.com>
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

On Thu, 20 Jul 2023 09:22:49 +0000
Chengwen Feng <fengchengwen@huawei.com> wrote:

> The memarea library is an allocator of variable-size object which based
> on a memory region.
>=20
> This patch provides rte_memarea_create() and rte_memarea_destroy() API.
>=20
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> Reviewed-by: Dongdong Liu <liudongdong3@huawei.com>
> Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  MAINTAINERS                            |   5 +
>  doc/api/doxy-api-index.md              |   3 +-
>  doc/api/doxy-api.conf.in               |   1 +
>  doc/guides/prog_guide/index.rst        |   1 +
>  doc/guides/prog_guide/memarea_lib.rst  |  48 ++++++
>  doc/guides/rel_notes/release_23_07.rst |   6 +
>  lib/memarea/memarea_private.h          | 116 ++++++++++++++
>  lib/memarea/meson.build                |  18 +++
>  lib/memarea/rte_memarea.c              | 204 +++++++++++++++++++++++++
>  lib/memarea/rte_memarea.h              | 141 +++++++++++++++++
>  lib/memarea/version.map                |  12 ++
>  lib/meson.build                        |   1 +
>  12 files changed, 555 insertions(+), 1 deletion(-)
>  create mode 100644 doc/guides/prog_guide/memarea_lib.rst
>  create mode 100644 lib/memarea/memarea_private.h
>  create mode 100644 lib/memarea/meson.build
>  create mode 100644 lib/memarea/rte_memarea.c
>  create mode 100644 lib/memarea/rte_memarea.h
>  create mode 100644 lib/memarea/version.map
>=20

The library is still interesting but patch needs some changes and rebasing.

> diff --git a/doc/guides/rel_notes/release_23_07.rst b/doc/guides/rel_note=
s/release_23_07.rst
> index 6a1c45162b..2751d70740 100644
> --- a/doc/guides/rel_notes/release_23_07.rst
> +++ b/doc/guides/rel_notes/release_23_07.rst
> @@ -222,6 +222,12 @@ New Features
> =20
>    See the :doc:`../tools/dmaperf` for more details.
> =20
> +* **Added memarea library.**
> +
> +  The memarea library is an allocator of variable-size objects, it is or=
iented
> +  towards the application layer, providing 'region-based memory manageme=
nt'
> +  function.
> +
>

This would need to be for 25_03 now


> diff --git a/lib/memarea/meson.build b/lib/memarea/meson.build
> new file mode 100644
> index 0000000000..7e18c02d3e
> --- /dev/null
> +++ b/lib/memarea/meson.build
> @@ -0,0 +1,18 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2023 HiSilicon Limited
> +
> +if is_windows
> +    build =3D false
> +    reason =3D 'not supported on Windows'
> +    subdir_done()
> +endif

Is there a strong reason this can't be used on Windows?

...

> +void
> +rte_memarea_destroy(struct rte_memarea *ma)
> +{
> +	if (ma =3D=3D NULL) {
> +		rte_errno =3D EINVAL;

No, this is normal, do not set EINVAL here.

> +		return;
> +	}
> +	memarea_free_area(&ma->init, ma->area_base);
> +	rte_free(ma);
> +}

Also add rte_memarea_destroy to the null_free coccinelle script
so that any cleanup pass later would fix unnecessary null checks
around this function.

> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * Create memarea.
> + *
> + * Create one new memarea.
> + *
> + * @param init
> + *   The init parameter of memarea.
> + *
> + * @return
> + *   Non-NULL on success. Otherwise NULL is returned (the rte_errno is s=
et).
> + */
> +__rte_experimental
> +struct rte_memarea *rte_memarea_create(const struct rte_memarea_param *i=
nit);

Now that DPDK has function attributes on allocators,
this function should be:
	__rte_malloc
and
	__rte_dealloc(rte_memarea_destroy, 1)


> +
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * Destroy memarea.
> + *
> + * Destroy the memarea.
> + *
> + * @param ma
> + *   The pointer of memarea.
> + *
> + * @note The rte_errno is set if destroy failed.
> + */
> +__rte_experimental
> +void rte_memarea_destroy(struct rte_memarea *ma);
> +

When using __rte_dealloc, would need this prototype to be
before the create function

> +#ifdef __cplusplus
> +}
> +#endif
