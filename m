Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14800E6748D
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Dec 2025 11:27:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D65F240611;
	Mon, 22 Dec 2025 12:27:05 +0100 (CET)
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com
 [74.125.224.41]) by mails.dpdk.org (Postfix) with ESMTP id 2319B40264
 for <dev@dpdk.org>; Mon, 22 Dec 2025 12:27:04 +0100 (CET)
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-64471fcdef0so2910258d50.1
 for <dev@dpdk.org>; Mon, 22 Dec 2025 03:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766402823; x=1767007623; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RpLTY3q6zLsAGOejo2aqCDVT7jEwfXBmjlXj9VwIY/A=;
 b=CIoHdDk7Yc2pMIXF2AhXxdadG6KTKm2sew7YygE8oIJahsLHPZ2V5IsRTjHhPc6yH1
 qZWHn2aMWi10Uk4u9G9EipzT0v4iDgBZ/FUzGJlEmXbKZvLIedLR6xAt/TFh9gGAd8G2
 Iwi2x+iHL26XIrtrZFl7xN8gvJBpoFokavcsRdIzCq8FI4d/GuY0tAvIHMOPophHrhCy
 eqRc9cg33GL+ag9eS44mzWMJtVTIH5Ef1duCb1nHl/fsZRKDxPJeCGT6bebyM/9uBsXc
 v+G3dgsUPfBHC8LOUhYYKeq/polGX8VNQEun8aGRKqsHclOAUgl6VOgPkWxnyoMGYgjS
 Ts3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766402823; x=1767007623;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RpLTY3q6zLsAGOejo2aqCDVT7jEwfXBmjlXj9VwIY/A=;
 b=c69FNB31myjM17niL2vdstTNWCgtK3JX09PITpCSMY3EHSUk+1pRsV7d3nTs3xwuJK
 SwpxOlGhDujF/1chqA8WfsO9RPptbiOInra6nIDgiHxEv38J90jag6Bz3kj6bd+VvJqm
 e2w0NY/vtptZ8qLA9HW37dUeyKUAIq2JopZIv0Zsuzoqbkd4w8EAYxP6tF/DDAiwQA/d
 nqp2G6cxoL7k+mW9WSbzK7OzSPg/wFAEB1ckhLXxAFWBBTD7hRKtUcD1DwKdS3+C+X6v
 fGYeizrmkL7qV6z8j2uRb9f7xFdzx6oA24+J9zrmRQRTzaPU8V2nJmXPEeflrI0yKNjR
 /gHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLY6o+j1r8Pi6+g7LtdabjWt0qL5vJvJWX+ZKTHG1WGh8g1bvcp6qQYeZ1QlPQoUpGad4=@dpdk.org
X-Gm-Message-State: AOJu0Yzl2NVO7ZvmSrXzC8AJYTxYT0Yn8xM+Q3h2IYISNWQJ8o3RWtCa
 uEAhsiLYi7In82ij/40ghi0cfD1x876z9j92esPcHkCX4ApCgM9fPk1wwQvXoY1sLPq/ox/6VbH
 NaFFZHR663aQsfHnjZ9iPX1KXo/qKndY=
X-Gm-Gg: AY/fxX7jYvCUkdBKfuGx8hx7JsZ5XlqnpFpmWc6QmNiwn/+K+lyZyJR/p8rLuzN5YF+
 7UoAAvGy9krmcoZKRLV1Lzsjakdn6Gfc3b2gnXwcjc6HGf2twqsFx6Plg9Rkya0Yhnc2QYomPxp
 BXbKjF3hQH9m6GIy97aVlb2Fbdxe2lD7QI28LwwkUvd/zvWkcegSLZEyLCBUEwo9UIbTqoYqJ2k
 PSKfRbiSfnhDx+YNChtPOn+BDKy+QqmrZqKkW031TB07RRBnVz/AN7ICf1ruJy8Z5yt/cG8ySDx
 oCQC5N1IbI45MRpMglhfsC6f5qWL1LfvmSjzzWQt
X-Google-Smtp-Source: AGHT+IFPql8ikILdURXjbIUIC+jDHw+f/snJ36aGuTUi30Oo/LHsewq2/R+xY+v8yJ8n+VZN+9bhfy+K/1uFo0f9B7U=
X-Received: by 2002:a05:690c:6c09:b0:78f:a5c4:7914 with SMTP id
 00721157ae682-78fb3f50c39mr189817657b3.26.1766402823295; Mon, 22 Dec 2025
 03:27:03 -0800 (PST)
