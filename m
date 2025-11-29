Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14247CFD2F6
	for <dpdk-dev@archiver.kernel.org>; Sat, 29 Nov 2025 19:13:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0ACF94013F;
	Sat, 29 Nov 2025 20:13:14 +0100 (CET)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id 91AD7400D7
 for <dev@dpdk.org>; Sat, 29 Nov 2025 20:13:12 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 08247EC092B;
 Sat, 29 Nov 2025 14:13:12 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Sat, 29 Nov 2025 14:13:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1764443592;
 x=1764529992; bh=ly0C0K6SANUGoM45TcLgBv3h7WB1I23RfPe41qufhlA=; b=
 RgtZbsiGKXRm53DPU0Dtu8lp6fdSqWFbRjqryMSvNQcM/481S95y4vAyFR//ALbQ
 H9iYCI1o3TwpKmMf5xVkXmI1aUNNnlutWwyz40ZRyJKVF8qUV5JbDg/UNcL9AUfI
 HAO4HVcU5rZQjj8rTl4GXoV2Wt5UYvTvRrZ6tHbuGA+J0gFlxfWEgOD4tYnRIX9C
 sr47KJ+RdLNyifZfnvalIpLIeh/sVPr35qrRTPD9UB59LBpJk/exTAOCXgnqh0yn
 O7Sow2uehCtu+qT43zAC3GdWXVxH6OTBRNe2CTmA3vfJ4dId/j5qIx4+nQyBbguM
 faR3j+r1P2F8La53dwJMpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764443592; x=
 1764529992; bh=ly0C0K6SANUGoM45TcLgBv3h7WB1I23RfPe41qufhlA=; b=D
 a7P3ppNFsR/RDuSeb6VTtZF8HhCgkoHbOnk+Q846bOnjwt1ggbprEcepzMzC3tvS
 N+jze9EAB7bxdBl2EudcTvbEQ2NJY0i7TK6ZOtjcNh4u+MgJYIR9cZWzNJzj+QSx
 ezEdTcmmBWpNo9OHehrIp/t3um3bxv/WMUpBgHcB/Je8M3+uAWToZX1phHsZl5wJ
 7IUOMTcw0B2z/aorE/QKAiWe97kUuX3mVZ0jH74pupOiEp8SBcpEmO0/F4+ppj9F
 +nFtZcf+Eemaqa89FfWw0DqhoY1O7IAKzdD3TPEuyQZHLIkO68nQ5l57IfI7+JxR
 FaX29GYvOydd+PXFXE1Xg==
X-ME-Sender: <xms:x0UraS1J6wa42IePMSEX4_1om3EFFrJ2lgJehjHOMMfKGNFxwaU9Vw>
 <xme:x0UraZaBAG-UYAgohna7WP2dlFqCBBIIZ2PKaQEpUkESRVNFCM-HpEQTrk212sHxv
 KBK2BLFOTJ_1NpuGxdC5f58w1TRdh2PTb4uur71WFYHy7vPqOqckw>
X-ME-Received: <xmr:x0UraaCjgB1tHMMoG71Urz4HX3Hi0m9s8jGzzUWTa-2qu959FWlOz2t-u-u07fPNqv0D_pwTv4abDzzxvEaTIzYHeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheefvdeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeeuffevtefftdeutdefhffftdduveetffekgeelfeelgffhheejieet
 tdevjeejveenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuih
 iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhho
 nhdrnhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
 htohepughsohhsnhhofihskhhisehnvhhiughirgdrtghomhdprhgtphhtthhopeguvghv
 seguphgukhdrohhrghdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhesih
 hnthgvlhdrtghomh
X-ME-Proxy: <xmx:x0Urab9iGWwJzVzCC24k_2zSrVIbnqxaD0Zor_GfEF3-uSyt7zdaaQ>
 <xmx:x0Uraa-tGLRfceuFGuPiDwCpsol9BZiIV43ARhIfW7C_8oNjK2QWig>
 <xmx:x0UraSexq6LN78MMgShEE2T1fu_UPiXgdQ-BdoUwpQ_FXtJ1toQ5Ow>
 <xmx:x0UraTHzmBC7BA51l6krQsrYh9ftKCOms9Cwv0t5HvU2PpUa6QwgNQ>
 <xmx:x0UrafBKV8Qd2LpeRlpGeqPVku2lHn08VL0UgueFOhj3u8ujs5tHn4Jb>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Nov 2025 14:13:11 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH v2] devtools: ignore new warnings on reported-by tag
Date: Sat, 29 Nov 2025 20:13:10 +0100
Message-ID: <6676158.31r3eYUQgx@thomas>
In-Reply-To: <20251114200640.1639056-1-dsosnowski@nvidia.com>
References: <20251114200640.1639056-1-dsosnowski@nvidia.com>
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

14/11/2025 21:06, Dariusz Sosnowski:
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
> Since Link and Closes tag are not mandated in commit messages
> where Reported-by tag is used, the warning about lack of Link/Closes
> tags can be suppressed.
> 
> [1]: https://github.com/torvalds/linux/commit/d7f1d71e5ef630ab9e15b5821d297a9e1a5fa1da
> [2]: https://github.com/torvalds/linux/commit/44c31888098a590b8ec5ba37009e5a983f7c4b46
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.



