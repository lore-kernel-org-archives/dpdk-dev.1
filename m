Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28E0F89249
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Apr 2026 10:14:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6D66402B8;
	Tue, 21 Apr 2026 12:14:10 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 930C54029D
 for <dev@dpdk.org>; Tue, 21 Apr 2026 12:14:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776766448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1qI6Ha4ZxKRgAE9UYCVtzMEU1tshTK3sVoMGMizbgsM=;
 b=SOixhDvXpQ8K+YFJO26hwMBiyKg7lTBKxnx2iRPN0gxDhIHwC2A+GBA5skFGZJsDD8E/m9
 y736O26mU7zSDN9OiUzrCLcrQmSwW/qOs/1C5PJXzNmxgQDffKTGorfxGTkRBojimhTy75
 FKDttwtl6A9QFTmxQpsi88UlgqsK/wU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-i49l5np9MpGf_9yPn77XGA-1; Tue, 21 Apr 2026 06:14:04 -0400
X-MC-Unique: i49l5np9MpGf_9yPn77XGA-1
X-Mimecast-MFC-AGG-ID: i49l5np9MpGf_9yPn77XGA_1776766444
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-358df8fbd1cso5487399a91.0
 for <dev@dpdk.org>; Tue, 21 Apr 2026 03:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776766444; x=1777371244;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1qI6Ha4ZxKRgAE9UYCVtzMEU1tshTK3sVoMGMizbgsM=;
 b=YTHGpCIZIIST1x+bWvarygQQqbcawmNvwuyO9fqrL7WqS/rrh0NNnl7s3JtHR2VUe3
 LUuLek5U+swylAgY1aOJl72ApwwpP1qwDoidR7VXvvT5w9abshRa8k9/f+fNl1uniSvM
 3muA0nvVE+de9iyDeV6aoUkAZcbPEnAkIGDaLoxUK3sITKDKpoDWtxk2Q5Wndbnhvhqb
 HclMHFKlqFx9qJoSnvq4L19PDtCdIl1qQC1FvWuvhKxC4iiB7I3h9QqMDmEXsKknySfr
 SypoPRgmbWSQws4Z9J4YUjLuTNL1qvQaYHsVtAG9qhsCyicljsCnZwdqhsBFZqaGPnku
 zy+Q==
X-Gm-Message-State: AOJu0YybZ6Madg1vvFZeykiknANXnnU5oPDRFvSGfh01t9oSSRRqLDHp
 RYElawqAJfOtBeYYh0LiSEfn3CUS3suLWgb8pr99Bt7Litcm7fu7nAAreP+IFa7toX7aluQSCV6
 lCxfK39aQ0sCz4jLSmUrqItw3LxrOduta3/f7OavWt009
X-Gm-Gg: AeBDieujYMX/2DeLprvpimMXTP7ll/nyP3w16foarRM3O+gR3sSgrb83dnTP3h5ck/T
 0djDb73fJcpKhXevO4Bfib50BRse/2z2qkaaCGRYkJnaNAvWptGyI537KMZr9xieQy2k29/yoZv
 Y/eazedWtsZchpFyVyeV1/MtCW5qjXOJY8nqBIoIXQV4Qepl0dpZQ8q8MzKhDeMHcRsszdy3H25
 yUJMta8Q5WL2/u5X/BavEKhmF+gV+PX6Gb6aZ9QhVIBcs1Q111uoRsJys4jJ3sJt2KJcUsO36x4
 2oNWtPKAHoMud6HZdjiNuJzT7qbQdnatzDuCLZlOOz9c8hSGuCxw9cgO7hLRroX6us0uKuJJzNn
 NMatXDIAC2kl2ccptHXB8iDbe6av7+iys1A==
X-Received: by 2002:a17:90b:3c52:b0:35f:b50e:defc with SMTP id
 98e67ed59e1d1-36140473f07mr18584673a91.16.1776766443703; 
 Tue, 21 Apr 2026 03:14:03 -0700 (PDT)
X-Received: by 2002:a17:90b:3c52:b0:35f:b50e:defc with SMTP id
 98e67ed59e1d1-36140473f07mr18584639a91.16.1776766443260; 
 Tue, 21 Apr 2026 03:14:03 -0700 (PDT)
Received: from [192.168.0.65] ([78.16.130.40])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3614195a9fbsm17090738a91.11.2026.04.21.03.13.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 03:14:02 -0700 (PDT)
Message-ID: <e3b57004-9f21-480f-97f2-13c305e25547@redhat.com>
Date: Tue, 21 Apr 2026 11:13:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 25.11.1 patches review and test
To: Ali Alnubani <alialnu@nvidia.com>, stable@dpdk.org
Cc: dev@dpdk.org, Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 benjamin.walker@intel.com, David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Jerin Jacob <jerinj@marvell.com>,
 John McNamara <john.mcnamara@intel.com>, Ju-Hyoung Lee
 <juhlee@microsoft.com>, Luca Boccassi <bluca@debian.org>,
 Pei Zhang <pezhang@redhat.com>, qian.q.xu@intel.com,
 Raslan Darawsheh <rasland@nvidia.com>, Thomas Monjalon
 <thomas@monjalon.net>, Yanghang Liu <yanghliu@redhat.com>,
 yuan.peng@intel.com, zhaoyan.chen@intel.com,
 Shani Peretz <shperetz@nvidia.com>
