Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1620F109E527
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 22:50:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D6C140FB5;
	Wed, 25 Mar 2026 23:50:14 +0100 (CET)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id CFF8A4067B
 for <dev@dpdk.org>; Wed, 25 Mar 2026 23:50:11 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 7C324140025A;
 Wed, 25 Mar 2026 18:50:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 25 Mar 2026 18:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1774479011;
 x=1774565411; bh=lu5UrjtpPrIC6VAUoe1Ucjpped/h7ILXM3HKoPaffxs=; b=
 dLKPggooAoweTEStu0ITAE5kLZhrVcAMKyXAsdhe0aEQVc46EwC0MMBS9nhxbiWG
 jEQE8Zdn2xANoQVERIjWE17aBQy3/Uup1nYHkFuJugaUSALqHvKkfFmQfHg2UeW2
 CMudUorI3ZemYljUQ0DJHwZHe6QbZEsMw3broJvVDVNH6328me42obfD22FjkXY/
 0TLpaU4VoZTNQR0sF/+cC7+RCGSf3gyeK4zfvPtxFIZg586Ivm81VbfVm+YpIpoJ
 qF5bZ4aR4VSJ/wCgfJGFLUaT4Tf2EV4RYWle0ry09bX4WijOwJEnO81SYn1zuHTj
 +GOQaorEUlI6+8z3cKYWVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774479011; x=
 1774565411; bh=lu5UrjtpPrIC6VAUoe1Ucjpped/h7ILXM3HKoPaffxs=; b=O
 tyzkmmv/fy9cnZKyrOvWVD5Zc2a0LMOioLNCjhMPiU4zGRdhI8EW0AirecQDiavv
 B0AOQuAByCHZcDf6A5YTgCVtVFqFbihKWm1w+4qKgjPDMmOn1Q4PwKU7qXDcdjX4
 2gMTVifJ8XA3FPDL0GRLyYACJrg68gQJs/lhMnVZEQ+qo+svN4XMM8mb4Gm7l3UY
 dTRZX6HAlaxgP/Kj3sWoX+BfKbjJFDhBVVdSlp9/UiNKO1Xgs2cvFJb4yIlpypkA
 x70wri0GRal2t+HJc6QpyNfXT3chTzIFQVcuW2ZwUg02C+cDzRoFQOOx0wbEhIHU
 A/RaMjlYSpffTh16aOp+w==
X-ME-Sender: <xms:o2bEaZw4zMGUPZEwivGiNZYiLRe5A1frBQLDIcF8XTTzIZVCyNk6Vg>
 <xme:o2bEaQQDz9k_TpyKdgzX9QweRt2JJiY4LK5ngX5gn7to7WMpSiql7iRsPX_gXtlRF
 8LIIdokwBruFkhWS8Vj05ILadF7S_MvUAukemduEhQsW_euC7KgZKU>
X-ME-Received: <xmr:o2bEaYXuc2djwXz-K-S6432xm_ik7Au9kM6gsTeoyfY6q1VAo0OcJghBKpUaNjkbPz-InllkJKTtJXFqvK5YuPvvGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehjeduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtoh
 epphhrohgssgesihholhdruhhnhhdrvgguuh
X-ME-Proxy: <xmx:o2bEaaYaZEYMvvCI86bHZvYoUMWLz3FgUO_xkMuPDB4bAYZ4rRUAvg>
 <xmx:o2bEaW2y2RrVI_V_oZ3YbmbirsjhhtCJJo56WI8wzJOurWNUNRlvrw>
 <xmx:o2bEaUg0EVZfoRUT2ljsCLUz4GTlgcN6s9R7sI7y8yUMni8iJTeOkQ>
 <xmx:o2bEaSYGl0TQJUBeLmayMDBqzvkzHmIU3CL4k_Ml1NWwXjAaTL5EmA>
 <xmx:o2bEadmYqB_iVldW4dHFC2g3k1Om6KA5vBUY2kYLI0jf5FAviC5auuV_>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 18:50:10 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, david.marchand@redhat.com, probb@iol.unh.edu
Subject: Re: [PATCH v2 2/2] test: simplify spawning extra test processes
Date: Wed, 25 Mar 2026 23:50:09 +0100
Message-ID: <4029978.TLkxdtWsSY@thomas>
In-Reply-To: <20260320161108.331745-3-bruce.richardson@intel.com>
References: <20260319171334.1151425-1-bruce.richardson@intel.com>
 <20260320161108.331745-1-bruce.richardson@intel.com>
 <20260320161108.331745-3-bruce.richardson@intel.com>
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

20/03/2026 17:11, Bruce Richardson:
> A number of tests require secondary processes or additional primary
> process instances, so we have common code for managing that in the test
> binary. Simplify that code a little, in the process removing dependency
> on procfs on FreeBSD

This commit deserves a bit more explanations I think,
saying the obvious about lacking MP support on FreeBSD and resulting dead code.



