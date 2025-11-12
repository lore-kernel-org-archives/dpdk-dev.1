Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FD2CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 09:10:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74FC440653;
	Wed, 12 Nov 2025 10:10:05 +0100 (CET)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id D79A84014F;
 Wed, 12 Nov 2025 10:10:03 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 40F311400231;
 Wed, 12 Nov 2025 04:10:03 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 12 Nov 2025 04:10:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762938603;
 x=1763025003; bh=8C6JtYW0rZQheiLHCygcusI91oW494c/bMkpGzSEMb8=; b=
 ZkxtnsU8fcU+/qAa0UIGwb+YAnVUyHBTBpwgl27rThzg8stV9k+P7voSkPl+ujyS
 22OQ8HT/pSdHHaH/Rb+qv+BPXUNjaAr6/6tEmru/iuvx0HTX8u1ivgdtWVldxh0j
 vr75OCYkY5s7ETGNEAI+1JXIcNVLycabf2QLFkfnDzVp7v8JRr5HocTPvYi2VrJv
 mQHZWz626zJaaX5jvnyFQ7hovh/CobxLHRNVfVJ8VOBOg7nJAY/cY8Sv3tpyPDw7
 c2RNe/QgDRvddGkNgPMRM99YMejHwTZ0YjgmJQOQ+fXwjRLKQQRH57chuXgkrCGm
 8z4qzMC9aDd51/6BB6wTyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762938603; x=
 1763025003; bh=8C6JtYW0rZQheiLHCygcusI91oW494c/bMkpGzSEMb8=; b=2
 oA37HoSo8mfpKZxvb7h6ZeKUvyIakwxoJI+T1a73kL8NIXhtkA0LKVJP+Ua/Ed3F
 mTtlunV+K8F4LSr2dhIO0b+aEVJfgin2NrAGm9d0PSxKdiM7xOibNRTb6pDfajim
 jZUsTn8l5aiLzIxN8QSWugvE0veZmbYV3pM3uEcE8CzY4SiHb4tEkj7genVGThEM
 p+GD1Qg7NgNo2Gf/oYMZgro9Rs/XpsSmSzgvk1qYgI62K2PkMdryM4i/7Szxk2pE
 Vhc0Cn6nMFZ80a9z5dW5+GHq9hjl3z6gRnto6Pdl/yKaqAPsg1gacmfKyoNqC6a/
 IbdH+jkTXvecknehZbwVw==
X-ME-Sender: <xms:6k4UaUcC1Vn-SDAn3HsYhnUyi4thpVeDYmkhjjLN1Ch7qIpLrlEZDw>
 <xme:6k4UacM5NCRyqNGco76v5ePcrCd7yoZi7ZjdB8JxjJBjTvW8LiA4FHtaFUoQDYYv_
 DM-JwD63oy1lOqQkR3hFNRwkAvq5nYIABYDzrkkQzsM3dAUSAgTWw>
X-ME-Received: <xmr:6k4UaQUzpkNsRDI3_yaI9rwRfyeD3zTzRZD40JYla-m1-wOD9Bcm64dk6yfZRXrmijJie1SVbhdisdY-vUFikP4rvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdefieejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeduuddp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrvhhinhhlsehnvhhiughirgdrtg
 homhdprhgtphhtthhopegsihhnghiisehnvhhiughirgdrtghomhdprhgtphhtthhopehm
 rghtrghnsehnvhhiughirgdrtghomhdprhgtphhtthhopehvihgrtghhvghslhgrvhhose
 hnvhhiughirgdrtghomhdprhgtphhtthhopehorhhikhgrsehnvhhiughirgdrtghomhdp
 rhgtphhtthhopegushhoshhnohifshhkihesnhhvihguihgrrdgtohhmpdhrtghpthhtoh
 epshhurghnmhhinhhgmhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepuggvvhesughp
 ughkrdhorhhgpdhrtghpthhtoheprhgrshhlrghnugesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:6k4UacxHqEB3F7Za-fTOAIozADLBF1tn6te31dC1I-cACHRxEE1exQ>
 <xmx:6k4Uaf-bslnvJAMDA9DTC6yYkV0QZnG1V1f1HeQXhgRkI9OPctDKuA>
 <xmx:6k4UaZ8LwPxgrW5Vdb02y8hS5KCl__aUynCIuJ7LuzUjzU8ikZ921A>
 <xmx:6k4UaWUQGLhgEjijbVGtSazt7aRriZB4Kp6xY-wmoa-fMgs_-T_F6w>
 <xmx:604UaUo2Nx-MsOy7ZzLb-co75FEsJlpWgxbsN8BtHm3JpUx3X3t7OvSG>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 04:10:00 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: "Minggang(Gavin) Li" <gavinl@nvidia.com>, Bing Zhao <bingz@nvidia.com>
Cc: Matan Azrad <matan@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>, 
 Ori Kam <orika@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>,
 Raslan Darawsheh <rasland@nvidia.com>, "stable@dpdk.org" <stable@dpdk.org>,
 Maayan Kashani <mkashani@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix IPv6 DSCP offset in NT HWS API
Date: Wed, 12 Nov 2025 10:09:58 +0100
Message-ID: <4447141.2yuIWEeYC1@thomas>
In-Reply-To: <IA4PR12MB97632C78D2EAF7F0987C75A2D0CCA@IA4PR12MB9763.namprd12.prod.outlook.com>
References: <20250930072827.9630-1-gavinl@nvidia.com>
 <IA4PR12MB97632C78D2EAF7F0987C75A2D0CCA@IA4PR12MB9763.namprd12.prod.outlook.com>
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

12/11/2025 09:58, Bing Zhao:
> Maybe the title can be changed to non-template API directly instead of NT HWS?

No, the correct name is synchronous flow API with hardware steering.
You can shorten it as "HWS sync API".



