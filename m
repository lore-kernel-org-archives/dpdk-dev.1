Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F03C5DF90
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 09:07:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3100440664;
	Thu, 20 Aug 2026 11:07:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id EE66A400EF
 for <dev@dpdk.org>; Thu, 20 Aug 2026 11:07:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787216848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qmqEiKHK5l3/pqPmebJ4Noz3WEQAo6FO050hMRDbr1I=;
 b=YT8cQZbblKUsYE6A4O9wDg6iAyozOv/+GvnCAcG0pdLKc8zqGKH0QnCY+dlpiedfu415Eo
 BgVOaPg4lkbDSyT8s44BsePlqK3ByTH9spLNlL5uo3zoZFAupR+EqiluUlPIC2ywmItKR/
 bGs4kX2oGpZdo5aZMuH1d8ef5oDC19M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-8Q5m79gQOYKTBn0ffRyoYg-1; Thu, 20 Aug 2026 05:07:00 -0400
X-MC-Unique: 8Q5m79gQOYKTBn0ffRyoYg-1
X-Mimecast-MFC-AGG-ID: 8Q5m79gQOYKTBn0ffRyoYg_1787216819
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-495689bfcc8so13669265e9.1
 for <dev@dpdk.org>; Thu, 20 Aug 2026 02:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787216819; x=1787821619;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qmqEiKHK5l3/pqPmebJ4Noz3WEQAo6FO050hMRDbr1I=;
 b=HKoxEx9zqXslO6Ivxx25u9IMmF9l2zY45GvWuDhj0sjAFFwiXz7pAVDicFkRm1t4lq
 ANBydpFhdvr0XYGp9tMnN+OvKg0XQJGKe3Rjypl0oB90CWdUY4IDvxvneXosaLHoivhH
 48n63RuSKKLsPf9AD5IQdmYISHuIbbmuMHSC3lpmPvkVROORYeWjPjl/8dLa4G/bOn/Y
 FXodc8Tg1yhwxhI43HzTQojJPTuZLJmM4ZRvl1+6ToHAk+d6ohL4g42eEQcbk6F21pZc
 K2SIBysDQMDSaVo6ARC0A5eXvTNY3V0QquCQX9uwQNqg8bbieriNBQxV/RhXa7V7IQms
 6xNQ==
X-Gm-Message-State: AOJu0Yyef+GXSeaKx1J69VxSFplJjre4bfx6RYyIU4uwCjMCrfE4xg7v
 ejlQWdAaGm/BInbxl+LafZ/Vmmk4TNacR9w3kYxuxmE368OaJKqjouDN7v6tlb1CSO5h4SWmm60
 Zwk6yg+rZ1ePaTpKNBgfU1e9AaGVn/ANd3NsUjae4Nftm
X-Gm-Gg: AR+sD12pCODx+s33lCFdeySRnVBNpwIAn2o1hHhdflLS8vJiqwbOBNKjbneyjb0XLUa
 pl9ReiNCpTjvzR+Eor61QFxuv4lK+xTMaJ8bgsvdmOQwsYKcHeBPUwGeQMwJ/E8DhQRtNa71tT8
 /s5CRbsfzLfYBf9ap/YgTfDswv2xE5YbcXYWG8hd3IkHYkTl9J1gbdCz/goWjpo2L8nw6Xq50dy
 XregwCZPtT8nwp3KEXqyFEWpGN1dGFWOmb1ImvQWzjGu3tA1dqnh0fqtF+2gYgO2AbA7Azy3xUB
 brrCTfKeJugN1IrM6yUZjzskAqI5/V4vx2NlU7r5iGpEKTs5yDWddLNyyLtdFXc7Gnz+S9bO5gS
 o
X-Received: by 2002:a05:600c:83c6:b0:493:c634:952 with SMTP id
 5b1f17b1804b1-499aa1a778dmr208257775e9.7.1787216818612; 
 Thu, 20 Aug 2026 02:06:58 -0700 (PDT)
X-Received: by 2002:a05:600c:83c6:b0:493:c634:952 with SMTP id
 5b1f17b1804b1-499aa1a778dmr208257085e9.7.1787216818230; 
 Thu, 20 Aug 2026 02:06:58 -0700 (PDT)
Received: from [192.168.0.66] ([78.16.71.222])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0dd620sm119650075e9.13.2026.08.20.02.06.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 02:06:57 -0700 (PDT)
Message-ID: <e644edc6-f12b-4b5f-b626-49e2079322e4@redhat.com>
Date: Thu, 20 Aug 2026 10:06:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 25.11.3 patches review and test
To: "Xu, HailinX" <hailinx.xu@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "Mcnamara, John"
 <john.mcnamara@intel.com>, Luca Boccassi <bluca@debian.org>,
 Raslan Darawsheh <rasland@nvidia.com>, Shani Peretz <shperetz@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 "Hosamani, Manjunathgouda" <manjunathgouda.hosamani@intel.com>,
 "Puttaswamy, Rajesh T" <rajesh.t.puttaswamy@intel.com>
