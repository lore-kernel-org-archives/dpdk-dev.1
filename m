Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C79CF89244
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Apr 2026 10:01:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1A86402B8;
	Tue, 21 Apr 2026 12:01:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 718D74029D
 for <dev@dpdk.org>; Tue, 21 Apr 2026 12:01:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776765686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Jx8U06Mt2ng2TwlIUWy+HixT6wdGLKLxMHFz0JOj5Uc=;
 b=RhdnzHKGgCL/2UBTPDQ3HeXWWmzRbP1NwCPrr7B04v/Mw6RHjrrVYOy6klHa1tWTCRjBsC
 wQMMSn59QJKqPYdCWyxBAPnAjiyyac82rSw0rAwve6w0w/X7lbTiilbeXcmS1kgXeFSjLG
 /e2e4P+b8BKbdyaddyDZ7fgMM6Rkwvc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-pwNmKW0MNMuwb8tpfA25Ng-1; Tue, 21 Apr 2026 06:01:24 -0400
X-MC-Unique: pwNmKW0MNMuwb8tpfA25Ng-1
X-Mimecast-MFC-AGG-ID: pwNmKW0MNMuwb8tpfA25Ng_1776765683
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b844098869cso303132066b.2
 for <dev@dpdk.org>; Tue, 21 Apr 2026 03:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776765683; x=1777370483;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jx8U06Mt2ng2TwlIUWy+HixT6wdGLKLxMHFz0JOj5Uc=;
 b=sZjLCkAczBjPVbqAkg2XzBq+18cmFxgcKY8yieqZuoSQleYYYvnRld+QTONvTmEB6e
 DYcUoHQVZGM0d+L0faTaDUBP51LAj2PEE2x028kx5rKVglSr1vq1tx4Fha+8G9UHaELi
 /3Vz9O7f3/PUSjeBNAcFwdAzf95ofLMzT/BQzxUv5GrIYVvkhFck8m2EZwyQtCvatcbb
 4oy/c1z7TDwput4N8nuCHpXFKHS5vjokstXtlnlMZRIckGgQR6dxUiUX5osAov0HycjN
 POf6wLD/+vqXSDHyfzUYNTjsXWpTki7pZnr1PcekCQ1AmCg99MM47EG4LHN6r9zOgA6f
 rk+Q==
X-Gm-Message-State: AOJu0Ywg5t7I0Z2xsft+Qs5vCkLsfKBLfUBj+pYK0ujIkihmZbKSUHvS
 ElWSRBrj+H8PVNndeC/GQlZipZDn6AYykGRi9U9OxKZNppoapqGRTnTf2z7yXV2j7m2j49oFaHX
 9q7BvtnrEAeMHKkCiFJHDrgiJPj0Az/Vzpa52Vpz5aIBE
X-Gm-Gg: AeBDiesD0BkcyJZ4z2k7OozqZKzx0ERPA/d78DV/AjOtzGrQQG850pQyESgMo2hEPky
 Qvoz364Fy7llWWzwxBYFVnkx2hLTCsxAgMvO79hrvIUOYuSPvBJQMJqvhhul6eX7oyd5R1CsrVR
 +CpP6zG2xCB38lNwNseb//2Kl0FLJTZ4kf+7Ic3H/oIVzGDVpaaSXO3zMTX8weiv2wxHj2oy7Z+
 YhGQdsdagtAtxkk9D1G+CsX77lb2aYAslKZ2zP073XZy6rTr1ACPYime1uzhkc6Xo6ss25bNRdq
 EoGGGYcdcEq4pZJMaPC6hUTcbST+uINJfZOUZ8eqf+DT7UA9gDA1sthakfve5ZPdhvtTdKgQqgp
 v/IjreSyAUHJf52v8kCtckLodhQn47s2/sg==
X-Received: by 2002:a05:6402:2714:b0:676:54d5:bc70 with SMTP id
 4fb4d7f45d1cf-67654d5c1f2mr2819943a12.25.1776765682868; 
 Tue, 21 Apr 2026 03:01:22 -0700 (PDT)
X-Received: by 2002:a05:6402:2714:b0:676:54d5:bc70 with SMTP id
 4fb4d7f45d1cf-67654d5c1f2mr2819882a12.25.1776765682203; 
 Tue, 21 Apr 2026 03:01:22 -0700 (PDT)
