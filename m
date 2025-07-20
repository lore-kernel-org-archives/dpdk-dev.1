Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A74AC83F22
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Jul 2025 13:03:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 331FE4021E;
	Sun, 20 Jul 2025 15:03:19 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id 430404014F
 for <dev@dpdk.org>; Sun, 20 Jul 2025 15:03:14 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 5A06E1D00066;
 Sun, 20 Jul 2025 09:03:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Sun, 20 Jul 2025 09:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753016593;
 x=1753102993; bh=Ig6t7Yn6fXxlKeC85WBatubJ9PThnO8vVY1U2l5ooqk=; b=
 AHxivUXTq0EU76GwVpmS5uo3LepV3OkZNU3pu4NgdndEmSaOYu9KLkgKdSKtdYgN
 EOm9T+wWZ625/AoR4Ud6PEJ/v5Fz75/w6tQ23XoUKPnGit1FAYvFOt8LxrvLq7EF
 ajizKmzn8aIx9epEvvb/MCV3kgNtBrLBavTHQB8zZX748Q91+1TmN+EYZyqnClS7
 ZUiZDVOdtfflQVTJSp0q6BRHpLALWmE5ndV88ZxTL4V0hdFUk8nY0NaP0uXmyMvw
 5yGNF2Mgx02ockYmMHGoJsi1ZcLhdvu07y43qsBVENAWcpPbawe51bLN3cYN933A
 sB5f5fLIsROcgi3847j1RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753016593; x=
 1753102993; bh=Ig6t7Yn6fXxlKeC85WBatubJ9PThnO8vVY1U2l5ooqk=; b=b
 cvxR3iLpC0GCB0arbOyeTdT5vjxqjdx/l/+ebvm/4gVdJLxBMjnSUi9U4Z5wE5u1
 jQ4ZIuCZm56b1Vhl5sXtkxVufGvKWkGXoBeUWytd2CCQLye1cxxFG4L0oRpK8A0R
 KqMT7frY6lSFQ9H/Ryo18qg7rvTlF6dN2Pekn0W7fn+q/ffOXWGrGyI0Ll2vRJ1F
 DU9rvpCg0SFH10et2CXpfpaF6PHDi6o09e1NwaQVnYGB5a/mayMM327jT/7vhnhE
 TMikU+kYLCXdf5VTb8k6JU7Yd99bKY2wGfthaR/Pb9FKWWn8G9F1wbiFUAbiYpeQ
 EayZMmdmJMQMxofv4ij7w==
X-ME-Sender: <xms:EOl8aOJJGyhPx-Da8qtbegwiRUDqTZWTmuN8tFpQvMfZjVHtpfl_9Q>
 <xme:EOl8aLaKVr9sZ--QzFaVk3xfR737-5hkcV6Zs_auQFBdNx9XQN-LvA9q4-DZbX4FA
 8iEantE8X2W6h7dzg>
X-ME-Received: <xmr:EOl8aAYz1MTdGP8oXCWFE5FJ9b1XYjsZE04kHO4O40QwNyCuGkk1qQzOuKktsMHEe8vo3h0L6biRyEvOvuuyYohfYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeiledvjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepvddpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgrnhguihhnihhpvghrshgrugefieduse
 hgmhgrihhlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:EOl8aLkTAuZCk6Ly9angyFJhPh0MPVPLcGgFVsov4go8xTFXB7HU0w>
 <xmx:EOl8aMzkAJF4GFyWo64JcfDlCIXxBYAN6FsZ9Qsm_KI7dqLRbx_nTQ>
 <xmx:EOl8aJMwx0ho3yZlO5rHqsfzOq8U_q3f3ejxnNxbF2txQR_UaHIHyw>
 <xmx:EOl8aASsj9FQXjB-E3TsElOvB72rCzT22P-toH9gfsVjDnd1XVYIUQ>
 <xmx:Eel8aDYfxbaeZl74MIj7V8Y59n_b0ZmJXekFSpmcwVQW0pW-mp3UpJHH>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Jul 2025 09:03:12 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Nandini Persad <nandinipersad361@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3] doc: reword glossary
Date: Sun, 20 Jul 2025 15:03:09 +0200
Message-ID: <8599554.NyiUUSuA9g@thomas>
In-Reply-To: <20241202052349.37261-1-nandinipersad361@gmail.com>
References: <20241122024023.31914-1-nandinipersad361@gmail.com>
 <20241202052349.37261-1-nandinipersad361@gmail.com>
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

02/12/2024 06:23, Nandini Persad:
> I added additional reference links and definitions to many
> of the terms in the glossary. Please feel free to provide
> feedback to ensure my definitions suit the proper context
> in the DPDK community.
> 
> Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>

I've improved consistency and done few more refinements.
Applied, thanks.



