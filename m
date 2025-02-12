Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6F9C021A4
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 16:02:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64F8542707;
	Wed, 12 Feb 2025 17:02:28 +0100 (CET)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id 3544C4114B
 for <dev@dpdk.org>; Wed, 12 Feb 2025 17:02:26 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id C49E411400B9;
 Wed, 12 Feb 2025 11:02:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 12 Feb 2025 11:02:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1739376145;
 x=1739462545; bh=OcW5rKp1B5KbDwkQe2lmx895FG+CSk1zhXOzymRrn0k=; b=
 JoLZRuv138qkSUBCDi3FAj1m60z05pRNRfe73XabguAZ5mkmF+jxDnrgXQxbwoiR
 JaMqlneeMfUeNJTYToQIFkzGy0cDeUDDxL8/h6SK3Ig1vN8Hyf6peR0q5exZRQez
 HExqr1VQTMDAA+oNdBdA7DlLc8QDaVGslmv+aVCTgYOODxcu3NDwsv/4Qlh0V4Fz
 j2x45RnDGUWmhrg9ScFEGTwLnJYNfJejvfKGhlyEufDwLQ/myM2GGgneDMYbK/Nz
 JMVFoQTQ0+v6ZA5Rq3gniX/mmgHh03KUaAX3LEXw4x7k1USMPKC0Ih9fNyzVu6aY
 JGOomKPBxQ2QRblYpWV7qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739376145; x=
 1739462545; bh=OcW5rKp1B5KbDwkQe2lmx895FG+CSk1zhXOzymRrn0k=; b=b
 ZKe6NnuN5hDJjJ4IEM5s7Rryj6VMXOogHOtmvJxdPRsT2yHdNjr3cbdTl7ia3DNP
 LqNYirTvZ+8ogcyj1R+WULbzZRWXqG1gp9Y64k7kUqAXIW0v3KVBzJLRowfFoWze
 jSbkImvhtBtbSBPqXCb2aym9tJT4rK8rr7/ywZosVWi3vL/7XSRUDSjA9mW9gho9
 bIpFFXdxZKJk/Z835Lzfz4pOlttWNM3Y3y0rm0rmlemPq86BDbkEQjIKJy7cXDw4
 OlLK368jeboaeaUsrWWMvYUc6w3/uR4engtHb3naMZWraQtto/moxJDbpic4aBrB
 aYbeFbv1BeSxuclzpJrSg==
X-ME-Sender: <xms:EcasZ6sgj7Ccfnl3vvhGBEnbnEfZMDsZFftdM-7x0WEkWl053F1oRQ>
 <xme:EcasZ_em5HMd2YwKyZkW45z09AMji4WWoTPzqMOpNWHJWwRx0ElDDOaqAP9T52gYu
 8a3wDKIlaREoI_sIA>
X-ME-Received: <xmr:EcasZ1xZcduy1t_YDGfrVnWNlyRCHWzvGQf0kTuRfHNMngfdPzAkyv9kCgoli9gKlLSyd4F7UbeONBNQ8sVd4a8l6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggeefudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvg
 hphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhg
X-ME-Proxy: <xmx:EcasZ1MgP7NktY4DBOviqw9k5l-FVmVTJRkQ87IkuomRSrEHOGP-yA>
 <xmx:EcasZ68ZswuCQuxM58l3Mz0be0ybueBEc2YQitmM_paq88De7cMKiQ>
 <xmx:EcasZ9XFj9R_Z5khPb2G-Y8Z0FfcD26Xrwkp1G9A7QbxXy4ISIZoUQ>
 <xmx:EcasZzcr7jWF4ygPIMDfzdOkkT_q6yYd_crwgNia-j58wAO2WYQvDQ>
 <xmx:EcasZ8INIOMa1g4BiDoxchUZtKKOurqLf_iEb-RwGW7XZyISPKuEkOO3>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 11:02:25 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH] doc: add release not for af_packet
Date: Wed, 12 Feb 2025 17:02:23 +0100
Message-ID: <6062138.uKWtJMOXK1@thomas>
In-Reply-To: <20250122155653.82860-1-stephen@networkplumber.org>
References: <20250122072845.714800-1-stefan.laesser@omicronenergy.com>
 <20250122155653.82860-1-stephen@networkplumber.org>
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

22/01/2025 16:56, Stephen Hemminger:
> +* **Enhancements to af_packet net driver.**
> +
> +  Added ability to option to configure receive packet fanout mode.
> +  Improved statistics including failed receive buffer allocation
> +  and missed packets.

Was squashed in relevant commits, thanks.


