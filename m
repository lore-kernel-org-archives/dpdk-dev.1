Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDD6CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 13:33:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C2E940292;
	Wed, 20 Aug 2025 15:33:06 +0200 (CEST)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id 146644027D
 for <dev@dpdk.org>; Wed, 20 Aug 2025 15:33:05 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 269131D00061;
 Wed, 20 Aug 2025 09:33:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 20 Aug 2025 09:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1755696784;
 x=1755783184; bh=+YzMe/lmO2UOmBd6VcLAdlQHRQT2qquYy5IbTc3YFCw=; b=
 gLlReNOG01ll+cGWlYp4PtG+1L/ZDIE4YARHH7SDMCkZKmSIsxm9I6vr+DYmydMy
 F02YbMqgZKsJMsPttyoHR1n7ITqhoX0rdyrLLihiwo8S+zgXkVXgNLW+7ei66Czg
 DGTbKmhZb1MBfGfzCdAvWKy9gwyfN4MO76jGr4mJ1sgna0qTCBFN+omxc0Yc8t33
 U1AhkQPqnCLihwpN0F9o5YbYB79IzW6k0qycGw3pPqPT0u3hIj9/RLkrpOyrKo0T
 fv1ENGepRPsnkEPiWrzsLkb0ugVFyqxREBD0FHmRoHLFhwHZJR/ZyybD5qYPQzp9
 fg0h3AkLA1wIXIpjSs58Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755696784; x=
 1755783184; bh=+YzMe/lmO2UOmBd6VcLAdlQHRQT2qquYy5IbTc3YFCw=; b=R
 sTjYZoDSi29BaoJbAeFX5MlJLTpfjbo34stV46MURyDVU5zNi+y9NznhR6KrEFhN
 xsdF3AEGgALKfXUCi6YTUWRM9QYYgagCZC0LpsCeimSCjiMqakB5OsX5CUYU0LfF
 JHLF9cNPjjTHUfwYCpbZuKqzVeOvTMq9IrUEppFKCu4JmFNqPhUvn8peIPDnACPP
 wzPpFXNyU8v/3xClvIG6P7Bl3w1C1WZaslv5XZWpEArEyxLhqfIuNgm+WUkRHRge
 +/uSE8bYIdxZWg3xo4EQGEenzGFOXdTof7VmZ9Tw73lJmQuUG4v5ZspLTj7mJdBQ
 waEP+FUyecvJak4wNCVxA==
X-ME-Sender: <xms:j86laA9pgYLWD1yOfv4MNP_HVIAqFFLL2mj19ZuLwVmf2JhbVHIEVQ>
 <xme:j86laN8-UMDWouTytibSIcEE9zj79n_9Whijrxi_X3xXrb1rVwlMCbYnFTBF9AQbP
 D3mjiEsy9QivAtFJw>
X-ME-Received: <xmr:j86laHu-ziqoxMz-Z0NaT7k16Rvq9CX-sy-5UhWBM4FpB8ZoM7jLSXJnuO4-3X6b5bHobeBo6MjVRnhuc2ML8fo7ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheekgeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeeuffevtefftdeutdefhffftdduveetffekgeelfeelgffhheejieet
 tdevjeejveenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuih
 iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhho
 nhdrnhgvthdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
 htohepughsohhsnhhofihskhhisehnvhhiughirgdrtghomhdprhgtphhtthhopeguvghv
 seguphgukhdrohhrgh
X-ME-Proxy: <xmx:j86laIqS1nBpwXLp8yENNgGBDG0MA7dxOPGo7NynAA4tfb1dlQ5g3Q>
 <xmx:j86laMmpFr7m_PB65nQl7sTBmWXgPYNuOkQMoM8jCt00CLOxhws_QA>
 <xmx:j86laExeQwlqn2YV2vFYwuD2TR2W2_k74Dvav7wqefZDGUu0lUmnTg>
 <xmx:j86laMlZD-ypWDyhkTBeVun2nnF09FloDLO3sTQhJp-F2ZhtfRuzvg>
 <xmx:j86laO_cECW2hubjwR98HH71p030fWiEYIekAX3WiZwhH2tK0brpBNsr>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 09:33:03 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] devtools: ignore new warnings on reported-by tag
Date: Wed, 20 Aug 2025 15:33:00 +0200
Message-ID: <2450283.yKrmzQ4Hd0@thomas>
In-Reply-To: <20250820095050.1090859-1-dsosnowski@nvidia.com>
References: <20250820095050.1090859-1-dsosnowski@nvidia.com>
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

20/08/2025 11:50, Dariusz Sosnowski:
> There were 2 changes introduced in checkpatch.pl script [1][2]
> which verify if Reported-by tag is followed by Link or Closes tag.
> Example of the warning output:
> 
>     WARNING:BAD_REPORTED_BY_LINK:
>       Reported-by: should be immediately followed by Closes:
>       with a URL to the report
> 
> Original purpose is to link the patch to the mailing list discussion
> and/or a bug report.
> 
> Since in DPDK these tags are not used, these warnings are false
> positives and can be ignored in devtools/checkpatches.sh.

We use "Reported-by", it gives credit to people doing this precious work.
But we don't mandate a link for this credit.

> [1]: https://github.com/torvalds/linux/commit/d7f1d71e5ef630ab9e15b5821d297a9e1a5fa1da
> [2]: https://github.com/torvalds/linux/commit/44c31888098a590b8ec5ba37009e5a983f7c4b46
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---
>  devtools/checkpatches.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
> index 35037aa8f1..8c5b5d1380 100755
> --- a/devtools/checkpatches.sh
> +++ b/devtools/checkpatches.sh
> @@ -33,7 +33,7 @@ VOLATILE,PREFER_PACKED,PREFER_ALIGNED,PREFER_PRINTF,STRLCPY,\
>  PREFER_KERNEL_TYPES,PREFER_FALLTHROUGH,BIT_MACRO,CONST_STRUCT,\
>  SPLIT_STRING,LONG_LINE_STRING,C99_COMMENT_TOLERANCE,\
>  LINE_SPACING,PARENTHESIS_ALIGNMENT,NETWORKING_BLOCK_COMMENT_STYLE,\
> -NEW_TYPEDEFS,COMPARISON_TO_NULL,AVOID_BUG,EXPORT_SYMBOL"
> +NEW_TYPEDEFS,COMPARISON_TO_NULL,AVOID_BUG,EXPORT_SYMBOL,BAD_REPORTED_BY_LINK"
>  options="$options $DPDK_CHECKPATCH_OPTIONS"



