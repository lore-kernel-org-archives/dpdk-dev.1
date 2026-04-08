Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A0810F996A
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 18:18:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA4F040299;
	Wed,  8 Apr 2026 20:18:39 +0200 (CEST)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id 82FC24014F;
 Wed,  8 Apr 2026 20:18:38 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id EFC751400088;
 Wed,  8 Apr 2026 14:18:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 08 Apr 2026 14:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1775672317;
 x=1775758717; bh=D9888Epv6sqTPjnVVJmkm6tBaP/E42jKHDieMM7R2Ok=; b=
 Teh3DbXXd+bqkS4kbUizm9yvAcqn3tAIYp1M3uN5NStLhEbMjU7klWX6kKeaI5LV
 PAT0N0n4qb3+OIJf4rJjaM92zBT9pHFR2omcQTogNxQ8nJS9jPeoWelgv5qaQN1i
 POl8eQ+6QmJgc+OP5klS6WyxUOmC9V5hxKleutudjnMR0rC/BAJV8daPAA+4XHBs
 qfHJh0JI0ICBiWQDs6QYxE9yCwkkqTNSu3Agf7fAgfWr8zDzN5v03LjBqwvykCLM
 uonrI65+lVhCD5vUj0i5aEHOfeuf05Ik5xekSRn5QrCsfKPn1BQ3hBs0o5ZtCNiD
 MV2UCOMyH7sMs0Vy/e2k0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775672317; x=
 1775758717; bh=D9888Epv6sqTPjnVVJmkm6tBaP/E42jKHDieMM7R2Ok=; b=k
 8i3ZNoEI0OBaBp5keSohhJYmfT6MDrN5oqACV9qc1m2nqclS/L8FYAXkl12/bfKD
 upvijmw2sy/7nK4f0iakJUgti6wFfD4PKB+xfWugo3Ktsct/f5R60QNAjRot+rXL
 efM08gqD34YZEwbeYoeFQDPv/a53irX3unzl1kpe9RXO5U50RegUCzuWLU55FGLD
 X4/zGZ9ucOIe3/XjP06+NK0S6BKOLqB3a3Kri8MpmjELQGvnwXFm9fl8W1XViEx0
 9pgn3ZJmNPZssDrrQRJyF6WyXsFnB1JfBGUCaiDqEI2IQVBPn/oaBArQ4/0Gpp42
 yE+r+CoD6Wv2ITpTFQ+ng==
X-ME-Sender: <xms:_ZvWaeUP2I_xlaVT4RoS-XUWL36b3hakumvlmY5hK_HcfqetFJlboA>
 <xme:_ZvWaVihkinQMbUKK8g_Xohq1iKYMi0QADxmOlUCaPTPQWVyQBYvlk6n0A5AgCcbk
 5C85fMBDfb_GvZFc3QK8F3IKPs2bc5fqFwU1_Csz3LkbLbNC_qEZw>
X-ME-Received: <xmr:_ZvWaRY5jIt9rqpOWG5dtXlNdOlbX1IT90e_hP2JnraxTk3GzWIADPYrbxyX_8fXm_8_mFCmijXlltxRQMpdAa2PoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgedvjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepjedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpth
 htohepshhtrggslhgvseguphgukhdrohhrghdprhgtphhtthhopegrnhgrthholhihrdgs
 uhhrrghkohhvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshhivhgrphhrrghsrggurd
 htuhhmmhgrlhgrsegrmhgurdgtohhmpdhrtghpthhtohepmhgrrhgtihhngidrhhgrjhhk
 ohifshhkihesihhnthgvlhdrtghomhdprhgtphhtthhopehluhhkrghsiiigrdhkrhgrkh
 hofihirghksehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhukhgrshiigidrghhoshhi
 vgifshhkihesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:_ZvWaaoWFBmiFwK8drwE1mpYGM4Nn5ytxIoNw7-NePhCdAQx-WnTTg>
 <xmx:_ZvWaWM-5vVY30rs25oab6oO9TOumprHFdB_kDAxab8lVscaW3yQRw>
 <xmx:_ZvWaVrwCHvTEJ2tzDA7SSYs1Kr-DcwcKg38_IvesC6Zf2w2IKstFw>
 <xmx:_ZvWabcGbFFd0OIFs0jfldZJYcfEYWf9v4WkGgHH6UBVg19wN27zdg>
 <xmx:_ZvWaRXw_LSgbhL0TqVLH-6TuiRyyJihDTBZqeT2HqAMwnLh7tTe16Vf>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 14:18:35 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: stable@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Marcin Hajkowski <marcinx.hajkowski@intel.com>,
 Lukasz Krakowiak <lukaszx.krakowiak@intel.com>,
 Lukasz Gosiewski <lukaszx.gosiewski@intel.com>
Subject: Re: [PATCH] examples/vm_power_manager: fix const discarding
Date: Wed, 08 Apr 2026 20:18:33 +0200
Message-ID: <3469901.tdWV9SEqCh@thomas>
In-Reply-To: <20260401093502.1420779-1-thomas@monjalon.net>
References: <20260401093502.1420779-1-thomas@monjalon.net>
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

01/04/2026 11:35, Thomas Monjalon:
> When compiling with GCC 15.2.1, a const qualifier issue
> is seen with this warning:
> 
> In function 'get_resource_name_from_chn_path':
> examples/vm_power_manager/channel_monitor.c:139:16:
> error: assignment discards 'const' qualifier from pointer target type
>   139 |         substr = strstr(channel_path, CHANNEL_MGR_FIFO_PATTERN_NAME);
>       |                ^
> 
> The function get_resource_name_from_chn_path is used only once
> and call a single function (strstr),
> so it can be replaced with a direct call to strstr().
> 
> Fixes: 221e7026d521 ("examples/power: add FIFO per core for JSON interface")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Applied to fix building with a recent GCC.


