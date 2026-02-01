Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63750E65266
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Feb 2026 13:51:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BDFE402A2;
	Sun,  1 Feb 2026 14:51:15 +0100 (CET)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id 2F6D840150
 for <dev@dpdk.org>; Sun,  1 Feb 2026 14:51:09 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 15BCC1D00063;
 Sun,  1 Feb 2026 08:51:08 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Sun, 01 Feb 2026 08:51:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1769953867;
 x=1770040267; bh=ubmu+bLgBRMBu8tCnMwnLM6KFOziXPIjTI7Xu1Z9k/0=; b=
 EHTDHKS5Ua/onofPRRqX9f08ZGL5X229FjcqOg8RJsWyTlE6bpUBnYIFAaaMad9l
 xsyJEK8/YpbOPJtPMtfrMUCW/S+4jM86b6n1DlUp1uCEwjSZ5pTaZR3H2bK6sN7B
 oVHDB/z/Dmrd93gu/HY03rOs2oPvAwzPjRoACAf5pLFGB0qhrD/df+2OtL0mBLB4
 KjXEo7wDkVZXJbaPZHqk9VrqFOGmvdg7HREXEHuw2FozbxsejlRixDvt0IBAgkiM
 Z8HNlVM3DTT8Uyha3Pcs2pp6vhWD3CzNLpWlqEENzzFTM9Ud1DSKkfQius9LGvEg
 VWONnyKehma6udQTdEh7Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769953867; x=
 1770040267; bh=ubmu+bLgBRMBu8tCnMwnLM6KFOziXPIjTI7Xu1Z9k/0=; b=o
 a+qvx6LIEbXth9GCY9QtJnqAJZT2gdRPOBgwE5bd3MTFZ9veulvLpAC2Rpn7u9VR
 WhV3BjU2CJG4E+3pvwSP1nunc3Na/enO3yPZgit36UlIe2KAHzmBXDZQR6A/RPaz
 2Llou5m9Y+nrbk/tdAx4+HdBNBKBR3ODBGYhg6Aq8ugy9n9vm+jC+kvzdaRPxJja
 mdKbfxIGuCLkp9o9Ke37V5+V5siOYSwZ9VrBHg37nW2fWuXim/+REKL5Q5ok9Hu9
 7FBDLZr69c6shgX7F+rq4y9d4zc5MHkfKWc1TaNaXAz23lPRjtyM/TDGff2mW74t
 OuPDLlTkZo3eMgsy0SC6A==
X-ME-Sender: <xms:Slp_aegpNgZQERoLAj-O_whApcnbz1piEn1rMdcQ8HT0bpcIpS3ofg>
 <xme:Slp_aaeVLG9pMtDNJudPqV-1NUB4j82qHSFbbEtV02cZAkteTsh7b0Ac23bRfVxRK
 U763nphntzedQALMsuwwzsy8BR5pZX7ctenYH02K4NXn_8YWHHYNA>
X-ME-Received: <xmr:Slp_aZnVTrQ5Uqq7H4ptOMP1e9Vu-dugcVgl_ZDhbWQS6o888RssteDjIAT8oWzA12gk58yuQMXvlNaE4sCp7wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeegleehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtth
 hopegrtghonhholhgvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghvihgurdhm
 rghrtghhrghnugesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:Slp_abtOsUvAI-sa1O5aRL6HYdAYaz3YzMlLc_5-eWRZDl5T4bEIsA>
 <xmx:Slp_aX8aseg9Y-zSBp7i7mob1B4JitYS8vyoMfgXt_hRbjdIGXg7Tw>
 <xmx:Slp_aVOM60XU9dX44aOrewBOhEDvsRPVb__xKpVCWhSReNGeUSxi_A>
 <xmx:Slp_aVEO9_DZhAJOnRj4Grmeue_6ei7EYp3poS54l5vRX1g1cB2UIA>
 <xmx:S1p_aVNSdWXHrSs1y8-hZTtQI9QD4xsOTqSDpWYlU8OHl6-vilqygH27>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Feb 2026 08:51:04 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Aaron Conole <aconole@redhat.com>, David Marchand <david.marchand@redhat.com>
Subject: Re: [RFC] devtools: replace get-maintainer shell wrapper with Python
 script
Date: Sun, 01 Feb 2026 14:51:01 +0100
Message-ID: <3273409.mvXUDI8C0e@thomas>
In-Reply-To: <20260131204823.29363-1-stephen@networkplumber.org>
References: <20260131204823.29363-1-stephen@networkplumber.org>
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

31/01/2026 21:48, Stephen Hemminger:
> DPDK has been reusing the Linux kernel get_maintainer perl script
> but that creates an unwanted dependency on kernel source.
> 
> This new script replaces that with a standalone Python implementation
> created in a few minutes with AI. The command line arguments are
> a subset of the features that make sense in DPDK.

Almost thousand lines for this new script.
Are you sure that's something we want to maintain ourself?



