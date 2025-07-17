Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8D0C83F34
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 18:17:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94FCB4013F;
	Thu, 17 Jul 2025 20:17:18 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 8F456400EF
 for <dev@dpdk.org>; Thu, 17 Jul 2025 20:17:17 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-23dea2e01e4so15314895ad.1
 for <dev@dpdk.org>; Thu, 17 Jul 2025 11:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752776237;
 x=1753381037; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XZ5jyaSxsKSAwTrPEuTyfa45gEuFehhIm29EiF9OEmQ=;
 b=jKi2Gtv4AC7YUm3fP+w8Fwpwe+2+tcyJeeqc3IWjoTqqqePHKx/wicL3Z/i1crF3iA
 dOxDuqleT3aLVKZl/0BheumcDlOJN5c52I1vhoTPnfsDzUL2rvQKeOqjJGYHT108kT+Y
 wmskZ+lAfciUHhWXyMXVzyG6FRmPU0nlCeQXWqWXK98UHJkOHfbjSxeyWgtVcWrN2YLl
 7pbKgyOHnec5eB4yuK1tcUhlcoH1pqyt0A4ZHCCocmwdtX+voJZ1cdhiAapWFTLP+1tj
 ECvK14HXQzgGdMz5u4ChDPY4XcLhGrGJjZkyTMlD2z5uuEkmDRO/fUzAum8/c6xVolnc
 N63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752776237; x=1753381037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XZ5jyaSxsKSAwTrPEuTyfa45gEuFehhIm29EiF9OEmQ=;
 b=XpC587Fqs1wyVe/J9V922Laleuxa2rqaXIwIV7ppFOPzoNlDCQRexoSRcSKWZsT4cp
 +oZu37FA4rIVoEr57Lg7tkm+Tns2rmCg1YRHKLraAYCWC+ANgfwWxGdBw472fK7dXPQs
 5X8JSMrXDbwDUCq+LR3HXPvqMZGiCClW9K55yJLNbd8y4l/uqXa7u0QaYQDxlRWNBb5a
 W03JqJm0e0PI2EFhhcdvirGBbxwHRN6qBG7DkfanNFInmr/9U3OzhiG37sfTxLeSv3yh
 rA05A/UOrxnTNPumUapLEC1+W8mpPM/E9fFcSrFX622FjZK+74pFy7FesYdTimsnEFKl
 bVPA==
X-Gm-Message-State: AOJu0Yw9cP9j5IsBfpZ9BdshM6I7w+572M/7e47bbY/mqzfWCrTCZt3d
 Utzu9Lg/5v2si99jtMgye37j+kV6hHqlAdTuyCPS1GN7RR5bJaBVWklwALg9HKL3qUzNJTDZlry
 Xjx99
X-Gm-Gg: ASbGncsTw4yQuUc0bwYpSYTcs2qVdL1k6niU6yCGJkTS1OmcPKhHqWHi+Mtx/K7K9Sf
 en/SffFcjbC+oNnxMkABjVYpV8l0/UOEDlT0n8lA2tudfLTdIN7NUrBlcMtC/OW8GMt8hdTpo2j
 t5urz8Q8EvgE8j0fGEzb+n0Rz5brknXgYk7kTqNLRc7Z0sKs8/ftryej1673BnzhALE/ud21EdF
 KIGGoMtrUnGeYWCV56ymioNUoGWuBHeh06WhU6itkEm22yDX7ZWf/8rBU0jzmy99t41lKUbkrHo
 AFqgA+gWwnXqKT9PTxLbdS2QzCOfkTz37C241b2VwhogcZkfduMXxcTyRUTiqepjBXosAK+g2on
 aNjKqqo/yj+O179j7zpOjHhUNVUUf2yrYrjOFyJNiQ11YUFVxeUsEZKCW3XyXh7D6CdWupLEqbl
 4=
X-Google-Smtp-Source: AGHT+IHJbznV5Bjj00Y8eUnH81uDlKisootI5Iea9es4AD992GVmOfvORnEfdLGVuwpBe308u4CfFQ==
X-Received: by 2002:a17:902:cecb:b0:234:d679:72e9 with SMTP id
 d9443c01a7336-23e2569b345mr133214145ad.12.1752776236662; 
 Thu, 17 Jul 2025 11:17:16 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de432278csm149855645ad.121.2025.07.17.11.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 11:17:16 -0700 (PDT)
Date: Thu, 17 Jul 2025 11:03:26 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v5 03/14] net/sxe: add tx rx setup and data path
Message-ID: <20250717110327.5b53131c@hermes.local>
In-Reply-To: <20250710012021.7698-3-liujie5@linkdatatechnology.com>
References: <20250707115819.12826-14-liujie5@linkdatatechnology.com>
 <20250710012021.7698-1-liujie5@linkdatatechnology.com>
 <20250710012021.7698-3-liujie5@linkdatatechnology.com>
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

On Wed,  9 Jul 2025 21:20:10 -0400
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> +u64 __sxe_rx_port_offload_capa_get(struct rte_eth_dev *dev)
> +{
> +	u64 rx_offload_capa;
> +
> +	rx_offload_capa = RTE_ETH_RX_OFFLOAD_IPV4_CKSUM  |
> +		   RTE_ETH_RX_OFFLOAD_UDP_CKSUM   |
> +		   RTE_ETH_RX_OFFLOAD_TCP_CKSUM   |
> +		   RTE_ETH_RX_OFFLOAD_KEEP_CRC	|
> +#ifdef DEV_RX_JUMBO_FRAME
> +		   DEV_RX_OFFLOAD_JUMBO_FRAME |
> +#endif

That was true in old DPDK version. No longer needed. Please remove #ifdef
