Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF4DC83F17
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 13:18:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28FE64069F;
	Fri, 18 Jul 2025 15:18:38 +0200 (CEST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com
 [209.85.128.177])
 by mails.dpdk.org (Postfix) with ESMTP id 8DAB04014F
 for <dev@dpdk.org>; Fri, 18 Jul 2025 15:18:36 +0200 (CEST)
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-70e75f30452so14127237b3.2
 for <dev@dpdk.org>; Fri, 18 Jul 2025 06:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752844716; x=1753449516; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SHE6+FJsji4yeni9suIcX1VC/G6r14+uhrcxKouMakM=;
 b=aeY1Y2wOcwS3wsrAnHcKe0Qeg4aCXyzFaKEDta1lfd8cbbV+1QAeqxMQ6arYvipz5I
 wj9yZvLgsM9BFq4zU6v9BL2EgSHW9JDqaJ+itkfoUm+g08rJFSrkqzZk9IyXfAY9tExQ
 29bpK4EcmEOcWsbg8rhxbekb0YnPcuKa3WP/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752844716; x=1753449516;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SHE6+FJsji4yeni9suIcX1VC/G6r14+uhrcxKouMakM=;
 b=JifCZz0tMuyUvb+FCFZV7VG5R5WlQBwnjRkqw9FoXXQY4rpnQSm61faur5wf3hvmWF
 RRwva6Ktg45dtOwSWSkI8TdeQ82WUDajFdgHXOhmBgVyLDxMQYmxMQf+w1BUGxrKG5vT
 IZU6Cuu/uZ6BMWwSIwkJvN/sZN6prYGJhDYVuP0W+HqeXTng8kggCI4mE+0uNO5qZDJr
 EqDON5k7IUeZfEFlQBYxxmMunO/54AEPMFXMR/JysJcAWbKkl0OAmZSqO/NGQwqbX39h
 T2l3WTbUOzVZDikPy3p/Vb7Eq8R2VKxt1f/7CmjHpqEjBAlZe3YooRqCN7/6e/cem0iA
 C+rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzHGw7HXrQOYYqwAvybbYqbNQc9SB2yHfwm4DqhuTfdLnm5ttf24wswNg3SAasPkW3Vyo=@dpdk.org
X-Gm-Message-State: AOJu0Yxs9PcyQWpyyvMFXdVqIk7smF6GuoqiFcG5Yxs3rqELiHduYjGe
 h3mPN8kBZwjRXck2ZcuKY2u9BC5qNy2Kw4B9pd3e/eP/fUEZ/G/4uzW1Q+M+jck027oK6GXYJse
 sXOSnfYy3Q56QNfMyki6Aq3+9cNsqfPGnNiKvIf4huw==
X-Gm-Gg: ASbGncsiUnp2lxqv5X1BHDThwhvHAriCxKtQj0ot50mvC9APlwsols3KucE31eSZGH8
 SnetiYNcp4K9VM7q3aKUCobG5HPqb2Jj1D2GFlQ/g+UrQWf7tyCafTU3E9E9nuqUgIJ2BRIbuNd
 Wog0TAo9Tfbo6yYuF5yWxF85pqU6hpSUv9wlTNwDDChhhb9hguw6zF5YRKpN58pbWTYZn6KPNbW
 cw1x03rl3R7Nn0DQ/oo1pc=
X-Google-Smtp-Source: AGHT+IFVVc38r2rsMANawanvbDacPnBWo5YJX8pcA7PgtI/IcmBYuUFd6L5r6tYQk0SCa3viZZfA6qZNXnBn+VXoMfM=
X-Received: by 2002:a05:690c:4a07:b0:712:e082:42ee with SMTP id
 00721157ae682-7183515f795mr144636327b3.30.1752844715589; Fri, 18 Jul 2025
 06:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250714133014.44597-1-bruce.richardson@intel.com>
 <CABD7UXPVg56UwvmtOsssBwV2HzmgV4ZJZCb=FrnVQKkggtD2+Q@mail.gmail.com>
 <aHd6x3kT053EvX2g@bricha3-mobl1.ger.corp.intel.com>
 <CABD7UXPtChUUOdz3gfiyKqY4Rn2_0F8Ck4O6ypq9woATD7hfCw@mail.gmail.com>
 <aHgBs5DGU48mTnwz@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FDB8@smartserver.smartshare.dk>
 <CABD7UXPccao=o1O=SessoAdEKUyA-dXP6HG5mnkpFSVNL_3dxw@mail.gmail.com>
 <aHoEUmesrg9Y8qtM@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aHoEUmesrg9Y8qtM@bricha3-mobl1.ger.corp.intel.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Fri, 18 Jul 2025 09:18:24 -0400
