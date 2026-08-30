Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311F0C61DB9
	for <dpdk-dev@archiver.kernel.org>; Sun, 30 Aug 2026 04:30:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1C4740264;
	Sun, 30 Aug 2026 06:30:31 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id B6BB54025A
 for <dev@dpdk.org>; Sun, 30 Aug 2026 06:30:30 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-398b1e63c49so566663a91.0
 for <dev@dpdk.org>; Sat, 29 Aug 2026 21:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788064230;
 x=1788669030; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LLS0iUG5joQx8JZhOXocDptRNw1fGv4bkIzG/ulByRI=;
 b=nnDthh4V7rdMgBIAY2NNFcsrSfruzPzmTrKLElLx2lx5u7uOplEykLquZWozk+xRYB
 STHt2SCOI8Q6h/wI3Xy8xrkNr/Ej3cZ1Yzjmqh9kUYV3Xc8cVnxsgw2quFmrG/dxRn1j
 5+Z1kzRyqc+IfcBdy2EiBoBRMVyLzmjpdX3/P36LnftIkHfGeZPCSGQYZAmad3wCOQmJ
 KxQKIw3heC16O7rUBj5aKN2vFhOp9Qm5Lg6AE0S+7AZ3arkvO5c8XATjCVgYRKc75t8k
 M3YYOIvvomQyHKXMeXuKk/4UavLGvnlfmT4Ry8JEV8FUFAdx0JRiWhJ4CzHjQHzH9wiI
 qndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788064230; x=1788669030;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LLS0iUG5joQx8JZhOXocDptRNw1fGv4bkIzG/ulByRI=;
 b=ZtnNxppPBD6h16CJdA/+Ky0WEOaWoXCdIw9x/XOsbWmEJOI2JxwX+LaGYBAiFT+Y/q
 X9fBVxIFxncO/WxzYiLYlkmMOVV1ekxV+4Dum6GOe30UkkOJkZjwkpbPvB6+k187pIBK
 KJYxPcZIjMqI1adV9aFDTIFG+YYKaBe0qo7l/blx+YhL83IzBjqSvr6/WNE1vu6cJQGa
 cz7bv2lYFlickMiOb1BGjB5nNp2zGlpZo4eOIpsIqcfBt/akF+bhixOQXI9Vc2LA+CBb
 Zd/QLNRp07F2+XydXPOV+AH5PiiDQHaaleG2GrahOG4br8ftIuVwBQrLvrTwO9vYJy/l
 WHzA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw3tJ10IeEp0twCunqftumXCdtJ9XV1jy188pSlz7NaPKVTY7dkE88BgnZ/rGzI7yJYUc0=@dpdk.org
X-Gm-Message-State: AFuF++mdoozdbKtz24vNW5R6UDMVAh84obNN4U2U8r/ufdJQcVUPcM2U
 IJR1jrSOQ1uS1bLSajaRRIpdXp9ElYHAU5Cig7kALp8aFE2lTdgwsAuFLHz5b1cgQYE=
X-Gm-Gg: AYBFou1c2F3PnDpklbmyxFoFhTf31HUX1nJDNwuf7ZRyxwpoEmCqvsCtjGSSF2p3C7i
 iF++Vw3nuYS9zxDDV6WNrnE0BdBbN2vcAT4NvSG3K/Bl/FEKbqnyX7yUBYR21UNq+KEieJw8Z4z
 X7kBh4HoluCSTQQhKrDrqpeLUC2qIQ5tKrzSx8TLw6XWRIeh5MSmjoZ56scAql+coSSWS56Npny
 9xAXQ0kk8Kd/ZILj3xXBwkb4zCx1I4PiuAUQjE/lBm8iwAJU4hhgmTYzxghEcRkryaMIylJGF57
 eIaJDkTOtvAobsYNJ1r9W4STNQ7v42jI1nTftjtuOdFhgVyrRI4tozaS58mWtbC09f26xT7Ollx
 MbqJMeg9MyN/U0BJh311PbQL9mpaXsm9HsB3uPl0pC+Zc2JLOZxg9FTFWQ0L6uqcM63BaNRqQlc
 EAazL7wjeSDvBwqXk1MpgGKEPWMNNElB43ABu/R+VJMURxM4Q/YEtb2/3RDRWZXZShO21rIYwgq
 OXNtPtS4tHtcWOPQEYeVORlusNdUw==
X-Received: by 2002:a17:90b:38ca:b0:38e:c232:9d2c with SMTP id
 98e67ed59e1d1-398da598b19mr265397a91.2.1788064229787; 
 Sat, 29 Aug 2026 21:30:29 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-398a14d3e83sm6797688a91.10.2026.08.29.21.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 21:30:29 -0700 (PDT)
Date: Sat, 29 Aug 2026 21:22:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Weijun Pan <wpan3636@gmail.com>
Cc: Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)"
 <humin29@huawei.com>, dev@dpdk.org
Subject: Re: [RFC PATCH v4 1/2] net/bonding: skip unavailable member stats
Message-ID: <20260829212225.30b4821a@phoenix.local>
In-Reply-To: <20260830011445.168073-1-wpan3636@gmail.com>
References: <20260826161009.37875-1-wpan3636@gmail.com>
 <20260830011445.168073-1-wpan3636@gmail.com>
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

On Sat, 29 Aug 2026 20:14:44 -0500
Weijun Pan <wpan3636@gmail.com> wrote:

> diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
> index 6a4f997b5a..6f10dbb0c7 100644
> --- a/drivers/net/bonding/rte_eth_bond_pmd.c
> +++ b/drivers/net/bonding/rte_eth_bond_pmd.c
> @@ -2677,9 +2677,12 @@ bond_ethdev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
>  	struct bond_dev_private *internals = dev->data->dev_private;
>  	struct rte_eth_stats member_stats;
>  	int i;
> +	int ret;
>  
>  	for (i = 0; i < internals->member_count; i++) {
> -		rte_eth_stats_get(internals->members[i].port_id, &member_stats);
> +		ret = rte_eth_stats_get(internals->members[i].port_id, &member_stats);
> +		if (ret != 0)
> +			continue;

Ok, but you really don't need the ret variable here.
