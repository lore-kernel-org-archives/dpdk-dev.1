Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E471C5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 07:29:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1138402D4;
	Tue, 10 Jun 2025 09:29:30 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id 1752540299;
 Tue, 10 Jun 2025 09:29:29 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 440802540172;
 Tue, 10 Jun 2025 03:29:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Tue, 10 Jun 2025 03:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749540568;
 x=1749626968; bh=GkobRODaNru8uPR+3yQFiAN4pe/2l3KbpYeLOaYlEsY=; b=
 K8fnvKUaJNoF0MxqyhD6fsltyZRKK5fIHTKEcUr29e7FYjVLk2WbjH0AcFoN+SMi
 WwfbCMczwy24zQKSG72ilqMyBH8o3c71H2u0HrtlsMrmVbf5p45qGhZiG01r2YcA
 5OdIqhuR29GbWbe5WHqo/eESYRYk71lUHMLl7a/UlKmcxELqvVm9yVtZ/cqF3DBF
 h2wpLm41758QG7PhgRrWLuAQHLGWp20PNcH21wga8Cx5QZ2lQWGFCVE3mQPKXkTr
 OTNZScegZcLq1sNQ8+oVCd1LDo7OoOKGV0H7OcypcK8xpHfxYUVEEXpY3ehjMmwL
 rF0QTDYO7RPcX0/TM0UpIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749540568; x=
 1749626968; bh=GkobRODaNru8uPR+3yQFiAN4pe/2l3KbpYeLOaYlEsY=; b=l
 Kfxpc9hSnMjHxHhLvv23WbgGOVFp4+AzkJlhoNHo1iz9kJ4xWJZCNkabAbEb/65i
 CeE+ANT6LY2PxBU8r1PhvMqUH0kj+kUeZnW0UMjPhukEpldOHAC2jxcJhJ7EOau+
 geF30KaX6yzy7vg2umBb/lZQoraVX/jH+9Kv+N2jJr+ekGkmkS3bwJktl4gFfbiE
 bYOGZfyWbZ9oTElY2duJy97goYSDIPgTHzoZGGJST4onJjbpB2f/P2ESox8r1dqk
 6OhP79NQvnB7jQkRqpmOE50R3LYcwCzld3asplEFTVz04n3sVfgKIi5MkWDJ4RVy
 MtkJhrMCpVG/BPnx1hAZA==
X-ME-Sender: <xms:195HaBnidB3TrB2wkzOgPXxkkK1SJ23bHGw2hDZ4_p0xnYJzeKh3yQ>
 <xme:195HaM3W6PL76ClJo85ylNreX2thWvchwrAQR4EsxkyFD1Z5Uf9LOdZ1Yyp_Ciu6z
 XPNBGK2PYDwd1Jguw>
X-ME-Received: <xmr:195HaHr7e2ACL0yNHLfZ4nTQ-AtnRe0YF5-PRBr4mFpW1H-70Y5LRewGDMNRNWiXxYNXQewRtS8yATtVo1raQgeIog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddutdegfecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepkeefheeftdegtdejheeuuedtgfel
 feeiveekieekleekffelgfdtveeiheehffdunecuffhomhgrihhnpeguphgukhdrohhrgh
 enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhho
 mhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhmohguvgepsh
 hmthhpohhuthdprhgtphhtthhopehrjhgrrhhrhiesrhgvughhrghtrdgtohhmpdhrtghp
 thhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepshhtvghphhgvnhesnhgvth
 ifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepshhtrggslhgvseguphgukhdr
 ohhrghdprhgtphhtthhopehsuhhnnhihlhgrnhguhhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:195HaBkbFV6r1bNxT-1zHLqn1g0fY9XeLeRmr2sM_ZmlEPvZJ5fwpw>
 <xmx:195HaP3DpOpRyme3aPaszz1OlEKFm-DqXq76iJo6rjC-pTytK-DHWQ>
 <xmx:195HaAtdX4Tat_xzguMCubs0tzqpn-fn24WVjpnJzbMtoLGQGMKYlg>
 <xmx:195HaDUR9Myw7DoDGtAlK_s48abkCgQzizbkE6arfU__I0id6oREbQ>
 <xmx:2N5HaPrjYJFzcNRfLp4WNXS-BDyVfrcqdjdMbjAZ-IkNP3jDHJWLWSR1>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Jun 2025 03:29:27 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 stable@dpdk.org, Junxiao Shi <sunnylandh@gmail.com>
Subject: Re: [PATCH dpdk] net: fix IPv4 compat and mapped checks
Date: Tue, 10 Jun 2025 09:29:25 +0200
Message-ID: <6595105.Wku2Vz74k6@thomas>
In-Reply-To: <20250224144725.271975-2-rjarry@redhat.com>
References: <20250224144725.271975-2-rjarry@redhat.com>
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

24/02/2025 15:47, Robin Jarry:
> The RFC states that the first 96 bits should be compared, not the first
> 32 bits.
> 
> Add unit tests to ensure this works.
> 
> Cc: stable@dpdk.org
> Fixes: 3d6d85f58c1c ("net: add utilities for well known IPv6 address types")
> Reported-by: Junxiao Shi <sunnylandh@gmail.com>
> Closes: https://bugs.dpdk.org/show_bug.cgi?id=1664
> Signed-off-by: Robin Jarry <rjarry@redhat.com>

Common format in DPDK is:
    Bugzilla ID: 1664
    Fixes: 3d6d85f58c1c ("net: add utilities for well known IPv6 address types")
    Cc: stable@dpdk.org

Applied, thanks.



