Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BEECA101F
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 18:16:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 330B540615;
	Wed, 10 Sep 2025 20:16:32 +0200 (CEST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42]) by mails.dpdk.org (Postfix) with ESMTP id 0B514402C9
 for <dev@dpdk.org>; Wed, 10 Sep 2025 20:16:30 +0200 (CEST)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-726dec342bbso64786066d6.1
 for <dev@dpdk.org>; Wed, 10 Sep 2025 11:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1757528189;
 x=1758132989; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PINVGoBgswdxOdMRCYJCvVp9AGblEE8Gol/kLsLjiNA=;
 b=JPgBg5acNRGd8HKxiHnT/BM927Hkiqb5xMycfKka/TDYnEGBPR1rseUKPYCKszxR2J
 YaNFajxgnReSCViV2y5d2xFncEjgKmU8zeNy3shSRhZA80+Z6sKECUE/b4oeemfHcWiu
 MPk7dwa2SVSq4oLF+2fp2dEknHCltj7Tw41Hn7kfUqiVL5Bw+HRXt70onh9irpGKuW0M
 dyofDOCR/HGp03hcNM1/hgqOjvg1YQWYwBRlH+KP/7mHpTC/n7oGHC1Wst7IHQLVPh8T
 FkId4Ym/a8dMp0TDFSlVuA8ZIQWZbfwIU6J4uqkxHlsHl/RU/w1DL8IAJvwY7szJ2Xzr
 V3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757528189; x=1758132989;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PINVGoBgswdxOdMRCYJCvVp9AGblEE8Gol/kLsLjiNA=;
 b=iRmyYUr4gENszxUfeO9cim9eZGvSYU94gT8/WTpdCUlsG+gsKx8J+2HT0ewWboS3Po
 IsTCg8ygetFpN/pqiIr8IikoIOgLNo1XzwfERwpe6TnF/BdpGBjoIQLSaN3G16WCg8LR
 pP1NXxAxAm4I3dncrS+Dt5VrNwL2eLGYNuAEDYjuOkgsw7hv1b7QacplH3Oxss6Fa/25
 X4RGiLDJ1thFBSbQcLrMGxXXwNaH0rYeYRUMLOgIiGvRnt3ndgfLI6TftuqMBvDTSWae
 6VZbZvB+t6SsylBsJY7RF1BOHFDPYBvXx8sugechz7L6uvvy05T/DUr83B3vdgXEKDyq
 mPXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+3D4NeTF3I35r6Tof+GXNHzn1Ljugbm5NZuzQmSWLHJ+Ul1GLiz5WMydFcqNwpI7ubdM=@dpdk.org
X-Gm-Message-State: AOJu0YyiXud2HR8NERjVskwIPr2JjmQ5tDiKw3AXSab27K/drRDvywNA
 +dkscRZpH43fMs/EUL6q42vzw1SJi3CavCbHO+cxHWcrYeAK2yUGkcMn+8lGXTDDJoQi3m0KKKQ
 FHWSnkP039/6r1lT4UQFbDHTfuGL6xgUbEq6SctQH2w==
X-Gm-Gg: ASbGncu6MRR/DBpbXKbgonOJ4lZR9TCvEpggH9A+r18qOOfGlnH8HMncx+hDnXFnyTu
 xdmEiX4LSPpM1FNUGpj+PM3SQ0gT/n46NvbSFGF9bvf92LLSlF49b9ih7ElsJwbvvIK9QZvStjE
 dDUp1Ndx2lWEfAeQJsVlMTa6lMh7k3EtBGYWQedjRPPh3R1A4PtFnu3pp3iBcfjGDiiqQ1VT9V5
 ht2mVDWd8pAcYf8/WsUCXMCaTZMPPuG4AzNtz/mNBxgxNlmPmbpXN6C6WH+dy5hm5ktTAS/UJpP
 wffZdGUr/LEqkZFxPpWa2iXxA+OgrRRP7bsF4Cp93OyiP6FoGT6X9x7UtZ6I9oZ8Dxyb/Q==
X-Google-Smtp-Source: AGHT+IGIlTPyzuSPeD/hHFMFCWpJz3pacneFB7RGJmyJ3iKeBbrrEWSRMBi4IpOUThdWi27ThTo7WYkWQR0gkpOX4iw=
X-Received: by 2002:ad4:5a4f:0:b0:742:e50f:22a4 with SMTP id
 6a1803df08f44-742e50f3784mr119549426d6.27.1757528189344; Wed, 10 Sep 2025
 11:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250910110237.460825-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250910103406.3be5eac1@hermes.local>
In-Reply-To: <20250910103406.3be5eac1@hermes.local>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Wed, 10 Sep 2025 23:16:16 +0500
X-Gm-Features: AS18NWCtG_VT4SaNH9OONPVUQ9UW9tK7_xUnlqWwShiumj1-FZn9IuDsCrxGqTU
Message-ID: <CA++2-x6ozxMD=yH7VZ4VROH7QFbXqiTSx+S8os7M-aAopesvPA@mail.gmail.com>
Subject: Re: [PATCH] app/testpmd: stop secondary process fwd_lcores during
 primary teardown
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Aman Singh <aman.deep.singh@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, 
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, 
 Ajit Khaparde <ajit.khaparde@broadcom.com>, Xiaoyun Li <xiaoyun.li@intel.com>,
 dev@dpdk.org, dpdk stable <stable@dpdk.org>
Content-Type: multipart/alternative; boundary="00000000000068af02063e766b60"
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

--00000000000068af02063e766b60
Content-Type: text/plain; charset="UTF-8"

Hi Stephen,

On Wed, Sep 10, 2025, 22:34 Stephen Hemminger <stephen@networkplumber.org>
wrote:

>
> > +#ifndef RTE_EXEC_ENV_WINDOWS
> > +
>
> Windows doesn't support secondary processes, not sure how you tested this.
> When Windows supports secondary processes it should the existing EAL API's,
> not fixing every service.
>
Yeah, I have tested on Linux only, the code is under the macro
#ifndef RTE_EXEC_ENV_WINDOWS
#endif

Best regards,
Khadem

>

--00000000000068af02063e766b60
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto">Hi Stephen,</div><br><div class=3D"gmai=
l_quote gmail_quote_container" dir=3D"auto"><div dir=3D"ltr" class=3D"gmail=
_attr">On Wed, Sep 10, 2025, 22:34 Stephen Hemminger &lt;<a href=3D"mailto:=
stephen@networkplumber.org">stephen@networkplumber.org</a>&gt; wrote:</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
&gt; +#ifndef RTE_EXEC_ENV_WINDOWS<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=C2=A0<br>
<br>
Windows doesn&#39;t support secondary processes, not sure how you tested th=
is.<br>
When Windows supports secondary processes it should the existing EAL API&#3=
9;s,<br>
not fixing every service.<br></blockquote></div><div dir=3D"auto">Yeah, I h=
ave tested on Linux only, the code is under the macro=C2=A0</div><div dir=
=3D"auto">#ifndef RTE_EXEC_ENV_WINDOWS</div><div dir=3D"auto">#endif=C2=A0<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">Best regards,=C2=A0</div=
><div dir=3D"auto">Khadem=C2=A0</div><div class=3D"gmail_quote gmail_quote_=
container" dir=3D"auto"><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div>

--00000000000068af02063e766b60--
