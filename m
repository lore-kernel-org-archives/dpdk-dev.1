Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896C9C02198
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 15:35:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA1A0402E8;
	Tue, 18 Feb 2025 16:35:50 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 459E54014F
 for <dev@dpdk.org>; Tue, 18 Feb 2025 16:35:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739892948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q+HNz9zu4+jaFr43NO1U6+CzHA/afYHRPSA77rd4eW8=;
 b=ht9D5VD5C1/VsTYW3msRt3rvqhtS8eFA6AxHQw9etiSY0NynLzzPGWjc4vqMNUuhdpZUnh
 HZKsZbE+OXnmdDPvZw1fZTb6rDXFbWTSb0oWF9+SRH10qSRSQ7nrK//pF1XDgaoHsA1XpK
 hRNRMY4cJwTDkVQrh6tBBE+nHWwR4xQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-tHjpd5VeNdunU1r5usja0Q-1; Tue, 18 Feb 2025 10:35:47 -0500
X-MC-Unique: tHjpd5VeNdunU1r5usja0Q-1
X-Mimecast-MFC-AGG-ID: tHjpd5VeNdunU1r5usja0Q_1739892946
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-30a2793bfceso11931011fa.1
 for <dev@dpdk.org>; Tue, 18 Feb 2025 07:35:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739892946; x=1740497746;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q+HNz9zu4+jaFr43NO1U6+CzHA/afYHRPSA77rd4eW8=;
 b=YFuJKdaatNmkG8Wq4IZjlXUao3JivCQDDXIgVQRRFbAPbNzp15Sy+JJeS1Q3E9WdFy
 4Fp1jyikoZSbqRRDGvN530M+oCxn66wM6n7G9+QNbY604ZccJkdNxqrCiUKoRxsdXZ6+
 z/A6eH8wUNKiP4yoqbYgrY1FV+REvOOn66QjV/uu84oe+BnLfb80JX5i/2l/B70ONr4e
 nz/c+CZBJNxI2TbTM+uDhIGOPtAJTlrPnn/nzl9TTXJqTU+mVtXPreU0i4SX5TiC2sEh
 cp/0d8/MwQq9VxsnETRgV36waHIvD+HlMS862GVYr4vcFz9b6grANN42wvYbTtlGEZUN
 Me8w==
X-Gm-Message-State: AOJu0YwUknOoGuh+RT5rCFee7SNuBxcsS1AIVfVbtjNMoTuP+wWr1Fwu
 2+0kLSAv6Npbb0X/2SfMnkclopttaKUoIC+jfRqXFMi8N5GJah1zNMQtGx07Pk4rC7BrNm6WUcq
 FD5aPX/PeL/GThccTsaCTNL/F77NFu9K3NXs4oP4EWrpCQfhcVIlUaKhbcMOh2a3Za4DRdHiLqL
 k9fBLZSgzDwzF1nxc=
X-Gm-Gg: ASbGncsEYTj0Tzr4eRi3ppTmINUtBq3HQYRpLdQ9XMr0+TtGL1TiWibAJ1TY6y6artl
 TnrVsB7lZPjb5jMx6QQFam0nRaQRxVXna8VeRuWzbjjzsfBuu8qZe18c9ZazFRUHg
X-Received: by 2002:a2e:988e:0:b0:30a:375a:fd2e with SMTP id
 38308e7fff4ca-30a44119cccmr1078671fa.9.1739892946092; 
 Tue, 18 Feb 2025 07:35:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG00ogn6ldgqRxBL7DF2IBf2KSpixZ6iixyHKRWizDW9bvALq670tNyWxGB2V6P9X5eBbfRbwRbVmk4OSif7MQ=
X-Received: by 2002:a2e:988e:0:b0:30a:375a:fd2e with SMTP id
 38308e7fff4ca-30a44119cccmr1078581fa.9.1739892945666; Tue, 18 Feb 2025
 07:35:45 -0800 (PST)
MIME-Version: 1.0
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 18 Feb 2025 16:35:33 +0100
X-Gm-Features: AWEUYZkzU9VBLBB1Avlwb7l1ZMkwh9IYWuej-Ejtd06naNM9g0Dbva__TuGpN4U
Message-ID: <CAJFAV8xqYeJAffXe+1wc90Tm_A5Gqc-XkeVcPzxtBm3=ffaRpg@mail.gmail.com>
Subject: Re: [PATCH 00/10] enable "app" to be compiled with MSVC
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EMXhpecumlLbCK1MxYaU5my9CdwzORQvp9G3Na2YsFE_1739892946
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

On Tue, Feb 11, 2025 at 11:02=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> This series fixes many issues that prevent the "app" directory
> from being compiled with MSVC.
>
> Andre Muezerie (10):
>   eal: add workaround for __builtin_constant_p
>   test_alarm: avoid warning about different qualifiers
>   test-pmd: fix printf format string mismatch
>   test-pmd: do explicit 64-bit shift to avoid implicit conversion
>   test-pmd: avoid undefined behavior
>   test-pmd: avoid non-constant initializer
>   test-pmd: don't return value from void function
>   test-pmd: declare lcore_count atomic when using C11 memory model
>   test: add workaround for __builtin_constant_p in test_memcpy_perf
>   app: enable app directory to be compiled with MSVC
>
>  app/meson.build                     |   4 --
>  app/test-pmd/cmdline.c              |  19 +++--
>  app/test-pmd/cmdline_flow.c         |  22 +++---
>  app/test-pmd/csumonly.c             |  12 ++--
>  app/test-pmd/meson.build            |   4 +-
>  app/test-pmd/testpmd.c              |   2 +-
>  app/test-pmd/util.c                 |   2 +-
>  app/test/test_alarm.c               |  12 ++--
>  app/test/test_memcpy_perf.c         | 106 ++++++++++++++--------------
>  app/test/test_ring_perf.c           |   6 +-
>  lib/eal/include/generic/rte_pause.h |   2 +-
>  lib/eal/include/rte_common.h        |  12 ++++
>  12 files changed, 114 insertions(+), 89 deletions(-)

The last patch of the series was not received on the ml.
This prevents CI from testing it.
Please resubmit the whole series.


Thanks.

--=20
David Marchand

