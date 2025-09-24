Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20C3CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 14:58:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B09240661;
	Wed, 24 Sep 2025 16:58:24 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id 3B7E44065E
 for <dev@dpdk.org>; Wed, 24 Sep 2025 16:58:22 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 31D7B1D00158;
 Wed, 24 Sep 2025 10:58:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 24 Sep 2025 10:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758725901;
 x=1758812301; bh=odr4RbFmSk/+s1vnzObbrKobi3f70Y3oR9kgE1I2Po8=; b=
 UpAuiO5ZpVvFF64MY2jvpw15foibrHUUlZZoprVqgMJUXr10KKDlTl4I56XpC76b
 fYx3M2IZYiW6g87+hROJEKQux0y5KDzmdw3HFbOi1lKHTyreeON18JInZP6OIwkw
 Fj050cxVed3ywIJdIG4v8BTitvqxmhwn+BTyFR3D0/iXS1fNccFmNISp9xatO+1z
 qOV52ifZeXYhCZj36dPxCffxtobrtl/JMUdWcQ4IolNNiCla19vUaSME89adY2f8
 wWnrqrIqHC4uWX9gX/+J4w7/2WJd8hF2WiBFy3/aIRpgWa9E2Jr0jRChYfmwJTt6
 y57/Sx4R6E0zmP0BJa3Jqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758725901; x=
 1758812301; bh=odr4RbFmSk/+s1vnzObbrKobi3f70Y3oR9kgE1I2Po8=; b=P
 qGHsWjE1JwMkv52RczdCfAsC2EoCRxFfsJIB5b8Uy5cB/jJxCeTD/ipKRFmRzwKe
 mU6hDB2Z4kkFfcMrjC5AYGXIoXC/MEdY6o3nM2t1KhMvewMIfjgirRDWK/e7VbWg
 IAnOD499zO6lSIlEGkXVozE4mPyXaao+6AchSpKUmYJ5EAMmy2EFsI1RLRcR3phk
 FJ74aPMohAzKoVygV4Wg2Zz5PIkWTUHL0plc+YXJCVxBeXgoVDkAmL5uPGZ+yOoM
 j8TadtMlZqrlpr/T+FPuPsqV1epYeA+PEtn5A97fGjxhZL8/nzKvCC2JUzSsgGnu
 vFO0vGf87zGo5ML1ufARQ==
X-ME-Sender: <xms:DAfUaP2KjUOkgRGo2K-6JkY6WD8rBRksnwkKLmOrA5OV6dVF6RdM0Q>
 <xme:DAfUaJjJ9cMq1z2IX04xV7PD14ZW6Iki5kQ43JPeY7XFqkN8W-WkpIGqlyPwVwceT
 TFdr8W5U8A1XFMMiCNQq1tz11rhVvFgAjusoFs7ntEazErtW8NhCdk>
X-ME-Received: <xmr:DAfUaDZ50HIdgPO5igEpiRcIJ4SPoA4ku0kkX64Pj3P3ONq-H_qJ1qA_NqzoJSZbaXP3dyLNXOigLpPl5MWZxlsTlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifeeludcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohephedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepudeiheeijegrughighgrshhhrhgvvghshh
 esghhmrghilhdrtghomhdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhes
 ihhnthgvlhdrtghomhdprhgtphhtthhopehkohhnshhtrghnthhinhdrvhdrrghnrghnhi
 gvvheshigrnhguvgigrdhruhdprhgtphhtthhopehjrghsvhhinhguvghrrdhsihhnghhh
 sehinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:DAfUaJQGn9yl9kdK3CN773quA5NO1--DHU75F2-PgUfKxw64w_-VfQ>
 <xmx:DAfUaORXIduLcQQdHxmEvIgHPEucx9TWaPZbULn4c59LbZ3RVPRcZQ>
 <xmx:DAfUaFRu-oUbunJM-IoX0uQaU_3eIUmPqVTLf6PfCx5OC7HsV9TKRg>
 <xmx:DAfUaL4uRs03r0xewW1AsUAro3Z1xejIzvFckLdWZV8fLi-zL6qp2w>
 <xmx:DQfUaC3Fy2aGDTXHIQWQS_kHSv-G94NjeXttHfZsl5_2SDRdIBLSKFw4>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 10:58:20 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Shreesh Adiga <16567adigashreesh@gmail.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Jasvinder Singh <jasvinder.singh@intel.com>, dev@dpdk.org
Subject: Re: [PATCH] net/crc: reduce usage of static arrays in net_crc_sse.c
Date: Wed, 24 Sep 2025 16:58:18 +0200
Message-ID: <2664319.yIU609i1g2@thomas>
In-Reply-To: <20250716103439.831760-1-16567adigashreesh@gmail.com>
References: <20250716103439.831760-1-16567adigashreesh@gmail.com>
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

Hello,

16/07/2025 12:34, Shreesh Adiga:
> Replace the clearing of lower 32 bits of XMM register with blend of
> zero register.
> Replace the clearing of upper 64 bits of XMM register with _mm_move_epi64.
> Clang is able to optimize away the AND + memory operand with the
> above sequence, however GCC is still emitting the code for AND with
> memory operands which is being explicitly eliminated here.
> 
> Additionally replace the 48 byte crc_xmm_shift_tab with the contents of
> shf_table which is 32 bytes, achieving the same functionality.
> 
> Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>

Sorry I'm not following.
Please could you start with defining the goal of this patch?
Is it a code simplification or a performance optimization?


