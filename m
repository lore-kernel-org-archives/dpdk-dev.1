Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73446CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 08:43:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6602402CB;
	Wed, 24 Sep 2025 10:43:47 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id C54D840289
 for <dev@dpdk.org>; Wed, 24 Sep 2025 10:43:46 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 14B9C1D000ED;
 Wed, 24 Sep 2025 04:43:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 24 Sep 2025 04:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758703425;
 x=1758789825; bh=+yIbcHy9BUT577/mkuUst3Zp9EGuWmI8gzzygDUAtAA=; b=
 NRXzSCeCUpQP7207ldKn/mIi+hAmU2zgf2Vov1tW9mnNqYCBWuy2wDup6pWc8dlq
 1db3hzMvdp6Eb9EOgMIPOpWngpHmtcs5h3N1GnLjFt/BrOGiGJS+LDiEyEkJhFqX
 mE5aejeFvZfdLX+i6iOJ0iOyILKenoJxZ/sNq65x9C8MSBorINz4xD4LyRSYFAMQ
 jilyrqRE9NUXpgJVHu29cnEseobe6ZqAQwgaoeSO4CC/wizUY6ZalQNb47TPLyEW
 M0JnqxxdlBhGc3l11s3rFOsNjrOpMNB0uvawiFA/lw2ovzv/fF/2J1tch/lTNAz8
 fhBq02RdcxFyF9HaR3Pn/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758703425; x=
 1758789825; bh=+yIbcHy9BUT577/mkuUst3Zp9EGuWmI8gzzygDUAtAA=; b=G
 d+oKYfbvwYSy1xh8epmytLtmJ4YL2sxaoTt6bdVxQ5BsopcbdnT74q0qBlCwznrW
 ttkyqRm8Aj2Mi+Su3ZwzS0In67OyLjak/uPr+5UR5tpFZ28wnBUmC1dkfsI7+W+j
 6vcruRbq89MRHEqHHDShRogs7UGeePQgmBASgTZS9spHtOmBgv8C1UULujLC5C8g
 zDFk2u5dxdfaW4FounJ25NPEt9uKXfX2dCixr3QWXpISermKWWeTfY1GEhhYzHlg
 LHBS+8yZosqGY0wPk5WCNi3DA606lVzp3s4FK9hm4e1l3Cuj4Tofvt4fjrLiEYvJ
 L3zXQPtEwWGYDLwRGDlgA==
X-ME-Sender: <xms:Qa_TaL0KyXsgSrlX749nWv7vzNMiR23N81a_drXchdFrrLB8yX5q_Q>
 <xme:Qa_TaKPhDCu4K-nU9Itkg1Dmk8Y-C1aF4MvZk6HSERtYEMF1QyaUqwl0ducxnsRTS
 _vUHS7Xsy59pbkFIGisZb94UQ0I9WE3Whn11YtDn9L6R-yhksThEw>
X-ME-Received: <xmr:Qa_TaD2OS7Fi3i112pNrnJA7h646Qh55HZN1gOXUYJehMd51wVK57E4UA8_ICCkL4sgDOAY07MuNIWVWLMMyl6NjbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifeduiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepgedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhtrhgrhihnohhrsehrvgguhhgrthdrtg
 homhdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtgho
 mhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopegurghvihgurd
 hmrghrtghhrghnugesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:Qa_TaJEeYcjeAEbHXU8tcLkcGnnigvVX4xIIgvpmq1tgtrPhzM3gKw>
 <xmx:Qa_TaI5XZuyNymr65Kx3CmzRNpL9qNlzSKszuGY0paPsha2Hq2RsmA>
 <xmx:Qa_TaHvpRE6SfNFwSPzISguEnA9IlOK_zf9hWk7fyR34GOy-TwsCGA>
 <xmx:Qa_TaB4hwdEyBdM8TBnIF4VjbWog2cDffnykSIFjfApQ5jdg6Yzkag>
 <xmx:Qa_TaNxBeZlAdvlQ2przf34H17Zt2ARjAP_4bCo08_-0NyMjzrnln49X>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 04:43:44 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Kevin Traynor <ktraynor@redhat.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, david.marchand@redhat.com
Subject: Re: [PATCH 1/2] build: add backward compatibility for nested drivers
Date: Wed, 24 Sep 2025 10:43:42 +0200
Message-ID: <3486585.4XsnlVU6TS@thomas>
In-Reply-To: <aNKgbnlYLSvu1zgq@bricha3-mobl1.ger.corp.intel.com>
References: <20250922110708.47879-1-ktraynor@redhat.com>
 <4a7059c1-43ad-4df7-a4fb-03ea938e6009@redhat.com>
 <aNKgbnlYLSvu1zgq@bricha3-mobl1.ger.corp.intel.com>
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

23/09/2025 15:28, Bruce Richardson:
> On Tue, Sep 23, 2025 at 02:08:35PM +0100, Kevin Traynor wrote:
> > Yes, that is a good point for discussion. Seen as support for the legacy
> > names were already dropped and I wasn't aware of any ABI like policy
> > about it, I thought there may be a preference for deprecation
> > warning/continuing to move to the new name only.
> > 
> > I would be happy to keep the legacy name without a warning/deprecation
> > for a longer term and we could adopt this as general guideline by
> > default too. It should not cost much effort to do this.
> 
> Agreed. If we do decide after a while to remove an old name, then we should
> do a deprecation notice first.

I don't think we should require a notice if there is no deprecation,
just an alias added.

> > Another minor point is, if this needs a Fixes tag? Yes, in the sense it
> > feels like it added a banana skin for users (the patches are because I
> > hit this issue with 25.07). I didn't add it for now, as no guarantees
> > were broken and there isn't an upstream stable for backporting to anyway.
> 
> If there is no backporting, I'm not sure it matters. Maybe add one anyway
> to imply that this was something that should have been thought of in the
> original patch.

Backports are not only for upstream branches.
If someone wants to maintain 25.07 privately,
it is good to know what to backport.


