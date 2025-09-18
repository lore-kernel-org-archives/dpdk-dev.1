Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7898FCA1013
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 20:59:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DA334065B;
	Thu, 18 Sep 2025 22:59:54 +0200 (CEST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id 92545402D0
 for <dev@dpdk.org>; Thu, 18 Sep 2025 22:59:53 +0200 (CEST)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-24b13313b1bso10312435ad.2
 for <dev@dpdk.org>; Thu, 18 Sep 2025 13:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1758229193; x=1758833993; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ht4If8kH+Qzquws89BXs3JfXUPPkvLudzv9VmDarXTE=;
 b=Lp7fA7Y1Jw7Us6IxFvl3Z2RZV7dr/vT3dwQLsFEYGxud3kQy04UfTr5pqriNAawrAH
 AAb0f2vTHyvyM3Wo1WUaBXN8fW0YFpb6A8MjdWfoEASpDzL1WC8ffLjq/kjPz13116Kb
 0IVbBgh6z9EGIt+8Y6k0KkpYmBClaJt8t60vI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758229193; x=1758833993;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ht4If8kH+Qzquws89BXs3JfXUPPkvLudzv9VmDarXTE=;
 b=dw3uapUWRv6ZneI9UBhVdmMlGuINYgq7eWPCvFeeEWW9E7RLi8FDxIUshvbKOJjrs2
 E7siID6X0qahhEAkzl4iQpFuPrHsrWu3+p8zlk27A6jrbQkkcVwFq6J7JRzL6O2ryegU
 3CgWeOAhvbwQMsYu6v3/mv0zuroJcuWzw3i2TKZ45ySvLcUlC5B0R9a9ewUVZomYqy9i
 z8/3JMnBuabjA0WBbyUE/rJ4L3VE9Ga9H5k5r8+eZim7VhP9ug1WuoiRm/w1lGqE0YCN
 cxEq43OeHeweMgGuqeIECoxIPXYiqWcGdI3ib6sbTn161Zm2Aa0ztPU+jNGsVxKMQVJt
 fSsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNMwHqfAPJCZVl18LW2Oous0NP8GpvrBvrwU5h9yCDqduwl9JMmmrjwxNNSNTIq2lBukw=@dpdk.org
X-Gm-Message-State: AOJu0Yy66j2jFkbCENECLp9iavZRMPxiX60dvymoqzdmNmntdEI6GxBe
 dg7nJ/4QD1ADGFLtlkF5tPFZ448hJSNziwmPpHULg2Tsc7yh8ZJeKOTY6zAdiojtmSYqDmWci/p
 bncEMBZTsZtdY1YH+hEMeWKEBVslAFrzaOWgLK6uetf0WUX5dqFJ72us=
X-Gm-Gg: ASbGnct3bUq4zultUCWFypsbd3fao9LPF/bm20ViT93S7DaMmtfFrCuHXx4ZjKB/rC/
 YiVNhB1P/LaWrCqBUahUsQSadPc0KpOfyNR3S1OU1SIAECpLZ6e7wVos1WvLodCymJ5wxModBxj
 m18UnDugdiWSpXVsuS1+qIBGRHJsdIY1n7+PWQbUSjh894lobOXIJwofhMjVFguKkqYHHipf7is
 LDfIt+8lmlj8wlVkIPRUvFb2UJ0aqmB4QffZ4HdJQqbdu9IQYTMAfp8hLw=
X-Google-Smtp-Source: AGHT+IGaKCkEzS44MWb3Xsk7xYy6pgUMGtP4cdRmuUIStvAWr+yZL5UJ3FeFKr11L0PnjADbJ9UNRDuG7aFaDlhJXnY=
X-Received: by 2002:a17:903:3850:b0:269:936c:88da with SMTP id
 d9443c01a7336-269ba53910bmr11696885ad.41.1758229192605; Thu, 18 Sep 2025
 13:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250908163456.420268-1-shperetz@nvidia.com>
 <3107280.irdbgypaU6@thomas>
In-Reply-To: <3107280.irdbgypaU6@thomas>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 18 Sep 2025 16:59:36 -0400
X-Gm-Features: AS18NWA3g8erBA57pkCXh19EO5f-Gb4tsqFacPBkMfcyuRPVyfP0A-vtl70EUxM
Message-ID: <CAJvnSUD77gw1f0ECo5XuSJrUNWkuJksohQ3hfFNr09j1DP2tLA@mail.gmail.com>
Subject: Re: [PATCH] eal: fix DMA mask validation inconsistency in IOVA VA
To: Thomas Monjalon <thomas@monjalon.net>
Cc: Shani Peretz <shperetz@nvidia.com>, dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000007592ce063f19a275"
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

--0000000000007592ce063f19a275
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

FYI the recheck you submitted is for Shani's v1 patch. The recheck pipeline
picked up your request and is not running a recheck because the patch state
is superseded (which blocks the recheck). If you still want a recheck on
the v1, I will just remove the line in our script which stops the recheck
is the series is superseded.

It looks like Shani submitted a v2 this morning and all tests are passing:
https://patchwork.dpdk.org/project/dpdk/patch/20250918064754.6116-1-shperet=
z@nvidia.com/


On Wed, Sep 17, 2025 at 4:49=E2=80=AFAM Thomas Monjalon <thomas@monjalon.ne=
t> wrote:

> Recheck-request: rebase=3Dmain, iol-mellanox-Functional,
> iol-compile-amd64-testing, iol-compile-arm64-testing,
> iol-unit-amd64-testing, iol-unit-arm64-testing
>
>
>

--0000000000007592ce063f19a275
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Thomas,<div><br></div><div>FYI the recheck you submitte=
d is for Shani&#39;s v1 patch. The recheck pipeline picked up your request =
and is not running a recheck because the patch state is superseded (which b=
locks the recheck). If you still want a recheck on the v1, I will just remo=
ve the line in our script which stops the recheck is the series is supersed=
ed.=C2=A0</div><div><br></div><div>It looks like Shani submitted a v2 this =
morning and all tests are passing:=C2=A0<a href=3D"https://patchwork.dpdk.o=
rg/project/dpdk/patch/20250918064754.6116-1-shperetz@nvidia.com/">https://p=
atchwork.dpdk.org/project/dpdk/patch/20250918064754.6116-1-shperetz@nvidia.=
com/</a>=C2=A0</div></div><br><div class=3D"gmail_quote gmail_quote_contain=
er"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 17, 2025 at 4:49=E2=
=80=AFAM Thomas Monjalon &lt;<a href=3D"mailto:thomas@monjalon.net">thomas@=
monjalon.net</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">Recheck-request: rebase=3Dmain, iol-mellanox-Functional, iol-co=
mpile-amd64-testing, iol-compile-arm64-testing, iol-unit-amd64-testing, iol=
-unit-arm64-testing<br>
<br>
<br>
</blockquote></div>

--0000000000007592ce063f19a275--
