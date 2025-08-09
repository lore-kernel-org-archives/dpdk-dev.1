Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E961EC87FCF
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 Aug 2025 06:31:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8E38402C4;
	Sat,  9 Aug 2025 08:31:20 +0200 (CEST)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id 508384026C
 for <dev@dpdk.org>; Sat,  9 Aug 2025 08:31:18 +0200 (CEST)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-7e6974a290eso267173385a.3
 for <dev@dpdk.org>; Fri, 08 Aug 2025 23:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1754721077;
 x=1755325877; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fL3OdDXuDaozjX6Tvl4WwEDWC0GhV7xkifMHmpqBxgE=;
 b=xiotposY+jvPbvKBcQ85ydpuOlRgWosauY7MVRLLssRBWtrFaCvDCkv+W7YfXDKGqW
 g1JJNV0SUc+IMgcouHMdFO6BlKNvxOIVABjpFeKp+g4+qMZzyOJhs/yBz8pOpkLiQLdW
 EpHltXYQx7q8qx/+CKjJloHKIsO3NKpA2mJfpTAfIw1BxCQSU3OfezZgRcPEy5zSaJ1J
 ViiCHMu52WY4g8BfSqK6yAsjXDM5Ix+SPauVTHg87Hnqz62Qs6iQSiq94ERdcm0xpwQr
 NwgieK3KeFrxPo3Sw5sF+zSS+8VgaVVtKjJ752qwfuEzVfVIu7BX88kuTmcuBd/91ytI
 v6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754721077; x=1755325877;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fL3OdDXuDaozjX6Tvl4WwEDWC0GhV7xkifMHmpqBxgE=;
 b=UN2x+dsj43prxcidWJRiIQOdYXXGf4/Q2dwIU/iWj9f4Gc93X3w+3ALzCPnVnf3kI6
 2sfyL7PU2z+A2c1e0vQRGGlpHrWlz4ewL9XDqfStGwEMCFjFM5Rg0LiQUwrrWVaV9B2T
 klI7f88loVzKml+AaQIz9jacpqQp0xCMl4ppMKlbqBWhEJ9DXxvUyboOWm5N/urDJ/5k
 OpdMEenk9wM7BYg4oyIAQZoCEgx3wimr7ePKqXx4k4mEPf//uoMxTswrObkhO1lmyJvq
 KqxaCNhM0aQnHS3czjDl2N37baGoFS0nvqLyVS/P3HncJmev5Nhdoge9xzNg0eRdhGn9
 k9jg==
X-Gm-Message-State: AOJu0Yyb4qynr+EyGlX1sej7DvIg6Txicg3zHupRFm+kNmFMEKqq4hWg
 biTKBblBSK5kh/BoEqoa1vxHUbZMg///LqdLglPmsrp1C9rMl2hO0WzLDprRHDmd2BRf9IN1EZL
 DlswDznRlvd8EvxIh8WdaHWiGX7zVVCVDaXXUAOo8SkQeNsSfca8x1EI=
X-Gm-Gg: ASbGncvk/HgewRhDt3q9Pw06KuvPQuMe8uj2cgV7ot8iBKgcPUaqCuCSKsLHZQLvRsP
 x+J/8VY6urAzc8s5GeQbjwUNMq+STv27GToe+j9+AshzEjQJwTweQA1uyZ5tRGTjJfXU+T4co5x
 L/k86Bu9m3/MuhymP+NHLsE6FuU0WlHPd6bO/VW+dZ/+AK5t14MCLFy9RbA2C8G8TjMMFSBgpta
 YGBBx02eaDFPgR2J1AQOC3KlHPUBX67Lt4Jzxl7gw==
X-Google-Smtp-Source: AGHT+IGDvyqJp2pgfWW6DfwG2i8xq/H579YBCFsFSU+MpEQw5SM37nOLS9yeqUu7qRGHotZMm3zOZaEF4OTGoRJgYpc=
X-Received: by 2002:a05:620a:4143:b0:7e8:221c:c968 with SMTP id
 af79cd13be357-7e82c7a1401mr830857185a.65.1754721077498; Fri, 08 Aug 2025
 23:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250808165843.39075-1-stephen@networkplumber.org>
 <20250808165843.39075-2-stephen@networkplumber.org>
In-Reply-To: <20250808165843.39075-2-stephen@networkplumber.org>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Sat, 9 Aug 2025 11:31:04 +0500
X-Gm-Features: Ac12FXzzOf0UgJjupdj_tCEnSEdXpsScuNCnP4BvApa54u0uD3_lC9eQ57C7k8Q
Message-ID: <CA++2-x72JeV9A0CZpif9JgsVKotASg_HqcFAQNBO=R=_n67Z=g@mail.gmail.com>
Subject: Re: [PATCH v11 01/14] ethdev: allow start/stop from secondary process
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Content-Type: multipart/alternative; boundary="000000000000812c90063be8d6fe"
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

--000000000000812c90063be8d6fe
Content-Type: text/plain; charset="UTF-8"

Acked-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>

On Fri, Aug 8, 2025, 21:59 Stephen Hemminger <stephen@networkplumber.org>
wrote:

> Before this patch if secondary process called start/stop
> it would only impact the secondary process, the ethdev on the
> primary process was not started.
>
> With this patch, when start/stop is called from secondary,
> it calls the primary and does the operation there. The design
> is generic, and we can later add queue and other operations
> as needed.
>
> Bugzilla ID: 73
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>

--000000000000812c90063be8d6fe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Acked-by: Khadem Ullah &lt;<a href=3D"mailto:14pwcse=
1224@uetpeshawar.edu.pk">14pwcse1224@uetpeshawar.edu.pk</a>&gt;<br><br><div=
 class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Fri, Aug 8, 2025, 21:59 Stephen Hemminger &lt;<a href=3D"mailto:=
stephen@networkplumber.org">stephen@networkplumber.org</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">Before this patch if secondary process c=
alled start/stop<br>
it would only impact the secondary process, the ethdev on the<br>
primary process was not started.<br>
<br>
With this patch, when start/stop is called from secondary,<br>
it calls the primary and does the operation there. The design<br>
is generic, and we can later add queue and other operations<br>
as needed.<br>
<br>
Bugzilla ID: 73<br>
<br>
Signed-off-by: Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumb=
er.org" target=3D"_blank" rel=3D"noreferrer">stephen@networkplumber.org</a>=
&gt;<br>
---<br>
</blockquote></div></div></div>

--000000000000812c90063be8d6fe--