Received: from [192.168.0.65] ([78.16.130.40])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4412150a071sm945221f8f.21.2026.04.21.03.01.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 03:01:20 -0700 (PDT)
Message-ID: <d24d7948-2087-453f-8978-431a73b6dd66@redhat.com>
Date: Tue, 21 Apr 2026 11:01:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 25.11.1 patches review and test
To: "Xu, HailinX" <hailinx.xu@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 "Puttaswamy, Rajesh T" <rajesh.t.puttaswamy@intel.com>,
 "Hosamani, Manjunathgouda" <manjunathgouda.hosamani@intel.com>,
 Luca Boccassi <bluca@debian.org>, Thomas Monjalon <thomas@monjalon.net>,
 "yuan.peng@intel.com" <yuan.peng@intel.com>,
 "zhaoyan.chen@intel.com" <zhaoyan.chen@intel.com>,
 Shani Peretz <shperetz@nvidia.com>
References: <20260402164454.669125-1-ktraynor@redhat.com>
 <DS4PPF00BBED10C3C2A50F6C7CFB30360539F2C2@DS4PPF00BBED10C.namprd11.prod.outlook.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <DS4PPF00BBED10C3C2A50F6C7CFB30360539F2C2@DS4PPF00BBED10C.namprd11.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WjizsjP3mQY-CjU02X1WUFCqoy_VKaWuDVuTFfey_Yw_1776765683
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

On 4/21/26 2:44 AM, Xu, HailinX wrote:
> 
>> -----Original Message-----
>> From: Kevin Traynor <ktraynor@redhat.com>
>> Sent: Friday, April 3, 2026 12:45 AM
>> To: stable@dpdk.org
>> Cc: dev@dpdk.org; Abhishek Marathe <Abhishek.Marathe@microsoft.com>;
>> Ali Alnubani <alialnu@nvidia.com>; benjamin.walker@intel.com; David
>> Christensen <drc@linux.vnet.ibm.com>; Hemant Agrawal
>> <hemant.agrawal@nxp.com>; Ian Stokes <ian.stokes@intel.com>; Jerin Jacob
>> <jerinj@marvell.com>; Mcnamara, John <john.mcnamara@intel.com>; Ju-
>> Hyoung Lee <juhlee@microsoft.com>; Kevin Traynor <ktraynor@redhat.com>;
>> Luca Boccassi <bluca@debian.org>; Pei Zhang <pezhang@redhat.com>;
>> qian.q.xu@intel.com; Raslan Darawsheh <rasland@nvidia.com>; Thomas
>> Monjalon <thomas@monjalon.net>; Yanghang Liu <yanghliu@redhat.com>;
>> yuan.peng@intel.com; zhaoyan.chen@intel.com; Shani Peretz
>> <shperetz@nvidia.com>
>> Subject: 25.11.1 patches review and test
>>
>> Hi all,
>>
>> Here is a list of patches targeted for stable release 25.11.1.
>>
>> The planned date for the final release is 21st April 2026.
>>
>> Please help with testing and validation of your use cases and report any
>> issues/results with reply-all to this mail. For the final release the fixes and
>> reported validations will be added to the release notes.
>>
>> A release candidate tarball can be found at:
>>
>>     https://dpdk.org/browse/dpdk-stable/tag/?id=v25.11.1-rc1
>>
>> These patches are located at branch 25.11 of dpdk-stable repo:
>>     https://dpdk.org/browse/dpdk-stable/
>>
>> Thanks.
>>
>> Kevin
>>
>> ---
> Update the test status for Intel part. dpdk25.11.1-rc1 all validation test done. not found new issues.
> 

Hi Hailin, great - thank you for testing and reporting this.

thanks
Kevin.

> * Build & CFLAG compile: cover the build test with latest GCC/Clang version on the following OS(all passed)
>   - Ubuntu25.04/Ubuntu24.04.3
>   - RHEL10/RHEL9.6
>   - Fedora43
>   - FreeBSD15
>   - SUSE16
>   - OpenAnolis8.10
>   - OpenEuler24.04-SP2
>   - AzureLinux3.0
> 
> * Function tests: All test done and passed
>   - i40E-(XXV710, X722) PF/VF: test scenarios including basic/RTE_FLOW/TSO/Jumboframe/checksum offload/mac_filter/VLAN/VXLAN/RSS, etc. 
>   - IXGBE-(E610) PF/VF: test scenarios including basic/RTE_FLOW/TSO/Jumboframe/checksum offload/mac_filter/VLAN/VXLAN/RSS, etc. 
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

