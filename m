Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C90DD6E2CA
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Dec 2025 19:07:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87A39402EB;
	Thu, 18 Dec 2025 20:07:00 +0100 (CET)
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com
 [74.125.224.54]) by mails.dpdk.org (Postfix) with ESMTP id CB57940275
 for <dev@dpdk.org>; Thu, 18 Dec 2025 20:06:59 +0100 (CET)
Received: by mail-yx1-f54.google.com with SMTP id
 956f58d0204a3-6420c08f886so1278606d50.3
 for <dev@dpdk.org>; Thu, 18 Dec 2025 11:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766084819; x=1766689619; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ESPE3qtjoHuZia3h+7eDVDQJ9Zk9Rdefk0+/K6IDfpo=;
 b=SWEY7ocPEd1UxtIZigxoPfTVZv08kvH3gaVY918c7sw8cA9IR77BOyieZdfuHxWF/g
 hpy5njpnjhftm4bDrYCdBvwLTNS0PhMU5e7Qraj8JNqSrFmx1M82qAbWB7FsUH6u5ip4
 qVy/GPt85ONY3CcXJTXFXkX+P5ddL5Ihd/mHY3i7BSJYY0CT/hAJeJR3c4tceK2u4LZP
 kwY8woSJblsbzvVhINdXsWlQF7TKZYcZaE7/EniHg5wrTT2jp64FtxpveLRM7XWnIzTT
 pjKZ0Q8wh7NpSIfMRZ5H+WbPYE7D1xTnWxPLT/TZFCUW4wnJmuw6Pf+ePdcEEpYaeIso
 NPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766084819; x=1766689619;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ESPE3qtjoHuZia3h+7eDVDQJ9Zk9Rdefk0+/K6IDfpo=;
 b=NzVEemof88NOYih1trIXksM4wJ/GWIq1d73O/Z+OsWwN/LF0SG/ix9WT3uGvY2GJb4
 sE8GabNsiGjUkkwRwGHZZEN0H0LcRty67GHVIJk3thl6fnsRrfiBVZsDMzwc61EIoRkI
 mrta+jc45bx5Rc1mNomce6DpSFL+xqzNEm+qFaPCj5U1rk7ayTdMpMYED0Rd3ryFJF8n
 eQ9XjP2qZ1MibgyYqcy8vHNN6R340D78bNVY/f9mhVwQRbQQJeV3gbBNZ9eviuUYbZfv
 s+Zq2XWWz4spWXzV7K1nOa3rzyLLZWMViWo3gWCD979FqH4sbf0KCB5Rk/JNGNz3AkoD
 Y2Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZgWe78Fa4/y/5AeoJyAcHlDGEyjQApA0Pc4h1aOTt9btZvVmIUEW8+BnLgkyO5YkgDik=@dpdk.org
X-Gm-Message-State: AOJu0YwzhBVJsAGTsfSSFxQjH35wlFP7ZBOQAbSAMSpvcCyihLd10pyI
 5SQwSp49yNYWihjaJrfl9lgD5gbKvvEDgNRfwOryj0/amaC7/KljyHCv8QAuXCybh9gLaMvNdUo
 i17gR1BFII96uVETliqROcREvteODDCo=
X-Gm-Gg: AY/fxX6a5eQRYFjXcNrD8xvGCalc+YnqdnCft1azKbCokv57e/IExI1/HGZz3wHtPjG
 Bsu/Wa/RTQ+OlDlKOmo+v1gPxgv5uVMjxZlxe+M+wPABkkUCPBnXpKgmzOd9VGpWUpZz2UyW8n0
 kZUur1zaYjlDgdYcQjWzaHvpaDX6QrlglBTdb9TMC6ClZ9p1F4eyAyFgVa7OS8YVGFp40jJQItT
 H+lLUKbPD05lz6lPZRCaY6dMGHwvf8ZS+We4I/EOJSiw777DlJToDsMyrUGH9Htc3Aj/YQQU/hD
 E7n4F460wmwrc1F09txyxlAzA5XITA==
X-Google-Smtp-Source: AGHT+IHaKFpJHoJLxQhlu4Thv3y1ui6/SM7ASIro8WisNmNHa/510zr4LhjWnOZK/YiT1en13M+n105YKDGB/VROMEM=
X-Received: by 2002:a53:acd5:0:20b0:645:591a:cb6a with SMTP id
 956f58d0204a3-6466a8c4314mr274615d50.70.1766084818680; Thu, 18 Dec 2025
 11:06:58 -0800 (PST)
