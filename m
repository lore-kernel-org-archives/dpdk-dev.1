Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A79ECAC586
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 11:53:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2149140156;
	Mon,  8 Sep 2025 13:53:45 +0200 (CEST)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id 6DFBE4003C
 for <dev@dpdk.org>; Mon,  8 Sep 2025 13:53:43 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 735E81D000C5;
 Mon,  8 Sep 2025 07:53:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Mon, 08 Sep 2025 07:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1757332422;
 x=1757418822; bh=H2vsrTJ48Gob5J/a2HcaJVpvcSAqcMQlolKcE0oGrRQ=; b=
 SWwuQWR1YR5oU84kX+mbl+2JKGuCMAcPHytO+R3wbmRDFZWiLBrxuaiJ0PTlPaEQ
 YCiOj8BrYUfUrZ+PuolUqe2NDoamMOY3LOv/FOPH8CQdoK5D8d4KVYTJ4rTUgeQM
 tVsU7bVveZp3yhxx8f+sgJlpJ+tl07x1LPCFk5Z+uGos419bF645l9498PW64IwY
 Aom3gN5MLBQH5SSejYOKVLteE9qVSaf86bAZOBw8w4Ux7TopodaxpHo0G+66FCTg
 l0zNUFMSYqc/pqbff7o+6cH1Wso2b9gtqqup/0tbQnIOfvago4e2xsG+G2xqAO33
 Ll2HiIaebuV1FbhZkFArzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757332422; x=
 1757418822; bh=H2vsrTJ48Gob5J/a2HcaJVpvcSAqcMQlolKcE0oGrRQ=; b=d
 w/QfD4nn/aymxXbFtZPjrjsWGgs0W10d64WOI6qPxWCXi5skjHgDVmLcBc2wVOqJ
 5PJgEnSY5u+HVO6ReFME5YeriTz1RNJV+/NP5IkF5yffUOojIk1bwtw2IToitE/9
 KJqoIpIqGqZtGMPuBPspWinUJ2Xj+zPCNZqwWmHXozxHn/ePP7sZEOu9M8Z22VNA
 wlrISJciFqkW9BdLQ2nqdZKD/a3HRDousyxtY+af/6LLR/okdILmECQvRi/9tEwX
 A6c43miHUBNTiuZAuqPvcSgGsobuFKitFMj1Z7TvanNNqqGo39zzkHfjY8pNDGmI
 bk7uQedrxIm9TVbx230PA==
X-ME-Sender: <xms:xcO-aCBUkMnvZ3MPLxY8EQ5C6n7AtkjG_7J7MhAcn7Pj1Een_Oaanw>
 <xme:xcO-aKfZwSGAdP_u8CgOobiH0hHdMzcEGAiW8x4yW1NRyi8VCXCpi0vksrKGBl2RW
 ioLNcClYcwhZEC-cQ>
X-ME-Received: <xmr:xcO-aH73evgK0rCTpPl29twCr202jU8S1I-jWeLtqAu_qUqhN8jBrK3SGjlLuLI_4fmp0JxMv5OIu3xpWSibcKGqew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeegiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepiedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplh
 humhgsvghrrdhorhhgpdhrtghpthhtohephhhurghnghguvghnghguuhhisehhuhgrfigv
 ihdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehlih
 hhuhhishhonhhgsehhuhgrfigvihdrtghomhdprhgtphhtthhopehfvghnghgthhgvnhhg
 figvnheshhhurgifvghirdgtohhmpdhrtghpthhtoheplhhiuhihohhnghhlohhngheshh
 hurgifvghirdgtohhm
X-ME-Proxy: <xmx:xcO-aFXvofsbg9Bk7JGQl9d4He-47EcRnVW5MsLFgVXXqwbSV0lF8A>
 <xmx:xcO-aO60Qt3TSztOubxz6I-z4ASuGii5HSxVdJGYc3g6HDHqYfBdJA>
 <xmx:xcO-aIqs0rkKNDbhoDvvJ0D9HfLR_wCT46UkKBRxWFH3xoO_f0zOPw>
 <xmx:xcO-aJmRH7BMEYEZzmk-nBLWW1OP563IQ0uC0JC3flXEFHYwiW20hw>
 <xmx:xsO-aOaxGCmwCD-vYbkhncc9LdJbSbnYraYYpUPduYwMMc1x566Ra46g>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 07:53:40 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Dengdui Huang <huangdengdui@huawei.com>, dev@dpdk.org,
 lihuisong@huawei.com, fengchengwen@huawei.com, liuyonglong@huawei.com
Subject: Re: [PATCH 1/3] net/hns3: fix inconsistent lock
Date: Mon, 08 Sep 2025 13:53:38 +0200
Message-ID: <3368264.aeNJFYEL58@thomas>
In-Reply-To: <20250813140646.48a2ff16@hermes.local>
References: <20250813073317.1352274-1-huangdengdui@huawei.com>
 <20250813073317.1352274-2-huangdengdui@huawei.com>
 <20250813140646.48a2ff16@hermes.local>
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

13/08/2025 23:06, Stephen Hemminger:
> On Wed, 13 Aug 2025 15:33:15 +0800
> Dengdui Huang <huangdengdui@huawei.com> wrote:
> 
> > The hns3 driver supports configuring RSS through both ops API and
> > rte_flow API. The ops API uses spink lock, while the rte_flow API uses
> > pthread mutex lock. When concurrent calls occur, issues may arise.
> > This patch replaces the lock in the flow API with spink lock.
> > 
> > Fixes: 1bdcca8006e4 ("net/hns3: fix flow director lock")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
> > ---
> 
> With that mutex removed, you can also go farther and remove all references to pthread.

This patch was (probably by mistake) in the next-net/for-main branch.
I've dropped it when pulling in main.


