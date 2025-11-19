Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577E6CF256A
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 03:16:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7997540265;
	Wed, 19 Nov 2025 04:16:31 +0100 (CET)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id 9A3934021E
 for <dev@dpdk.org>; Wed, 19 Nov 2025 04:16:29 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id CA7787A014C;
 Tue, 18 Nov 2025 22:16:28 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Tue, 18 Nov 2025 22:16:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1763522188;
 x=1763608588; bh=SnvWoRJ3+sRop5RzW7t6Y14atpJOi16GbfiEix0Trv8=; b=
 wwd3SrywgitfWj2OI45Aeq+LTkvEtjS8TyDtTVc56hDHww0KeG9Txz+f7LBUh9qT
 K2IpPIGJEV4emyvHbuE0duT10MxgeM0k2RY8F8H3Ajg9g4UYJEJ9ViAP6j4uF/Mj
 TJmYZBToe9RGyiZOVChEhgsXE5SikhpEni+v/9N4ZEX0JKRwmNf7vgQ8nbQNvk3a
 KlsHhluXpovDSMRo0Jqmbq3TT8h2PfXv9h2j2xnvrX6EuDrvzFwYXXqCehNuHtx+
 E1lwfPhk78aUkw2BtJJPh1OyKs/lt3Ps4lZOApwXzrnsLOBOYuMFXhiXoTZXlj4o
 W8yDZGdl+heMfTwWfihN6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763522188; x=
 1763608588; bh=SnvWoRJ3+sRop5RzW7t6Y14atpJOi16GbfiEix0Trv8=; b=l
 quRjCTDYpgl37CquGhpEGGJSh2dsbBOqWeNkaBhMBi0G4wkBr3G+MCDrCIVGyq01
 IemdiGxoai2EAtZGTUPPITwluB/xIdEdKrmTgThYuOz1G2a00jas86jIOkHv08Pj
 asSXJcjNBh11vEyNDeza2cNS8f12tkJkVec+5BpDXdCsOjdGU6WFdnZyEvMIfSCN
 B9qE/prlSc5iwUaS80AgWOcMBxzh852xgX7V7QOu5+mh3OVKoxovlNdvrklo/IPp
 sS2CJ0g+HZw0XtcupVwutdFWGahslg04qwf3PMJU6cNSkL5ShiiuwMFYYdq0pX/B
 ZRfgFQe9BiINlY6BxV3/g==
X-ME-Sender: <xms:jDYdaTEZ93qlB3gOH_DiZni8v_wCM1itMBN-v06q9hp7V3R90HKZUw>
 <xme:jDYdabTeM6Itw_DZZpVY5WblnEfGkA_dxJ7BS58N1FOgns4Ld8kdAgNh6rmbsD-gH
 AJD_X8K9CCHNRoMMEepkZZ0wWziPiCuwJ_yxi6hQWE_M5em9GUf>
X-ME-Received: <xmr:jDYdaUIBJB5hInJMcx5QehaqMb1fLN7DvtXT74PpdXSF6an7_wY5YkDT-8otviV2snqqW6znovmV2TwQqTN9pRaLnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefuddtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehprhhosggssehiohhlrdhunhhhrdgvug
 hupdhrtghpthhtoheplhhutggrrdhvihiiiigrrhhrohesrghrmhdrtghomhdprhgtphht
 thhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehprghulhdrshiitgiivghprg
 hnvghksegrrhhmrdgtohhmpdhrtghpthhtohepughmrghrgiesihholhdruhhnhhdrvggu
 uhdprhgtphhtthhopegrsggrihhlvgihsehiohhlrdhunhhhrdgvughu
X-ME-Proxy: <xmx:jDYdaWbZG5JgDMd-cf5RBI4Pe32ZwOgjyk5AvPmSIkRZHC46X3ocVg>
 <xmx:jDYdaW8QeQS0HA_CFT_qvxmGLlqPGgaZjnbwYBmb_lmpug4haIOVhg>
 <xmx:jDYdaXYnU6Ojkhm3aJYdXjCm6qBcV996Z5AvMyXZNKoq2074OxqPsw>
 <xmx:jDYdaaOlWDxEE_N3aTJZ0g2Viw9ug8Qb17ZvQbwIrSxJa_CIi2YKMw>
 <xmx:jDYdaZfEWEjpdyAjoRHXldY-pHgQPqIql3XE0xZ8EboqFaQHeekP6-GP>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 22:16:27 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Patrick Robb <probb@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, Paul.Szczepanek@arm.com,
 dmarx@iol.unh.edu, abailey@iol.unh.edu
Subject: Re: [PATCH] dts: mock pydantic for autodoc
Date: Wed, 19 Nov 2025 04:16:25 +0100
Message-ID: <7024868.MhkbZ0Pkbq@thomas>
In-Reply-To: <20251113215617.183141-1-probb@iol.unh.edu>
References: <20251113215617.183141-1-probb@iol.unh.edu>
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

13/11/2025 22:56, Patrick Robb:
> Mock the Pydantic import so that even when Pydantic
> is available on the system, it is not loaded by
> Sphinx, ensuring we perform the doc build without
> Pydantic regardless of the environment.
> 
> Signed-off-by: Patrick Robb <probb@iol.unh.edu>

Applied, thanks.



