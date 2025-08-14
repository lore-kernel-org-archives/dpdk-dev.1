Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02942CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 10:02:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DEDC74270A;
	Thu, 14 Aug 2025 12:02:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 470874026D
 for <dev@dpdk.org>; Thu, 14 Aug 2025 12:02:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755165776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5e3W3N640g1i/qqa+yM5ZNH04ElEY/JI0BN2kXX2+uI=;
 b=Nq4xcKavy8B21pmDqabspLLMIwA5lf/vcHaKEkF2DiiZqKC406doXE4TZaZiLFcAvthjr0
 BY0JjmtmgomkhbOlUHMQub22Y8lX4YoM+Tu84yM9lQvDnpXOtZQDtX/iGljrrt45BbTr6a
 hMMMCAHlP259zXL9h0M3wU1f7LOXOrQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-8V3v7hWzOxqbqI4lHdb_Og-1; Thu, 14 Aug 2025 06:02:55 -0400
X-MC-Unique: 8V3v7hWzOxqbqI4lHdb_Og-1
X-Mimecast-MFC-AGG-ID: 8V3v7hWzOxqbqI4lHdb_Og_1755165775
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3b916fd2cf3so620592f8f.0
 for <dev@dpdk.org>; Thu, 14 Aug 2025 03:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755165774; x=1755770574;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5e3W3N640g1i/qqa+yM5ZNH04ElEY/JI0BN2kXX2+uI=;
 b=GTA6RDQy9p3DAaKjHfhssY0gbwTAqRu5WzGywD9qXYZgpWF9KiI/tH8Gre2DxzJzvK
 P9k6Elc51q0jCsWiVtv0fjWEizOaJK/aeFoU88ETQwwjrD/b7AX3I29j6BkOOQUCU0em
 y2TdypVpMuIOKGnhG9Mq7V4s80R3z94I2QG8f6a4b22osewLwIAZ+PmnjiJIgX+xRsir
 vqhI1I2eOQT4ZiZiqlzE78g0fH7zv/VXJ+WAGhZNZkSiqVlygtyRJ8DbmC9gYf1fffbe
 J4Ddkqmlwk31ZXx9F1/hb6XBdTsptQp9WS/Wl55b2eg0bfjdoZUsJtBEHCpGx8PVFyXB
 trdA==
X-Gm-Message-State: AOJu0YzO0V6Hj4GzI9uXDC1SpJJ7EH8dmLO9aMccWbmMm24dA5d22BDF
 BzIzJq1pO5g49Qfd7TzSv3apPiHT3sm/yNICMdL2Ly9E211a5Nz/dsXVOYu0RVrjPkGn8jHGFG9
 vnof4JRo92CBXGSCRVYxKaaqYOIcoUr91TGY+vqVK+qlh
X-Gm-Gg: ASbGnctaWw1EotrSLvZu1Cr+9+Ia2FUlyFT36Qw4bilZggDTPgtpK6lG+Qb3LDhHMkn
 wp63G7R2sHeGRCUjiNJu5+TYga7tto3ziYTr2KxwEn/7SFBSk5fGlu9bPXkpESkQ3s5NqGXHWGU
 ONoHw0vwHnySn8HjA5naTOZiIiYP4wY+V6LPqGONExF4LOr8LJZgPAJR0hkBhbHnxmb/Vr6szdU
 9nvQRBpp/1SViMeZDhvH5TUKpM6h8kBdMwMemOkfRv7msTLp4yHJzkeLziY4pUKKQHCuFZKmOyq
 GwZLeo+VuiFi3v9r++VUPHiXtSWmHqbXjXudyILoRw==
X-Received: by 2002:a05:6000:2302:b0:3b7:8acf:1887 with SMTP id
 ffacd0b85a97d-3ba508ec36amr1744775f8f.13.1755165774532; 
 Thu, 14 Aug 2025 03:02:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhuUNDBIty8rUNCB/RJMkxht7NE+Sm1T78JnhQfbf/jQgKzlMCDA2NSVoPpQ9CWnPbeMH22w==
X-Received: by 2002:a05:6000:2302:b0:3b7:8acf:1887 with SMTP id
 ffacd0b85a97d-3ba508ec36amr1744742f8f.13.1755165774069; 
 Thu, 14 Aug 2025 03:02:54 -0700 (PDT)
