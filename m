Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BA1CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 17:11:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D25E24021E;
	Fri, 24 Oct 2025 19:11:16 +0200 (CEST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id 1371E40151
 for <dev@dpdk.org>; Fri, 24 Oct 2025 19:11:14 +0200 (CEST)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-7930132f59aso3029087b3a.0
 for <dev@dpdk.org>; Fri, 24 Oct 2025 10:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761325874;
 x=1761930674; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HxVo9j+4zl2siLMeQ3+m7FTVq42VJvIWNsWvanGi+MY=;
 b=UecIKVNCiUXLMpwa+9YDztxpGNeI17715wg0f4seuYtL/MBsgTTokXwngXDLdTogAM
 3vae/vZzTEMYE/wZdCVxjO04viTnk+dgEIbBkYp8cmRL2rBZEwl0a9ZVfo56Yx8EzShD
 FFhuZSCB5uk7nWRdY0EVBbKwxpy6dIr4+sGQvJJgo3b9hwAU2eT7G3d6nUIbds4Aadp3
 AkrmB7zEfuzJQ6hzavnTwgzv5GRTCP6yO2DaP7IdcYdGKWFp+q4MbdBuHQnpc97zkbrV
 eYj81MmVCV9A8lAPisN9qVDXl9W2nEe31CBS22OoSHixk6ZQKCOi0kZ/FrKOqc+wLLQ8
 At8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761325874; x=1761930674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HxVo9j+4zl2siLMeQ3+m7FTVq42VJvIWNsWvanGi+MY=;
 b=XLaAXibf2R1y/BlFPYd666T7O+3CggZrPr9W5l54VNyKk7NL1OA3/AJNDB48Du8QKK
 lRmbD3TO3blhiK5I2g5IP5/VWwE8OSLDsQxw5dVwaxk6zYWH40SY//vqFC/4OUSrJ4Wo
 3k+8NQAIBZptBFD7psmuZgX8Z63Iiq2VKbMZxkDUrQvE/5oS2uOAdMq0YpPRYy2NYgFE
 od4cU+hQ0IqCLm4iFH6VpxvCyctoRd6WcoIlGScybAzcWJ69inHFAmIwpFxu2tCWoFmk
 fJrJBXijjaQI+gQgV3wz+g5i5m3KTUE9rrUeeloyU637hDY+aZfbVFrsngeE//204YYr
 yeqQ==
X-Gm-Message-State: AOJu0YxtCgYmIAj3aWhCyjjAwSrDcL6oFv6scKJc/xwiYomfd2x9xxTU
 c5sCQST65W6gMZ39UA/WhjJu/pRrJjcPI59CxGcW8clWWnWhRve+L2vNQDmX3NrPjt0=
X-Gm-Gg: ASbGnculeaYH+uQTYdqsdeCWYDcYF8l0/4BCMLbyT8gtGRaU+MCfBaXMM+kfc39yM1D
 hmX8TcF04hVsNSWbkQTMci1rBtxssyp9FCRzKsmdxsUWawtDiCwhlRDk+tdZ2CjcxBWVxsY9/2d
 Ox+spmWWnM/6CnIeK9ss29FDdp44qsnJpqBhCF0WJCZJmGs7l8YkGFRHn7ZsFOKnykTJkS5hADH
 W/g4J5BjWe/uykF0v9ZSbWaU7F03FQ2F+nNa1miw9bcSu52x9YVWQf5Z9yAEkR68lpaqwVaA5Ei
 mJMELZLkigttMUhmJcGf+LXEsnC35qEsD9I5lsgsa/P5NumOUyVSSxhtISTIuRxzHMX0NWA9Y/W
 pnBPW9j7P/BxqtfbPTtSG7KgKWUDx1NHVzkqy/9yu0LfKGsZiM1YmxTMDXwyvAqk8tAiwuaWHIE
 hSdUQROgB3JWGpJQyx8CfaQLJbydLEnBfxFw91XGVDeo7j
X-Google-Smtp-Source: AGHT+IH6XEtOICXdBzsKGrrniPffHtYQKSg8vYNULu8lbubpV7xYarwuq/99aVL8txGx9RcsyZENrw==
X-Received: by 2002:a05:6a00:2d28:b0:79a:8a6d:c082 with SMTP id
 d2e1a72fcca58-7a28682679dmr3942680b3a.23.1761325873956; 
 Fri, 24 Oct 2025 10:11:13 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a27d583970sm4669776b3a.51.2025.10.24.10.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 10:11:13 -0700 (PDT)
Date: Fri, 24 Oct 2025 09:59:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v12 13/13] net/sxe: add virtual function
Message-ID: <20251024095955.3b4f456d@phoenix>
In-Reply-To: <20250728090517.1811244-13-liujie5@linkdatatechnology.com>
References: <20250725104855.73326-13-liujie5@linkdatatechnology.com>
 <20250728090517.1811244-1-liujie5@linkdatatechnology.com>
 <20250728090517.1811244-13-liujie5@linkdatatechnology.com>
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

On Mon, 28 Jul 2025 17:05:17 +0800
liujie5@linkdatatechnology.com wrote:

> @@ -288,6 +293,7 @@ void __sxe_recycle_rxq_info_get(struct rte_eth_dev *dev, u16 queue_id,
>  	q_info->mp = rxq->mb_pool;
>  	q_info->mbuf_ring_size = rxq->ring_depth;
>  	q_info->receive_tail = &rxq->processing_idx;
> +
>  #if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
>  	if (adapter->rx_vec_allowed) {
>  #if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
> @@ -302,6 +308,7 @@ void __sxe_recycle_rxq_info_get(struct rte_eth_dev *dev, u16 queue_id,
>  	q_info->refill_requirement = rxq->batch_alloc_size;
>  	q_info->refill_head = &rxq->batch_alloc_trigger;
>  #endif
> +
>  	return;
>  }
>  

Once again fix it in the earlier patch don't add whitespace in later patch
