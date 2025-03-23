Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B88C28B30
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Mar 2025 16:36:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4ECFC40277;
	Sun, 23 Mar 2025 17:36:39 +0100 (CET)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id 1002E40150
 for <dev@dpdk.org>; Sun, 23 Mar 2025 17:36:38 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 351BE1140069;
 Sun, 23 Mar 2025 12:36:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Sun, 23 Mar 2025 12:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1742747797;
 x=1742834197; bh=33oOh4W1BfflLUnCN9QIXHgGajDOcIuUZRge6bA3eXI=; b=
 Pzg44Rd+VcNok2Ok6dyTggU3QiOr87ixc1iFPHKbPVjTBXjsFDzhC+sIrYzqpQD3
 1Cfp6hSFQHY5t9Jk1UhFergPWuU23MDCuseuiZIQDsy7ntmMrSYxDVyDrU6Y0ETr
 yqZEf7U0+Pg6Mw9n7K7miab7b9jSW2/CkqHpNZkZD2/f8F9/XxzQtgaloB7KNvbk
 Eydl12acQz4+6fVqn+naSRzWJU2HeY3jk05ifcjJGNrvuHcNeJNcRzIeQn6MdocC
 R/7q6zj7Uvoilqw40j2KsUCEzQ9nFl0tyuviRa15kB8rU9hiZj/Hc1+SLucyBtxC
 3u9igOj8APKb3X7RXptU1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742747797; x=
 1742834197; bh=33oOh4W1BfflLUnCN9QIXHgGajDOcIuUZRge6bA3eXI=; b=M
 TJgBMy3AHbBotokxC0FzA13rod/CpcVouJonJR3pzgELTXanQ221m/5T9/x0VKw+
 KGeMs8h49C+eCvqynM7r1hAwWji0UKLGh/WN+1q0OWQLRmvZdS58eocIPYXtaszv
 ElF8NsIGRlL4qhdozxbJzX1j1OAQa5yH2f3Wt0vDax4VH4aJQEhdOqiy64zFaAML
 +qabUuhMC1FLoPK8Nzapm8lZcp3Wcs6z85pi1eOmOgH+T5QvH10mYlkVcfr1bwot
 /FJDAvOKvQ6FzSrBaauXF2MBbsTkNS+Pv+YhmALMWwzCzxbLaX/eiczVFiHJyX8+
 o0SpaVuiLLy+TC6hKFSoQ==
X-ME-Sender: <xms:lDjgZ1P_9TP6Bwe50962XyUFe6_LR3aTDpPhAqx6um1SK-giWjdcmg>
 <xme:lDjgZ39knMXXw9LUcqyDNuLvGmpvFEU875O50XvHd05Q1D5Q89y4zUbQOi0mm9PRY
 j6smkq7olkX1e6NMw>
X-ME-Received: <xmr:lDjgZ0Q8VWTvjkHR8VxRC5KgahWVBacicJrbduWjc_9yCwYr64UAYZU5Bp7NTQfYIrChrhFjB81fuVsIrg8wv6Q7hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheejfeejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrg
 hslhgrnhgusehnvhhiughirgdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhr
 gh
X-ME-Proxy: <xmx:lDjgZxstAxiA7qheL4HWCv5Ak1XkrYqre79QvcoA1jtk9kpkC4wtlg>
 <xmx:lDjgZ9c6CE9ax4lSWvQDCD3x96Jy_T-5neU59On-0MYZh612iDXr6A>
 <xmx:lDjgZ93TeDzKbJ466CLaz-zxIkQVCanHuKhoNX8QC1W1xOKI2LpulA>
 <xmx:lDjgZ59UJLZneZUD7onr-iFsj_3zge6GriYcq9HxPco5e3nfszrVXQ>
 <xmx:lTjgZ-oreRMbk0cE_9MHQwJi8arqfi6T_MTLEOx2DFJP34AgJTJfoNaD>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Mar 2025 12:36:36 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Raslan Darawsheh <rasland@nvidia.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] doc/bluefield: add comparison between BlueField versions
Date: Sun, 23 Mar 2025 17:36:35 +0100
Message-ID: <11000977.NyiUUSuA9g@thomas>
In-Reply-To: <20250319121359.32365-1-rasland@nvidia.com>
References: <20250319121359.32365-1-rasland@nvidia.com>
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

19/03/2025 13:13, Raslan Darawsheh:
> Updated BlueField-3 documentation to include a detailed comparison
> with BlueField-2 and added notes on compiler requirements.
> 
> Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>

Applied, thanks.



