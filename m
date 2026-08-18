Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2418DC5DF7D
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 15:23:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5ECE4027C;
	Tue, 18 Aug 2026 17:23:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D5A4140269
 for <dev@dpdk.org>; Tue, 18 Aug 2026 17:23:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787066637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q9LxUz/9Nz4LS9wlFI6ncHxjZVt8Z2re9L9fNZJ78i8=;
 b=f7Zm8a3+4zpmFFc5vdM8+RhALbkdJQj9+qQJqahJphh4Mf8DlPo+DV3SGSCbz5gyQrU7n4
 VTRjIjt1wueUYh/IJ6Pl+LH2g4CclNydaWcG4xJ8m2s4HZiEme9UJ4kpFB4cBp3xAHrvB5
 zDAAygpU0v157ib1Y/Ar8EDHcNOgwIM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-iXI7G-iNM1mCyn9xiYA-pA-1; Tue, 18 Aug 2026 11:23:55 -0400
X-MC-Unique: iXI7G-iNM1mCyn9xiYA-pA-1
X-Mimecast-MFC-AGG-ID: iXI7G-iNM1mCyn9xiYA-pA_1787066635
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c210c66672eso503857066b.2
 for <dev@dpdk.org>; Tue, 18 Aug 2026 08:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787066635; x=1787671435;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q9LxUz/9Nz4LS9wlFI6ncHxjZVt8Z2re9L9fNZJ78i8=;
 b=XjmFjGrPCFa4xh4PHsJdYrqxdlgpB0luP1tQQxWfpfBopyHmwRHhigNkotCeFu3cD1
 aVKEMDXffKxnFVhaUDK5gcwFMBlHw5cfwnLbbctBVGE5tXlo0krcyzxWf/vLlc5isV9m
 /1dVn9LhnDJw0XZRI6HZleaL42xBF2iqy92xyppGl0h83CyrKScbaFea6pvYtTvt8unw
 Nt/hJ2pwaNZR0uagtQLAe1QuViTiWr8MIy/kvPEXkR9sJI4Jr6VEcI8fSuKaU+z5bo6l
 +e2OnTRGA002V6bivZ/1K9lKjgGolNHHQIiVMopxl5dr2zE62JdTE514Q+vM9XqmiOAt
 crpg==
X-Gm-Message-State: AOJu0YyLwPVTIlOX0j47ADKZPeqFEetyumGxRzDwH0sBGj6qTgAjFyTB
 BfNACVbl7USsJw0+mrAqEliWnltd8y7ZdRobuCrBbww3+qUxxwgDoRiO9jz70XcUQhln7HdYpps
 zxNqMN9jW+MX5g0ER/9T4dVL2VZxQsNksFg81aVcdjScx
X-Gm-Gg: AR+sD13tUZfM4yXSBsWue2eGdPHm+cZgu6cPZUn8NuL/GJhVWn/Gz/GMWFdFEUtOT1m
 /N/DpHmyRiVkVDvluBbrDGefHRu7Z+1n+HVaGM9hNlDl69X4k3a9ckPQHykPr9892hSatMUBtAO
 1Gm5DMBuc77hYaYyJqRxhLqYTIsqTn+FUm1K9dYDa0ndJx1v1FyjxThAnivk8ksQfkv085D0rAo
 yPnmfCGZltMel1kpruhI8trxOqW3QCp+qe64m4BjIij7KQLQiml68pWyHkf43iTF0d1VmlMhPni
 gELLBrz8esBFD5H0LObhHJfExhXTIMKHo8ul+suC1cxBJEVFJr2a7lm4s34aCtVVQ8slP0k/zCX
 S
X-Received: by 2002:a17:906:6209:b0:c21:74ed:4608 with SMTP id
 a640c23a62f3a-c21885cb5fcmr676554066b.10.1787066634642; 
 Tue, 18 Aug 2026 08:23:54 -0700 (PDT)
X-Received: by 2002:a17:906:6209:b0:c21:74ed:4608 with SMTP id
 a640c23a62f3a-c21885cb5fcmr676549266b.10.1787066634238; 
 Tue, 18 Aug 2026 08:23:54 -0700 (PDT)
Received: from [192.168.0.66] ([78.16.71.222])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c217fea2cbasm217422566b.19.2026.08.18.08.23.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 08:23:52 -0700 (PDT)
Message-ID: <a9a061ec-6641-4fc0-9cc0-9b294c8c6ccb@redhat.com>
Date: Tue, 18 Aug 2026 16:23:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 25.11.3 patches review and test
To: Ali Alnubani <alialnu@nvidia.com>, stable@dpdk.org
Cc: dev@dpdk.org, Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Jerin Jacob <jerinj@marvell.com>,
 John McNamara <john.mcnamara@intel.com>, Ju-Hyoung Lee
 <juhlee@microsoft.com>, Luca Boccassi <bluca@debian.org>,
 Raslan Darawsheh <rasland@nvidia.com>, Shani Peretz <shperetz@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>
References: <20260804104755.135019-1-ktraynor@redhat.com>
 <45705b36-123e-4459-9287-935485b3658e@nvidia.com>
From: Kevin Traynor <ktraynor@redhat.com>
In-Reply-To: <45705b36-123e-4459-9287-935485b3658e@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _Cmnzss22pJPZ1i4xQzK1v1lpwNHgkX5tfO30TPhhV4_1787066635
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 8/18/26 16:14, Ali Alnubani wrote:
> On 8/4/26 1:47 PM, Kevin Traynor wrote:
> 
>> Hi all,
>>
>> Here is a list of patches targeted for stable release 25.11.3.
>>
>> The planned date for the final release is 20th August.
>>
>> Please help with testing and validation of your use cases and report
>> any issues/results with reply-all to this mail. For the final release
>> the fixes and reported validations will be added to the release notes.
>>
>> A release candidate tarball can be found at:
>>
>>      https://dpdk.org/browse/dpdk-stable/tag/?id=v25.11.3-rc1
>>
>> These patches are located at branch 25.11 of dpdk-stable repo:
>>      https://dpdk.org/browse/dpdk-stable/
>>
>> Thanks.
>>
>> Kevin
>>
>> ---
> 
> Hello,
> 
> We ran the following functional tests with Nvidia hardware on v25.11.3-rc1:
> - Basic functionality:
>    Send and receive multiple types of traffic.
> - testpmd xstats counter test.
> - testpmd timestamp test.
> - Changing/checking link status through testpmd.
> - rte_flow tests (See https://doc.dpdk.org/guides/nics/mlx5.html for 
> supported features)
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
> Environments:
> - NIC: ConnectX-7 / OS: Ubuntu 24.04 / Driver: DOCA-Host 3.4.0-085000 / 
> Firmware: 28.49.1014
> - DPU: BlueField-3 / OS: Ubuntu 24.04 | DOCA SW version: 3.4.0 / 
> Firmware: 24.49.1014
> 
> We don't see new issues caused by changes in this release.
> 
> Thanks,
> Ali
> 

Thanks Ali. I will add the release notes.
Kevin.

