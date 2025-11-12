Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C575CCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 10:24:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 057424067B;
	Wed, 12 Nov 2025 11:24:10 +0100 (CET)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id 37F7C402B0
 for <dev@dpdk.org>; Wed, 12 Nov 2025 11:24:09 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 998AE1400154;
 Wed, 12 Nov 2025 05:24:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 12 Nov 2025 05:24:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762943048;
 x=1763029448; bh=gMhr1bYXo71qWYSeNK/IkUaCakOgx/NH3XcNDQ5oXG4=; b=
 tMbDYgNvE1GMG53h4bV/cqdkhDmNJAITbZ5O5KS3DKr9O01GBHTRuZdelaSjJQxV
 uBCYus+j66GgKIUHP/Lm9DC602Vjci7AZ8XC4iyPSDovXZ37QaOnZZianlMljfZg
 ZaH7L/dmy6WKGx41VF58u4g+ivqKLawZX0MKPIZEKyO/Nplqt7ZYj1kuOVpFQxLT
 Wz4JZDqB32rdHZh0VHW0NzCZsLbvw+/UzTxV5hyLJfM6RtuuruXObcLMFgMOIk7N
 3C1d9rBMYNNT3AKfZoz0hjmO7ErQkdoRMCYA+TvO3KSOuVIYwmC0tvwYUegGfV98
 oY25zYoUbUyelpYYAFC2IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762943048; x=
 1763029448; bh=gMhr1bYXo71qWYSeNK/IkUaCakOgx/NH3XcNDQ5oXG4=; b=t
 thXcPqGyX1Z+nYdxjoWTFoichBYQNeI7reig7Swb1xa7M04cB5kXkUIXYNI1uIWp
 mTHs3ZWbHIHwoiLmBBTybpkhb8tFPblFto6LoiXI/udem+r4h2mKgJSjJ2LogVmf
 aJY1ZT7onvrXRAcOs/yG0dg7fHysSJEBSfrK3bYdEZRvZX3uOQYEbmdhYOo66Vc2
 I3KsBgIh5m63UNW8A6/SoZXkfC0mUwiCmx2MOaBvIHQqSgr5h6cpkBZn02eOMdME
 dxvAFsfih2H3Qq/ictSAHaVLK34oE2UUCMZ9MuqPeHb6T0gNOQNkAYLIsAY0fHDv
 MyR+t6E3wdSmAWMO564zg==
X-ME-Sender: <xms:R2AUaVc0xGypZ591HH-L2BnhrHkg9RvVbyQYaFvZ2QtZPndzWJtEXg>
 <xme:R2AUaerAWpdi3yfY_AFro0rNzURhF-_I2TPXnx7KMbMUgFq16lAdVmGsPpEURxxT0
 FW4eSRo90q6Qp8X7vJNx32y82M7WpPwo99LobTfdYT8_bt8d04ZDg>
X-ME-Received: <xmr:R2AUaSBzmUZGwDCwuIcoBDWDvs7my2MN2pPkBw880eDF2B4ZaQs4Wib4e7MlH9i7H6x4PghimaBHWlPyUCnsonRqWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdefkedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehgvghtvghlshhonhesnhhvihguihgrrd
 gtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepmhhkrghs
 hhgrnhhisehnvhhiughirgdrtghomhdprhgtphhtthhopehrrghslhgrnhgusehnvhhiug
 hirgdrtghomhdprhgtphhtthhopegrnhgurhgvfidrrhihsggthhgvnhhkohesohhkthgv
 thhlrggsshdrrhhu
X-ME-Proxy: <xmx:SGAUaTarcekjyVb3idOB6t51uckSAEI8Y6R40T0BG3cAg6dmP1v0kA>
 <xmx:SGAUad78EtJUKEOYDDZIJwhuE9evgPsFRcRjZhEoKG2Ns1wp2_O4Sw>
 <xmx:SGAUacZIjqddNiFKFS1AcYVlfD2uNFWeaJxKAWsTwX2fWuFSz2_llA>
 <xmx:SGAUaUidlCz2rNFO_7xNyJz1VoRiM8RpaO9fL4GzMhBCM0ijQ9x3OA>
 <xmx:SGAUaWn3nA4iqMvNBk95dhtimiswOSvFgPesLqvt7wxNTt8ZJMImM0rn>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 05:24:07 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Gregory Etelson <getelson@nvidia.com>
Cc: dev@dpdk.org, mkashani@nvidia.com, rasland@nvidia.com,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v4 1/2] ethdev: make representor parameter more explicit
Date: Wed, 12 Nov 2025 11:24:05 +0100
Message-ID: <23140020.huCnfhLgOn@thomas>
In-Reply-To: <2506bb2c-2dc0-4f3c-8e54-25f5a9949462@oktetlabs.ru>
References: <20251028095831.53669-1-getelson@nvidia.com>
 <20251106055246.360824-1-getelson@nvidia.com>
 <2506bb2c-2dc0-4f3c-8e54-25f5a9949462@oktetlabs.ru>
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

09/11/2025 15:42, Andrew Rybchenko:
> On 11/6/25 08:52, Gregory Etelson wrote:
> > The current format for a port representor parameter is
> > '-a DBDF,representor=pfXvfY'.
> > That parameter syntax describes port representor relative to
> > PCI device DBDF.
> > In that notation VF Y belongs to PF X and PF X is relative to DBDF.
> > 
> > The syntax 'pfXvfY' will probe 2 port representors: PF X and VF Y.
> > If we want to refer only to VF Y related to PF X, the parameter must
> > be '(pfX)vfY'.
> > In this case only VF Y representor will be probed.
> > 
> > Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> 
> Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

Acked-by: Thomas Monjalon <thomas@monjalon.net>


