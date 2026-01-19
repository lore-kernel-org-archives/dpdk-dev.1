Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458B3D29C33
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 15:13:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24FC64029A;
	Mon, 19 Jan 2026 16:13:17 +0100 (CET)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id EE31D40299
 for <dev@dpdk.org>; Mon, 19 Jan 2026 16:13:15 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 69A77140064B;
 Mon, 19 Jan 2026 10:13:15 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Mon, 19 Jan 2026 10:13:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1768835595;
 x=1768921995; bh=WeCVoL+S9LQQ/t+zO9vf4Mu0lCVzrrt5rQB3Fob3+RU=; b=
 E6MwiE9DpTmS1n20J2RNhSbb2E69JXJ2n7t5yNkptu65E9GU0VBvTeaPdWu6dbrz
 J4cTT+DXYenBYbBJd7nH4j4M96qZwb/NvNNByyWJjAYXCwvMdIMWFj48p7w3hAnQ
 X3CeQq+zgxn6D/O09Bquv7HGkNXhV5gKgczAWQ0iR8+VXzHns1TEo506h9z0OMSf
 kpYAOaJcMuTDyBqYigglGuIOa3KeGj39U39cVpI2Yai7R1VKybB7IUKXwxnC6VVe
 /Y4TLn8Xdsm1blYKoD4S3fXgbWclChi5xQwBLzpS2yGMs/AE/RvmCUYcwq4hd3Xm
 gz7dnntbuLgU/hnXagHrYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768835595; x=
 1768921995; bh=WeCVoL+S9LQQ/t+zO9vf4Mu0lCVzrrt5rQB3Fob3+RU=; b=R
 OEcFE0A86EsKj9dFEJNUYIMD2JN49wu9uUqlSWgCDt++xrPQPU6tghR/ticB7A6m
 iKjXfvMH0OtOE7wOr10eykhrxjZ+BndUvAIw9GuheFD6dRMi9xFc4pmUkW39Sq8G
 6DKg6gWoihMdXaGYQEkIZKwA3IM0CfUbgjOqN8cIkN3ryJPcaqQly/j/LZlPBcto
 NlsC/+L9021I9Daq4nl68EpErFlMVTFYMayUGIRe58cMmiLxgg3nKDOvFbVhkYZa
 /Oj9ubvs8XthnWQgoVa4wvIJVk5mJ0hXQSn4+hKWaAD7hCoE0v5WMEftlJFdBUzr
 nQ82hLz13Un/t4NqHbBMw==
X-ME-Sender: <xms:CkpuaXOsc3KFhXXknAV2NOTPmkiFcM_1LsXnyj47JE8f9hv_8DWPQw>
 <xme:CkpuaeSr3h0GqI4fC6-u_oeAskojPWgthIplzLy49an6iNTYGKBwrulQ2H5cIamvV
 Uhk5lQY0SsjvbUnHIti0MTpDtUB_U0jeltzozf4Ma8mExOVavQSKcs>
X-ME-Received: <xmr:CkpuaZARbQPFMjJZJ8i0lFmPQPwzpp-zWtamEv6Rg0lUNIGx5hMCi6XSQa-lXfJuaadvD1GYlL1I_y-2y470osBcKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeejkeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehjihgrfigvnhifuhesthhruhhsthhnvg
 htihgtrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:Ckpuadh5i1yHHsZXWSrfGHSpNKMCk3kz4-ZNSmQ8-VE_XYptB_aAqw>
 <xmx:CkpuaSPnQ47UnmF-LgKDV24MGfI8riWwaqAB9ts7nI0rujmvyu_oYg>
 <xmx:Ckpuae4ksSqKw7PbQ5xzpqxtfR7zN8ZnkhezIYn9D6iS_JwaLerbCQ>
 <xmx:CkpuaQ0Lya3g_pKqjpN2siUX0zcGPvHeqNOc8U9fHSafo3cWOcLThA>
 <xmx:C0puaRh5J2vjUaL0e9qGk_z6XEbvLTSpPl9gsU6ishhIy-kxFT-9ftBS>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jan 2026 10:13:14 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] maintainers: update Wangxun maintainers
Date: Mon, 19 Jan 2026 16:13:12 +0100
Message-ID: <4479661.ejJDZkT8p0@thomas>
In-Reply-To: <BA4B85C9F816456A+20251216062031.93100-1-jiawenwu@trustnetic.com>
References: <BA4B85C9F816456A+20251216062031.93100-1-jiawenwu@trustnetic.com>
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

16/12/2025 07:20, Jiawen Wu:
> Remove the developer who are no longer involved.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Applied, thanks.



