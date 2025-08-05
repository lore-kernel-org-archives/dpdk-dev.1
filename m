Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA01C87FD1
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 Aug 2025 09:38:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F290440DDE;
	Tue,  5 Aug 2025 11:38:02 +0200 (CEST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com
 [209.85.128.172])
 by mails.dpdk.org (Postfix) with ESMTP id 65C1F40A4B;
 Tue,  5 Aug 2025 11:38:02 +0200 (CEST)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-7183d264e55so57871957b3.2; 
 Tue, 05 Aug 2025 02:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754386681; x=1754991481; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lqWsK0Z6f+JDt2kA548tXbHjwzQrw62o7LA7CzDiWro=;
 b=klbyCttdUJ82lLVFSg4CMBQIbVHa5ac0mN43eKzXhWR3f9+AiGcTK3rxwqMffCcX63
 NRgxbXBSp6wTo3IENlBRyJGxwDO8hGLIALCRnO8nj9giDw0jIL2Fv0LJU+O0p5LufOd1
 vZ9tHF4HIER0k/+PRbalXBZBQbPsCYC4VmhCrUqEfwo4FCmr33ER/gDbQ03Gg+TiHUTd
 tc4KMxFdJjgXSU6QTNbugkOJADowHlhyCRif5aLB6d8VVZ+whjCbOKHPvFfZK4et5dXU
 6jtxGbhg+re7x8yJ3eTwIdOT/BVDpl45x9/z3KEFFwkG+wYsau8DAxvhmte/bLQ2GXBu
 a+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754386681; x=1754991481;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lqWsK0Z6f+JDt2kA548tXbHjwzQrw62o7LA7CzDiWro=;
 b=IT16oUYlJWvhRgZYFRaUKd5vm9uR/i1wLwcbAl14SzcCMLwJeOfgg9yRvtzJGBI9Oc
 UWvYDrPpMI7rBj6nwoyFJZghF+rBAaepGaEL0s/X7HC6C9MVlXBsyMIuZZNvMCyjt+Zy
 itYBLzB4b5s2ELc83bt1dSOYTrWLM7Hpn2r+KrzYZdOx+GWm8sD/wpZHVgVRIrD4Sei3
 3d24m3OZ0XbhAxdyzV0D796RXwouRJ6RhwS1aJGSDArkwxj73rWSAyK89AYE9i+nmor/
 Ng/4qVYF2SIP/2ZgcrFqyoi7vV+y0Qw5sJ9Skl+crrKVipVglLjywZDwb3dCpcy5BDLR
 eEWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuloeECtjSR1+N9UXdOVhrssPo5pYONhufYdifJHG3RLyVa8+2od7i8j25IuM+CTzI26E=@dpdk.org
X-Gm-Message-State: AOJu0YwFkyY7khxx2jqRC6nCWzU3Pd4iotsWYfzDUzZdXTCrzjLcMpUu
 jMBBsIuXeyHppjiv2PNI7GkioOl7YMc+qJg808es3Irv1oTBXATDJFz5xw6B1wdL4lOhJSIuBE8
 VDHNQK0ofwir5oMvewUpPmlClULpvkWk=
X-Gm-Gg: ASbGncstTM9XAey+YQ1bu/8ey4NC4jj7Mcw4HRyAaB9der52NuaB5CL/n2KjfdGX4LO
 8RqoOXYLW+7xz9vfEVgYUJ31iW0Hg4kzFiYnXS/4BeZERFU7ZjM7KvIwi4idGXPfrOl8hEUL15b
 1bRif8Mh882QCACVar7JClQj/NSq4HLUcQwcgqg230oKagxbRZTPBYTwYF84yReanDpmDwZbO93
 UEl6KWJo+RbC70belgbCle8aooKl6sq93qpxJLu
