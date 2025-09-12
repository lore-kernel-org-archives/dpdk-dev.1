Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0794ECA101F
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Sep 2025 09:32:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C92A4065F;
	Fri, 12 Sep 2025 11:32:08 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id 370C9402CC;
 Fri, 12 Sep 2025 11:32:07 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.stl.internal (Postfix) with ESMTP id 545411D0039B;
 Fri, 12 Sep 2025 05:32:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Fri, 12 Sep 2025 05:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1757669526;
 x=1757755926; bh=z58u8LoKmQFpQ4IyuQGz5GMlrgmQxPgksGj1+LBpWdc=; b=
 gwibmi/wHfau7mWMZvegk9RuyzBJb3LyMn/fMdPVDKC8Os2un878/ZtQndogoX34
 ztJBDx8T9MKR9hxvf3adWy1JVaKSZb1MaVOaxn2eIzx9jkctGnIAGuh+gautEHp5
 LAkH0CkUFgrfFRUFR1HVyZFMR6Ius21nYjSZ8I/JixaWYucbDMB+oy+J39SHxuWM
 SfzgfKcwhqyQw0/ZhQOJrVxHjKUx0o5xLIUoZ0bI/O+2M7cyi0Kk53OINgWMYASe
 CxZGhuSqtVrZhHawlAe26kdKaYX0X8HB/zPNy81N0+Rv8Ltb6ewVeh/+SKkdXl02
 h60ICUagPBLo0zNwYIxQXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757669526; x=
 1757755926; bh=z58u8LoKmQFpQ4IyuQGz5GMlrgmQxPgksGj1+LBpWdc=; b=i
 sQexn4rUhwyQsSn99RQlL5NAC7iY81a2McKQXxjv0Orj2HRpAmDj4ZvzAH3IRaNL
 O5Z7OslZJQ7A6lAFWEg2zrPp3g4+PXHXTSab+S3qBMsvZpZFVgycuO+DFick7m3p
 B5LnAciab8YxzPh4RmzbuFVmitYoM3+kF3uSqCel/IwX4Vs7YJ5TAYEqx1zfqQpl
 I7kve3lYZzy8RZbMeEkaWunAPUbaGS5dBnLBBmjgZ39OxWzSSVZnPUirplpmCx6U
 Py7DbEugFLzZ7jCPWkJr1g+mK1zs9Dbcao+YbrVBXaB9dARNWpP9qsz9PnFAbek1
 QgEeef8yaNca+mk/NJX4g==
X-ME-Sender: <xms:lejDaIXSxE27O9dfPDsl_EH06bpFSaFZCBvj2ThegJAI9RvGkCWVIQ>
 <xme:lejDaKhoxrCdsdHrddR0YKf2DYeFVVI3bWjO0uZnTw1DqAOwZmyREmBFpn2bxv2Q_
 GHwTis410QoQwTaww>
X-ME-Received: <xmr:lejDaOvA0qiaV6h9gXKLmYhZJWd6oybV5vLrjlHmPW4XxKAHx83_5LmyECX_IsiDaMVxWSDgHpmyT-wETNXx6BGX1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvkeejtdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepiedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgvrhgvmhdrrghkshhusehivdhiqdhshi
 hsthgvmhhsrdgtohhmpdhrtghpthhtoheplhhinhhvihhllhgvsehtuhigughrihhvvghr
 rdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtoheptghifi
 hilhhlihgrsegsrhhotggruggvrdgtohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgv
 thifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepshhtrggslhgvseguphgukh
 drohhrgh
X-ME-Proxy: <xmx:lejDaL6gdiZVkoE6KHC0mN5FSayhyqFud21JJjGp4oYFtVSc-WroRg>
 <xmx:lejDaKOUAsyDDq-LVtP9cZ7j4TlRPyeUb0s5YiflutaT9vmyyGcTMQ>
 <xmx:lejDaJuKXfVu2X1-nQK6yHDfj4upAHnTXhuLTPmwNiEUoCaXDSUzoQ>
 <xmx:lejDaNZkb0MMMftCZCjjhVUspXG1dZ3mHnM4xjotmZzYBlXe8WE8zA>
 <xmx:lujDaGIEqGWobbRvsStiN_VjV-lbjofOpwgHBkQ-SSS8guNx3YFJJS9Q>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Sep 2025 05:32:04 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Kerem Aksu <kerem.aksu@i2i-systems.com>
Cc: linville@tuxdriver.com, dev@dpdk.org, ciwillia@brocade.com,
 stephen@networkplumber.org, stable@dpdk.org
Subject: Re: [PATCH] net/af_packet: fix crash in secondary process
Date: Fri, 12 Sep 2025 11:32:02 +0200
Message-ID: <3299441.5fSG56mABF@thomas>
In-Reply-To: <20250912084758.354208-1-kerem.aksu@i2i-systems.com>
References: <20250912084758.354208-1-kerem.aksu@i2i-systems.com>
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

12/09/2025 10:47, Kerem Aksu:
> dumpcap crashes when trying to capture from af_packet devices. This is
> caused by allocating interface name with
> strdup (i.e. malloc). Interface name is not accessible from secondary
> process and causes segmentation fault. Use rte_malloc instead of
> strdup to fix the issue.

I agree with the analysis, thank you.

[...]
> -	(*internals)->if_name = strdup(pair->value);
> +	(*internals)->if_name = rte_zmalloc_socket(name, ifnamelen + 1,
> +									0, numa_node);

Probably no need to go on the next line, you are allowed to go to 100 characters per line.
If a second line is needed, only 2 tabs are required.

Why zmalloc? Probably no need to zero it.

>  	if ((*internals)->if_name == NULL)
>  		goto free_internals;
> +	memcpy((*internals)->if_name, pair->value, ifnamelen);
> +	(*internals)->if_name[ifnamelen] = '\0';

We can use a string-specialized function, like strlcpy.


