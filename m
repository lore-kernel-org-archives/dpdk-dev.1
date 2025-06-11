Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8721BC677C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 12:33:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2B0A4066F;
	Wed, 11 Jun 2025 14:33:31 +0200 (CEST)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTP id 3851B402EF
 for <dev@dpdk.org>; Wed, 11 Jun 2025 14:33:30 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 9F6DA138055B;
 Wed, 11 Jun 2025 08:33:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 11 Jun 2025 08:33:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749645209;
 x=1749731609; bh=tkXmlmGGRS2hDger7zUGIMViYLbV+maQ6srTat3+p5E=; b=
 dkRTN8d8UxsaMCYfvn8GYz6sTJLGt2AZdo84Yrux2VtHtzSN1OCV0Lq22+B2Pg5q
 bQovSllVi9Edp3Hb9ugRW/OQDeBsqr7j4+hBDpgueQ0rph6MIV8cMLIwrhbV/U7K
 Y4WmN7rwgZbjdBCJAqCrHgRJorgzvKY5GNAQ/05l7FrXOXFcT6zwwSMklebqohwX
 CC0p8A5+Y2IMnlTRTeOfDA7qo2qCFJxDunJOYXueQwoKIgqzQqbxy4LhHYqyWwcA
 +EiQsU6KM/KKIjDiTUitWkx8a01r9sxxvJb04n80uUlqE2VZ5avKvk1EE8R3Awb4
 GWRHYStRQJrK4vg8QDTV3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749645209; x=
 1749731609; bh=tkXmlmGGRS2hDger7zUGIMViYLbV+maQ6srTat3+p5E=; b=M
 Jm/6oOKLiZ6a/w4N9qF3/vwt7hitiNTkusEUdOqAjmv5/xy10RSR8ci96zIqIjrJ
 ECBx3CkvMU0GVhd13paZ6YNvOMJXRsk5Rqngf/EKxP9z8eFKzrsKa5MB5kfMC7Pp
 KldJUoXOrhf8myI8LIcOzFTW88jjQKNnrywwKLLpRQopAQvVtdxm61e6z4OP1lTV
 8jDrgdotm8fchTYDtT56YOAiMkOCdfKuAx2fHLl0wmq+TFx5AZWHLIM6JMNFQus7
 ONrJ3t+pxC6WoVxzR9f4jH4/ZP3Mf2VBNR6BygTv1eq1DdvF5CT/2DwouhhFxS3i
 Oa6j1yn7BZJ6G4E+rOsQQ==
X-ME-Sender: <xms:mXdJaP_9zllb2ydmzzOxpYELLIxRyBOt5xIkhIILLWyykCv4C6qtnw>
 <xme:mXdJaLtbX8ZY9-rqF_NPBzYj2AKDQjj-2J65y1GL0KhjJAZI0RiJSvZn5MtbVI2M8
 A_Wo0_KaLWlh35tKw>
X-ME-Received: <xmr:mXdJaNBoyNRgyqo30JHXymF6KyzGdyqug0-DITboDdo9TidNQkrI0OR8Njff_drOViASI6Dbs3GZgEIYjsGJnCINCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvddvtdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:mXdJaLfsIuwyfkETP7mqhuJsdYQhNLtsatohnyws_PL0U0cPZQeJ_A>
 <xmx:mXdJaEP4ghLaw8pdYfSis8aUw2TwtExx7Ml5OG4mtnhuhAFEkLqFwQ>
 <xmx:mXdJaNmCegUbDGJy8a1uIP1Y1EM2ZoKwXNvS7f2NGHlCSFEcMa9bzQ>
 <xmx:mXdJaOs9YqcUmwB0KxNzUVqfIzEiDasTvnBgxLBjrHC6_NidbxnFjw>
 <xmx:mXdJaASnmVzpMKrZ9N2QspW1vW2EDz7r9_egZxYUaaNAsdRCQTWw-fJi>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 08:33:28 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v9 02/15] app/test: remove unused variable
Date: Wed, 11 Jun 2025 14:33:26 +0200
Message-ID: <5408326.KgjxqYA5nG@thomas>
In-Reply-To: <20250220164151.9606-3-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250220164151.9606-1-stephen@networkplumber.org>
 <20250220164151.9606-3-stephen@networkplumber.org>
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

20/02/2025 17:27, Stephen Hemminger:
> The buffer tmp is set but never used. This leads to warning
> since the memset could be eliminated by the compiler.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/test_cmdline_cirbuf.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/app/test/test_cmdline_cirbuf.c b/app/test/test_cmdline_cirbuf.c
> index 8ac326cb02..f6361d49e9 100644
> --- a/app/test/test_cmdline_cirbuf.c
> +++ b/app/test/test_cmdline_cirbuf.c
> @@ -251,11 +251,9 @@ test_cirbuf_string_add_del_reverse(void)
>  {
>  	struct cirbuf cb;
>  	char buf[CMDLINE_TEST_BUFSIZE];
> -	char tmp[CMDLINE_TEST_BUFSIZE];
>  
>  	/* initialize buffers */
>  	memset(buf, 0, sizeof(buf));
> -	memset(tmp, 0, sizeof(tmp));

Another memset was missed in this function.
Fixed while merging.


