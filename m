Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B72C5AE5D
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Aug 2026 10:42:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4758F40E0A;
	Mon, 10 Aug 2026 12:42:39 +0200 (CEST)
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com
 [74.125.224.47]) by mails.dpdk.org (Postfix) with ESMTP id 5AD1D40671
 for <dev@dpdk.org>; Mon, 10 Aug 2026 12:42:37 +0200 (CEST)
Received: by mail-yx1-f47.google.com with SMTP id
 956f58d0204a3-6611669cd16so2233619d50.0
 for <dev@dpdk.org>; Mon, 10 Aug 2026 03:42:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786358556; cv=none;
 d=google.com; s=arc-20260327;
 b=oGGLTJAHmUvEKnBQilAVH889sGZGq8jWstd4W9KIKJK4pnaih8dAorUmqmnuwE6P52
 O92mWgf7Yclb5kea1yoMObrpCy4Rovw2ufHGYS2lOCeyjAf/75JmtngG7F+inMbb8ko/
 SgHkPQxXe14J89wiAwtSsIo4Pto+BUVA70kW6HANR6DAjwC8EoFYV0Zf4dsO5hwXK/HU
 5jULHQrx9r90ZxQrjufQjk3L3OstpzkhFkVKC1HRl+r3u0DrSEozsehCxpN6WfZjCtpi
 0vc9BCzr/3KWrqrqlC10THCKugszOrlLWrVEoZmCaseT8Vn5Ro2ajwQfB2SK2pM4ELuS
 NhVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=amsH/GzHM9z1NDGkCnOnYVAcVoOOCYGb8Z6jKnvAXcc=;
 fh=rHqa4iH8c6LoLmz/oL0Zs+figF3qFiuIxVBLdArE9gQ=;
 b=ahj+Vq6hkmtaFVvreNuNQ774CgdwwhZ3OQ/vNBKtgPyr2bX/toAASqWiq43aqoqut0
 LFLfvEKfCI1KoT1X4eBXZS129I0r9XezEs7QXca21dtiUDBIvH5vLyrrC6itSvzeTQSE
 gVqFH97Q66Y+Vv4IZDqmpOgolfwmlO8U15iNTz7GDtVNMcC/42QCUMuzH5J+rIdPGbHG
 8PnAUO/rZ7yUNKoWqJgS0DibNsY8aLC8BwV4vqTd2jg2yhb5OIlFQKz+bQgCCH4XG4Iz
 ucsrGC/FsCfpCvFPBWQucuB/Oru4rKNx18uTfwUeYd4KNjMNlQQXwRjWSN2krH0dMhqL
 WYqw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786358556; x=1786963356; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=amsH/GzHM9z1NDGkCnOnYVAcVoOOCYGb8Z6jKnvAXcc=;
 b=JqFnwPWDJ47CsrSriQClY8RgRJZcvSmmx3uN0D3OtACdRkf5GTPyrBZvzi8bmj1pib
 sauGj2rTc4LnnXVlAGgRFC7+IEAPj9Pj2l2fMhqfjB6FK03IGo1OVyQZNVOp07tjPBu9
 ZECf+2wW+wzGXwf94iIetqDH4O5sC1OzYO5z+7qVgu4A7d9IktafPedUaXLCSNAKxDWs
 +rlMUIo06HPBe5ntk+ryQJXMEDD7aiKq0HgWt3kNh6LYr7f+l5TjJA7hn2+LeB/vHjmg
 1ogUJkKPUK6QZTqg2Uh+60y1CfweMAZx5ZdiRFN4qTKJK6hf6BBtOLGBL2wj70D067bb
 SYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786358556; x=1786963356;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=amsH/GzHM9z1NDGkCnOnYVAcVoOOCYGb8Z6jKnvAXcc=;
 b=pZc/+RF8WkD1E3C1nKhAtSfOO10XLiqoqe9TDwfTH/CKluaGVUTRFyvcrw6SJBivIB
 b77gHYnUnpaYQVSYBxejUrfshB3FauxrDZYy/ulPHMPcDQzZEzwXspzqOkjHxkaUs1A7
 gD0o9S2UBdGRdjLGJxH4qgpgUDDrDngLzRb3+E3/6PYNwTZVdGjICVloeXKlsRx2rANC
 vwgZBY9PKOkwCY4ij18vSL1iIxele42e7yjYgjoNET4xwEmRSdyOXmaqDRTIPDrGw5AW
 1igJrs2hyzlHsygN1Kqz2/Trj1ywXDh9LbuVGmZ3/IICLO7OcTikiGKdyO08Az+xXtw3
 H/KQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp4oIYZZxT1HVt5D/wmcx40xAM73/WFgKpTEllrQ+OMNfPolOs5QedEmWU6z15NQBRVzl8=@dpdk.org