References: <20260804104755.135019-1-ktraynor@redhat.com>
 <DS4PPF00BBED10C93748DCE189FFFB33BFD9FA42@DS4PPF00BBED10C.namprd11.prod.outlook.com>
From: Kevin Traynor <ktraynor@redhat.com>
In-Reply-To: <DS4PPF00BBED10C93748DCE189FFFB33BFD9FA42@DS4PPF00BBED10C.namprd11.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JUFOfhRucqMBpnPxDwsAVqXBVqmso-kJiYDVUN-se8M_1787216819
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 8/20/26 06:47, Xu, HailinX wrote:
> 
>> -----Original Message-----
>> From: Kevin Traynor <ktraynor@redhat.com>
>> Sent: Tuesday, August 4, 2026 6:48 PM
>> To: stable@dpdk.org
>> Cc: dev@dpdk.org; Abhishek Marathe <Abhishek.Marathe@microsoft.com>;
>> Ali Alnubani <alialnu@nvidia.com>; David Christensen
>> <drc@linux.vnet.ibm.com>; Agrawal, Hemant <hemant.agrawal@nxp.com>;
>> Jerin Jacob <jerinj@marvell.com>; Mcnamara, John
>> <john.mcnamara@intel.com>; Ju-Hyoung Lee <juhlee@microsoft.com>; Kevin
>> Traynor <ktraynor@redhat.com>; Luca Boccassi <bluca@debian.org>; Raslan
>> Darawsheh <rasland@nvidia.com>; Shani Peretz <shperetz@nvidia.com>;
>> Thomas Monjalon <thomas@monjalon.net>
>> Subject: 25.11.3 patches review and test
>>
>> Hi all,
>>
>> Here is a list of patches targeted for stable release 25.11.3.
>>
>> The planned date for the final release is 20th August.
>>
>> Please help with testing and validation of your use cases and report any
>> issues/results with reply-all to this mail. For the final release the fixes and
>> reported validations will be added to the release notes.
>>
>> A release candidate tarball can be found at:
>>
>>      https://dpdk.org/browse/dpdk-stable/tag/?id=v25.11.3-rc1
>>
>> These patches are located at branch 25.11 of dpdk-stable repo:
>>      https://dpdk.org/browse/dpdk-stable/
>>
>> Thanks.
>>
>> Kevin
>>
>> ---
> Update the test status for Intel part. dpdk25.11.3-rc2 all validation test done. not found new issues.
> 
> * Build & CFLAG compile: cover the build test with latest GCC/Clang version on the following OS(all passed)
>    - Ubuntu25.10/Ubuntu26.04
>    - RHEL10/RHEL9.6
>    - Fedora43
>    - FreeBSD15
>    - SUSE16
>    - OpenAnolis8.10
>    - OpenEuler24.04-SP2
>    - AzureLinux3.0
> 
> * Function tests: All test done and passed
>    - i40E-(XXV710, X722) PF/VF: test scenarios including basic/RTE_FLOW/TSO/Jumboframe/checksum offload/mac_filter/VLAN/VXLAN/RSS, etc.
>    - IXGBE-(E610) PF/VF: test scenarios including basic/RTE_FLOW/TSO/Jumboframe/checksum offload/mac_filter/VLAN/VXLAN/RSS, etc.
>    - ICE-(E810, E830, E2100) PF/VF: test scenarios including basic/Switch/Package Management/Flow Director/Advanced Tx/Advanced RSS/ACL/DCF/Flexible Descriptor, etc.
>    - IPsec: test scenarios including ipsec/ipsec-gw/ipsec library basic test - QAT&SW/FIB library, etc.
>    - Virtio: both function and performance test are covered. Such as PVP/Virtio_loopback/virtio-user loopback/virtio-net VM2VM perf testing/VMAWARE ESXI 8.0, etc.
>    - Cryptodev: test scenarios including Cryptodev API testing/CompressDev ISA-L/QAT/ZLIB PMD Testing/FIPS, etc.
>    - DLB: test scenarios including DLB2.0 and DLB2.5
>    - Other: test scenarios including AF_XDP, Power, CBDMA, DSA
> 
> * Performance test: All test done and passed
>    - Thoughput Performance
>    - Cryptodev Latency
>    - PF/VF NIC single core
>    - XXV710/E810 NIC Performance
> 
> 
> Regards,
> Xu, Hailin

Thanks Hailin! I will add this to the release notes.
Kevin.

