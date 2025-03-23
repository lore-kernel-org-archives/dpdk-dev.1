Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F9FC28B30
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Mar 2025 17:12:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98EEE40277;
	Sun, 23 Mar 2025 18:12:00 +0100 (CET)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id 5E3AD40150
 for <dev@dpdk.org>; Sun, 23 Mar 2025 18:11:58 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 98CB02540109;
 Sun, 23 Mar 2025 13:11:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Sun, 23 Mar 2025 13:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1742749917;
 x=1742836317; bh=KHmUGg7eV7MKM4JbEMuCsXSZVKTJtRW08A17XleIQSY=; b=
 ZVRtxGOB9aJsOLKov5nBNcpKRm2y4B6beE6aY1TJqpPt1YWzPYz1etLmfGJu4/vy
 Mmqy1FPLFO4T5aKR8vLQOiclxHCqMBQOGgPBu1B9Rdl0662m1xJSeSaSlT4tdTY4
 MJGT7Yhhmee1nbFz9dh5zPt8h20rO0JwSIavUyUl2U5tsUEzxaMM2oWhiFmjU0fe
 3X3taFNyjJ63lJwXFfM4wGDTLVElPeeAIkIPxkniu3FudXnTDuZpOrbf7km16cfV
 cB47SmHHS2WnaAlPB8WQHxdD5S5ihjKVwm1UXWirfO5aTnq35CkdQcx570NQGKdR
 FERnWeL/6pcHYPJjw6c6sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742749917; x=
 1742836317; bh=KHmUGg7eV7MKM4JbEMuCsXSZVKTJtRW08A17XleIQSY=; b=p
 8ZWMqNbFFYJ/PfQBPIRLspNIbc+E5O353YeNZ/JX3h42wePaxpoTFOLyzihizcwc
 yi1T+5YOEfgivzLWzARLJLo+wZi8P6qLESEFlxRs4x58f0sLioA8nfovaVYVj4i5
 w/eMbD+jrbKezpUgLR15JH9HLnBVvWcmmnl+O3rmH2rePYLFrJV0lLGTQwQjqMxB
 /AEQnO8ui6iyYNvJgWls9Mjxe591zIHrC/N7xGGACJS/EX5DTI5iTxYqUtfkh3Lm
 rDWEmypbOgPNTQCBv425f8XCmfwKosZ4KnutjITYbmR1f0+clpOZizoEE7W0TBw+
 gkfsPRrVQZ9a9artofqUw==
X-ME-Sender: <xms:3UDgZxPqx9LlEYP-ZEix9tgovCcLEFv21TCY2jE94mnvjEeMFlFWiQ>
 <xme:3UDgZz_Y5ear-BQUJCo_UJHoysEOwx58srQbiEkrO6nmhX8AheQG8pnAcu_wofm5n
 wHEXr7SSsximrCLcA>
X-ME-Received: <xmr:3UDgZwQFmsPf-ZSA9ToN3gPP5750QdYX_PYMKOeYjWpt3Kbgm35dOiiirFZXpyEnP8dib5pWTJzk-ZifaPJkt_UnmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheejgeegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrg
 hslhgrnhgusehnvhhiughirgdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhr
 gh
X-ME-Proxy: <xmx:3UDgZ9smqQUbNZBTTRsh9YR-HdwZKXBwwC91FHTokjg1pLilLSpriA>
 <xmx:3UDgZ5cRFloiY8Vns7WV_JL4Jsv1fc8uDcbSw2l40yLenoXM0ROk6w>
 <xmx:3UDgZ53DTdkwONYW-Njcv9vZ4kVrzVkxlibPh28VO9cS_XymaSyDRg>
 <xmx:3UDgZ1_pNFHMG4k0meiPl2zGZDIy090QUCVtuiOJD_60I55fFX2ajg>
 <xmx:3UDgZ6oaY2LqU8rYic8PWLTqpNmiqS2OUOYH02YyabfK1wGPbb6HlmGY>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Mar 2025 13:11:56 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Raslan Darawsheh <rasland@nvidia.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] doc: add tested platforms with NVIDIA NICs
Date: Sun, 23 Mar 2025 18:11:55 +0100
Message-ID: <26331382.6Emhk5qWAg@thomas>
In-Reply-To: <20250320084446.82777-1-rasland@nvidia.com>
References: <20250320084446.82777-1-rasland@nvidia.com>
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

20/03/2025 09:44, Raslan Darawsheh:
> Add tested platforms with NVIDIA NICs to the 25.03 release notes.
> 
> Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>

Applied, thanks.




