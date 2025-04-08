Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9EBC36010
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 18:39:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1ADAB402D1;
	Tue,  8 Apr 2025 20:39:18 +0200 (CEST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com
 [209.85.219.173])
 by mails.dpdk.org (Postfix) with ESMTP id A24BE40267;
 Tue,  8 Apr 2025 20:39:16 +0200 (CEST)
Received: by mail-yb1-f173.google.com with SMTP id
 3f1490d57ef6-e643f0933afso5760962276.1; 
 Tue, 08 Apr 2025 11:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744137556; x=1744742356; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZM3OO8GkW+118EcNcG9rAOePT1hq7xhOSS79t7MRnwA=;
 b=PCQkUk978X47ep1At7zSGaTKG9TiAwgG0bi7mkrORHW1AzyLfAgoKZSf1vo1UDl0Gv
 BJRntmKmQVsnEafbX5IaGv2f6feDS731LQW+F1o5ED41DNCTVfmjQQbTEuVapu51CcZv
 Ew+m71fcF0h5VPr9G2No/Q0uF0hgc+bBWEkerp77WVp8QSohj2P3IQ+Idebf4FxS7mFh
 Rf+pimXTHHU1JFQHTGNbtrinilhaUELru8mLDKKN5UmuQHin3ZEkZCDqC8M6VMvbr5Qg
 /sn2TFVHw5eE4kw6C2PACkZoKybFo0w4TMl8lMgd5A8ffjMy2LqxGFj0vx/gEBgz88sQ
 uoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744137556; x=1744742356;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZM3OO8GkW+118EcNcG9rAOePT1hq7xhOSS79t7MRnwA=;
 b=l73/vXusfn5ZBJNzuVgliFkQdOMDEdqLsY+aOwojzn/gi1nvt8gT55mZO2/2vurHnh
 jFRTFygotzw+WmJiCu3qBSPe71wU/yHH9M3ZDHfVK7i+eFiNe66s60IbIHSSgFfCcYCw
 L5Rz2vXw05w0bTmQ1p0fwNUbZ59ztUMobOAFWgMXYQeSbOTAMmJoIOVma1uHE1B7O/8M
 XCR25cr9f4K7UjMAHZwXyWdSB7tWaDKDDyNa1iHvcGpKiEm9oUx7agLlz7bDaDS0cJ19
 hO5CxC9Kw4gikQ7p6NzTknKPK5+TFOxAknUdNJlD+MPX/u+7sTgCTE88qAMz5i/Fp6eX
 BWBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmAJQEiKcuVMv9ZlaWeTgqtqizoHvHzxIrnJsE0u4Lut3G1xUdIGO/pY72Y7lo3ChPbKc=@dpdk.org
X-Gm-Message-State: AOJu0YzlxvdvcN8v8VZiRhL0kolko4Q8U6Hl5D4xOqioozPjGPVIdwpP
 6tplxYjEubnj6u9UEUWYjiGk9efjDb5CfaZoNVE6VnGdJq+spIBIdjR5/Bjmmrpc/ViFrnNfI0T
 u2fmP9Dqdh7c/WfnHUDUtQoAOtyg=
X-Gm-Gg: ASbGncvhmwa6Fq6ExN5fh9qxNKTl6D2E+/yg4P6zLpm9IMwBtmQZRXFgB6QAkWGRxmz
 N7EJNchMbb0uQZW1YnsVU3Y7i5NWxCZ0hKQo2EAiHSp/md7N4ZvWFEvIw1WnDo/iLWZw5ZypfCz
 UY5vg/lbXsuP1T5jFcZRpCdP6aF4dEko5OjvSpZNW0tEi33eHtmyT8JJ+vJMGhFndQ6jJLew==
X-Google-Smtp-Source: AGHT+IEuoiSmQeUDuj7QRnRhHtCwHgDhCALs7QUotXn4ZATy/TxQkLdWQHKWzjOlpe6Q5UIksPI8X5Mvv/nwM/tsJo8=
X-Received: by 2002:a05:6902:18c3:b0:e63:41cf:b600 with SMTP id
 3f1490d57ef6-e6e5daad5ebmr8561566276.24.1744137555910; Tue, 08 Apr 2025
 11:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250326115132.1444530-1-luca.boccassi@gmail.com>
 <PH7PR12MB91732CDFC77ADDF91DA22727DAB52@PH7PR12MB9173.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB91732CDFC77ADDF91DA22727DAB52@PH7PR12MB9173.namprd12.prod.outlook.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Tue, 8 Apr 2025 19:39:04 +0100
