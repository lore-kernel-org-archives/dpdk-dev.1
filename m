Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05297C369AB
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 07:08:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE280402A1;
	Tue, 15 Apr 2025 09:08:32 +0200 (CEST)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTP id ED65040289
 for <dev@dpdk.org>; Tue, 15 Apr 2025 09:08:30 +0200 (CEST)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-476ac73c76fso52913201cf.0
 for <dev@dpdk.org>; Tue, 15 Apr 2025 00:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744700910; x=1745305710; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jtZxYcaekdvKN+L2PTSvmu87wAZowmWlVWuoQVx3Tac=;
 b=M12HHhmh+jl0O2U3dGxHnDrDXFTAesBXSv4vnC7S1L4YTPlGPmPaLMNetB6iX4OF/0
 TuIOnboj2wOpNveEs9YzKaiu2k/AGQ8BVEVLmQrwiAj8Dnk3eYJAt3zjUG5OqNecl2a3
 vdYrfcvo72MGUGyFZYL2PVbjxhzBena6pw9SMn9GeapsuZkWAi31fgqA5NKbHKppvr5j
 1eDb3FOu2JwlT5GSFAAUxz+kSXV4hC8iBAHON+HhhSOky8/so0SMbh/WMo71eUq7gXdu
 z16x9ZVZsqGB/MZ7CVjaDDVjToYVnAVFyKkvbpMfu5xEEzwxJevLBMn6VbDy9wa8HVyE
 w2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744700910; x=1745305710;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jtZxYcaekdvKN+L2PTSvmu87wAZowmWlVWuoQVx3Tac=;
 b=uu3H+A3S/Ci8Sdghp7p8sQiqq6040ny54bvIO6Pve/k5mF+HsYQaQsW5fZyQqZkNYc
 3zV9bvHA7zst1RIgUY8va90JhX4zi5fT/wP6//MF+f6VsoNTHaq/fUnX153aTpAUDBtF
 eXmd0m6Ta4SCzfbgJEXMxFPnKZ/MKC3TEmoLm7Y5os/IjfCIqf3+hzqzfNw2Ju3mhpL2
 CXXqnkbOtAvxVtLT1r+G7qdK1Xh+Jd+G0UCY5PbOWCmHM7Sh5+hnpuQVAKzq2uQbXz6m
 8jOAdMKqpZcUBQnasGBcTt1r/LT6f4FtKoTJnhOZRN9Cm+mqkgA7+qvRyI1+0g/utyxJ
 QGEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaUUGXttZsJ69l/e9bV4dY4Q0WBntDnYHDQ62gx1rG04tmh6xXcF696wqaplYOnSf6UpA=@dpdk.org
X-Gm-Message-State: AOJu0Yy6ehh7cCQWdxjprp28klwp+xBJsP5wgyyu99r4vT/KNKIHMISx
 aEZfL6x82BdGTNrS13WBeK7lkErVZmveRATET7H4fkK95gn7gkW47C1BwEjHx7xRw18lbfV010j
 gWHlbBPgNNDLbtHot9LD2ar7PETc=
X-Gm-Gg: ASbGncu3rO3DgOGKn4RoozPgThla4rs/syeOtbtdpXQlDzCJuQwKx752juT0hPji9iB
 8bLobmW7E117vsWzhnAMpPsPlSchz/FWwt733JgCc9i1mwVJMUuY0mRAWTCS6h5krEpm2pNEaAk
 1lqcFa0s0FbTSfwuKAleeU
X-Google-Smtp-Source: AGHT+IH2pV+/yIxyHTxPWYWq7iinX2BJVKVOBxMT/+HPul6x/jYP6iWEmrXbfx2TP7JvToAJThA2vEoiSophJPIfi2s=
X-Received: by 2002:a05:622a:1a15:b0:476:95dd:520e with SMTP id
 d75a77b69052e-47977538fa7mr235392771cf.16.1744700910271; Tue, 15 Apr 2025
 00:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250403070837.926292-1-ndabilpuram@marvell.com>
 <20250403174647.1d9e5742@hermes.local>
In-Reply-To: <20250403174647.1d9e5742@hermes.local>
From: Nithin Dabilpuram <nithind1988@gmail.com>
Date: Tue, 15 Apr 2025 12:38:18 +0530
X-Gm-Features: ATxdqUG2T66oKpQAsKppHvJbjSPqFJqzH8p2vsXzoxchmS6KDtvVTV7Ix69DkSc
Message-ID: <CAMuDWKQ09WopqXqxhkB7NhHgTi4v=N4xG5z0V84b2xPPZGgWxw@mail.gmail.com>
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

On Fri, Apr 4, 2025 at 6:16=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Thu, 3 Apr 2025 12:38:34 +0530
> Nithin Dabilpuram <ndabilpuram@marvell.com> wrote:
>
> >  /**
> >   * A structure used to retrieve link-level information of an Ethernet =
port.
> >   */
> > @@ -341,6 +354,7 @@ struct rte_eth_link {
> >                       uint16_t link_duplex  : 1;  /**< RTE_ETH_LINK_[HA=
LF/FULL]_DUPLEX */
> >                       uint16_t link_autoneg : 1;  /**< RTE_ETH_LINK_[AU=
TONEG/FIXED] */
> >                       uint16_t link_status  : 1;  /**< RTE_ETH_LINK_[DO=
WN/UP] */
> > +                     uint16_t link_type    : 5;  /**< RTE_ETH_LINK_TYP=
E_* */
> >               };
> >       };
> >  };
>
> Seems like an ABI break, and not sure that all drivers will fill those bi=
ts with zero now.

Generally ABI is between APP and all DPDK libraries/PMD and not
between DPDK libraries and PMD ?
For example:

#1 App build with DPDK 24.11, DPDK libraries and PMD's based on 24.11
#2 App built with DPDK 24.11, DPDK libraries and PMD's based on 25.07
#3 App build with DPDK 24.11, DPDK libraries based on 25.07 and PMD's
based on 24.11
#4 App build with DPDK 24.11, DPDK libraries based on 24.11 and PMD's
based on 25.07


For scenario #2, there is no issue if my change can includes memset in
ethdev library ?
Scenario #3 and Scenario #4 are not really valid right ?






Scenario #2 is not possible right ?
