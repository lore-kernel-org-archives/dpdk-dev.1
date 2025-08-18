Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA48CA0ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 17:20:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C52640267;
	Mon, 18 Aug 2025 19:20:26 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id 1FBDA40262;
 Mon, 18 Aug 2025 19:20:24 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 6DFD8EC070E;
 Mon, 18 Aug 2025 13:20:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Mon, 18 Aug 2025 13:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1755537623;
 x=1755624023; bh=wY9MzhDPBOHeHXC5aj/HmpNF+22NrOT56D8BjcdEC6s=; b=
 nnljgUdmyQD2X2eIatREPlp/mNnrOwmyq1wr3hI1ab5rggM0h4BcuBc5V8C8RGxW
 2SL0KJWuVJmWf/RBszAlbU16kB4WdR9k+bInb+IAvfumKAQbtkmYQqIDSV2WHhUr
 4In5D3bf5CQ40T1Yu6mGi6YZHyo70G1sUvlgQ9zQ2gAzbB9yKfIyioQvTXHUwoBP
 ceIxwexbkKRfMtO5r84VITOKUYEAg9Sc4fN+BLv+IQbTGv5q9nrWYS/jXI6GQJGu
 I2yuPjn8UAhfeMnEwhjIci5gFWsaprXTvl4xYUJg+QD+54Ic59rplGFqHBHYpsU9
 nNqt8FQik68je0fmY/1Q2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755537623; x=
 1755624023; bh=wY9MzhDPBOHeHXC5aj/HmpNF+22NrOT56D8BjcdEC6s=; b=T
 toAlxZ+EmLuOdDT97yhNYpHVcHgrupi6/zcmyDhPjV/ajeBG1ADRfF1lIcjk1/ON
 g3zdGQXwVUc9Nu/S/5RhZJBFdKeqJPhW2qK+Pa6KkXzUmio+YJdCZagtdOo4blzT
 WApjpEMsWrpHWyCOxjzWwJMuNeNK1QorrMjZN2i/+x5c0yIqDI1uOJwKOAxmTy/k
 7rwiKHSF/yvmW85hZ2xIJ8uLHUqT4PQeg2/TjJe7J+KVBuej59w1VTI3Pf5hVu73
 ngc2T8YHrgNZviUIQM5iVTuJJtK8rZ1ttBXHFzBmq2ZoR3bUcb41Y4r7edjrPdTj
 621cUi4xtnmRoDzEfRKGw==
X-ME-Sender: <xms:1mCjaHgtRjSwmfeqZhNM95j7PHK_v1cqtQnKYgDwMj9A81C6HmnCEQ>
 <xme:1mCjaIZlrBE4fjDP8FKpP9TM8M7-exSToIUU6TQ919U0SVSsWCc3u-2h5APsJewh-
 hfoBwVPJHo1nnS7hA>
X-ME-Received: <xmr:1mCjaE_b02d4XvLErsm_QPO-IlF-4brUqXAP296_eCVtyY6hzOdw4Y5-Pk3n78wou2BdDx5QRiXqOo62NRPf6FGfPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheefudelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeeuffevtefftdeutdefhffftdduveetffekgeelfeelgffhheejieet
 tdevjeejveenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuih
 iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhho
 nhdrnhgvthdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtph
 htthhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthht
 oheprghlihgrlhhnuhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepughsohhsnhhofi
 hskhhisehnvhhiughirgdrtghomhdprhgtphhtthhopedugehpfigtshgvuddvvdegsehu
 vghtphgvshhhrgifrghrrdgvughurdhpkhdprhgtphhtthhopeguvghvseguphgukhdroh
 hrghdprhgtphhtthhopehvihgrtghhvghslhgrvhhosehnvhhiughirgdrtghomhdprhgt
 phhtthhopegsihhnghiisehnvhhiughirgdrtghomhdprhgtphhtthhopehorhhikhgrse
 hnvhhiughirgdrtghomhdprhgtphhtthhopehsuhgrnhhmihhnghhmsehnvhhiughirgdr
 tghomh
X-ME-Proxy: <xmx:1mCjaCPxm4GXYbTu-ByuiYewdet2zCoY8cp9BkhDA583Iy5yOU-E7w>
 <xmx:1mCjaJHvTRsDxTBix4hdod-tW0bdJa1LYevwa6CKcuLWpTyD2-J9Hg>
 <xmx:1mCjaIxUsAbyFd-KL6_2weZhkMZi7ubsAKnEb1bDj2sKLGHUD6b2xA>
 <xmx:1mCjaCpGhPCQBHHSl86Cqeoy-JpaDnNpzoHwV65yE5cXqhcaftJCoA>
 <xmx:12CjaL4K1xC96B1QH8yBdDDLRyb7vAowtzmkjdPntVNneGWxBap30kYM>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Aug 2025 13:20:20 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>,
 Ali Alnubani <alialnu@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>, dev@dpdk.org,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v2] net/mlx5: fix connection tracking state item validation
Date: Mon, 18 Aug 2025 19:20:19 +0200
Message-ID: <2610138.4XsnlVU6TS@thomas>
In-Reply-To: <20250813141614.yiwou5lbd4exybnv@ds-vm-debian.local>
References: <20250805132318.480413-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250812124630.2916225-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250813141614.yiwou5lbd4exybnv@ds-vm-debian.local>
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

13/08/2025 16:16, Dariusz Sosnowski:
> Hi,
> 
> Thank you for the patch. Please see comments inline.
> 
> On Tue, Aug 12, 2025 at 08:46:30AM -0400, Khadem Ullah wrote:
> > This patch validate a connection tracking state when matching
> > 'conntrack is' in rte_flow rules. Since conntrack item flags
> > is a bitmap, then any combination of RTE_FLOW_CONNTRACK_PKT_STATE_*
> > flags is a valid value to match on.
> > 
> > This patch validate the CT state item.
> > Fixes: aca19061e4b9 ('net/mlx5: validate connection tracking item')
> 
> When used locally ./devtool/checkpatches.sh reports the following:
> 
> 	WARNING:BAD_FIXES_TAG: Please use correct Fixes: style 'Fixes: <12+ chars of sha1> ("<title line>")' - ie: 'Fixes: aca19061e4b9 ("net/mlx5: validate connection tracking item")'
> 	#12:
> 	Fixes: aca19061e4b9 ('net/mlx5: validate connection tracking item')
> 
> but it's not reported in "ci/checkpatch" job in Patchwork.
> This check was added in Linux 6.1: https://github.com/torvalds/linux/commit/bd17e036b495bebbf07a5fc814c868e30e1dc131
> so it appears that checkpatch.pl version used in CI is older than that.
> Locally, I have a version from Linux 6.16.
> 
> Ali, Thomas, David: What do you think about updating the version of
> checkpatch.pl used in community CI?

I've updated the checkpatch script used in the CI.
It's the latest version from Linux minus few non-relevant checks.


