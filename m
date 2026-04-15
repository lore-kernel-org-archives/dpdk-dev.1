Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF3BF43825
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Apr 2026 14:18:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE6DB402F0;
	Wed, 15 Apr 2026 16:18:16 +0200 (CEST)
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com
 [74.125.224.44]) by mails.dpdk.org (Postfix) with ESMTP id 8EF9E402E1
 for <dev@dpdk.org>; Wed, 15 Apr 2026 16:18:15 +0200 (CEST)
Received: by mail-yx1-f44.google.com with SMTP id
 956f58d0204a3-64e87a81639so6301781d50.0
 for <dev@dpdk.org>; Wed, 15 Apr 2026 07:18:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776262695; cv=none;
 d=google.com; s=arc-20240605;
 b=PM1ujv8KhDdCpJDqag4YqSzzBlNx0u/uE6QfzKcjEz6SExqK5JQewJM02Sjvx3yeCX
 562Sc1eO9BnbojPhdNJM0LvorLIY9KX4JHeVZ+FT3U4DZxWEraPZlYDk98Y4zt+ETTgv
 9jK5JgwlrSGV89MDTx5hzLqN46Gkvi/Ly3yK2Xx2iaYnVxhntSyCl3HjQ9X6ZPl27x8H
 LvB9l1CrU3qjJx/uhHVXfA0z/33iydudXPKaZTcKcuhdXHR5gYRghuUOT0MXt53Oe+X4
 WdU9iuW1VGPQnYcnCREGwBPaL8QaYSiSX7WLCVStSpd4fjjSuxmvi+O+Uel2M8x9izaS
 KbZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=faHnVO2JcjW6KpEsplMzI5dtesdJzTD0TAzqziMjeNA=;
 fh=Va0OzcunXq0lgeATQStsYJiqBEu6HXe1LCGPq65d/Gs=;
 b=DV0Tsa/Kbz/kD7AK6TVCf18mV3lcOUoFdt+iU1UUowwuYHPdcvR/TuL0+CnjrPgaWY
 /FiULd/d21mfWbmoo+Iqw642xnhqw1DxeKxBDH/Z0BYfrVStFHUd75n5tJ6gCsuuGcAE
 IJay43N7rKgvVmjeJ2ruV+LtpvSQSmr6nlvQuEcwTYQ+d9cxg8HFU8PiznGAxU+BJWV2
 U2JoXU0MPd1a2cN7ClZSje5PRbq4A1zZyzdYzWYXm9rkeX2PSqSQ165j+JE8HS4o1zQK
 +o1t5ykolCGphZsSvo92DWWh2ZekaaPWE8PeTHl5l/kT7qiRVsC53QfL7yUKA2QUmeHr
 azhg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776262695; x=1776867495; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=faHnVO2JcjW6KpEsplMzI5dtesdJzTD0TAzqziMjeNA=;
 b=JyhdzEnCw0JfKvrLppuMnM0DN6PvnwalIUOOjlHxAqDMwl+am+pSFY5x32aSmGT9JB
 Hl2Cv7cKtQRqL7r3O0mffVfR1bYS7FzUqe1E4Vrc6qsuJG/8xRrlRwRLlC3ah6ZPx2XQ
 4wtD6E+UgJwZkscRh5qLaJsu4xhdjXs+jH1S7m+mhrw6eXrnC8OgXlL8ld3jdYW2A+9c
 lltDhNAlTXQFhjDio4bkySL9aNTaack1IoljpE8Sv3e3BIERpueJhr5MSMRCLIYzO7WU
 tcLHKuYy+yKCrX3e2K6JCNIPr+ukMBkThtRUlMTM7GHIJf/yH7fk0qL9Ap41wcutVCkG
 N4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776262695; x=1776867495;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=faHnVO2JcjW6KpEsplMzI5dtesdJzTD0TAzqziMjeNA=;
 b=Hxi5mwjLr+JVuTPgK6czlup9T3ScOqLlB7F273B5F2/PuAKe1gW9D8U5LjSJtxgfqk
 sY7jIdfhM81p/7C2uT4wXZTb1+YnrZder0aKT5pVdKuttBCBQCnbLvzQNGNJR/O8QsCB
 IKFvFcF5eVC1kM7o+8I1FFz7KR4rzzL8WZHCw1BWx1VucjLyE29xOhkctO1pkTVr55yl
 XRz49j4HvZYDpIMiIOAW+xqww5pwxh3grkLAJDyQcGVC7kXdc5DufirPr1orJ0jWOEc5
 9DBKCVEzwo8B1qK9seawndX3BsoMGww4K3uZuVqB0aKxqUwnBMky6752MdKFeV7dTgeg
 oeYA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8KCrtIi3cgFtMW56dNYoqHPTu1+iuF0nvGiG/Gkur52ropryGVv51P3mHJ9b3ETfT/eGg=@dpdk.org
X-Gm-Message-State: AOJu0Yz4fUbW1EuvmKFPdoTEKBmHCR+Iia4aaJfDv8jtPOaIPQduchlC
 jv/aoRtHa1BoZ1xa922FPuHY3b7YcUyGlBgFW+6kXcURhmn7xVg/ka27jkAvQBcqQ+tt8QBdtLW
 pKis7NnACaR4lFgmMfTvw+B8EZC2CzGj5Xg==
