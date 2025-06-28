Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69807C7EE39
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Jun 2025 22:44:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6F3A402E0;
	Sun, 29 Jun 2025 00:44:33 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3216040288
 for <dev@dpdk.org>; Sun, 29 Jun 2025 00:44:32 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2366e5e4dbaso35706895ad.1
 for <dev@dpdk.org>; Sat, 28 Jun 2025 15:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751150671;
 x=1751755471; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wOfQdQNp/Vs50YJet/xP9tv7ZowzJw3aI+QBcf4HHIw=;
 b=crDmVNRuIX4YOf3VclQLq1b3wpAVRY/IuvXzVHUOIIMeGyqxv4t96xn9adyFrL6b1J
 qGdPkElXPgz6lLVCsTNolFc/tNIya87CEVSW/OhyG29kiysIUKMxEQsXFC4t58Jh2CL9
 y7v5QnEV9mmso72KkctxXGCo5107TuIJPpmxiLCcGcbZ3L6/T3da9Y6jw6pENCRqJjl6
 w+GOoYSchM7q0e8m83XWqCLH0gycxzxIVeTnIbH7y8vsddED8DXmyRkHcRsA/Lo9f254
 iSu+qB3gG9Dno0XGntp1f6JDT/sX3L0/vmlD+uVcZeTD44tEPoHBihK23z8/Qn7FriB/
 uhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751150671; x=1751755471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wOfQdQNp/Vs50YJet/xP9tv7ZowzJw3aI+QBcf4HHIw=;
 b=TixmdYO0xKLoalWwSgbDKagPCx2uY5AmnR6uPMTV3U3+PLJn9rXEUKDMWA//DQQbV6
 Cor1t0AtTVynaeIfloInTayWsHndk/XWXraafAjE48SWLhivUAS1xSWT82nJDyy5v3o4
 E3oGm3IQi8lVUxzMjyRP4+1sJ4KD5zgc39bdm2+JUj6TYHNuo0liXWwB+JRBiNgtaBXw
 kx/ckcIBJgkSLjdgLNahjawGIvq9HSsOBD8WvdzZ4qm8HF/aOxIiGUFEo1tm4zXSpnCp
 jUfUmhuXvn93H61YODusBwfu6ZEcTdxAyzRHKWEM1miVv0AoGOf+68jXh22FkH6Y9qYq
 ZbVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0/rf52M71booNfgtqSrf9Fjl7YnKs8WaVbZF0Nlm/FPHynjwOnC6vjpkMUXgA1PaLvvY=@dpdk.org
X-Gm-Message-State: AOJu0YyoLVph2JNoeJuZ5KFZyxrAkczBHIt7NebDZT6Ow7SYJdyEeLHf
 wg07YrTk9EFSXdCVKchL+Rk4LGlGXKd2p7tu61hB9KZDtTiLwx39zw9aHcfE/1Bzagw=
X-Gm-Gg: ASbGncuVom9kix9Q/LDjcQPrU4aJIqlw9iByi2kqmcwLh723b4nrpTMZBYOH70f4l9y
 smQqO5qSAgN3DTG5HPRccog5rJACKr7u1WrD6SCguHT6YNoGOWJ2Su8OBwPvpBi43NE+MzC0siw
 LNF8Kni5D8H+ncTTEZrzS/d/F9L5ru5ctHOH9V+m6Zg1q4J34k/cJ32/vo0dKLNRdVQI0EVwc/y
 PkhIBPqP/Hq3/n4S+TYGOCJkt8Ki8Jr1PDDFIeqbqEVTcq/2h+SszdvQBrpzY0wnZA7HsmPKm39
 N29ba+caY9gvO3vtmBOspMs0cg+QXqM1Dq9ZTLnkDZd3LIxF6BTxSq4kTSJPPMxzaRhH5qPYqUS
 27sYFbt3PNMG847BdL/ru/fyeWCu3IZNVN/Jwx+w=
X-Google-Smtp-Source: AGHT+IE/C1XCwknp3Evk4BxK4zp6mnn0WgMa/GI6u+pSe40w/Ekljk1cF8Erjbd7zfqqxMKunuP/Pw==
X-Received: by 2002:a17:902:e847:b0:236:71a5:4417 with SMTP id
 d9443c01a7336-238e9e05a5cmr178151905ad.5.1751150671096; 
 Sat, 28 Jun 2025 15:44:31 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb3c8b81sm44698925ad.242.2025.06.28.15.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Jun 2025 15:44:30 -0700 (PDT)
