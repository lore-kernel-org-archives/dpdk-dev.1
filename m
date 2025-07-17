Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE998C83F1A
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 19:48:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2E74402AE;
	Thu, 17 Jul 2025 21:48:30 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id EC32F40283
 for <dev@dpdk.org>; Thu, 17 Jul 2025 21:48:28 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 973821D000F4;
 Thu, 17 Jul 2025 15:48:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Thu, 17 Jul 2025 15:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1752781707;
 x=1752868107; bh=uzUcoCMrhfjWRDh9ar4Yw53sqyPhqD31UD8Uede47fE=; b=
 C3O50tqDx93Dl0nSJ4KK+cJlsyPmbD1Ie8Ja0dOrwdA2Ua8j1blHSvMHBBm1JFiT
 xFHkNrX2/r9W4yUsv7L1pufxBxsPNzxNj2dlJSEpGeY7kG1zbljH+lpGyKW0KUM1
 Bf5YaodGJsBNVth7Dx4T1DZcP4ohK7CDsEQCSdvpd5jiCkn4FOAbTOqVQDDxKeoj
 Msz4doq8q/uc+uizm/Q8kqAl9goBXMaWDO/4S8snXWLSmNqzVu/pgVDXYcGzqrNP
 CdNFPF7VcCqHouU4KSFlnMHXNtFr7Ohxx9hw51LjQx1N6Damru/nbCu8YoLBBPbW
 aCDVJG/NRg3kUmhl7vYauQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1752781707; x=1752868107; bh=u
 zUcoCMrhfjWRDh9ar4Yw53sqyPhqD31UD8Uede47fE=; b=CckhkIBfjXXLxmJyw
 cJ8Iq2urXspiqY2/DKd0bEhOOlBuTG3SWnVQX4RSbRmSYds6siYFFz6x0ruSvNJ2
 jro7jh8oxlJVTdle/hQW/TjOqMjQE6DHuGNNr3j2RVe8TpYMr59C6tXecLGSKyQO
 VVFgclquYiLvM7kreDYzA3BqKCtPQBw+D9JqiDIORvax+WwgQMNFOOoIYLJ82yiH
 xrbJyU8qVeZ6tNAzVRTIcSeS+PdNdvO8DSJgIsosTRIHIki9E9orwEv9kx873XyF
 5XQt618UJBLIwR2+8KTBZogAUU/6NbyniOiePR3LUNrff6V5ghPJNzZikRkJrSLg
 Xd4eg==
X-ME-Sender: <xms:i1N5aGY8ztRTpowsfYqmshR_1bNoCYwIPj2iXKY7Bs66p6PAQzegxA>
 <xme:i1N5aEoozBCUm8Hr6k1JK_ownsxjILCSYeu4yb0IbUnChnQnz4mGy36F3ed8suO5c
 -prfEmFcTmBSd082Q>
X-ME-Received: <xmr:i1N5aBm494kX8yslXWBKQ0SQwPk8AQqtNHQN5PTb85116Unx1afWdb7w5kTq0yK0sMa672tn_FdAahegDfvb3L1z4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeiudegiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhephffvufffkfgjfhgggfgtsehtufertddttd
 ejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhn
 jhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepledvhefhudduudefhfffhfetfe
 fgjeethefhteefudekvdefgfeludegtedvtdegnecuvehluhhsthgvrhfuihiivgeptden
 ucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvth
 dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggv
 vhesughpughkrdhorhhg
X-ME-Proxy: <xmx:i1N5aO1DDi_s7BSkhUTCahzL9SZV4GY4IAenqMco5HLhAdBmQkEPyQ>
 <xmx:i1N5aBBbC2fg-gyw_mOFtTN3aiz_I9pTFjV6_CYLoR0w-p4iU_F6Bg>
 <xmx:i1N5aDwbi4efeffmTIHSZy-AKTcSyL9hKh-Jhuom8-3Ygi4yQWxuvQ>
 <xmx:i1N5aHltrZUUb1wFJF22NpcC2XZOMzywgkps0GkXDb_0EQIEJ9ApBg>
 <xmx:i1N5aIoqG7jUt4-ptZaJglj9NjCg3v878_Hoh5Ecixk5o4jCGH9v6JPL>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for <dev@dpdk.org>; 
 Thu, 17 Jul 2025 15:48:26 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Subject: Re: [PATCH] doc: make table headers more visible in guides
Date: Thu, 17 Jul 2025 21:48:24 +0200
Message-ID: <5000016.GXAFRqVoOG@thomas>
In-Reply-To: <20250716101455.224877-1-thomas@monjalon.net>
References: <20250716101455.224877-1-thomas@monjalon.net>
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

16/07/2025 12:14, Thomas Monjalon:
> Set a background color to table header
> so that it is visually easier to read.
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Applied



