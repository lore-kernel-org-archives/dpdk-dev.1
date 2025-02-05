Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D18EC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 17:03:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E71440270;
	Wed,  5 Feb 2025 18:03:35 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id CFCB940261
 for <dev@dpdk.org>; Wed,  5 Feb 2025 18:03:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738775013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yWmAT99iXTlTZDyAKdmPck/+yBIr15IFfWrlKuFkuPM=;
 b=YwIq/9menqJAyVup5Rq9cQf3V5WabM+nf1hldO3N3J4TwdYamnFQqPguVQ+GA4o4Sqtl6r
 ZJVZbqS8MnB92kOqYkFYBaVmki2iCZKtn1xwgQA4OzsxMyJ7wnezA3hBizBFZ+ZPVMCWxK
 TnUdv+Bj2K26R/LJhufJPRo88gA9f8w=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-RkR3xJa_PlqLu_thnbsewA-1; Wed, 05 Feb 2025 12:03:30 -0500
X-MC-Unique: RkR3xJa_PlqLu_thnbsewA-1
X-Mimecast-MFC-AGG-ID: RkR3xJa_PlqLu_thnbsewA
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5401af85368so3383206e87.2
 for <dev@dpdk.org>; Wed, 05 Feb 2025 09:03:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738775008; x=1739379808;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yWmAT99iXTlTZDyAKdmPck/+yBIr15IFfWrlKuFkuPM=;
 b=OPBECpEIQ7lPwYT/DCDczhG4jOEnVW0y1Wzu385Be51AjQGq3UkaAVi2XJRb3hIut8
 xT8PXxfF+KEOCGFyVK8d4b5X1I8++Zp6l3IYO1oC77iLTOziiCkDNO71263J+XATK+1Z
 Ji85FSUlg1jrVVjly3X5aMcpWL2VjFVBdHgD9sjpccwGgjxlHJFcTMkEI8DYeiXHrGp2
 VDLNMBZluqcdVJ+b3jxpesm8YclN/CfwCgQQafYQWUzmr/p6MwtIUItFXXAUTJS7antF
 9iXV1ZnOo2AHAmQkxwz056NsfWDrcnFdtVVFfFgm4VIwWSlvPGSPeWsr3I8Be0iTBlL5
 f0yA==
X-Gm-Message-State: AOJu0YwLN3GC4Z840prKPJ1nhLA41rb+diyHTyxAUv+WV+6QtFQuZD9A
 swuzzy7vq6HgiVvsKqeKH2uuhtMGbmu/ggIvFI5Cr2YuHvUyK0kEG6XXZnyxPHst+n6raaX6X+D
 7kidg616VAoWKdPNFrEBmtSYxKDaO2QO2R/pvFcObF6sMN3SQ8VCt1XPYlJXKKdVVHCNckHzoFR
 njF4+bs+OEJvmtNSU=
X-Gm-Gg: ASbGncsynpidUKET1Y/Q7gvqMmgQaTEKGLji+EH2n3D+JM0FSmjUmyNL2nuXyNAULoo
 2cWw7gvzNXcL+aCPA9KWQKAKcMsfamz6oqY1ZRgxEicvoRp00ep5rtS/5jZqzo4mB
X-Received: by 2002:ac2:44a4:0:b0:544:db4:3028 with SMTP id
 2adb3069b0e04-5440db431b8mr79896e87.19.1738775008285; 
 Wed, 05 Feb 2025 09:03:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwgpOzOXRDdW4Uh1xaB2iN85xKRIQ3W/OIww7YgsXGUFyWIQqCgYs6XCwggqgeRUY+tUNBPZhTiAgrS1rFOjg=
X-Received: by 2002:ac2:44a4:0:b0:544:db4:3028 with SMTP id
 2adb3069b0e04-5440db431b8mr79854e87.19.1738775007929; Wed, 05 Feb 2025
 09:03:27 -0800 (PST)
MIME-Version: 1.0
References: <20250205161823.2849595-1-bruce.richardson@intel.com>
In-Reply-To: <20250205161823.2849595-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 5 Feb 2025 18:03:16 +0100
X-Gm-Features: AWEUYZmvDhi7Juw0K8NCS6QxAnBbAico4Jsklak_S4Gjx5JR_p65m99Ie1pRg_U
Message-ID: <CAJFAV8w1ROF3rGGyrpDWokpxZT+tiG1vWXbfwFemqSYzt3vPBw@mail.gmail.com>
Subject: Re: [PATCH] build: remove support for icc compiler
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, anatoly.burakov@intel.com, vladimir.medvedkin@intel.com, 
 ian.stokes@intel.com, john.mcnamara@intel.com, 
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PzaiNzK9Olqe09QKvOIvlPvwa3rYwVXHcQlrsFhWQYA_1738775008
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

On Wed, Feb 5, 2025 at 5:19=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> The Intel-produced compiler "icc" has been replaced by the newer
> clang-based "icx" compiler. DPDK compilation has also not been tested
> recently with the icc compiler, so let's remove doc and code references
> to icc, and any special macros or build support that was added for it.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

I noticed remaining references, from which some can be cleaned up too:

app/test-pmd/testpmd.h: * Work-around of a compilation error with ICC
on invocations of the

lib/eal/common/eal_common_dynmem.c:                     /* to prevent
icc errors */
lib/eal/x86/include/rte_vect.h:#if defined(__ICC) || defined(_WIN64)

buildtools/check-symbols.sh:# Filter out symbols suffixed with a . for icc
buildtools/check-symbols.sh:# Filter out symbols suffixed with a . for icc

And please add a release note update.

Thanks.

--=20
David Marchand