Date: Sat, 28 Jun 2025 15:44:28 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wenbo Cao <caowenbo@mucse.com>
Cc: Ferruh Yigit <ferruh.yigit@amd.com>, dev@dpdk.org, yaojun@mucse.com,
 stable@dpdk.org
Subject: Re: [PATCH v1 1/3] net/rnp: add check firmware respond info
Message-ID: <20250628154428.1de592f9@hermes.local>
In-Reply-To: <20250618121113.17302-2-caowenbo@mucse.com>
References: <20250618121113.17302-1-caowenbo@mucse.com>
 <20250618121113.17302-2-caowenbo@mucse.com>
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

On Wed, 18 Jun 2025 20:11:11 +0800
Wenbo Cao <caowenbo@mucse.com> wrote:

> diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
> index de1c077f61..7b996913c8 100644
> --- a/drivers/net/rnp/rnp_ethdev.c
> +++ b/drivers/net/rnp/rnp_ethdev.c
> @@ -751,17 +751,17 @@ rnp_get_speed_caps(struct rte_eth_dev *dev)
>  {
>  	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
>  	uint32_t speed_cap = 0;
> -	uint32_t i = 0, speed;
>  	uint32_t support_link;
> -	uint32_t link_types;
> +	uint32_t speed = 0;
> +	int bit_pos = 0;
>  
>  	support_link = port->attr.phy_meta.supported_link;
> -	link_types = rte_popcount64(support_link);
> -	if (!link_types)
> +	if (support_link == 0)
>  		return 0;
> -	for (i = 0; i < link_types; i++) {
> -		speed = ffs(support_link) - 1;
> -		switch (RTE_BIT32(speed)) {
> +	while (support_link) {
> +		bit_pos = ffs(support_link) - 1;
> +		speed = RTE_BIT32(bit_pos) & RNP_SPEED_VALID_MASK;
> +		switch (speed) {
>  		case RNP_SPEED_CAP_10M_FULL:
>  			speed_cap |= RTE_ETH_LINK_SPEED_10M;
>  			break;
> @@ -789,7 +789,7 @@ rnp_get_speed_caps(struct rte_eth_dev *dev)
>  		default:
>  			speed_cap |= 0;
>  		}
> -		support_link &= ~RTE_BIT32(speed);
> +		support_link &= ~(1ULL << bit_pos);
>  	}
>  	if (!port->attr.phy_meta.link_autoneg)
>  		speed_cap |= RTE_ETH_LINK_SPEED_FIXED;


Prefer not to mix raw masks and use of rte_bitops.
Better to stick to rte_bitops which is portable to Windows as well.
Can be simplified like:

static uint32_t
rnp_get_speed_caps(struct rte_eth_dev *dev)
{
	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
	uint32_t speed_cap = 0;
	uint32_t support_link = port->attr.phy_meta.supported_link & RNP_SPEED_VALID_MASK;

	while (support_link != 0) {
		unsigned int bit_pos = rte_ffs32(support_link);
		uint32_t speed = RTE_BIT32(bit_pos);

		switch (speed) {
		case RNP_SPEED_CAP_10M_FULL:
			speed_cap |= RTE_ETH_LINK_SPEED_10M;
			break;
		case RNP_SPEED_CAP_100M_FULL:
			speed_cap |= RTE_ETH_LINK_SPEED_100M;
			break;
		case RNP_SPEED_CAP_1GB_FULL:
			speed_cap |= RTE_ETH_LINK_SPEED_1G;
			break;
		case RNP_SPEED_CAP_10GB_FULL:
			speed_cap |= RTE_ETH_LINK_SPEED_10G;
			break;
		case RNP_SPEED_CAP_40GB_FULL:
			speed_cap |= RTE_ETH_LINK_SPEED_40G;
			break;
		case RNP_SPEED_CAP_25GB_FULL:
			speed_cap |= RTE_ETH_LINK_SPEED_25G;
			break;
		case RNP_SPEED_CAP_10M_HALF:
			speed_cap |= RTE_ETH_LINK_SPEED_10M_HD;
			break;
		case RNP_SPEED_CAP_100M_HALF:
			speed_cap |= RTE_ETH_LINK_SPEED_100M_HD;
			break;
		}
		support_link &= ~speed;
	}
	if (!port->attr.phy_meta.link_autoneg)
		speed_cap |= RTE_ETH_LINK_SPEED_FIXED;

	return speed_cap;
}

