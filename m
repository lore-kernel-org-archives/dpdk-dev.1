Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0A4CD98F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 21:12:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88E3040268;
	Wed, 17 Jun 2026 23:12:46 +0200 (CEST)
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com
 [74.125.224.51]) by mails.dpdk.org (Postfix) with ESMTP id AC1A84014F
 for <dev@dpdk.org>; Wed, 17 Jun 2026 23:12:45 +0200 (CEST)
Received: by mail-yx1-f51.google.com with SMTP id
 956f58d0204a3-662e7fed068so64084d50.0
 for <dev@dpdk.org>; Wed, 17 Jun 2026 14:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781730765;
 x=1782335565; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dUXRwERXa37ck/AAJDX11WtyD/mhcCOipi6+xmgIdQA=;
 b=a6sXz+u7ODdDnzjN8MgP/rw3Qbc0mjAYndDzaR8WngAEBhY+YHle0hQDVu0SM0e3To
 NFDsrUtpSM7LH5sYGPZSOkW4OQVL0tI46NA6qzT4ZPkgd57MNdJDZvzewQisWCuxKHfg
 1M5EsU5CBvsFpZSoKkHZAiK4cdFAKb/waZhULRxFU0vevlqC+QPw7mrXH5S/KdZ+zB9B
 D/oq32QU/vV+QHpsgCx6gioxPHborSwHLN+3HONoe+LaiG8ic/+AGjee/aAZuCg7jzpf
 q5+Dp9J4dGqnjqJnBzvlbHlQfULms+QmLTTq6a48GqRzzU0Y79BrFaglHGnYu5DYRhWa
 SIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781730765; x=1782335565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dUXRwERXa37ck/AAJDX11WtyD/mhcCOipi6+xmgIdQA=;
 b=C0w8IlpMvTrAvr5LNxPV2uiLoEjdqF+Lg4grkuArefmu5/rALLsjBLRibTQ6206W34
 ngK34DNQ2EQ65DlKAZ7CaehCA6x75ZGzRsO5brKWcyiBcJVba4LTsGLz5qqyhY2dJ/4P
 czKMe87KVidiGPNW6O59vnkefFz8dClgv3Z/yhFDmHfNyP3TlPEaSq25g95pwJzKOsFP
 VkL8q39vTMW4O86yCKWQYPeK/dz1sLQZAwdGMs2ldf4HqXNy6R5PNn1a6WE2QQpHPObr
 8WqXaM105zMG7Xk9a7Uw90+3PRBLh5DKQZIwj4PS3A58OABv5HGflPkKaEgYKsBCGY47
 T1+Q==
X-Gm-Message-State: AOJu0Yy4/7D2GSWGkZbHqYFjlgcBfLFOH+QfjWQQQj+ivP0/q4YGeQ6D
 e19ZjIyYXpBLt7iqPbj4y+z6/t1qCJYNzzg01Grj3MJT2IAC3cgRJSD9hlTSt0WzQ64=
X-Gm-Gg: AfdE7cmQTi+4oIeg1DIOZJZqcB2YEpy4YY0ANSkQegYgxuzsQ2j5bZ/RC+0SyD55BC2
 R4OPG4eHm1V+W1n5TlX4VEfKgTxN2LZLaqbtQ/4GTm9DVSpvV38gZdqRg1WZp/5fxrCfTdoUFV6
 LhuL4TE4QUufVI6WuwqduRIM6OcFO3Gbni8dPdjSHw8pMJBSlG68zZPvHmQwfVVQMINWJEaP6UW
 VSDYiFlSmOp4bSMUr4TqJaTINx0tQfzDO/7oKCAd9qAj76IWR2KodVu6q/auDEPM3qvh2qnE3Rh
 wkKMf36jmZyYjwMp1hK35tLyoFaGXnEIv7AOQxJCLYeLXWinvVMHPBb8SCfX4Cr2BonsCZ01n9Q
 CUoRfEtkuq0tBMD8M5o6OfmLCzaBYDy2s2lPdVyhsSTIsHxLUPTxY5t4HOq0cGn7ZIAsszptM6c
 5zUMD/bML3c8B/wsb7IPF6+zHu8/13SLoqgpaSLYVp4ge1BWxHGOWYBMACEL1Sd+Z1
X-Received: by 2002:a05:690e:d57:b0:660:55a3:9b30 with SMTP id
 956f58d0204a3-662cbd3ff62mr5028007d50.56.1781730764923; 
 Wed, 17 Jun 2026 14:12:44 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-662b976e47csm5212973d50.20.2026.06.17.14.12.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 14:12:44 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:12:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maxime Leroy <maxime@leroys.fr>
Cc: dev@dpdk.org, stable@dpdk.org, Aman Singh <aman.deep.singh@intel.com>,
 Heqing Zhu <heqing.zhu@intel.com>, Jijiang Liu <jijiang.liu@intel.com>,
 Helin Zhang <helin.zhang@intel.com>, Cunming Liang
 <cunming.liang@intel.com>, Jing Chen <jing.d.chen@intel.com>
Subject: Re: [PATCH] app/testpmd: include IP fields in UDP RSS option
Message-ID: <20260617141241.39e58d77@phoenix.local>
In-Reply-To: <20260616093912.685791-1-maxime@leroys.fr>
References: <20260616093912.685791-1-maxime@leroys.fr>
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

On Tue, 16 Jun 2026 11:39:12 +0200
Maxime Leroy <maxime@leroys.fr> wrote:

> The --rss-udp option is documented as enabling IPv4/IPv6 + UDP RSS, but it
> currently sets the RSS hash functions to RTE_ETH_RSS_UDP only.
> 
> On PMDs that translate this directly to L4 port extracts, this can build a
> L4-only RSS key. Add RTE_ETH_RSS_IP when --rss-udp is selected so the
> configured key matches the documented IPv4/IPv6 + UDP behavior.
> 
> Make --rss-ip additive as well, so combining --rss-ip and --rss-udp is
> order-independent.
> 
> Fixes: 8a387fa85f02 ("ethdev: more RSS flags")
> Cc: stable@dpdk.org
> Signed-off-by: Maxime Leroy <maxime@leroys.fr>
> ---

Applied to next-net
