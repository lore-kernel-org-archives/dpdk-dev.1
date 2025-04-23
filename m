Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694DEC369D3
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 10:24:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E047402A9;
	Wed, 23 Apr 2025 12:24:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id E52574029D
 for <dev@dpdk.org>; Wed, 23 Apr 2025 12:24:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745403846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GaDvaDSEh8PhzFd3MTh1q6l3kQFSDYWvMZuXSymcZTk=;
 b=bD0RsrqWvR0bgNV4brQwwj3PwlGTk614M5gZ5zPgFnUhq8NIHAw6EOhAdWfkPQ307D6HgJ
 OFE8TRCh5RgsuwEJv7LZV9mXrIkMrrWSQ8P2j8YuqKD/klmiPQqasT9jhBDap+SvQHJZWo
 JlflgFgPZQ8vuSxzokEXaftfL9guAjs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-3vyofl9fMWGk5_Bgq4SjaA-1; Wed, 23 Apr 2025 06:24:04 -0400
X-MC-Unique: 3vyofl9fMWGk5_Bgq4SjaA-1
X-Mimecast-MFC-AGG-ID: 3vyofl9fMWGk5_Bgq4SjaA_1745403843
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-391492acb59so2882620f8f.3
 for <dev@dpdk.org>; Wed, 23 Apr 2025 03:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745403843; x=1746008643;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GaDvaDSEh8PhzFd3MTh1q6l3kQFSDYWvMZuXSymcZTk=;
 b=QAIa/lL61fQ6wW2yUGUnF0vFAJwR1m5Q/0EeA/1jp5uRBkAiDwG2xXgVrzahsZjo1s
 mql4AxcyPFLhEZ/70/vC7EbTN9NoAfXjJFPNpmA+ZKbs14rqp4o15EwM1Rs8CiKKPKlh
 n2Zf2DLZcZWO3Xj9S4JUK5wYAmaZHhmkoMLpuJNoQo7IFj35sVIdluqRXtxJcQJlSPzx
 S3nW9eTgO9y3GKaWTC0PMZTADY2tKuO1vdxZbx3XZhs2KAodjtZ8Iur04SNOzo34HDg8
 b8kxHbGbPUP1iff2tBln5RXq6Cpn5KB1EGrLH7GleInJiW8GSBEDLEm9Q2E0Ty1rBeSM
 uZyQ==
X-Gm-Message-State: AOJu0YwZSChzSAHOKom+gZ1PbElAJyws4E3ofeaPtog+Ojn3G9hawoeM
 ilHGuuxI6BLtIXPpmeZa43aVNvm+EBIrm1GTn6pSoMFtxizoz8uA2Jvilke0+K+ChFrH5BxyIto
 gSOqeCZ1X9FSLtV1GGXPB4YyZjE/zIsz+2q+rExJQ
X-Gm-Gg: ASbGncvBmbCbJ4yrJfTQJshlmNeAMQXpnG5gkyEpPItvDcdLfcOQ5wW2/UngfjiG5wl
 8jBui7Pt72J4sbx9Av2DjIdMOfMqcttLHWWZ6QXcGw6n7N/dTvTGSYzavbsaCHWpAaHUnR8k5ZA
 wLxwCvCNHBbG+Nk+SFXXfj5XyKhlC9fE1xP7sfvVaiF40azZUb66/LWnMH1Bm18Tf31dQ949ZrW
 BSppdqjtOB8tCRNiwNSo76psdOzMHSC8fW7BVelhEYiyjPJ7EdJAVJx2UixHHQ7dEojutYYuYNi
 7+UtM4PtB2MC
X-Received: by 2002:a05:6000:290b:b0:38f:4acd:975c with SMTP id
 ffacd0b85a97d-39efba5ee6bmr15310656f8f.27.1745403843417; 
 Wed, 23 Apr 2025 03:24:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8BkQi5CbFxjXky5madHtTsFIi2Ih+jaU+EjJtc/BIhnmwjRjMLpWn9GY26+NujHxTlYbARQ==
X-Received: by 2002:a05:6000:290b:b0:38f:4acd:975c with SMTP id
 ffacd0b85a97d-39efba5ee6bmr15310635f8f.27.1745403843036; 
 Wed, 23 Apr 2025 03:24:03 -0700 (PDT)
Received: from [192.168.0.56] ([78.16.128.39])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa433303sm18088482f8f.24.2025.04.23.03.24.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 03:24:02 -0700 (PDT)
Message-ID: <029acdda-4147-4b55-bf10-7d6ef8b92d2f@redhat.com>
Date: Wed, 23 Apr 2025 11:24:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 24.11.2 patches review and test
To: "Xu, HailinX" <hailinx.xu@intel.com>, "stable@dpdk.org"
 <stable@dpdk.org>, shperetz@nvidia.com
Cc: "dev@dpdk.org" <dev@dpdk.org>, Ali Alnubani <alialnu@nvidia.com>,
 "Mcnamara, John" <john.mcnamara@intel.com>, Luca Boccassi
 <bluca@debian.org>, Thomas Monjalon <thomas@monjalon.net>
