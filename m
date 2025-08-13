Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA9BCA0EDC
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 00:35:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12A764025D;
	Wed, 13 Aug 2025 02:35:21 +0200 (CEST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 16D4C400EF
 for <dev@dpdk.org>; Wed, 13 Aug 2025 02:35:19 +0200 (CEST)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-459ddf83023so36876895e9.0
 for <dev@dpdk.org>; Tue, 12 Aug 2025 17:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755045319;
 x=1755650119; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j82+T5QLAnBZyeq39yagydos4Ty6G9UIxKufefZCyKU=;
 b=hnk8YkaxOAf53kBNrZqTXON+pNQSf2h6gy6d7hC9UB3hfspXsVfYeo/5ht7gb0WyhW
 mvSlQj4BRGFZ8/17suIAIZezhAWva7MQJDqy3llYMvtCUqizaHVbGzu8dEjFuRsa3enm
 iMtqf3Kt5bPwk4KGrGvneP2VI8QfRXNLYTOAKwlT9GOKwEYbG0XkQ8/Gql+9y6SXMK/p
 9Ai+ur+rt2pKtF+O+dySx89hLH/jxLUwAAjjH8EbiJxLi3NPc2xssgcQ7RChaseezE85
 nLqSVAp81ZvsScoPo33P+rs3xCdDlradWyeFKcvaQygTx6S6/APRJPmGKd2WL+2SUOUn
 YAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755045319; x=1755650119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j82+T5QLAnBZyeq39yagydos4Ty6G9UIxKufefZCyKU=;
 b=nmaleUR3DvpxQxtAdmgwB5vavF8ArGQh3cjxkI4zx3jKbdW2rjyN4nHaEDa1shwWFK
 B1oZcdCIl6HT5/2D2DI4uD8ouoOHZb5ufxuv3myNWBqGUO1CW6/MVGuGT/QbDZhvHFT2
 H4KZgD1IKdnH7dOIXBgfFFO3JoXeKTshC8RPwbSHEpapTvOw+lTW5SazqDkss1TzOtTz
 x2nsH8lblKYwE9xVRl2ZstRUcW/bQ/KqyxdB7vLHZrn51wMGmGGYwKegSZMMKY3sYaP/
 ncPbSSm90/VP4i9/yjH8MDsDUkctEIKgpkY0qOEUuG25av2VPLLN+G9YIZfOWyJI3OcL
 jMSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjOL39rYy7IsNReK0ks49z8DkgVF+SmcwZiSefZoIpMLxeh3EXBs67+ANxjvUd4RgUezc=@dpdk.org
X-Gm-Message-State: AOJu0Yx5DyDUBcCNHUIKPvk3QjTUeGRMJz2N9mQw9HZ5xObJ7/xt3NUt
 UOrLvHamHop3MrOKlalA9x5hgoJQS0h9R7qm5ZUKP+8RPFf3rrflx+hD1JKFG9ELnSw=
X-Gm-Gg: ASbGnctPJLsscKdafWIly30WerxHD9xtPSlLZYxeKDS5xD3MSVWmcGaezJzVoGrpi5N
 tFyYnSex4gk+5ht8GYQzuIoFXk3b4pENb3hsfqZBLbgJWI1HGzHQUqBi59UwPfUlDPZsQTygyyf
 Oc1n50ifWWOW7PEEMkbq8du9j1Vr/WJu4mUINwFY6oZgtrDGQnlI5KGFySyiJMDrwV+ZO6EyFBJ
 PZu7lnyZCm/DkelZXwr0+Ok/cCjrVCDQIhToh1RoMwPNtODw3cqkQyo8FMGH6k9ozSgzmttQV+i
 Wuqsr2pRWGionAJEEpuXC4VK4RG8cbNae6gkan4Oy39E2CJ0hYJuEZeYNWB1teGZCm2cvcyXXni
 2i02O6UsISzA9ao1aq7np+wU+EPqA1ZJllcWPUsvmv55zPTU56sA6q6fyjBDNWnWJcG/+7gjbUg
 g=
X-Google-Smtp-Source: AGHT+IF6YYr3C7/Tgk7NCaijlL0NTs1k8DfIbch9+JHFPB5KrMionZHEIRj6FiyVzCuV1kjx4kl5Fg==
X-Received: by 2002:a05:600c:3515:b0:456:3b21:ad1e with SMTP id
 5b1f17b1804b1-45a165eb2ddmr8706645e9.17.1755045319412; 
 Tue, 12 Aug 2025 17:35:19 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a16dfdd6esm6757355e9.27.2025.08.12.17.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 17:35:19 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:35:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: longli@linuxonhyperv.com
Cc: Wei Hu <weh@microsoft.com>, dev@dpdk.org, Long Li <longli@microsoft.com>
Subject: Re: [PATCH] net/netvsc: add device argument to configure if NUMA
 information on the device should be ignored
Message-ID: <20250812173514.1faf462b@hermes.local>
In-Reply-To: <1754952487-30601-1-git-send-email-longli@linuxonhyperv.com>
References: <1754952487-30601-1-git-send-email-longli@linuxonhyperv.com>
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

On Mon, 11 Aug 2025 15:48:07 -0700
longli@linuxonhyperv.com wrote:

> From: Long Li <longli@microsoft.com>
> 
> In most cases, netvsc is used with a VF device. The application generally
> runs with better performance when all the device memory is allocated on
> VF's NUMA node, as the VF device carries most of the data packets.
> 
> But sometimes netvsc may run on a different NUMA node than that of the VF.
> This patches adds a device argument "numa" to allow the application to
> configure if netvsc should be NUMA aware. The default behavior for netvsc
> is that it is NUMA aware. Setting "numa=0" tells netvsc not to be NUMA
> aware.
> 
> Signed-off-by: Long Li <longli@microsoft.com>

Using 0 as "not numa" seems odd because NUMA node 0 is a valid node id.
SOCKET_ID_ANY is defined as -1 in rte_memory.h

The VMBus channels are being created before the device is probed.
And those end up being set before the probe is called.

> @@ -126,7 +183,7 @@ eth_dev_vmbus_allocate(struct rte_vmbus_device *dev, size_t private_data_size)
>  		if (private_data_size) {
>  			eth_dev->data->dev_private =
>  				rte_zmalloc_socket(name, private_data_size,
> -						     RTE_CACHE_LINE_SIZE, dev->device.numa_node);
> +						   RTE_CACHE_LINE_SIZE, dev->device.numa_node);
>  			if (!eth_dev->data->dev_private) {
>  				PMD_DRV_LOG(NOTICE, "can not allocate driver data");
>  				rte_eth_dev_release_port(eth_dev);

No need to change indentation here. Yes alignment with paren is nicer but better
to just focus patch on one thing.

Maybe this should be handled in vmbus then it could get all the allocations right?



