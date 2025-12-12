Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4C1D4921F
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 12:25:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECDAE40DCE;
	Fri, 12 Dec 2025 13:25:57 +0100 (CET)
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com
 [74.125.224.43]) by mails.dpdk.org (Postfix) with ESMTP id 8D1BC40268
 for <dev@dpdk.org>; Fri, 12 Dec 2025 13:25:56 +0100 (CET)
Received: by mail-yx1-f43.google.com with SMTP id
 956f58d0204a3-64476c85854so1066287d50.0
 for <dev@dpdk.org>; Fri, 12 Dec 2025 04:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765542356; x=1766147156; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uVko2JmVEVJS+45LHdKxtSJITPHOA44Hk6xWe5UuCJ0=;
 b=f9keKH6h2Z8JpgPb8A3wvMKJWAoTYIebr6I7Skjul/2rh+0T6/7r7vsB5a0H07q6J+
 dFYbmJIa3CT/f9NP6K3Cr0ipWDQi/gnQLBbKZRduQZxbuxsH2GQDdskwCtLg+557+7X1
 dmCzLSi8Om71OeMTvXn/8KTr9EJXF/x2XJwZw8elZfbk3KUaIoVCC5MI+wbQHXqViMdD
 q2Dcpyz4pTl6EIHc6Rqahw2Ew9Pozn9Fg873lWHhLixZ4D5qvGE8iVscbZnSi3/DSkao
 gJPzF+D7hn+NKILXpNCpte4L8pV/V3vlmztgA9BOhfsHtY08VBBTWIxKbyROMySDXPpr
 B9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765542356; x=1766147156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uVko2JmVEVJS+45LHdKxtSJITPHOA44Hk6xWe5UuCJ0=;
 b=VR+WAg1Itia2xk6Cmj5YGi4SedMd50ex96Rlr95jCNPzvibBJ0L68YIDSoNI/vhnY0
 Abu5Qsv+oi7WM8V/ne3TTe5V/ZZqH4jp9PB/QH58h+Vf8u9YODind7KC7UY5Pcj5sHxQ
 eviaWIh3e/nqZ7H3S/MTd1kl2EX+9x4yZTTsrsy2DHBQJwHCwDJjvKpmtE6Lcz6EM1RB
 Cay0jyTYOsSTcyvPlaKbW5ox5/XdFhWqwnN1u1FHE4uFj2FpiaAZnJYUiU4Qb+GEMlIH
 V48BsoAuXSaLWlpNgq0PKWrbPsceEppmJo+eaRzGOLNP+VtAL9pWD9uQ5QM29HtV1Jv6
 8RIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQARgBsqAeyAzcXPHLdg+0d7Ns2yh7qzn+ZuWm4uQ2bc51rtmj/LBYZKqvZYesAq+Dlqo=@dpdk.org
X-Gm-Message-State: AOJu0Yzl3wf9DfeGsgQk1DuprTBOFqo4ObNKAZLUFSWqxJI8BFhJgTyt
 S4nSKBCySua3SaG15SphRRh/iNWgN/WwIbRKmQPbT265j7+Ml1kF71a2dnthcLvUZ6234SdacYi
 i6lEOUCnC/ZLmW1dXApJMOTpGqmqfuCQ=
X-Gm-Gg: AY/fxX4/FgxJu7q+fY3ZX80x5uRY4iuGH+CEtiGJ0II/K1MBfJmelpyiUKmTzbPX80E
 pzCNQpzgOE/1Ye4EpJb60iDAOMvHV0kCCgQWaIQlmafq7P6ejQsG2vRaSQ+AV7oXUuqZxy1wXOz
 XcYY7A4dcj+qsVx8fBQjVH5p7Ahn90209LZ42Ssd7AtoI0SoupDyT/b6rGzeHXvjsDU5y9SkWf/
 v5M61w3RYxLzvHKu9Mmi8Y0195sKPh0gm9WFVYU5/6ka3C05iogh4ZGPzEHyDFtb3DGcplXOvx0
 98r8ehxekdXZCpYHrM58Hl0Zt27qDg==
X-Google-Smtp-Source: AGHT+IFYDg9i2wp8uNXkJyLW+lzrpnTBaqAGaa5GkBl91hU/0mqyxHREOkBX62fjkWwHnekKD62x5hjY9I7jK5NtEMw=
X-Received: by 2002:a05:690c:4a0e:b0:787:ca0f:2687 with SMTP id
 00721157ae682-78e66dc90d8mr30531357b3.34.1765542355682; Fri, 12 Dec 2025
 04:25:55 -0800 (PST)
MIME-Version: 1.0
References: <20251204005603.3236032-1-luca.boccassi@gmail.com>
 <DS4PPF653E4B5310732D910B6E58C05AD8F9FAEA@DS4PPF653E4B531.namprd11.prod.outlook.com>
In-Reply-To: <DS4PPF653E4B5310732D910B6E58C05AD8F9FAEA@DS4PPF653E4B531.namprd11.prod.outlook.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Fri, 12 Dec 2025 12:25:44 +0000
X-Gm-Features: AQt7F2pm8QW-UcswOJYoABHosJhHEkd1b8YyzRXXSDSp9ztTHXdrQABbZ9ECWiY
Message-ID: <CAMw=ZnSGQ3O30F4aCBDx_Xpa3mEdqKDC3=C9MGe8mKdhtqB2bA@mail.gmail.com>
Subject: Re: 22.11.11 patches review and test
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

On Fri, 12 Dec 2025 at 06:53, Xu, HailinX <hailinx.xu@intel.com> wrote:
>
> > -----Original Message-----
> > From: luca.boccassi@gmail.com <luca.boccassi@gmail.com>
> > Sent: Thursday, December 4, 2025 8:56 AM
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
> > Subject: 22.11.11 patches review and test
> >
> > Hi all,
> >
> > Here is a list of patches targeted for stable release 22.11.11.
> >
> > The planned date for the final release is December 18th.
> >
> > Please help with testing and validation of your use cases and report any
> > issues/results with reply-all to this mail. For the final release the fixes and
> > reported validations will be added to the release notes.
> >
> > A release candidate tarball can be found at:
> >
> >     https://dpdk.org/browse/dpdk-stable/tag/?id=v22.11.11-rc1
> >
> > These patches are located at branch 22.11 of dpdk-stable repo:
> >     https://dpdk.org/browse/dpdk-stable/
> >
> > Thanks.
> >
> > Luca Boccassi
> >
> > ---
> Update the test status for Intel part. dpdk22.11.11-rc1 all validation test done. find one new issue.
>
> new issue:
>   Bug 1849 - [dpdk-22.11.11rc1] virtio_perf_cryptodev_func/test_virtio_aes_cbc_sha1_hmac: dpdk-test-crypto-perf EAL: Error: Invalid memory

This is now fixed by revert

> # Basic Intel(R) NIC testing
> * Build & CFLAG compile: cover the build test combination with latest GCC/Clang version and the popular OS revision such as
>   Ubuntu24.04, Ubuntu25.04, Fedora42, RHEL10, RHEL9.6, FreeBSD14.2, SUSE15, AzureLinux3.0, OpenAnolis8.10 etc.
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
> - All test done. Find one new issue.
> * Cryptodev:
>   *Function test: test scenarios including Cryptodev API testing/CompressDev ISA-L/QAT/ZLIB PMD Testing/FIPS, etc.
>     - All test done. No new dpdk issue is found.
>   *Performance test: test scenarios including Thoughput Performance/Cryptodev Latency, etc.
>     - All test done. No new dpdk issue is found.

That's great, thank you
