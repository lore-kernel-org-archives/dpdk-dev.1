Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB04C3600C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 09:47:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 288A940A7F;
	Thu,  3 Apr 2025 11:47:38 +0200 (CEST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com
 [209.85.219.171])
 by mails.dpdk.org (Postfix) with ESMTP id F3E374060B;
 Thu,  3 Apr 2025 11:47:36 +0200 (CEST)
Received: by mail-yb1-f171.google.com with SMTP id
 3f1490d57ef6-e6cea43bb31so543193276.0; 
 Thu, 03 Apr 2025 02:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743673656; x=1744278456; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=42jLK3uEbJOg4TGSy/+oT9bhGSHF0B4LmVg9NkD2Ww0=;
 b=JRElGwKfcegGGWrhV9bYV/K5LnM1fS+E9Fbo59tNX/JBpATTpSzhoA/D0Uwex4K68W
 XW3H/bPFwfbVziJVf2PVRI8x9H9xjFjoA7+7kLRwvT+3xBnkBqljPgAL7cVUiv3bKg6Q
 /twJxyEw4wfP+aXYtZ0VmNKuPLvdrZ7rWLMp5CIUISus1Kub43JV0mqF8fznB+jay7W7
 7EUz5GOmbkcFvBgJhiws6cJop2+oo0gQRRnHfgqE4EwV8Kx4Vt7L4loi2Z4hQBzF6p6O
 v5fP3GMOm8KM1NIHrkh8QKHL5xIQCzesvd3cEU05mpy2gNeC26z/VqnfkR1B0QXVPRJs
 rIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743673656; x=1744278456;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=42jLK3uEbJOg4TGSy/+oT9bhGSHF0B4LmVg9NkD2Ww0=;
 b=NheiL7Epr0OGcQhbL+8Jnt6Hdrkgq52RHSBUjnukzDtuXXti9z6pzAjzHxynCM7JO9
 xDoAFh5aYxWTk+5JsgvKy73c06+4ILqPrVL0mqKiX0Z7pt7+JO3hhwEBHLhya34LVqEm
 RDNoZMiRjITJM90NursSzlDWtUofXrMmHyNvRRV6LRT94cTkNJ0p1sU3NiWcwI3J87nW
 dkl7WrZEVe4kS/3p+CUSZ6zgpEmlBsmMB/2d7rWszmHHWUdOqN+mN3wqAgl4R0+F1DlV
 tnK6wIhTKBXXm8BgUqZL6aRANRSLbA9/8iftGXv2PmgYc/w+tu+qOwyVzCumCEvw0zAv
 5m9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAjMzSfjL7UsXHGTgGwYMeVNpdWRoVCcp2hvwUh7jUQzX24YfTP89jpJaBK2GgJHCnMjw=@dpdk.org
X-Gm-Message-State: AOJu0Yw1amXGltSEpLO9sQkWCJoAPps36Kgan9R3/skiJxmDNM2l2Vzc
 JRYowRgBsswg21xKTjQ/lB2PmsOe84avbZ/bXV2GjmoW7OfnJFGis0FDhIFwM1WNhohh5mEDhb6
 q2sDoxetwrLMxj9b+ngElX56aK2w=
X-Gm-Gg: ASbGncu3NFFDMg0qXybvyd3HMqOgQ0z+yNZhZVYrpzonYFeBnYGos6Uj1LvSUCUf4mZ
 gbmfCsPHRlb8xZpHpbmhbF/J8YqIvxqOuEhH//Z9Xkm0dJQzJ8lQELU0vhGhDD/SdYKVlUwDWtn
 Zxdpte0MVBgvRyQ4gnhfaLiGQJlHmyBvbPFGOVfysIWvSh//D7sxZ83b5hqhY=
X-Google-Smtp-Source: AGHT+IEh0aFmJJBj5JCfBbPJABBAUMYn/zHxiSzyE2+Nt6oeADsuuuDZehKZdOLV3U/CYS9iXins2kTLR6j/ZuRwji4=
X-Received: by 2002:a05:6902:2e10:b0:e61:146f:9408 with SMTP id
 3f1490d57ef6-e6df45b258fmr8703202276.42.1743673656166; Thu, 03 Apr 2025
 02:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250326115132.1444530-1-luca.boccassi@gmail.com>
 <MW4PR11MB59126EC32C85D127C002CA7E9FAE2@MW4PR11MB5912.namprd11.prod.outlook.com>
