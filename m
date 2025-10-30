Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9551CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 15:53:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8DFC4026F;
	Thu, 30 Oct 2025 16:53:09 +0100 (CET)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 by mails.dpdk.org (Postfix) with ESMTP id 7494840150
 for <dev@dpdk.org>; Thu, 30 Oct 2025 16:53:08 +0100 (CET)
Received: by mail-oi1-f181.google.com with SMTP id
 5614622812f47-44daa894741so366258b6e.1
 for <dev@dpdk.org>; Thu, 30 Oct 2025 08:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761839587;
 x=1762444387; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SztFEtiNhilZHJ71W7cSOCKrmtfBKCsuYSvJ6FoZB54=;
 b=mSMIRf96Vg2Fa1EvrVPpN++vANKTNhxzEHKXaG12/MLiWMe3oFEt9myKi8ar1Uqhee
 t7RcI88MSoE7sDfsVE/VsRUHziK0RTJfEdB0jEBCjtMp82D1XUb55Fkphr5s3slM8DeH
 YAigJMci4p83z75FpB81W3svQE5/xlxJJ8KHcbI29iKe1oYQsOwzwAcmtRaYkj7N/FLc
 oGsQ0a4PYFH1w/55jDeeZwRmFpjF6zQ5VUzOqrgyEGZEdQKDXqc0nG/2OvhCMh7Zskxq
 3B3/yeB15t0ixksGWUz30mUs0lnQ2fTykzgjg/6ZNSYyaXWdrcMfsPL0STM/Cei4wUUc
 pkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761839587; x=1762444387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SztFEtiNhilZHJ71W7cSOCKrmtfBKCsuYSvJ6FoZB54=;
 b=Bbjn4Do7Fm/dCpUtp0RTX8IFEd0yZwSb3dHk6G+4R0p00wA84iSyBHHlbfCVH23a9b
 TlGcS1JVzi3C3Y68Dwj/MENZ55Vgn++eYbRFl1n9JawsiPn44Dm+h6JP4NRtWSzN9Wi+
 vixBc6IEl4M8DYf2KuKVMuVVG5qo8/tOOiHR0YxU39v3y+MkKtbqUBVS0BGSvET05tC5
 41HH6WMQJkUHOZI4BoZ8f/dm90Spi/LKvm06w5V2rch+ncEebshA05p02VKTtofSp0D/
 63FIdy3nZsUDOqfhc2T2A1GurrhXI8XDbL2nAiEa6Xgih0Q+8paJXofAWVjMPNM/MjxP
 QshQ==
X-Gm-Message-State: AOJu0YyPtT9+Vf/Olq0J6YFv+H3mVwxg1ceJlAbZbBf3hooiBAk5Aa17
 sVR1uQ5m8ST/fQIDf5yZyPgkuAozB+0sGkqeJFmhrfCKGvfWMbhlJDJvqNGMszLO6Y0=
X-Gm-Gg: ASbGncsbSsyGcwnjTqhTyXaIi0AqsziraF2NILo4KRKOrrCkHDIDq8kP22lUauZ6Agf
 GHNObalL5PmUdHoj3SVGCpigrsR3Y2NzrVurcgmyvyXfFsC84IPHje2Zkpju4fjVzZbpxNFpZTo
 8cHGnVHs/yRlcHwk+kxce40J84DRF8E7OfDlApaQ1yoOmzly7CJOHls3QVifgCtvqOsewGnqGp6
 N+TcbQSS2e83XnDGOpS7NCIjo3cI/MTDoHK3sbZ0pY2EhyNVP8EmVKexnNS/V+B1DwgpoktoEmB
 lnuBPanUOP0O0JSW3LntWYk3/WNBkDjS0+VR8Uzo5/NAOna3p6wiAwkj3QO6nEExXfnKQGutq1n
 e36hfV4/KIUdD15KNvyXI0Kicr/bLnnrCvjEOgqhVuUfUHeM5hyvIk7uCCOpdgctB0qi7cmvNOg
 bsjV0GuoYKl+9LS8eWdtLy8kCVfpjUOzZK/g==
X-Google-Smtp-Source: AGHT+IGMC94GwsKcN4jclSPzlHMJmIqb9Vuuf0L+nnjYwHD2ILlEHL6p2v8rOyqKR1tCu9MrOVIGAw==
X-Received: by 2002:a05:6808:1a1c:b0:44d:aab9:3f99 with SMTP id
 5614622812f47-44f95e4d3bemr45824b6e.17.1761839587458; 
 Thu, 30 Oct 2025 08:53:07 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-44da3e93e0esm4268477b6e.17.2025.10.30.08.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 08:53:07 -0700 (PDT)
Date: Thu, 30 Oct 2025 08:53:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gregory Etelson <getelson@nvidia.com>
Cc: <dev@dpdk.org>, <mkashani@nvidia.com>, <rasland@nvidia.com>, Dariusz
 Sosnowski <dsosnowski@nvidia.com>, Aman Singh <aman.deep.singh@intel.com>,
 Shani Peretz <shperetz@nvidia.com>
Subject: Re: [PATCH] app/testpmd: fix devargs format in port attach
Message-ID: <20251030085304.41795417@phoenix>
In-Reply-To: <20251030092016.226974-1-getelson@nvidia.com>
References: <20251030092016.226974-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 30 Oct 2025 11:20:15 +0200
Gregory Etelson <getelson@nvidia.com> wrote:

>  static char *
> -convert_pci_address_format(const char *identifier, char *pci_buffer, size_t buf_size)
> +convert_pci_address_format(const char *identifier, char *pci_buffer)
>  {
>  	struct rte_devargs da;
>  	struct rte_pci_addr pci_addr;
> @@ -3430,7 +3430,8 @@ convert_pci_address_format(const char *identifier, char *pci_buffer, size_t buf_
>  	if (rte_pci_addr_parse(da.name, &pci_addr) != 0)
>  		return NULL;
>  
> -	rte_pci_device_name(&pci_addr, pci_buffer, buf_size);
> +	rte_pci_device_name(&pci_addr, pci_buffer, PCI_PRI_STR_SIZE);
> +	sprintf(pci_buffer + strlen(pci_buffer), ",%s", da.args);
>  	return pci_buffer;
>  }

It would be safer to keep the buf_size argument. It avoids any overflow issues.
Many tools flag any direct sprintf usage as an error.
