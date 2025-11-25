Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676AFCFD36B
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 00:19:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E42840687;
	Tue, 25 Nov 2025 01:19:40 +0100 (CET)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id D1DD9402A1
 for <dev@dpdk.org>; Tue, 25 Nov 2025 01:19:39 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 4F31C14002AB;
 Mon, 24 Nov 2025 19:19:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Mon, 24 Nov 2025 19:19:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1764029979;
 x=1764116379; bh=JgrWc4tPN1GDlw6OcBYzTdLzTwHaOiiynlto2XpSopU=; b=
 EVdkwUjR/q246xTmzI7qqaIpQ0cjJzBlGRFr/cTNOCElE+smfswLsKuI/uUiuRBO
 Hu6/3JgT0812s+aJ/Iq4zJLkFml/YPy/MC5bSyREcJXN5PPWt/gEw95Ru7NcQVOL
 3dCDh1VStyjLOayjRsF661pyaUxePavz2j/Dh49j8O3RmFHDf3dHfTAAjQtkZgec
 0hpFeZ0e6lxjzLEqJV1qs84yRyshQ3XiUR2hpYl6V7hKie+UlGzZhqumHHVaIeRN
 OEYvHIF/1vIs5ooj5ReZywYJA2VoDgefRn1e+hPwKNgyMnaRSQkAHTgi+eYMvhIG
 nYKC68rV0EurT5LjaJYIrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1764029979; x=
 1764116379; bh=JgrWc4tPN1GDlw6OcBYzTdLzTwHaOiiynlto2XpSopU=; b=W
 M+vy9LkJ/f6olTm6qzkrW/tMBMu0HsYQtWPgTZi/iIs4PsLhu313oPDNHDjTQmjG
 7Or98sJhs5vIo33GngQ1XWqkElWqK7A96CKOIA3qo1bgzFEI7kPleIRnXF7Lc+PR
 WUROwRLVHlQkKMPuu6ut+Gb62o1OS7/ql+Eiq+BFAByF9Y4lmIJgcT7QTC2O5rUc
 bdN9P4N3XAFHAOGbvorUVDdtwnnmOS0ryHSHTML3VAtRgS++s+eCst/lxyexkfnd
 yPuL6Z2KAqbaGp1er1ZfK5DscHmxA05bufuTn/OiJ4VDHkme/jruap3yPB6hTEBn
 3pja0N4PQFrkP/Fvjntug==
X-ME-Sender: <xms:GvYkaYWwqnEV4Xij-3SWfH3ReEBxxUArXzrQJsQAuMk-i8l7IpBM5A>
 <xme:GvYkaYD0dh_4DzNroNzMuNIOdK-7O916pnH49wc2CKIyU24d5gNLoPnsqYIcea5Yv
 Qg1dCf46omgBsZuLHYguoiMdffvQApfsiVjdcaAhmZmhIIluAWBIQ>
X-ME-Received: <xmr:GvYkaf4tPDMbUwg_nEdNuMb3zycJAYiM8EYFp3I_wN1rzi8GJALLIZtK4r_8v4koDSJg1zpWpY8bvHytgd0uQKzhUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedttddvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehvihhpihhnrdhvrghrghhhvghsvgesrg
 hmugdrtghomhdprhgtphhtthhopehjohhhnhdrmhgtnhgrmhgrrhgrsehinhhtvghlrdgt
 ohhmpdhrtghpthhtohepuggrvhhiugdrmhgrrhgthhgrnhgusehrvgguhhgrthdrtghomh
 dprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehthhhihigrghgr
 rhgrjhgrnhdrphesrghmugdrtghomh
X-ME-Proxy: <xmx:GvYkabyvRqcweP6UBlfsVjB-EYn_mrFz6w8W2OJVvXbh3gOXEgT11g>
 <xmx:GvYkaexNXmd-tgIx5FdExQibj2lY3j9qlid8OEjzCFpospRG4ZHC7g>
 <xmx:GvYkabxfWsD_rSxKN0dqHF8en8RoLJSMlCc68HAEM3zTTwTh9LYOSg>
 <xmx:GvYkaQZo45Z4e9fK-gGZV-oGNJ-x_C9ddOZhpHJ2pmaCe4sNzMWUYg>
 <xmx:G_YkaciaI5S6goCqWkphnd-VQ6A21ep75OOh82enXhKW_SgfUpNGmPrR>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Nov 2025 19:19:37 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Vipin Varghese <vipin.varghese@amd.com>
Cc: john.mcnamara@intel.com, david.marchand@redhat.com, dev@dpdk.org,
 Thiyagarajan P <Thiyagarajan.P@amd.com>
Subject: Re: [PATCH] doc: update AMD EPYC guide
Date: Tue, 25 Nov 2025 01:19:36 +0100
Message-ID: <7733642.G0QQBjFxQf@thomas>
In-Reply-To: <20250922070016.1066-1-vipin.varghese@amd.com>
References: <20250922070016.1066-1-vipin.varghese@amd.com>
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

22/09/2025 09:00, Vipin Varghese:
> changes:
> 
>  1. fix spelling from `SIENNA` to `SIENA`
>  2. add tuning guide for zen5 AMD Epyc 9005
>  3. add uncore power details
>  4. update on using AMD Solarflare X4 and X2
> 
> Signed-off-by: Vipin Varghese <vipin.varghese@amd.com>
> Tested-by: Thiyagarajan P <Thiyagarajan.P@amd.com>

Applied, thanks.


