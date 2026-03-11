Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5C01125865
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 18:37:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78E8240A76;
	Wed, 11 Mar 2026 19:37:31 +0100 (CET)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id 295ED4060A
 for <dev@dpdk.org>; Wed, 11 Mar 2026 19:37:30 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 4D6921D001A9;
 Wed, 11 Mar 2026 14:37:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Wed, 11 Mar 2026 14:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773254249;
 x=1773340649; bh=VkCSkB2JKpsMnENawRwh1RbfeEw+eIf9Ki8AXqT3/rk=; b=
 On9c9lw1HCc03fxG0dO3UNJNc7T2EUqJW19Ixs7FKVIBbVwLJ1BE+kJhrG0WD/Bj
 qV6DZnKjWElaewf36WIZScMtMIvnPVHZ8hWJa7GpETedf7phPxdErGxOCgqyoLk2
 j0gYA0ekgmxolqc9sGUW98lT5XyMk4Xikx5LJomMYcbtn2PN1xsgFFdoBHj26AA4
 u9C2fL/zHe9WwyUoG6qG+iUa52VNqYLWckUod9PM2TsK66Q9gajA/NZhthkQ0s3y
 lw1KP1OK4ezVo4HpEqr+XEqQUtUyzaYpxnLX5WjvSfjB5CjkPJHKNzzN8TW9FlAE
 kqnLBJeLKRPCK64sTxqbZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773254249; x=
 1773340649; bh=VkCSkB2JKpsMnENawRwh1RbfeEw+eIf9Ki8AXqT3/rk=; b=6
 ETIR7qfk//5odScDFcwfnRKlyafozUst0e/KqX940E1kBm9CWDSSWZkmCeHdiKqu
 EZ9oLRtFrYpwaT8ugFurzvtFqOT3xBVydocNrnI9wEfQEH4/t9M9mKCKzmYcFt8U
 mZS9c87OfMcJyz+wg9IywB1vF2T6KUxYYeSSII3acc85B2cnvScpRTwUfbEOXUrC
 0ionT8W//Ct9QzbFH6DQIh1PUxL5fM5DWRUkFPe/rEFso5pSEXxjNhkkeIIR5N4E
 DsqQ4JdBTW37pnwtNmi9C+TckNBgFQ/NWdyKp2EM9p/v8M0UPU7ufLqVVbljNhGr
 uF6GfEAXyXv5A7WSI3xiw==
X-ME-Sender: <xms:abaxacoLIulJ-nCRCDXO79561pg42wfk9gQxcb3pf8lj28l3oCQxcA>
 <xme:abaxaSwC4O5HHQY1JW4BoKVX_5tQnACE9HBGL2E57gttGgT0wZMjkMovovOnzCMZH
 _wbxIaAZbApi6GA-Gxmys20aOEUI5QX8AsqGrmeQ_u1KVB-K_8c_Q>
X-ME-Received: <xmr:abaxaZJ-t41IPfnMcnR028bMGbS4zZt15eAwcRMoxrTn-kJYs2atv8RAq9DbIA2dOcF83MRQ_iLTqbPergkscD1boA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeegieefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehmohhhrghmmhgrugdqshhhuhgrsgdrsh
 hiugguihhquhgvsegsrhhorggutghomhdrtghomhdprhgtphhtthhopeguvghvseguphgu
 khdrohhrghdprhgtphhtthhopehkihhshhhorhgvrdhprggumhgrnhgrsghhrgessghroh
 gruggtohhmrdgtohhmpdhrtghpthhtoheprghjihhtrdhkhhgrphgrrhguvgessghrohgr
 uggtohhmrdgtohhm
X-ME-Proxy: <xmx:abaxacLQnuDBXtbUaaHnukuo1CDB0Ns4VEfQbcW0yN1fAZziZ3j8wQ>
 <xmx:abaxaWs872--9WWQjQ4g8UTNF7Hj6eveLc6pO8swMY6VlKz6snxNzw>
 <xmx:abaxaZTp6O7jmy4sH-RdKv0dqHIjWnUkFoqkKN-x_E2RncXvPL5vZA>
 <xmx:abaxacOht1QFOrXytih11_JuEefTnlW9NsUMXNRO4S9YgE6_JRd7bw>
 <xmx:abaxaZDFM4FpfONBbI6F4uFHRh8xS2hqcz7FislnWWYhnvbPdYywmqBw>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 14:37:28 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Cc: dev@dpdk.org, kishore.padmanabha@broadcom.com,
 Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: Re: [PATCH] net/bnxt: allow get stats when port is stopped
Date: Wed, 11 Mar 2026 19:37:27 +0100
Message-ID: <2254923.irdbgypaU6@thomas>
In-Reply-To: <20260302195208.103202-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260302195208.103202-1-Mohammad-Shuab.Siddique@broadcom.com>
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

02/03/2026 20:51, Mohammad Shuab Siddique:
> From: Ajit Khaparde <ajit.khaparde@broadcom.com>
> 
> Currently the driver returns an error if stats are requested
> when the port is stopped.
> But some applications may need to get the port stats even if
> the port is stopped.
> Allow the get stats command to show the existing stats
> if the port is stopped.
> When the port is started the driver will get the stats from
> the firmware.
> 
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>

Applied, thanks.


