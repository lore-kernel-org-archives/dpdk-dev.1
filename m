Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9349C369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 18:38:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D552E402E2;
	Fri, 18 Apr 2025 20:38:18 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 77852402D3
 for <dev@dpdk.org>; Fri, 18 Apr 2025 20:38:17 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-227cf12df27so18584195ad.0
 for <dev@dpdk.org>; Fri, 18 Apr 2025 11:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745001496;
 x=1745606296; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TerfrAmMTe1fcbthvrcBWCAbS5wCIH22sSBBOi3SF+s=;
 b=vlICR4eoHmS6oP54YNsBQDZi5TRORpJRTJSbvJ65wiQKK6M6yUTrmlbecIHHTUE363
 rPrjGMoJoBylay1AiA8MF2Y67JcrqH6zwaokrK3RtWLubOjCb/bHNkr9tEPlKFjsPFI3
 X2KX1pzNhAqlW1HTGsADxEktH+xMJIAGlmsKf92dgflXkBQkmzzEAbuKPycisI5klbRQ
 LnBwTfMRAYw343ubZSDy9M4BZyy1ROUXRlh+olB1A8UsXSduJ7MNXcdYtKmvXBkKV+0B
 PLimK+VRhKDdL786MEpTcPIccuoXbGSs8/T0M6DHI0VpgOGc0s583oUc+dvnQ91o2Eo2
 E0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745001496; x=1745606296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TerfrAmMTe1fcbthvrcBWCAbS5wCIH22sSBBOi3SF+s=;
 b=D3AkwomuATgVN4TnJ0OzXvYZeFJ/OvI+pfjFMRMdULBB7ifRLpJqO6ihEQY8lsL3Na
 nlZ0OvSCw/I2TqSw3ZlllCcxvqvmVPBm88R5wfkRE8HUShFPczzRJhF7sNS6Nr2pjwDn
 IbXSS1szXVWcDyHMVJ/nCrwuyoXZHtkRksy2I9n/vDN5cYco2BbgiT0afcAv2RWf9zDV
 M6Y9Lm04EMEAuPg+4BS7sqKcNFjCxJYxmPJ329VWuJQLSiXmRPE2Z3/EQqvp1zpM2QHy
 ETqR1ir25OIbAzKcT9EPZGyZZfkEsN7CWZ9ABRt+JDnRP6fYkzyG6RP0x/FMk88lfUoU
 ZyQA==
X-Gm-Message-State: AOJu0YygCzdtCH5wfGPPG0cS9QpiY1nry8f77zDcZpAqQVpcohUKQQVb
 9bOHKHQUic23r1BiMjfGHKJ0IDMguPo3dq+A9/HzJcB6gSFNR1gfqUl/2z+rxgU=
X-Gm-Gg: ASbGncuYY8eCCpwqOVBITIsR8eE9PHTdmILPF5MYfGhrfYTWyP3g41Hrjut1Y9q0JWJ
 92njFR4jjHNSIeJa/1AFvrWDYHzmemi9UnPLjxz9Vzol/Dfx/mRHSkiIauT0EslMe67X8Zw+RzX
 F8PNhq2PWpbFcAizKPYTWlafHL11+22rp6HbZ/XLt2NlYrjExbKBZXmQlUGkciLkbevmoPc2C3Q
 hMNDUs7Sm0DYC8RtLFMPvZXgfB7wbtTeuFBuS4/5mk50TdGFHSOBaIbDJp0U2Huk+HyqeuaysGP
 Ub7CBr70Yuzh8QJsW1Zb32/qg1peDVHNSQrT6ZPzgttq262xqbzL2TE8eFjIpXube+mB6eN4BnU
 cBlD1JR/MRcWmv/gH
X-Google-Smtp-Source: AGHT+IFPS4im1dbdAhMRmPh0+T91q/yvEsMSy9lFiUFx/A/cmJrX+lNY06sV86xu1LsesKioAucc2A==
X-Received: by 2002:a17:902:e884:b0:221:89e6:ccb6 with SMTP id
 d9443c01a7336-22c53f17338mr55178285ad.25.1745001496411; 
 Fri, 18 Apr 2025 11:38:16 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bf1371sm20139465ad.57.2025.04.18.11.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 11:38:16 -0700 (PDT)
Date: Fri, 18 Apr 2025 11:38:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chaoyong He <chaoyong.he@corigine.com>
Cc: dev@dpdk.org, oss-drivers@corigine.com, Long Wu <long.wu@corigine.com>
Subject: Re: [PATCH 2/3] ethdev: retrieve VLAN filter configuration
Message-ID: <20250418113814.2f0a48e5@hermes.local>
In-Reply-To: <20250411081005.1133509-3-chaoyong.he@corigine.com>
References: <20250411081005.1133509-1-chaoyong.he@corigine.com>
 <20250411081005.1133509-3-chaoyong.he@corigine.com>
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

On Fri, 11 Apr 2025 16:10:04 +0800
Chaoyong He <chaoyong.he@corigine.com> wrote:

>  
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_get_vlan_filter_conf, 25.07)
> +int
> +rte_eth_dev_get_vlan_filter_conf(uint16_t port_id,
> +		struct rte_vlan_filter_conf *vf_conf)
> +{
> +	struct rte_eth_dev *dev;
> +
> +	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
> +	dev = &rte_eth_devices[port_id];
> +
> +	if (vf_conf == NULL) {
> +		RTE_ETHDEV_LOG_LINE(ERR,
> +			"Cannot get ethdev port %u vlan filter configuration to NULL",
> +			port_id);
> +		return -EINVAL;
> +	}
> +
> +	memcpy(vf_conf, &dev->data->vlan_filter_conf, sizeof(struct rte_vlan_filter_conf));

Could just be a structure assignment which would preserve type safety.

> +
> +	rte_ethdev_trace_vlan_filter_conf_get(port_id, vf_conf);
> +
> +	return 0;
> +}
> +

Not sure if adding new accessor function is really needed.
Unfortunately, all of dev->data is exposed in DPDK API already.
