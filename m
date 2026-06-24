Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E0ECDB481
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 13:09:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 430C24025E;
	Wed, 24 Jun 2026 15:09:25 +0200 (CEST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51]) by mails.dpdk.org (Postfix) with ESMTP id F1070400EF
 for <dev@dpdk.org>; Wed, 24 Jun 2026 15:09:23 +0200 (CEST)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-697764213d6so1659566a12.1
 for <dev@dpdk.org>; Wed, 24 Jun 2026 06:09:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782306563; cv=none;
 d=google.com; s=arc-20240605;
 b=MwRjFYL53gqmaXVhaGHCXVo2HGZiQwqdJt3e9Is/EINxSX6la3/2zIfSLFgVrutg1l
 IpzCb/eCzHiahiBIpxFxwcflFNa8vcZa6gPeBn1qWl3Dg08/HTCom+JhVcgEX/RbDR2o
 e+17neeXbjsQW5uyXjzhipTLuF7IjCrFlvMP//ALytqlPc9/ZkAnBbwSWGsFa7KieVEH
 eMxO3qFG+fcM1e+KGDhdbpQAVWsuqzbYZNzB5RG9p6cgTmV5XnjFfl0pid9wD9DtbX4y
 mYSzG8lsC/N9D8P8Drpzl0Tr3nxHMblL6Wq2F63OoBAaslMdMwvX4Z/kdP/5j6WhhJdS
 93UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=j7ikBbwdxV7IFug1sXE734+1YABtGhKefp72r0XFfBg=;
 fh=h+/LpadMJ9QWO+oRsYmUZNNUFJ8WP1e0BUKKbdJvC48=;
 b=SEdYcKAbLPvLYilMkYSiJKXedd+NjS5uebGuXCjg8Z2KGfPo8jl8L1SzshfzG/nAVw
 yIUMMAfbkbTQrPP2nuGALkAnEFLc3f2VA2h7M/g6rzCjpBz8yWFY1T1SdyaLJoeMgEd5
 +bXd/GiuTQkdvdJhbtzpWvaOB/ZGn3T5tO2Hvnk2ShpQarnkb0b5f17hOHBeQGrAljCe
 KurE47qUqePNL3ksa6wH5efh4jqC5MS1aKzlyzxnz2Pk6drXuHN02asED0i0vMJZTeeV
 kYpI4bM/G9WrqECHLkfRgc0phhSRc//JB4d+UoagIqP+aJNm947vsRAtzIdyaP4odCgr
 g3zA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782306563; x=1782911363; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j7ikBbwdxV7IFug1sXE734+1YABtGhKefp72r0XFfBg=;
 b=AWyExXPzBvc7UPRQn+zNoYtrF2svsHGsHJ04u/bLWdV3ltU5B0/H//6IiAyn0sLcTQ
 OdX3hywHNFQG7UaDWur65smQBKKRsDWTSt7U9xP76UxXtZ8spCFf4W9CjHonqOQ5iKQO
 zsgDQxSpIjCt6tIlVruq8Ah5P3FRtjFyjies2G0w3PABsfSkakm+CN+sAXl0Jxb2IGK0
 5K/fKTbYAxkv+SR3MINDgsPuxpmL2I+lC7bCqt52eKM5OHlW0OX5j5G/zDS/0rOg4bat
 jH85/yoVCEeFe/umvN6IgYdQLbfOMB8YM60VCAK5uE2lLHtysD59KpD5BzuAa5GgyjDV
 wVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782306563; x=1782911363;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j7ikBbwdxV7IFug1sXE734+1YABtGhKefp72r0XFfBg=;
 b=iAA9BcWe3wWTE7QigPWULpr2nIK7TnG3HdL4KFx7yHpjHSv2irL0RibogX+KAu0BLa
 MVWyp/qJYwRwlpAXE4yy8gBfUFqFO90Yx1weSUzUuAvPhTNZ1XysU18gqBcKxdYDlnlo
 lT4MvqFBI7l9NvlHoyBge0f9WUHktuZgN6JPIE9emg9PZWxcYpBAnZqz8u9QMCyCKwCF
 K+dZiq1zUeskDvVtdIxVBt0l7dr1txiTOWjHM8X3cqVd4lJPevoBGTJVsavK77o2COKL
 CBR/pYzyRUj88L27JLEhcf+5DIhrHlzQqhsb4yZdQr0WDsnC7VlkjZi8W1Guu+NKTvXO
 +aLg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqKcYPDI2gHmwr3geTUQEMlXOXPuh6qwIgXd7Y0UdDGhFT5ug3VciJGxfMmcstkj78YfpU=@dpdk.org
X-Gm-Message-State: AOJu0YwuK2mmVqtkjPgjYey0qH1cUB8AvireAu8GDOKoxbhH0O4zMYQb
 TlMhqiy0vASSe48FGA2Ofj/Jm8UcQaIaNLjYwNM/S5JrZ7UljaF5zFvzPmo4cWIzg2j/FPhS52D
 vPK3WLX92baU685H0eoOEEG/dG+dgVPgFGQ==
