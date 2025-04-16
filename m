Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D97CC369C1
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 16:43:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40E59402E7;
	Wed, 16 Apr 2025 18:43:17 +0200 (CEST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id 422CD4025A
 for <dev@dpdk.org>; Wed, 16 Apr 2025 18:43:15 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-af6a315b491so6171946a12.1
 for <dev@dpdk.org>; Wed, 16 Apr 2025 09:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744821794;
 x=1745426594; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Xp7ivDIJlTfyI4zQZHZ9Mcn5Sj2tQx5OMWDX7fvMvk=;
 b=aJzeSv2RLblan5CORlZYplrRoeRVGRRu+eM4ZED03LDIHvJLP/EZu/N5DRVLBcdRQw
 vrsBbJo8RvnwOBmqIyZQldJORdt54Y8TJDuT/oFyPxkSxZfrzZTPe6EOHJkf0L5ZH6PM
 yZoPf/aRjmsPUJS7py8dbRy3CdUZhoRMkPbMDA6QDQneyHb2ZCbEd/C9e6qo12wnaytw
 M5E2oea+1OkZlGbdi1j5fUw0azsLkueZqyZAL1wJLAHjbYxIMNNsBBlU9umctDyVeV/t
 GHQ0TIe/tkYxk2IEgFPQmxNbNTPeT2YG02irRPZxaoSmdQRV9ueMPkEJoVQCkD85P0Py
 /Yfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744821794; x=1745426594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Xp7ivDIJlTfyI4zQZHZ9Mcn5Sj2tQx5OMWDX7fvMvk=;
 b=KILywo8bJw9fcMoN+eRTfl7A2HcJfl5mpSjnQnJ3o+XlT8WX4dVg0zQBI8LzbgI0mY
 7m9vHPVq2e53y3V1EjHgMyAI4FFV2weyPtRlTnhjOkmgJ6hMlGv8+s52HUyHgrgTdIAV
 ls1HHLTmUm3RvV5T3LRY8/TY2AcMx/zoo6Gr1P9WDP9+IuFs6nx1GMctssyNEd8QY5UK
 BbYmGHc7lDMoybItzOL/uqQEwFOm5kKpESUXflB6OPdFrILB8qa/9oX5o82u/YLDNRca
 M3nCgzWO9TuB6akiJap3p8G/X0jWK9Llvx+y4v2ocYMaeu+Le+4dP/6s6jha2IlGtVqH
 BvaA==
X-Gm-Message-State: AOJu0YyiuxLuMV1n2olgBCOA+O0fZcK9wLVUuTwjRr0yXjG7GSwBOmS1
 tfiUdybjkZqpTbpqtRHg9dQBRAcnvQvz4GRYffPw2WFjFvXhYLneBhLwp0zwsX4=
X-Gm-Gg: ASbGncs74g6kUQQEx3Z2E/h2zujAOIgGSc5zjQcjM6MwrjbWnCh5DKV4WooNf7rMFXZ
 E6CjDI6OXyKm/+tz33O7koetImsuTifrz/fp9TzuyRC9bCUxSql17VUBuIuPSQ16Ae/2L4ptric
 9U1zN22QLvrJifvXcilDCRO4J1qs1EenUxDC15RqpIhPst4gx+FcZ+GiDFHFWDwIMU41IKFV1RA
 dDle7hcZPIbl5iutP2b5pvsH1XrrytAcBLL/rrzD9Zd9YlEFvBkNHXDTBz4D0YG4alhl8H6WjCf
 f3GMgW/GpJFQ8tzPRqlnfj3gsL+lk3fPxDi7SLQ+a2qHPmGkkJyMGXs18FXOAcFsXP+ggl7rWbJ
 Ez6s4V+sx2U9Ry6+y
X-Google-Smtp-Source: AGHT+IGMSXnWQLTtwWQbrqZmZkylUvx3+xNpY3QBsG2t0ZCBnZhs7EKrQ4dWswFOXQrsz0HGPUZYtg==
X-Received: by 2002:a17:90a:d64f:b0:2f9:cf97:56a6 with SMTP id
 98e67ed59e1d1-30863f19e0amr4341477a91.14.1744821794242; 
 Wed, 16 Apr 2025 09:43:14 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-308611f002esm1808265a91.15.2025.04.16.09.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 09:43:14 -0700 (PDT)
Date: Wed, 16 Apr 2025 09:43:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liwencheng <liwencheng@phytium.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 4/4] net/macb: add necessary docs and update related
 files
Message-ID: <20250416094312.5805259f@hermes.local>
In-Reply-To: <1743577171-119901-1-git-send-email-liwencheng@phytium.com.cn>
References: <1743577171-119901-1-git-send-email-liwencheng@phytium.com.cn>
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

On Wed,  2 Apr 2025 06:59:31 +0000
liwencheng <liwencheng@phytium.com.cn> wrote:

> +Features of the MACB PMD are:
> +
> +* Speed capabilities
> +* Link status
> +* Tx Queue start/stop
> +* Multiple queues for TX and RX
> +* CRC offload
> +* Jumbo frames supported

I see no operations functions for Tx queue/start stop
in macb_ops. Obviously not tested.

int
rte_eth_dev_tx_queue_start(uint16_t port_id, uint16_t tx_queue_id)
{
	struct rte_eth_dev *dev;
	int ret;

	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
	dev = &rte_eth_devices[port_id];

	if (!dev->data->dev_started) {
		RTE_ETHDEV_LOG_LINE(ERR,
			"Port %u must be started before start any queue",
			port_id);
		return -EINVAL;
	}

	ret = eth_dev_validate_tx_queue(dev, tx_queue_id);
	if (ret != 0)
		return ret;

	if (dev->dev_ops->tx_queue_start == NULL)
		return -ENOTSUP;
