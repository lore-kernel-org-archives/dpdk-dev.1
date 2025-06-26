Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7585C7EE30
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 19:58:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE6ED4026F;
	Thu, 26 Jun 2025 21:58:11 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 360734026C
 for <dev@dpdk.org>; Thu, 26 Jun 2025 21:58:10 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2350fc2591dso14869195ad.1
 for <dev@dpdk.org>; Thu, 26 Jun 2025 12:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750967889;
 x=1751572689; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XV+7FVuC8c8jXJEFyf76iq05oRhfjhB+SueKhN6GDWQ=;
 b=c1HyTpJGIzaIVFEKgwagKPGJQ2cdy6S0466FkOmt8DxIBHUY64d7rTGMdeKkTmmx5O
 6gDSfQm66nFdIh0AHbwnjqx6gTJgOQbPGAYO8vY0rZPplfGXE4Lb4hMOC3IkrXLloasQ
 OkrHkRetB+K7fUSCggm3YCXLa1B+7h9KAZIWox8a6PoNAL3E8M/t2HhEV4npQP43olRd
 mpFuJ0q7yJklKGyUmSHhqf58bDn5wb92LWQM/t64nN3oPOyz6X1aTynGvH4MJHHm6O9x
 iv+Q7OpLvmFY9+zy5xFhdkV27Tt7mN+VVysuIlemOIf3GNGrygkDjH3K6pwJOubHckxJ
 p6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750967889; x=1751572689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XV+7FVuC8c8jXJEFyf76iq05oRhfjhB+SueKhN6GDWQ=;
 b=NhesP7aq0k/yb6VqZMhiVbA4XorJpZgDM7j60KQZGbLEBZHlpPCDy45+u9nrJYtkyI
 0tUs4M+EMMG9fj/c0Tz6Fbf7SHIWhc8YPE/PTDyVbkTQToO0MjVRX/t1g8Tb3Dbi3Ipn
 +fOybneTaeE5pLNQXajioyYTr26A79qOC62EcSkXosNQrhS9LaWJnQJhgq23XOzCKn3t
 VNddeq2fJqt0dfBIJC6xIS01C+EtpVy12p0CNX/BtPX4wvVff0r1WXU95w4UPwkHF9qU
 8qIRTC41/qngup25q5NRswBnZ8mywcM8epkIC88SLD7nTF5MPiPQyYh7zSlgfADYilDo
 RQ2Q==
X-Gm-Message-State: AOJu0YxrVrrMBOtTwOtBLrb8CA5CcDahlkCTYKdSjvL/qLNn3sDbOoHr
 NFB/VsBNZlJwXffa7XfDqtgIZSf3CUPkAHvuHrVfcOZ5tkXrdvcu481oWHcnIsbic/U=
X-Gm-Gg: ASbGncsf976qpubnEEG4XUPDSfsWon6cZsfRh/0J/Txkp9CsC+npXq1UMjqgtGBsqSd
 TF8r9zPkni8pourucv4/fXwNsZxyyknhi4y3fUrarJwTtl6ebtCyCiPdxXe+Nb/vuehMIS6C7mD
 QZxiloLYsLM5k+MINf6D8VlI7IE7P1rVw8LSaX3/FWjgR3iQjNKDI9xjb7BP5U/ealzzpwGm5HC
 hBqagudgUemyPOWttlYJTCFXxXwdzOxEC9y5INpW7NM7LOkjnQbKPxtcsXg7h/i6OLY3IYA/FCZ
 tejnQLZQsIN/P6afS/Ue/TGrYzWsXBQkXVqYeZDuLUcAB3UCu8szZRiWLqoQ1NYxaxfppkIlu+G
 xxCRJt+SI4PCiv4tfSHQh5HPrPZXdVWaoOpLw65w=
X-Google-Smtp-Source: AGHT+IGUFrgeS+ataPI0ne798Ict8ZKh9r5GpNNvSieLfpTVSGeRtffO2+Uoffkvll1x7WxvrIpf5A==
X-Received: by 2002:a17:903:1a84:b0:234:595d:a58e with SMTP id
 d9443c01a7336-2390a54e8d6mr69992245ad.25.1750967889293; 
 Thu, 26 Jun 2025 12:58:09 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23abe4424e0sm5000995ad.240.2025.06.26.12.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 12:58:09 -0700 (PDT)
Date: Thu, 26 Jun 2025 12:58:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, Yi Chen <chenyi221@huawei.com>, Xin Wang
 <wangxin679@h-partners.com>, Feifei Wang <wangfeifei40@huawei.com>
Subject: Re: [V2 17/18] net/hinic3: add FDIR flow control module
Message-ID: <20250626125807.26d650ae@hermes.local>
In-Reply-To: <20250625022827.3091-18-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250625022827.3091-1-wff_light@vip.163.com>
 <20250625022827.3091-18-wff_light@vip.163.com>
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

On Wed, 25 Jun 2025 10:28:13 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> diff --git a/drivers/net/hinic3/hinic3_fdir.c b/drivers/net/hinic3/hinic3_fdir.c
> new file mode 100644
> index 0000000000..32fc5472bd
> --- /dev/null
> +++ b/drivers/net/hinic3/hinic3_fdir.c
> @@ -0,0 +1,1394 @@

Suggestion: Don't call this fdir since that implies the old Intel Flow Director
stuff which was deprecated and (mostly) removed from DPDK.
Your code is for the current rte_flow API.

> +static int
> +hinic3_flow_fdir_vxlan(struct rte_flow_error *error,
> +		       struct hinic3_filter_t *filter,
> +		       const struct rte_flow_item *flow_item)
> +{
> +	const struct rte_flow_item_vxlan *spec_vxlan, *mask_vxlan;
> +	uint32_t vxlan_vni_id = 0;
> +
> +	spec_vxlan = (const struct rte_flow_item_vxlan *)flow_item->spec;
> +	mask_vxlan = (const struct rte_flow_item_vxlan *)flow_item->mask;
> +
> +	filter->fdir_filter.tunnel_type = HINIC3_FDIR_TUNNEL_MODE_VXLAN;
> +
> +	if (!spec_vxlan && !mask_vxlan) {
> +		return 0;
> +	} else if (filter->fdir_filter.outer_ip_type == HINIC3_FDIR_IP_TYPE_IPV6) {
> +		rte_flow_error_set(error, EINVAL, HINIC3_FLOW_ERROR_TYPE_ITEM,
> +				   flow_item,
> +				   "Invalid fdir filter vxlan mask or spec, "
> +				   "ipv6 vxlan, don't support vni");
> +		return -rte_errno;
> +	}
> +
> +	if (!spec_vxlan || !mask_vxlan) {
> +		rte_flow_error_set(error, EINVAL, HINIC3_FLOW_ERROR_TYPE_ITEM,
> +				   flow_item,
> +				   "Invalid fdir filter vxlan mask or spec");
> +		return -rte_errno;
> +	}
> +
> +	rte_memcpy(((uint8_t *)&vxlan_vni_id + 1), spec_vxlan->vni, 3);

No need for rte_memcpy here, not fast path. use memcpy instead.
Don't hard code value of 3; instead use sizeof(spec_vxlan->vni)
