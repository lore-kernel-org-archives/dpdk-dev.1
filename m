Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADB7C77B7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 16:23:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B3C340267;
	Thu,  3 Jul 2025 18:23:53 +0200 (CEST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42]) by mails.dpdk.org (Postfix) with ESMTP id 1719140264
 for <dev@dpdk.org>; Thu,  3 Jul 2025 18:23:52 +0200 (CEST)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-6ff16e97d1eso16717616d6.1
 for <dev@dpdk.org>; Thu, 03 Jul 2025 09:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751559831;
 x=1752164631; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HnNJY/1PEh5Ximz+RWZqfRkVO30VzYxPUnaUQYsNdLU=;
 b=Kq1B3EhELqnXMogdfYQA0+/UkAnYGwlMP2rTnVbape2YprQ88XKz64k3v7UZpYGRjK
 /5THiqqJrsBMFawK/N5SjCdT4vVRNS9Ga3ygloATeXd0Mwzj+uoyb1UmwuSVCZRaZwLP
 JvPEL/TZDt8ksXFnf24oSl24MztPl8VZDX7IK6Skown6phCbzbwbJ5OwQfPR4dbZFy8r
 XpYTACe820ooVTU8VShVCDg7zOddbqRxMgU046fgNphRNJ18sjgW2h9HIQvLfHLaVWHO
 cuh6waYgM0FPHdy3rKDQKWkB9JgH5HqjvY1n1FG3NIHPMb8Wy1eouW66XH1ODYF5izpB
 LM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751559831; x=1752164631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HnNJY/1PEh5Ximz+RWZqfRkVO30VzYxPUnaUQYsNdLU=;
 b=SYBvPWIKwiGooSBiPMh7zMHe0r0huoU9xil4aYqHeRporpOqoIc3cuRtjztJtkvED/
 GWcPIsGnlbsm4xKnLjzRWBukNkbpLjPmpS9nYQbLKTuBe85a3wniVBOG15wBia0E29Wn
 wAp7EkHUlQbmuzmE904xQyXc67LgClLXqO3sEfdPy1uAfht9/jZxBKB7GhlMb1NNrWp4
 yqlSK0L+2WVaeyZEkjr2w0OO8aE+orzHX7y+SveIMQ4SqVIu0QV06IZLiTIqAeCT4Y5t
 isUDjXGjB188ud5/TTmZSY9kzgXj9FnLugLnbSBs5x9sRKHTe+IWLAdPWBD5bSYNBh0z
 e5qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJJNXZW6eiQtXDmdgTfRxuT1f3ZJoXLZOpGC+upU3QbIGfGE8c2kSMetZN5VlSP1vudFw=@dpdk.org
X-Gm-Message-State: AOJu0YzzUM7I2LcD4Sxv63sbZmczLG5a33AiSY7dT2tA58KKwjE2Ogaj
 rf2sRa06wqo5iXvBdQHkU2hJW5MaxZ6y42FuHawjHFn3pzWC+Dq1DsKZSom8X/TXqUfhuyoCv4R
 egOTY
X-Gm-Gg: ASbGncuhywuqaomDMx3EXC2aeBI7xjHslNk5XwO27wsa3wCPs8PLaFsTKQKsROVnjqY
 cQu6Fl8LTNvjQL7zYNgrik6Q2lYk57ffQru5k7BovAg+isuksBaH3hRkFbV+DfGG6u7OAGT4C+N
 XXNAvoq1Q3o2cDYy7oZh0cUz559TjJVJEbsk3UySrLn7hBLPZGJEaekWYLDz4ad/P7DRB3QIkeW
 3NllqZN598F1aDSib29qWekvKNL7kQbs8/9PXkRKRwS4TUspJ5iYa0nHt290BdaFry6ZXeOO65U
 p7+dFMHCKQcnB5JtXjwRmAbom20qX56wvEM22GFb+oChEe769tgYlQtKUbhkeTrKK8CDQ7wyZW5
 AhmAHzl64/JPl2yoMch2WxouXgZFMs94nmY3D+tU=
X-Google-Smtp-Source: AGHT+IGuFxbnUwLq8ryoMIuWhrb0s5b4oltX58qR0uN1+CZNAGrgMj544iIRzQAqMclMHguIbK+/0Q==
X-Received: by 2002:a05:6214:519b:b0:6fa:9ca1:c520 with SMTP id
 6a1803df08f44-702bf5eb468mr39618716d6.16.1751559831317; 
 Thu, 03 Jul 2025 09:23:51 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd7718d8e7sm119729326d6.11.2025.07.03.09.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 09:23:51 -0700 (PDT)
Date: Thu, 3 Jul 2025 09:23:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: madhuker.mythri@oracle.com
Cc: chas3@att.com, dev@dpdk.org
Subject: Re: [PATCH] net/bonding: avoid RSS reta update in flow-isolation mode
Message-ID: <20250703092348.4d52dc3b@hermes.local>
In-Reply-To: <20250703115903.7157-1-madhuker.mythri@oracle.com>
References: <20250703115903.7157-1-madhuker.mythri@oracle.com>
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

On Thu,  3 Jul 2025 17:29:03 +0530
madhuker.mythri@oracle.com wrote:

> From: Madhuker Mythri <madhuker.mythri@oracle.com>
> 
> In bonding PMD, member_start() function checks whether RSS(mq_mode) is
> enabled and then calling the RSS rte_eth_dev_rss_reta_update() API, which
> is returning error in-case of device configured in flow isolation-mode.
> When the device configured with flow isolation mode RSS reta update is not
> required and the API was not supported. For example in-case of mlx5 PMD,
> RSS reta update API was not supported, when the device is configured in
> flow isolation-mode.
> 
> So, added check to verify if the device is configured in flow-isolation
> mode, then do not call the rte_eth_dev_rss_reta_update() API.
> 
> Signed-off-by: Madhuker Mythri <madhuker.mythri@oracle.com>

Should have fixes tag

> ---
>  drivers/net/bonding/rte_eth_bond_pmd.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
> index 83339bae3d..b8fecb85d2 100644
> --- a/drivers/net/bonding/rte_eth_bond_pmd.c
> +++ b/drivers/net/bonding/rte_eth_bond_pmd.c
> @@ -1904,12 +1904,11 @@ member_start(struct rte_eth_dev *bonding_eth_dev,
>  		}
>  	}
>  
> -	/* If RSS is enabled for bonding, synchronize RETA */
> -	if (bonding_eth_dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS) {
> +	/* If flow-isolation is not enabled, then check whether RSS is enabled for
> +	 * bonding, synchronize RETA */

Comment needs to be split to satisfy the style guidelines.

> +	if (internals->flow_isolated_valid == 0 &&
> +		(bonding_eth_dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS)) {
>  		int i;
> -		struct bond_dev_private *internals;
> -
> -		internals = bonding_eth_dev->data->dev_private;

This code looks like it was always redundant. The new definition of internals
duplicates same variable earlier in function. Why is the compiler not flagging this?
Is there some warning that DPDK is disabling?

>  
>  		for (i = 0; i < internals->member_count; i++) {
>  			if (internals->members[i].port_id == member_port_id) {

