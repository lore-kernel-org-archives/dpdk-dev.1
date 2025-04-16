Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46B6C369BA
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 09:09:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B24B40BA2;
	Wed, 16 Apr 2025 11:09:00 +0200 (CEST)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by mails.dpdk.org (Postfix) with ESMTP id CD8EC406B8
 for <dev@dpdk.org>; Wed, 16 Apr 2025 11:08:58 +0200 (CEST)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-4766cb762b6so5022911cf.0
 for <dev@dpdk.org>; Wed, 16 Apr 2025 02:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744794538; x=1745399338; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Ki7wW97Qn+WHeZPFo5iUBfwbW/hdI4IIpJRvq1F5c8=;
 b=BZpWMuwxFG/g8WylT6/UfR6mjABmZ+a4zfgrOMF3Gxc5ocR4+qzTPYF4CL5qPbOxgs
 9/Jd/iDxOP4jx/a510E/dktOZWNWHyNfoeLKp+V4Lwoh2JVHUodGhU4DFGBYNzswaefa
 A26dQzblU3SZSo8I/RdWQ6YgGaQNcLpwXOoCANNMNH03dnwvbCQmoD0nHBoPI87w/4IP
 JQrjNFhOqXbULY/xjJURMGJq2zdteibE08XA3fUY621lH7oGpcYhtYJ/dSMZsjkIEvfB
 1aqoNXGZrIu29B6cchSMiWN53q8fWDc3omyy13Y3fsrkIUwUs3lRFL+gqiZjscDm7q+7
 7Zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744794538; x=1745399338;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Ki7wW97Qn+WHeZPFo5iUBfwbW/hdI4IIpJRvq1F5c8=;
 b=jXAz/CqZyvd1cpJrE7KJ0iyviOP6QNB/6LgjoGz6gXSbbrU5tc7y1oR9Xqs0OXzV5G
 9JqLBIihNZYF/oCRsAAIlqdylTvoHs//Z819v8EWGhXDE0wSKwboEg9pqck+K2lhkKju
 uDOQzH7EIGmYBvbedb13z1/Rsescjb1B1T3DOiv0QcOpzcvr+zSH12kY1KDCbghze7Xh
 jBHdEOZFFt+eCMqR5FeIyLlIxYV9aldW2alalmsLeqV1mib/sQvYRSw00IjHkfgRT564
 ZgM9s5QvaOAVWA1GjMQ8+lXd9bjvHbjxOu0ZQSU8lZpL+6+DLdOTQqaTK7RtNWBlnWkn
 PcZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVahEky8kQSw+0rmW0cTAa+2zXA6JjfFzdUNNtgfCddW8uQXUtECVfaGDZ9ADrnHHOHz8g=@dpdk.org
X-Gm-Message-State: AOJu0YziOtlKS/XkjKyIaRVXoxRF9vjSCp/AjvCNzUjr9Ln02DJwkJWY
 zjiDuGORSCfNnBtEhjGbOGsER6QNkt3t2PRo4fbzBKxexrXFbSmkZc8kK1gkSydX/i7vwqWSO36
 WhQ3jn2/kNbK2VgVuq/W32hhkvIs=
X-Gm-Gg: ASbGncvDtiE4XkOowdqaz2BXUrI7bNIPkUuv3k6p1jmUZgu76Z0EpXCR7ZsUo4ybP19
 e1eajQIYac29XjOSi/NkVgIqefitAN17umQW5cidSXrd86Z3RL8TtsT3/e7NaU5LJ2B7ezu+9wY
 zueAB+MGTls5RTIhMzP19tYC41tICpJm4=
X-Google-Smtp-Source: AGHT+IFJQCiYLd2JutqDPY/0ysxxlcGKHOiGrEVa1WsxHgdbmxhfPfr8tIb9T4Y5qjK01H72ggZpIE6QnQU/GD5G+ng=
X-Received: by 2002:a05:622a:19a0:b0:467:6563:8b1d with SMTP id
 d75a77b69052e-47ad80545b8mr10250581cf.6.1744794538188; Wed, 16 Apr 2025
 02:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250403070837.926292-1-ndabilpuram@marvell.com>
 <20250403174647.1d9e5742@hermes.local>
 <CAMuDWKQ09WopqXqxhkB7NhHgTi4v=N4xG5z0V84b2xPPZGgWxw@mail.gmail.com>
 <20250415170344.1bef377d@hermes.local>
In-Reply-To: <20250415170344.1bef377d@hermes.local>
From: Nithin Dabilpuram <nithind1988@gmail.com>
Date: Wed, 16 Apr 2025 14:38:46 +0530
X-Gm-Features: ATxdqUFRsmbxl9XhaQloWR4FeLIir7WYtOwkVadCuzhQ4Z3JSuDjcepULdcTpGE
Message-ID: <CAMuDWKSySooz8=qh6t-H=H9ehgQwFh8ty+GKSOya=3wi+Lw4-w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] ethdev: add support to provide link type
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Thomas Monjalon <thomas@monjalon.net>, 
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org
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

On Wed, Apr 16, 2025 at 5:33=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Tue, 15 Apr 2025 12:38:18 +0530
> Nithin Dabilpuram <nithind1988@gmail.com> wrote:
>
> > On Fri, Apr 4, 2025 at 6:16=E2=80=AFAM Stephen Hemminger
> > <stephen@networkplumber.org> wrote:
> > >
> > > On Thu, 3 Apr 2025 12:38:34 +0530
> > > Nithin Dabilpuram <ndabilpuram@marvell.com> wrote:
> > >
> > > >  /**
> > > >   * A structure used to retrieve link-level information of an Ether=
net port.
> > > >   */
> > > > @@ -341,6 +354,7 @@ struct rte_eth_link {
> > > >                       uint16_t link_duplex  : 1;  /**< RTE_ETH_LINK=
_[HALF/FULL]_DUPLEX */
> > > >                       uint16_t link_autoneg : 1;  /**< RTE_ETH_LINK=
_[AUTONEG/FIXED] */
> > > >                       uint16_t link_status  : 1;  /**< RTE_ETH_LINK=
_[DOWN/UP] */
> > > > +                     uint16_t link_type    : 5;  /**< RTE_ETH_LINK=
_TYPE_* */
> > > >               };
> > > >       };
> > > >  };
> > >
> > > Seems like an ABI break, and not sure that all drivers will fill thos=
e bits with zero now.
> >
> > Generally ABI is between APP and all DPDK libraries/PMD and not
> > between DPDK libraries and PMD ?
>
> The problem is rte_eth_link is returne by rte_eth_link_get which is expos=
ed
> to the application.

Which scenario you are talking about here ?
