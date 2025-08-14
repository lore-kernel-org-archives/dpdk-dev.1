Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C065BCA0EDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 10:27:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5680C4278B;
	Thu, 14 Aug 2025 12:27:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2AED742707
 for <dev@dpdk.org>; Thu, 14 Aug 2025 12:27:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755167265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Bjrm5P2T2XCR/3ea+O0gSx0bFNcbCyqmAuFRktZphok=;
 b=hRxE5Oanz8A7VH/xMTHijLZeflV4Xar/HPFTofNFZALZE3yJEWYCkPh1XFD0Dsn499Diil
 +kczUhyF9i0xwbdyEy5NfaafSdnhTmzdE3qWZdEfCHsRlWdfQCFDPMhHl+Y7dWTt0DShDW
 tpQjCOr4MeafsT3JcL7l2SMs6druWi4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-ptK7ZbfuMdqwLoAJBZrnGA-1; Thu, 14 Aug 2025 06:27:44 -0400
X-MC-Unique: ptK7ZbfuMdqwLoAJBZrnGA-1
X-Mimecast-MFC-AGG-ID: ptK7ZbfuMdqwLoAJBZrnGA_1755167263
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3b9dc5c288eso555318f8f.1
 for <dev@dpdk.org>; Thu, 14 Aug 2025 03:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755167263; x=1755772063;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bjrm5P2T2XCR/3ea+O0gSx0bFNcbCyqmAuFRktZphok=;
 b=R4uKm0yt34AmheMgnm4zD9TMYrUMn5a7RlG3sCN3TZkqPAnz5YlOnoQdZ5CIwHJUPW
 xwIsgeryfZAcFVfFmlokIDhf4rxuZJA+VTQvcMGyMR7gT3103U6gdBVBZKv5PsvwJRZ/
 3x/nFdmZGRoQOecETAb9NmBsp6PUUl3rTOoU3eZB4cTEqORqiB4lWHXw5alvkdssJnuc
 KRiF1COedpYU9bDGcGC6gUXb9pp5NMlRX+xCukUKuvFUNbabCEQAQkz2PkhP+HueWN0s
 FxiMw/lBia4qdixoG/zthR8LKElAGtRVGLs2YQ2nfuZix41g8DO/VNuOR9N/uwNthtU3
 fP7Q==
X-Gm-Message-State: AOJu0YziqSUMq3aPz77WFAIIdPUyv26V592ltP4vwDprqJMY+qhIsayT
 7rfh2t9m04nY+HOtnZ278yU/mhbyE2wW3AY9bPD5vH9Gn57cKP+pg9g4bVVECrIeNUjCGF0ai7j
 kKMOMS/TnqthbkTIJSWJOz+AWegm/Dl5oGVJHBPlzgCtx
X-Gm-Gg: ASbGncvWX0nvx+OyOXSfGfDzUXKPoDLXXnu5VtfvDfvTzEgmhSFGnDSVyPlVu9+OJ6c
 7cKeatRv1aQM4yZe6v7NHRGqflr7F04xDcBnooYcBipRHyXRNVHtsi14wQVh/kNNxXqlZHAdM7K
 qIwVYRcDR/t4jfOCdSKyS1eL17DTOPz/lPWr2UyhOxWRP+IAxJy3eGhLQsNwbsAn6bharcj0dqO
 E7mZKUA8xs0eSoXU1idxe55oGZm1sU0zOjPuqIb4SAmWHybeURpa1tezccKbXYx6z1rqxZNX9N1
 6V1yi2BN6SHp2ovHJ/KzJOXpi1nwkKIEJVjKRWOgdg==
X-Received: by 2002:a05:6000:2304:b0:3b2:fe46:9812 with SMTP id
 ffacd0b85a97d-3b9e417a231mr1914203f8f.19.1755167262991; 
 Thu, 14 Aug 2025 03:27:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/vuxAlCDYb5t6U7Eax5ddz1k3E8RBbl5FlquegjV8FlsvogpPgfrNJiLBfEt5d+uKdHD0dg==
