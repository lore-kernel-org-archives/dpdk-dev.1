Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A56CD5BD1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 12:16:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D5E14025F;
	Mon,  1 Jun 2026 14:16:21 +0200 (CEST)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id 18FB14025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 14:16:20 +0200 (CEST)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfhigh.stl.internal (Postfix) with ESMTP id BB6E17A02C1;
 Mon,  1 Jun 2026 08:16:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-08.internal (MEProxy); Mon, 01 Jun 2026 08:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780316178;
 x=1780402578; bh=hbJKUWzN6U6zG1KtiPQa4JbBZtA4Fo66RUPC9UIY3ew=; b=
 AHJxMAMJERYp5GeLQZX+n3LEH3GaFZXO/MtNW8CR1i9f81ifq9M634Ah7WkVWw6x
 ftrTSR0v/M3rVtDdg/tZBAuOTtbVmaLEaXOkWfNG2uhsdvK7vJyVlY1zgfQ7C9Hw
 06L4PE92v/iBAk+pLWIks36p1opfEx3p+kUp1oqVsmYyaHy0gJOqIU754HUQRbfv
 +M8QPqpcYTtxyZJ5AVWXbjDkgSqz3tUFM5xZD+/TQfx36NAr1M3hAOiekiK9Mxp1
 MDCeFJ2UEYB1J+m0hDvzfS+OWypmtavT9qoRA1+6iw1m4CxLt0tAHxofHHTQc79j
 DPO5YmTgoHjEj4DPBRldaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780316178; x=
 1780402578; bh=hbJKUWzN6U6zG1KtiPQa4JbBZtA4Fo66RUPC9UIY3ew=; b=K
 B2LIwaWcKoPjiExKV7w3tGVdQbCmAFvosWk/aL+n/TgLT7ssbj0Rdm4NqjSj2Z1h
 kTMSQToa9HvPSsJDeiOzuPPfyPuMGHiOxcU6hzIXjKExq8gMMSm2bcD5dusVWNSq
 kJNxwI7RBj6LUBjeaRxVY66h/VrdEsa1XRs4S/SlVhBy5x8XFTwDmgzyAw68XFaK
 TKmjqzI51izSap3mKUYXNVg+nGi7/XUSBnPmx7Z1SWYwRNjyyIw7ScoOXQwgRUxD
 e0LTj/TEVMC9IGK96Nd8uR3Xvg9qjxyO1Q6djcAKz2QDfJTq0ypi38UYKY+r+DHp
 2qM4hFR2Xt/6aRV13VaTQ==
X-ME-Sender: <xms:Engdaj_ke_wV_rnsvb928IoPbApT_zrxWxgUrHXFl6PzjEq4YR_RMQ>
 <xme:EngdakC0fHmLh9vP5wp42wJtuAQk9Z0wYbLsSbhszJIF6yLK_DCMdV422K80-so68
 Q-qaC4wmw2L3qrjUrduUviX7eh202C2htQGMU5IFq7L1dueXfIi5Q>
X-ME-Received: <xmr:EngdagLynkpgEjlqgdHFyeahZKQ4RQUiZfLmsB0CyFzZNZ2yhtMR2G4plGjMUyZejaQwl9iKM12gd7A00o5hrN9n_w>
X-ME-Proxy-Cause: dmFkZTFMoBfQdlQCQHwwMIFZBvDIzgxCvR4f60JK/SEelt8OeQmLPQti2tdbc6seK67pNw
 a2Q5s2qxRKC1gfJNVccBYo1yVSuk2FzjgJZPQ587jzX1Qh1/2liwzKichqysL4WYO757WM
 geQd4UAnyX6WljbX4B8ger2+QCL1wRvHGcYeZwVzIieDQz6xBfMY99EyvM9hPODNXOuCjg
 LRCwKzFjvy6HaNQWVKU2zZ/FevBietccvNG+jj4poT3lcUdCA0IJmwyG6yGofjzMfBKRg/
 7NXLTJ4nYNzVZJPkHR4XAMXyYXvwnqGq7TgSgpGSgNtbZyPdTyVTw/ovKPphyvSWun2LWo
 AUmV47y5xbryaIqKNVAjUmgkaVYPpAk05ErydfDhkszrNt5GGkYcMhYUbLkLiqV8RhpJN4
 NcjLsNhUi2w56T6cfc4JHFMrr4VB7hWQRoZxt/7CmTawzwYF/PrIWUcj9DNVREbZl00C+f
 P6oSSb20dRqH5e2ORBxdYF9Po0qAltzM5Htgjr2+6hDJwQCNaWKRKApUixR5U8/3nMb281
 kY9KTHSD8lAHuKyqCr/1Swssr3hQLEYhzVoXyK1+TcFaWIU77EkLq2DaUrmFcu9Bdgzou3
 Y8fVscMTNWxNk6bjwiPt8JHPkMFRuYikXUp8ZnOkEmjiiSt471YORUPlds4g
X-ME-Proxy: <xmx:EngdannOxBrRcveoSHI3RlXdSEJF73o6HDYtzqUgG2h1H-USWGNNOQ>
 <xmx:EngdauGnVrHDQZYbeM3RnofmPiFqQ9uER_XnZZa8Eh4ghYniALW8nQ>
 <xmx:EngdanEk8Ca0Zx0Gqr-aINVTZoiIQWzp3lBK1oB7V9JcjHAW0HMrlA>
 <xmx:EngdarOFilUdWafKl5_pko_kc0nZXepjemK0nrRQQJzbdbxa7LxKBA>
 <xmx:EngdatPnHvKN1UWWx5eIHwQWM6k2MhFnNgKVsAVPiK7y73B184_EZyNH>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 08:16:17 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Jianfeng Tan <jianfeng.tan@intel.com>
Subject: Re: [PATCH v2 4/5] eal: fix async IPC resource leaks on partial
 failure
Date: Mon, 01 Jun 2026 14:16:15 +0200
Message-ID: <68rC0bdETzqwIkoItqSb_Q@monjalon.net>
In-Reply-To: <eea1925f6fb24f0f92a2a57d45e9a9c824d353c0.1780068382.git.anatoly.burakov@intel.com>
References: <eea1925f6fb24f0f92a2a57d45e9a9c824d353c0.1780068382.git.anatoly.burakov@intel.com>
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

29/05/2026 17:26, Anatoly Burakov:
> Use a numeric request ID for alarm callback lookup so stale callbacks
> from rolled-back requests become harmless no-ops.
[...]
> +static struct pending_request *
> +find_pending_request_by_id(unsigned long id)
> +{
> +	struct pending_request *r;
> +
> +	TAILQ_FOREACH(r, &pending_requests.requests, next) {
> +		if (r->id == id)
> +			return r;
> +	}
> +
> +	return NULL;
> +}

This function is supposed to find only async requests?
What will happen if id wraparound and becomes 0,
matching sync requests?

I feel we should filter with r->type == REQUEST_TYPE_ASYNC


