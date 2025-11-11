Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D97CCFA18
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 14:07:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A9C84026A;
	Tue, 11 Nov 2025 15:07:01 +0100 (CET)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mails.dpdk.org (Postfix) with ESMTP id 85E0A40144
 for <dev@dpdk.org>; Tue, 11 Nov 2025 15:06:59 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 4ABA67A0031;
 Tue, 11 Nov 2025 09:06:58 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Tue, 11 Nov 2025 09:06:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762870018;
 x=1762956418; bh=ryi2GDZJwwjWFHEN51spFc5Sk8IXCFBXFouhZLancJ0=; b=
 YETzf8FjHx1PqbiY3DvTNg2KbML4TH9nyKHEUo8ltDbnmRPw4GVjCKR79Vpmwv5H
 zWchkiEmlvRpXKMPk40Ee1KvS4L8FM+xukw8YW+3gjN1aT0cs8lb9qMEjpWZLQke
 K4g3eV4Xsda48I2mKNVfNhfzSw5ibujCOlckNv8AU+zW/9WNaWZjlyXyVg3WFntK
 m1xriT1PfdeONu1NDv13h/LgFmnv6DUo7eopHw9PSYYyscujEPJxKW2lTDhBu1eX
 hbguLs3aa9lC38+jBpkRT9eCobzxjKKTJr1LqZXTKia0WpC1HuyKaEGk359x6Np2
 L05nJKxiaEBRETFP8N6rAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762870018; x=
 1762956418; bh=ryi2GDZJwwjWFHEN51spFc5Sk8IXCFBXFouhZLancJ0=; b=L
 RtzYatonot10Z8Opuw0xwN9rsr68Bm9RlWKjO9b7lUXD76P36rDT9mUB02mkTjY1
 mNoYPukkmPcKpdXGgPB3VqnimqWFDsXLwj722g938tJT8Y+iE3jYojyewrl3Xl5s
 zYWTgjaYokp3l0HKfGwrdcAjFxwacRbkDUsPSsPsMjL3+NZGmCMI2mZYyuQXDDYW
 vIxiLHUwd4dUBHEPmySqvr9svJyn72ec8V9UudsHY6EOOPmWocJ5P5iX+OFJHXUD
 Vw7mnIDQoTd5ZJd4lkoZhUabYDdOcYG2q8sXUqLCIR2Q3QEetGzyIcIBV3Z/pVmG
 XqlejNqNmxgtTHGy/XjLQ==
X-ME-Sender: <xms:AUMTaT9R-XxD58zvM9O70DJxf6dR4RTei7NH2PARxUmPnYVkhdzZ7g>
 <xme:AUMTaTZzq7Sp4mgBoGjP19GuyR0BMJJU66AjxaQEEeTXP2HWvETyMvwdJ4HwvQHWK
 RK7gtO8Kh5pvgPmCb8awPkGFaSxvo68J4XCoR0anQTlPkTlLGvLfg>
X-ME-Received: <xmr:AUMTaa3sDUlTLnvnRpuzFRK5rIOoxweGW0SVZg2G--Hl8H2nem1m97G41X_NOPahoGqOfw2aM7dngf473oF2-t_x5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddufeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehmsgesshhmrghrthhshhgrrhgvshihshhtvghmshdrtghomhdprhgtphhtthhope
 gtrhhishhtihgrnhdrughumhhithhrvghstghusehinhhtvghlrdgtohhmpdhrtghpthht
 oheprhhorhgvthiilhgrsehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghpth
 htohepkhhonhhsthgrnhhtihhnrdgrnhgrnhihvghvsehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:AUMTaWaj-rZ4bec2v8bvUWUuDvHGoGLap5L24pfBInyfpRBD3fLc6g>
 <xmx:AUMTaaIFA5TXcMLj6jmgjrwcMr8BhaFv-KMQUk6bYz6_Ac05l4wvFw>
 <xmx:AUMTadEQ4fjx6L5YwNQPeBysEdkhq3z_-EJ2UWeDRqgpgtiibAwfcw>
 <xmx:AUMTaZtlpPl2nKfxzW6qw-m2bE4NyfGRHqcCJjaBc-xKo-lrJAFZwQ>
 <xmx:AkMTaTL67MVy0Wb2JBYXamh2DpcsW6c4huMs2GGUtIDv1EXVru2lok7N>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 09:06:56 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH v2] bitmap: change return value of rte_bitmap_free
Date: Tue, 11 Nov 2025 15:06:55 +0100
Message-ID: <41535164.1ZeJGzUXcx@thomas>
In-Reply-To: <cc6a7dece31f4769b6ad0c1038d35434@huawei.com>
References: <20251028204432.880074-1-stephen@networkplumber.org>
 <20251029145055.990899-1-stephen@networkplumber.org>
 <cc6a7dece31f4769b6ad0c1038d35434@huawei.com>
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

> > No existing code is checking the return value of rte_bitmap_free
> > and other functions like rte_free do not return an int.
> > Change it to just a stub void function.
> >=20
> > This was motivated by Coverity warnings about unchecked return
> > value.
> >=20
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > Reviewed-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

Applied, thanks.


