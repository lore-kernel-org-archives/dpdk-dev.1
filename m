Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F988FD8777
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 13:57:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FC0A402B0;
	Tue, 17 Mar 2026 14:57:17 +0100 (CET)
Received: from fout-b3-smtp.messagingengine.com
 (fout-b3-smtp.messagingengine.com [202.12.124.146])
 by mails.dpdk.org (Postfix) with ESMTP id 8D01F40270;
 Tue, 17 Mar 2026 14:57:16 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 96C001D001EF;
 Tue, 17 Mar 2026 09:57:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 17 Mar 2026 09:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773755835;
 x=1773842235; bh=i5LjjVNTpHQIPy7oqlub4pUhp58Hf7YGHBhn5j4jUpg=; b=
 GJbkODbbCrL2feJHyBpAfVFps2FklgHbMWVWvt7exzE3aPlaI5WKvCQCoCKzRAS/
 iH4HxaZ9j2QHYKd5R1YfDkHK7Pcij5UvPED4FKrfPOpRPd1WqA2PSVhedWOhfVLP
 0IvjcmOWpU1aeWJ607VEqEixlk6W8hg+Ytv26ocHMn1DYkTthKqm3kaeZjzHNBZv
 D/5tna5et412IYW6OC0JUxmXpx8d14tY6qvvRRqOAcfGxu6U2m7xUDuTBLqNnhQj
 s+iJ97I8uA4jNrDDTV6IWuwhDBPRl/JaNmJ/35ZKsA0ngd/oTxznZ5gkIEgaTotI
 PYPGuWlAnV1Z1iE+Cw9vaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773755835; x=
 1773842235; bh=i5LjjVNTpHQIPy7oqlub4pUhp58Hf7YGHBhn5j4jUpg=; b=M
 KIE54fIr6SUDbEGNAGNxdP6E9trzPS6/gfbYo8K/Fke9bdroDz471ZUZHnWyjsp/
 j+xRzd21Qe5TKrXjbvVfWEVbIVTqy5wHeLLxG1YS/6oWs+48Qx04KK+JVPH37tvA
 bevAjYSyWUWHfifoSrnfPEUOgsywY3JDMUngZxTijW2Xj6kChpWf+Mt8QBBROluj
 6AL9fRxCHha0ji3y0+Nw1b1kdlrWQqGTFebL5OQNKlaAs7J29it2LxgMSQu7C4vj
 JNLC8sIlvozWcXi9RYHeyXfP4IuytfN394A1rlRBDajfjHOF+wvUQL5sqc1y5EiD
 K/GSBUWPj1FF0QBPDSUvA==
X-ME-Sender: <xms:u125aXto2s7zstzS_bn5tfbkBx2vX6v9oMHDyJNG0dI5WKmuZQCbpg>
 <xme:u125aT5M15avHI8Vcx5-Db2_Bqd2RXlqqrCah9prsETdfbmPqu3a1NN0D1V__6zOP
 SLLjDLUM_HUktGkScvU90JAlxB3EScJuy16OGDaCKHw9v3_39_GZGY>
X-ME-Received: <xmr:u125aeQ9Pj03aIAZDASwLYUZT6WWq3TRuJ67QhmsK1heURVSqnMrntW6AlruZnez5IzskokXeyaYRMaYdb_eL9pmAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddugeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehthhhivghrrhihrdhhvghrsggvlhhothesieifihhnugdrtghomhdprhgtphhtth
 hopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtoheprhhjrghrrhihsehrvggu
 hhgrthdrtghomh
X-ME-Proxy: <xmx:u125aaoYeOAnY06GlJNKfJ8bQ6Zmkf6GsH2QUKdv0ZvLJbEzHSi6Bw>
 <xmx:u125aULPFUW7MfCPw1A9j6HiRjD-abyJ1gL8zxbBXWatMqmfXj7ADA>
 <xmx:u125aVq199QDFadMx-c9xRi5Tdx9Rs7mdcMIk9STFPYjS5h3iY2K-w>
 <xmx:u125aUzQdKrgLJI7Koyusv-N2TrhNyO3vZwJ1E5mRB0brcFJL6sz_Q>
 <xmx:u125abz-hr6YxgfGT51pj7F8QAdTfjkzeVnoW70FHbaW_m3P2qiiG15d>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 09:57:14 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, thierry.herbelot@6wind.com, stable@dpdk.org,
 Robin Jarry <rjarry@redhat.com>
Subject: Re: [PATCH] usertools/pmdinfo: fix search for PMD info string
Date: Tue, 17 Mar 2026 14:57:12 +0100
Message-ID: <1996966.6tgchFWduM@thomas>
In-Reply-To: <DGHZMMMMIQHE.2D7VL676OEQST@redhat.com>
References: <20260123162104.1854187-1-thierry.herbelot@6wind.com>
 <20260217124844.1458644-1-bruce.richardson@intel.com>
 <DGHZMMMMIQHE.2D7VL676OEQST@redhat.com>
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

18/02/2026 10:41, Robin Jarry:
> Bruce Richardson, Feb 17, 2026 at 13:48:
> > The PMD_INFO_STRING constant string is not guaranteed to appear in the
> > output binary immediately after an unprintable character. Because of
> > this, in some cases the information for a driver could be missed by the
> > PMD info script as it only checks for the prefix at the start of strings
> > that it finds. Change the script to use "s.find()" rather than
> > "s.startswith()" to fix this issue.
> >
> > Fixes: 0ce3cf4afd04 ("usertools/pmdinfo: rewrite simpler script")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Nice find. Thanks Bruce.
> 
> Acked-by: Robin Jarry <rjarry@redhat.com>

Applied, thanks.



