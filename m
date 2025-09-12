Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE5FCAC582
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Sep 2025 15:13:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C37E14065E;
	Fri, 12 Sep 2025 17:13:38 +0200 (CEST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id C67A04065A
 for <dev@dpdk.org>; Fri, 12 Sep 2025 17:13:37 +0200 (CEST)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-7f04816589bso196999985a.3
 for <dev@dpdk.org>; Fri, 12 Sep 2025 08:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757690017;
 x=1758294817; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=en2sxcERkKhZk61Uz9LeTPPNatFc7ViYP6cm3axpx8w=;
 b=z9CKx9+Eo+R7YYB2y/EO2lEDgWrBsoXNFvjid1eaU6t8A0WUy/t2zOQLKPklNbU3Pf
 LUshUF/TG60BqVJbhAVh+WQXfcx2g1TU7EGNHlqvnEp/mSN9/GcvZhAX6afKiMjYMHyT
 Ojlk91WYZHsywfuxuBoVZg74zhZTf6A7IOjoWxTQNd/CRxrybMfaoSlTieFlIm2zmJND
 +qgLw5+7eCab1WcTYjjCQr9RtLiOJixISGShgbTUSx6h7+b7ArRCvLfw2iyRpm4LHxfI
 oU5cz1t8B4FWzgAaLYiq+A04wcJZpvyrf4U1z0rHzyQVpfo3DPPiMUvK5IB6UxhF89Jw
 /VTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757690017; x=1758294817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=en2sxcERkKhZk61Uz9LeTPPNatFc7ViYP6cm3axpx8w=;
 b=kd2QY1vr5kW3DEpmBip9P/uuLZ6HdG6tHAYW84UacqNffVFqwDJBH1ytpfoLaLof49
 IgUeAEJXDcdZ8TTvt2sdcw2WS6saFk3kuHjYqdzr7SlVMvxGvuxDztqHoktbWtkQlf1G
 tnzGAZxnN/U9+8zKNRiZKm+U9mA6pMjPWy9lHaKk0uNjFwG5ysIb8fB0/OB3B3rrsZcQ
 szGWG5xxAlid72A/+g9czZdD99DtAVGHN+cfHnHZodID+nJXEHkRuw0CKUSDWXenTbSN
 Ft+t6DeaLT7b+RJUdgEviO8xNFUufvxT8K/MUzQ9YyEoEVrd7b3oxBoAWQiB1bsji/zm
 N+xA==
X-Gm-Message-State: AOJu0YwHzALpZqdx7TeGUfUwAjlDPo6+68ww7MMTE5g39cgRKgZKQQVB
 MLdPo2Ft74K4PcOPglDPgfJgQE3vwiJOLAU7inFayTpUmcRj/4i6x/h94Ff/9m9AwD2PFqxn4sZ
 Hb9td
X-Gm-Gg: ASbGnctbon7uGQxp7YnjK3P2uivljt6pl96tNbUgmiIALKqjfoxGaQN2w2xfbrdfdeK
 miL6rJdPfZd5yenJQfC4Trz/R8ZjWrnnTWb0e0gI/BQJyOAk0ak4rw/Gna7cXjt/f6NgdpHtoyN
 N5l2GTQoPFtU/RCmdhxu3obS96R0KWwsC7FHGij/F1O0CxfQdbK0OYIUSiH4gr/iAMc0uvct03I
 XTWNYmPXD6IhDQJUT/jjejxPnkIFDZpynv4eKOOCo3pHV7K2iKDmdOc40WbPJwcdrT1lxV5kQ82
 AxUeR9ABsZitlQSkQVLRXhUDugpEg9o942Ntn7IOfkdPRcNqCZlDhZv1OuvCzav/vCVU4r3I8zr
 mqDtbUxiBB934Wko82vUKEYXV8c1DVC6FP9JFKf3fRGFXyxNhKjs0Qz9Ss/vVYBZhoYD9zTCQiT
 8=
X-Google-Smtp-Source: AGHT+IElqgjC6XD3D9D2kOQGBvYPsVRa2/JD3ViMD8YVRdYh9gCRICPfcMMQuzYCJDkjR6HUOyt+vA==
X-Received: by 2002:a05:620a:254a:b0:7f9:8cde:2bb7 with SMTP id
 af79cd13be357-823fbde83e1mr428620185a.11.1757690016797; 
 Fri, 12 Sep 2025 08:13:36 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-820cf5e22ecsm283939285a.66.2025.09.12.08.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 08:13:36 -0700 (PDT)
Date: Fri, 12 Sep 2025 08:13:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v8 16/17] net/nbl: add nbl device xstats and stats
Message-ID: <20250912081331.38bac355@hermes.local>
In-Reply-To: <20250912061752.2091320-17-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250912061752.2091320-1-dimon.zhao@nebula-matrix.com>
 <20250912061752.2091320-17-dimon.zhao@nebula-matrix.com>
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

