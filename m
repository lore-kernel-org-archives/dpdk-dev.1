Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9809C7EE39
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 17:53:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1A5D402D2;
	Sun, 29 Jun 2025 19:53:19 +0200 (CEST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id 9873640288
 for <dev@dpdk.org>; Sun, 29 Jun 2025 19:53:18 +0200 (CEST)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-7d3efcb9bd6so365865585a.1
 for <dev@dpdk.org>; Sun, 29 Jun 2025 10:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751219598;
 x=1751824398; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=juC05G0h5abPknMkASXV8uQ7emuobKEze1E5LANogdk=;
 b=fYblw0goPg79i37vQ3Lkz30Frq1IU9Wg8EArFi+xQpmnlKKl7qZCDAeILEuMOsTpqw
 cUd17IciC9gHXPNZu3LDGo4973KVWrTSFBD64+IiJSt9u6hyRsUJvBikktMq1jCjhyCr
 QqOuXlJNjMN9F6YDfOWSlnv3UKBzt61jZbFQc/THsV/4GgvhBaMa8G89YT6NwK01NbMu
 IufRjdw/TXFzORecCN1O+19uZ7Mel8IJJ/D5SpgZEWf2ZTmow8JaMlT1VlxzUYvbCJ4c
 ABhHSScQNUmwWz3cpoQzLcwPeHVqfCUrXffTxzl5Dy2x59MFw+bVF1KIHNcegED/hWqY
 AjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751219598; x=1751824398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=juC05G0h5abPknMkASXV8uQ7emuobKEze1E5LANogdk=;
 b=CufjLb05iFcMC6JsbgbhEohxB72tD10hjGN94LfDdhjAesvWA46alcG0Mm6e8maLak
 9PERBdHhX/8zbUqBKSwDz/degvkf+1+pODHG7NmxgJ5N1Mb3VUEwEXRTo3KgRj5Dbewh
 7/iT7HsGFBAnCXbBIsjgTT/C/OZWxU6Q/PdV2ueZwDUU0WzYrkJ+gW5J64NwUTstvwp6
 VDh/bzOvWaD0NfmyhLtteVZBZ7FbscYdt4z0SLeC7nn3GQmBBsu7MwehVkG8pDoM3bpH
 gn/vpzZ5wVBoo0E/4h4gd/+EPiXZ2X7VPP8nJOLZA5S/TtY8RfakDF2bNL1IMbRqz6sd
 Xx0w==
X-Gm-Message-State: AOJu0Yx+jkMNstOwCo8bO7tAlkbLV8iivmUphCOCRMPc+yFu8XSeOBl1
 NZZDCwCukseZWW/woD/MgaU4hbFXBFfSIE3xRj5VhD+cF5tCGPgT/3E7vc6h6SfTIzd12Ix/dxW
 RGpe5MXY=
X-Gm-Gg: ASbGncs8eeAB0Fw1IJ++e0zFl1bNmp+JJ23HU2Z1ErTHiM6sPMnDaBUkt0KryEfSqom
 YuW3dXYC5/xoN39Jh6c8Sqdl2oYA4DuZLHd3hLCCExA4ir6OvPnlrYj521Ui+aPIGn3d0jGInmY
 wpOmtyGWlLD0Bq/k4LJWtSIqnL4vPKE6mU10xqou6VJLxWQZ/pEiRRjLCqsrUyOZ79AZNiSUY0k
 WRlCZIJm4urPuYYKcZWHXa9L7pv5FlLDndWM+q+eAVwBIWusslWJJpf0Le8FDXN+jMcNyWqur4U
 kElLJpCEXdwl1p0Rm6Szby4kNmkL6/1I0Ex4pjWJFpkW5mLNMY5wc/U7GZc9eSIsgpJkBcRStio
 NXfyYVJzE/cEqHjJJm9lUREYdgFVkfyPJibnCyIE=
X-Google-Smtp-Source: AGHT+IGzFQJEcn2LfRMz70ESYXMPh0UIb3uCCaM0TVc/zSvOYwSIyraTx1SGtIIIKmPAw6p4ZRosEA==
X-Received: by 2002:a05:620a:3715:b0:7d3:8ba0:614f with SMTP id
 af79cd13be357-7d443990b8dmr1478968185a.26.1751219597952; 
 Sun, 29 Jun 2025 10:53:17 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd7730af00sm54700546d6.113.2025.06.29.10.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 10:53:17 -0700 (PDT)
Date: Sun, 29 Jun 2025 10:53:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Oleksandr Kolomeiets <okl-plv@napatech.com>
Cc: dev@dpdk.org, mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com
Subject: Re: [PATCH v1 4/4] net/ntnic: add warning when sending on a stopped
 queue
Message-ID: <20250629105300.153b53d5@hermes.local>
In-Reply-To: <20250620112707.294596-5-okl-plv@napatech.com>
References: <20250620112707.294596-1-okl-plv@napatech.com>
 <20250620112707.294596-5-okl-plv@napatech.com>
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

On Fri, 20 Jun 2025 13:27:07 +0200
Oleksandr Kolomeiets <okl-plv@napatech.com> wrote:

> When sending a burst of output packets on a stopped transmit queue,
> the packets are written to a memory mapped address.
> On queue start the packets are processed and transmitted by the NIC.
> 
> Signed-off-by: Oleksandr Kolomeiets <okl-plv@napatech.com>
> ---
>  drivers/net/ntnic/ntnic_ethdev.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
> index 79ef9e7e7c..4145128d11 100644
> --- a/drivers/net/ntnic/ntnic_ethdev.c
> +++ b/drivers/net/ntnic/ntnic_ethdev.c
> @@ -694,6 +694,10 @@ static uint16_t eth_dev_tx_scg(void *queue, struct rte_mbuf **bufs, uint16_t nb_
>  	int pkts_sent = 0;
>  	uint16_t nb_segs_arr[MAX_TX_PACKETS];
>  
> +	if (!tx_q->enabled)
> +		NT_LOG(WRN, NTNIC, "Trying to send a burst of output packets "
> +					"on a stopped transmit queue of an Ethernet device");
> +
>  	if (nb_pkts > MAX_TX_PACKETS)
>  		nb_pkts = MAX_TX_PACKETS;
>  

This may result in log spam if application is sending a lot.
And the message is too long and split across lines.

But best to not do this at all; no other driver does it.
