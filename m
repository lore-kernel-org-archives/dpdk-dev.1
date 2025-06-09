Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90366C5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 13:36:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B015C40EDF;
	Mon,  9 Jun 2025 15:36:12 +0200 (CEST)
Received: from fout-b3-smtp.messagingengine.com
 (fout-b3-smtp.messagingengine.com [202.12.124.146])
 by mails.dpdk.org (Postfix) with ESMTP id C212840EDB
 for <dev@dpdk.org>; Mon,  9 Jun 2025 15:36:10 +0200 (CEST)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfout.stl.internal (Postfix) with ESMTP id EF28C1140376;
 Mon,  9 Jun 2025 09:36:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Mon, 09 Jun 2025 09:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749476169;
 x=1749562569; bh=vKIqw3vuqFoTO93Rarde3hdZUUU84UzscJnOv/DF7SM=; b=
 a2yTsa9cKxqZFxAaOZAII2s+9gloV6wE7Fylk/pcAfyviD3HgeEENVZmVsdmWPAw
 aOZqjO6AdhJq8NgmNPNkwo1a4Y4KWLBixNZPI3hNh3RH2C1qLlfKjfyxVsPgv6f+
 9DPwLOwV5lKXHK5k8pwInwk5eHg28Qs5dmtumCRK/VGsqA+KKXJPpj2SK6ZB1Qjn
 Y7wA8TEYgvRXYzMelQHoOQ6MKYtSUu1jHx4DdZ/N9rPhjn25/VWy/an/BE6YGCXP
 xyHIS2IEaf5fbBs9Dg+7uWfoU29Bu/BktVmzKyTkKXyfDfyH12D+1Z5fyO1lI+w4
 jw6pHDHG+TSHwSgFY2S59g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749476169; x=
 1749562569; bh=vKIqw3vuqFoTO93Rarde3hdZUUU84UzscJnOv/DF7SM=; b=E
 OUFTcP/NBcTefOyV+iPdFopHUitqhPp288U0O0EKgYoPV5rVyrzT6Gn/pOb9rR4v
 r1/JUd7zwcafETZ9e9wDwqfRDTYdoz3x7QCb+k5MOQTrfCN5FNJA309bi7XRGBXL
 31uykxshgHOijCkiNgyTfSXiV4i7JsuHy9b7R75j6qiKwazMjGKIORzBltrvZJMQ
 TB8CsvZz7QT7B4YX89lGTvVFr3AyzZmx/COK4Op7dqa2/EJYRRur4jKVnWzxzyMe
 asi6yaBehlTA4IxbKpEkL/0FpMDTZTHJRioH/yC/g+B+qK7fffjNs0PUnhjmyUP+
 N3p8NYve3u5TNl+WWjo1A==
X-ME-Sender: <xms:SeNGaEHYLqEg-HjnPEpDVEqip7ozemvNnUS52gFNqDR7GdabNzOo8Q>
 <xme:SeNGaNWVHrnPvH9e7AN8_RCWo3BT6ezbaNuUrjRW3t_29AAWHRKbqpOmGuVivlHQy
 yWGc6TnxxkTfUWjOw>
X-ME-Received: <xmr:SeNGaOKBXxq1B8MAD8BU72F7KkXaySSZXUZbazi5AVkfB1n_G7VCBiWpb404KmX3UGfr566Ffh_vEQY992dtFcqb2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelfeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
 ffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghl
 ohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnh
 epjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeugfefkeejnecu
 vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrg
 hssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhht
 phhouhhtpdhrtghpthhtoheptghhrghnghhqihhnghdrlhhiseifihhnughrihhvvghrrd
 gtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:SeNGaGHFlgbrQIlSBx5pzxbOi4oKw8GV-jM1uGsZahZGMPhrjSxLYw>
 <xmx:SeNGaKX0NpMwRwMnUOTWwizZwI-zsG_dqpG2jTZ4W6rQTVCRjG1kdA>
 <xmx:SeNGaJMENS1XTDtm32L_2GLXX7zodmGSVUkZOepYp7sX5KWNzP83-Q>
 <xmx:SeNGaB2W0AVqxn4sq6SWy6Hg9UPUbJ24H6779COtw1uEW4orzZIw_w>
 <xmx:SeNGaAn9ZppQZK4Hq8TO5y7DN28I5f1vRqjhneb-zbn_RA4mVSjLttFP>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 09:36:08 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: changqing.li@windriver.com
Cc: dev@dpdk.org
Subject: Re: [PATCH V4] Add new tracepoint function for type time_t
Date: Mon, 09 Jun 2025 15:36:06 +0200
Message-ID: <4236848.C4sosBPzcN@thomas>
In-Reply-To: <20250527120404.2027529-1-changqing.li@windriver.com>
References: <20250429030017.1126516-1-changqing.li@windriver.com>
 <20250527120404.2027529-1-changqing.li@windriver.com>
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

27/05/2025 14:04, changqing.li@windriver.com:
> From: Changqing Li <changqing.li@windriver.com>
> 
> To support Y2038 issue, for 32bit system, -D_TIME_BITS=64 is passed to
> gcc, struct timespec time->tv_sec is 64bit, but size_t is 32bits, so
> dpdk will compile failed with error:
> "../git/lib/ethdev/ethdev_trace.h: In function
> 'rte_eth_trace_timesync_write_time':
> ../git/lib/eal/include/rte_common.h:498:55: error: size of unnamed array
> is negative
>   498 | #define RTE_BUILD_BUG_ON(condition) ((void)sizeof(char[1 -
>       2*!!(condition)]))"
> 
> Add a new tracepoint function for type time_t to fix this issue
> 
> Signed-off-by: Changqing Li <changqing.li@windriver.com>

Applied, thanks.



