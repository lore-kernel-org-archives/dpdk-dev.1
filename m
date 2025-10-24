Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0181CCD193
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 00:36:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15648402D3;
	Fri, 24 Oct 2025 02:36:45 +0200 (CEST)
Received: from mail-oa1-f102.google.com (mail-oa1-f102.google.com
 [209.85.160.102])
 by mails.dpdk.org (Postfix) with ESMTP id B046B40144
 for <dev@dpdk.org>; Fri, 24 Oct 2025 02:36:43 +0200 (CEST)
Received: by mail-oa1-f102.google.com with SMTP id
 586e51a60fabf-3c97709a4fbso497760fac.0
 for <dev@dpdk.org>; Thu, 23 Oct 2025 17:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761266203; x=1761871003;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :dkim-signature:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dcsfWwTwPiFyUMhM2/T6sbqx8QtQjfiTlp2Qtw2i4HQ=;
 b=Ffr6LSH8/he2pFOtYImglZV/90RRtXgbTa+NjCNMyEzjOJDVr6BerfVVY8nQQ88ORZ
 yjm7NrANNOuw1rd6SshBZ03ltMChoNPppBjjwfYFBQfnJfcda4cyAmXRIAO2CyC3QE0h
 2diQmAf12W12oYqRzyvcQa9GYyxJm/6SshHylWBA9n5aNLnYjSouwPMekViYrQjqUW35
 xr495dHfHaD9uJdc0mVTugY1k5NpoZRGJ8DNpSAFPGNJA1Evafw8aDPJ5Aa7EP6zMvdK
 /lZzHA2nA4FAdxbJnaVIUdELkn2lITd+Kks4cvCSW+ctRvC121f1r8Rlwx81OLvZKhZP
 RtRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdqyXNK27QMvlwpYHef4xXpRfON6rbUHrWpGRM/3qeadaTVeXVRzCFgehsxpbYhFhXg0M=@dpdk.org
X-Gm-Message-State: AOJu0YwLWeRhxTFZQlAX7YEQMELl77DzDBxkxDQDgJ2yALKfcLKdVzmZ
 eHXHG0kyQ75xGo2OprjNOsIs0HZ9XfsqLoHWtrjzCn3VpqQ+rvWGbINYZ7MuUec9ZRLiy591eS2
 EEHfPp3fbHS2ith+6LR8CwaXgBxHzin33i/Zo0InD5DFLIH5Bmizev8oS0KGWwPyh+Q6nzHTUvM
 /93dNzj445XLnedyh9HvjHK6HAPM8cNPUz+4BpZ+/Z+5bs5IFt/FXaq6/50NCXVxi/rV5+rpSFK
 js=
X-Gm-Gg: ASbGncvtVLfnEZQUeIO+f5ZalGGGt+zZGWRZQNGDcuG9FHUGeBzjo1imny/3+iNc9t2
 s0sb0nWnywJ504GZ5VS0r/29YQgzI6fRaa2nRrspnnAPKsAfcHtshYZcGcMkSeO7be4Ms5+nQjl
 fhY2sX8haXPRw0tkjVCnbh+57JZovdj6R9O6annRMF9J7boyDIWUtveGjVh6eOFpwQl4tcc2pjU
 Y6sM25gb6P7J763cX2oQ9AW36ybHe7YR7wdAjnUa4n9Q7N3CTCYMcK/xpg+Y/bBTyiFEnXY5ls2
 5lN5ct5dAVQzSsg6e4Y6qU5ivmuVpyp74cHKGARVolEn+2gL+QSr7D4PU7btHR0CbziggcRGoEU
 RHA4iwhB/4c3WahW4cwd1SO1/ePhnJtpkUqMMxUH+7fTk4J2QngdEVUCVA/0sOZv+oH/v5YH9Qa
 KAU7nSjb+gwrZeeVok1pzZx02WuYhzi+IRNlVJ6fs=