X-Google-Smtp-Source: AGHT+IFOHl9v1ZGI6U7NK4Pbw25iYh1IFdPXLyfl6Onu2YS4lmROzKxDz0ZVQfSBnn4eVnUitqp2VgRt7l4MS764w1g=
X-Received: by 2002:a05:690c:6383:b0:71a:1bbf:bc04 with SMTP id
 00721157ae682-71b7ef61a04mr144020337b3.19.1754386681575; Tue, 05 Aug 2025
 02:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250723160822.1686060-1-luca.boccassi@gmail.com>
 <IA3PR11MB9040438B8C576F33588A3E1D9F22A@IA3PR11MB9040.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB9040438B8C576F33588A3E1D9F22A@IA3PR11MB9040.namprd11.prod.outlook.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Tue, 5 Aug 2025 10:37:50 +0100
X-Gm-Features: Ac12FXwGXwjetVunTmIaw7WkEUjeLndLshyArzFftkA2Lcd0X42LZJkcWlvyaAE
Message-ID: <CAMw=ZnSMQvZCbN5J9TMEaBbDKaUd7va=k3O4Ok2Nm_-J=dS0Qg@mail.gmail.com>
Subject: Re: 22.11.9 patches review and test
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

On Tue, 5 Aug 2025 at 10:28, Xu, HailinX <hailinx.xu@intel.com> wrote:
>
> > -----Original Message-----
> > From: luca.boccassi@gmail.com <luca.boccassi@gmail.com>
> > Sent: Thursday, July 24, 2025 12:08 AM
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
> > Subject: 22.11.9 patches review and test
> >
> > Hi all,
> >
> > Here is a list of patches targeted for stable release 22.11.9.
> >
> > The planned date for the final release is by the 25th of August 2025.
> >
> > Please help with testing and validation of your use cases and report any
> > issues/results with reply-all to this mail. For the final release the fixes and
> > reported validations will be added to the release notes.
> >
> > A release candidate tarball can be found at:
> >
> >     https://dpdk.org/browse/dpdk-stable/tag/?id=v22.11.9-rc1
> >
> > These patches are located at branch 22.11 of dpdk-stable repo:
> >     https://dpdk.org/browse/dpdk-stable/
> >
> > Thanks.
> >
> > Luca Boccassi
> >
> > ---
> Update the test status for Intel part. dpdk22.11.9-rc1 all validation test done. no new issue is found.
>
> # Basic Intel(R) NIC testing
> * Build & CFLAG compile: cover the build test combination with latest GCC/Clang version and the popular OS revision such as
>   Ubuntu24.04, Ubuntu25.04, Fedora42, RHEL10, RHEL9.6, FreeBSD14.2, SUSE15, AzureLinux3.0, OpenAnolis8.10 etc.
>   - All test done. No new dpdk issue is found.
> * PF(i40e, ixgbe, igc): test scenarios including RTE_FLOW/TSO/Jumboframe/checksum offload/VLAN/VXLAN, etc.
>   - All test done. No new dpdk issue is found.
> * VF(i40e, ixgbe): test scenarios including VF-RTE_FLOW/TSO/Jumboframe/checksum offload/VLAN/VXLAN, etc.
>   - All test done. No new dpdk issue is found.
> * PF/VF(ice): test scenarios including Switch features/Package Management/Flow Director/Advanced Tx/Advanced RSS/ACL/DCF/Flexible Descriptor, etc.
>   - All test done. No new dpdk issue is found.
> * Intel NIC single core/NIC performance: test scenarios including PF/VF single core performance test, etc.
>   - All test done. No new dpdk issue is found.
> * IPsec: test scenarios including ipsec/ipsec-gw/ipsec library basic test - QAT&SW/FIB library, etc.
>   - All test done. No new dpdk issue is found.
>
> # Basic cryptodev and virtio testing
> * Virtio: both function and performance test are covered. Such as PVP/Virtio_loopback/virtio-user loopback/virtio-net VM2VM perf testing/VMAWARE ESXI 8.0, etc.
>   - All test done. No new dpdk issue is found.
> * Cryptodev:
>   *Function test: test scenarios including Cryptodev API testing/CompressDev ISA-L/QAT/ZLIB PMD Testing/FIPS, etc.
>   - All test done. No new dpdk issue is found.
>   *Performance test: test scenarios including Thoughput Performance/Cryptodev Latency, etc.
>   - All test done. No new dpdk issue is found.
>
> Regards,
> Xu, Hailin

Thank you, that's great
