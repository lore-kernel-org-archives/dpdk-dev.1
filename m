Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47101CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 14:35:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EEC440698;
	Wed, 24 Sep 2025 16:34:59 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id 853894066A
 for <dev@dpdk.org>; Wed, 24 Sep 2025 16:34:58 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id CF9D37A0197;
 Wed, 24 Sep 2025 10:34:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 24 Sep 2025 10:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758724497;
 x=1758810897; bh=UCYZbB1Z4IdYUvTVrm0s9CukG5VO1WcI1Y1tmu4qIII=; b=
 uM55p7yMXSDj2cZUg5/0EFAwESZFayhBPIsOEJwVDc0HryR7BzjbwHAqf0XESNKD
 vAr9LQjeb4sgJN4tcJcu6wCKPUK3x0rCsww/qm7MvE3Gaf1JEWVENmmuE6pXIVWB
 8eD+RvD0rVsUkrZp8ZifXLzM3taudoU7msNWeLeyLfVWe4D1o5iXvB2Wcmufl43r
 SrbMqQbqeCgs5yEQOfry/N6IFHdiPihWoiWBK8h33Vv0cjr07MiMHfDeZH8Ii6E5
 qxq/ASm3nJIwFSLGBSDJW//IV2tx3nz6rWlPl3piphXNqCAbrZDy+EHmGVnJJozm
 Psul3Y+iJ+kP427cjh/CTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758724497; x=
 1758810897; bh=UCYZbB1Z4IdYUvTVrm0s9CukG5VO1WcI1Y1tmu4qIII=; b=X
 zHIfP4Ny5C+9khlHXx2HPNWbpS1SHapJ4X7/O/3Ry7VOyN7DADSyH7bHbk8mXjme
 voaiYcaui3515czaa0yM9RU3StjefciE8wLFBMDIhRJxPfoux6ubypaCn6psf/qc
 2RIbEop0tF1QEIcErsuT8nYkPyBjiRhECYwtmQhqlIk5Pwm/h/alNXMvA86hsbEF
 eNc07sR9biatxCb643SD6aQG4BNG58M8qHUFNOUPLsgYAIhbrQG0eqM08ly8m7ZP
 tAxPhAJV+UqhNjVBUbG6wgjY31acWXTKzmEz+sA2+9p5yJpvvQzcyqZuuSTBsPEA
 fyOBqcX+M7sB/FlBo9t2w==
X-ME-Sender: <xms:kQHUaKTnTS5XCLZphTyvpNw-LxJQIoPjrzztKynPtcv4etJ_b37WRQ>
 <xme:kQHUaP55CoMoL-UAuAOyyfXzxRvGspFu_32XxYdFmE8wjb3HkTVV_HwEEIMw1Xpnr
 hOCv4Gr0KX-tiuPMavoat_gC6DGEy7weao0x2_l3eN4toy8oYRlhw>
X-ME-Received: <xmr:kQHUaPwuC11vgVWk-SGWr45kQYwZjFKBHF-tsjtufR76cwV6rpLuUjvRm_WkhS5cn53-0o-9nv5NngijovxvSttn0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifeekiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepgedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepthdrrghlihgvvhdrmhhnthesghhmrghilh
 drtghomhdprhgtphhtthhopehjihhnghhjihhnghdrfihusehinhhtvghlrdgtohhmpdhr
 tghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepsghruhgtvgdrrhhitg
 hhrghrughsohhnsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:kQHUaOQpeOXE3J4jQmjwT3FSqyOFKndEiN1411_sNRygZNigAG2hIg>
 <xmx:kQHUaOW75m0MuAOq85tvBefLMOFzHXswUlKgFHncMUaYSlPsaehMNQ>
 <xmx:kQHUaIbMSb4N7sOr-8Von_sZ0J-Oe1TgQhX2dCyd0AQHmrzLmDv7Cw>
 <xmx:kQHUaM2u9b9ih2K9MnL9t8ZY8AGKKt0F14A2EncRya1IWcXcTj4TXA>
 <xmx:kQHUaNkE7F_CliuJBrOsuoZPH3rSYAidZqEPvdOu0Yjqn1mOYL3Sa0aT>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 10:34:56 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Tofig Aliev <t.aliev.mnt@gmail.com>
Cc: jingjing.wu@intel.com, dev@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH v2] raw/ntb: immediate return if no doorbells
Date: Wed, 24 Sep 2025 16:34:55 +0200
Message-ID: <4185454.vfdyTQepKt@thomas>
In-Reply-To: <20250731183117.87499-1-t.aliev.mnt@gmail.com>
References: <20250731183117.87499-1-t.aliev.mnt@gmail.com>
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

31/07/2025 20:31, Tofig Aliev:
> Added immediate return from ntb_dev_intr_handler()
> if no doorbells.

Please could you explain the consequence of this bug?

Should it be backported?

[...
> @@ -158,8 +158,10 @@ ntb_dev_intr_handler(void *param)
>  	}
>  
>  	db_bits = (*hw->ntb_ops->db_read)(dev);
> -	if (!db_bits)
> +	if (!db_bits) {
>  		NTB_LOG(ERR, "No doorbells");
> +		return;
> +	}
>  
>  	/* Doorbell 0 is for peer device ready. */
>  	if (db_bits & 1) {


