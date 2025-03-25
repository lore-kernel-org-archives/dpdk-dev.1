Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62998C35FFC
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Mar 2025 07:46:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33B8740E17;
	Tue, 25 Mar 2025 08:46:55 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4516D40B9C
 for <dev@dpdk.org>; Tue, 25 Mar 2025 08:46:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742888813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TpE0zQVtLtgBdnR7yfnuoHtGb0pcVLKajBq9HR4qh0c=;
 b=RorHzXSUNuDka2InHDNvGp5lyHToxe6Ga/Bcy+9ioCcJeJqEtaQ0JdeLCUnx8XkKT/z9wg
 vkZ/FzjzRx5w5dHq5tNgFuT/lFWDHUDQRwlHf2bQ4yaxnuOXKjAk2fx7o6oVu579AaqUyY
 l9IusoENHKUFCY6wV+0r0sV8H+nHN2g=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-eYf4cSvTNFOfrRD5sldPag-1; Tue, 25 Mar 2025 03:46:51 -0400
X-MC-Unique: eYf4cSvTNFOfrRD5sldPag-1
X-Mimecast-MFC-AGG-ID: eYf4cSvTNFOfrRD5sldPag_1742888810
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-549b3bf4664so2113085e87.1
 for <dev@dpdk.org>; Tue, 25 Mar 2025 00:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742888810; x=1743493610;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TpE0zQVtLtgBdnR7yfnuoHtGb0pcVLKajBq9HR4qh0c=;
 b=qRdoll52LBfDlZ1gDg7IlW/1Iw+TKlyYm1AFRXkinYCFHPgzuQxF12eDnNiIAvR+yC
 iSkcwIeD8YPvlrxeEN6aTOsvJlM/5ZSJS8xu/8gZZKlNY6RpIa9j1WjQly1cesCbJ0tN
 A2py0LSZDxQo55Zj6Mt33XfuxGqSGAzq840ncbGXL9hLND+BXwHHCSI3XqSxud77rywU
 mXSriDA3ueVw+kfECFNKpT85Wvev7IJMnYy6kCQ+QMmLushX1roA9uY0XoF3QPsI9LnO
 GDomX6/OUOULOp8z4BPccR2A0i4ad4w2sz8pRva9xmMzRI/PSrdDGZZKTIpIJWVkmN/L
 X/+w==
X-Gm-Message-State: AOJu0YzYTXAkOE+9cZh6skq7dhix+6aNFxXkKN1uDrrGUqSbSis1vaih
 UBB4dlR5JPOv1fLpwZ5ty9d5Mm8exABZxncO7E9OyiRrwq0W0F1kVv6FFr1uri5Tzg3RElyg7bW
 s7d20FnEWEb4bhhpfZhVII9dB6mjyMbKuorkBafzc6EGILKRsmFTT53iVvnVAvEcKtwwcjWb4SO
 dtt18gSJNacDWkBAs=
X-Gm-Gg: ASbGncsNn7DjHlARvDi1o5v6mgMzXPPC4y0VoS7kRGLD+2nnohA80UDY/0Mu/wzD9iS
 lpEuSf2IHolCzOU2MAKLarMwiWYBjbML3GWttVRqqvFD2D6tzfAPfoalyZfurwP7NLI8q6/TBqG
 s=
X-Received: by 2002:a05:6512:ea7:b0:549:59d2:9ac0 with SMTP id
 2adb3069b0e04-54ad6501e3cmr5436416e87.47.1742888810254; 
 Tue, 25 Mar 2025 00:46:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1klN9O6dng3yOzYbg0ROl389c19rjvxjEVn/XlSvRGzbtwxBkFBqW8i851gACD4IUPlz41qCTwmCJ9QMIMlA=
X-Received: by 2002:a05:6512:ea7:b0:549:59d2:9ac0 with SMTP id
 2adb3069b0e04-54ad6501e3cmr5436407e87.47.1742888809793; Tue, 25 Mar 2025
 00:46:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250314172339.12777-1-bruce.richardson@intel.com>
 <20250319172942.2992053-1-bruce.richardson@intel.com>
 <Z9sIGDafadtgB9gr@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <Z9sIGDafadtgB9gr@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 25 Mar 2025 08:46:35 +0100
X-Gm-Features: AQ5f1JpMaLyWppag6NCYsQ4ZcHXF1bcKUfRpbJRxef4YfSnO0HyvtY8cwIcABGs
Message-ID: <CAJFAV8ynP9_b7DV=xR_s_b4u5Vkzh9G8ZGHEe8wQ6htGhqvwsQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] remove component-specific logic for AVX builds
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oayDzUezW4bFdYT680Vg8C4GujwWX2UVYTtUskSw4kM_1742888810
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

Hello Bruce,

On Wed, Mar 19, 2025 at 7:09=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Wed, Mar 19, 2025 at 05:29:30PM +0000, Bruce Richardson wrote:
> > A number of libs and drivers had special optimized AVX2 and AVX512 code
> > paths for performance reasons, and these tended to have copy-pasted
> > logic to build those files. Centralise that logic in the main
> > drivers/ and lib/ meson.build files to avoid duplication.
> >
> > v4: rebase on latest main branch
> >     minor fixes following feedback
> >     limit use of -march=3Dskylake-avx512 to when we don't already have =
a
> >       -march flag supporting AVX512.
> > v3: add patch for event/dlb2 AVX512 handling.
> >     add common code for libraries as well as drivers.
> > v2: add patch 4 to remove use of unnecessary CC_AVX2_SUPPORT flag
> >
> A related follow-up to this patchset. Checking with "godbolt.org", it
> appears that both clang 3.6[1] and gcc 5[2] (the minimum called out compi=
ler
> versions in our docs[1]) support the set of AVX-512 compiler flags we use=
.
> Therefore, it seems we can simplify our code further by removing the
> "cc_has_avx512" variable.

What about https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D90028 ?

You'll need to send a new revision for this series in any case, since
patch 9 broke the crc stuff in the net library.
https://inbox.dpdk.org/dev/CAJFAV8w9wYPN+30Hv=3DbatMvP=3D0M4momKZgmNDFixXbd=
-9u8t6w@mail.gmail.com/


--=20
David Marchand