X-Google-Smtp-Source: AGHT+IFzhl9ePI3MhQaCkYbTgz8J/xtSRQ6cMGEvFkUx/V85dRBbAhVERar23VRkblxv+eCExjZsC+HQbvTB
X-Received: by 2002:a05:6871:7bc9:b0:3c9:8438:daae with SMTP id
 586e51a60fabf-3c98cf01f0cmr10339835fac.3.1761266202655; 
 Thu, 23 Oct 2025 17:36:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-3cdc4e3e73bsm304791fac.14.2025.10.23.17.36.41
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Oct 2025 17:36:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-88375756116so520582985a.3
 for <dev@dpdk.org>; Thu, 23 Oct 2025 17:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761266200; x=1761871000; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dcsfWwTwPiFyUMhM2/T6sbqx8QtQjfiTlp2Qtw2i4HQ=;
 b=FmR9KPAmDj1kpKPdN40+iLUVe64u5jvlPT4zzzsF7I1qe5Q3kdP2r949KyiNhzwxBZ
 BzfT77IfPVhYx7irmlbIKh/OPQF48UNmkCyPiY+6kVWCMmS/+oaGOHRgnFvLiXaycbMm
 MXEJo9c040aUtCHPo2ikfbjRyhDkvV/4Bhv/E=
X-Forwarded-Encrypted: i=1;
 AJvYcCVJjQGWxkbZTQoyX92fU1LAIWr/bA/qFI0a55S28t8NEv6E3PYPatMYNhT5Cfj6EH12vbw=@dpdk.org
X-Received: by 2002:a05:620a:2807:b0:854:b9a1:b478 with SMTP id
 af79cd13be357-8906e0dad88mr3256809685a.18.1761266200590; 
 Thu, 23 Oct 2025 17:36:40 -0700 (PDT)
X-Received: by 2002:a05:620a:2807:b0:854:b9a1:b478 with SMTP id
 af79cd13be357-8906e0dad88mr3256807985a.18.1761266200177; 
 Thu, 23 Oct 2025 17:36:40 -0700 (PDT)
Received: from [10.211.11.251] ([192.19.50.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89c1169a918sm273676485a.39.2025.10.23.17.36.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 17:36:38 -0700 (PDT)
Message-ID: <8e750656-787c-4dce-8cbe-241e7929d2a0@broadcom.com>
Date: Thu, 23 Oct 2025 17:36:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net/vmxnet3: disable RSS for single queue
 configuration for ESX8.0+ versions
To: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>, dev@dpdk.org
Cc: stable@dpdk.org
References: <20251022155651.9818-1-amiyaranjan.mohakud@gmail.com>
 <20251023083019.18792-1-amiyaranjan.mohakud@gmail.com>
Content-Language: en-US
From: Jochen Behrens <jochen.behrens@broadcom.com>
In-Reply-To: <20251023083019.18792-1-amiyaranjan.mohakud@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

Acked-by: Jochen Behrens <jochen.behrens@broadcom.com>

On 10/23/25 01:30, Amiya Ranjan Mohakud wrote:
> It fixes the issue of v4 RSS configuration failure in
> vmxnet3_v4_rss_configure() while writing to BAR register. It's very
> specific to single queue configuration.
> 
> https://mails.dpdk.org/archives/users/2025-April/008236.html
> 
> Bugzilla ID:1789
> Fixes: 52ec00fd1474e8 ("net/vmxnet3: fix RSS setting on v4")
> Cc: stable@dpdk.org
> 
> v2:
>   - Fixed typo in commit message
> v3:
>   - Checking if RSS is already enabled
> 
> Signed-off-by: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
> ---
>   drivers/net/vmxnet3/vmxnet3_ethdev.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/vmxnet3/vmxnet3_ethdev.c b/drivers/net/vmxnet3/vmxnet3_ethdev.c
> index f4cdb1bb31..a0306af86c 100644
> --- a/drivers/net/vmxnet3/vmxnet3_ethdev.c
> +++ b/drivers/net/vmxnet3/vmxnet3_ethdev.c
> @@ -534,6 +534,13 @@ vmxnet3_dev_configure(struct rte_eth_dev *dev)
>   
>   	PMD_INIT_FUNC_TRACE();
>   
> +	/* Disabling RSS for single queue pair */
> +	if (dev->data->nb_rx_queues == 1 &&
> +	    dev->data->dev_conf.rxmode.mq_mode == RTE_ETH_MQ_RX_RSS) {
> +		dev->data->dev_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_NONE;
> +		PMD_INIT_LOG(ERR, "WARN: Disabling RSS for single Rx queue");
> +	}
> +
>   	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG)
>   		dev->data->dev_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_RSS_HASH;
>   