In-Reply-To: <MW4PR11MB59126EC32C85D127C002CA7E9FAE2@MW4PR11MB5912.namprd11.prod.outlook.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Thu, 3 Apr 2025 09:47:24 +0000
X-Gm-Features: AQ5f1Jp7Z2h5NtevcXWbiwJA74MYUUdo3tA39fSYV_vTgdMwFHh_mnXRYgTcY9U
Message-ID: <CAMw=ZnTF5csck6GSk5PS0eddrPHNxFkt7VQLCMB5M78nhJtGzQ@mail.gmail.com>
Subject: Re: 22.11.8 patches review and test
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

On Thu, 3 Apr 2025 at 10:42, Xu, HailinX <hailinx.xu@intel.com> wrote:
>
> > -----Original Message-----
> > From: luca.boccassi@gmail.com <luca.boccassi@gmail.com>
> > Sent: Wednesday, March 26, 2025 7:51 PM
> > To: stable@dpdk.org
> > Cc: dev@dpdk.org; Ali Alnubani <alialnu@nvidia.com>; David Christensen
> > <drc@linux.vnet.ibm.com>; Hemant Agrawal <hemant.agrawal@nxp.com>;
> > Stokes, Ian <ian.stokes@intel.com>; Jerin Jacob <jerinj@marvell.com>;
> > Mcnamara, John <john.mcnamara@intel.com>; Kevin Traynor
> > <ktraynor@redhat.com>; Luca Boccassi <bluca@debian.org>; Pei Zhang
> > <pezhang@redhat.com>; Raslan Darawsheh <rasland@nvidia.com>; Thomas
> > Monjalon <thomas@monjalon.net>; Yanghang Liu <yanghliu@redhat.com>
> > Subject: 22.11.8 patches review and test
> >
> > Hi all,
> >
> > Here is a list of patches targeted for stable release 22.11.8.
> >
> > The planned date for the final release is 2025/04/10.
> >
> > Please help with testing and validation of your use cases and report any
> > issues/results with reply-all to this mail. For the final release the fixes and
> > reported validations will be added to the release notes.
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
> Update the test status for Intel part. dpdk22.11.8-rc1 all validation test done. no new issue is found.
>
> # Basic Intel(R) NIC testing
> * Build & CFLAG compile: cover the build test combination with latest GCC/Clang version and the popular OS revision such as
>   Ubuntu24.04, Ubuntu24.10, Fedora41, RHEL10, RHEL9.4, FreeBSD14.2, SUSE15, AzureLinux3.0, OpenAnolis8.9 etc.
> - All test done. No new dpdk issue is found.
> * PF(i40e, ixgbe, igc): test scenarios including RTE_FLOW/TSO/Jumboframe/checksum offload/VLAN/VXLAN, etc.
> - All test done. No new dpdk issue is found.
> * VF(i40e, ixgbe): test scenarios including VF-RTE_FLOW/TSO/Jumboframe/checksum offload/VLAN/VXLAN, etc.
> - All test done. No new dpdk issue is found.
> * PF/VF(ice): test scenarios including Switch features/Package Management/Flow Director/Advanced Tx/Advanced RSS/ACL/DCF/Flexible Descriptor, etc.
> - All test done. No new dpdk issue is found.
> * Intel NIC single core/NIC performance: test scenarios including PF/VF single core performance test, etc.
> - All test done. No new dpdk issue is found.
> * IPsec: test scenarios including ipsec/ipsec-gw/ipsec library basic test - QAT&SW/FIB library, etc.
> - All test done. No new dpdk issue is found.
>
> # Basic cryptodev and virtio testing
> * Virtio: both function and performance test are covered. Such as PVP/Virtio_loopback/virtio-user loopback/virtio-net VM2VM perf testing/VMAWARE ESXI 8.0, etc.
> - All test done. No new dpdk issue is found.
> * Cryptodev:
>   *Function test: test scenarios including Cryptodev API testing/CompressDev ISA-L/QAT/ZLIB PMD Testing/FIPS, etc.
>     - All test done. No new dpdk issue is found.
>   *Performance test: test scenarios including Thoughput Performance/Cryptodev Latency, etc.
>     - All test done. No new dpdk issue is found.
>
>
> Regards,
> Xu, HailinFW sync

Thank you!
