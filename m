Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EDBD6E2CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Dec 2025 18:27:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 115DE40275;
	Thu, 18 Dec 2025 19:27:20 +0100 (CET)
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com
 [74.125.224.44]) by mails.dpdk.org (Postfix) with ESMTP id 38B344026A
 for <dev@dpdk.org>; Thu, 18 Dec 2025 19:27:19 +0100 (CET)
Received: by mail-yx1-f44.google.com with SMTP id
 956f58d0204a3-64475c16a11so1089835d50.1
 for <dev@dpdk.org>; Thu, 18 Dec 2025 10:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766082438; x=1766687238; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bvSpzWsL7XDfsGotmpvocKe17WaHm7tjWKjTlpRDKoY=;
 b=at8oTTfCyNPgVyNNjNJT87iEXSTeuefhflA8LfZJuNa7G2bOzaMxo1wQ0EO1j8Rihv
 Hd7nM4/5bnLWHKxsgP2tJMcTy+a7vcNshacjb8TuBohVFDNCiFMPaAs6RD7Nqm6H7pZB
 ttR2Vj6QJiAI0C16HfrToz+LBo0gvM1Ox58LcJQ0HZ8xIQz4ksYeIPj3wURiecPkFLi0
 lHrVPqKZ1F0uXofQmBrqX1JWPEevEWxAlw4gXW0DVNabkXS3kSyFTPan1+cbO/LrsFnH
 r5RNydXc+nBu2pRuVBXUok0YVUspFYvaohsT7GEPgGwmZFTm6hOct9tsGWtMKV5TBd7+
 x6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766082438; x=1766687238;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bvSpzWsL7XDfsGotmpvocKe17WaHm7tjWKjTlpRDKoY=;
 b=o6VszHE4YCVJURVjxNwxTnr0RYhVjYMzWvBKdTkfwyASyeBOS9pDPLgvL1Q1la+bL4
 LxOR3Y7RK1IPpMcG4pEbHVmDYBHrP4d3hf7O/W9sdMSUPlxj5jAYAVf4ML4HN2OMtHQH
 C1FDrkD6MAej0vr48JdmZj+wnEATzH3YFUkhiiRLSPSBo1hY7UNlGjhT9IFfoeVBPT5z
 fMn6qts3gNrXIjLGUmzHWVxNHSf00+2iEfrRCr0OF+NMYzuP2rf0bMDLwbK2pMCP3LQL
 wJWStMgQP/vvVb2Rsz2rfSlBbexTe/MjUWImv6QKsr8292uyJnnY65Nl7Alnzff9bwSk
 sfgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL/yxHR+WMd5H8+w870XTaQ4SGO88lfl8In1ONzjyDA/E74njtdvWqnuHeitu96e6F56I=@dpdk.org
X-Gm-Message-State: AOJu0YxlQzviA8f5vNW82cvzlz/Vavc1qnByaw/bxF/LVoX0W9gTsMJV
 TM74sdNwAx0TuYw/5w7hczyCOskCafoN8CjNkbE38g01ZxaqJomoxG1ZReKYOxXuuEm9Kfsbnd7
 FkvadoL9q4bBU80Sb9n+qZ+VIznCAEgg=
X-Gm-Gg: AY/fxX78PLERhecWndxKWQJWReYCXU1Eog6DE9PHcAeHv9NyAkBhjzJ35punNem0Erc
 XD7Gbt9LIFdIW1FEJWhZeb4IqNQttuXv8oBR9XHdQ74DWFCcBC/8KDS0qVoeukJ4q0CNgm1xUO5
 BASvTh7w9RybeP5HUxz8wRGG+TzH8UWXBIccL2iSq6Ni2buzCVLT8UB3/YFc5isgsZMe8HwO3po
 JnMCAHcf0+pQZcCQEJpnEt08/B7cJubPxtgyzobt1DwwpMFk6v4bIRH/zcDwYRkaYwdl6qNnwPU
 /zPGz2jmawk7FmQK/6T8YdTNxspP9A==