References: <20260402164454.669125-1-ktraynor@redhat.com>
 <9beb13d5-8072-4b34-8db9-2c472d6d6803@nvidia.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 xsFNBF2J2awBEADUEPNhgNI+nJNgiTAUcw4YIgVXEoHlsNPyyzG1BEXkWXALy0Y3fNTiw6+r
 ltWDkF9jzL9kfkecgQ67itGfk1OaBXgSGKuw1PUpxAwX2Bi76LAR6M5OsyGM9TSVVQwARalz
 hMwRBIZPzPc7or6Pw7jAOJ8SQGJ1Zlp1YJCjrvpe87V1tH/LY8Wnxn/EuoseFmWILAQZAtYS
 tGjcrAgYn3SPMLR1B0BP5bTBY06vWQjiufH8drenfDnMJAzuBdG1mqjnTqCjULZ3Hunv4xqZ
 aMnkvL/K5Tj1c12Oe4930EE53LrXIBUltRg5mBudSWHnC7twjH0082HH9f963Z/2UI63SFIT
 iUvRvAzJYytgy7XnWLQ0+goZBADKYfolOuC0H8VgCaux8u8KFF28Dy+N6TV2KI58jTlyg1Zu
 l7QwykZpnOkJFiy37Gfbu3YEOzO72cP/S7/A+zvuqkxi63jyEkd+FY99vLt/HN2MUZwRmKDw
 UPbLkmrs8WU01/POVsqDcfvz7vu2St8hqqTiSIdQGS2zyTKB2/DvPSM3jws3udkIYSuhn+X4
 QBiV6lkVZ7DSE6a065gnAauAql+b32Eymy+xnG5jCt1tR+0Cp2VZYCR9OU2gmomUKBDoX/He
 pSgED01CqYPNjN+TddirwmQX7ep4DtXc8FWvv2g/pq9WZFQk2QARAQABzSNLZXZpbiBUcmF5
 bm9yIDxrdHJheW5vckByZWRoYXQuY29tPsLBjgQTAQgAOBYhBAoiOaH51tHF7VYtEI9CINER
 a+yJBQJdidmsAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEI9CINERa+yJoxIP/3VF
 2TIgW4ckxhRFCvFu/606bnvCPie88ake4uWVWMAWwcMc4fKEltRWRCpkSVOwgqoMHnyHxK5r
 kOKzx2CLJMX5TgTMfKzPuaBDHngHLUzl2DStpBzrod0cVg5TShdmmfjY61uxRJKz+DlSkwgJ
 riADdVF5PPosQXTkKSGf2ombpTGpx/pue9ocjnr3x4SDpRLlnooM6Jf/3Y3Ib4jX6HPEyWuY
 b+owIIk9y2nRRGPQ6jbqAhsrXd9V+77UL0QuGWloMuKMZFbNg8hbu7X5aFijAbfxj4YUgojS
 ba7gfGZQan8h32A9KGQWrmsCBc3j2GqEPsX0r05X7cn7WL6IOPgQJ5EiQ7PlazQYVLrvZg9B
 n0GKK0k6895mLG0ZZ5v/qajOPF52etSmvFD1WUPb4OqaHqGA9ZtMpaKFRt7Y6rpXqKNU1xzW
 F5KjbTPtTb9WF3An8dciVv+AYUI7totkZYkWvQtgss8lfaX3NKUvXLVxqK0z3dQyr7rF/tYz
 PneTKypSksjCgaEBLSrsRmM5zKfe7tSNF/fDntfIq/029Jtcw29TcWEP57peNu6TtejewQD9
 sTI+oqiXvW2D5l7LNUDYG8eMJp2oT7I0ZSBRvwcbmjH0DtN/bXCCFfCvk8Yic68F3tV1ctix
 wQARVKDBhT30uCxycRWojCYqTgNJJS71zsFNBF2J2awBEADP57PR2IpSYBeNSrsAjeIcsahE
 N4SQP2C4s50S8QEWAUhqMRI7WNv5cfeef0nDvcl1IUA6oz5SokbcsbMa+mRgaNF4N5KikWTO
 LPYxq2YVJoXwJ+tKmNzyOLFUIfFJ4NBJZple5dTfWzD00Dbb19Mri1hy1mWMqNTPGBee1+hw
 Qcp6n3mmGECvajs8G5A7NyXbwL8ihN7HX9D01ucD62b4G03yKe2g/hvKgcdUVmhCldJlF27I
 2fSR9tDxH9pZqRODY4rjbFZEey/vWKXqjE+DQ8AtMSEaDfFe5D+i4Aw6erWQ3Wr+DwZt1/7G
 dIAElGA/q90T1ENVwJX9y7fsQssawKYYdDqURHCl5JuDXI+VXUypExipUUT5SPycMmbLsx0D
 iKEqPPDQWKxkIDVKqj2+EhamSuJznZUwBLJKn0h4zrIWiXWUy07lRwtVuhaDXhF3GfW+5W/x
 wAg7Qg3w00ASsb/XTHBIhMnenKDfS7ihtQA8SacwX8ySdxb+15XPyiplM979qBQ0mhnilulm
 MIJzEf/JxoYR5huuj4f1PFqqrsP06Dl+YGB7dQZp3IKggS5c3/TAynARRg9N89UsDXNtp7X0
 tgIPFF5k6fnHE0J5O64GYHeTqN/1aE6dAEOV9WrGzQAJxU9ipikb8jKAWXzLewRIKGmoPcRZ
 WdB0NmIjmQARAQABwsF2BBgBCAAgFiEECiI5ofnW0cXtVi0Qj0Ig0RFr7IkFAl2J2awCGwwA
 CgkQj0Ig0RFr7IkkORAAl/NbX93WK5MEoRw7/DaPTo/Lo6Pj1XMeSqGyACigHK/452UDvlEH
 NjNJMzYYrNIjMtEmN9VVCfjT38CSca7mpGQVwchc0mC7QSPAETLCS+UacVf/Kwxz5FfkEUUw
 UT7A+uyVOIgW3d9ldlRzkHA2czonSSgTQU+i2g6DM4ha+BuQb4byAXH6HQHt/Zh1J64z0ohH
 v6iGsCzCY/sMWF8+LEGSnzMGRCLiiwSF0vJBHbzWK68fANaF4gBV0Z/+6tQRFN7YMhj/INmk
 qgvHj1ZzHFNtirjMGPRxoZs51YoLQM/aBPxKrnmXThx1ufH+0L6sGmFTugiDt0XSEkC5reH7
 a+VhQ1VTFFQrClA8NmDSPzFeuhru4ryaaDHO+uEB16cNHxHrQtlP/2hts2JM5lwkZRWJ5A57
 h8eDEIK5be47T85NVHfuTaboNRmgg1HygVejhGUtt69u/0MVRg/roUTa0FyEbNsvz4qAecyW
 yWzMcVrcGJDQLC9JLKEpoyUF6gdTKaiDL2Vao4+XRIA3Y57b6MO35a3HuzAv7+i5Z0mnDEJO
 XxXqTOmKYpMIGexzM/PtuA0712sT1abG9tAJ17ao/B7cqMW5IkKkalemFbWfI2unns4Papvo
 tk9igVqyp6EJDU98z5TJioCVojwK2laDaoIjTJk9YYv3iwCsqPd5feU=
