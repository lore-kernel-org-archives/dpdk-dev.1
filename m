Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263ACEFCD6E
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 09:45:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B0F440281;
	Mon,  9 Mar 2026 10:45:44 +0100 (CET)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46]) by mails.dpdk.org (Postfix) with ESMTP id 84CFE40261
 for <dev@dpdk.org>; Mon,  9 Mar 2026 10:45:42 +0100 (CET)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-89a06bc2f1bso128441376d6.1
 for <dev@dpdk.org>; Mon, 09 Mar 2026 02:45:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773049542; cv=none;
 d=google.com; s=arc-20240605;
 b=j5MSHQkIYZHjBaSzBA0fAnSCwBzroXWvTEvAKHONELdmga323qak5QHntel/4AqErp
 1GBvdQhcb29W5xSQN6rjU9YVFPktnGwrTYI0IrrFGMOpZn7zWgNSA0yZL2jpS5S3gh79
 KVQ1ASJgj8djLk9qzzKL5eAsY4VJxm2hb1pR6KRpdHyLbtG04Ge3nDnWoUL7aj30R9Cu
 BJeIAZ69M9hquMC7x+7CL7dAS+EAkn0gZF8MTv8WPvKJXjnof1QKA93YeyND4gSiE+uq
 CAK/BvI9ouGX29ObLhoiq7ekEW1IqBRw4DyxxZ4MLKmSVBbuZ6Al/GwXzZ/ER+IcmNgm
 hhKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=3SyijclXnVhJLoJx+FzFJfif4A/6cDNnsvdSHNr3ebA=;
 fh=qVLawbezbQx869rS9hY5B0gNyTG5R8T8F8FcHRK09rA=;
 b=Vdfl2QIdj/XCSozHiJqbbvY0DeJWWC3WLH1piTBK+JKeL8szfA5+WcLGItz81hkVZh
 /lYEtSc0e9oFRUuxnWbvQVyg6ErKterMlDmfJGqXgqY/EJGJ+BVV4MmOd3uHgUtF2ffi
 Y2l4hpq0rRPz86PBqf16Het099esdJ7ZptAtjeCMdPqGM81j+UGB0c0fDz94/JiXLeo+
 dIx/vt/xr0ZT+dxzMfvyZ1qb+2eP+CM917/7XKMECWUYZbeToTbyPBlV9l8UW40jfekp
 4bncn2XTwLDZdmbOxkQPbK8H47F84xYaHs0Zy0HCncUY4oTAu2xcSDU1NTxqeCnqve0Z
 Hppw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773049542; x=1773654342;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3SyijclXnVhJLoJx+FzFJfif4A/6cDNnsvdSHNr3ebA=;
 b=rYJFIhiPpdZTQS54uTKylbcuBQXo6qZBp4t83ntAzxtTDUYBHuXhYewj+BOIKwoJfP
 +uE6aJ+m+WZHwL5ZsIIq3H1ZbuH1aLHmwfO6A625PJFJ8m63Yqm9ryVLYuHnvOPUkMNG
 C7grFTPoy+rT9rciaEcH9EEOZirL6Vq8hDTrhLTZu3Xq7l4uKuuuv16cfVWcW3Hqj47+
 /ym/KyTI/WEece/v6guMSCOAUT/Y83vAnoxbU5Nm7BXs0b6fpJuOSpNTbZUfUpgC3lVI
 aZDsAoe9n/MBZ0BOIO4TdXEPSK98En3/YslNQSpX/X/fp2Lvv1XzwQKkRDLhwrlw/iUC
 z7Yg==
X-Gm-Message-State: AOJu0YyiaEYmdwtSHStd/bNoAj0QVOI5eq8UgkP+J58ubZgCHcexwdVT
 RjwaQKMry6unui3p9qAnO7Whq08sGl1VdnnLnLqC69x/yX61fw3/NtAJ+0hHyWbu/I9V//biVds
 01Sr08Ky/gkUhgI77bG0OEaje6WDWE44=
X-Gm-Gg: ATEYQzyK3ZHLt5eCLDsq9wwDxB3P7Krok/Bil1NCu2pScaaLzNzYTYQDIXdSwypYHJw
 l0aReeHXZEnuspUDe+0Nzi1f2Uo9TTnJk48GofCpoPYbaahbTq4SlYxXiDLYaHhknuRWW/GzSar
 QKAeI10WEgUFe1Gu0VMtAcDS7daYxf2F5+gzKRGFrV/EjP3+3p2j5W9oB83Jkv27lB1NqQU+wit
 Z790bNZSRnM/WX9LWA/m1slX9BaytemkNv8f+2vW6jR0GwmzDKnvb2qYPz6mdOZOKZsdkecanE7
 9NvQmTPb2h79fVsdniSg+LoXFqdBwIlonWSedw==
X-Received: by 2002:a05:6214:f0e:b0:899:ea7c:4d84 with SMTP id
 6a1803df08f44-89a30afb3b6mr163011736d6.60.1773049541815; Mon, 09 Mar 2026
 02:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260226143341.282188-1-maxime@leroys.fr>
 <20260306133035.179709-1-maxime@leroys.fr>
 <20260306105112.46d8d0c2@phoenix.local>
