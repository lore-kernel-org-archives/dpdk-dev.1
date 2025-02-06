Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E684C02192
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 01:18:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 142DD40666;
	Thu,  6 Feb 2025 02:18:09 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 95EE84042C
 for <dev@dpdk.org>; Thu,  6 Feb 2025 02:18:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738804687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ar8DM+uiiB906R0mGllqTOgxVvZWhZ3crVXLk3nx0X0=;
 b=LA+RZ7yG7ZXjobQ75al3jKuKD243YoHJYq1khbQVDlvA7d4jfxYNmTk3u6Cp/Z2R+3z2gT
 ToczOI8GZUZG3FDUJ1kPNsiEarJIaZF1Ja2j0kArLvBn3O//wqUME2XZfhIDYgMOEpOm5v
 6CCT2JYsS3T023psD/3w6WGxkNJy+Zo=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-xj8-n42yM0OxS6YJXAiw3w-1; Wed, 05 Feb 2025 20:18:05 -0500
X-MC-Unique: xj8-n42yM0OxS6YJXAiw3w-1
X-Mimecast-MFC-AGG-ID: xj8-n42yM0OxS6YJXAiw3w
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-6f28f5f2c5eso5685827b3.0
 for <dev@dpdk.org>; Wed, 05 Feb 2025 17:18:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738804685; x=1739409485;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ar8DM+uiiB906R0mGllqTOgxVvZWhZ3crVXLk3nx0X0=;
 b=aTiSo9pRpw/89YH+wqzyRyiqL5Ae8vB4Sn4surM4touEtyHCfbtfjhCdnKjZPED/95
 nS/Sld3KalEhLpCOBDFgZvxL9LWiOi3pFvXR/kxGmuplhPkyC6i8Q4Wu3H/kr+tQ59nr
 1qpKm4aRfP9SOGN0UAEDvSkfGYz1CTQa2oqFycLYq7+W2d0QyIYl6tCAzpwPLYDRESAC
 P4NnlDYQb1w9gDgISUqcICgovbTi/3hl7CoHmWQw1w/Q29wbX25bxuzmjYp5qVCYCd4r
 GTa3dgYFZ+Dc7A3l/hToOOA4vBBtYpKnIXm6FXlfpuY00xhQgARupJqNVcbby+goIvOH
 zhhQ==
X-Gm-Message-State: AOJu0Yyc5FvS2zZO7wDI6Ei4lB7x7PI1J9RWoSAMVcuvP2vFn5DY4UTe
 mFhyD6JGyL+tGNURd1SnshnKCtB8nOCzsvQFG6+FD1qpGotGWvbjFFLZppM7ogflOtvjM9E2rE9
 RBbE1/xWe0aQ8s3fkSQwRq1kZ7dvaB8D9nI92ABVrzGqmA15SblBecrr+HOnDwawuH6oeWwKeku
 hPq+W5GraUb9xWZ9k=
X-Gm-Gg: ASbGncsTRyOS/dfjlJBKyEWigTQUWSAQ5RKpxATqU8CB/4DsQ3ZvqTsgTurphrugCyD
 H/Mvn/uLofYFZDP4yKTOMAPUNayaBedNbQYmOziFmeVkXM4Jl7Sn45JR+hX0oRpEUUJIEB8kDfQ
 zFXCjrMWM1sPegeing9A6D
X-Received: by 2002:a05:690c:3607:b0:6f9:50aa:8605 with SMTP id
 00721157ae682-6f989fab670mr41071827b3.34.1738804684985; 
 Wed, 05 Feb 2025 17:18:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeb0wDEjv3kScCxLfJVdSdPS7mSVv2pfT2ifvrtEH607wcuSI0+o+R1pcP6KW8sRg3HjreUr/ugwXskfIwo+s=
X-Received: by 2002:a05:690c:3607:b0:6f9:50aa:8605 with SMTP id
 00721157ae682-6f989fab670mr41071687b3.34.1738804684767; Wed, 05 Feb 2025
 17:18:04 -0800 (PST)
MIME-Version: 1.0
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250201100300.2194018-1-ariel.otilibili@6wind.com>
 <20250201100300.2194018-3-ariel.otilibili@6wind.com>
 <CAFdtZiu9t6tzw=cZgN+B22DiC7eYbMx7hxmBzVbx9Mfz3XwMVQ@mail.gmail.com>
In-Reply-To: <CAFdtZiu9t6tzw=cZgN+B22DiC7eYbMx7hxmBzVbx9Mfz3XwMVQ@mail.gmail.com>
From: Maryam Tahhan <mtahhan@redhat.com>
Date: Thu, 6 Feb 2025 01:17:52 +0000
X-Gm-Features: AWEUYZlnucmOEJB-HU3qNYpD-qBP6S6bsG7P_S0Px97ywoxGJXLnF-_DCmTuPU4
Message-ID: <CAFdtZitU9qkVqPravc=T3x7Or8U1MA9mEQ9nESrTSx6tQMEoVA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] net/af_xdp: Refactor af_xdp_tx_zc
To: Ariel Otilibili <ariel.otilibili@6wind.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 Thomas Monjalon <thomas@monjalon.net>, 
 David Marchand <david.marchand@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>, 
 Ciara Loftus <ciara.loftus@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8xyLaBEKw06OtiF_mpg8wZR90l6i-ucFhpyndgsFnYg_1738804685
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000091eb19062d6f0378"
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

--00000000000091eb19062d6f0378
Content-Type: text/plain; charset="UTF-8"

>
> Sorry, just fixing my comment here:

>
> So I think i spotted one issue, you might need override desc->len after
> the call to the reserve_and_fill function so that it's *not taken* from
> local_mbuf here.
>

--00000000000091eb19062d6f0378
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote gmail_quote_container"><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex"><div dir=3D"auto"><div class=3D"gmail_quote" di=
r=3D"auto"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex"></blockquote></div></div></blockq=
uote></div></div><div dir=3D"auto">Sorry, just fixing my comment here:</div=
><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex"><div dir=3D"auto"><div dir=3D"auto"><br></div><div =
dir=3D"auto">So I think i spotted one issue, you might need override desc-&=
gt;len after the call to the reserve_and_fill function so that it&#39;s *no=
t taken* from local_mbuf here.</div></div></blockquote></div></div></div>

--00000000000091eb19062d6f0378--

