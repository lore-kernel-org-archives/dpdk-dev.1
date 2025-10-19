Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76068CCD183
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Oct 2025 10:13:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A554C42D28;
	Sun, 19 Oct 2025 12:13:28 +0200 (CEST)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id 792564013F
 for <dev@dpdk.org>; Sun, 19 Oct 2025 12:13:27 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 819217A00EF;
 Sun, 19 Oct 2025 06:13:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Sun, 19 Oct 2025 06:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760868806;
 x=1760955206; bh=9mPXUxywZSHSnRoCRrizc8uda/qBYudJ4vaCnVycJ50=; b=
 EM8wwlrNH7muKVQ0A+kj3j7JllW8dQ4qEDw0/gEocplBxgF7+urOkhrVaCXELq89
 zUrpk1YrlpNAksBQcdVm7uupTRu1SlegCioOA4wk/6+7UY/0HXrG3a5LnyCvQ9d4
 i5uRQQuIhzIQ8YN8AQEzPypP6rJ2HJ4S+TVm4ACeGC6dbU/6hfTyBCINjsXkoFkl
 rhoqVPySJV499hC6U6dcWhwaMYH51ngG60pBBwLh78iVaLAqpuuxav/jYLJEdW2R
 gvPh7UwI90efW6o/Py+V2gdxkTUmw2OV7F/QX4i6aWBQFodKnAi7h3EQICudvPDK
 NzRn1e+Fwe/n5Ct/rl7yvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760868806; x=
 1760955206; bh=9mPXUxywZSHSnRoCRrizc8uda/qBYudJ4vaCnVycJ50=; b=Q
 FcvKuiTJvvuOf+9pQpomYeWG40WXjeILIxb9md0EHOLAYqhqTFCvGU5mvEPuZIfI
 VTTFxLevo0Js10gXn0JDfEsEaiedznNUeCMuaQHVLXKc1wfESySztpQMtXl/grnf
 cuhfITlRlxnPbo84z0LSsD1HeUHL5VviRbTbYSxDVGOJS35OaG302vxYT8+cd8EQ
 l7wok6gEKVxQUIBbf68n1FnRzhjgFJOTQ/DM7AmVYGwr7dsdPECqtPeE77JorQV/
 BA3WXJl+Pv8yvKfjT9DAlik6DubFH7jmpdRdkieqvUo5eewwYtm6IEdMaBO26sS+
 2Gjg/WiS4iEbrYAcnELpg==
X-ME-Sender: <xms:xrn0aO1fznZHZEFyWEhnlhWi8C7yHXCJLcpfQxFGicNyBXbrimxPig>
 <xme:xrn0aMDkuYOybgb3xKwVUAouLU6wpL57m06MaxWvSY-nxqnI8zxYo8V41QVYDE1dg
 pxSXq9gC1zG_zl6LkHnWlGiaUwu1NwO35BjHDIzJV2pTVDumIiy1OQ>
X-ME-Received: <xmr:xrn0aF5cs4hZPL4-3YYetTv6HW04GMLA_mf9oo_AdTW8UTYkdKwrrKdScVb3nn6RRhQZVwOd081kJZ5uryR_mfQ4xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeegieejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehnkhhishhhohhrsehmrghrvhgvlhhlrd
 gtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepshgrtghh
 ihhnrdhsrgigvghnrgesnhigphdrtghomhdprhgtphhtthhopehhvghmrghnthdrrghgrh
 grfigrlhesnhigphdrtghomhdprhgtphhtthhopehshhhrvgihrghnshhhrdhjrghinhes
 nhigphdrtghomhdprhgtphhtthhopehjvghrihhnjhesmhgrrhhvvghllhdrtghomhdprh
 gtphhtthhopegrshgvkhhhrghrsehmrghrvhgvlhhlrdgtohhm
X-ME-Proxy: <xmx:xrn0aFLM0AIWWqeOXNs6swTxFW0mNTr1So0WA9vX0Q6hR0GUXdrjxA>
 <xmx:xrn0aOuGVC1dM6Z376ByhAQ5JmgnXmcGnx7QQRRz4v7SUR7B8YngFA>
 <xmx:xrn0aEICiPfOpn2cBsN0oJwGO4EeodvPoMn_SsKX46L_2gdakT_XfQ>
 <xmx:xrn0aH8WfS9j5-zAm3HMIkksRPLSwMegkJ3SYjSm_Vwe5uUOYCVljA>
 <xmx:xrn0aKimXcT8pchPHbmwJ6JD0XKGU8sLMkCJWL5-uD9-eCizBojEX3SW>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Oct 2025 06:13:25 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Nawal Kishor <nkishor@marvell.com>
Cc: dev@dpdk.org, Sachin Saxena <sachin.saxena@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Shreyansh Jain <shreyansh.jain@nxp.com>, jerinj@marvell.com,
 asekhar@marvell.com
Subject: Re: [PATCH] rawdev: fix device ID retrieval function prototype
Date: Sun, 19 Oct 2025 12:13:23 +0200
Message-ID: <13678998.iMDcRRXYNz@thomas>
In-Reply-To: <20250924055654.1986682-1-nkishor@marvell.com>
References: <20250924055654.1986682-1-nkishor@marvell.com>
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

24/09/2025 07:56, Nawal Kishor:
> Fixed rte_rawdev_get_dev_id() function prototype and its usage.
> 
> Fixes: c88b3f2558ed ("rawdev: introduce raw device library")
> 
> Signed-off-by: Nawal Kishor <nkishor@marvell.com>
[...]
> -uint16_t
> +int
>  rte_rawdev_get_dev_id(const char *name);

As I said, I think this change is not enough but it is light
and fix something.

Added release notes and applied with a real commit log, thanks.