References: <20250328101435.250876-1-ktraynor@redhat.com>
 <SA1PR11MB5924B25AAEBE0D441AC306779FB82@SA1PR11MB5924.namprd11.prod.outlook.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <SA1PR11MB5924B25AAEBE0D441AC306779FB82@SA1PR11MB5924.namprd11.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ydxHVUNhKHghD-46ypw6hp8FCobTzFCTShqrqu2np6c_1745403843
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 21/04/2025 07:18, Xu, HailinX wrote:
>> -----Original Message-----
>> From: Kevin Traynor <ktraynor@redhat.com>
>> Sent: Friday, March 28, 2025 6:15 PM
>> To: stable@dpdk.org
>> Cc: dev@dpdk.org; Abhishek Marathe <Abhishek.Marathe@microsoft.com>;
>> Ali Alnubani <alialnu@nvidia.com>; David Christensen
>> <drc@linux.vnet.ibm.com>; Hemant Agrawal <hemant.agrawal@nxp.com>;
>> Stokes, Ian <ian.stokes@intel.com>; Jerin Jacob <jerinj@marvell.com>;
>> Mcnamara, John <john.mcnamara@intel.com>; Ju-Hyoung Lee
>> <juhlee@microsoft.com>; Kevin Traynor <ktraynor@redhat.com>; Luca
>> Boccassi <bluca@debian.org>; Pei Zhang <pezhang@redhat.com>; Raslan
>> Darawsheh <rasland@nvidia.com>; Thomas Monjalon
>> <thomas@monjalon.net>; yanghliu@redhat.com
>> Subject: 24.11.2 patches review and test
>>
>> Hi all,
>>
>> Here is a list of patches targeted for stable release 24.11.2.
>>
>> The planned date for the final release is 14 April.
>>
>> Please help with testing and validation of your use cases and report any
>> issues/results with reply-all to this mail. For the final release the fixes and
>> reported validations will be added to the release notes.
>>
>> A release candidate tarball can be found at:
>>
>>     https://dpdk.org/browse/dpdk-stable/tag/?id=v24.11.2-rc1
>>
>> These patches are located at branch 24.11 of dpdk-stable repo:
>>     https://dpdk.org/browse/dpdk-stable/
>>
>> Thanks.
>>
>> Kevin
>>
>> ---

Hi Hailin,

Thanks for the testing and report. Comments below.

> Update the test status for Intel part. dpdk24.11.2-rc1 all validation test done. no new issue is found.
> 
> known issues: fix patch has been merged into main, but they not merged 24.11 LTS, so this issue still exists in 24.11.2-rc1
>   1. Bug 1606 - flow_filtering/flow_filtering_mismatch_rule: Some mismatch rule packets match the rule.
>      - has fix patch: https://patches.dpdk.org/project/dpdk/patch/20250112075200.5020-1-shperetz@nvidia.com/

(CC: Shani)

This patch is part of 24.11.2-rc2, so not sure if it's the same issue
you are seeing ?

It is applied here
https://git.dpdk.org/dpdk-stable/commit/?id=b540e51a864d25b1e254fa8c311b92223e0f4162

$ git tag --contains b540e51a8
v24.11.2-rc1

$ git show b540e51a8
commit b540e51a864d25b1e254fa8c311b92223e0f4162
Author: Shani Peretz <shperetz@nvidia.com>
Date:   Sun Jan 12 09:52:00 2025 +0200

    examples/flow_filtering: fix IPv4 matching snippet

    [ upstream commit 5fa25916f1ab47c82310264449a6d67dbb15ca4d ]

    This patch corrects the destination IP address mask to
    restore the previous implementation's behavior.

    Also it fixes a misuse of rte_flow_item_tcp struct.
    Replace it with the appropriate rte_flow_item_ipv4 struct,
    as the code in this context filters ipv4 traffic.

    Fixes: 16158f349000 ("examples/flow_filtering: introduce use cases
snippets")

    Signed-off-by: Shani Peretz <shperetz@nvidia.com>


>   2. Linkville vfs can't forward packets
>      - has fix patches: https://patches.dpdk.org/project/dpdk/list/?series=34939&archive=both&state=*
> 

This issue was introduced by missing case in commit '316637762a5f
("net/ixgbe/base: enable E610 device")' from 24.07. The patches linked
are already applied in main branch and patch 2/3 has the fix.

In summary, the first reported issue is example code. The second issue
is not a regression from 24.11.1 but I'll apply the fix patch for that
as it's straightforward.

I will go ahead with the release as it is overdue. It would be nice if
we can resolve the first issue for 24.11.3 but we have time.

thanks,
Kevin

> * Build & CFLAG compile: cover the build test with latest GCC/Clang version on the following OS(all passed)
>   - Ubuntu24.10/Ubuntu24.04.1
>   - RHEL9.4/RHEL9.5/RHEL10 beta
>   - Fedora41
>   - FreeBSD14.2
>   - SUSE15.6
>   - OpenAnolis8.9
>   - AzureLinux3.0
> 
> * Function tests: All test done and there are two known issues.
>   - i40E-(XXV710, X722) PF/VF: test scenarios including basic/RTE_FLOW/TSO/Jumboframe/checksum offload/mac_filter/VLAN/VXLAN/RSS, etc. 
>   - IXGBE-(82599, E610) PF/VF: test scenarios including basic/RTE_FLOW/TSO/Jumboframe/checksum offload/mac_filter/VLAN/VXLAN/RSS, etc. 
>   - ICE-(E810, E830, E2100) PF/VF: test scenarios including basic/Switch/Package Management/Flow Director/Advanced Tx/Advanced RSS/ACL/DCF/Flexible Descriptor, etc.
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
> 
> 
> Regards,
> Xu, Hailin
> 

