Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1100C5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 12:14:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E3FE402D4;
	Tue, 10 Jun 2025 14:14:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 757C54026D
 for <dev@dpdk.org>; Tue, 10 Jun 2025 14:14:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749557654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iziNp1aMDODBOUqC0T3/YvC3ItOyZHCPS4LvmfiFgvg=;
 b=FPXrh+Lz3vsOVAOWSml1mO6EBquP/VH/Cxug6PHwGXAjSwP9cy1gyo6zJ+MVqKn7vvgzEE
 NTU16xBa16t8DqMneBfDFKn7ZlEsuNpnP2cRvfWTwt/VhSNC0BPl2HlNV8qvaY49s1vugS
 XfjA9dMLhHsvdf9eIWF+7vEudiI+dT0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-FpYuXsF1OyGftJuEDmOXNQ-1; Tue, 10 Jun 2025 08:14:13 -0400
X-MC-Unique: FpYuXsF1OyGftJuEDmOXNQ-1
X-Mimecast-MFC-AGG-ID: FpYuXsF1OyGftJuEDmOXNQ_1749557652
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-55324829e0eso3342220e87.3
 for <dev@dpdk.org>; Tue, 10 Jun 2025 05:14:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749557652; x=1750162452;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iziNp1aMDODBOUqC0T3/YvC3ItOyZHCPS4LvmfiFgvg=;
 b=pXNfSQOe9bh9QjyIRS4frh6DA63PwPhuc8rLI2MdDFrA/Kqu1oZtV/r1CXh4u5YIZU
 DkB6/HPajfmjfCeQ2Xh26GnjSLJA+2DzajoghrmT2E0e8JdtVcVe55nfyptK8miygDEL
 EAfA6qmvs4Ur32/8gQ03CuzTO/MVa2ahBsdZ0sG29Yz/S4vuHicAi6etvP1pHlPgjI48
 P59DKMjLREnWSkjC3iAcHtDs138ZcwGSMqI4DgD1wVXHYg5p0T3yise7yQE8AJFXQSIO
 ms1KNedYMF7zxQ8FokJKj+TZj7GTehgSCzq4Om4fW8nKuYnT4lNK38Bhc0KgMZ66dL1R
 y+5g==
X-Gm-Message-State: AOJu0Yx3Yld2cdTZn3/gVF+fzJvdkZr1tfTIApYCeMpq8SOVXI/4XNcu
 q4nvTSFR5jPau2dIT4+stO/IakRdMvK7LeWcaQb3c6v/ck0cOjZIHb0q3LmZg97Gn/uen2dAFO7
 o4tj/hNqNB0V9iNA0MNmHMe23nXAIwXUiunQmyLWMUOYlSKKRtgXU41BrgPCSh0WspHbdMWJJXo
 Tv0g6PzSVvJ7A6tYWwLzs=
X-Gm-Gg: ASbGncsA/fw6OQB/Ll8H2wpbvy/7aiVeffTzi78DI3ZV4pNhRjM9/w3MeDYYoSJ4kNA
 hHJj8wQU3oQtNN1AGyUDJOXWgVHqNOqqViX21Paln7YTRCaRtbGvxIvuqZJL47Kwp6w8AFdi9xk
 skWbMBKQ==
X-Received: by 2002:a05:6512:3da7:b0:553:2ef3:f73d with SMTP id
 2adb3069b0e04-55366bd9d7amr4853774e87.14.1749557651824; 
 Tue, 10 Jun 2025 05:14:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFW59uWa4ps0Wk4fjtYGkW/YcDY78V27NsNwF8ceaPBjBrp4SiEay4TB2pnLerapp0/n7BlWAfwAKU3rh3nMu8=
X-Received: by 2002:a05:6512:3da7:b0:553:2ef3:f73d with SMTP id
 2adb3069b0e04-55366bd9d7amr4853754e87.14.1749557651432; Tue, 10 Jun 2025
 05:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250610100947.421877-1-david.marchand@redhat.com>
 <20250610100947.421877-3-david.marchand@redhat.com>
In-Reply-To: <20250610100947.421877-3-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 10 Jun 2025 14:13:58 +0200
X-Gm-Features: AX0GCFtYlLvvYoutD4uYt6UHNgVoy4fo6ZGOQIarnp4jfH5VnK4A7fiRW57pUU8
Message-ID: <CAJFAV8yu4gwARpVYR0GSsWyTPNHMYJuM9DQm19Dm1CaYRhT95A@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] dev: export driver information with MSVC
To: Andre Muezerie <andremue@linux.microsoft.com>,
 Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Parav Pandit <parav@nvidia.com>,
 Xueming Li <xuemingl@nvidia.com>, 
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, 
 Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Rosen Xu <rosen.xu@altera.com>, Chenbo Xia <chenbox@nvidia.com>, 
 Tomasz Duszynski <tduszynski@marvell.com>,
 Chengwen Feng <fengchengwen@huawei.com>, 
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>, 
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, 
 Matan Azrad <matan@nvidia.com>, Nagadheeraj Rottela <rnagadheeraj@marvell.com>,
 Srikanth Jampala <jsrikanth@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>, 
 Ashish Gupta <ashish.gupta@marvell.com>, Jerin Jacob <jerinj@marvell.com>, 
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: feSVRIQyV6H5ndKR4xsQZIk-8lqYRtDCYnwVrilKwvY_1749557652
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

On Tue, Jun 10, 2025 at 12:10=E2=80=AFPM David Marchand
<david.marchand@redhat.com> wrote:
>
> From: Andre Muezerie <andremue@linux.microsoft.com>
>
> DPDK uses GCC attribute "used" through macro __rte_used to indicate
> that a variable not referenced in the code should be assumed being
> used and therefore not be optimized away. This technique is used to embed
> information in the binaries, by having crafted information stored in
> them.
>
> MSVC offers similar functionality, but it differs significantly: MSVC
> requires a pragma to be used to send a command to the linker telling it
> explicitly the name of the symbol that should be included (even if not
> referenced). As a side-effect, variables called out to be included cannot
> be static, otherwise their symbols are not "seen" by the linker. This
> restriction requires some DPDK code to be refactored.
>
> To assimilate these requirements/restrictions, a new macro
> RTE_PMD_EXPORT_SYMBOL is added in this patch to ensure these special
> variables make it to the final binaries.
>
> The elimination of "static" for some of these variables caused name
> clashes when __COUNTER__ predefined macro was used. As a workaround,
> predefined macro __LINE__ was used instead.

We only need unique symbol names, and the driver name itself is unique.
It is probably more robust than __LINE__ (that is likely to change..).

I'll send a followup patch on this topic for rc2.

>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> Signed-off-by: David Marchand <david.marchand@redhat.com>


--=20
David Marchand

