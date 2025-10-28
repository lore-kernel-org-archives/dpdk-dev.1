Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEDCCCD1BF
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 17:44:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1092402E6;
	Tue, 28 Oct 2025 18:44:21 +0100 (CET)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by mails.dpdk.org (Postfix) with ESMTP id CA0D240262
 for <dev@dpdk.org>; Tue, 28 Oct 2025 18:44:19 +0100 (CET)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-4ecee8ce926so27418631cf.1
 for <dev@dpdk.org>; Tue, 28 Oct 2025 10:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761673459; x=1762278259; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hOFSRoExJDjROeo2lBnc6CoNyQ0iuFLCvmO0NaiKhhM=;
 b=I8HoFPR734XM/zlU6QPDNs0FPIqdplTD3YChaYx4xX2LKnd6SbvHFJNooL6Rqdt7Go
 gwoVYO47WSbrCJzS3WPJMYsNHyNM0qgX+Ignaxtr0IH2Llheh5CS4c9h2OlMVe9lRU2Q
 Ft+8vXVlN4dE3XgdOcABbL+Tz0tQXOWviEQvr5m+Gj+9JjayEvJUyBt4kvAeg6MsHaXh
 YFnFBlTkBJC/KizVr4qeIVsCVipSnyFRWQ1a6IiuCKU8AEHr/jP8rvu4opN5Igt9BqEm
 UncD7NXsg1M0+Nk/WQipoOKpczN58uwQmxzQYb4G9Rv3QafeccYgrBRG24u78bsi6vbC
 y3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761673459; x=1762278259;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hOFSRoExJDjROeo2lBnc6CoNyQ0iuFLCvmO0NaiKhhM=;
 b=A9eKk0q4pTWhuphLM6HWM2BdxywyT0n6BYCrK48VkC4kNAfDH2EfiRgUrFVGhW4uyu
 gsotCn2bcWMb1N5lqd1+rVUmUTXVWeWNS+kmudedVFO/XdAo4fNErqpmMHRXSZ6CbHjy
 MB1rkhRU4NOAR5+dIvd3MVKoy8v3GO6Z8PrRZjp4Kt2XW1WT2OFPJKoIdHKXKdL6qQvD
 nek8e3qr2g16vSekJ8EHXQ+0CgzHsWJBFfuDA0VhaZURZg1ImqeZiOV2RJXskHoBbyjM
 uRI9IHAEH22J5Mp7ookrR/Y4qiAZzWJ98VMxB+BqkmLI+YzPMWtUcASrKtmaPxnSHr56
 pbjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKXaG1NF3qY3s+feh5P6HB6gkFX2YcQg+N//CDhl9lfpCRawNl0PPsxPOtRioqDZolSWk=@dpdk.org
X-Gm-Message-State: AOJu0YwJZuaKzGjGiYr8J6Ew36tF4pvzsygYh3oKX6CsdTXCuPa5+FUH
 cBKycImnvbVrS4brNLaQwxpOHMvRjWKbgwLs+K/SKZsyjShy1JNQeb3n80Tva2oEsQuYvphTbkx
 F+VfV+n9Sj6r6N2j1qrO06Wijb9M4WBM=
X-Gm-Gg: ASbGncsxm1iwwShfETpkfoJdfmcKb0EyatCGMRIQKGf+6Hb90kkA4ky6deXetFUBLvd
 40n/hDgt/hw5RisrMJNcuniaUfI/kJOjTTUFSbBS2rZZ+OPBwClqPCCdW5QFZHjnBKY1HGPsBeS
 +ikMBNgDm+skrlLPlgKvhzzwqhFELpBI/PjM/Ut50Jok4bomWwcL0u6fLh1uD3/P796o+PimLwv
 KANVpHIjGCULHn747kJQJXwl3keDYVew+YBe9NKMLiy0jD7Lg1wAsAGiAYh2SJQZlnhY8Ge
X-Google-Smtp-Source: AGHT+IHMp8+0jNdFIfNtGdbCm5XSvqv/V3YzDBTf02vd+2dAtsfZ26PDIulfwL7GnzxwsneOJnLP6F3BWfeTQhsuH4Y=
X-Received: by 2002:a05:622a:5c19:b0:4ec:f6b2:e4ec with SMTP id
 d75a77b69052e-4ed15c1bf1dmr373301cf.44.1761673459004; Tue, 28 Oct 2025
 10:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <98CBD80474FA8B44BF855DF32C47DC35F65442@smartserver.smartshare.dk>
 <20250918081327.06fcdadf@hermes.local>
