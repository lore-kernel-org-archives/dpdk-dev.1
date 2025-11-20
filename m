Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB560CF64BC
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Nov 2025 05:50:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC472402D7;
	Thu, 20 Nov 2025 06:50:45 +0100 (CET)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTP id 26DCC40267
 for <dev@dpdk.org>; Thu, 20 Nov 2025 06:50:44 +0100 (CET)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-bc1f6dfeb3dso276314a12.1
 for <dev@dpdk.org>; Wed, 19 Nov 2025 21:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763617843;
 x=1764222643; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oInT/OB36+I98sHzX+gR/6d70jrYKhQsaV0EO9kyblc=;
 b=UNSc3PytTZeuPngJnyNmT864CXAS/6DVFdRtgJ3JFUXQVzqUSxpqcOGec6vN8vd08x
 Vw7m2bFDZgbhVe2hNWkDE+OC5xO07vI1M7qYmG2bOsIi6gEdVc7uS+8p70Ao7BXlFh0O
 3y2x5nCmpBCE/87G9ZzPQsl15lNDq0Xn/M9jFoJeTNfSgKV4YaBY495MBvn6xDrapchK
 /LhmlEwfP7+0FrqptFKZKSK5Fza9vxrc3L5oQIkwv60uNBN8kXxNFC1MazCebpCYQvTT
 4bFQpXiwvxadCa++n7F9CNRJbuEHgiT7aBuQGsADGsXqG+KGFl30HY43QbceuPBHopsz
 3tsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763617843; x=1764222643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oInT/OB36+I98sHzX+gR/6d70jrYKhQsaV0EO9kyblc=;
 b=UQWCTg/I0oqpKK/SIu5Q9A2ndaoZrgAaW95gaFjoWQ1AgKCw0PzdWFhH4TYMAujHZp
 PNRhaeWNNEczQWKKD0xCZcSo5N0CpphggFP6VjRSA7U/OcFs4mHiClmaxr6K+HKMwW5Y
 IpXwk1sLVFto3rjdtU7JapeAHo2hgu01golM2tb732rPo3IZ7AkO/hvyisdOP4ZkAt29
 skTJCmVmbXkdCBYezm0tvX7lWycdorS1GO2esoJfMO3LJ0odYd/MPxY+RYYagvEE5Z8y
 9TveEEMKFdeRJ84knUtmKaRjg5b7TtEMU6YlV6f4oQFL5uIao8OSYDj3llJBIxn5IM3T
 w7yQ==
X-Gm-Message-State: AOJu0YyzY1cx1u9yuVtEQGf5A8IwG6OMCVzLuaLn/u6BQ7ORg77L+kAS
 hJkLW7Q6f3kAOMEz8BUzqWFuxVPFHlibK0kC2VrFqDpKYRu9b7sMiSyQrDYbfjBzrg8=
X-Gm-Gg: ASbGncv1dsbZ7DTp8M9h2qQkG+OiK648gpAaXuvUj811DIveYW0CZzkITctQxw9iuq3
 ri2gdPfAmGCeOTq/sXTjFArlF6qs0MHI2Pj/I2RWNR9VYF+L44QO7Rx6DjS8ohGj6+jtUBzlOHW
 XC0L9o6nOKWx+peqzwUXg6SUYv+FMCuF8ZHuEkBIt3V0pZe7Fx/FQeIFvIZUYGjQH2O4RLkwdiB
 eZ3iWiiccNzrdPC600nuqnbNPOhBvsNnHRyCpkG/gdkS5XLQvoXDzWGFnEgYq9w9X0rICpya3cR
 M+H8Ep4BVyYCUAWzSDnITrjzNMasN+KaRmB9MTe8h7n1yTztOxrZte+s8AoCNLuEAxePYcqitGL
 tINbWZMhXJFQkmJi5tLH68rD4GKj1WUn7dVt9M2F66k4mOfeUBpzOOfZifzVf3G+QdhBObj8+fc
 n4sN+VEKjp+dajnjJnMr6QYCTKFi78laTHC5WbcXMxoWR3C/ZLAT7l
X-Google-Smtp-Source: AGHT+IGNV8RAAJi2xYvcpMGm1TKcVEfSvnqusKyiIwgiMh/Xl5NyfUFMYz6fpg2JcLku4fuCpg4F0Q==
X-Received: by 2002:a05:7022:4428:b0:11b:c0db:a5ea with SMTP id
 a92af1059eb24-11c9388fe48mr709512c88.26.1763617843001; 
 Wed, 19 Nov 2025 21:50:43 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11c93e55af3sm5930248c88.7.2025.11.19.21.50.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 21:50:42 -0800 (PST)
Date: Wed, 19 Nov 2025 21:50:40 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Jiawen Wu <jiawenwu@trustnetic.com>, Xingui Yang
 <yangxingui@huawei.com>, Chengwen Feng <fengchengwen@huawei.com>, Zaiyu
 Wang <zaiyuwang@trustnetic.com>, Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>, Cristian Dumitrescu
 <cristian.dumitrescu@intel.com>, Jian Wang <jianwang@trustnetic.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Morten =?UTF-8?B?QnI=?=
 =?UTF-8?B?w7hydXA=?= <mb@smartsharesystems.com>, Sunil Kumar Kori
 <skori@marvell.com>
Subject: Re: [PATCH] drivers/net: fix Tx packet prepare
Message-ID: <20251119215040.47ab3a96@phoenix.local>
In-Reply-To: <20251119130333.2697937-1-thomas@monjalon.net>
References: <20251119130333.2697937-1-thomas@monjalon.net>
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

On Wed, 19 Nov 2025 14:03:33 +0100
Thomas Monjalon <thomas@monjalon.net> wrote:

> After removing callback checks from ethdev fast path,
> some drivers crashed because tx_pkt_prepare was set to NULL.
> 
> Some drivers (hns3, ngbe, txgbe) need to use rte_eth_tx_pkt_prepare_dummy
> when configuring queues.
> Other drivers (ntnic, softnic) does not need to set tx_pkt_prepare
> as it was set by eth_dev_set_dummy_fops() called by rte_eth_dev_allocate().
> 
> Bugzilla ID: 1834
> Fixes: 066f3d9cc21c ("ethdev: remove callback checks from fast path")
> 
> Reported-by: Jiawen Wu <jiawenwu@trustnetic.com>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Queued to next-net