In-Reply-To: <20260306105112.46d8d0c2@phoenix.local>
From: Maxime Leroy <maxime@leroys.fr>
Date: Mon, 9 Mar 2026 10:45:30 +0100
X-Gm-Features: AaiRm50dkkZ_mi2VVfvgYiKMK3JHqcJlRmgswfpZHmCiVdtmi8ME6fyl2vPmIRc
Message-ID: <CAHHRULUkhOg0m7H496aiQ8hnC6PfbLw5xZSDpHfRX2Tsmrqf4w@mail.gmail.com>
Subject: Re: [PATCH v3 00/17] net/dpaa2: fixes and improvements
To: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: dev@dpdk.org, david.marchand@redhat.com, 
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

Le ven. 6 mars 2026 =C3=A0 19:51, Stephen Hemminger
<stephen@networkplumber.org> a =C3=A9crit :
>
> On Fri,  6 Mar 2026 14:30:18 +0100
> Maxime Leroy <maxime@leroys.fr> wrote:
>
> > Various fixes and improvements for the dpaa2 net driver and fslmc bus.
> >
> > Patches 1-6 fix resource leaks on port close, error paths, link status
> > and devargs propagation on hotplug.
> >
> > Patches 7-14 fix additional bugs: spurious VLAN insertion, error packet
> > dump crash, packet type classification, checksum offload flags, softwar=
e
> > taildrop buffer access, burst mode info reporting, SG table walk bounds=
,
> > and MAC stats DMA allocation.
> >
> > Patch 15 is a minor cleanup in the link status area.
> >
> > Patches 16-17 add devargs alternatives for getenv-based configuration
> > of taildrop and data stashing options.
> >
> > Changes since v2:
> > - Fix checkpatch warnings: short SHA in Fixes tag (patch 14),
> >   long line in commit message (patch 10)
> > - Fix check-git-log warnings: shorten headlines (patches 3, 9, 12, 14),
> >   fix tag order Fixes/Cc (patches 10, 11), fix wrong Fixes reference
> >   (patch 8), remove colon after function name in commit body (patch 8),
> >   lowercase macro name in headline (patch 15)
> >
> > Changes since v1:
> > - Add Cc: stable@dpdk.org on patches with Fixes: tags (Stephen)
> > - Reorder series: fixes first, then improvements (Stephen)
> > - Patch 2: squash with former patch 4 (Hemant)
> > - Patch 6: move devargs refresh from plug to scan rescan path (David)
> > - Patch 17: keep getenv for backward compatibility, add devargs as
> >   alternative instead of replacement
> > - Drop former patch 11 (bus/fslmc: remove dead blocklist check) to
> >   avoid disaligning with other buses (David)
> > - New patches 8, 11-14 fixing issues reported by Stephen
> > - New patches 7, 9-10 fixing VLAN insertion and packet classification
> >   issues
> >
> > Maxime Leroy (17):
> >   net/dpaa2: fix queue block memory leak on port close
> >   net/dpaa2: fix Rx error queue memory leaks
> >   net/dpaa2: warn on Rx descriptor limit in high perf mode
> >   net/dpaa2: fix resource leak on softparser failure
> >   net/dpaa2: fix link not up after port stop/start
> >   bus/fslmc: fix devargs not propagated on hotplug
> >   net/dpaa2: fix spurious VLAN insertion on non-VLAN packets
> >   net/dpaa2: fix error packet dump crash and memory leak
> >   net/dpaa2: fix L4 packet type in slow parse path
> >   net/dpaa2: fix L3/L4 checksum offload flags
> >   net/dpaa2: fix software taildrop buffer access
> >   net/dpaa2: fix burst mode info report
> >   net/dpaa2: add SG table walk upper bound in Rx path
> >   net/dpaa2: fix MAC stats DMA alloc per xstats call
> >   net/dpaa2: use check interval macro in link down path
> >   net/dpaa2: add devargs to disable Rx taildrop
> >   net/dpaa2: add devargs alternative for data stashing getenv
> >
> >  drivers/bus/fslmc/fslmc_bus.c           |   4 +
> >  drivers/bus/fslmc/portal/dpaa2_hw_pvt.h |  16 +-
> >  drivers/net/dpaa2/dpaa2_ethdev.c        | 211 ++++++++++++------------
> >  drivers/net/dpaa2/dpaa2_ethdev.h        |   3 +
> >  drivers/net/dpaa2/dpaa2_rxtx.c          |  85 +++++-----
> >  drivers/net/dpaa2/mc/fsl_dpni.h         |   6 +
> >  6 files changed, 164 insertions(+), 161 deletions(-)
> >
>
> Applied to next-net, minor edits to first commit message to fix
> the reference commit; problem reported by checkpatches

Hi Stephen,

Thanks for the merge. However, I was not expecting the series to be
merged without an ACK from NXP maintainers.
Many of the issues were found through code review only and marked as
=E2=80=9Cnot tested=E2=80=9D, with only minimal runtime checks on my side. =
I would
feel more comfortable with an ACK from NXP.

Hemant, could you please take a look at the series when you have a chance?

Thanks,

Maxime
