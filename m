Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8C0F54ABA
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 14:13:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C79BD402BE;
	Tue, 24 Mar 2026 15:13:11 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id D26FC4025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 15:13:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774361590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Zaf534HuRf7s6ehM0qdcBi00HETFFDOcHTwtU8Gl3l4=;
 b=C/3kCrAQTHgTLtenK9npmIHv4995vhAYiwo00m5JtpvfCccSTgjzS2Kp9lDi5IAKs1Yh9M
 0msMyultJulvRHUGEbkrSOqHPGv1k+moeZX4vjKEZxD5JQ8fY7ExyFo3jZBY1P7dJ8i+RJ
 fXUXR+S2L6X9GtrslUvrKD7ylC1mBK0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-0mONBAIdPZ-Vu4edMJuJvw-1; Tue, 24 Mar 2026 10:13:09 -0400
X-MC-Unique: 0mONBAIdPZ-Vu4edMJuJvw-1
X-Mimecast-MFC-AGG-ID: 0mONBAIdPZ-Vu4edMJuJvw_1774361588
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cfda078676so1988879885a.2
 for <dev@dpdk.org>; Tue, 24 Mar 2026 07:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774361588; x=1774966388;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zaf534HuRf7s6ehM0qdcBi00HETFFDOcHTwtU8Gl3l4=;
 b=liEQSDQ9BOyy36L44k2SBsX7YRJgG4X/UeJXyg5MXCgvmkxsPldhhFG1DJYpJZ/QBs
 EG700JAw7HHPPjLUL0YhBSSuNWGnC33ppN8usJkFrgLhS6PorXJTsOAAj2E0NLTHG0NJ
 so1tq2VdTYDhQxjiZXCG/Pqd+wRKEVlPqjAw8E9+JJdZzKKNs/XXrKByzRmmXpv1b57M
 hxi0Q1SJOrHPOvF27ZmBAO+nqy0qVIqcRnJTDlV0AetipEM1P7m7E2PUpC9qtbdkuCw4
 YaTeep7gV+jD0zjyo1mVT7Qwwh9c1ESKslplo57y58z+11aVWRvTCN6Um1rAjKXzrviO
 6BNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwQCKRiod76IQIxHd+JR0R76RsYm2Nl2V2hZ1wnei7IWKU4Jet7pwAYiUSanTNnXDvJZI=@dpdk.org
X-Gm-Message-State: AOJu0YwZVWc4dW7OC4G9wBxLizWXd98OahayJqzqgTHEbHF/oAQdPff2
 lotSYlK9e0suvGEp7CupjxxUB9wxMr6/HWL937ByrEjECjYczclluIctzXL3w3ytNNeV7EXPYKk
 NIuVgsMHtaRNP0iRX9YbS+9LoT265W7Bwm7XI5BC6dNcq
X-Gm-Gg: ATEYQzxhJsJ1dt0GWZwNzt8GlWzxv2UxuoMrzo7a/Vt7xRIhvMrfgc6tNIvkStOpNhv
 s7An97z/IWcL+a5wnc1GXr65BMYUKZWpxEcN+5wWVjLb6aYWtbCJUhK5J/sdEvyzTDRZq0zA4CX
 CsCvDesDTvxuBp6lvN6oDMFP/Do6gF8zZy/Mej6udO3ejdl9RQZG68E7COiKG+8TYq9rgdmB2XQ
 BxPHUl4oHfNyqsBE2cHSrJaSh+jIX3w+rH/0cP1SZfzvuBDxWitNH9Zst1utkdbrqrU8I48JZcc
 vMQmAHTjoZ0IbGIT3Os50iX+/jnt3B2IgrIiqdGgWqcX6byWniXdbpbpwkwH/nfpBOxichwFIwu
 F6R5g0ViGYuBzmQ+aPS0Nc2RO
X-Received: by 2002:a05:620a:4892:b0:8cf:d62a:c81d with SMTP id
 af79cd13be357-8cfd62acc82mr1794648685a.29.1774361588332; 
 Tue, 24 Mar 2026 07:13:08 -0700 (PDT)
X-Received: by 2002:a05:620a:4892:b0:8cf:d62a:c81d with SMTP id
 af79cd13be357-8cfd62acc82mr1794636685a.29.1774361587344; 
 Tue, 24 Mar 2026 07:13:07 -0700 (PDT)
Received: from [192.168.0.65] ([78.16.129.161])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cfc8f926e0sm1152200785a.12.2026.03.24.07.13.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 07:13:05 -0700 (PDT)
Message-ID: <f5d3c1f8-f3f1-49a3-b075-f0684ce21023@redhat.com>
Date: Tue, 24 Mar 2026 14:13:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] drivers: cleanup devargs lookup in bus scan
To: David Marchand <david.marchand@redhat.com>, dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Parav Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@altera.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260323105306.1531689-5-david.marchand@redhat.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <20260323105306.1531689-5-david.marchand@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e2PXJnJElOLeYmGJj5elMZeaW-p6bq4BJSpn_H8OS7E_1774361588
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

On 3/23/26 10:52 AM, David Marchand wrote:
> Don't hardcode the bus names in the RTE_EAL_DEVARGS_FOREACH() calls.
> The bus name is set by code in EAL.
> Even if there is nothing broken, let's reuse the name from the bus object.
> 
> And remove the now useless macros.
> 
> Note: in the ifpga bus case, the call was using an incorrect macro
> (IFPGA_ARG_NAME instead of IFPGA_BUS_NAME), yet it was working fine
> as this macro is aligned with the ifpga bus name.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/bus/auxiliary/auxiliary_common.c     | 2 +-
>  drivers/bus/auxiliary/bus_auxiliary_driver.h | 2 --
>  drivers/bus/cdx/cdx.c                        | 3 +--
>  drivers/bus/dpaa/dpaa_bus.c                  | 6 ++----
>  drivers/bus/fslmc/fslmc_bus.c                | 8 +++-----
>  drivers/bus/ifpga/bus_ifpga_driver.h         | 2 --
>  drivers/bus/ifpga/ifpga_bus.c                | 4 ++--
>  drivers/bus/pci/pci_common.c                 | 2 +-
>  drivers/bus/platform/platform.c              | 2 +-
>  drivers/bus/uacce/uacce.c                    | 2 +-
>  drivers/bus/vdev/vdev.c                      | 2 +-
>  drivers/bus/vmbus/vmbus_common.c             | 2 +-
>  drivers/raw/ifpga/ifpga_rawdev.c             | 2 +-
>  13 files changed, 15 insertions(+), 24 deletions(-)
> 

Acked-by: Kevin Traynor <ktraynor@redhat.com>

