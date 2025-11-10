Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7B8CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 09:29:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3A464060B;
	Mon, 10 Nov 2025 10:29:24 +0100 (CET)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id 496A4400D5;
 Mon, 10 Nov 2025 10:29:23 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 7B33A1D00118;
 Mon, 10 Nov 2025 04:29:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Mon, 10 Nov 2025 04:29:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762766962;
 x=1762853362; bh=MxvsW/J8Y/DIo05k2U5r/QluCiVjwYDNeJyt/zmTsps=; b=
 puvYgZ2vfjVmqc4mWa2BaKKcMVWMZOApdxaZe/3LsFEKb4R3LJQXGYm7oPR05UsI
 SGhSnYgVftHvCr3/Kotmbad7Uhsgkp4H9XBdLs3KGkWIxw14DwyBWbMiypyxzstV
 CvyEnsIbKNRKg4BIj4N0alALxW2VlrGpAzFUF6S12/Rf5+NnyL0ekZQijTfZJ3RP
 PqdV47ptPbr/DyvOKCLH7Bb4583mFyVH9+RIHYqBOtvu0MTS+opkyUBK9Dl1dJel
 NBEo+U0Qh9OlOv+1u+bo9bK7lzNSqo8iznMdBhMbCXhoCQdHMO/8PfAg8hDgDntW
 uB/yaRbecMcn/0RKMwGK5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762766962; x=
 1762853362; bh=MxvsW/J8Y/DIo05k2U5r/QluCiVjwYDNeJyt/zmTsps=; b=R
 3Xm8sk7/lMrII72xGOOd7IoiSB+DdF56vdYVXQ3ISNv2M9yIF17w/+PFmam6oLrW
 N515K/5jEL3AlDsYNGfJXwJyuFm6q9skLP33lpAfHR3zluInMrj7+xdkOwGVSmKT
 tvxkwat+Ev1xkA/c92O8h9tNdiZrYawyKEM5BVrTdXctpT9rVLYQcQ8bTNZVzNny
 EKVbH2YU1qOLQ00hW7koibuFdzAB7Umkp/V30WnklhPsAeUPf5U+Cm6Uw6FgwPMs
 rb21+LHU64l3UAAfye3fhSDNbc+qG1diAusrgBk8ZZWrAjeDry6bzZaOBbvoEdX/
 Ue/56TrdkCyBM3+uX2cYw==
X-ME-Sender: <xms:cbARafBF6qnybOZ3tc8Jq_M3sY89Gow0kLzRYQoYuxIwm8s969JKug>
 <xme:cbARaQ-1a7seLBnv8p4mOTVuy5DSW6f-5lCB-RW_StU5i62kl_ndBxZtVirBj9Jqd
 ERm1_y4tpTbVEwz2zt5Itwm1q6bXYZ7dbDJz9tnZfeg64PuuO0chQ>
X-ME-Received: <xmr:cbARaeGkRgWtpDBFBvapNAPuv7WxNYmRps8IwVUCg4sqnUPKxcVDt6Rk1Hdd-6XY_g3tWKIXkHQl67UZeNrnY0Yd9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleejleehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehjihgrfigvnhifuhesthhruhhsthhnvg
 htihgtrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohep
 shhtrggslhgvseguphgukhdrohhrghdprhgtphhtthhopeiirghihihufigrnhhgsehtrh
 hushhtnhgvthhitgdrtghomhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhk
 phhluhhmsggvrhdrohhrgh
X-ME-Proxy: <xmx:cbARaWNAz-_rCL8fefhXfsd37MGiZY-V4OmqoeD7ieUYemSgf4vVdg>
 <xmx:cbARaQfvbSemZC7FCwCLlmkdXM1L6IMVYwzefUfdiqS1nStog5CyyQ>
 <xmx:cbARaTs6pIDcNreKZjDxl8denlwlFZJv2k-iH0Iukj0bNkEk6oXZsg>
 <xmx:cbARaRmKt1-1mxIxx9Es-o0UTKUOtWT1TAr4qUnxImgXrQr7Yne1Vg>
 <xmx:crARaWxxWUQzZ2TmhDKQOkKki-T2AH-fbvgqfqlIqKhW4ul3qek41B7s>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 04:29:20 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: dev@dpdk.org, stable@dpdk.org, zaiyuwang@trustnetic.com,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH 08/19] net/txgbe: add device arguments for FDIR
Date: Mon, 10 Nov 2025 10:29:18 +0100
Message-ID: <4063720.8FI41Ny9JD@thomas>
In-Reply-To: <20251027031542.10512-9-jiawenwu@trustnetic.com>
References: <20251027031542.10512-1-jiawenwu@trustnetic.com>
 <20251027031542.10512-9-jiawenwu@trustnetic.com>
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

27/10/2025 04:15, Jiawen Wu:
> Since FDIR configuration is deprecated in generic ethdev device
> configuration and move it into the device private data, there is no way
> to configure the FDIR parameters.
> 
> Two device arguments "pkt-filter-size" and "pkt-filter-drop-queue" are
> added, they just continue to use the previous naming convention.
> 
> Fixes: 5007ac13189d ("ethdev: remove deprecated Flow Director configuration")
> Cc: stable@dpdk.org
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/txgbe/base/txgbe_type.h |  4 ++++
>  drivers/net/txgbe/txgbe_ethdev.c    | 20 ++++++++++++++++++--
>  2 files changed, 22 insertions(+), 2 deletions(-)

You forgot to update the documentation.