In-Reply-To: <9beb13d5-8072-4b34-8db9-2c472d6d6803@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BsQ49Zks078aoDehWAiR8PXo4-Unl2uhkA7dIKAdbM8_1776766444
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

On 4/20/26 8:37 PM, Ali Alnubani wrote:
> 
> On 4/2/26 7:44 PM, Kevin Traynor wrote:
>> Hi all,
>>
>> Here is a list of patches targeted for stable release 25.11.1.
>>
>> The planned date for the final release is 21st April 2026.
>>
>> Please help with testing and validation of your use cases and report
>> any issues/results with reply-all to this mail. For the final release
>> the fixes and reported validations will be added to the release notes.
>>
>> A release candidate tarball can be found at:
>>
>>      https://dpdk.org/browse/dpdk-stable/tag/?id=v25.11.1-rc1
>>
>> These patches are located at branch 25.11 of dpdk-stable repo:
>>      https://dpdk.org/browse/dpdk-stable/
>>
>> Thanks.
>>
>> Kevin
>>
>> ---
> 
> Hello,
> 
> We ran the following functional tests with Nvidia hardware:
> 
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
> We ran our testing with Shani's backport for 9ec0c6bda04a ("net/mlx5: 
> add RSS TIR registration API") on top of  v25.11.1-rc1. Environments:
> - NIC: ConnectX-7 / OS: Ubuntu 24.04 / Driver: DOCA-Host 3.3.0-088000 / 
> Firmware: 28.48.1000
> - DPU: BlueField-3 / OS: Ubuntu 24.04 | DOCA SW version: 3.3.0 / 
> Firmware: 24.48.1000
> 
> We have not identified any new issues caused by changes in this release; 
> however, we are still investigating test failures that are suspected to 
> be related to environment changes.
> 

Thanks for testing Ali. I don't mind waiting a few more days for the
release if you want some time to investigate this ? or if you are fairly
confident it is environment changes, I can go ahead with the release.

Let me know which you prefer.

thanks,
Kevin.

> Thanks,
> Ali
> 

