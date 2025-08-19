Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3A7CA0EEB
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 16:59:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8690640669;
	Tue, 19 Aug 2025 18:59:16 +0200 (CEST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com
 [209.85.219.180])
 by mails.dpdk.org (Postfix) with ESMTP id 8B45A402E4;
 Tue, 19 Aug 2025 18:59:15 +0200 (CEST)
Received: by mail-yb1-f180.google.com with SMTP id
 3f1490d57ef6-e933de387b0so90838276.1; 
 Tue, 19 Aug 2025 09:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755622755; x=1756227555; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W8Z44QjEyB+RT+e4pPx0+SyYYkbZzA/u1pmhwZ1jlb8=;
 b=CvE+tr/Ogi2J2udPK0vcdlhDF6/wrhoKLZw+xsdLsQz1Gy8GbNJ2H/YeiW0vWOTzEl
 ZI3TwXx91FNddiD2pYx0TMMisIT1ZapMh1ESVy8rTc9NltYy8V9PTZBBS8aB8tVJSeqo
 vzdPMQWxHgtclUksxHL2lzqdWH+wTbHVaVudy6rqa1l8O3VMZI/NkYbxwh+4+Y4segeB
 tWso+CGtuqc0ih37p8B4UDCQw8yIxxPUBkSEPOjsPKqt1/cqF3PDzTQOyJ+mAC7EQFzG
 0ZUD2RWBOm/pFR4lt+XaKJjD35t3wFvQ2y7MZRWo6a+AtTEZukBesSkFZzt/Dy53sinD
 FeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755622755; x=1756227555;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W8Z44QjEyB+RT+e4pPx0+SyYYkbZzA/u1pmhwZ1jlb8=;
 b=ad8dCHf+2/CrmNcOWr6oGHf+zT0afEt70Vuxg44bz7rXgmNOQju+HejT+uyoTPeveC
 X7n2ttTAazsFOFqf41gBzm+lWLqBhymepAiZ+OaeI0ECIDl5zQtmDEMyaDDn9rNlTDbS
 mRN7+fZ5ZYIgU/etTXlBXAo3/tJ5DtPxmtJwIzY3H99bWKMW6nMLkSwDetDmdfpq921W
 BddflJUrFZOax6KMi+W+Gu2J5ytC0WgI34k6UfS9t4Go8uHHackxk3r8xBjJMpA4DgCs
 EZT+IC/F7yRf4gS1nBDm4K+JtCQpMhH8R2KFwukovWaDp00WB8S+obTMDIQYU4N8DqP9
 Y6fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAwsuRAgVTVx5UuS7xwS4k7lasU4+pMgRl+Wyodx/cuRJyEbwQATIVplyF23qlrTJ3+og=@dpdk.org
X-Gm-Message-State: AOJu0YwBo1rEc2Z0F3wNJDvmwSGce4bJXYxB33vKmcRew6dOQQUpN1r1
 55edRml9FJncapHoL0ywCTg2hCysX97mLfdrSg1IUkM64dBtIbw/hMvM9DFTpb5lM7RhTYlI7H0
 5Lcc6NURiua6llQPvp9ZExZMKQTiuuBqh1ktf
X-Gm-Gg: ASbGncsDHaffWZflUOhgnDBBDKs5WBgc7X4ExHv7RXHO3Xka33/El5lJRdwv3GatFpJ
 ZGE3PcXXDPAzo2q9tRFUKyCw/OyiKMHIxURupNHAIotWaEX/GsBo6P+6lR1CEhuwAEkPG9e8rtQ
 8T5eY0Q/wp5Bn0wbhMm66PM+ensJv2gn0HRuUXMZbbi4sjSlSYi6lozJIN85wuYtk4fYhqhYeIm
 7ZB4ybJCpsGFUheOHpvmL9aHlRqaOKOqY7WlWv74Sk4QPdUPGQ=
