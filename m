Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BA8C982DF
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 17:34:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA8AB42E63;
	Fri, 16 Jan 2026 18:34:08 +0100 (CET)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id A9C5B4026A
 for <dev@dpdk.org>; Fri, 16 Jan 2026 18:34:07 +0100 (CET)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-431048c4068so1319035f8f.1
 for <dev@dpdk.org>; Fri, 16 Jan 2026 09:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768584847;
 x=1769189647; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DllFruRYMHVRxw4ugeNSkFef59hQSSHP2iELynkw7hM=;
 b=FlaYhC7nQKRh2FMsZCbc5+LYtFKCdWrk68HOAOB2cgtKYyaEvLu6qj9KCS5OUu2OLK
 7H4UqjeQuIFDZBH4jgilRAv7/3otclkYo06muJafHCsGMSbHHGmSkvUR4cJsSWvHDpj+
 XPFWQKJvMu7lCiOpKVf3BFJLS0mb8pLBq81ykj6tkiEclXIpwAOF1nb+v9G/IpaVOB9Q
 I/TswS7bMJzAvsSHvILAcAacDBdzw9Fe96/mTqHtibcmjzHgWSj+91SF7P4e4oPdgGNv
 4BFaZdY4HU4QjcWbbgqRQVXntWwGIIgX6iqPVdR1xmv2MispGM9y24PxTpoSmWUexDGG
 XMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768584847; x=1769189647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DllFruRYMHVRxw4ugeNSkFef59hQSSHP2iELynkw7hM=;
 b=hsF/4S49IT4Ly40vowiDkaZXEm5zrykxwdpcDkgkkKVahlNYKigfnFcq58oYKo/uvm
 nSlXivZjb7rjSIFMTXT5xI+3DUGLG4sPeqO6rZJtEFrK/TeuR3tGF57gBFSS3X75Nagm
 wGjIz3Wlg05GFICStM1wvGsRJ2w170hQOBKa3GYx7Q6M0QRS3W8jWbeKaqugx7zdimfW
 g/o8GOEoIBTMBywIec6IKeW8ER+bTROgoG7BLnnisjFXlLNoCmTYIWw99m1blHoDENqs
 4ZMFzV9XX0ilmEmkj4FeRJ/ZBnaDiVPyFvgS+fffmZP5jf5VQFN4U10Na1TqaA2MLH+0
 bhMw==
X-Gm-Message-State: AOJu0Yxtmrx/v0u7Lco4oo71YpuvGhoPmH5i5Xk/jy7jcfJ2PdU/UCyA
 m+V5dzRWErALjpsy55wqj2ARQkDqTH7jA5vsUpjo/yXrhkDByoFbiTdJwweXeatnQRU=
X-Gm-Gg: AY/fxX7QGuK9GsjRie/Bwwbc2rdZvvyQR3SVS/ZKMFz6eHNTNPV7dnhPhAPcuOXb87P
 2KYYtsg1AQuUI77sKpZyHjoBVB0Jgz79FP8qJz0klQb61RmwnCzkPk2mSGAU5sDy/Ocjl4v10j7
 ZspuhNJ+umclyRVxT+TJ/azLw+jNvusFedjfaLR8nldO84vsjvzhfguYcZ8uepTEL8GkzqLWDmr
 a20PSWi0mefdsKbyKDrb+CIzByZ3lyxv9usjLDePAINNzuadfFLd5BnK+hSXM8XakIgpB62CYx2
 FGW7QTw0fHtf9cgjOsna3bkH9p2hNr8r2JQfFGWo5V9jQWKH1S4ErTuHY7J71QJR7oybSPwQICQ
 9UdfhP49LPyYly/F9iwSfyzVhBX9c+P06junQoyg2yjzb0joMy8cuOXkhFK/7tue/Fb8fezCHKd
 Nu/UfZfkUmpsSLWzk85pdLKFL93HsrBqwaWI3VASbAgngRy/dlvNlnMLdU0NHyp1k=
X-Received: by 2002:a05:6000:2089:b0:429:b8c7:1848 with SMTP id
 ffacd0b85a97d-4356955f32bmr4645122f8f.19.1768584847154; 
 Fri, 16 Jan 2026 09:34:07 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997eb0bsm6264438f8f.34.2026.01.16.09.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 09:34:06 -0800 (PST)
Date: Fri, 16 Jan 2026 09:34:00 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH 1/8] net/nfb: prepare for indirect queue mapping scheme
Message-ID: <20260116093400.74fc31ed@phoenix.local>
In-Reply-To: <20260115151656.393106-2-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260115151656.393106-2-spinler@cesnet.cz>
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

On Thu, 15 Jan 2026 16:16:49 +0100
spinler@cesnet.cz wrote:

> diff --git a/drivers/net/nfb/nfb.h b/drivers/net/nfb/nfb.h
> index d85c5fba62..ef41d100ac 100644
> --- a/drivers/net/nfb/nfb.h
> +++ b/drivers/net/nfb/nfb.h
> @@ -47,6 +47,10 @@ struct pmd_internals {
>  	uint16_t         max_txmac;
>  	struct nc_rxmac *rxmac[RTE_MAX_NC_RXMAC];
>  	struct nc_txmac *txmac[RTE_MAX_NC_TXMAC];
> +
> +	int             *queue_map_rx;
> +	int             *queue_map_tx;


Since these are queues, would prefer uint16_t rather than int.

> +
>  	struct nfb_device *nfb;
>  };
>  
> diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
> index 74728f91dd..247f78fe24 100644
> --- a/drivers/net/nfb/nfb_ethdev.c
> +++ b/drivers/net/nfb/nfb_ethdev.c
> @@ -510,6 +510,7 @@ static const struct eth_dev_ops ops = {
>  static int
>  nfb_eth_dev_init(struct rte_eth_dev *dev)
>  {
> +	int i;
>  	int ret;
>  	uint32_t mac_count;
>  	struct rte_eth_dev_data *data = dev->data;
> @@ -567,6 +568,23 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
>  	dev->rx_pkt_burst = nfb_eth_ndp_rx;
>  	dev->tx_pkt_burst = nfb_eth_ndp_tx;
>  
> +	internals->queue_map_rx = rte_malloc("NFB queue map",
> +			sizeof(*internals->queue_map_rx) *
> +			(priv->max_rx_queues + priv->max_tx_queues), 0);

Use rte_calloc() of arrays.
> +	if (internals->queue_map_rx == NULL) {