X-Gm-Message-State: AOJu0Ywr5OenKnebQL+HPp3XwN4l7l3qXWVCbK5GlRK8BRV9RFaRsFzG
 Ljqo9XsrV9qLoY9zYSnbF+DihO2kTqPp0Dbs8YK5SNwVno0csCVxFaX2YZCjIRmCHM0LZI6D8F/
 AoL49amUMMTCZPINPPNGWPNZfZFoR4FE=
X-Gm-Gg: AR+sD13CjdxwnOz4U1MWWLQ+cm3x/ULTaEkPQfRMBVAJTVDK8JBpXx7+1ngDW34tQ8s
 5NB/Dkn1frmGS7Ikqq11Hzifdh1Ahk0usEagFTrlBSvskuv0Hs3YSP28goh/S7eWDo4+pOuhDVZ
 ndXBrocCTYKjJDBGFpIL1wB3lTQTUIjebda3MU4YKK6P316IZQDf9KWLJwKnx5jTaYaMcwIBAgX
 7YegMMcKabJjXViLbJ89VTV/g7+t+myGSna1ZHaAfUdkfrZVOifCwPMc15/qpeHBBe1rBaOqIVd
 xaZxKa849zbwDvjiQVMWD9Y6s8IKwU0/FCgOD19Dny9W36bWbZjM+SmxDKdV++Q2TYddwIXumfD
 r42vKx1nXP7EckQ==
X-Received: by 2002:a05:690c:b01:b0:804:a2d5:1e04 with SMTP id
 00721157ae682-82574af4157mr121749447b3.16.1786358556552; Mon, 10 Aug 2026
 03:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260727094306.41797-1-luca.boccassi@gmail.com>
 <DS4PPF00BBED10C46A3A7E83F35B88C059E9FDE2@DS4PPF00BBED10C.namprd11.prod.outlook.com>
In-Reply-To: <DS4PPF00BBED10C46A3A7E83F35B88C059E9FDE2@DS4PPF00BBED10C.namprd11.prod.outlook.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Mon, 10 Aug 2026 11:42:25 +0100
X-Gm-Features: AUfX_mxcQn6oppdBSwff5FdqBCRiOFoxf2JErFYunuLOn7p0tQnpgaPo5ExnFUQ
Message-ID: <CAMw=ZnRq7nCu7E1n-52wLaOwzhc27tWx+9XDDK-Q5RELE=1arw@mail.gmail.com>
Subject: Re: 24.11.7 patches review and test
To: "Xu, HailinX" <hailinx.xu@intel.com>
Cc: "stable@dpdk.org" <stable@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>, 
 "Mcnamara, John" <john.mcnamara@intel.com>, Kevin Traynor <ktraynor@redhat.com>,
 Thomas Monjalon <thomas@monjalon.net>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 10 Aug 2026 at 02:09, Xu, HailinX <hailinx.xu@intel.com> wrote:
>
> > -----Original Message-----
> > From: luca.boccassi@gmail.com <luca.boccassi@gmail.com>
> > Sent: Monday, July 27, 2026 5:43 PM
> > To: stable@dpdk.org
> > Cc: dev@dpdk.org; Abhishek Marathe <Abhishek.Marathe@microsoft.com>;
> > Ali Alnubani <alialnu@nvidia.com>; David Christensen
> > <drc@linux.vnet.ibm.com>; Agrawal, Hemant <hemant.agrawal@nxp.com>;
> > Ian Stokes <ian.stokes@intel.com>; Jerin Jacob <jerinj@marvell.com>;
> > Mcnamara, John <john.mcnamara@intel.com>; Ju-Hyoung Lee
> > <juhlee@microsoft.com>; Kevin Traynor <ktraynor@redhat.com>; Luca
> > Boccassi <bluca@debian.org>; Pei Zhang <pezhang@redhat.com>; Raslan
> > Darawsheh <rasland@nvidia.com>; Thomas Monjalon
> > <thomas@monjalon.net>; Yanghang Liu <yanghliu@redhat.com>
> > Subject: 24.11.7 patches review and test
> >
> > Hi all,
> >
> > Here is a list of patches targeted for stable release 24.11.7.
> >
> > The planned date for the final release is 2026/08/10.
> >
> > Please help with testing and validation of your use cases and report any
> > issues/results with reply-all to this mail. For the final release the fixes and
> > reported validations will be added to the release notes.
> >
> > A release candidate tarball can be found at:
> >
> >     https://dpdk.org/browse/dpdk-stable/tag/?id=v24.11.7-rc1
> >
> > These patches are located at branch 24.11 of dpdk-stable repo:
> >     https://dpdk.org/browse/dpdk-stable/
> >
> > Thanks.
> >
> > Luca Boccassi
> >
> > ---
> Update the test status for Intel part. dpdk24.11.7-rc1 all validation test done. found 1 new issue.
>
> New issue:
>   Bug 1974 - [dpdk24.11.7-rc1] DPDK build failed with clang on Ubuntu26.04

This test hasn't changed and is the same in main as far as I can see.
Are you sure this is a regression in 24.11.7 and not simply a new
compiler issue that affects all branches?