On Thu, 11 Sep 2025 23:17:51 -0700
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> +static int nbl_dev_update_hw_xstats(struct nbl_dev_mgt *dev_mgt, struct rte_eth_xstat *xstats,
> +				    u16 hw_xstats_cnt, u16 *xstats_cnt)
> +{
> +	struct nbl_dev_net_mgt *net_dev = dev_mgt->net_dev;
> +	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> +	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
> +	int i;
> +	u16 count = *xstats_cnt;
> +
> +	disp_ops->get_private_stat_data(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
> +					common->eth_id, net_dev->hw_xstats,
> +					net_dev->hw_xstats_size);
> +	for (i = 0; i < hw_xstats_cnt; i++) {
> +		xstats[count].value = net_dev->hw_xstats[i] - dev_mgt->net_dev->hw_xstats_offset[i];
> +		xstats[count].id = count;
> +		count++;
> +	}
> +
> +	*xstats_cnt = count;
> +	return 0;
> +}
> +
> +int nbl_xstats_get(struct rte_eth_dev *eth_dev, struct rte_eth_xstat *xstats, unsigned int n)
> +{
> +	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
> +	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> +	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
> +	int ret = 0;
> +	u16 txrx_xstats_cnt = 0, hw_xstats_cnt = 0, xstats_cnt = 0;
> +
> +	if (!xstats)
> +		return 0;
> +
> +	ret = disp_ops->get_txrx_xstats_cnt(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), &txrx_xstats_cnt);
> +	if (!common->is_vf)
> +		ret |= disp_ops->get_hw_xstats_cnt(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
> +						   &hw_xstats_cnt);
> +	if (ret)
> +		return -EIO;
> +
> +	if (n < (txrx_xstats_cnt + hw_xstats_cnt))
> +		return txrx_xstats_cnt + hw_xstats_cnt;
> +
> +	if (txrx_xstats_cnt)
> +		ret = disp_ops->get_txrx_xstats(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
> +						xstats, &xstats_cnt);
> +	if (hw_xstats_cnt)
> +		ret |= nbl_dev_update_hw_xstats(dev_mgt, xstats, hw_xstats_cnt, &xstats_cnt);
> +
> +	if (ret)
> +		return -EIO;
> +
> +	return xstats_cnt;
> +}
> +
> +int nbl_xstats_get_names(struct rte_eth_dev *eth_dev,
> +			 struct rte_eth_xstat_name *xstats_names,
> +			 __rte_unused unsigned int limit)
> +{
> +	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
> +	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> +	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
> +	u16 txrx_xstats_cnt = 0, hw_xstats_cnt = 0, xstats_cnt = 0;
> +	int ret = 0;
> +
> +	ret = disp_ops->get_txrx_xstats_cnt(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), &txrx_xstats_cnt);
> +	if (!common->is_vf)
> +		ret |= disp_ops->get_hw_xstats_cnt(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
> +							&hw_xstats_cnt);
> +	if (ret)
> +		return -EIO;
> +
> +	if (!xstats_names)
> +		return txrx_xstats_cnt + hw_xstats_cnt;
> +
> +	if (txrx_xstats_cnt)
> +		ret = disp_ops->get_txrx_xstats_names(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
> +						      xstats_names, &xstats_cnt);
> +	if (hw_xstats_cnt)
> +		ret |= disp_ops->get_hw_xstats_names(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
> +						     xstats_names, &xstats_cnt);
> +	if (ret)
> +		return -EIO;
> +
> +	return xstats_cnt;
> +}
> +

You need to check the limit value.
The API is designed so that application is allowed to request only a subset
of the counters.
