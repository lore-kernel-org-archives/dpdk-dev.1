Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA27D12D75
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Dec 2025 15:20:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07545402F1;
	Wed,  3 Dec 2025 16:20:24 +0100 (CET)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by mails.dpdk.org (Postfix) with ESMTP id 89DE2402B7
 for <dev@dpdk.org>; Wed,  3 Dec 2025 16:20:22 +0100 (CET)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-4ee0084fd98so51061311cf.3
 for <dev@dpdk.org>; Wed, 03 Dec 2025 07:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764775222;
 x=1765380022; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UMflljZ3qZ+kVPnuUEVmkFUweOTyB7LsrITx03P1RqM=;
 b=AYOZCE+7kdCb1y8YYw6bDhVcMxglthNiHoarEdIuFvhs20Vq/xm18pthIGVXj0oqnE
 HGVaGEApoTwnPcYLdaYdlZlV1JjHcQrWFU3G7Uhdw6wh5IDwj4YloQQnYypF6irDGBZP
 GXYSToDXOaDQOn1WCbrh+v7tT4jYEX1ticLMIg/Ito19sht8Odh0JLIxfQFyRTIGIrjU
 D5gqnOqEHJqphtCL39ySRsBfyZEY9ARrYmNj9hiQ68JK+HQA94xCEnHrBPCgu1lKtRw1
 K83jJQLgjW908pD0L7tIEjzLUQf4LXjT/8lZIwZKqUtvHwn7oKiRtNFJokjBPFyTYkWb
 VD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764775222; x=1765380022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UMflljZ3qZ+kVPnuUEVmkFUweOTyB7LsrITx03P1RqM=;
 b=eQEZ0UbxW/Yedrzp2+hjxWOrwIAp4hkTV5mPlRe213ATrH1cFByvBPjVsp6fmdnZmp
 ExZxAe5S/RUg6CdYZqpOaV7j3Jpf5CDdP7KqQqbQ2mh9O9HDjiV6h7nbhq16ZM+5+n3p
 RvuWE2zNQJZeQ7xGJaVKRHwhsQuJGwIwtZWt1mGNToCuEhPWSOpnEYVLoQNR8BZK9vSI
 ABSG4jgIxOONg5PXukOJ5USz4jH0Y6Vbl0OrH+alwGjmro0wQ5SPE8Q+fostvEKW0GYW
 XV2KUJBGxhmG/jY9aKNYI4qSvXCd1YEVeIfx+mFsLbJLrzxqIptc8mzDDCRy6+Xr4bP/
 LeSQ==
X-Gm-Message-State: AOJu0YwGFuL5NvlMNqWXATEvDLkmuG5ATZTvPsr+Xd+LAoBN+pXTV0x0
 2yMRh8eE2TWDvHNZpHDy0af8rJQIZZYDq4LdKh7kKZOc6V5700Mo8xjJ5TNt/XEDyLU=
X-Gm-Gg: ASbGnctJhGugMOkz4UMgWF6605/OKs2WKn2Px37UlseDuKvdN+hBBDWVbEWXBhJJpSJ
 HE0mn9F5e9+c1MBNfe4ZRtoooeXbDkfOVS70CMRoVErSsqfOZ/TJFML94XlvqQb6cwFS1FgRjmK
 b5hG9QbhM26R0Rpn9I8q8C0VgsbD8xFoMy94PjD2JkmXVQo1yAgGkgC/Sir8HKQzzQpNfqLOpWp
 aiuA8rpef1Ci52Jxs4yfSpm/WG+NNbht6JlexErVYA0U9YBIXz4LVjW0+JM7TkdgPD2AFHUNxE+
 FecwX+j0Ct0j6e7RySUETEwhOy/NCEAy2Qp/ivOvlwrM+gpqxd4dNedBPfB4yFDk/d2AHCXgNF0
 S+VrqLmVqv/Ke64EUMXy/0xHhiBdnZcOVyWU4nf5+Ecf6w2se0NxMitdJImrgdUIbD16cxhx2mf
 2IiP1ux/LXA2nisFGLu1RzjWPFSLxNmlE8a5uM/E1WpopEwKA11EkSRM4Cbe9ZStM=
X-Google-Smtp-Source: AGHT+IE86T1hnBYFyx41ibcs5xyaTXhBigknfq7jE5Iel09KTo0GoXZRe9xcN1IDpjfBJLaBwFz3QQ==
X-Received: by 2002:a05:622a:150:b0:4ee:22d6:1cff with SMTP id
 d75a77b69052e-4f0175a11efmr36222921cf.36.1764775221623; 
 Wed, 03 Dec 2025 07:20:21 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88652b90ebasm128830406d6.55.2025.12.03.07.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 07:20:21 -0800 (PST)
Date: Wed, 3 Dec 2025 07:20:17 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shani Peretz <shperetz@nvidia.com>
Cc: <dev@dpdk.org>, <stable@dpdk.org>, Remy Horton <remy.horton@intel.com>
Subject: Re: [PATCH] examples/ethtool: fix buffer size for pkt pool name
Message-ID: <20251203072017.27a079d9@phoenix.local>
In-Reply-To: <20251203110157.51471-1-shperetz@nvidia.com>
References: <20251203110157.51471-1-shperetz@nvidia.com>
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

On Wed, 3 Dec 2025 13:01:57 +0200
Shani Peretz <shperetz@nvidia.com> wrote:

> Increase str_name buffer size from 16 to 32 bytes to fit the provided
> format. The previous size was insufficient as the format
> string "pkt_pool%i" can produce up to 19 bytes (8 for "pkt_pool",
> up to 10 for integer value, and 1 for null terminator).
> 
> Fixes: bda68ab9d1e7 ("examples/ethtool: add user-space ethtool sample application")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> ---
>  examples/ethtool/ethtool-app/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/examples/ethtool/ethtool-app/main.c b/examples/ethtool/ethtool-app/main.c
> index 1f011a9321..06605b4202 100644
> --- a/examples/ethtool/ethtool-app/main.c
> +++ b/examples/ethtool/ethtool-app/main.c
> @@ -92,7 +92,7 @@ static void setup_ports(struct app_config *app_cfg, int cnt_ports)
>  	int size_pktpool;
>  	struct rte_eth_conf cfg_port;
>  	struct rte_eth_dev_info dev_info;
> -	char str_name[16];
> +	char str_name[32];

Don't use hard coded constant, instead use RTE_MEMPOOL_NAMESIZE which is
not 32, but 32 - 4 + 1 = 29