X-Received: by 2002:a05:6000:2304:b0:3b2:fe46:9812 with SMTP id
 ffacd0b85a97d-3b9e417a231mr1914179f8f.19.1755167262523; 
 Thu, 14 Aug 2025 03:27:42 -0700 (PDT)
Received: from [192.168.0.56] ([78.16.130.126])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e0b2d2fasm39701959f8f.50.2025.08.14.03.27.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Aug 2025 03:27:41 -0700 (PDT)
Message-ID: <2f601b6c-6316-40cc-9b86-31af16017258@redhat.com>
Date: Thu, 14 Aug 2025 11:27:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 24.11.3 patches review and test
To: Ali Alnubani <alialnu@nvidia.com>, stable@dpdk.org
Cc: dev@dpdk.org, John McNamara <john.mcnamara@intel.com>,
 Ju-Hyoung Lee <juhlee@microsoft.com>, Luca Boccassi <bluca@debian.org>,
 Pei Zhang <pezhang@redhat.com>, Raslan Darawsheh <rasland@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>
References: <20250724161514.396245-1-ktraynor@redhat.com>
 <1a0cca7f-fd45-433e-bc37-2b4b8ea7faee@nvidia.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <1a0cca7f-fd45-433e-bc37-2b4b8ea7faee@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RocKdW8BqOlOiiajI9lrFYCjJy_gNjGZLY8I8UocHhc_1755167263
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
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

On 13/08/2025 21:25, Ali Alnubani wrote:
> On 7/24/25 7:15 PM, Kevin Traynor wrote:
> 
>> Hi all,
>>
>> Here is a list of patches targeted for stable release 24.11.3.
>>
>> The planned date for the final release is 12th August 2025.
>>
>> Please help with testing and validation of your use cases and report
>> any issues/results with reply-all to this mail. For the final release
>> the fixes and reported validations will be added to the release notes.
>>
>> A release candidate tarball can be found at:
>>
>>      https://dpdk.org/browse/dpdk-stable/tag/?id=v24.11.3-rc1
>>
>> These patches are located at branch 24.11 of dpdk-stable repo:
>>      https://dpdk.org/browse/dpdk-stable/
>>
>> Thanks.
>>
>> Kevin
>>
>> ---
> 
> Hello Kevin, apologies for the delay,
> 

Hi Ali,

No problem, thanks for taking the time to run the validation.

> We ran the following functional tests with Nvidia hardware on v24.11.3-rc1:
> - Basic functionality:
>    Send and receive multiple types of traffic.
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
> MLNX_OFED_LINUX-24.10-3.2.5.0 / Firmware: 22.43.3608
> - NIC: ConnectX-7 / OS: Ubuntu 22.04 / Driver: 
> MLNX_OFED_LINUX-24.10-3.2.5.0 / Firmware: 28.43.3608
> - DPU: BlueField-2 / DOCA SW version: 2.9.3 / Firmware: 24.43.3608
> 
> Additionally, we ran build tests with multiple configurations on the 
> following OS/driver combinations (all passed):
> - Debian 12 with MLNX_OFED_LINUX-24.10-3.2.5.0.
> - Ubuntu 22.04 with MLNX_OFED_LINUX-24.10-3.2.5.0.
> - Ubuntu 22.04 with rdma-core master (091ddb5).
> - Ubuntu 24.04 with MLNX_OFED_LINUX-24.10-3.2.5.0.
> - Ubuntu 24.04 with rdma-core v50.0.
> - Fedora 42 with rdma-core v55.0.
> - Fedora 43 (Rawhide) with rdma-core v58.0.
> - OpenSUSE Leap 15.6 with rdma-core v49.1.
> - Windows Server 2022 with Clang 18.1.8.
> 
> The following patch addresses an ASan issue in testpmd:
> https://inbox.dpdk.org/dev/20250730113243.197386-1-mkashani@nvidia.com/
> 

ok, that one is not merged in dpdk main branch or gone through release
validation yet, so will hold off applying into stable branch for now.

> We are currently investigating additional functional test failures but 
> have not yet determined if these issues are new or present in previous 
> releases (and appeared due to environment changes). Will update as soon 
> as possible.
> 

Sure, no problem.

thanks,
Kevin.

> Regards,
> Ali
> 

