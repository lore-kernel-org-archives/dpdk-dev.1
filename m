Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E72CA1013
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 09:42:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9045940264;
	Mon,  8 Sep 2025 11:42:30 +0200 (CEST)
Received: from fhigh-b8-smtp.messagingengine.com
 (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mails.dpdk.org (Postfix) with ESMTP id BE0A8400EF
 for <dev@dpdk.org>; Mon,  8 Sep 2025 11:42:29 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 39B717A0069;
 Mon,  8 Sep 2025 05:42:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Mon, 08 Sep 2025 05:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1757324549;
 x=1757410949; bh=CH9kSFaD3aPIidfRKVlQC0RsEszQPWKpEHVanU/voqA=; b=
 dNdKE1/72zIx1Hr/WKW+IKMEtB+mLYV62oy39Zl1M4KQAVE4QP0qudrX2bu+8SLL
 wN8uvhxNvHPOlQxIRFJsGOe4G8dNWkQ/aSXhAdrd0KyUUSovUuchVOnksMIToLGV
 8+UrjsLA/hxlml0mSbGk4w4CAQQzdFyJaImBZnUMaZkY86Oq78tJTPgYkWhAykVh
 DLETYFG4UZzQfR8DXeXVFSkCAcvBAHa2hEXHMBRAXAFAZ0aFzLFDG4POkHZljwAz
 +RCc7n/UMiLbKIVp/yTbwPuqIJWwRYkZAb/HoplNcG6AqyHqLEOFY32c33pT9m04
 j9ZmyQTRt1WBbpRSCDFMuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757324549; x=
 1757410949; bh=CH9kSFaD3aPIidfRKVlQC0RsEszQPWKpEHVanU/voqA=; b=N
 YRd3TcrU7CMGCRDw3SCkIatqfa144292KZEwuhrs2yYOa7o6PBUaj2x29kJrrV3U
 73MqQF624PNzjtazmkhqGH+WWGfGQcfGQArBDCh2mOWgo71PSbfk5kilcl+Ak/PU
 kRkVQjsZefo1jShXoPpnmOXPQozD6q0sMSRMc1yh4g2fVn4R80IyMlXAjmBC8lRB
 n8TkhEzXyUqQ9t+jXAzl9LIUwz+/p+0PvOpnxRVSPDtS2bQb556en0jkRGQFrgVU
 /yIjWGPvNrUp4WGLAnsZherBoqTPNzVJxONc8f+4LQJ694ZfCNvsY9XoQCRtPd8Y
 V3vIWUAs6zyk9ThC34pYA==
X-ME-Sender: <xms:BKW-aD1rM7p4-bW0owf9z9GCuK9rW-LGaI2QZq2seZeVOcc9qxgKuA>
 <xme:BKW-aHWAeEu-P2tgZ2oqwpjKfWi0KYjvvfkTcmfLMqP47ZkBfGxr0QvCZ5SBbbzHC
 TWdYuMIaHwUecmM6Q>
X-ME-Received: <xmr:BKW-aFlvJyDjo1PNh0ap1qQ7JS02411is2bVBWNKdouh8HtuZYQiNh9GOlRi3FZDbZTpJlWJc7rHC5fazqOFKE_k2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedulecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepvddpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpth
 htohepmhgrgihimhgvrdgtohhquhgvlhhinhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:BKW-aBBVKSdVsjynwDwIsQ2BOgY9XtOprwYX8m-BxbZxJXYoStMJsA>
 <xmx:BKW-aNfgn0G_0Hh2v8NSIgPt4aE4Dj0oCuhUPc8QLlCs3N6sZMzpHg>
 <xmx:BKW-aEJjDje2n8SwBHJfJkLuU0R59KrTkkTWZ-2whdy2AvRLcmBQ1g>
 <xmx:BKW-aId6vbglXscsLj7oxM5GUL8_eWZorPz3Syiw1P1RzzWZ8135Vw>
 <xmx:BaW-aADa9_hB3iJ0wgzk5UY-XHP-qltaPaLi1GXkL5cAcz7jXWpxBMyn>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 05:42:28 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH 0/6] devtools: improve Linux uAPI script
Date: Mon, 08 Sep 2025 11:42:27 +0200
Message-ID: <13838928.uLZWGnKmhe@thomas>
In-Reply-To: <20250827082413.1417226-1-thomas@monjalon.net>
References: <20250827082413.1417226-1-thomas@monjalon.net>
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

27/08/2025 10:21, Thomas Monjalon:
> The main goal of this series is to check Linux uAPI headers quietly.
> While doing so, few minor improvements are done.
> 
> Thomas Monjalon (6):
>   devtools: remove superfluous curly braces in uAPI script
>   devtools: remove superfluous fallbacks in uAPI script
>   devtools: move uAPI processing into functions
>   devtools: remove unused variables in uAPI script
>   devtools: make uAPI check exclusive to other options
>   devtools: add quiet mode in uAPI script
> 
>  devtools/linux-uapi.sh | 146 ++++++++++++++++++++++-------------------
>  1 file changed, 80 insertions(+), 66 deletions(-)

Applied



