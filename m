Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C23FF8875
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 09:58:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED1D540395;
	Thu, 30 Apr 2026 11:58:48 +0200 (CEST)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mails.dpdk.org (Postfix) with ESMTP id 50F124021F;
 Thu, 30 Apr 2026 11:58:48 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id D32CB1400060;
 Thu, 30 Apr 2026 05:58:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Thu, 30 Apr 2026 05:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1777543127;
 x=1777629527; bh=4Um63M6r7OpbyFiN4h0uRNkSr9XOdkGAFYnk1vnYgZo=; b=
 r/DnLrmTaM503Q6Ihi152vWvm1+EoYmjWYFuuQ3EUrJSg4yp1KBhcNg0WTwGrbV9
 kxHauaaw47vCp2w0sVT/8UBH583nHJnmL16W5aRHYuHHsQqbO1BFph798rjnDVJg
 qC5Nzj1XvEqRmcOdkiOs2PdTfrFEPUtij3scCmvvkEuaw2JG8hTknnhe/OvcoXx4
 z28MVqqK69JAGsdx0BpxkQltmZaqxKxXQ3DCtAF6f+82R1RyjH2vLHgs1wXUGhss
 6A92kzcTf2pHxQi6Of54S30uiU268VDhm6hvok6UC/finU9lUMVfU2hI9okxgAmE
 1TPacCDcqY5aN0WXD46SDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777543127; x=
 1777629527; bh=4Um63M6r7OpbyFiN4h0uRNkSr9XOdkGAFYnk1vnYgZo=; b=g
 JUq5m2Mq2xlNYH0LDTqdHYXwNkc5aNr/uPhdkPXIa1BQghuGeBi7JGZ1wC1daRbw
 SM1DX54QQjHzA1OVGPKSSbJ6YkWpwatv5lCUHHyrkWMpF485/C1V3ZMkn98NJgvp
 TRftnsTqLfvMSPcP2FdevG4wN7uVZWzrQbXjquq7a2gn5w3N4QMSI5lXFGP1wHo5
 bSQVeMlscHHOPgZD/ytmPDXDuuA20FsKPFzuvIh/8VIJpLqjWKmBcAGdLmYBevbE
 fjVPCYhIvcFhEs1RnebvqJFyCg4JlCa75PHNKcd5yg5XYHckX2GjMiQqANuVSmif
 AoKUgPgQbEpxkHEqPfyTg==
X-ME-Sender: <xms:1yfzaf_TGxHa-TMRKdHBAnEPPsxBQtWLgzh0G_mjQiAoI49zfFU30Q>
 <xme:1yfzaWp8lGnEy3ZHzF7j1HoXYNYJWPiMoyiNwkM6qRb5cDpzwHZXt2SjFyjetifrK
 axVAT0OPAN_osyLj8dvYLLgN2QpMam9WSekoTwYBAS_lOTx6mnZR78>
X-ME-Received: <xmr:1yfzacCrwAeJ2A8HeUP3pn0a2hJcOj-IbEvwtkVYH7oQlFoTQcheOiV3PqLoBp2ccUR93vXF7U9QFlja-cGWCF9TOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekjedtvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepjedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhphgvrhgvthiisehnvhhiughirgdrtg
 homhdprhgtphhtthhopehkthhrrgihnhhorhesrhgvughhrghtrdgtohhmpdhrtghpthht
 ohepshhtrggslhgvseguphgukhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdroh
 hrghdprhgtphhtthhopegslhhutggrseguvggsihgrnhdrohhrghdprhgtphhtthhopehr
 jhgrrhhrhiesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrvhhiugdrmhgrrhgthh
 grnhgusehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:1yfzaQylJTsFPp3C8CJp02wrsCFv2jjBv_sF_q1ucj1gn81ZmpNeAg>
 <xmx:1yfzaR3qo3vEdjj0yeQoVJQ407REcekONihY5lzeAYKTh3a0g_GaPw>
 <xmx:1yfzaYwqjHDsYoM1RY-f08pXtyMMRbZj8BPa_qZfTEQxpegowZSIuA>
 <xmx:1yfzaQG6rMKdBXVWBBq0_qFTFwbav6ACLKJS8C0dRA-VZbHobwbMrw>
 <xmx:1yfzaRg7afmRCCpJ37uNofebRf0K5LglHZT0hfIv1sXq7SfGCQHx0rdb>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 05:58:46 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Shani Peretz <shperetz@nvidia.com>, Kevin Traynor <ktraynor@redhat.com>
Cc: stable@dpdk.org, dev@dpdk.org, Luca Boccassi <bluca@debian.org>,
 Robin Jarry <rjarry@redhat.com>, David Marchand <david.marchand@redhat.com>
Subject: Re: 23.11.7 patches review and test
Date: Thu, 30 Apr 2026 11:58:45 +0200
Message-ID: <2787587.q0ZmV6gNhb@thomas>
In-Reply-To: <73da1ec3-d1cc-4efb-bedf-89b0f951ec5d@redhat.com>
References: <20260421064637.2506152-1-shperetz@nvidia.com>
 <73da1ec3-d1cc-4efb-bedf-89b0f951ec5d@redhat.com>
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

30/04/2026 11:32, Kevin Traynor:
> On 4/21/26 7:46 AM, Shani Peretz wrote:
> > The planned date for the final release is 30 April 2026.
> 
> As discussed on thread [0] there was a quite serious regression caused
> by "net: fix packet type for stacked VLAN"
> 
> As discussion on the fix is ongoing, I would suggest to just revert this
> patch for your release.

I agree the revert is the best option here.

> It doesn't require a new RC and re-validation as it's an isolated issue
> (and there wasn't test cases to catch before Robin's new patch anyway)

I suppose 24.11.5 and 25.11.1 are also impacted?


