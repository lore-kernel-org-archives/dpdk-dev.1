Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C67CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 14:06:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 743F740151;
	Fri, 24 Oct 2025 16:06:16 +0200 (CEST)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id 6BE8A40150;
 Fri, 24 Oct 2025 16:06:14 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id CE1977A01D6;
 Fri, 24 Oct 2025 10:06:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Fri, 24 Oct 2025 10:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1761314773;
 x=1761401173; bh=DDWz2Ys+hLe2M/uoo5cZMBEM3w6fsQVG9VIwCAVM0Qw=; b=
 YHOPl1Dcj/rfDatSaR4LPBEa13ChEQ1FjXMyQqGPqbm+ewmO9gClFCQk30pc7UHi
 05+1ZVwqJTKzHlYp+CU3eshDs7SJgNci/tDZdMLIKqkXYRYsC5+JRIdrkU+dO5Ib
 +Ly8LZEf7kc1qB8V80IiEfiJicqzeWknf7R2L33CyT1qAnWafHhoJdgy3/3b9i4Z
 C76WxZ8D9C7Q6WPLbp4B94NSmEux+WEdvO+vpz0k+cmP5tKh7wF40+nmEzr9vTB2
 EqjHO6te0FBof7X08CuNr8+bKkpbUE/VvowmsrXdpNIEsMajIizARXmxZ7hlUd34
 2D8zcMtw4HmeiHVeF7gInA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761314773; x=
 1761401173; bh=DDWz2Ys+hLe2M/uoo5cZMBEM3w6fsQVG9VIwCAVM0Qw=; b=g
 w60NJNEWkqLMngBbUYweJUnMFuDK9yVIqu8vmuo+0P1fjkuM1RRz551WK0mSEh/Z
 ryfPe8rz75ZuvdgvM7+iZoOLnlmKOxbYcWVoEC+p50IBzVuk63XuZPD0jDb6AadF
 YaYxmMdEPMYY76rGFWJJEaAMek4PVbS8xLm7GZRXUogmZp/ZmEde2sDNq5GDJQ3t
 ZPAY2uI29rRaBwgroVv7sOkOwYLcauAPbcLT8i2p6n4z4ZA5j8IE29hE9vsoTe3/
 Sd1x0H1J+WhXmc2zCKnE3MeGjpIJ2bypnUcd+aGPe1AQ+/Nwo2D++vSwuKKtfTo9
 9GH2IlKG68ZatPeNq3o6A==
X-ME-Sender: <xms:1Yf7aC56w1lRkWXhia15CyO2W8PtTNwV9LSeMHv3siZUXWhtGZbyBA>
 <xme:1Yf7aANFAPyIQIyqfOUpbpu9EYZ7OOnpMCYJRk5H8SGowxc6XgzYRGWKS8rfkC2NO
 3gqIexGf6uAQzPNOh71EoAm_vtNbLDaxbV56ml-tYjGiuq478OcqBk>
X-ME-Received: <xmr:1Yf7aAnHdp5RTDUu9sElU0ihIaEZosuwKWjJ27qQWcMc_Z_AXwHPlPLqcV9kOuknLjq6-2HPHAggC5SdJm5C_MuBaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeelheefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegouf
 hushhpvggtthffohhmrghinhculdegledmnecujfgurhephffvvefufffkjghfggfgtges
 thhqredttddtjeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomh
 grshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeeuleeiffejledt
 ueekleegudehheeggedvgedvheelfeejiedttdfgkeekvedthfenucffohhmrghinhepoh
 hffhhitggvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
 lhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtoh
 epfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprgguvghlqddvrdgsvghlkhhh
 ihhrihesphholhihmhhtlhdrtggrpdhrtghpthhtohepuhhsvghrshesughpughkrdhorh
 hgpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:1Yf7aHTMgivUzRlnHQtee9Y8SoIARQ-MrGo0pJeefAwnn15ESpy2YQ>
 <xmx:1Yf7aMBNz1HmMET5EUVGY6U0EoBistm7hatTtCOtNW6OkSH6ItttJQ>
 <xmx:1Yf7aGQe6SqutsmTAH6koU9wJIw7hz361B4KFRicPvZODpxXatkqhg>
 <xmx:1Yf7aCpEId1lx5GpPbMOEEDsJ4-nu6uXYLzPgRSdkUqZcZVM7GCMow>
 <xmx:1Yf7aEraPDUTeyux-KWiSnDJw4R9m6uQGs4GdP5-ofcUxaGSmfQL5XL0>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 10:06:12 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Adel Belkhiri <adel-2.belkhiri@polymtl.ca>
Cc: "users@dpdk.org" <users@dpdk.org>, dev@dpdk.org
Subject: Re: DPDK observability survey =?UTF-8?B?KOKJiDc=?= min)
Date: Fri, 24 Oct 2025 16:06:11 +0200
Message-ID: <2720733.htQpZWrp2x@thomas>
In-Reply-To: <YT1PR01MB88265C8B9023D8653C29BCB58EF2A@YT1PR01MB8826.CANPRD01.PROD.OUTLOOK.COM>
References: <YT1PR01MB88265C8B9023D8653C29BCB58EF2A@YT1PR01MB8826.CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Hello Adel,
=20
21/10/2025 16:18, Adel Belkhiri:
> Quick reminder about our =E2=89=887-minute survey
> on how you debug and observe DPDK-based applications in real environments.
>=20
> Survey: https://forms.office.com/r/6zRAqxWYKj

In the question "Runtime environment",
I suppose "Bare Metal" means just on top of the OS?
DPDK used to be a real bare metal environment,
so I suggest rewording this question.


> This will help guide open-source observability work (Trace Compass analys=
es)
> by Polytechnique Montr=C3=A9al, Ericsson Canada, and Ciena.

Will you share the results here?

Thank you


