Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDDCD116EA
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 08:49:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5CE04013F;
	Fri, 28 Nov 2025 09:49:39 +0100 (CET)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id F08DB400EF
 for <dev@dpdk.org>; Fri, 28 Nov 2025 09:49:37 +0100 (CET)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 4FBFC1400199;
 Fri, 28 Nov 2025 03:49:37 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Fri, 28 Nov 2025 03:49:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1764319777;
 x=1764406177; bh=Pd4O2j0P4zuCWiWmtshDJXJ3pGpZceJTW+cUtdQXf6I=; b=
 KPqHIhpbM7NivpkQpNK/xlHGoY1cBDNGFwChVTx40vE2dEUGKwWBamYJYqzmdZnH
 NQrVIFdpXxtoR998A9ZpRbUSTWqBk9h9gSJf/WuHl4xcVXjCAqZfoKJwepK658gm
 TCUPTWOA/z8z7xoR4JHpBeviArd4UcydaylJRHbRZhyB5eS3rWB1LAc8MvnorRfQ
 5QHtg0A3Dl02HL7Ob7ez6bQXD59Cfzd+VnvbAE9VX47vhu6oyHUZ7gA0Jrw1U2e4
 2TG14qhR8k9FsiCDfMvilgDpSssgIhBrmjGRYk4oIF5tWNVPVkCYjhoaOq8s+AHI
 GOd31q6+ym1zhtcZY/tcug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764319777; x=
 1764406177; bh=Pd4O2j0P4zuCWiWmtshDJXJ3pGpZceJTW+cUtdQXf6I=; b=M
 dF8DiuV+kjejh/6Df/MOByH+edYLLc08qeg9PfqG8oQI9HzogEtMCwNRfCtBRcQi
 zxBLUHwByBvrpFn/nEa9BARswXu60TUPC3eSN+xakIwkR6xXuLtje3J/tVd458qr
 Hg1GLSiTTloO4l9j5LWIdVkIGk3BOVOXjSZGFxZmYd0rn07wNShH5lLs9lZFk6K4
 eInz15AA2q6ct1iaOz0X+n5zzK/rhwAFAuia8CHmKNVzmnuoGqdEvdlbu1OTybul
 lr49Xr4XizNK4PpwwbTV/bew8yb9n5sBYTEFBLDx4XYTvJ5T0X2XxlpLb3zbhQlW
 ipE002nZYDCjkTE8bH3UA==
X-ME-Sender: <xms:IGIpaUAMyNKGYp6HPlleuB-Yb69-gHlccVdF5iJZW3znRNRaAZ3lLA>
 <xme:IGIpaS2k2Qb_e3fOLF3hvCTNPys3wUB8MDHjoEP4U4I9o3un4FalV01fD0dfhXJYp
 oApWpbMsDALGyIOYjifSzhcoFi_m7YBfYIvfeapQOGH43Zm5mdHPjo>
X-ME-Received: <xmr:IGIpaaVepuJzEyssIqdE5naZ20ZemdP3wkS9-t_eBvA5aUSCV5Ms6uOG-PvI6skC0R4TyWUNRQ_d_GA_vMbL1hIY7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeelgeegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhhnhdrmhgtnhgrmhgrrhgrsehinh
 htvghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:IGIpackpjihomx6lsQrl-uAaBoKNO1ztaO6vzNb7ZNbqPijCRr2cxQ>
 <xmx:IGIpacBWpwVVlsRuDekAbUOE5Q2wrAaQX9cbIJ2XiEoIFQumyRq8HA>
 <xmx:IGIpace4CmGEwQosZXpfXelJq57iYIgbKsGPbS88J-2M1SxIhLW4Kw>
 <xmx:IGIpaXL0zcYcLHCQw2dYsnMXsqi9C1SYu8ps7sDk0D8d4cgdJ4n8HQ>
 <xmx:IWIpaUorXdr2sZut7fg7ksT9-OvopiOwkC2pzCpchtHAp8ZgvMEJJC-l>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Nov 2025 03:49:36 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: John McNamara <john.mcnamara@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1] doc: update release notes for 25.11
Date: Fri, 28 Nov 2025 09:49:34 +0100
Message-ID: <6757578.DvuYhMxLoT@thomas>
In-Reply-To: <20251127094443.109547-1-john.mcnamara@intel.com>
References: <20251127094443.109547-1-john.mcnamara@intel.com>
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

27/11/2025 10:44, John McNamara:
> Fix grammar, spelling and formatting of DPDK 25.11 release notes.
> 
> Signed-off-by: John McNamara <john.mcnamara@intel.com>

Removed comments and applied, thanks.