X-Google-Smtp-Source: AGHT+IFkiYYWQp3T+jc0vb9+FWYtjIf2BmcXqngL+0y+BXbfagPwjsPQE3274sgZaNWCf/+HTuObjM9/VqDXA4mvW/o=
X-Received: by 2002:a05:690e:bcc:b0:644:71f7:a9ee with SMTP id
 956f58d0204a3-6466a8ec1fdmr193795d50.97.1766082437916; Thu, 18 Dec 2025
 10:27:17 -0800 (PST)
MIME-Version: 1.0
References: <20251204005603.3236032-1-luca.boccassi@gmail.com>
 <18458ac8-1c0d-4bc9-bf4b-97ee06c1eef0@nvidia.com>
In-Reply-To: <18458ac8-1c0d-4bc9-bf4b-97ee06c1eef0@nvidia.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Thu, 18 Dec 2025 18:27:06 +0000
X-Gm-Features: AQt7F2pzh52XpnyvxeBsJiNRueIHDHncQGG9MsbxdkkVlvQD52Obkg-UArKLKgc
Message-ID: <CAMw=ZnRXeX+UxekNOFtkeTbWYyBm-WosWqOi3MtkQ+4Ot3mFpg@mail.gmail.com>
Subject: Re: 22.11.11 patches review and test
To: Ali Alnubani <alialnu@nvidia.com>
Cc: stable@dpdk.org, dev@dpdk.org, 
 Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 David Christensen <drc@linux.vnet.ibm.com>, 
 Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>, 
 Jerin Jacob <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>, 
 Ju-Hyoung Lee <juhlee@microsoft.com>, Kevin Traynor <ktraynor@redhat.com>, 
 Pei Zhang <pezhang@redhat.com>, Raslan Darawsheh <rasland@nvidia.com>, 
 Thomas Monjalon <thomas@monjalon.net>, Yanghang Liu <yanghliu@redhat.com>,
 sbadawi@nvidia.com, waela@nvidia.com
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

On Thu, 18 Dec 2025 at 18:24, Ali Alnubani <alialnu@nvidia.com> wrote:
>
> On 12/4/25 2:56 AM, luca.boccassi@gmail.com wrote:
>
> > Hi all,
> >
> > Here is a list of patches targeted for stable release 22.11.11.
> >
> > The planned date for the final release is December 18th.
> >
> > Please help with testing and validation of your use cases and report
> > any issues/results with reply-all to this mail. For the final release
> > the fixes and reported validations will be added to the release notes.
> >
> > A release candidate tarball can be found at:
> >
> >      https://dpdk.org/browse/dpdk-stable/tag/?id=v22.11.11-rc1
> >
> > These patches are located at branch 22.11 of dpdk-stable repo:
> >      https://dpdk.org/browse/dpdk-stable/
> >
> > Thanks.
> >
> > Luca Boccassi
>
> Hello,
>
> We ran the following functional tests with Nvidia hardware on v22.11.11-rc1:
> - Basic functionality:
>    Send and receive multiple types of traffic.
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
> Functional tests ran on ConnectX-6 Dx (OS: Ubuntu 22.04 | Driver:
> MLNX_OFED_LINUX-5.8-7.0.6.1 | Firmware: 22.35.8002).
>
> An engineer from my team reported 2 issues:
>
> https://bugs.dpdk.org/show_bug.cgi?id=1851
> Did not reproduce in 22.11.10, git-bisect points to 58a6421bc396
> ("net/mlx5: fix multicast")..

Thanks, are you planning to send a fix, or should I just revert that commit?

> https://bugs.dpdk.org/show_bug.cgi?id=1852
> Reproduces on v22.11.10.

Given it's not new, unless someone can send a patch to fix it, I'll
leave it as-is
