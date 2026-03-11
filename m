Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7997C104BEC9
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 16:54:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CB7A40A76;
	Wed, 11 Mar 2026 17:54:28 +0100 (CET)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id B261A4060A
 for <dev@dpdk.org>; Wed, 11 Mar 2026 17:54:26 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id B90057A00FC;
 Wed, 11 Mar 2026 12:54:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 11 Mar 2026 12:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773248065;
 x=1773334465; bh=Ywj6PHZSAXpsEzbR0B1fSI0V5yBSEQBL/GcdMGJ+4Uw=; b=
 AQOvVZ/v9h4+sVZF5iLlzjEmoavYdKy5GxrAko0GzJRoc+TPOeutq8JDb7LsC82f
 gHI7PS6MyOIqO0D2Tl3Yehu/kXQk0/saY0bqYZJeZzBImbbbDvyuQK2AZdMjcG+k
 bGIwoR189zul0CRh9YMkwUvMYAXOp7N0eYGVkcooNEPgBRRsqSpXdIx/SMF2KsHs
 lIplTorXA8631TzEK7RgcvEDOU9qI4uCOtGe5GOjaziZr4k338NJfAIRfMMb2yOZ
 4UqM1+t1ipu75v9iospfchH/P3gWtdjmzvNyfjh1k+BK7VGQEZjpdJju2RbTimI3
 mlP2MbYd/o4+1pi69WI2Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773248065; x=
 1773334465; bh=Ywj6PHZSAXpsEzbR0B1fSI0V5yBSEQBL/GcdMGJ+4Uw=; b=X
 PBlUTHaFerFkOUk8BqE6PXo/rtdTvKiLgojl6SG6wPg6QUoO/42igC3Vs4mkHTzN
 EMJUZSwAMxc/RBiOzU8KY/44Wpsu2Mrri7woYR1tnQrix7YjKGccMYpUJMODH9oF
 f05npCR6IPr0z8Ys4OSocYC0ojaGPjXzD5ZLaa2uNzSAuSrpeuZTwBWHnvA9UBFV
 GfHkHquDAsDooZIZcIww3jX3uDV2es1566jfNoZ3TziXp4IuUqWtcCmPyfhDKydI
 X0e7FZuZPu9KhRwHbrFu0NJ96hHAimO5Uaz9d3j0czu7U3pa3XsFEqIrtSpYxvcO
 6n1GIaEsx5zQ9DSPF94eg==
X-ME-Sender: <xms:QZ6xaRN9mhZnUSF_35TTopNh2p0mcDDqECzkshfNEaGJaHJTNBG6MA>
 <xme:QZ6xaeCy94Wrj16Lel34riQX-ruu9f4qX56xrZXE1Ttn2nBNlJ-0Td5XMb_Pvh4Rv
 qQCvY6XFCZT8azVPKheR7eGmhm9iER6y9rMRerTJKrggYRKSvOziQ>
X-ME-Received: <xmr:QZ6xaQLFhi_llRqDrEodU-njfGvnQOiDkwEpdfMJZwEwqXbYb5IQXm9AtEeeUwzinVFGnwsfLeb_J198EwYmzDIQpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeggeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeekpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopegrjhhithdrkhhhrghprghruggvsegsrhho
 rggutghomhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtth
 hopehshhhurghnghhlihhnrdifrghnghessghrohgruggtohhmrdgtohhmpdhrtghpthht
 ohepfhgrrhgrhhdrshhmihhthhessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepsh
 hhrghhrghjihdrsghhohhslhgvsegsrhhorggutghomhdrtghomhdprhgtphhtthhopehs
 rhhihhgrrhhshhgrrdgsrghsrghvrghprghtnhgrsegsrhhorggutghomhdrtghomhdprh
 gtphhtthhopehkihhshhhorhgvrdhprggumhgrnhgrsghhrgessghrohgruggtohhmrdgt
 ohhm
X-ME-Proxy: <xmx:QZ6xafOoojm_6KSBCzrkzZeXRx1uhzNSdaIoBWrsaKoo4K8dMPe2mQ>
 <xmx:QZ6xaW7_nLutG_stm6FS9wyM0RFTLDRFFm84--nlJJhM-4_1hRN4Iw>
 <xmx:QZ6xaZ6zpkFoneBrVBgFbldLC1HcEZVsyJ8V3fGAEFbNRYsyIWNG-A>
 <xmx:QZ6xacH8QHtiTkndzClUn1pcanlB9lWQuE9r167AIHTNYEc3TfCefw>
 <xmx:QZ6xaUIwRj75VnBjjHaVByDqaYjRKaWN7GUmmSE0DjaUVcHkbamCcp9z>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 12:54:23 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>, dev@dpdk.org,
 shuanglin.wang@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Shahaji Bhosle <shahaji.bhosle@broadcom.com>,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: Re: [PATCH] net/bnxt: remove unbuilt source files
Date: Wed, 11 Mar 2026 17:54:22 +0100
Message-ID: <2820895.mvXUDI8C0e@thomas>
In-Reply-To: <CA+BST0=5mgHmmzjiTrar3-ufTgZjOtUWgZhuKTc6U0Xnq9SLug@mail.gmail.com>
References: <20251114175112.1103784-1-stephen@networkplumber.org>
 <CACZ4nhtooChGsnDsSHfDy_ZYcFGzqKxuWMO-GagGkUHrbDgNQg@mail.gmail.com>
 <CA+BST0=5mgHmmzjiTrar3-ufTgZjOtUWgZhuKTc6U0Xnq9SLug@mail.gmail.com>
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

> > > Several C files are never used or built.
> > > Looks like they were converted to header files but the old source
> > > was never removed.
> > >
> > > Fixes: aa49b38fa7c3 ("net/bnxt/tf_core: cleanup external EM support")
> > > Cc: shuanglin.wang@broadcom.com
> > >
> > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > Acked-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Acked-by: Kishore Padmanabha<kishore.padmanabha@broadcom.com>

Applied, thanks.


