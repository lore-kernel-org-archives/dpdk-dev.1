Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19638F428F5
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Apr 2026 21:01:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 024CC402ED;
	Wed, 15 Apr 2026 23:01:49 +0200 (CEST)
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com
 [74.125.224.46]) by mails.dpdk.org (Postfix) with ESMTP id 29CC5402EA
 for <dev@dpdk.org>; Wed, 15 Apr 2026 23:01:48 +0200 (CEST)
Received: by mail-yx1-f46.google.com with SMTP id
 956f58d0204a3-6501c9903edso8130449d50.1
 for <dev@dpdk.org>; Wed, 15 Apr 2026 14:01:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776286907; cv=none;
 d=google.com; s=arc-20240605;
 b=SXMy68GusoN7XRtStJ5P/e4zeemHxJ+RBGafL+2py63DS3GCFyLuM6ataqu0HI1xjk
 fTkb0sy/5EREpgfcRSyhV/N87b8IXF/gwuz0+4fADyGQskWuS+Ej2ePlFjgVV1M7IWvS
 qdVZzfVxbGpJiBS84jFzdMR6Gq3mpO0F4z07YXTQiXxjftBVqS6LOCkYaebeHWjQy1we
 1e2lHyRUZgv+1GzPN3QxVctGsZfefkXtawp9cD3ul6J84c51FT2RhcaMdn2MfOe7FR+J
 BtCaPyMIJZkmdiYMJkWMOLQxqaRTdvCQIDwH5Y8fjMqjtsCDFArrBQmw4TvORMWZX0C+
 4Dyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0B4zQjSoYkZeX5KYgkIEBSEGMdmeZfJrOh9DU5SiaHY=;
 fh=b444qT3A4A4Ay1O0PNmQXyBbmRmtJGAqapNMCIiq/AA=;
 b=bsFYbsC8fSPcDR3loc8BO9boVT52whZMRFg3N47JquwZJ7/kN1sEIhoca/rgxDZNpr
 Ti0J5Xr9zw0XT3/GEccgEXmgvlyqpopiCOBwlprRLvnyYlnG+AkfUZv33b0ypFK1GQao
 vypmk422a4Mxwzo0f0gobN66FP1BBsp/pehp2UCM/9X1I5GNAAnbashSnw43Hc1u7Lys
 Fj9k/R+UqMhgMJa9wx0898yb+451TUvegiVy2HbH04dIA9KJrvrEP//jbsYngPVreeI6
 ApAVwR0uADemXG6+cbdXC7s1DuBK/WqzPeo0O39yd+xoSeQfDeyMGynjaY3U8vLV9BUd
 7dvA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776286907; x=1776891707; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0B4zQjSoYkZeX5KYgkIEBSEGMdmeZfJrOh9DU5SiaHY=;
 b=CO0KO2fcaq6WvZAAehtIc0IVLiXtE+qCfEeVNflDyX2Z8Dag14XvGZz2dxcIBtXToL
 v//dDXAzw6evd6QgK7jtSQrlQuU1dZQ6SFrAb5OjXLeXHt7+flE0k51Y2AHdtt9mCR3l
 2LFUJ2f9F5c+quUbN1+7R/pNP61kQqTDcUCbtzrQS1k0FEqhwb7ePVXFbz/pi2dJdxSP
 zDUkaIgZeSHTwmG1U5Z2dfJW8K3ZUrUtlioMM6Hpnr2iXBlO7/6zQJUDkHQG4WaUozzr
 iBnV7tWZk4rT6UUJeymVwtoGepPay9FAIamrZURwgQUvZ8NtL9JgMLdz0eGrLnAznZgm
 JFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776286907; x=1776891707;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0B4zQjSoYkZeX5KYgkIEBSEGMdmeZfJrOh9DU5SiaHY=;
 b=rnc16hLWuf5qvCXp/aU2r5++MwKX4SAo4eY7pRosf0qkDKOCw69/ZqnAz3Vl0idF5d
 7JYV/RvR3ww5EzZaiSEW7ur2gUsrI+G+wCsJFWIPhDPk0wh0dAcVQV9PseXfNPF824rV
 Y+/VH00mJtqpPFtPaF6l/yc03z5uiuBFrSp4k6ZuEbehjdW9MgHIIsZn53HA+rGbQ8sv
 iKH/23VUqqm0Qxzivb8INXok+gvhjN/bCsH0bdu4X6J9Ob+NWLdBUhYF3alkNx8BTZO9
 9fm+FgesbJ5tVPG0sM56Na8b0RrqdxW7td+CJEoYJk363xNNFdrZsOVtYkhWfepKovea
 U3WQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/X948CDYBa5VnxRlo9CLgdmeWbw1qABhNzuyE6v0KLQkKXcOZmXeNUxIDBpajUz9t7prY=@dpdk.org
