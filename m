Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F75CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 22:10:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B71340EDC;
	Thu, 16 Oct 2025 00:10:46 +0200 (CEST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by mails.dpdk.org (Postfix) with ESMTP id 5116A40EDC
 for <dev@dpdk.org>; Thu, 16 Oct 2025 00:10:45 +0200 (CEST)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-88e456972d5so11382885a.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 15:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760566245;
 x=1761171045; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p9UQYQ3Q+VwU/ZgDAjalrMuc+Vo0x/kEv13L4NsD3RE=;
 b=i3ZtI/Y7pF8BTBv9OsN4Jp9KeTT7ld0uFya9UXIqtJln/zZgEKOFXdSkCmd8LJJCTq
 VsIgPWjNZOJI40M/KTgor6fVgA1oo7ESmCg7+xuNsRe+02ttJ7HuCD1wa0GCFf72Gfl9
 kKLwtzqErl6l/DuDOttv0eUNknZq5rhuhP9xwAsQSKDNMTkkxYEDmUdCYe1oYQMj2NQq
 3pXqxkld1pJDafD1ucGv/A+04wy0sPUb6bf5B3wX86g7KG/ymUKyw09lLu7eCFhuDQgP
 BxS2NNGg66+VIT65jC5VSYP9mlxF+D5ke6e9Hxw4LCqILmtP55HnqFjJ00jtt7hznMpp
 yCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760566245; x=1761171045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p9UQYQ3Q+VwU/ZgDAjalrMuc+Vo0x/kEv13L4NsD3RE=;
 b=L3l562tvQXSqivz4dtwmksiz3lEkwXbEcpj3sxb/IiUn4DtrgVmF0+C+OxC0O9rKe9
 Q67QOFn+2aTPhfHcUAWqtGN0d9Tii9ZRKksqt0K4AmwyDMD6hviH5LuXYw/G6fs1Smci
 TggKS1vyu4pi8JxldfYRawZonkcLwJhDEo/zoVYTRURG0ZRqgqcJ/XQO41kHVDikigOb
 S1y0Hbt2le2cruGGKunmHN1NXEahqSaE3Ip6Z6QkFtIF4hDbMDyGojI9QvW2Cj25uJgD
 fD5E3Kbqxl+6FG78hlA7ztmmapeJtE3bfppCrJ0Fy2mN+SdKXDytccHAhGXee8K3XVeS
 LcdA==
X-Gm-Message-State: AOJu0Yyge0XjEXt8oQoXq5DlU3df0DHQ4xQd4cBk4Ey3Tb54lDP8vGsC
 LkzILFAd9HrSTjVD0U7Yc0PPPv0Vfal2Sz8Jsa2J6tlizLCudjU69hipSI47mzxQT68=
X-Gm-Gg: ASbGnct9IuQjF+qNPn97JkSQLgeEpIE/8wQ/+dRHZ6yL2mrRQEOzEp0aw+R1JT43pjg
 hhbAqt2Hk7XmjKWXJu8BBIKHf+Y69Pft+LXvFRUBUx9Ztb5m5MX4JERYOUdudgk45XKkkjPm9I5
 hhXYMko9lFEOcmFR6tO038eFqLQHK+bw3mGOa+QrYQGAkWR/LuMJVa1TtRoaTu0wjqddVjRycMr
 j0iLLxGaGxGlL1/F8LzV8DuW0EbyEGOlXITAsNMUMGIO0yLSAHrn9dMrEQKEyj2RxjBqMyfqD9o
 yjdEkTFRRjluQMhTdxs8x6MxHZWYULebhmM5Pi5BofDHGibVT2/dwFM1y/0hWUoF0FMv4yAmqLj
 lUPMVadIJfbcIp+B6CqzZItw65xQk+T4SR2rJKQJvoABXjCwHzKxlroMVEz4VVmkkm346s4vXkv
 hHU8VJS5sqXW8gR2zC1Rpo/7XzHlui/+OhIAzhW9lkxnxFuWC5RAuD
X-Google-Smtp-Source: AGHT+IF+Y3wqawM/964uPV+rEHO+znGX52Uw+rXzwvA/84FxDJmiK/UaJWuwdByDA784gM/g+MPTqA==
X-Received: by 2002:a05:622a:1313:b0:4b5:ed9d:7bcd with SMTP id
 d75a77b69052e-4e6eacdae2fmr437692751cf.16.1760566244514; 
 Wed, 15 Oct 2025 15:10:44 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e881c577e6sm27732021cf.7.2025.10.15.15.10.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 15:10:44 -0700 (PDT)
Date: Wed, 15 Oct 2025 14:42:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: vanshika.shukla@nxp.com
Cc: dev@dpdk.org, Gagandeep Singh <g.singh@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Apeksha Gupta <apeksha.gupta@nxp.com>
Subject: Re: [v1 02/12] net/enetc: Add RX and TX queue APIs for ENETC4 PMD
Message-ID: <20251015144218.0ae34a17@hermes.local>
In-Reply-To: <20251009111633.3585957-3-vanshika.shukla@nxp.com>
References: <20251009111633.3585957-1-vanshika.shukla@nxp.com>
 <20251009111633.3585957-3-vanshika.shukla@nxp.com>
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

On Thu,  9 Oct 2025 16:46:23 +0530
vanshika.shukla@nxp.com wrote:

> +int
> +enetc4_tx_queue_setup(struct rte_eth_dev *dev,
> +		     uint16_t queue_idx,
> +		     uint16_t nb_desc,
> +		     unsigned int socket_id __rte_unused,
> +		     const struct rte_eth_txconf *tx_conf)
> +{
> +	int err = 0;
> +	struct enetc_bdr *tx_ring;
> +	struct rte_eth_dev_data *data = dev->data;
> +	struct enetc_eth_adapter *priv =
> +			ENETC_DEV_PRIVATE(data->dev_private);
> +
> +	PMD_INIT_FUNC_TRACE();
> +	if (nb_desc > MAX_BD_COUNT)
> +		return -1;
> +
> +	tx_ring = rte_zmalloc(NULL, sizeof(struct enetc_bdr), 0);
> +	if (tx_ring == NULL) {
> +		ENETC_PMD_ERR("Failed to allocate TX ring memory");
> +		err = -ENOMEM;
> +		return -1;
> +	}
> +
> +	tx_ring->index = queue_idx;
> +	err = enetc4_alloc_txbdr(tx_ring, nb_desc);
> +	if (err)
> +		goto fail;
> +
> +	tx_ring->ndev = dev;
> +	enetc4_setup_txbdr(&priv->hw.hw, tx_ring);
> +	data->tx_queues[queue_idx] = tx_ring;
> +	if (!tx_conf->tx_deferred_start) {
> +		/* enable ring */
> +		enetc4_txbdr_wr(&priv->hw.hw, tx_ring->index,
> +			       ENETC_TBMR, ENETC_TBMR_EN);
> +		dev->data->tx_queue_state[tx_ring->index] =
> +			       RTE_ETH_QUEUE_STATE_STARTED;
> +	} else {
> +		dev->data->tx_queue_state[tx_ring->index] =
> +			       RTE_ETH_QUEUE_STATE_STOPPED;
> +	}
> +

Max line length is now 100 so could be on one line here.
