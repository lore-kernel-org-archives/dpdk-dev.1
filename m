Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEB2C98304
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 15:44:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE9C442EED;
	Wed, 23 Sep 2026 17:44:10 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id D505A42E81
 for <dev@dpdk.org>; Wed, 23 Sep 2026 17:44:09 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2d747eefae4so3226265ad.0
 for <dev@dpdk.org>; Wed, 23 Sep 2026 08:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790178249;
 x=1790783049; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LG2bBdV9rVD9PCOCRCgqia4G8ps9RV7+zDxLV+fTC6o=;
 b=OfSgUTprkusdpnOKWoB/fuS1SgZyH5yfm/EtwzSIp1IVZYJ9+eIOFxKrZTO+kmqgKQ
 Ci9Ih8Ck5ggZ5Uz14tU13DkG0KDanTiJCDI/LrpeY2DrTz6sf3vKXvUvDjbEvOPXwIkx
 edZ0BcUNh//fTviBMPnDgAdZbLDXmIFEcOrPseVmfw1RK+vhBXp4PtvjevjPfDR/Cx8H
 Y2gXJDLvWxHYHh6DfoEp6+FnxBlmIYUXr7ucPuLnLsvzG+pmkXp4LdvdXpimptqynHEm
 VKaUo07wQVdXeWqQci/UBSdCmIyXIS0iOTK5wFLUtz7tkLxslPQRIYvEqDQVNnjGZj5f
 QOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790178249; x=1790783049;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LG2bBdV9rVD9PCOCRCgqia4G8ps9RV7+zDxLV+fTC6o=;
 b=rXNjtfFl2khq7ElY4w2s/oe6B8tlE6UQGqRf86hhBRhquOfoaFq0hifNh+0i0Wyb8L
 MsySjAjbJ4WJBZeONUbq5irdSyc74O/iBuUhoxpaKVFauxZmGoruont6L0bGkocf9+uq
 C35Ld9ahqUJERmXkvD1nSFTCMSlNIFD7BXd4+OYX6ADLM4UuTHM68urmnoSVetuKpZ//
 O8eSGMpX3sRfKd4MLDbij6p4inCoh6aFb2xudJIU1Nq9pQxCvjKUFIrMxm4Y6NjM8Dw5
 rxtcwnsA0o0eXfnoBkFpMklbZRkUoFa5n1MiLSYBrH+hC9bwDMLeciEgmrcwtKBcYDSk
 G39w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwU2zMFZZZ+n0cBWWxl+zjD7X/t37ZD6z03EKe4BGKODGs981N/WIdUDeXM/7e0rDYrmVM=@dpdk.org
X-Gm-Message-State: AFuF++lZ14KoxJhnPAAyUw/UEkrkbgJ+19JdorBtSZTi7QaZV+9YtCI5
 PYmiuIg85Spew5fXiMttdeHzcOvpMtfjUmPKWHs7IOXbCVA3di2iTqRu4BaV+WrjcBw=
X-Gm-Gg: AYBFou2mUi6bS6uFvdbap1/3n2Ne6vQ5f5N91fK5iAr16jCpmdaHjRwWSInwNtbeGJs
 iBxJ8y2jRlB8aIRtGFLSbK/Mgebv4ginxw7a+MEDR9GfPUchshZFt+i7e7deC3yd2RY9Gn4znH8
 EKL7g/yTuz3buD4cjBGxajbCMMlYsxJ4PCNWk/T2gsn7LHjZIPODMb/5abhnE+qgPmi34H0r8dq
 bbJgf44Kht3+0/uNfrSifJBJFD/pGKMxnj+CnPLYTJoB9aif5QNU6Q9bcw6dJT9fEyLf9cGhz/g
 onMFfsg+1LnEs0qNAXTRKmi3ZRRRD5d+lY8qOEz8d+EOtXvj3zgUAmRLPHWdkSU3D43clrp5aE/
 TBzTCPAeJzhesWAtuzhGEJw9s5ljK/uzfRonlcmQwNLcQ5L0O0XWJzymyG99U3TgMpu3CiRwmWB
 8U6TRSxocsAgY5kos/Q058/5NDQmhuU4HbYQnTs5OZRDshmXoOL4M64/OZQXd3mgI5LlO1BXDvK
 aaVtR08WAnLnNJCW436knB3q+5QjWqdIq7GeSN/
X-Received: by 2002:a17:903:19cb:b0:2dd:c100:2515 with SMTP id
 d9443c01a7336-2df699c8dffmr20541775ad.30.1790178248551; 
 Wed, 23 Sep 2026 08:44:08 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df6a5c0ce4sm13164835ad.34.2026.09.23.08.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 08:44:08 -0700 (PDT)
Date: Wed, 23 Sep 2026 08:44:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Raslan Darawsheh <rasland@nvidia.com>
Cc: David Marchand <david.marchand@redhat.com>, dev@dpdk.org,
 stable@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav
 Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Adrien Mazarguil <adrien.mazarguil@6wind.com>, Nelio
 Laranjeiro <nelio.laranjeiro@6wind.com>
Subject: Re: [PATCH 1/2] net/mlx5: fix promiscuous inconsistency on port start
Message-ID: <20260923084405.6f0123c2@phoenix.local>
In-Reply-To: <4deac670-704e-4529-8b15-2289ec77616a@nvidia.com>
References: <20260731092332.3833632-1-david.marchand@redhat.com>
 <4deac670-704e-4529-8b15-2289ec77616a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Mon, 31 Aug 2026 18:40:48 +0300
Raslan Darawsheh <rasland@nvidia.com> wrote:

> Hi,
>=20
>=20
> On 31/07/2026 12:23 PM, David Marchand wrote:
> > The kernel netdev promiscuous or all multicast mode could be enabled
> > before DPDK starts the port. This would cause an inconsistency between
> > the kernel state and DPDK's expected state
> > (dev->data->promiscuous / dev->data->all_multicast).
> >=20
> > Add mlx5_os_get_promisc() and mlx5_os_get_allmulti() to query the
> > current kernel state via netlink. On port start, compare the kernel
> > state with DPDK's state and sync if they differ.
> >=20
> > On Windows, these getters always return false as there seems to be no
> > API for getting the states.
> >=20
> > Fixes: dd4bb90bc3cb ("net/mlx5: use Netlink to enable promisc/allmulti =
mode")
> > Cc: stable@dpdk.org
> >=20
> > Signed-off-by: David Marchand <david.marchand@redhat.com> =20
>=20
> Series applied to next-net-mlx,
>=20
> Kindest regards
> Raslan Darawsheh
>=20

AI review found that there is potential issue if tcpdump is used on kernel =
side.

  963565124c reset promiscuous modes on close =E2=80=94 behaviorally delibe=
rate, but the
  condition is kernel state only, not "did DPDK set this." If an operator h=
ad
  promiscuous mode on independently (tcpdump, a bridge port), closing a DPD=
K port
  clears it and disrupts that unrelated user. Kernel promiscuity is refcoun=
ted
  internally, but a netlink flag-set overrides that accounting rather than
  decrementing it. Scoping to modes DPDK actually enabled would be safer.
