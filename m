Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44634CA0EE6
	for <dpdk-dev@archiver.kernel.org>; Sat, 16 Aug 2025 21:33:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E19B40151;
	Sat, 16 Aug 2025 23:33:41 +0200 (CEST)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id 0521F4003C;
 Sat, 16 Aug 2025 23:33:39 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 674981400089;
 Sat, 16 Aug 2025 17:33:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Sat, 16 Aug 2025 17:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1755380019;
 x=1755466419; bh=kyoEd9K+omaC/CdFDVLnZN4LQoHVsPChcxO2Do/EGkg=; b=
 aHCe0w2x32Ex47b0H5xe4rm33tO2sCYfehrRsT2tdA7GXe9mzbmEUOSLh++38TlL
 uJTUkHRm/EpzSTO5y2QKpRx8wqLKHM2Ry2e3L+3QenrPGxG3lOr2sS/TiNGbVR8D
 O7ZbgfCTPmZ/pGFXgB/x+ry+lzPp9k2nE+rXBuNcwnpKAVwGfJ5Nk6QYutDhiZO4
 erXpTmJDLpo7ktKk0BdxEm1//vQaA2Oh26p3lQWXX/oSFDUz/iLFdQOAYUs6Kj/k
 mlB6AmSprmOKGc+D9tNtAcgfD8drQx99VUsXIon77Xpq1gKmOJ6MR5sGm4Yq0sei
 HfLXLeTD2Co3H0/UjU4xHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755380019; x=
 1755466419; bh=kyoEd9K+omaC/CdFDVLnZN4LQoHVsPChcxO2Do/EGkg=; b=d
 UPQ7PYBCfgnJTG5+Xr3cBfvZ2OJLNlkeBgc1BceuLGfqjDgc8ZnlDkuZ+7jrimgD
 U2cB5LI8LeCg7frjTelFaznDMnpoCmNX7vKBefxIwTeRn5AMqCF36GLPJzuuFNOE
 gYFqPQe37Edz2xBR5C5x4v2CjeUtDoPgPc2AlFRixbYe5+F9CXI0mpDpN2TUpFQX
 iUTfxeuAt0tX0U+LFzlktLrxD+VTKJiQ9SYuZ3Ag8eeQC43ciii+ap+x9Ccdw+L3
 fE9a2NnRizQtg421AHoNQ3OPrpg+EKHgFV1SAGjXv+pRD6lcRnZ621Mw/thuVLiD
 YGBy2ULvoJ1ectdFVLKiA==
X-ME-Sender: <xms:MvmgaEh61S_YIPOvriTg3tYfibqiczGZMn2u7uQN91kxURqKH-FUVg>
 <xme:MvmgaOm8KB3zQQ124_X6r9gJvO_sca7356HMu02pGqgWhwbKX84-k7rMAvhEl5z2B
 Cm69PfhYTQe9KlnxQ>
X-ME-Received: <xmr:MvmgaCasqbCts-VkFBO-ncYzr-xbx3QjFrFJiele2Kjs7l7w3oJWx7p2dQaaEZnQrZR0_uSDYcUYBZykSAd_g8tlgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeejleegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedutddp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrvhhinhhlsehnvhhiughirgdrtg
 homhdprhgtphhtthhopehmrghtrghnsehnvhhiughirgdrtghomhdprhgtphhtthhopehv
 ihgrtghhvghslhgrvhhosehnvhhiughirgdrtghomhdprhgtphhtthhopehorhhikhgrse
 hnvhhiughirgdrtghomhdprhgtphhtthhopegushhoshhnohifshhkihesnhhvihguihgr
 rdgtohhmpdhrtghpthhtohepsghinhhgiiesnhhvihguihgrrdgtohhmpdhrtghpthhtoh
 epshhurghnmhhinhhgmhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepuggvvhesughp
 ughkrdhorhhgpdhrtghpthhtoheprhgrshhlrghnugesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:MvmgaBGplsMYST0go8v153j_XhSZxc3b6NbPsdWwz2JwDeZoWH7TqA>
 <xmx:MvmgaJZDLG3HkEx66qpsK1z_cLEqJ1YdAE65ztdG1AUhB_qQirXe3A>
 <xmx:MvmgaNxi9_5FbUeWXk70grxAFbueQ8Az3jJj8rtx7UAtdW_chls5yw>
 <xmx:MvmgaDQ3-ZXVh5mPvqGEcMDXvoAky0tMQP330NxlfP9hfasxxi2RGQ>
 <xmx:M_mgaNe0U7LFHGV5ryT_Ibm0JLbHasTU6Qs4PxqF6E9ufHjtmHg6UA9q>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Aug 2025 17:33:37 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: "Minggang(Gavin) Li" <gavinl@nvidia.com>
Cc: matan@nvidia.com, viacheslavo@nvidia.com, orika@nvidia.com,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, dev@dpdk.org, rasland@nvidia.com,
 stable@dpdk.org
Subject: Re: [PATCH V2] net/mlx5: add support for flows targeting multicast MAC
 addresses
Date: Sat, 16 Aug 2025 23:33:35 +0200
Message-ID: <39010057.XM6RcZxFsP@thomas>
In-Reply-To: <82b383fa-80bb-47a4-8a58-23b0573db3b4@nvidia.com>
References: <20250814100815.801132-1-gavinl@nvidia.com>
 <3720215.hdfAi7Kttb@thomas>
 <82b383fa-80bb-47a4-8a58-23b0573db3b4@nvidia.com>
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

15/08/2025 03:55, Minggang(Gavin) Li:
> 
> On 8/14/2025 10:05 PM, Thomas Monjalon wrote:
> > 14/08/2025 12:08, Gavin Li:
> >> Rules for multicast MAC addresses are intended to filter multicast traffic
> >> and are managed through multicast MAC add/remove APIs. In mlx5_dev_spawn
> >> function, devices (PF, VFs, and SFs) retrieve the netdev-configured MAC
> >> addresses via netlink and store them in the PMD device data, which
> >> includes multicast MAC addresses.
> >>
> >> To update multicast MAC address rules, create them within
> >> mlx5_traffic_enable.
> > Sorry this is not clear.
> > Please explain what was the previous behaviour with a past tense,
> > and what is the new changed behaviour.
> ACK
> >>   	BITFIELD_DECLARE(mac_own, uint64_t, MLX5_MAX_MAC_ADDRESSES);
> >> +	BITFIELD_DECLARE(mac_pmd, uint64_t, MLX5_MAX_MAC_ADDRESSES);
> > Not sure about the naming.
> > What is the difference between mac_own and mac_pmd?
> 
> mac_own serves as a flag for MAC addresses, indicating that they were 
> added for VF by pmd. This flag is useful for the flush API, which can 
> clear flows associated with VF MAC addresses. Similarly, mac_pmd is used 
> to show that a MAC address was added by pmd for PF, VF, and SFs. It 
> helps differentiate MAC addresses that have been synchronized from the 
> kernel driver.

The description does not match the name.
Please could you find a better name and add a comment in the code
to explain the details?
If you need to change the previous variable, I suppose it would be accepted.


