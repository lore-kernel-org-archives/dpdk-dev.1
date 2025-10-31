Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6AACCFA02
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 17:59:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 276D14028E;
	Fri, 31 Oct 2025 18:59:15 +0100 (CET)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id E217D40150
 for <dev@dpdk.org>; Fri, 31 Oct 2025 18:59:13 +0100 (CET)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-33b5a3e8ae2so3167676a91.1
 for <dev@dpdk.org>; Fri, 31 Oct 2025 10:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761933553;
 x=1762538353; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K0kmrTT5RmcqFWHVSLAjqd0Z9ZsEwgM70zH7kIRuoVs=;
 b=US90bZmYZU4l4mEFVa7tR6/5Eghx582c3S+GyA0JAScR+hg0+mTZKQxSt83E//+T02
 GQ8Hntfsf1uVB84IJNKfZz0TY3nxAtDBcvsDhVY6iJ1b8+lP09doTRYOzRk/sID58bGv
 q03UH0kFH63vy1Bqhsbn7iKS8ECdL+pWP2X9AkGqpvsODr6jrxXs3vN5a7MslPqgMSYQ
 tSqjWmqRyy7kZJJioEJh03ujXzltsRxqXWhb3ftyA9fyekpPkL6UIay2M4qAltcfSpTE
 iBmv2Y16Bt+W18G2A/8/1VtUYWtR+Y4HttNn/QrC39pFuLrYSTpcFnMS48vUJrL1/Bcv
 ii7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761933553; x=1762538353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K0kmrTT5RmcqFWHVSLAjqd0Z9ZsEwgM70zH7kIRuoVs=;
 b=wsyVxWbRyrK2a5GhQbSfLxnS/j2oA1LaCnRyjZEg8g4BdSaAcynpTg9CB/g9Y4AhSy
 BmwFA7H2KG/jzsTIPjTFHTaEcdGFglGfXobyAgj7uEvocNlKoS5icxfP/gVmPBpHyHHK
 gGmyyFnFVjs7mze0+VPpjzhTtlYM3Lt/nj0gWOOL6vpvUwk1yMEo+8XDWn0ne0lFAKrF
 h8ldh8OuXJovTHgqFoHdadPBIjd/UgzTRPcMqQOCinSwDO812ozEs1KVD52gIwEv6Wok
 oJytsDX0zIv4QYMDJ4R/blLQ8PXM6kdQh+lhB1St1gSKuuU1nPKIhx9Aei+TXJHCsUSz
 7gGA==
X-Gm-Message-State: AOJu0YwkyIwNz7X9V9cGTOYHviB+vVCIIW8eYyDzgKZjpXJZu1TjiQoZ
 rtMFBTunLeb43foiK4FIHmAS4npwimHv0L826//n3xc2yEVgin0nLSNcqhhTNnnB3DWG7h7+2at
 II2Gf
X-Gm-Gg: ASbGncvafNU+yi3YJGNofPPFckGPQvaWtwrr0buj/wzPS3h80nSgygbTfO01VjVUYBv
 E08wf3n+zVj9Y+Ap+AbgcNiUgbgpz8rZa88/Y/cg5+Qnbc/BhIsg1VL73g9T0zW+nNAnyaVtFyP
 kg6h1RMANZL4SqDgNs/myDbbo2T9VF91oyxeI8kqMVVuap8wMhhiX4EJMTvhjHRUKU3Kv7MiEp3
 3dwGXo7hpxYapW1ZRyG1EARiL0LdmW+e2wPE97Z8dlxrDazfbbH8IzGhcVEGW+/5C/oHFWABUlC
 v8Tw5VyekBgCF1F9KK8/L7SeNIk//Dr1S7LK9cgfjyTdhyEK+XrjRcpgcqS5hKqUUR7IQ4tS204
 Yms3FmnY2bLyRIOwEzz3MnQvX0YnKQNkYCb22wKDq1g1hLwnVwIpJZFUKgduTrq/5hBH7RyheuK
 xkNmpdmITQZ4KleNw8//hRARzmFIzq7gVVCg==
X-Google-Smtp-Source: AGHT+IGrQWUotmX/A+dwP7WrLwFSvSPuZA+RUiVxOJc6s8f3BXtVoAvCw/Z1RjoVDvyINxQPoctuRA==
X-Received: by 2002:a17:90b:4f4e:b0:335:2d25:7a7a with SMTP id
 98e67ed59e1d1-3404ac7e680mr9017950a91.10.1761933552736; 
 Fri, 31 Oct 2025 10:59:12 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b93bf265180sm2754826a12.33.2025.10.31.10.59.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 10:59:12 -0700 (PDT)
Date: Fri, 31 Oct 2025 10:59:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v1 1/1] net/nbl: use hardware MAC address instead of
 random one
Message-ID: <20251031105909.329bd359@phoenix>
In-Reply-To: <20251031014417.3424934-2-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20251031014417.3424934-1-dimon.zhao@nebula-matrix.com>
 <20251031014417.3424934-2-dimon.zhao@nebula-matrix.com>
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

On Thu, 30 Oct 2025 18:44:16 -0700
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:
> diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
> index 8a4a776b22..adfaec22f8 100644
> --- a/drivers/net/nbl/nbl_dev/nbl_dev.c
> +++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
> @@ -886,6 +886,7 @@ static int nbl_dev_setup_net_dev(struct nbl_dev_mgt *dev_mgt,
>  
>  	common->vsi_id = net_dev->vsi_id;
>  	common->eth_id = net_dev->eth_id;
> +	memcpy(common->mac, register_result.mac, RTE_ETHER_ADDR_LEN);
You might be able to use rte_ether_addr_copy here?

[...]
>  static int nbl_disp_get_mac_addr_req(void *priv __rte_unused, u8 *mac)

Take off the __rte_unused since parameter is used now.

>  {
> -	rte_eth_random_addr(mac);
> +	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
> +	struct nbl_common_info *common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
> +	u8 zero_mac[RTE_ETHER_ADDR_LEN] = {0, 0, 0, 0, 0, 0};
> +	int ret = -1;
> +
> +	if (common->nl_socket_route >= 0 && common->ifindex >= 0)
> +		ret = nbl_userdev_get_mac_addr(common, mac);
> +
> +	if (ret) {
> +		if (!memcmp(common->mac, zero_mac, RTE_ETHER_ADDR_LEN))

Why not use rte_is_zero_ether_addr?