X-Gm-Gg: AfdE7clLG8iulqRlmB2OCwXSeCIPNR+Ordf/I8jXdkaE0aily3KiVWP5V4hhB7dlWJy
 I8o1OLlZczhhgcEwGboubvkP1IHzm7Eh5qZZF/4L44wfP1IcR93L6gsWW/nWoNaTMvNLkJti6ey
 bHSxDlhp28AoNBiaaPp2Hl44plZ35KIMP+n46hrlD9FBziPFbGGMEDYKRxZQBetxLOK9Jp5IGCZ
 uI8RjInMGSJjIJQ3zQZJ+AUC/PgfnooW25FSgONXK1PRZYaDdN+vEsKkShZIO+lHhE3kVSQuMiR
 rvhuOLM7PSB/Z7Me3omxNL4iDLMz
X-Received: by 2002:a05:6402:4002:b0:697:bd1e:868a with SMTP id
 4fb4d7f45d1cf-697f3aab9f9mr1736734a12.22.1782306562963; Wed, 24 Jun 2026
 06:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260619202047.2809165-1-mb@smartsharesystems.com>
 <20260621184140.2878132-1-mb@smartsharesystems.com>
 <CALBAE1OCbZ9GB1oGYgR5hRtzjRmev2ZFOaSNndf02AZptihOcw@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65937@smartserver.smartshare.dk>
 <CALBAE1OZDXfH1FoVLJ=vXVqr=9hYPgqeCzN8h278wN8FbU+XaQ@mail.gmail.com>
 <CAHfVqdWKoDqb0uD_HrF8e=GqadThPhZj0vZnRYDW=KMPei0mXQ@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6593A@smartserver.smartshare.dk>
 <CAHfVqdXW_=8Gn_hy7zYSztAngy=Un2HJ4d+8Ds-EyaqpjM=WHQ@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6593C@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6593C@smartserver.smartshare.dk>
From: saeed bishara <saeed.bishara.os@gmail.com>
Date: Wed, 24 Jun 2026 16:09:12 +0300
X-Gm-Features: AVVi8CdfdidybPiH32cGDub6pB04wMheBhlwfqbO_wc6F_I9CLO4HaLC227Gnfo
Message-ID: <CAHfVqdW_SoSWOVAe1xB0O2kuQ_Ccge9-SBG5xMF0DerayuXhPA@mail.gmail.com>
Subject: Re: [PATCH v5] graph: add optional profiling stats
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: Pavan Nikhilesh <pbhagavatula@marvell.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>, 
 thomas@monjalon.net, Jerin Jacob <jerinjacobk@gmail.com>, dev@dpdk.org, 
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan <yanzhirun_163@163.com>
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

On Wed, Jun 24, 2026 at 10:59=E2=80=AFAM Morten Br=C3=B8rup <mb@smartshares=
ystems.com> wrote:
>
> +Pavan Nikhilesh, +Stephen Hemminger, +Wathsala Vithanage, +Bruce Richard=
son, +Thomas Monjalon
>
> > From: saeed bishara [mailto:saeed.bishara.os@gmail.com]
> > Sent: Tuesday, 23 June 2026 16.11
> >
> > > > also, instead of adding cacheline for this profiling data, can we
> > > > share with line 1 that used solely for xstats?
> > >
> > > This profiling data is 4 indexes * 2 values * 8-byte fields, so one
> > cache line in itself.
> > make sense.
> > btw, the default value of RTE_GRAPH_BURST_SIZE is 256, I suspect that
> > real applications will enforce smaller burst when pulling from input
> > devices (e.g. 32). Do you expect such cases to change
> > RTE_GRAPH_BURST_SIZE?
>
> Excellent question! I don't know.
> They should. E.g. an application optimized for latency should certainly n=
ot process bursts of 256 objects.
>
> IMO, the root problem is the lack of a unified burst size across DPDK, wh=
ich causes every library to be designed with its own optimal burst size.
> E.g. the Mbuf library uses 64 (for rte_pktmbuf_free_bulk()), and the Grap=
h library uses 256.
>
> There has been an attempt at introducing a unified burst size [1] for DPD=
K, but it met a lot of resistance, so it still needs to be refined before w=
e can reach a conclusion.
> The drivers supposedly can report an "optimal" burst size at run-time, wh=
ich the application can then use. But the application is unable to configur=
e its internal burst sizes if one driver reports 64 and another reports 32.
> I'm strongly in favor of a build time constant, used across DPDK. The def=
ault value should work reasonably well across drivers and libraries.
> And if an application wants to optimize for performance (either throughpu=
t or latency), the developer should experiment to find the optimal value.
> Furthermore, designing for a build time constant max burst size throughou=
t DPDK might provide performance benefits in itself, as the compiler can op=
timize for this.
>
> [1]: https://inbox.dpdk.org/dev/KdOygM96Qb6d6ADK1-AcnA@monjalon.net/
>
> Now, back to your question...
> As a workaround, I can sample Graph node performance data for 32 objects,=
 instead of sampling for RTE_GRAPH_BURST_SIZE / 2.
I see, so there is no simple static parameter here. what about
tracking max burst, then report the calls/cycles for that case, the
user will also find what was that max burst, and how often it occured.

saeed