Received: from [192.168.0.56] ([78.16.130.126])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c453ab0sm50724608f8f.44.2025.08.14.03.02.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Aug 2025 03:02:53 -0700 (PDT)
Message-ID: <14a65539-bc56-4e32-8e30-31460e419466@redhat.com>
Date: Thu, 14 Aug 2025 11:02:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 24.11.3 patches review and test
To: "Xu, HailinX" <hailinx.xu@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Ali Alnubani <alialnu@nvidia.com>,
 "Mcnamara, John" <john.mcnamara@intel.com>, Luca Boccassi
 <bluca@debian.org>, Raslan Darawsheh <rasland@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>, shperetz@nvidia.com
References: <20250724161514.396245-1-ktraynor@redhat.com>
 <SJ5PPF04AA7285FA44F7390FE3113CCC24F9F35A@SJ5PPF04AA7285F.namprd11.prod.outlook.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <SJ5PPF04AA7285FA44F7390FE3113CCC24F9F35A@SJ5PPF04AA7285F.namprd11.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sMYSSebW_Hi14qdDBg9zYpddFAtzWPWPKqnt603V3yI_1755165775
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

On 14/08/2025 07:01, Xu, HailinX wrote:
>> -----Original Message-----
>> From: Kevin Traynor <ktraynor@redhat.com>
>> Sent: Friday, July 25, 2025 12:15 AM
>> To: stable@dpdk.org
>> Cc: dev@dpdk.org; Abhishek Marathe <Abhishek.Marathe@microsoft.com>;
>> Ali Alnubani <alialnu@nvidia.com>; David Christensen
>> <drc@linux.vnet.ibm.com>; Hemant Agrawal <hemant.agrawal@nxp.com>;
>> Jerin Jacob <jerinj@marvell.com>; Mcnamara, John
>> <john.mcnamara@intel.com>; Ju-Hyoung Lee <juhlee@microsoft.com>; Kevin
>> Traynor <ktraynor@redhat.com>; Luca Boccassi <bluca@debian.org>; Pei
>> Zhang <pezhang@redhat.com>; Raslan Darawsheh <rasland@nvidia.com>;
>> Thomas Monjalon <thomas@monjalon.net>; yanghliu@redhat.com
>> Subject: 24.11.3 patches review and test
>>
>> Hi all,
>>
>> Here is a list of patches targeted for stable release 24.11.3.
>>
>> The planned date for the final release is 12th August 2025.
>>
>> Please help with testing and validation of your use cases and report any
>> issues/results with reply-all to this mail. For the final release the fixes and
>> reported validations will be added to the release notes.
>>
>> A release candidate tarball can be found at:
>>
>>     https://dpdk.org/browse/dpdk-stable/tag/?id=v24.11.3-rc1
>>
>> These patches are located at branch 24.11 of dpdk-stable repo:
>>     https://dpdk.org/browse/dpdk-stable/
>>
>> Thanks.
>>
>> Kevin
>>
>> ---
> Update the test status for Intel part. dpdk24.11.3-rc1 all validation test done. no new issue is found.
> 

Hi Hailin,

Thanks for the report.

> known issues: fix patch has been merged into main, but they not merged 24.11 LTS, so this issue still exists in 24.11.3-rc1
>   1. Bug 1606 - flow_filtering/flow_filtering_mismatch_rule: Some mismatch rule packets match the rule.
>      - has fix patch: https://patches.dpdk.org/project/dpdk/patch/20250112075200.5020-1-shperetz@nvidia.com/
> 

This patch is in since 24.11.2 [0]. Anyway, it is example code and not
critical so don't need to delay the release for it. We can investigate
more for 24.11.4.

thanks,
Kevin.

[0]
https://git.dpdk.org/dpdk-stable/commit/?id=b540e51a864d25b1e254fa8c311b92223e0f4162

> * Build & CFLAG compile: cover the build test with latest GCC/Clang version on the following OS(all passed)
>   - Ubuntu25.04/Ubuntu24.04.2
>   - RHEL9.6/RHEL10
>   - Fedora42
>   - FreeBSD14.2
>   - SUSE15.6
>   - OpenAnolis8.10
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

