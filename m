Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830B1CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 14:15:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8B55402B0;
	Thu, 21 May 2026 16:15:09 +0200 (CEST)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id 48F634025E
 for <dev@dpdk.org>; Thu, 21 May 2026 16:15:08 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id B58F4EC00E5;
 Thu, 21 May 2026 10:15:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Thu, 21 May 2026 10:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1779372907;
 x=1779459307; bh=0S8W4VenMFt3Lf7W1TshS3lFby/LP7C2a154lRddKn4=; b=
 lPhz68RYztPhFxT7yAZ2lOf8bztHFrcN1pywLrvsfHt9usMMFMP/8FKpy4GUAyK1
 uO9Rf4ZzRk9dzfyvCNGz1RDMtTH1bzWbS2Di72ZObhbJHQy2y7ZvwHu7AHHF+Of0
 ch25OO7M/KfpY0kGZMPeBCnOjAURXlYPoKdwyafemd9sv32IGBkHzrnS83NKhvGp
 oVmsksKpikOlgPDfST9MB1q1XdZXPs+jhZOowCH7uczg0wIxa9Z7Ji0nnQUt1Nw2
 CaeYNOsyzbg2IBBJhPx1aUxLxm4YhYBemiKmSxiDGarpPkGd9H1fqLbyqLchrucc
 eVaI7LfDTH7zvZQ4L+1eKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779372907; x=
 1779459307; bh=0S8W4VenMFt3Lf7W1TshS3lFby/LP7C2a154lRddKn4=; b=T
 g2uOgbomEGUrowoIemvkl33tTKc8ms9PjUmRZLDKNn77VHlZ2/f+e0dJyaRC/mJI
 d4ud/xmyXObSW8hE83C4zSH+2pPvFsG2iEZ+qo0x7N3eOjDjyuwv3LZVdIjI/7mT
 zD1Yfbz4H/ltvDpeFXjKbzzPsG7c56lz5WF0wYlOxMkVfZ8DZQJY61eNbW7dp34z
 CWjiZIrzsF8sOkzoyi3cqrdOyKD7M1ia4LC5YigQLr6MlcIHPg6ELT7eKJoF+SQb
 KXEZDr73VtENk8TYP3NXgsnQR/AUeyXlHA2+tWAT5hNzBcpUUoK4PeT5JOTRkC7b
 iq0I8NRRLCHXEX/hRPiLw==
X-ME-Sender: <xms:axMPapLGDVYuROeZIc352jRI8CRbEsAL5afREihNU1WLWYaWi_fYHw>
 <xme:axMPapejdExtdDtLTSd7q8HBw6LOpKlb3WQCsQhjPAUf_pjoMXhZCqpY-hFfnYeRc
 -em6thy-2Y6FU-xZR99o9lDNBbngmHB3wl-08pip5qXBXZQKapaqQ>
X-ME-Received: <xmr:axMPag0EbPVCwdVgXmtWKZK00YsYeAawUQ3uDWYj8JP_Hv9hmKxWgn1QecLH7EbYz3FGh3VH8nyrrh8oQa-LXl-p-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejjedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopegrtghonhholhgvsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:axMPaihfbz686_wClwIPxDSnU-ohvhNQp6_ALC8wakaGzMMxRkHNIw>
 <xmx:axMPamR8R0L9u_NtQGCq-XO2bFu8crknKRJ6A1zEpc37UeaVUEkiUA>
 <xmx:axMPajhSLL_s6JcK6WHjz-BM2QyWGY0x1dpBbgjWhlJTTMYDwqYhRA>
 <xmx:axMPam7Nvv3ii79I4VdsgVA1gT5YcbwkiLHAoANN2_d6nzMjhNcNVw>
 <xmx:axMPatPccP_--las40GQudgokCp4vPJI9EdB5kCQx-5RiDKY3tIon-DS>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 10:15:06 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH v14 1/6] doc: add AGENTS.md for AI code review tools
Date: Thu, 21 May 2026 16:15:05 +0200
Message-ID: <sTDZN-zMTZqixmxLFQo8MQ@monjalon.net>
In-Reply-To: <20260414211012.951613-2-stephen@networkplumber.org>
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260414211012.951613-1-stephen@networkplumber.org>
 <20260414211012.951613-2-stephen@networkplumber.org>
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

14/04/2026 23:08, Stephen Hemminger:
> Provide structured guidelines for AI tools reviewing DPDK
> patches. Focuses on correctness bug detection (resource leaks,
> use-after-free, race conditions), C coding style, forbidden
> tokens, API conventions, and severity classifications.
> 
> Mechanical checks already handled by checkpatches.sh (SPDX
> format, commit message formatting, tag ordering) are excluded
> to avoid redundant and potentially contradictory findings.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Aaron Conole <aconole@redhat.com>
> ---
>  AGENTS.md | 2170 +++++++++++++++++++++++++++++++++++++++++++++++++++++

There are big chances that we are going to update this file in future.
Please help easy updates by following this guideline from
doc/guides/contributing/documentation.rst

* Each sentence should start on a new line.
  Multiple sentences, which are not separated by a blank line,
  are joined automatically into paragraphs.

* Wrap sentences at punctuation points, for example, at a comma.
  If no punctuation, put the newline at a logical point in the sentence,
  for example, at the end of a clause before an "and" or "but".


