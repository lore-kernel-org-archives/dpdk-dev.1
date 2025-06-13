Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03ADBC61DB2
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 05:06:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89972402E2;
	Fri, 13 Jun 2025 07:06:49 +0200 (CEST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id AE27F402A1
 for <dev@dpdk.org>; Fri, 13 Jun 2025 07:06:47 +0200 (CEST)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7d0976776dcso179242985a.2
 for <dev@dpdk.org>; Thu, 12 Jun 2025 22:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749791207; x=1750396007; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wij/3bsumy5Ca9ZNcK0j4q018uhuoIoQCwFBx3qVwuU=;
 b=EyB47VAGDlEsm/vgcqOshWLwDeX7Y3NbGA33VSAhaaXiZKWN0oJMcdUwtx6knUtMCC
 t69QQS5ZeANhmAIqxUZykRPaAAQ1kxej9NH92Lyu6ESENbpCnXzKGPVkum+3EFoc1Qzo
 pUawBC9E7p4eiqDT0pavoyck9ZAj7gzmypRY91epLe/ntxoRStw8NfjVKw4oEgRatygK
 v/3dC9LMreNAflsH4fARFVTASQZah1rifN2QdSXYdrLmvWpiy4yKGxg8XvVPh9hMqY/V
 rls20Zo6E5tYZxxpR/IlUla9sFVaF64fK6jRMrDbZjv6BhR8094cf/yyqCnv6gwuI0Xl
 d14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749791207; x=1750396007;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wij/3bsumy5Ca9ZNcK0j4q018uhuoIoQCwFBx3qVwuU=;
 b=GQ2CzoZdZGmmKOSZ/P9FmqIyA06JQ9aYjH4nsLDBJHrSrzPp/Ahowtd4FUzbArXG+L
 3FWbK34Mr8dz5sOiu9mlU+uXo4CjR/otHcFUt4tARUoUG9m9c8665cxYB/eAgoQ8k3vq
 MDjSnmgJ9/Ds+mh0sNBrp36gyR9yNfqcAJ+j2wrWS3TiuPnPAF/ahMA2dfXlezipJnmf
 /OsahmZq96QFn2DZH+eVy77c0Bz0gAD5jnqUtdilVJCS2OtlRboTha4ZNSwMTc4hNNbw
 sTmf3kVWJ0tNNQCSB7/hGUFK6a6A9KSsnZ4pm411vlxgNOioqGFe8E3Wc5oFE0/BkQp5
 OXBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBM4ueOavDJ9BWKFCqhsfSiKueXwMNBDN5E6dKY6Z6avHEg49sZn5kXgOoKyV2apRBFRA=@dpdk.org
X-Gm-Message-State: AOJu0Yw255gJnT4tNwWi5a17FzpQ4kUPccpoVrQ7EXq9ReHkdOYeoR3Q
 5K9Z0GQZA5n+PB2SCIQji/wFiDN7+BMEdA9Fdwa4KDx5VgxsxEeo3NGHXHCOEm91HciaWLYdI6g
 /U9VeFmNCH2Tx3OCpfgjHMSq4QHSp6OtBq93y
X-Gm-Gg: ASbGncvK70KvOE+ITZyuKiIgF/4rrTcGXLr1epeo3QHVLV0tf9AMhVykFMYINnmH1a+
 +H9xvvgAH9+48KjTR7NPqvAWvS2HEUa9B/l9n5/zjKvgJNf9I9TtgDGlEsoknfASHPzwsm9xPBi
 YlcH3bM3dySFoR4sr0+yStB2arkVD7uzBgc22ZfCE6jvzEWoIEPM9S
X-Google-Smtp-Source: AGHT+IFK+qpXO3wmrfbzf4he8C8xmH/C/H8zcswiy3vHUobfX0JkEgL6NjaWPPpMlB3Ebds9xzgbvGotwv+JG9qZm1I=
X-Received: by 2002:a05:622a:5a19:b0:4a6:ef77:3deb with SMTP id
 d75a77b69052e-4a72ff2d007mr30304461cf.40.1749791195911; Thu, 12 Jun 2025
 22:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250604124305.80579-1-pbhagavatula@marvell.com>
 <20250612170923.36114-1-pbhagavatula@marvell.com>
In-Reply-To: <20250612170923.36114-1-pbhagavatula@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Fri, 13 Jun 2025 10:36:09 +0530
X-Gm-Features: AX0GCFuon9TUdjSksN4csBRHPvdtiiCuMFnDAV5GXhrvEKZ3Dmo-iK5EHKBZflc
Message-ID: <CALBAE1Ohg1qOTYf4a77oVJtc2UiaCXqYU5tnN4dMroTw3PUnvQ@mail.gmail.com>
Subject: Re: [PATCH v4] event/cnxk: add event vector adapter support
To: pbhagavatula@marvell.com
Cc: jerinj@marvell.com, Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, 
 Shijith Thotton <sthotton@marvell.com>, dev@dpdk.org
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

On Thu, Jun 12, 2025 at 10:47=E2=80=AFPM <pbhagavatula@marvell.com> wrote:
>
> From: Pavan Nikhilesh <pbhagavatula@marvell.com>
>
> Add event vector adapter support to CN20K event device.
>
> Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
> ---
> v2 Changes:
>  - Add depends on series tag.
>  - Fix compilation.
> v3 Changes:
>  - Rebase.
>  - Fix errors from check-meson.py
> v4 Changes:
>  - Rebase.
>
>  drivers/common/cnxk/roc_sso.c          |   4 +-
>  drivers/common/cnxk/roc_sso.h          |   2 +-
>  drivers/event/cnxk/cn20k_eventdev.c    |   8 +-
>  drivers/event/cnxk/cnxk_vector_adptr.c | 148 +++++++++++++++++++++++++
>  drivers/event/cnxk/cnxk_vector_adptr.h |  22 ++++
>  drivers/event/cnxk/meson.build         |   1 +

Missing updates to
doc/guides/eventdevs/cnxk.rst
doc/guides/eventdevs/features/cnxk.ini

Also update release notes
