Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19104C83038
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 13:06:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC62740264;
	Tue,  1 Jul 2025 15:06:23 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id 420A9400D7
 for <dev@dpdk.org>; Tue,  1 Jul 2025 15:06:22 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 6797B7A0106;
 Tue,  1 Jul 2025 09:06:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Tue, 01 Jul 2025 09:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751375181;
 x=1751461581; bh=GrMJLVwLND908jkSoOPmnYzhMn8P9n+qKL8caN+r77M=; b=
 FcYZGZOIxxdRWnQkDiUVEpzNtmeZeWvYWoY+gXBSKUHol6bGY1beHatHLYTXhIHI
 NaZp+Nh/wYnepZ0UrizLeUfiS4dmsHBXP7niyMm034I+xGKBgJL+E5SDA+7sJhbk
 4hteXpZfyhk3GeSDvWDDbD48m0mA09pgdCAo/U5NGTosf7+mS+QdBbAta5HFdDe3
 OoVfoGNiIs/D07RVM0DS2LLHtn4K1kQt9i34wKzm4HJ95Mn6vU7NJxisoI1jGH68
 8rnK1THU3QJi7UTgq6Q6rI8KggDseqTfkJCaCC6UwbdrMJ4ZiuBgYTHZhZ0UjuCI
 2ncqhkj8qi0K3LjVFD4quA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751375181; x=
 1751461581; bh=GrMJLVwLND908jkSoOPmnYzhMn8P9n+qKL8caN+r77M=; b=R
 7RhMvswgPThLrQgk5iqaWd7EokQ+G31sAb0KR8a/dqsU4Tx2ZuFOhSIYBzZ8Idf7
 vsH6HFBRN+Md+sS3Fbh8DCiynZPy77m3YTgXutremIQ/wRfKGMonnSmSag0qxSRz
 OMJPWW2vhWHy/bxeyITmrGYnK/Pk13byQxmAYPn8d6oRU9No5efDZaXMCez3C2f2
 rHmuE2oEOMrOGDvlmYa5wdqqDtHX//3C6Ln1qYxftOMqj/5uwVmDHxKL5xiZTY1B
 W0uVA24rkaQEKXEELvDPhVK2cRXtJP45FqtYA8gqG6PBPpM8W0oAlakdHjrNA5oj
 +opqRDCCPtEz20EnjugOw==
X-ME-Sender: <xms:TN1jaFUqiz0XJDWBZFGLUd8aOq84jf-er9HQxNzAeSa9n5lSiX1pAQ>
 <xme:TN1jaFmAm0AAtisJchsjKjNmPCXSu4rH569_5S8HvniGJfvW2LOHWusJF8kl990OA
 R3tc07vEr9Cwv4x7g>
X-ME-Received: <xmr:TN1jaBb08a7MQ18DMjVbRFs6oC936zNpAbTyJVQxurCRjnf8v3LZiMBzPRl9ipqS3bnHzOTHYtOX_q65ZYJwqCnJeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeeivdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepiedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepvhgrnhhshhhikhgrrdhshhhukhhlrgesnh
 igphdrtghomhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggv
 rhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehhvg
 hmrghnthdrrghgrhgrfigrlhesnhigphdrtghomhdprhgtphhtthhopehsrggthhhinhdr
 shgrgigvnhgrsehngihprdgtohhmpdhrtghpthhtohepvhhinhhougdrphhulhhlrggshh
 grthhlrgesnhigphdrtghomh
X-ME-Proxy: <xmx:TN1jaIUdfDsluBSE5YN7gwilbq9xPjmzqKAL79zW4pKvt1s04uUmWA>
 <xmx:TN1jaPnTPZ_e58tyaXKDhgSQTLAuH0aPYaJzE0j0aizg3Giu61B7rw>
 <xmx:TN1jaFeTNzIJ-Sl3cVNC9niNgvWjbrW2dHnrdP4CuEsUp4h597I0YA>
 <xmx:TN1jaJF32whVjFyngv4JjtdqXmKd4nE87UAAcs3XOfs_fZ8mKm9YSw>
 <xmx:Td1jaMtX6BmJAudbL_L38LE4nY3l2CEPbwHYeEsgc8q6HLuGKWURJaqB>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 09:06:19 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Vanshika Shukla <vanshika.shukla@nxp.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 "dev@dpdk.org" <dev@dpdk.org>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Vinod Pullabhatla <vinod.pullabhatla@nxp.com>
Subject: Re: [EXT] Re: [v4 07/10] net/dpaa: add Tx rate limiting DPAA PMD API
Date: Tue, 01 Jul 2025 15:06:18 +0200
Message-ID: <5175369.NQBDW4tYnK@thomas>
In-Reply-To: <AS8PR04MB89793B130FC03500D560F9B5F441A@AS8PR04MB8979.eurprd04.prod.outlook.com>
References: <20250610091411.2500413-1-vanshika.shukla@nxp.com>
 <20250629094254.450724d5@hermes.local>
 <AS8PR04MB89793B130FC03500D560F9B5F441A@AS8PR04MB8979.eurprd04.prod.outlook.com>
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

01/07/2025 13:42, Vanshika Shukla:
> From: Stephen Hemminger <stephen@networkplumber.org>
> > On Wed, 11 Jun 2025 12:40:36 +0530
> > vanshika.shukla@nxp.com wrote:
> > 
> > > From: Vinod Pullabhatla <vinod.pullabhatla@nxp.com>
> > >
> > > Add support to set Tx rate on DPAA platform through PMD APIs
> > >
> > > Signed-off-by: Vinod Pullabhatla <vinod.pullabhatla@nxp.com>
> > > Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
> > > ---
> > 
> > You intended to add a PMD specific API for rate limiting.
> > But there is no RTE_EXPORT_SYMBOL so it was never used.
> > 
> > You would have found this if you added a test for it.
> > 
> > Not accepting this without a test in test-pmd for it.
> > 
> > And why is the existing ethdev queue rate_limit not a better API here?
> 
> We have exported the API and are currently testing it using our internal application. This feature is specific to our platform.
> 
> The existing ethdev queue rate_limit API supports per-queue rate limiting. However, our use case requires per-port rate limiting, so we have implemented a custom solution to support this functionality.

You should make a port-level generic API.
PMD-specific API should be avoided.


