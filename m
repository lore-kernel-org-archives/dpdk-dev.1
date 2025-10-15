Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C42CCD194
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 16:37:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5888440A84;
	Wed, 15 Oct 2025 18:37:24 +0200 (CEST)
Received: from fhigh-b8-smtp.messagingengine.com
 (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mails.dpdk.org (Postfix) with ESMTP id C782140273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 18:37:22 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.stl.internal (Postfix) with ESMTP id CA5E07A009F;
 Wed, 15 Oct 2025 12:37:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Wed, 15 Oct 2025 12:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760546241;
 x=1760632641; bh=RQBRZmSiB0JonoVNfH/vM0+K9mpir85EzopBXazSVW4=; b=
 XxWC2XB+0m+XDrk0qoBFYfc4Xebu8QzDPpgftMzrM3s7pIoE6x8A3am9uzAgRfDA
 0mH1QW3IngFAryajdX/zDg3wbTMXk44MiVJSpfUSZU0v8bXZ1mXIi1LB7cVr9QmV
 f+xc1GEMKhfTaV4wHFdVuh+YKzssAb4nht6o7yD1YWhXbfD2Gg+iFCGYu1m5p6AA
 qTQV237GtSBu/B8g7jHm9wmUaaNlQdfs/IFTYXaaqicVGZmM4UmHWOQ2njJmAS+/
 uTlaQZ3CPiKrz7EYbwwLzIxfgiK3TBUyjqjvqvFiefniA2IEe6Cwuo/uS0AA92Jf
 h26jhgRGNYTJ+V5BJEUo/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760546241; x=
 1760632641; bh=RQBRZmSiB0JonoVNfH/vM0+K9mpir85EzopBXazSVW4=; b=O
 MjZj/Mw0lvQZqm8hPJ+KN+ht5Kf+jX84iN5n39VmwqPKLc5qsTDhRe224oCkuqfR
 MgiNVe3/gYknBSMsZPLXnz8vZ1yiBQo3Husx/hYdwaD30bl2e1frfpOgBUckEKzp
 gtizM/596mnbb8GoUJk5V9Mp20rkD4xU5kx/uVH+FUCAD/oJxGTj/MCbaT9rEjFw
 FNeBZAZuAZvzaz4W+XPMe9Y1E2AutVmg2jEm4f8O46mRqGZs2sarLsVsTxcxUNhy
 WEkAKtjTf6pHskp65Q23uypUjhgJbhmbHscZD0+WNCWnBjF2TnrD3XBuFVi0DvAx
 PcA8UQFitLgef4OyV27lg==
X-ME-Sender: <xms:wM3vaJRpMJrasOpcfmzNrviFQNHh3owAIqrme_Q7oGr6Gvhls3HXAA>
 <xme:wM3vaNsKGGF4gq-mScZLx6IJx4xUMmiaCAAj3NgFajNsTcdDd5EhhfoyZgcTJIIOJ
 -GdfKnRInLaBMlWXYGoloBRAohWGdxUsBsn1tg7_G0HYH2hRzQkcA>
X-ME-Received: <xmr:wM3vaN3X6epAapc-kmg-3R0ctUPNXJ4RrODxGZdCbOcpPLkz9tu3zckK4vrvqTmAUv1ANSlkSYMlUQh-uP3EuxOkMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdefleduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeekfeehfedtgedtjeehueeutdfgleefieevkeeikeelkefflefgtdev
 ieehheffudenucffohhmrghinhepughpughkrdhorhhgnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdr
 nhgvthdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
 epkhgrihdrjhhisehinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdho
 rhhgpdhrtghpthhtohepghgrkhhhihhlsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtoh
 epkhhonhhsthgrnhhtihhnrdgrnhgrnhihvghvsehhuhgrfigvihdrtghomhdprhgtphht
 thhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtth
 hopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthho
 pehmsgesshhmrghrthhshhgrrhgvshihshhtvghmshdrtghomh
X-ME-Proxy: <xmx:wM3vaGV7C8JvtAndE5CQq6IVveid3XyqbFPJApiiG0kg0T8zun7i9Q>
 <xmx:wM3vaAIkIDLYInZPaAbZhw9THgwzdDrNChsMHxbKIlZPnakvzYOiWQ>
 <xmx:wM3vaA2PkLRjySHDCfnHPvUxBT5Y7Lo55mznfcAAuxMRgo5c78Y78A>
 <xmx:wM3vaO5qwy_2YRiXsGjUL_hYQDNcVf8-t4RW4WSH3hjZOZKLkU0Rtw>
 <xmx:wc3vaCkW_HppAdLeEJsxIkB_JZe5k64D_H5GICmSZh0wLJM37hyXJBHb>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 12:37:19 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Kai Ji <kai.ji@intel.com>
Cc: dev@dpdk.org, gakhil@marvell.com, konstantin.ananyev@huawei.com,
 bruce.richardson@intel.com, stephen@networkplumber.org,
 mb@smartsharesystems.com
Subject: Re: [dpdk-dev v6 2/2] crypto/ipsec-mb: use constant-time memory
 comparison
Date: Wed, 15 Oct 2025 18:37:17 +0200
Message-ID: <29399600.gRfpFWEtPU@thomas>
In-Reply-To: <20251002153229.98158-2-kai.ji@intel.com>
References: <20251001153242.55987-1-kai.ji@intel.com>
 <20251002153229.98158-1-kai.ji@intel.com>
 <20251002153229.98158-2-kai.ji@intel.com>
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

02/10/2025 17:32, Kai Ji:
> Replace memcmp() with rte_timingsafe_memcmp() in cryptographic
> authentication verification operations across iipsec-mb drivers.
> 
> Note: OpenSSL crypto driver already uses CRYPTO_memcmp() which
> provides equivalent timing attack resistance and is left unchanged.
> 
> Note: scheduler driver memcmp stays unchanged as its not secret data
> comparison and actually faster with no timing attack risk.
> 
> Bugzilla ID: 1773
> https://bugs.dpdk.org/show_bug.cgi?id=1773
> 
> Signed-off-by: Kai Ji <kai.ji@intel.com>

Applied with few minor edits, thanks.



