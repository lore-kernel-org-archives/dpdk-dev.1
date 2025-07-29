Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95892C87FC9
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Jul 2025 14:48:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0AA74042E;
	Tue, 29 Jul 2025 16:48:56 +0200 (CEST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mails.dpdk.org (Postfix) with ESMTP id 98BA74026C
 for <dev@dpdk.org>; Tue, 29 Jul 2025 16:48:55 +0200 (CEST)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-7e62773cab8so559878385a.1
 for <dev@dpdk.org>; Tue, 29 Jul 2025 07:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753800535;
 x=1754405335; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lSlAro5XldPrHQtQKYW1+EdyhfOZFrvrgUa44pvLXBg=;
 b=EyPxXVOfeNqm6kuMnIGm/qBb9i7FwSs43OHU87UZqtS9UXsudWS4FImMJp3ZmQ8uT0
 9nv1erVPk3Nrs/RYQtBPnr4wrnOGbHkoG7GsyOSBQbDopaAQYzkGL9pHDg3kLxptnafm
 manf7SRhs4sPZdbWyZ2o+Iqk+RvWxHOSNY4KoENgDRhlN+rt0HzrZ83DYWFTpuVmXpwA
 oN5T46Ocf+BRm1rCa+ns+7He+KzLDTnQY4xcIwxC+HvveNBMHjfTGJAw9z3IwR8H3PGe
 Vd9o1kYuO/bMmjyJ+4LhfYWso5/hMpEkK2I0MeDQyy4xYzHG63WbEkk3ntW5T4eL1B9/
 zJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753800535; x=1754405335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lSlAro5XldPrHQtQKYW1+EdyhfOZFrvrgUa44pvLXBg=;
 b=euKx9q39dxuomu8AqCX2pSUGNsEaCOwmJAyzidf/HkPwQtI2zGfliZdMr826G3rfe4
 B8WQbOzYFhwMMeTqnu+PwiQAbUi8cAzzcstFGdcNPSGcsFq7OfdvGGuXU41VJx4QNi6k
 gs7E0NPrupwJilBIJCmpiq6sr8yrmlPQzWbuZrLF+eVuHczPRqEqcoh7inPcZpCIFzdE
 Ha8NZgtNPCYowjfXubW+VIAnYbJMEtOCUL2FOgoFjQ9hKOcCWpyHAtFmK04blZifh1Pu
 oTZ9kUQ3Kn3RwT5DpxriGW/+4rcVgVgWoj99sApqjlAvUIdBnd5nNbn9455Ne9zUcLYw
 z4dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV48XIaKY1kIazRtCuAmMroaLC2eBLfic1/ctVvTBhRNVhgRp8Sghzwzp97eRliVztwwBQ=@dpdk.org
X-Gm-Message-State: AOJu0YxF0xU4/Uk5C9LT8J8A26eaOxY6PLxK8STnLqb/ypPDDZDZXkIA
 YiKQeJBu4D3gOZpfnc+dTjlUnuJ2sUuY4sxlhUK2Eokj3JEbHd8XPJtDgnupYVcF6HY=
X-Gm-Gg: ASbGncsFDQR8zAaSlaWwcAF2cJVdUxLDcrhMMOiTtNZ+LP2jkv8zAcKQRtKZeRoSt0W
 LEPz/4Fzbq/jyvyVAs03G0yywr6QJYUQ87i/f7T3X13VkcPcIQYbNjuZyoC4XCnXTRU08CmMWrP
 ZW16zY2Ei5Z2+sP3HL956NNg5e9yd8+imewZNheRfXVs5uBiFz9WkDUeoA6LVhaGRHBIC3PODs2
 GiVkXKdYctoOP4ObP8V2pWQEWB53Zht2/NcqymhpqDui5pG6fKmWUX/e7DmUNJebIEraH3tdlOQ
 9jS4we7Deshj9ikk1oOXHvw7iL5TF7hY00DiYDTcqBk8TvDdxslUyYCdNgmeNq7GlWariXShrL+
 sVthV65ABAUBqeIQKtDzPD3mxi0P9IYfYT13e712Hrak/GVzsM4h2ydFxkyjC5zGl1/tSDAK3zZ
 LdIHvsoS6C+w==
X-Google-Smtp-Source: AGHT+IG1GvYQHZ5C49aE5b+1pKKcSAWG1HppizG9l0cfvMH32/k0aLOs1ULoZfg6Mnrmbqr0uvW3+g==
X-Received: by 2002:a05:620a:4610:b0:7e3:4c63:578a with SMTP id
 af79cd13be357-7e63be5ba39mr2347991285a.10.1753800534630; 
 Tue, 29 Jul 2025 07:48:54 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e64387a1a8sm438178185a.52.2025.07.29.07.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 07:48:54 -0700 (PDT)
Date: Tue, 29 Jul 2025 07:48:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shivaji Kant <shivajikant@google.com>
Cc: Ivan Malov <ivan.malov@arknetworks.am>, dev@dpdk.org, Ciara Loftus
 <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>
Subject: Re: [PATCH v3] net/af_xdp: enable AF_XDP program attachment mode
Message-ID: <20250729074850.5713031c@hermes.local>
In-Reply-To: <20250729100845.819452-1-shivajikant@google.com>
References: <20250729082456.796921-1-shivajikant@google.com>
 <20250729100845.819452-1-shivajikant@google.com>
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

On Tue, 29 Jul 2025 10:08:45 +0000
Shivaji Kant <shivajikant@google.com> wrote:

> diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
> index 5f65850a27..fbd592c538 100644
> --- a/drivers/net/af_xdp/rte_eth_af_xdp.c
> +++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
> @@ -104,6 +104,7 @@ RTE_LOG_REGISTER_DEFAULT(af_xdp_logtype, NOTICE);
>  
>  static int afxdp_dev_count;
>  
> +
>  /* Message header to synchronize fds via IPC */
>  struct ipc_hdr {
>  	char port_name[RTE_DEV_NAME_MAX_LEN];
> @@ -169,6 +170,7 @@ struct pmd_internals {

Looks like random line added while doing other edits, remove in next version.
