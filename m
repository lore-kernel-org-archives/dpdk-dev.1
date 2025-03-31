Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB294C3600C
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 08:45:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F1ED40156;
	Mon, 31 Mar 2025 10:45:10 +0200 (CEST)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mails.dpdk.org (Postfix) with ESMTP id 39F8740150
 for <dev@dpdk.org>; Mon, 31 Mar 2025 10:45:09 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 694BD2540139;
 Mon, 31 Mar 2025 04:45:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 31 Mar 2025 04:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1743410708;
 x=1743497108; bh=ll7vOm4Zrh6zij45nvOatKqhsYT4vMAUPIp4tGNzlLM=; b=
 UfGVQMMIMooFwrjB5Y4raxFPOEUqfbcA+Nt+cQvumaFrpvgJTcc+XgX15MQPLX/H
 4TFsxCRHPUM1cAFgQ9jI3cJb8Ld0ntntw+AtrsNc1DB7N0Komer2hDMo/sKGnEik
 IN0VzCZOo+eZEf+NMP0xOI3KOmfLYfLP+Qf+CpI66vTs35aqTPfLIQdnNdWr9jpM
 JG7x+P2ohCs1cNTTCEjk+0j6SMObUSrm6TpW2S3scFABIw9RKiwXmKVlLgQQywax
 p/F1u3xahSRcq8c5yoRDJ+99RUDKMl/6m+miv14bIbRQMHusPY30oMuq+qCqpn8k
 x/CgzUhuVDEVr/i0owu+Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743410708; x=
 1743497108; bh=ll7vOm4Zrh6zij45nvOatKqhsYT4vMAUPIp4tGNzlLM=; b=P
 hAVZyKfzRaf2vce0Lq5HxTQ6w748KwZWkQiEYOY/l/cyvpC0p3w9ZV9m+nSbZPSJ
 aoeUiLNuhtnXt/SZ4oCFExCiDHo3gSOkxPRs9aFtFlzV6098jtZhfygc8zA5kPPw
 gopXc52CzslSwGSylPJFYEK3PoER5olYsYkpXe6TMydOC3R3hk58/tPJxqk2qTYm
 cqf/o99dY5EWVjBNFugB+ueODEZ4BBV39pv6cn6/qTf5RCQUD8vAf+IRwg8MQq9d
 8nl53aZ86/JpWKnwI3lV0sEgRqhgTWG8x/pf8yj1nRJtE6j+A8bYS+6dtcZTg2SC
 AY1eh4tqdLGcpotZyZOhA==
X-ME-Sender: <xms:E1bqZx4docWpxEquimQpg0FbIZl2PqUh8dg0eaZmmQOS3qcCPahZIQ>
 <xme:E1bqZ-51YAlmBtt02iwOUC36hCcBSVpKNTh3UkVET_odaxztHBHRg8TLssFt_cOfx
 _eCvD0j-PEyZVYuVA>
X-ME-Received: <xmr:E1bqZ4dizroncFB2AVEHqVtTIkW0L9nOcbi5U0A3LZOJtuPbWag40RD-jfHC53sRHn8Igy2smyAZQCUZwZWFL4UeLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelgeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtrg
 hniigvvghlrghhmhgvugejudefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepohhrihhk
 rgesnhhvihguihgrrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtg
 hpthhtohepshhhphgvrhgvthiisehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:FFbqZ6KpvCHk7UZ-uc-0g2WxWU6o2TyK_1PYTEVOtNGKlw838AGQ-w>
 <xmx:FFbqZ1KKV_e_U0-n6MwhUbJD1GZTb1B4UDysKz2P2suP2zE-j3hP-g>
 <xmx:FFbqZzwtChfRKxpdLy61u6XrN3hmWfN9UvVkE7ZxxIyLyATtNEohjw>
 <xmx:FFbqZxK85iFZqpasJd26a7iKoHeObFccufCEWNrqv0ZimygX_s8yog>
 <xmx:FFbqZyH7GF-EluvXmzvyuE5h3czoo0TfGBC3SYtrQm9y27LvkRwQ6yQW>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Mar 2025 04:45:07 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Tanzeel Ahmed <tanzeelahmed713@gmail.com>
Cc: orika@nvidia.com, dev@dpdk.org, Shani Peretz <shperetz@nvidia.com>
Subject: Re: [PATCH] examples/flow_filtering: fix make clean
Date: Mon, 31 Mar 2025 10:45:05 +0200
Message-ID: <5791577.oiGErgHkdL@thomas>
In-Reply-To: <20250329195333.324178-1-tanzeelahmed713@gmail.com>
References: <20250329195333.324178-1-tanzeelahmed713@gmail.com>
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

29/03/2025 20:53, Tanzeel Ahmed:
> make clean is unable to delete build directory
> because *.o files are not removed.
> 
> The other way to fix this would be to add all the
> c files into SRCS-y.

How adding all C files into SRCS-y would help?


