Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CFDCCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 14:56:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA5C8409FA;
	Wed,  5 Nov 2025 15:56:30 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2AD1540687
 for <dev@dpdk.org>; Wed,  5 Nov 2025 15:56:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762354588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Dr8kA5VmNrd1rosOD8gVEfXKTPEfNKZler8aadsymBg=;
 b=MyTKxTnDp1I8qSrA/b8/xtHmgcjwKgL4EOmk4n0tRjWSfXy0uYEsRe94f9kM3N+RS8uQav
 LYvFVS9jPAL1JsLS85iHoYSBL4a08ssbPkxdf29gGauBgdpJrJcwlWJjofpSoWP0sIbeLi
 WLYm5Sk2XN0FbfHSXIaBNORXK86iskc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-uJ_MC62cMeeYhMQK_FFIJw-1; Wed, 05 Nov 2025 09:56:26 -0500
X-MC-Unique: uJ_MC62cMeeYhMQK_FFIJw-1
X-Mimecast-MFC-AGG-ID: uJ_MC62cMeeYhMQK_FFIJw_1762354585
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4773e108333so31272765e9.0
 for <dev@dpdk.org>; Wed, 05 Nov 2025 06:56:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762354585; x=1762959385;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dr8kA5VmNrd1rosOD8gVEfXKTPEfNKZler8aadsymBg=;
 b=AsXkVmYmG8zt9c1c8fJ//GVmPilUU1+JmJV71w4X2/NrKzbfpfbOF289KA5cRUXpJH
 9sLrogZDCThhtb9nsk6Y8wZ7FJe6cfTTClJ+kPQCrfEW7rlpFDIv20ZR1yxGPgwGw88g
 e98VoHeBuuNJCcB51vrEsRhc6Ir/nPNwyvDqtshjBH0PBUYjZyNndT8XhooqRVKibWiR
 esrEIlGyLPvqAPEi1rcdFONFJtWxLm68UiJH0PoF/wM4FAZIgdBJ3AFSL/+JsAPE6dYL
 +E58c/rGynALRw+psXeOe3a/SfsnnHJEb3zLKE+6BycG4NrU96MJaQign20n/r56TvL8
 swxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1ZGkaYU+jlcpWbq7vbvKFPRoj+zWUqLjDGifTPShn7cSPVlGhFKoTWWEpA6a220Hll8s=@dpdk.org
X-Gm-Message-State: AOJu0Yz4JsKDg7uEn002OpcuL/HkNRzHQ+YHAeN1FeTyhYBYlI7Gn2nI
 C5l0PtUJ4WBwOxz8+4/FUHaJ7WJVt1RddKjHMZKJ1ovBVC5+dxIQLok1zA3HeUqyU6sKM5bkZsR
 vjpAAB7zeRcRDFmBBSPUlKyuXO9aisTuu8Qu3HicgWRZk
X-Gm-Gg: ASbGnct5xScLtQ2o5hXds4fOVhTYR40HJiyPYclx8HRaUMLsqf1KcO03EV7s3PGhcJJ
 8IsgRWWSW+M9yJ4ZZLNGpozCcGdu2aT+CGPk+caacAjoQmpp0pqYyyeahH6xPHrLcjw0SiNGdIV
 N1RHduUffIj2f4XLPcbFP/ge5uge4Uu0Dn4IafE3RMnT/cKdUTyFH/Fi7hhfvSwyMa+QL0cOW/M
 iYF0ud3mjnMwzn/OAQfPZyiKwLMzBVrrkrCVeo8b5XjTR52Al5trGKqFXX0paB/fqq+yAvOZ+nT
 PJw6WI0KHHjRuLpRHJ1ykvK3PtuGQWB7OGBOZwl2zvI5okIiwtMjEvQGECam6HnJSYH5eOvZKdP
 m
X-Received: by 2002:a05:600d:8315:b0:477:55c9:c0c2 with SMTP id
 5b1f17b1804b1-4775cdbfb96mr17242375e9.12.1762354585337; 
 Wed, 05 Nov 2025 06:56:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgM8SzRwaid4ua9Fs9NpiWB4Hru907kanzowsPI9pJDol81q+ZUMoWFIEUxwAGrPISWvyOhQ==