X-Gm-Features: Ac12FXy1VExlGy2Nd3tSkxv9Mguy3QDKng6aDGnY9EzAjVxZzshTbrVOnMDpBIg
Message-ID: <CABD7UXOqkROef0_BreD1GHC_R+7EwxRTL8LF-fXQJBECp7J9SA@mail.gmail.com>
Subject: Re: [RFC PATCH] doc: clarify VLAN and QinQ stripping behaviour
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, dev@dpdk.org, 
 Dengdui Huang <huangdengdui@huawei.com>,
 Vladimir Medvedkin <medvedkinv@gmail.com>, techboard@dpdk.org, 
 Patrick Robb <probb@iol.unh.edu>, fengchengwen <fengchengwen@huawei.com>,
 stephen@networkplumber.org, 
 jasvinder.singh@intel.com, thomas@monjalon.net, aman.deep.singh@intel.com, 
 lihuisong@huawei.com, liuyonglong@huawei.com
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

On Fri, Jul 18, 2025 at 4:23=E2=80=AFAM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Thu, Jul 17, 2025 at 05:03:13PM -0400, Dean Marx wrote:
> > I've created a v1 of a QinQ test suite around the set of test cases
> > discussed earlier (which is not set in stone, and I expect it to
> > change significantly across many future versions.) The PASS/FAIL
> > values can be mostly disregarded in the context of this conversation,
> > but I've added logging to explain which packets are sent, and what
> > happened upon reception, which I hope will be more informative. After
> > running on mlx5/i40e drivers, I got the following results:
> >
> > test_vlan_strip: QinQ strip OFF and VLAN strip ON
> > test_qinq_strip: QinQ strip ON and VLAN strip ON
> >
> > i40e:
> >     test_qinq_strip (sent packet: Single VLAN): FAIL
> >       reason: VLAN tags found in packet when should have been
> > stripped: Ether / Dot1Q / 802.1q (0x1c) vlan 1280 / LLC / Raw /
> > Padding
> >     test_qinq_strip (sent packet: Stacked VLAN): FAIL
> >       reason: Expected one VLAN tag but found 2: Ether / Dot1Q / Dot1Q
> > / 802.1q (0x1c) vlan 1280 / LLC / Raw / Padding
> >     test_qinq_strip (sent packet: Single S-VLAN): FAIL
> >       reason: VLAN tags found in packet when should have been
> > stripped: Ether / Dot1Q / 802.1q (??) vlan ?? / LLC / Raw / Padding
> >     test_qinq_strip (sent packet: QinQ): FAIL
> >       reason: VLAN tags found in packet when should have been
> > stripped: Ether / Dot1Q / Dot1AD / 802.1q (0x1c) vlan 1280 / LLC / Raw
> > / Padding
> >     test_vlan_strip (sent packet: Single VLAN): PASS
> >       reason: VLAN tag stripped from packet
> >     test_vlan_strip (sent packet: Stacked VLAN): PASS
> >       reason: Received packet had outer VLAN stripped, with inner VLAN =
intact
> >     test_vlan_strip (sent packet: Single S-VLAN): PASS
> >       reason: S-VLAN tag stripped from packet
> >     test_vlan_strip (sent packet: QinQ): FAIL
> >       reason: Neither tag stripped
> >
>
> Can you confirm exactly what is being sent in each case for the ethertype
> of the VLAN tag? When you say single and stacked VLANs, that is VLANs wit=
h
> 0x8100 type, correct? Is single S-VLAN a tag with ethertype 0x88a8, and
> QinQ packet a packet with one 0x88a8 and one 0x8100? No other type option=
s,
> e.g. 0x9100 were checked, right?
>
> /Bruce

That's correct, single VLAN is one 0x8100 tag, stacked is two, single
S-VLAN is one 0x88a8, and QinQ is 0x88a8 and 0x8100. No other types
were tested in the stripping case
