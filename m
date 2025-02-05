Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2629C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:35:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F309040289;
	Wed,  5 Feb 2025 17:35:50 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 35D9640261
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:35:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738773348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=611K8MdOtD5A2yLCPoLOSciG0dFLXuitkaMWYQaxgJk=;
 b=CQvUo/Kj8IbUBoHMuJoolewSDxwfx82XhqtqcHHon0QWshnR/ER3qPpBjQxtzRyVE1k2Rd
 5xvtkvFFCSXzcPNCyLukTnxAUetrn1SDGXwT3FuFoOOlklX2ETbVFACjZpy8W4ayHkT0Fw
 lDfDKFIFP4swH9Vk8Buqpub6LKH3C6g=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-_VcX7ncqP3GOCrSPRr52Xg-1; Wed, 05 Feb 2025 11:35:46 -0500
X-MC-Unique: _VcX7ncqP3GOCrSPRr52Xg-1
X-Mimecast-MFC-AGG-ID: _VcX7ncqP3GOCrSPRr52Xg
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-53e1ee761d7so4028144e87.1
 for <dev@dpdk.org>; Wed, 05 Feb 2025 08:35:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738773339; x=1739378139;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=611K8MdOtD5A2yLCPoLOSciG0dFLXuitkaMWYQaxgJk=;
 b=HU6qW546KhOSOp7hfUewYt46VISVEswIpHYBL2v1PXnuYmfFSCMeIJB7cNgYyWRFJY
 qrJ7vbwcDpXtCKJoMYzuUnnv/p61ANvCsh9ANwCEgG++99wzQxrBzOf+wciQijgtavnU
 nPGbWr4ELmcqydMoZNziR3VzKsWTELGQjw6kiFtwiQPdQnR9wPOf7M9c0gK5l5QBY2Gq
 VDADCnVtlKutI6RurtDiEiFPwGQHWZfXXmz1WHM+9nib0MMoTnMaii+PE24WhCnC2P62
 HDTGwjIvWL+nnxgAOLvJEdDp/PHcVyHSiv0vjYVf3NmFTT/BUWGvuxWD/nYYtPZOhQQK
 hmXg==
X-Gm-Message-State: AOJu0YyI4YQRNZT1yiPW0wIJpsyII/WAMd49fADRQkQwq2kavSx4CZZa
 9rEwB9LTx/S3q1fh3Hnr2Gf+jeWenxbjsmJI9ipDVyhQED2c5zH5GmwS1mZMWmJedHBGiD8vSpH
 1UjBblypCpC7AB3TY+LFq2V3ReszcN6UFrUMOWc2R40Bj0ErbZIG3MO9+Bhrt+Fg0LQz9pZZZPm
 iqlQEL8DmdV9Wcl8c=
X-Gm-Gg: ASbGncvQYyHcYaA7tDHbxxzi/DMx8S9NRHSjWJreXLJcZuhGOQExZzcS/NWFxPA2pWF
 3vv+RwnAf7ODHCahAckm4PWZAbyNrDibs5CNiaRC9fRgFC1JGVA4vv+iEMeyz0ffQ
X-Received: by 2002:a05:6512:3b99:b0:543:bb21:4255 with SMTP id
 2adb3069b0e04-54405a76a90mr1488730e87.49.1738773338640; 
 Wed, 05 Feb 2025 08:35:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHittZ9I4c4KeQBaRedGzQdGrzi9OkdQkLtpF14yN5ZogiTLsHBtH1ihqbBiFRmiH6GLGEbyV9EO1ePUfpS6pc=
X-Received: by 2002:a05:6512:3b99:b0:543:bb21:4255 with SMTP id
 2adb3069b0e04-54405a76a90mr1488717e87.49.1738773338243; Wed, 05 Feb 2025
 08:35:38 -0800 (PST)
MIME-Version: 1.0
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738702638-22363-1-git-send-email-andremue@linux.microsoft.com>
 <1738702638-22363-19-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1738702638-22363-19-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 5 Feb 2025 17:35:26 +0100
X-Gm-Features: AWEUYZlPRCB9RdDaEitfIadmB8bqKZ0tkr19fZhuA02ay0CELUy2ACJZr27B9JA
Message-ID: <CAJFAV8zNk++o-P-QtQjkPDkQjb2=C=NfUxfgLVSSk1eSu+x3dg@mail.gmail.com>
Subject: Re: [PATCH v21 18/27] test: remove use of VLAs for Windows built code
 in bitset tests
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, konstantin.ananyev@huawei.com, thomas@monjalon.net, 
 =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SUhuEhns_7pooD7t4xamNlikHnsXa6xruN9KgEKJeNk_1738773339
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

Hello Andr=C3=A9,

On Tue, Feb 4, 2025 at 9:57=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
> @@ -168,10 +169,20 @@ test_flip_size(test_fun test_fun, assign_fun assign=
_fun, flip_fun flip_fun, size
>         rand_bitset(bitset, size);
>
>         for (i =3D 0; i < size; i++) {
> -               RTE_BITSET_DECLARE(reference, size);
> +               RTE_BITSET_DECLARE(reference, RAND_SET_MAX_SIZE);
> +
> +#if defined(RTE_TOOLCHAIN_GCC) && (GCC_VERSION >=3D 110000)
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Warray-bounds"
> +#endif
>
> +               /* gcc is giving false positives here when code is optimi=
zed */

Why not simply alloca(te the right size)?

I tested with my gcc 14 (for which I could reproduce the array bound warnin=
g).
By replacing with uint64_t *reference =3D alloca(RTE_BITSET_SIZE(size)),
gcc seems to be less smart and won't inspect 'reference' and 'bitset'
arrays boundaries.


>                 rte_bitset_copy(reference, bitset, size);
>
> +#if defined(RTE_TOOLCHAIN_GCC) && (GCC_VERSION >=3D 110000)
> +#pragma GCC diagnostic pop
> +#endif
> +
>                 bool value =3D test_fun(bitset, i);
>
>                 flip_fun(bitset, i);

The rest of the series lgtm and the plan is to merge it for rc1.

Just beware that, if you send a new revision, new drivers (net/xsc and
net/zxdh) landed in main.
Both use VLA, so both require cflags +=3D no_wvla_cflag in their meson.buil=
d.


--=20
David Marchand

