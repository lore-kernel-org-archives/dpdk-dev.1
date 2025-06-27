Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09FEC7EE31
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 10:44:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5752940658;
	Fri, 27 Jun 2025 12:44:50 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id A6BDF4025D
 for <dev@dpdk.org>; Fri, 27 Jun 2025 12:44:49 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 256441D0029B;
 Fri, 27 Jun 2025 06:44:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Fri, 27 Jun 2025 06:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751021089;
 x=1751107489; bh=oiu15o71aalyuIwPFIufqYGbAv5FCwuCingdxmIKAeY=; b=
 JO6gGuE6KsHnYCQaHoRkyLJRsXhVTNW45fDIp7JWwYx8lFYyTVbNi/SR3UBX4+eL
 +vaRB0gFYE/dLCAdAVAsKcnUujuEJhwOVcEqkHhwmqx/45TPB2M68+PpaJDDhZcv
 fh+NPkTtiWyv0LXcTyyxk/F9TcM4Zl3KqP3nycakzCnEH5NJsReRXefNDsTKHj7K
 vLu391sB7dSlcTv6GkoHjRWyiB+UsMHUy+AO0s6TOku1ctLwkuOaif3K4xLE9sSR
 rwJ7Ec9eTa3H6pfOsNXhDEcJwhzCTNl1qZzPkdq+t1cpTQdLq7kWTZQtsyEjmnUa
 FFPti56OneKXsZq8pZtXNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751021089; x=
 1751107489; bh=oiu15o71aalyuIwPFIufqYGbAv5FCwuCingdxmIKAeY=; b=c
 KgMRGP6YKWBluSmntHjWl6pAoynjx/dhhPDLrXj500zO66TcRm2BYCt//zaethBA
 GZSfuHs3tGodeoRQQ27lj9G+bijbFkrLCAcJHxTGQ3KDCsREoyGLk2cf84j2up3w
 tSDdchAabwGHSptdqWhKx6rfGI76odUK1X/VBkZB0vxFMnSL48uZQ7NZ17Scjddc
 uomirqo+D9w94AMiCW214MauNHzKkhbTrwR5HceO589oOWdMru5p8kREF2K7zt1u
 MMUVNaZ0HbsEDypgzMK5NjVY8sYdbceKZF94DK4sRkVEs5bcNtfzZfB4Ep0e7e4o
 oH5jeXoYm4B5qC0hjZxjw==
X-ME-Sender: <xms:IHZeaHPdqdjMIPgZjp_e-W8j51K4ZPNkf1fpuj3LvrLwD_-qAp1pMA>
 <xme:IHZeaB-4QgUnXan9WgNLNWo0cqqWaNdctcldKliMZ63S4uXJiY-OfliA_WBRDx3vS
 mBYFBMXMvmRTeRpSQ>
X-ME-Received: <xmr:IHZeaGSXyMQqwdDEW_T3CCjiVMsKZQf8ckLrQowazNiF7c92ExlVQxx0ps1cpfzR34904OuprabLmAF5-ai6-2Z-Zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvkeehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdvuefg
 feekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopegrnhgrthholhihrdgsuhhrrghkohhvsehinh
 htvghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohep
 rhhorhgvthiilhgrsehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhm
X-ME-Proxy: <xmx:IHZeaLu5f47DT_PAOZ5fUhCoo5CXqXWyqB_h1lwbaMcuHiNgznFWOA>
 <xmx:IHZeaPfa5wv6Od8HwuQ_89R0vIlZs5uwZ-5ScWZCWGxnkzL2efrgtA>
 <xmx:IHZeaH3BDO8lfL45gioLUKmCBxBdxPlblrb8Vr9wFeaYmBGi0kEALg>
 <xmx:IHZeaL9BHnauGvDj0gT0GVHWGpr22KOVQCgN7LgjFMWKQppGEOyLjw>
 <xmx:IHZeaJcjeczRD5Geul0tO5ALcOh31mT0DLHVU8ZsRIlgxQqa8OodePAG>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 06:44:48 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v1 1/1] malloc: handle invalid socket ID's when allocating
Date: Fri, 27 Jun 2025 12:44:47 +0200
Message-ID: <8674337.c0te8JeNC1@thomas>
In-Reply-To: <02ee77dec888cd2ece830f63c5163c4ad7d3d3a5.1750067739.git.anatoly.burakov@intel.com>
References: <02ee77dec888cd2ece830f63c5163c4ad7d3d3a5.1750067739.git.anatoly.burakov@intel.com>
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

16/06/2025 11:55, Anatoly Burakov:
> This issue was reported by static analysis. It is a false positive,
> because both `rte_socket_count` and `rte_socket_id_by_idx` only report
> information about physical sockets (so return value of -1 cannot happen,
> as we only get into this function when socket ID parameter is -1, which
> excludes external memory from consideration), but to avoid future false
> positives, we can fix it here.
> 
> Coverity issue: 470137
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>

Applied, thanks.