X-Gm-Message-State: AOJu0Yxqv5eyGvRlbZ2NZf7CvkE9WK1hc4YoC+pCj+pzvUIUCDN7+WPP
 jjciYpu4I+x3TNR3tFHGstyuniPyurO76KlmuARNMkoRDCC7+ESjYWEk/8aCuP/DJxC7Ac9j4f8
 DV2CQzpO7OKeWfU1qstG7gGm75Y4lmIs=
X-Gm-Gg: AeBDietFnP6Tp2Na6cxsmdOkCRA5mgYpJDIpmno1Lsovw/deNIH+Y3EKeBf6weocso/
 lCVMI8BppPoClrbY+dExohErICLzCGymrXuz6WWiMYDu9SFqd1EPAhaQoEuiL+7EBaK/WeTC3Us
 Oii1bZq9MXQOJTZPU+DbLIB18npTUtLoLMTzJoWtx/FTm+VvxV710VfWvT+qLdq7Qs81TOrCU6W
 GSj0GfHTsyqugsRzuwSjUGmk5/XSNAa5cygPNydgD/ACVyhr7xxTcKeu+M/rFDm3VZxUfGnHKxb
 h0uDwNvwq4liunG8Li7CxUCNs1Oc2EiSrL1Zw1hs
X-Received: by 2002:a53:d007:0:b0:651:c065:a261 with SMTP id
 956f58d0204a3-651c065decfmr13681646d50.57.1776286907232; Wed, 15 Apr 2026
 14:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260404095902.856502-1-luca.boccassi@gmail.com>
 <cf6b2387-dec2-46b7-a1e7-5e09c8b7bae7@nvidia.com>
In-Reply-To: <cf6b2387-dec2-46b7-a1e7-5e09c8b7bae7@nvidia.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Wed, 15 Apr 2026 22:01:35 +0100
X-Gm-Features: AQROBzCSjX3aClzwAMm6nd72gcFrVQFs1lwyTKZKCOiBDuR-5Sp39DmY0Yh9r3Q
Message-ID: <CAMw=ZnTXBoyTkkkOQN-qE0-SgkJaEaHg_RX-yCCEjzUfat3F2g@mail.gmail.com>
Subject: Re: 24.11.5 patches review and test
To: Ali Alnubani <alialnu@nvidia.com>
Cc: stable@dpdk.org, dev@dpdk.org, John McNamara <john.mcnamara@intel.com>, 
 Raslan Darawsheh <rasland@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>
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

On Wed, 15 Apr 2026 at 20:59, Ali Alnubani <alialnu@nvidia.com> wrote:
>
> On 4/4/26 12:58 PM, luca.boccassi@gmail.com wrote:
>
> > Hi all,
> >
> > Here is a list of patches targeted for stable release 24.11.5.
> >
> > The planned date for the final release is April 16th.
> >
> > Please help with testing and validation of your use cases and report
> > any issues/results with reply-all to this mail. For the final release
> > the fixes and reported validations will be added to the release notes.
> >
> > A release candidate tarball can be found at:
> >
> >      https://dpdk.org/browse/dpdk-stable/tag/?id=v24.11.5-rc1
> >
> > These patches are located at branch 24.11 of dpdk-stable repo:
> >      https://dpdk.org/browse/dpdk-stable/
> >
> > Thanks.
> >
> > Luca Boccassi
>
> Hello Luca,
>
> Apologies for the delayed report and thank you for your patience,
>
> We ran the following functional tests with Nvidia hardware on v24.11.5-rc1:
> - Basic functionality:
>     Send and receive multiple types of traffic.
> - testpmd xstats counter test.
> - testpmd timestamp test.
> - Changing/checking link status through testpmd.
> - rte_flow tests
> (https://doc.dpdk.org/guides/nics/mlx5.html#supported-hardware-offloads)
> - RSS tests.
> - VLAN filtering, stripping, and insertion tests.
> - Checksum and TSO tests.
> - ptype tests.
> - link_status_interrupt example application tests.
> - l3fwd-power example application tests.
> - Multi-process example applications tests.
> - Hardware LRO tests.
> - Buffer Split tests.
> - Tx scheduling tests.
>
> Functional tests ran on the following environments:
>
> - NIC: ConnectX-6 Dx / OS: Ubuntu 22.04 / Driver:
> MLNX_OFED_LINUX-24.10-4.1.4.0 / Firmware: 22.43.4100
> - NIC: ConnectX-7 / OS: Ubuntu 22.04 / Driver:
> MLNX_OFED_LINUX-24.10-4.1.4.0 / Firmware: 28.43.4100
> - DPU: BlueField-2 / DOCA SW version: 2.9.4 / Firmware: 24.43.4100
>
> We did not find issues caused by changes in this release.

That's great, thanks