In-Reply-To: <20250918081327.06fcdadf@hermes.local>
From: Nithin Dabilpuram <nithind1988@gmail.com>
Date: Tue, 28 Oct 2025 23:14:07 +0530
X-Gm-Features: AWmQ_bn0q4PyetrqkUWMHWVqE_3XqgmMLEA4ZGAMG1iKar5MGqk_fnetHZYgq8c
Message-ID: <CAMuDWKTLgDjSTD-Dzb-SBEUdC0LPwDNx3W0W3mn2doWFyQQp0w@mail.gmail.com>
Subject: Re: Fixing MBUF_FAST_FREE TX offload requirements?
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, 
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, 
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, 
 Harman Kalra <hkalra@marvell.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, 
 Sachin Saxena <sachin.saxena@oss.nxp.com>, Shai Brandes <shaibran@amazon.com>, 
 Evgeny Schemeilin <evgenys@amazon.com>, Ron Beider <rbeider@amazon.com>, 
 Amit Bernstein <amitbern@amazon.com>, Wajeeh Atrash <atrwajee@amazon.com>,
 Gaetan Rivet <grive@u256.net>, 
 Xingui Yang <yangxingui@huawei.com>, Chengwen Feng <fengchengwen@huawei.com>, 
 Bruce Richardson <bruce.richardson@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, 
 Jingjing Wu <jingjing.wu@intel.com>, Rosen Xu <rosen.xu@altera.com>, 
 Andrew Boyer <andrew.boyer@amd.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, 
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Wenbo Cao <caowenbo@mucse.com>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Jerin Jacob <jerinj@marvell.com>, 
 Maciej Czekaj <mczekaj@marvell.com>, dev@dpdk.org, techboard@dpdk.org, 
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Ivan Malov <ivan.malov@arknetworks.am>, 
 Thomas Monjalon <thomas@monjalon.net>
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

I agree with Stephen.
Generally what we see with customers is they enable multi-seg offload
on Rx and Tx just to handle very few jumbo frames while most of the
pkts are smaller / IMIX.
So if we say FAST_FREE is mutually exclusive with MULTI_SEGS offload,
then in effect, FAST_FREE is never used.

We should restore to original two requirements and report bugs in
driver as bugs rather than adjusting the spec for that.
In Marvell drivers, we have adhered to original spec. Keeping #3 is
fine IMO. Problem is only with #4.

--
Nithin

PS: Sorry for late reply

On Thu, Sep 18, 2025 at 8:49=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Thu, 18 Sep 2025 10:50:11 +0200
> Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:
>
> > Dear NIC driver maintainers (CC: DPDK Tech Board),
> >
> > The DPDK Tech Board has discussed that patch [1] (included in DPDK 25.0=
7) extended the documented requirements to the RTE_ETH_TX_OFFLOAD_MBUF_FAST=
_FREE offload.
> > These changes put additional limitations on applications' use of the MB=
UF_FAST_FREE TX offload, and made MBUF_FAST_FREE mutually exclusive with MU=
LTI_SEGS (which is typically used for jumbo frame support).
> > The Tech Board discussed that these changes do not reflect the intentio=
n of the MBUF_FAST_FREE TX offload, and wants to fix it.
> > Mainly, MBUF_FAST_FREE and MULTI_SEGS should not be mutually exclusive.
> >
> > The original RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE requirements were:
> > When set, application must guarantee that
> > 1) per-queue all mbufs come from the same mempool, and
> > 2) mbufs have refcnt =3D 1.
> >
> > The patch added the following requirements to the MBUF_FAST_FREE offloa=
d, reflecting rte_pktmbuf_prefree_seg() postconditions:
> > 3) mbufs are direct,
> > 4) mbufs have next =3D NULL and nb_segs =3D 1.
> >
> > Now, the key question is:
> > Can we roll back to the original two requirements?
> > Or do the drivers also depend on the third and/or fourth requirements?
>
> IMHO fast free should be as much like normal as possible.
> Only things that would have a measurable impact on performance would help=
.
>
> The reason for the single mempool is mostly related to not requiring code
> that would walk a multi-segment mbuf to disperse the segments to potentia=
lly
> different pools.
>
> The reason for the refcnt =3D=3D 1 is that updating refcnt requires atomi=
c
> operations which need to read-modify-write on memory (not just cache).
> And RMW operation can take several memory clock cycles.
>
