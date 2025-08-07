Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F565C87FCF
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 03:15:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28FFD4026A;
	Thu,  7 Aug 2025 05:15:53 +0200 (CEST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id 67B4640264
 for <dev@dpdk.org>; Thu,  7 Aug 2025 05:15:51 +0200 (CEST)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-458bc3ce3beso3400185e9.1
 for <dev@dpdk.org>; Wed, 06 Aug 2025 20:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754536551;
 x=1755141351; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=czgYmvYtYtt0sFbpfUjEgVgUURyHLZBfXNJLeePUDNI=;
 b=F9+vEYjDTUVVmoELVOLImMgcXxpsEgmzy+H5FOe5DxLwjOnGaleRKVsbg/AO9mNjDl
 /AjYRIp/knk37pCFoiaKO27cA1t8eJCtIn/E9HFtNEn2OcvrlVGkzlid0Fhx+QWJu9gH
 4IIqjv5S97huqfC35rnHm7K2FFFIKQVDJ4tHBr72lzVEdlS6ljCQOem+AbhnmoXWJlSk
 +J8aR9MmrpSfV1WQfO9JFzrlA1gm89Rgrp+WZ5SoYMQOX4oKrLvBgnQ/KtAdSqv2mRm9
 apEjor3ShYDOyhX98Zc1ZdneKDj/fqk4g9MyKn/OTzYzT3/BH52hKwcFs51E1rsSfLNR
 xFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754536551; x=1755141351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=czgYmvYtYtt0sFbpfUjEgVgUURyHLZBfXNJLeePUDNI=;
 b=aenF9BXy3OGIZ/Z8eqrWRzgbXKUqFOSniTCF8u6tYXzz+T0stq6BdL9r3/dVDFSuUg
 3do64BpfSUDCKhWZPKh7xZIRM4bzloKI9U1Oj0Cu8i89rFSjY4EAKiFGs3mASLOHN8EZ
 MzC9hKLHY95NqLRf072sWxWgVAwPBNYFQWCW7q2McYbCXiBXg8hGECV6fCXIVYnibBFo
 UZfGY5sAQvVsavyqWl2HwkBZTNQjSsS7ViF1IOiGJPtmJoNXQPFuhG2ORQ0fUjlTwQGL
 VJU8QkSMpW/IisrSXaNc9c7rHKtKdV3FMcTnosMmNhb+ghq0/B0PouzVexubM+aN/209
 g2KQ==
X-Gm-Message-State: AOJu0YzRjJZ5rj64d/3g1VA0rEk49WSd5fr4V5m9GwzgZUzY6NrzpGhQ
 UkWT1wgT1PbTUfz+fl2m8nj5kdiTi7orFeVaoSWux/MGdpjYbrldkxgu2qVGDM83Kxc=
X-Gm-Gg: ASbGncsDX8l7jvdoanyrv3o59cmgj5sCPSNEkiLOtWsHOhgxFRn6Nh0IxyTXWvXFxK+
 E9RGiQBwa5ZKbdcM6OOoJ6jWOLZf2P1EGf3vTh7QeHICFrA6NzBu6lmqnaC9gN9155CZVLFkydZ
 WCSdofjYcjW+AXVkfWn5Ry4mhKAGbTyNeircraxjf7fmyIHE0b/CYlLWKNH6DnWsTcmmFRBmpaR
 JIz8/zime7RqBW76ehag4LqBF/CtWREET33OdG+OOEL/iozuFKNVUrjLTgMPYjyq+NJhfHIJj0N
 JMGUQe1aiNMTZj1Rbp4aq0IbJQdMdUXShI3dH02c2QyLM82Eph7+uavA9eWPnM7FWpfAThRgcuJ
 AwgnNJOdyy2YB+NVjDPZqeGlddLTjcijc/+pbHzSksgoTfwydptYi/2M+qUX2FTStZA0czSS974
 pDiLksaTaI7A==
X-Google-Smtp-Source: AGHT+IFruv2Ao01R3wysGFv/8q74u1wWknJ1rt8/N7tLeJuEyvtdUTwD12zEsr5glfvAq+08unPngQ==
X-Received: by 2002:a05:600c:4f4e:b0:458:a7fa:211d with SMTP id
 5b1f17b1804b1-459e74b4fb1mr39149495e9.29.1754536550650; 
 Wed, 06 Aug 2025 20:15:50 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5e99e04sm68786475e9.11.2025.08.06.20.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 20:15:50 -0700 (PDT)
Date: Wed, 6 Aug 2025 20:15:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dengdui Huang <huangdengdui@huawei.com>
Cc: <dev@dpdk.org>, <mb@smartsharesystems.com>, <david.marchand@redhat.com>,
 <roretzla@linux.microsoft.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: Re: [PATCH v5] eal: fix uncheck lcore role
Message-ID: <20250806201545.514def16@hermes.local>
In-Reply-To: <20250807024936.2039379-1-huangdengdui@huawei.com>
References: <20250724112551.2502389-1-huangdengdui@huawei.com>
 <20250807024936.2039379-1-huangdengdui@huawei.com>
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

On Thu, 7 Aug 2025 10:49:36 +0800
Dengdui Huang <huangdengdui@huawei.com> wrote:

> diff --git a/lib/eal/common/eal_common_launch.c b/lib/eal/common/eal_common_launch.c
> index a7deac6ecd..be7226e4b6 100644
> --- a/lib/eal/common/eal_common_launch.c
> +++ b/lib/eal/common/eal_common_launch.c
> @@ -36,8 +36,15 @@ RTE_EXPORT_SYMBOL(rte_eal_remote_launch)
>  int
>  rte_eal_remote_launch(lcore_function_t *f, void *arg, unsigned int worker_id)
>  {
> +	enum rte_lcore_role_t role;
>  	int rc = -EBUSY;
>  
> +	role = lcore_config[worker_id].core_role;
> +	if (role != ROLE_RTE && role != ROLE_SERVICE) {
> +		rc = -EINVAL;
> +		goto finish;
> +	}

worker_id could be any value, if it was out of the range of the array
you would end up reading junk.
