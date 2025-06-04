Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5941C5B552
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 10:08:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AA9B4042E;
	Wed,  4 Jun 2025 12:08:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 052C44029D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 12:08:18 +0200 (CEST)
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-rebcNOCMOlSegsTT-9qf0Q-1; Wed, 04 Jun 2025 06:08:17 -0400
X-MC-Unique: rebcNOCMOlSegsTT-9qf0Q-1
X-Mimecast-MFC-AGG-ID: rebcNOCMOlSegsTT-9qf0Q_1749031695
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-55220256289so4188852e87.1
 for <dev@dpdk.org>; Wed, 04 Jun 2025 03:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749031695; x=1749636495;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LwQR87NMMysRIn8bt0RTphkXuNoxszaYkPyXzOpIXos=;
 b=jN0MzEou2/s79NxUbg9Uw50ulQLAMUK8DAiJxRhBXIX/Ao0B7hbW697ALi6bLn4vLB
 zwST1O1qC9Cf6MtB+W/1EcRDfRdYugA5up1F9Fm9wvSc2J60fS3CUagSmj4sthgvgRpc
 2jH2D/e3+PAvJgUKpQLheSIkyCbM03kC6NcDLi3/2sZMXRrX8w6uoVYgzgqM3s9KU5rv
 kkSdbVxzTBqXzaFyvTnF9jOxMfXTHtCSSb1z984srhhoWP7CJuraGZ77SOjdrXmPJqYd
 MkioTcx9yFrg4f69aoBJdE3ZOGu8dYPlbpYz9Jr2VoUmzsErPc7sa1+JPhBuU1Ggzs9N
 emkA==
X-Gm-Message-State: AOJu0YwLFbPsA/v/wDVzyDHmlYZa7SHrjySv2otXrvmoe5L57IkFRSLY
 lLD5rCKQtJ6rGu9wJtIJd9as2FX9nKbnJB9czDe0U3EmHYUFdMgCBOgugJSzdgxGbD/LMrvYpup
 x5iFKBvc1K1nih/sPJAJF/lqeFMiKprg01egzryZ4bVLz8+/SxKm/9AmLntdj/4lTqK6kptWWos
 0PKMypSlUWKErCmcktJ+s=
X-Gm-Gg: ASbGncv9HeCbU98I0+IVUyTzAtJ+vIZaZ8sIM8hPOKtqp5PpQHqVq5qQpP7OK80NPoy
 cqOHjkV0bPUKbi/s+jnD3+BopjMAng0Emgp6aTKn7F8+1zIYRPX9aWJwlKQXlyn3RNBLP1Nk=
X-Received: by 2002:a05:6512:3092:b0:553:2f8c:e624 with SMTP id
 2adb3069b0e04-55356beff09mr649868e87.15.1749031694987; 
 Wed, 04 Jun 2025 03:08:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExRtsUQRLDrCUF7qNuBgNyplBU2aPsDbydviz8bfnqpKflLYs7xvf927r6WCYQ+dT7eGb/7z+lvFlRV13HwVc=
X-Received: by 2002:a05:6512:3092:b0:553:2f8c:e624 with SMTP id
 2adb3069b0e04-55356beff09mr649859e87.15.1749031694542; Wed, 04 Jun 2025
 03:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <1735857169-19131-1-git-send-email-andremue@linux.microsoft.com>
 <1741962820-27123-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1741962820-27123-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 4 Jun 2025 12:08:02 +0200
X-Gm-Features: AX0GCFs_twX8RwBfWsaGtPtaTLLjzWU8Yz5xidmsbQQgYHW5d2Pf81ihLvUYiOg
Message-ID: <CAJFAV8z3zqxm_VLXkztjThS3XhuKrJ0kf_yjeSgx+VjXaoyh7w@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] add portable version of __builtin_add_overflow
To: Andre Muezerie <andremue@linux.microsoft.com>,
 Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, mb@smartsharesystems.com, 
 Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richards@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l3sSkiHkOWYdYiDb1M-WgR6BnwipGnoZX1WHLK0fb_8_1749031695
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

On Fri, Mar 14, 2025 at 3:34=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> __builtin_add_overflow is gcc specific. There's a need for a portable
> version that can also be used with other compilers.
>
> v5:
> - Combined patches 1 with 5 and 2 with 3.
>
> v4:
> - Added define in ice_osdep.h to use portable version of
>   __builtin_add_overflow when using MSVC.
> - Undid all changes from drivers/net/intel/ice/base/ice_nvm.c.
>
> v3:
> - Rebase on top of latest main.
>
> Andre Muezerie (3):
>   eal: add portable version of __builtin_add_overflow
>   net/intel: use portable version of __builtin_add_overflow
>   app/test: add tests for portable version of __builtin_add_overflow
>
>  MAINTAINERS                            |   1 +
>  app/test/meson.build                   |   1 +
>  app/test/test_math.c                   | 170 +++++++++++++++++++++++++
>  doc/api/doxy-api-index.md              |   1 +
>  drivers/net/intel/ice/base/ice_osdep.h |   5 +
>  lib/eal/include/meson.build            |   1 +
>  lib/eal/include/rte_math.h             |  46 +++++++
>  7 files changed, 225 insertions(+)
>  create mode 100644 app/test/test_math.c
>  create mode 100644 lib/eal/include/rte_math.h

I am not a fan of adding such public API, an internal API would be enough.
Do you plan to add more helpers for math operations?

For the current helper, the only user is a driver (base code).
Can't we just wrap a __builtin_add_overflow (under #ifdef msvc) in the
osdep.h header?


--=20
David Marchand

