Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF409C282EC
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 02:52:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EACBF402DD;
	Wed, 19 Mar 2025 03:52:55 +0100 (CET)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id BA90D402C4
 for <dev@dpdk.org>; Wed, 19 Mar 2025 03:52:54 +0100 (CET)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal
 [10.202.2.47])
 by mailfout.stl.internal (Postfix) with ESMTP id DF7EC1140171;
 Tue, 18 Mar 2025 22:52:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Tue, 18 Mar 2025 22:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1742352773;
 x=1742439173; bh=1VOJqcSwqRFUSg7FC7wJ2NChpZEeLmtFMyTO7O764/c=; b=
 M1nMi+7CwzVHP8wnF6qSl2//FFi3LiqH9Xp1UUg09JkSEh609VOIy0ikdyqZPDjW
 kmR5oYHne3LyGcNENAe5ivcugrerRnZO0y9nv//Sf+Si8zVMRUaq5hHcgWsYgq4j
 sfBJZs/pGx/5NjV9dlG7BFx2LfaHLCLVnmr2FpN4fiLMB7W2aTqNPjTb5EYg6dla
 I7HD+Tyw1wsQa7gF96sDhIL+LmOJzAqJkJ9GIGdI8wcGXZSQ3tVLyqgjG1JtbXu7
 D7O1IeM1OWsACqxxE3Hd4noKXphD9CLqWB3evgNImzs/FjjucXsS5uWLALs7DW5J
 MXlQc+sRKwbQf8yvBIrIRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742352773; x=
 1742439173; bh=1VOJqcSwqRFUSg7FC7wJ2NChpZEeLmtFMyTO7O764/c=; b=T
 M1lDJcxwdBW/n13ZuDbawh+GwRlr3mmB0yhK0f3xCVbFVgMAhFtzr6rjhTEn9g4R
 RkyyagIq0V/vY3FTz1jBwtDXCayHYkt933U9kjP+4duOF+ZSOdBXJJ8PIh5Q1tGF
 pyFK0/bX3ZNk5EYsGwadGKJqHmDEim34qgwtaEJ46vYKs00GWrmOdYAn2k9sjJhF
 eDycNlTWnycsTcs/a2kWJXlo7w131COMEefINHULo1OBnfj3bDoo6Hwkyo3ylsli
 QKtvdaLJ4tY+WZLIUiZOMMwjvIA4GH/gC3v9ygEDG/WRWcP9CkOnwV6Hvuv58Dv4
 OhjF+jVaF2eENVQgCsGLw==
X-ME-Sender: <xms:hTHaZ4BgZgt1Hw1zKYF0Rjxy31coVBFu6mY__GKqk7fDqopXB4QOdw>
 <xme:hTHaZ6gyQBO977XDQDbDfj-w8Bc-BnyKILyUBxmKf5Ba11JqjHuY1F1grRKcnkM48
 -vsquPIk6cEfiqAMQ>
X-ME-Received: <xmr:hTHaZ7nZGDrSldpnYPD7uuVXws4YwW5AGWoFihmtMtWWLFPsSKcq5UVdALhSWkErEcPBNzGml12WiISlrQokqwdEgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeegudekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnh
 gurhgvmhhuvgeslhhinhhugidrmhhitghrohhsohhfthdrtghomhdprhgtphhtthhopegs
 rhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopeguvg
 hvseguphgukhdrohhrghdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhl
 uhhmsggvrhdrohhrghdprhgtphhtthhopehvlhgrughimhhirhdrmhgvughvvggukhhinh
 esihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:hTHaZ-xVoHn4qxqv1a5WQ9aBCtQ2kAE7fx8YmRcZOnplJZ4odN2Ktg>
 <xmx:hTHaZ9RhSvCo3Luk37WIO3YWZ6GGdEL2FA21LQE1LIBT5L3KuWHLiw>
 <xmx:hTHaZ5a75qtFL2w55F8r8W-CEe3JvvetyjShNlTDuWe5ZvR9M8DSGA>
 <xmx:hTHaZ2Q0rPIT102cpzETIAcU2N1D4tnpVaiU4MQlNZCBVoJGH85m1A>
 <xmx:hTHaZ2Kjt_IdbDOe2stmwQC2V_6Yvz2Yw6LSfFx5MLdRmC36eVOv5acv>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Mar 2025 22:52:52 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org,
 stephen@networkplumber.org,
 "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3] app/test: fix stack overflow in lpm6_perf_autotest
Date: Wed, 19 Mar 2025 03:52:51 +0100
Message-ID: <7218775.tWeucmBOSa@thomas>
In-Reply-To: <0513cfe3-ea93-42f5-b052-20df56fc7127@intel.com>
References: <1734057571-20367-1-git-send-email-andremue@linux.microsoft.com>
 <20250305144531.GA32194@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <0513cfe3-ea93-42f5-b052-20df56fc7127@intel.com>
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

05/03/2025 21:04, Medvedkin, Vladimir:
> On 05/03/2025 14:45, Andre Muezerie wrote:
> > On Wed, Mar 05, 2025 at 10:08:33AM +0000, Bruce Richardson wrote:
> >> On Wed, Dec 18, 2024 at 07:21:26AM -0800, Andre Muezerie wrote:
> >>> Test lpm6_perf_autotest was hitting a stack overflow on Windows
> >>> with both MSVC and Clang.
> >>>
> >>> The fix is to move some of the data from the stack to the heap.
> >>>
> >>> Signed-off-by: Andre Muezerie<andremue@linux.microsoft.com>
> 
> Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

Applied, thanks.


