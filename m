Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFE8C28B20
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 07:02:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7289402B5;
	Wed,  2 Apr 2025 09:02:15 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8B3ED4029A
 for <dev@dpdk.org>; Wed,  2 Apr 2025 09:02:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743577334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i2VQLjo+5P7l4JiFzB7MOYhPSisLDHegtR3R0tCj6KE=;
 b=T/uZufwOnF07P0Eakuobrvne5GU7NZvPqOveNJgvLj1jZh1syv2Y2prRq0QYPAQGY0vOMh
 fTRKwz77CCPT/LNbVzaGUpbln3mOEuTWJ6RUmrLr4J9BiBAwD+sNSk9+2qFXCpnRQhIQt6
 1+nrUq00KKZx5qNM53xuUZ2zdpkGSXA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-GXzXP4k7Muyy9SlCl-oMjg-1; Wed, 02 Apr 2025 03:02:12 -0400
X-MC-Unique: GXzXP4k7Muyy9SlCl-oMjg-1
X-Mimecast-MFC-AGG-ID: GXzXP4k7Muyy9SlCl-oMjg_1743577331
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-30c2d4271c7so31743321fa.0
 for <dev@dpdk.org>; Wed, 02 Apr 2025 00:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743577331; x=1744182131;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i2VQLjo+5P7l4JiFzB7MOYhPSisLDHegtR3R0tCj6KE=;
 b=EoCRFnEwp9W0qRL+GVnrdqMkVFQ/Sx7mZSDt6i25ov7hAOpr2MkKD+qoz9lNmfG+bi
 x4UzWY4mkGjmuGsKDvrjnbLb1lV4nMSI9Yy5WmJWAWvo81PtNk3Z0F/N92l1/n89e6b/
 qmyiUmJ9QZORnTeeQb1A5lnRUoDEaboI1jjcRkc8STrsCw4KfdSrMVpIIU2WEesmhOye
 lnhU4YfGfsyLCJcevGbfWGwypyDrXFAJEyj+MyaiRUIC40c+qQkwYlMoUyDyxc9iODZ2
 zs/UzXdTu88hlq3wnkwDsehPPg9DnUgG0AhpKr7akLKNCxiaLHGN4l9lo32O5gT2AjEs
 k9Kw==
X-Gm-Message-State: AOJu0YymJFfmx6WMm+M88qyu/DD+YLRirOtCVlBw0l2c8j7ptp1HQ9OQ
 EfV+yrwQv7JjZ0A/JVHyIqunGBr/orHuibamFqP2bQkKRoX9iyEadGXMa5i8vEGPdaN9j76JYsF
 UqFC9MB5peKn9D+tGXVyztJHTTuWC4rCoR4xnp4TwotdEQ8B8UMCzz+8ixzZUCApSzYf9wKtQDC
 U/F7/WfjBwKXqqW8k=
X-Gm-Gg: ASbGncsnE7PU21fPnf7G6PXUPTw+3SevHTnecTtCUXKDWd7dsOAKkdijeqO6IlJHROP
 +J4per8WjFc8gsYMinsLvPZ3qMz8WHsgLjjiqaWMqOR6NdqAfrm9M5sMw7zxMKw0okNPfxjCGKY
 4=
X-Received: by 2002:a05:651c:2107:b0:309:23ea:5919 with SMTP id
 38308e7fff4ca-30de0300b8amr50677211fa.31.1743577331329; 
 Wed, 02 Apr 2025 00:02:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEMAjs6pzx3U7nKIPNr8u1MW0tkN5oW33sD2iCpFJHTmudyooVbo03A/8m6Sl0J/6kh93jUXzuB1E1Sc/ux2M=
X-Received: by 2002:a05:651c:2107:b0:309:23ea:5919 with SMTP id
 38308e7fff4ca-30de0300b8amr50677131fa.31.1743577331007; Wed, 02 Apr 2025
 00:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250328105250.3082414-1-david.marchand@redhat.com>
 <20250328105250.3082414-5-david.marchand@redhat.com>
 <5363995.88bMQJbFj6@thomas>
In-Reply-To: <5363995.88bMQJbFj6@thomas>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 2 Apr 2025 09:01:57 +0200
X-Gm-Features: AQ5f1JrZX0muU8QHUONN-UYi_y2iGdW7UJFxnPFCVTJoj8KBmdQZ67G5jk99kQU
Message-ID: <CAJFAV8yy4mjA0a4v8-Dx4Wj=2wb18zU2x+tdm8giJ31yNSXiEw@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] build: generate symbol maps
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, bruce.richardson@intel.com, andremue@linux.microsoft.com, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: h7kZJAQcD6Lzf5OTzuew8QZH6HeIXXinX-gTYETxixg_1743577331
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

On Tue, Apr 1, 2025 at 10:34=E2=80=AFPM Thomas Monjalon <thomas@monjalon.ne=
t> wrote:
>
> 28/03/2025 11:52, David Marchand:
> > +scriptname, link_mode, abi_version_file, output, *files =3D sys.argv
>
> You should add a comment to show the usage of the script.
>
> [...]
> > +if link_mode =3D=3D 'mslinker':
> > +    with open(output, "w") as outfile:
> > +        print(f"EXPORTS", file=3Doutfile)
> > +        for key in (abi, 'EXPERIMENTAL', 'INTERNAL'):
> > +            if key not in symbols:
> > +                continue
> > +            for symbol in sorted(symbols[key].keys()):
> > +                print(f"\t{symbol}", file=3Doutfile)
> > +            del symbols[key]
> > +else:
>
> Maybe add a comment after the else to make explicit it is GNU format.
>
> [...]
> > +for file in sys.argv[1:]:
>
> This script requires a comment with the usage as well
> to make clear what we expect as arguments.

Ack.

>
> > +    with open(file, encoding=3D"utf-8") as f:
> > +        for ln in f.readlines():
> > +            if file_header_regexp.match(ln):
> > +                if file_header_regexp.match(ln).group(2) =3D=3D "lib":
> > +                    lib =3D '/'.join(file_header_regexp.match(ln).grou=
p(2, 3))
> > +                elif file_header_regexp.match(ln).group(3) =3D=3D "int=
el":
> > +                    lib =3D '/'.join(file_header_regexp.match(ln).grou=
p(2, 3, 4))
> > +                else:
> > +                    lib =3D '/'.join(file_header_regexp.match(ln).grou=
p(2, 3))
>
> [...]
> > +#define RTE_EXPORT_EXPERIMENTAL_SYMBOL(a, ver)
> > +#define RTE_EXPORT_INTERNAL_SYMBOL(a)
> > +#define RTE_EXPORT_SYMBOL(a)
>
> I would prefer an explicit variable name instead of "a".

Ack.

Thanks for the review.


--=20
David Marchand

