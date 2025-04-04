Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5369C3600C
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Apr 2025 00:46:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EC8E40270;
	Fri,  4 Apr 2025 02:46:51 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 84C084026D
 for <dev@dpdk.org>; Fri,  4 Apr 2025 02:46:50 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2295d78b45cso19693455ad.0
 for <dev@dpdk.org>; Thu, 03 Apr 2025 17:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743727609;
 x=1744332409; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jYBQq5ClCOUON1ZJ51TXc7+qxyMg8S/aPpjbbJHLiEo=;
 b=kiVyMJ0yhiR0nhX6GtnoNekQ7C2bAD6MJAX2mozqZaGBzuKk/n+rqi6hyZtspWVedO
 O/bh6sa+xFYEe60YCJM+2zXuilv3Mre6nxPwf+x1uEWS2ZVDP4AEpNLugbcqh0Shqw3D
 Lq0hQocYFtL2BXT9qxNKlxEgnH6zP0dm4axMJB/nPiVWe3BDJ9jSd76xooFHVt/VzIX0
 lHFry2k2pK2WPu3qXu0pqOTTkZLQZr7RR7qbJRugYTwWHSoxGcDhK1L7s1BGKUv5NktI
 f5bFDn7USv5RQYLBz6anrnP4EmTMv99hspdL3cfwkOj4K/7+UMk+I3ilfpoYDXt+/1gI
 up5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743727609; x=1744332409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jYBQq5ClCOUON1ZJ51TXc7+qxyMg8S/aPpjbbJHLiEo=;
 b=tzY7MTQ/u9lyZs/anjMpghNQ5e3EiqkKA7U/HvKlFOlbVAOy/S/i4atm0e+iHurkzn
 aibufIHugv0YoHJQY1+YzphORy1H51lkttUTEAB2DfinNoo4b2uCasvwojP703FZqM+y
 /GCBofrGLnuxeBsROQw+JNnVUA01QrOErDp9K2CiCTagrbpvrnlMLX9ffL3Ddy+Ld9Kw
 ocTnmdYAPWV9qq4zmqm05ckq9zAOgnNGIPfhehlztB8/uDmZam4IOy3wVoq4BCap/FzN
 DCceRrfxGfl4Mb4uxrQZvbpOujjxoCkVD0GFhjW2vhwtoHXcxRwkDTqBg0Tg6jofEieT
 SYDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1DSvI6lTgKdZ+FSwGaOlcT+AmbV2zN5l/FDkl9DxmGCIhwi+AefOlv7AS56Q5IyuQd0c=@dpdk.org
X-Gm-Message-State: AOJu0Yy625nBxq6q73p+aue+ipPlizoJkOq47jTBDRhpCiwqdVPFJQEL
 pO26Wk+ruRm/wZIz9tn4mhffEC++6hni5IF43RobNmkxwjmFc2kNluSJ5aDuYSY=
X-Gm-Gg: ASbGncuE9/HW8O3JygILRqkfb7aR8g+j5VRfhZm6r1FhW0bV8aV4ZmDVrf+TC3x+pT2
 odQ34b+fExmBOcDpVlKGBcU5eeBDULW0V/p2gY2bmrxVpfRSiz8pJ/tW9SuQjWlq+3iZcNL1RTX
 YKI8myHbgQy5xA6wXSfy+HLx7aBR9b4w6saKLyi/qnl7Q0sD8oXKMpNiv9nLOgv4YVcnKDu5/tp
 Xi/fuk3cooG2pBe7nQOAyKfpQa4D6uWOkcdH+Ieb0+3w2RNWixn+PNy48dTVVeoXoc/N9ds2gFf
 VdCBBAV9AR4ba9wvjHKwbUsZX9zecmAV/iSnj59XuwF/IJv1hyd9skO2VpeQF0/GWiNJdp53sVe
 HbOKGgTnHNNdBz4/EfI95
X-Google-Smtp-Source: AGHT+IEhJjfx3JSiJCEIL4AdLwWRDJ27LNIIERPp7KXLVqdw3loSLgz7c9SbgSanLNa3+cwpOPpxUw==
X-Received: by 2002:a17:902:e888:b0:21f:617a:f1b2 with SMTP id
 d9443c01a7336-22a8a0b3f7dmr15065735ad.46.1743727609393; 
 Thu, 03 Apr 2025 17:46:49 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2297865c251sm20907455ad.145.2025.04.03.17.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 17:46:49 -0700 (PDT)
Date: Thu, 3 Apr 2025 17:46:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit
 <ferruh.yigit@amd.com>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 <dev@dpdk.org>
Subject: Re: [RFC PATCH 1/4] ethdev: add support to provide link type
Message-ID: <20250403174647.1d9e5742@hermes.local>
In-Reply-To: <20250403070837.926292-1-ndabilpuram@marvell.com>
References: <20250403070837.926292-1-ndabilpuram@marvell.com>
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

On Thu, 3 Apr 2025 12:38:34 +0530
Nithin Dabilpuram <ndabilpuram@marvell.com> wrote:

>  /**
>   * A structure used to retrieve link-level information of an Ethernet port.
>   */
> @@ -341,6 +354,7 @@ struct rte_eth_link {
>  			uint16_t link_duplex  : 1;  /**< RTE_ETH_LINK_[HALF/FULL]_DUPLEX */
>  			uint16_t link_autoneg : 1;  /**< RTE_ETH_LINK_[AUTONEG/FIXED] */
>  			uint16_t link_status  : 1;  /**< RTE_ETH_LINK_[DOWN/UP] */
> +			uint16_t link_type    : 5;  /**< RTE_ETH_LINK_TYPE_* */
>  		};
>  	};
>  };

Seems like an ABI break, and not sure that all drivers will fill those bits with zero now.