X-Gm-Features: ATxdqUFY3QTxUtFj_-fzI1sZpKCG6yYv16OriBm4CjhaFtzA-CJdSFiXvJb7KpM
Message-ID: <CAMw=ZnQOsoMjUqoWQ0Tx4QO-qwi+2Xc_+Teev1R=4GyWFdNjXg@mail.gmail.com>
Subject: Re: 22.11.8 patches review and test
To: Ali Alnubani <alialnu@nvidia.com>
Cc: "stable@dpdk.org" <stable@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>, 
 John McNamara <john.mcnamara@intel.com>, Raslan Darawsheh <rasland@nvidia.com>,
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>
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

On Tue, 8 Apr 2025 at 19:31, Ali Alnubani <alialnu@nvidia.com> wrote:
>
> > -----Original Message-----
> > From: luca.boccassi@gmail.com <luca.boccassi@gmail.com>
> > Sent: Wednesday, March 26, 2025 1:51 PM
> > To: stable@dpdk.org
> > Cc: dev@dpdk.org; Ali Alnubani <alialnu@nvidia.com>; David Christensen
> > <drc@linux.vnet.ibm.com>; Hemant Agrawal <hemant.agrawal@nxp.com>; Ian
> > Stokes <ian.stokes@intel.com>; Jerin Jacob <jerinj@marvell.com>; John
> > McNamara <john.mcnamara@intel.com>; Kevin Traynor
> > <ktraynor@redhat.com>; Luca Boccassi <bluca@debian.org>; Pei Zhang
> > <pezhang@redhat.com>; Raslan Darawsheh <rasland@nvidia.com>; NBU-
> > Contact-Thomas Monjalon (EXTERNAL) <thomas@monjalon.net>; Yanghang Liu
> > <yanghliu@redhat.com>
> > Subject: 22.11.8 patches review and test
> >
> > Hi all,
> >
> > Here is a list of patches targeted for stable release 22.11.8.
> >
> > The planned date for the final release is 2025/04/10.
> >
> > Please help with testing and validation of your use cases and report
> > any issues/results with reply-all to this mail. For the final release
> > the fixes and reported validations will be added to the release notes.
> >
> > A release candidate tarball can be found at:
> >
> >     https://dpdk.org/browse/dpdk-stable/tag/?id=v22.11.8-rc1
> >
> > These patches are located at branch 22.11 of dpdk-stable repo:
> >     https://dpdk.org/browse/dpdk-stable/
> >
> > Thanks.
> >
> > Luca Boccassi
> >
> > ---
>
> Hello,
>
> We ran the following functional tests with Nvidia hardware on v22.11.8-rc1:
> - Basic functionality:
>   Send and receive multiple types of traffic.
> - testpmd xstats counter test.
> - testpmd timestamp test.
> - Changing/checking link status through testpmd.
> - rte_flow tests (https://doc.dpdk.org/guides/nics/mlx5.html#supported-hardware-offloads)
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
> Functional tests ran on:
> - NIC: ConnectX-6 Dx / OS: Ubuntu 22.04 / Driver: MLNX_OFED_LINUX-24.10-2.1.8.0 / Firmware: 22.43.2566
> - DPU: BlueField-2 / DOCA SW version: 2.10.0 / Firmware: 24.44.1036
>
> Additionally, we ran build tests with multiple configurations on the following OS/driver combinations (all passed):
> - Ubuntu 22.04 with MLNX_OFED_LINUX-24.10-2.1.8.0.
> - Ubuntu 24.04 with MLNX_OFED_LINUX-24.10-2.1.8.0.
> - Ubuntu 22.04 with rdma-core master (9e9a957).
> - Ubuntu 24.04 with rdma-core v50.0.
> - Fedora 41 with rdma-core v51.0.
> - Fedora 43 (Rawhide) with rdma-core v56.0.
> - OpenSUSE Leap 15.6 with rdma-core v49.1.
>
> We don't see new issues caused by the changes in this release.
>
> Thanks,
> Ali

Thank you!
