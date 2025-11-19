Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264BDCF257C
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 04:14:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7A3340265;
	Wed, 19 Nov 2025 05:14:50 +0100 (CET)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mails.dpdk.org (Postfix) with ESMTP id 38E344021E
 for <dev@dpdk.org>; Wed, 19 Nov 2025 05:14:50 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 5D8477A011B;
 Tue, 18 Nov 2025 23:14:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Tue, 18 Nov 2025 23:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1763525689;
 x=1763612089; bh=U/voRmZ595oy59Vj8GFuy8dYKgBgNsW0zkP21Gg8bVs=; b=
 cyEdADTr+Vww/kvLkrjE3tolV1l/ug3OKKWnFoDOgsaH/noXK0sCbE2sGNKeDGhU
 u2VyOhiJrbTe4nozOEsQjAKW6FJ+vZzy0L4X427b0RJSIsOdpIfNh4zM6VZrk6bb
 atMMTMleumApxVS8nQS/Fyn2pvjpANJFAGKc5Ms007bbVuZhGl565oTZJOLKWHKY
 d2dd8G5npSvUPMno1lFFCS+YQumgh9Nx/wIZNv6sZCu011LXwcpgtW3wOS/qk7lP
 ELh7IMBjaCEAZy36J7bsC9XbQKrr8WwXgdUDlx8oaWOa1DOH7ZGpB7q8n0rzqrw4
 vzRWB/U5rGt3uWKb0wBhvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763525689; x=
 1763612089; bh=U/voRmZ595oy59Vj8GFuy8dYKgBgNsW0zkP21Gg8bVs=; b=g
 NuWorYDZ3SedQymmxHAjYsl593bbldc2WupsGYH3q58fu/J+F8YDLeQPhnEK0HIv
 WB/OO7x6z6noySutLojvtBS5Op+YYCx6n6ASDyNbplHLNggpBlIpPpFhq4nsLhEd
 OeSJc9iAJQsd9lWooHCjCoZ0z3wIT5qn8aJPZUAl8zhOk2J1Ly2Y9oXppb95JsZS
 lM8SfhMqkWb5yMJFYqt3jQ9Qj4x6Zfc2Hn0zTaOYu53GxFbrux+LOYzjzWwTkIa3
 3OVoTc46djJyPuFTKiKdlNt2FeS9tkgzgKuTGuWkVuT8mMgHGpER+l3IhA85XqvN
 ZoGTd4+5ARcbYH1pYpdNw==
X-ME-Sender: <xms:OUQdab5J54YWRGUMNkSzgq8sF-V-ma9fPmxQ-mD3EZy9wiHRFNowLw>
 <xme:OUQdadMGjr1cemzLXWMCQsLYUgqdZers5XxwIA73R98IbWq1ZNerOvwO-qhsEKzJL
 hSnEVsdyeTJ1Z1KFnb2U1QzW_8xUZhb9FeBHdfeyNFPo6wGdPSoQN0>
X-ME-Received: <xmr:OUQdaVODHaMF8EWH268k5TwyJiLhRNFfa9Q5eQd3PFjdHl-AK4iJFQ4-DjG0kbSDjgnx0T4t7J0-1tmr5Vlj8nze5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefvdduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehrrghslhgrnhgusehnvhhiughirgdrtg
 homhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:OUQdad8bpdrrIO7g35MQa5At8V8LTLw-rdZlE4qRuEgV5FNi5KzChA>
 <xmx:OUQdaR4uNLdBcr1WK_Zwfmv1X0-wLqHG6Kx5IBePyc9ljUfCKPzQ6g>
 <xmx:OUQdac3fKJI2zcYejuggA_3D3LyyzyxqcBeISNMASwFFnx6iY0TuuA>
 <xmx:OUQdaQD2O_UzFWx_YDBZDZPZSyYJD8Z2Zn1bm9DewIoNNQjRyB5ndQ>
 <xmx:OUQdac5xU9EnPPUg6MkjQQOJjwtDyfkNmoKSfxJW0kzG6cm7oZwo8Y4w>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 23:14:48 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Raslan Darawsheh <rasland@nvidia.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] common/mlx5: add BlueField-4 DPU
Date: Wed, 19 Nov 2025 05:14:47 +0100
Message-ID: <25080602.6Emhk5qWAg@thomas>
In-Reply-To: <20251111121628.75282-1-rasland@nvidia.com>
References: <20251111121628.75282-1-rasland@nvidia.com>
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

11/11/2025 13:16, Raslan Darawsheh:
> This adds the BlueField-4 device ID to the list of
> supported NVIDIA devices that run the mlx5 drivers.
> The device is still in development stage.
> 
> Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>

Applied, thanks.


