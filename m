Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F42FC83F0A
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 20:59:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E0FF40654;
	Wed,  9 Jul 2025 22:59:57 +0200 (CEST)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id 3859E4029E
 for <dev@dpdk.org>; Wed,  9 Jul 2025 22:59:55 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id A507C14002F3;
 Wed,  9 Jul 2025 16:59:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 09 Jul 2025 16:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1752094794;
 x=1752181194; bh=VsmXvz2gVgbfsrB4g5WySP5idXiP2oq5/0aJE9c4mKA=; b=
 EfD1RMSPxBIJFwZxtfU93J/JwY80N5u+RqK7SYyOsGKJUqZexn9mEv9PcoWDsWJc
 VTjaZiKNN3C/tXeKTqsg6Jrp/tcmC9M0RulijcdR7CXE5DM1GlQvZRgee4huc2XV
 eVkVyMfe/WgxU8Ri4jWcKB/2264rZwHzHPaSQBt3O8YDtsUk/dQ20+nL/n8rZ8WC
 7ky7THyiBeT4mB4N0B2r7PlEQYEnFj1Wh0FqmIAs4ypby2urXb+H2Wf6K3UHvoZc
 0SkUgq8/2RsYAUfS96vUImj5MwBtRrQAevE2eA+rTJJHEIjJsUkzh2psKa3Yb5BV
 eHcqHfle1l/i9NhwzR127w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752094794; x=
 1752181194; bh=VsmXvz2gVgbfsrB4g5WySP5idXiP2oq5/0aJE9c4mKA=; b=V
 qy5u2BxFiMJY+xShD6wKiUG3gURxnq+gyWYWisvN1Si00ekSGB4nR2zApEpjb6YZ
 TBsWDmERkJxwB3CWluJjdKcqFoNwRJ7Hsu1QYTNX94CSOmqPIURvphry4htPP6x6
 Yes+mhnYsnzouvvRLFl0WquT90GQUSfPtsqKuGJHN+sg5+kV5xQMYEFLyquH6ARV
 Zq+j/Xjpgv4ufh/lns2wC4kP+EpPY1hMiTnT5xMxYajfDcFVLa6J7dB85VvbsJO4
 OYjEAs3bUgdsd015fwGPmFTFPrf3m4o5gkv1lm7bDfmL5MIY0cNfuFmitVSot7Hk
 jcBo5Nkk2Zppb3bB9WFPQ==
X-ME-Sender: <xms:SthuaAaQ3zJcB4hOoQnfzHc7CoWsQkP-K-54RWZoTyWuRDaieIyt6Q>
 <xme:SthuaArAHI1TpFlG7MF9vYgp_O0ufTXqFqbeFLo78yluxWfoNeT-akvnKhR0tDEpN
 1eJHfJd5Lk8ZU-m8Q>
X-ME-Received: <xmr:SthuaMpfkne_WJ5xnxSu3AyCTGa1SSK_QjhBW3xU_EQN6HDceLU4ygzZi8rc3xlAtZn79xRdhog8e27OHEMrQomcuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefkeehkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepvddpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgrnhguihhnihhpvghrshgrugefieduse
 hgmhgrihhlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:SthuaC074xkIkoLN1ysm0xqQdSdxkKfAiqdL_OIwfjBXfVe9UQERyQ>
 <xmx:SthuaDDpQOh0oJFZ2g1-zTK0CKE32ZrAB_ETHFI96UWVH98XoO6vjQ>
 <xmx:SthuaCfnKre-YOezEieC4PF7r2bsYdT-gKwATNZwQyPjnb1nvK_S1w>
 <xmx:SthuaAhhfRBCeUPqtNDfLFfrUz0QTD8dpC3JCm8xooVsBtNCgqS89Q>
 <xmx:SthuaPqvV6JT1enoppxG4X4LpBTe3b8JY1PUsA1uoI4a7-zW-uHj_slA>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 16:59:53 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Nandini Persad <nandinipersad361@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3] doc: remove known issues
Date: Wed, 09 Jul 2025 22:59:52 +0200
Message-ID: <3895501.h9gRbJKcGU@thomas>
In-Reply-To: <20250411161503.44103-1-nandinipersad361@gmail.com>
References: <20250410181948.40431-1-nandinipersad361@gmail.com>
 <20250411161503.44103-1-nandinipersad361@gmail.com>
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

11/04/2025 18:15, Nandini Persad:
> I have uploaded all these known issues into Bugzilla,
> so they are not needed here anymore.
> 
> Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>

Applied, thanks.