X-Gm-Gg: AeBDieuYRDXGYPW4BfjRL6bCq/mGy5JvUVs9rN6HbJntHmHc33DH4QCeNDislfASuxR
 9QexpCMAByHdCjGkwLtQiN+XWWautiYtWbL5x8tX5bU7K83EukMXXC2uMNiCDlvuM+8/6HYySq1
 QCkhdun4a5fXHBZqNcP4MCT75naUcqmULOOHdVjwhSVKvwTtsdwkWkKQ+i4MSlk5B0yA2wxGgP9
 uymADBlTASuYnp14yfirURyIZ104iZj9BQxTlqlTSQ2oWMKg3I5Qz4basWUrtCVQ/ACupLtAV0I
 RySOJOHJHhK/C4dR42tgNFlo0mhT2ks8wWGde0ubKw==
X-Received: by 2002:a05:690e:11c9:b0:651:d179:d316 with SMTP id
 956f58d0204a3-651d179d3d6mr10283033d50.21.1776262694558; Wed, 15 Apr 2026
 07:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260404095902.856502-1-luca.boccassi@gmail.com>
 <DS4PPF00BBED10CD8DA7B76160DFF4558979F222@DS4PPF00BBED10C.namprd11.prod.outlook.com>
In-Reply-To: <DS4PPF00BBED10CD8DA7B76160DFF4558979F222@DS4PPF00BBED10C.namprd11.prod.outlook.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Wed, 15 Apr 2026 15:18:03 +0100
X-Gm-Features: AQROBzDhwisaqQrvGnpaqtu_FBhVKbFSmo3Euusd4E8vVMs8dJYf2l1bBKmi2qg
Message-ID: <CAMw=ZnRjy5aTX2jD0hYpDdebJorrUVzLsXRy4s1ikG77arpPyA@mail.gmail.com>
Subject: Re: 24.11.5 patches review and test
To: "Xu, HailinX" <hailinx.xu@intel.com>
Cc: "stable@dpdk.org" <stable@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>, 
 "Mcnamara, John" <john.mcnamara@intel.com>
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

On Wed, 15 Apr 2026 at 02:24, Xu, HailinX <hailinx.xu@intel.com> wrote:
>
> > -----Original Message-----
> > From: luca.boccassi@gmail.com <luca.boccassi@gmail.com>
> > Sent: Saturday, April 4, 2026 5:59 PM
> > To: stable@dpdk.org
> > Cc: dev@dpdk.org; Abhishek Marathe <Abhishek.Marathe@microsoft.com>;
> > Ali Alnubani <alialnu@nvidia.com>; David Christensen
> > <drc@linux.vnet.ibm.com>; Hemant Agrawal <hemant.agrawal@nxp.com>;
> > Ian Stokes <ian.stokes@intel.com>; Jerin Jacob <jerinj@marvell.com>;
> > Mcnamara, John <john.mcnamara@intel.com>; Ju-Hyoung Lee
> > <juhlee@microsoft.com>; Kevin Traynor <ktraynor@redhat.com>; Luca
> > Boccassi <bluca@debian.org>; Pei Zhang <pezhang@redhat.com>; Raslan
> > Darawsheh <rasland@nvidia.com>; Thomas Monjalon
> > <thomas@monjalon.net>; Yanghang Liu <yanghliu@redhat.com>
> > Subject: 24.11.5 patches review and test
> >
> > Hi all,
> >
> > Here is a list of patches targeted for stable release 24.11.5.
> >
> > The planned date for the final release is April 16th.
> >
> > Please help with testing and validation of your use cases and report any
> > issues/results with reply-all to this mail. For the final release the fixes and
> > reported validations will be added to the release notes.
> >
> > A release candidate tarball can be found at:
> >
> >     https://dpdk.org/browse/dpdk-stable/tag/?id=v24.11.5-rc1
> >
> > These patches are located at branch 24.11 of dpdk-stable repo:
> >     https://dpdk.org/browse/dpdk-stable/
> >
> > Thanks.
> >
> > Luca Boccassi
> >
> > ---
> Update the test status for Intel part. dpdk24.11.5-rc1 all validation test done. found two new issues.
>
> * Build & CFLAG compile: cover the build test with latest GCC/Clang version on the following OS(all passed)
>   - Ubuntu25.04/Ubuntu24.04.3
>   - RHEL9.6/RHEL10
>   - Fedora42
>   - FreeBSD14.3
>   - SUSE15.6
>   - OpenAnolis8.10
>   - OpenEuler24.04-SP2
>   - AzureLinux3.0
>
> * Function tests: All test done and passed
>   - i40E-(XXV710, X722) PF/VF: test scenarios including basic/RTE_FLOW/TSO/Jumboframe/checksum offload/mac_filter/VLAN/VXLAN/RSS, etc.
>   - IXGBE-(E610) PF/VF: test scenarios including basic/RTE_FLOW/TSO/Jumboframe/checksum offload/mac_filter/VLAN/VXLAN/RSS, etc.
>   - ICE-(E810, E2100) PF/VF: test scenarios including basic/Switch/Package Management/Flow Director/Advanced Tx/Advanced RSS/ACL/DCF/Flexible Descriptor, etc.
>   - IPsec: test scenarios including ipsec/ipsec-gw/ipsec library basic test - QAT&SW/FIB library, etc.
>   - Virtio: both function and performance test are covered. Such as PVP/Virtio_loopback/virtio-user loopback/virtio-net VM2VM perf testing/VMAWARE ESXI 8.0, etc.
>   - Cryptodev: test scenarios including Cryptodev API testing/CompressDev ISA-L/QAT/ZLIB PMD Testing/FIPS, etc.
>   - DLB: test scenarios including DLB2.0 and DLB2.5
>   - Other: test scenarios including AF_XDP, Power, CBDMA, DSA
>
> * Performance test: All test done and passed
>   - Thoughput Performance
>   - Cryptodev Latency
>   - PF/VF NIC single core
>   - XXV710/E810 NIC Performance

That's great, thank you
