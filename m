Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0500C71130
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 16:09:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F4EF40287;
	Mon,  7 Jul 2025 18:09:05 +0200 (CEST)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44]) by mails.dpdk.org (Postfix) with ESMTP id 587164025D
 for <dev@dpdk.org>; Mon,  7 Jul 2025 18:09:04 +0200 (CEST)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-6fd1b2a57a0so36153416d6.1
 for <dev@dpdk.org>; Mon, 07 Jul 2025 09:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751904543;
 x=1752509343; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+I0a8dKbjPlWw5RPGHhAQXZhxDgwM0ketz4fMVUOJSE=;
 b=Z8ZWonaeK5DsF2otqEsndLQKZw697BufRGs5/40FgVFOZftadOVK08UqdobCryFrJ2
 NPY+p9QWB/h+npU80U16PlDrOB1xOJYPUlzlvaje3osy4oiDRugjpx93Wftb81Ib73yI
 IzESkIQp+gwqLEtBO/u7uNkAB3GsAUXM8lYiVJ/0jHp6MT93O4OyI+NSMSzAWzGfnjfZ
 CnyenNb2DUFSLpjg4AZRJgvNkbIE96HeHCQrjpZDLFPafvs5+CZMV0T8p8sY/jEti1z7
 haKyhYZPnyGovR6nEyF+qlVH4z+z1lENgbBWEY8YYTMebqGvDZ++0p44kyQahfYeCkUm
 KclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751904543; x=1752509343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+I0a8dKbjPlWw5RPGHhAQXZhxDgwM0ketz4fMVUOJSE=;
 b=PgxhrxkaJPEl7JFyZ2bga+fdPuYtVQVS983ICYFABt4YpBMpA6N7UKJso1Igo5+ecI
 NSzRbJ6bAdC9wJWlHE7TWXDDcpy7q7ZzFgqE5H6KfaewI2kgRcPd+0khbXii4nBWuk9b
 v3oPuUCkfI/4xKLTKWF8zFb3YAHZbgzGb01KVN+zBRcbl0CX+LgefUJKs73BDxwM9k1e
 Q4iVGbwPbmXp00Z5yPAN+Fyi7i4Z8kT9ZQpfi6EA4/uVyBJHBRSoO8Gd2b2T8GzjtBl+
 d6Cn29oLYND40vOH+l3Ibn0J0jUFikDajZ9cPKm/qWM6yl29kHgcpbmwTknoAnD52H/a
 rw1A==
X-Gm-Message-State: AOJu0YyZlh39aXCrtIe7TgcePKUzSbS1/o0TYgClgLsH8GmOz8ziAnDE
 cWsTqpbLeDCVqdAP18YtsnluDdPqoK4A2Equ6BNpjjIBUfLZ54jSJrRFgST+YWOcGL6pqvHxf81
 D03PQ
X-Gm-Gg: ASbGnctfy40se9zVmx+T6zMHiZxPzuFMG0ukAEvDvfAfxSFchOXdjxOXjCZp8dyrjdQ
 9m6/tymrx2QtfxzKKhVFkgESv9KxYzR/Uni5tSm2AfpwciSozvRLwWUk/B0E4dGJa4jDHFVZgkn
 Tu0CVXh5S+JGp0BWRrzfWDi/FpNaGG7EhsqmgSEdtAL3arRtvVciuzM9M1qU3AbfZ3pd1VdELSJ
 LMTcL2MQEUd/cHP/OJ+bfKOTIVNo0s0jw7u/tjHDAyi5pPOHqtwtq5zS44jrSnLu4EE7LmNW0u0
 yM4P9s6K8l8e2SdDyNrUj+UuMJAyUeXRZyWyC7pothZYemmdqEE9QMXf1h5S0PEFA1JRAlXw3im
 55r0npgLH5pFzyTAutAoFQeeyoqFA68e7Y88+jPY=
X-Google-Smtp-Source: AGHT+IFIUvgV+GKBhPOw0sejTYAbYHDKTBV+X2Cgqr5rOCDQvVxKwNZ6/IDa3jMjfYNemqtMKtyBdw==
X-Received: by 2002:a05:6214:2608:b0:6f8:d223:3c14 with SMTP id
 6a1803df08f44-702d171dd04mr136816446d6.25.1751904543420; 
 Mon, 07 Jul 2025 09:09:03 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702c4d51147sm61672866d6.57.2025.07.07.09.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 09:09:03 -0700 (PDT)
Date: Mon, 7 Jul 2025 09:02:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v1 2/6] net/zxdh: fix issues related to MAC configuration
Message-ID: <20250707090224.1ee10cf3@hermes.local>
In-Reply-To: <20250707055621.357606-2-wang.junlong1@zte.com.cn>
References: <20250707055621.357606-1-wang.junlong1@zte.com.cn>
 <20250707055621.357606-2-wang.junlong1@zte.com.cn>
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

On Mon,  7 Jul 2025 13:56:17 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> Fix error handling when MAC configuration fails.
> This is issue was discovered during internal testing.
> 
> Fixes: 1c8f68b64cfc ("net/zxdh: optimize MAC operations")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Junlong Wang <wang.junlong1@zte.com.cn>
> ---
>  drivers/net/zxdh/zxdh_ethdev.c     | 15 +++++++++++
>  drivers/net/zxdh/zxdh_ethdev_ops.c | 34 +++++++++++++++++++-----
>  drivers/net/zxdh/zxdh_msg.c        | 10 +++----
>  drivers/net/zxdh/zxdh_tables.c     | 42 ++++++++++++++++--------------
>  4 files changed, 69 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/net/zxdh/zxdh_ethdev.c b/drivers/net/zxdh/zxdh_ethdev.c
> index 80053678cb..8996d86b90 100644
> --- a/drivers/net/zxdh/zxdh_ethdev.c
> +++ b/drivers/net/zxdh/zxdh_ethdev.c
> @@ -1265,6 +1265,7 @@ static int
>  zxdh_mac_config(struct rte_eth_dev *eth_dev)
>  {
>  	struct zxdh_hw *hw = eth_dev->data->dev_private;
> +	struct zxdh_msg_info msg_info = {0};
>  	int ret = 0;
>  
>  	if (hw->is_pf) {
> @@ -1274,7 +1275,21 @@ zxdh_mac_config(struct rte_eth_dev *eth_dev)
>  			PMD_DRV_LOG(ERR, "Failed to add mac: port 0x%x", hw->vport.vport);
>  			return ret;
>  		}
> +		hw->uc_num++;
> +	} else {
> +		struct zxdh_mac_filter *mac_filter = &msg_info.data.mac_filter_msg;
> +		mac_filter->filter_flag = 0xff;
> +		memcpy(&mac_filter->mac, &eth_dev->data->mac_addrs[0],
> +				sizeof(eth_dev->data->mac_addrs[0]));

Since mac_filter->mac and eth_dev->data->mac_addrs are both of same type (rte_ether_addr),
using structure assignment operation instead of memcpy is preferred. Assignment assures
that types are the same. 
	mac_filter->mac = eth_dev->data->mac_addrs;