X-Google-Smtp-Source: AGHT+IGBDN4tJeAi+z/e7sMgj6XHGmTOb55AAKDxyHcNQGmTyG6Uoy7q9mSFG7ZC9RFRln2EnR8/NSNyN1xVwEZNrLQ=
X-Received: by 2002:a05:6902:120d:b0:e8f:d4b2:c2ce with SMTP id
 3f1490d57ef6-e94e79f6da6mr3367652276.24.1755622754763; Tue, 19 Aug 2025
 09:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250723160822.1686060-1-luca.boccassi@gmail.com>
 <ac197013-cec0-41cd-ac6e-0755e7dbc806@nvidia.com>
In-Reply-To: <ac197013-cec0-41cd-ac6e-0755e7dbc806@nvidia.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Tue, 19 Aug 2025 17:59:03 +0100
X-Gm-Features: Ac12FXzws74qn3sAHZMzdJOoFNfanVUCsMJFwPG-7oM1gdupOsg_6nocox4BY1E
Message-ID: <CAMw=ZnROFOSiejmGbndtnZ78yAJpDOOSWDrFt-S8JjzPecDogA@mail.gmail.com>
Subject: Re: 22.11.9 patches review and test
To: Ali Alnubani <alialnu@nvidia.com>
Cc: stable@dpdk.org, dev@dpdk.org, Raslan Darawsheh <rasland@nvidia.com>, 
 Thomas Monjalon <thomas@monjalon.net>
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

On Tue, 19 Aug 2025 at 16:32, Ali Alnubani <alialnu@nvidia.com> wrote:
>
> On 7/23/25 7:08 PM, luca.boccassi@gmail.com wrote:
>
> > Hi all,
> >
> > Here is a list of patches targeted for stable release 22.11.9.
> >
> > The planned date for the final release is by the 25th of August 2025.
> >
> > Please help with testing and validation of your use cases and report
> > any issues/results with reply-all to this mail. For the final release
> > the fixes and reported validations will be added to the release notes.
> >
> > A release candidate tarball can be found at:
> >
> >      https://dpdk.org/browse/dpdk-stable/tag/?id=v22.11.9-rc1
> >
> > These patches are located at branch 22.11 of dpdk-stable repo:
> >      https://dpdk.org/browse/dpdk-stable/
> >
> > Thanks.
> >
> > Luca Boccassi
> >
> > ---
>
> Hello,
>
> We ran the following functional tests with Nvidia hardware on v22.11.9-rc1:
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
> Functional tests ran on:
> - NIC: ConnectX-6 Dx / OS: Ubuntu 22.04 / Driver:
> MLNX_OFED_LINUX-24.10-2.1.8.0 / Firmware: 22.43.2566
> - NIC: ConnectX-7 / OS: Ubuntu 22.04 / Driver:
> MLNX_OFED_LINUX-24.10-2.1.8.0 / Firmware: 28.43.2566
> - DPU: BlueField-2 / DOCA SW version: 2.5.4 / Firmware: 24.39.5050
>
> Additionally, we ran build tests with multiple configurations on the
> following OS/driver combinations (all passed):
> - Debian 12 with MLNX_OFED_LINUX-24.10-3.2.5.0.
> - Ubuntu 22.04 with MLNX_OFED_LINUX-24.10-3.2.5.0.
> - Ubuntu 24.04 with MLNX_OFED_LINUX-24.10-3.2.5.0.
> - Ubuntu 22.04 with rdma-core master (091ddb5).
> - Ubuntu 24.04 with rdma-core v50.0.
> - Fedora 42 with rdma-core v55.0.
> - Fedora 43 (Rawhide) with rdma-core v58.0.
> - OpenSUSE Leap 15.6 with rdma-core v49.1.
> - Windows Server 2022 with Clang 18.1.8.
>
> We did not detect new issues caused by changes in this release.
>
> Thanks,
> Ali

That's great, thank you