X-Received: by 2002:a05:600d:8315:b0:477:55c9:c0c2 with SMTP id
 5b1f17b1804b1-4775cdbfb96mr17242235e9.12.1762354584938; 
 Wed, 05 Nov 2025 06:56:24 -0800 (PST)
Received: from [192.168.0.56] ([78.16.130.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4775cd44575sm53445565e9.0.2025.11.05.06.56.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Nov 2025 06:56:24 -0800 (PST)
Message-ID: <1da58d87-a6f5-4929-a20e-7eb1f238e14a@redhat.com>
Date: Wed, 5 Nov 2025 14:56:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] app/testpmd: fix devargs format in port attach
To: Gregory Etelson <getelson@nvidia.com>, dev@dpdk.org,
 stephen@networkplumber.org
Cc: mkashani@nvidia.com, rasland@nvidia.com,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Aman Singh <aman.deep.singh@intel.com>, Shani Peretz <shperetz@nvidia.com>
References: <20251030092016.226974-1-getelson@nvidia.com>
 <20251031061816.333400-1-getelson@nvidia.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <20251031061816.333400-1-getelson@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Wq3T8CBZ-8NQq3NiYzfpAwvhWntSzEuhI5ClQNxqK6A_1762354585
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

On 31/10/2025 06:18, Gregory Etelson wrote:
> The port attach procedure discarded PCI port devargs provided
> by application.
> The patch restores PCI port devargs.
> 

There is a bugzilla for this issue, so it can be added to the commit

Bugzilla ID: 1815
> Fixes: 12c2405989f6 ("app/testpmd: canonicalize short PCI name format")
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---
> v2: add buf_size parameter to convert_pci_address_format()
> v3: use snprintf()
> ---
>  app/test-pmd/testpmd.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
> index 2360da3a48..b10f6baee2 100644
> --- a/app/test-pmd/testpmd.c
> +++ b/app/test-pmd/testpmd.c
> @@ -3417,6 +3417,7 @@ convert_pci_address_format(const char *identifier, char *pci_buffer, size_t buf_
>  {
>  	struct rte_devargs da;
>  	struct rte_pci_addr pci_addr;
> +	size_t pci_len;
>  
>  	if (rte_devargs_parse(&da, identifier) != 0)
>  		return NULL;
> @@ -3431,6 +3432,8 @@ convert_pci_address_format(const char *identifier, char *pci_buffer, size_t buf_
>  		return NULL;
>  
>  	rte_pci_device_name(&pci_addr, pci_buffer, buf_size);
> +	pci_len = strlen(pci_buffer);
> +	snprintf(pci_buffer + pci_len, buf_size - pci_len, ",%s", da.args);
>  	return pci_buffer;
>  }
>  
> @@ -3439,8 +3442,8 @@ attach_port(char *identifier)
>  {
>  	portid_t pi;
>  	struct rte_dev_iterator iterator;
> -	char *long_identifier;
> -	char long_format[PCI_PRI_STR_SIZE];
> +	char *long_format, *long_identifier;
> +	size_t long_format_size;
>  
>  	printf("Attaching a new port...\n");
>  
> @@ -3448,9 +3451,15 @@ attach_port(char *identifier)
>  		fprintf(stderr, "Invalid parameters are specified\n");
>  		return;
>  	}
> +	long_format_size = strlen(identifier) + PCI_PRI_STR_SIZE;
> +	long_format = alloca(long_format_size);
> +	if (long_format == NULL) {
> +		TESTPMD_LOG(ERR, "Failed to attach port %s - allocation failure\n", identifier);
> +		return;
> +	}
>  
>  	/* For PCI device convert to canonical format */
> -	long_identifier = convert_pci_address_format(identifier, long_format, sizeof(long_format));
> +	long_identifier = convert_pci_address_format(identifier, long_format, long_format_size);
>  	if (long_identifier != NULL)
>  		identifier = long_identifier;
>  