MIME-Version: 1.0
References: <20251204005603.3236032-1-luca.boccassi@gmail.com>
 <18458ac8-1c0d-4bc9-bf4b-97ee06c1eef0@nvidia.com>
 <CAMw=ZnRXeX+UxekNOFtkeTbWYyBm-WosWqOi3MtkQ+4Ot3mFpg@mail.gmail.com>
 <4132b192-db18-4df2-a755-44405501330d@nvidia.com>
 <CAMw=ZnQwf8cH_cO9CK3Y--XmzYU+cfCNJ3YWe8qjNZbuCfSe6Q@mail.gmail.com>
In-Reply-To: <CAMw=ZnQwf8cH_cO9CK3Y--XmzYU+cfCNJ3YWe8qjNZbuCfSe6Q@mail.gmail.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Mon, 22 Dec 2025 11:26:52 +0000
X-Gm-Features: AQt7F2q7ZTgvRz7efJ_qcVqWF7csRYm9RkfMmiHyAXLoKyxx8eLPomH9EEPPPug
Message-ID: <CAMw=ZnRPba=cPc1waWhmzkkSK_+iKpdhuFf8u9QZZqDjmScUYA@mail.gmail.com>
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

On Thu, 18 Dec 2025 at 19:06, Luca Boccassi <luca.boccassi@gmail.com> wrote:
>
> On Thu, 18 Dec 2025 at 18:58, Ali Alnubani <alialnu@nvidia.com> wrote:
> >
> >
> > On 12/18/25 8:27 PM, Luca Boccassi wrote:
> > > On Thu, 18 Dec 2025 at 18:24, Ali Alnubani <alialnu@nvidia.com> wrote:
> > >> On 12/4/25 2:56 AM, luca.boccassi@gmail.com wrote:
> > >>
> > >>> Hi all,
> > >>>
> > >>> Here is a list of patches targeted for stable release 22.11.11.
> > >>>
> > >>> The planned date for the final release is December 18th.
> > >>>
> > >>> Please help with testing and validation of your use cases and report
> > >>> any issues/results with reply-all to this mail. For the final release
> > >>> the fixes and reported validations will be added to the release notes.
> > >>>
> > >>> A release candidate tarball can be found at:
> > >>>
> > >>>       https://dpdk.org/browse/dpdk-stable/tag/?id=v22.11.11-rc1
> > >>>
> > >>> These patches are located at branch 22.11 of dpdk-stable repo:
> > >>>       https://dpdk.org/browse/dpdk-stable/
> > >>>
> > >>> Thanks.
> > >>>
> > >>> Luca Boccassi
> > >> Hello,
> > >>
> > >> We ran the following functional tests with Nvidia hardware on v22.11.11-rc1:
> > >> - Basic functionality:
> > >>     Send and receive multiple types of traffic.
> > >> - testpmd xstats counter test.
> > >> - testpmd timestamp test.
> > >> - Changing/checking link status through testpmd.
> > >> - rte_flow tests
> > >> (https://doc.dpdk.org/guides/nics/mlx5.html#supported-hardware-offloads)
> > >> - RSS tests.
> > >> - VLAN filtering, stripping, and insertion tests.
> > >> - Checksum and TSO tests.
> > >> - ptype tests.
> > >> - link_status_interrupt example application tests.
> > >> - l3fwd-power example application tests.
> > >> - Multi-process example applications tests.
> > >> - Hardware LRO tests.
> > >> - Buffer Split tests.
> > >> - Tx scheduling tests.
> > >>
> > >> Functional tests ran on ConnectX-6 Dx (OS: Ubuntu 22.04 | Driver:
> > >> MLNX_OFED_LINUX-5.8-7.0.6.1 | Firmware: 22.35.8002).
> > >>
> > >> An engineer from my team reported 2 issues:
> > >>
> > >> https://bugs.dpdk.org/show_bug.cgi?id=1851
> > >> Did not reproduce in 22.11.10, git-bisect points to 58a6421bc396
> > >> ("net/mlx5: fix multicast")..
> > > Thanks, are you planning to send a fix, or should I just revert that commit?
> >
> > I reached out to the engineer who authored the patch and am waiting for
> > their response. I may not be able to get back to you with an answer
> > today, though.
>
> Thank you, no problem it can wait a while

Hi,

Any update?

Thanks
