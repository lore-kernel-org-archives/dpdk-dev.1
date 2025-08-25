Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F360CCA0EFA
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 14:52:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FFF54021E;
	Mon, 25 Aug 2025 16:52:15 +0200 (CEST)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id 3A12140156;
 Mon, 25 Aug 2025 16:52:13 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id E9FD57A014A;
 Mon, 25 Aug 2025 10:52:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 25 Aug 2025 10:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1756133531;
 x=1756219931; bh=IR7BH7E0wWbUxcHieSgaP6tlR1tv+W/MENKPvgE8hWE=; b=
 cWWLe5yAyOdYCBSA5tfDaWr8wnr4mLed7uZbKhYlwXqOZJoQk7QP2y2SIv2u37Dc
 PYKQLv2HV3Bp93KitfO2iYD6drG0ZwZS4ESgAjMhxJK3jWsNtOewaP675WBSHSpC
 Pge5YDlHEZdbHrViUlKw4wGbjeR99yBgd/xteS1JWamYk2+myFyTcjt/eB2EBzQI
 lEfTYZ1/M6X1Ivfd5Ip8keivO7efyb1/HUDszM7hUWxApoGVYDWUG+SUfWGUas0a
 dUbx6IOqkKexw/5WimCl7se0SSAKMm+apWj/1CxFvKskpMVYbTYgNUaCs95tp5ou
 wHLWSDmUxPQ8eMWN6bQrlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756133531; x=
 1756219931; bh=IR7BH7E0wWbUxcHieSgaP6tlR1tv+W/MENKPvgE8hWE=; b=Q
 cP0YOaZQB/SIXSx6CFa8ku7nxSCtkg/SHdObv9OBJj3N/ZPDB2yv3cqoGRgX5ps/
 7ZXrCRDBd5/gkwWuSkfz6xR6bV7W2zLE2ojuuqx5BW/UgtvDvrusuZgJP1DRXnHC
 jcFKb7oqPIkkU+iHMvHdlRSYlzRKCA7OvRclyuO/L6UGE+CXsWt4G92blJztkP22
 7N+W59aOBfjwYbQJcECiDLr6IKk5TYSTjsbwLZtx231U7iFsTLzwKGbVlQXv1By7
 mnoP8cIHQKyik4/WwekWiBa6OrKJwcG9x8izdcuRzzOYJDQKgR/4cvvv3ktwQ8Oa
 9vcAZX3gH3d3yRJiFk28Q==
X-ME-Sender: <xms:m3isaHOYrofuBPWk5d9dVM-nqbJtNQQayTFiZgHqEuDhI2l7jLBQmw>
 <xme:m3isaBJWHbZchtdVUYzyk4Pg5ppgFq1DUbeOLX2cSHAB5kYYIESbxFN1PAmk3JozM
 l-FK-7EWY-_SKQ26g>
X-ME-Received: <xmr:m3isaI88m5cDhrgwdN2U1zyrnv-0KGagZDd38MH1xfphXYOCWJ3scqOHF9x7rA_iZYAoglzJumS-GaC-pXeeLdWdQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedvieejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeduvddp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrvhhinhhlsehnvhhiughirgdrtg
 homhdprhgtphhtthhopehmrghtrghnsehnvhhiughirgdrtghomhdprhgtphhtthhopehv
 ihgrtghhvghslhgrvhhosehnvhhiughirgdrtghomhdprhgtphhtthhopehorhhikhgrse
 hnvhhiughirgdrtghomhdprhgtphhtthhopegushhoshhnohifshhkihesnhhvihguihgr
 rdgtohhmpdhrtghpthhtohepsghinhhgiiesnhhvihguihgrrdgtohhmpdhrtghpthhtoh
 epshhurghnmhhinhhgmhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepshhtrggslhgv
 seguphgukhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:m3isaFF8pqNLYAikDduKYOvpSfVWhTrPTh3_xI95COT9U9u2TDQehw>
 <xmx:m3isaL7x7UzU4rwDA5uG7yGzNE_ybHFbq4cU_qQ-U8dwbi46owMBLg>
 <xmx:m3isaGY4M27B1UAWwNPZdbqlWsO6Re3NLrUb6Agyipyw294-uDmqEw>
 <xmx:m3isaBh5gY3kKxiPsjes99wjuD917BP3d7C-0iblMFvF4ARA0w0L2g>
 <xmx:m3isaIUU-FnCfZHBN6JZh5DNuCKZCPkpj39oIDB_ho08kOZLtabZFdIT>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 10:52:09 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: "Minggang Li (Gavin)" <gavinl@nvidia.com>, Gavin Li <gavinl@nvidia.com>
Cc: matan@nvidia.com, viacheslavo@nvidia.com, orika@nvidia.com,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, stable@dpdk.org, dev@dpdk.org,
 rasland@nvidia.com, stable@dpdk.org
Subject: Re: [PATCH V3 2/2] net/mlx5: add support for flows targeting
 multicast MAC addresses
Date: Mon, 25 Aug 2025 16:52:07 +0200
Message-ID: <3029429.o0KrE1Onz3@thomas>
In-Reply-To: <20250825141322.974335-3-gavinl@nvidia.com>
References: <20250825141322.974335-1-gavinl@nvidia.com>
 <20250825141322.974335-3-gavinl@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

25/08/2025 16:13, Gavin Li:
> Rules for multicast MAC addresses are intended to filter multicast traffic
> and are managed through multicast MAC add/remove APIs.

You should name the functions to be explicit.
Also it is not only managed via DPDK API,
as you say below we also retrieve kernel addresses.

> In mlx5_dev_spawn
> function, devices (PF, VFs, and SFs) retrieve the netdev-configured MAC
> addresses via netlink and store them in the PMD device data, which
> includes multicast MAC addresses.
> 
> Previously, flows for multicast MAC addresses were incorrectly disabled,
> causing the multicast MAC add API to stop working.

To be clear, it was blocking addresses added in DPDK,
not ones created in kernel, right?

> As a result, multicast
> traffic directed to those multicast MAC addresses was not received.
> 
> To resolve this and update the multicast MAC address rules, create them
> within mlx5_traffic_enable.

Actually you allow default rules for multicast addresses to be created.

> -		if (!memcmp(mac, &cmp, sizeof(*mac)) || rte_is_multicast_ether_addr(mac))
> +		/* Add flows for unicast and multicast mac addresses added by API. */
> +		if (!memcmp(mac, &cmp, sizeof(*mac)) ||
> +		    !BITFIELD_ISSET(priv->mac_own, i) ||
> +		    (dev->data->all_multicast && rte_is_multicast_ether_addr(mac)))
>  			continue;

PS: you forgot to use --in-reply-to to keep all versions in the same mail thread.


