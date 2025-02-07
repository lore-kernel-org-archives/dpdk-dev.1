Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231E4C02196
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 10:56:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07EEF42798;
	Fri,  7 Feb 2025 11:56:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 497AF40DFD
 for <dev@dpdk.org>; Fri,  7 Feb 2025 11:56:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738925789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lAONAs6C5wVp22BvLVvdNffb/PqpNgKzijwTZfhCz8s=;
 b=ViJ5pTT4Q/5dW9L9euWg+74a80JyzLcC1V4bxr5MGdgyclrVPOxh35pUSmKo4CW47Yq/f1
 PzOOtr/Y6msjYeSSbLzcVmE5/Zq8Az3dBQcoS0ZR/nafvochXI/oANJvoG79uL9TNLmS3h
 v89a0m8lU4tqlcxNhRss/7k3XufCtJs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-j9nw452EOzmD3FIGycmtVw-1; Fri, 07 Feb 2025 05:56:28 -0500
X-MC-Unique: j9nw452EOzmD3FIGycmtVw-1
X-Mimecast-MFC-AGG-ID: j9nw452EOzmD3FIGycmtVw
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3062b3bcdf6so10361071fa.3
 for <dev@dpdk.org>; Fri, 07 Feb 2025 02:56:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738925785; x=1739530585;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lAONAs6C5wVp22BvLVvdNffb/PqpNgKzijwTZfhCz8s=;
 b=QrLwFwaLxITHYpBbUihkpjYghhYgAaTG3w9Df/qznxSQFjgw3Wg8Pi2UNMASbi8793
 fUSHeXSzc8IYCyOC8ef8BpvrzG+VK0XN751rv2Wtta9BqNz0HbhIIygVDROpXL1UXoDN
 FuaAS3hbXCLXR6AgS/Cf935+pN2Lrn1UWXb1HdH5aDUb2sdjV8OCD/NZlfqP/iLYkxbX
 SlpSXSCoH6C1Ua5EiRpkO+9chBXx5ugsDt4eQf9RkyhWcqxMN9KIlC/N7iyVw3Ga2CKR
 w7UVGayBcjxnaDPwZiNESb/DUlJjxwQCgoQDv1zm48RIHR4BePWk1TAyK8z103ox63qb
 bfow==
X-Gm-Message-State: AOJu0YyNRFwMOQdiF/YrTLC19yXyK7YQfHt7E8JpL7SjrJ/0y/3fMtjJ
 KMnEs3IEIObsygk2JcCHa6b5uTKtTvdK0A3c45s4NnU7As0H0w+JY3A2oEl3x6jFJXOj7v63Naw
 ya57KkogTLZsFU61drHcXRONPXgXWn+m4isZmiZTe4AOhBpc69o3sh3E/2hXsPez+6JrBbVCpH/
 O1RB6oUQajecmSzsY=
X-Gm-Gg: ASbGncv7elMJ1YdqAq4drS12YG76BkcWT0WEh3pKYG3OIGD9toF79PkJpj/lu8g3HfT
 oHzE5p1ENT+6j6ChHlCCBJ40liTF4DpEueAZTFfxJlNjneYMwwoULB0RanDxZ3jfV
X-Received: by 2002:a2e:be1e:0:b0:300:1d45:871f with SMTP id
 38308e7fff4ca-307e57bbd06mr8114371fa.5.1738925785123; 
 Fri, 07 Feb 2025 02:56:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXpMpwdHSb2mgJJ5iryraqokAOSTRQ/UMOPL4IbPjv0JoIEnoyXuHISfDtKWYfwEyKhgfdG/IWAYnf9aPgixY=
X-Received: by 2002:a2e:be1e:0:b0:300:1d45:871f with SMTP id
 38308e7fff4ca-307e57bbd06mr8114301fa.5.1738925784702; Fri, 07 Feb 2025
 02:56:24 -0800 (PST)
MIME-Version: 1.0
References: <1733342995-3722-2-git-send-email-andremue@linux.microsoft.com>
 <1738771937-18083-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1738771937-18083-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 7 Feb 2025 11:56:13 +0100
X-Gm-Features: AWEUYZkfBn27iOtxVEABW8M_0GoJ6sAfaWISZIsuQ_fFLwz3hxWdZ4uRHIhQFAE
Message-ID: <CAJFAV8zamNXCdmyO2YNGnF_2nE0vHCPgV_CtRy5W7fNshj49zg@mail.gmail.com>
Subject: Re: [PATCH v5] eal: define __SIZEOF_LONG__ when using MSVC
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kJvW2q0bybBdFnYlp_cyHrt0AE5KlQzjmCUivHcEm6A_1738925785
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

On Wed, Feb 5, 2025 at 5:12=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> Macro __SIZEOF_LONG__ is not standardized and MSVC does not define it.
> Therefore the errors below are seen with MSVC:
>
> ../lib/mldev/mldev_utils_scalar.c(465): error C2065:
>     '__SIZEOF_LONG__': undeclared identifier
> ../lib/mldev/mldev_utils_scalar.c(478): error C2051:
>     case expression not constant
>
> ../lib/mldev/mldev_utils_scalar_bfloat16.c(33): error C2065:
>     '__SIZEOF_LONG__': undeclared identifier
> ../lib/mldev/mldev_utils_scalar_bfloat16.c(49): error C2051:
>     case expression not constant
>
> The fix is to define __SIZEOF_LONG__ in a common header when
> MSVC is used.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  lib/eal/include/rte_compat.h | 5 +++++
>  1 file changed, 5 insertions(+)

rte_compat only deals with symbol versioning.
I think a better location would be windows/rte_os.h.



--=20
David Marchand