MIME-Version: 1.0
References: <20251204005603.3236032-1-luca.boccassi@gmail.com>
 <18458ac8-1c0d-4bc9-bf4b-97ee06c1eef0@nvidia.com>
 <CAMw=ZnRXeX+UxekNOFtkeTbWYyBm-WosWqOi3MtkQ+4Ot3mFpg@mail.gmail.com>
 <4132b192-db18-4df2-a755-44405501330d@nvidia.com>
In-Reply-To: <4132b192-db18-4df2-a755-44405501330d@nvidia.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Thu, 18 Dec 2025 19:06:46 +0000
X-Gm-Features: AQt7F2qX96ltO0lz-8dkjTBjAy_2SANQ4fbMXzgk74_BCHllI00mw0hOb9dLTUo
Message-ID: <CAMw=ZnQwf8cH_cO9CK3Y--XmzYU+cfCNJ3YWe8qjNZbuCfSe6Q@mail.gmail.com>
Subject: Re: 22.11.11 patches review and test
To: Ali Alnubani <alialnu@nvidia.com>
Cc: stable@dpdk.org, dev@dpdk.org, John McNamara <john.mcnamara@intel.com>, 
 Raslan Darawsheh <rasland@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>,
 sbadawi@nvidia.com, waela@nvidia.com
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

On Thu, 18 Dec 2025 at 18:58, Ali Alnubani <alialnu@nvidia.com> wrote:
>
>
> On 12/18/25 8:27 PM, Luca Boccassi wrote:
> > On Thu, 18 Dec 2025 at 18:24, Ali Alnubani <alialnu@nvidia.com> wrote:
> >> On 12/4/25 2:56 AM, luca.boccassi@gmail.com wrote:
> >>
> >>> Hi all,
> >>>
> >>> Here is a list of patches targeted for stable release 22.11.11.
> >>>
> >>> The planned date for the final release is December 18th.
> >>>
> >>> Please help with testing and validation of your use cases and report
> >>> any issues/results with reply-all to this mail. For the final release
> >>> the fixes and reported validations will be added to the release notes.
> >>>
> >>> A release candidate tarball can be found at:
> >>>
> >>>       https://dpdk.org/browse/dpdk-stable/tag/?id=v22.11.11-rc1
> >>>
> >>> These patches are located at branch 22.11 of dpdk-stable repo:
> >>>       https://dpdk.org/browse/dpdk-stable/
> >>>
> >>> Thanks.
> >>>
> >>> Luca Boccassi
> >> Hello,
> >>
> >> We ran the following functional tests with Nvidia hardware on v22.11.11-rc1:
> >> - Basic functionality:
> >>     Send and receive multiple types of traffic.
> >> - testpmd xstats counter test.
> >> - testpmd timestamp test.
> >> - Changing/checking link status through testpmd.
> >> - rte_flow tests
> >> (https://doc.dpdk.org/guides/nics/mlx5.html#supported-hardware-offloads)
> >> - RSS tests.
> >> - VLAN filtering, stripping, and insertion tests.
> >> - Checksum and TSO tests.
> >> - ptype tests.
> >> - link_status_interrupt example application tests.
> >> - l3fwd-power example application tests.
> >> - Multi-process example applications tests.
> >> - Hardware LRO tests.
> >> - Buffer Split tests.
> >> - Tx scheduling tests.
> >>
> >> Functional tests ran on ConnectX-6 Dx (OS: Ubuntu 22.04 | Driver:
> >> MLNX_OFED_LINUX-5.8-7.0.6.1 | Firmware: 22.35.8002).
> >>
> >> An engineer from my team reported 2 issues:
> >>
> >> https://bugs.dpdk.org/show_bug.cgi?id=1851
> >> Did not reproduce in 22.11.10, git-bisect points to 58a6421bc396
> >> ("net/mlx5: fix multicast")..
> > Thanks, are you planning to send a fix, or should I just revert that commit?
>
> I reached out to the engineer who authored the patch and am waiting for
> their response. I may not be able to get back to you with an answer
> today, though.

Thank you, no problem it can wait a while
