Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA28FCA0EED
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 13:38:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D081E4025A;
	Thu, 28 Aug 2025 15:38:04 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id 2EE5E400D6;
 Thu, 28 Aug 2025 15:38:04 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id 453161D0024A;
 Thu, 28 Aug 2025 09:38:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Thu, 28 Aug 2025 09:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1756388283;
 x=1756474683; bh=7l4+8PpylRc14sX+m5HHrMVGLo4UWAbZ5AdOw1uPQ4s=; b=
 OFuKTAvgngiQR9P11+zl6SHuRdoO9m8X2bG8kvjsNz6VgVPxivH85H5nnPu+GbrD
 htWdxCFwpy8ZMnr245s8fJOK6B/g+rOUQazA/RxyKq8SpLJqwYVjfoH2ERnxHEnQ
 oFWJrLzGIUF+d8+txSqkzCMafNOFQi00w9DRIxZ4NHRXqzdugtKFcv+ZCUOn6qDL
 fm4pQw8W0lR31yCsGrVjRuzMxg+QblP97bq9B/XSnOZH5Ppk/uK45qGH0VWSJNG+
 gwP3wZw2RxZR5w9VKC7PFxfofOY5Z5Dosp7QjT070jKlthYp62B8+24m8YadIIYw
 9WZjGdHVIB+QGKehlQtjWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756388283; x=
 1756474683; bh=7l4+8PpylRc14sX+m5HHrMVGLo4UWAbZ5AdOw1uPQ4s=; b=l
 +cVT70mm5/AxzjSw/7ZtRnlsKm16XQzj7j4t+W3CtD4KlQ5kjf9inPsv5fOe5n11
 XwcAAXaEvu/2D27800BaUUr2N1LWo2G4ZwZK7kPYFpG/LcZ6Hqt9X3sPqose9NCn
 Z16LY/TeGHcm/XtIv4Yus7+oH1wvTsZrq+Y3x76RDjV+MBHqiP8uGWZ+VyxVal/2
 zcE6Sa6NNYjLsD1LB+mYg8r6qE0IeCqJLRkALMtM7lRBsTxcDs6D5ffILg3i4Ef2
 WgXvCb6VgPVo6Kk8r79QQ6apsAwYsm1coZ7o8hrdIfBYOwvfFfrjLXeFoN5/Ai0H
 5AcNAwhiZnJJtyXvIYzuQ==
X-ME-Sender: <xms:uluwaNLvKAkHpbpp_GcQHfIKCOKqP3iPZrALj-I0a8-zVQetnXWfLw>
 <xme:uluwaKvEg6j5bWgyBbOoVoNqtNcM3JaIvWTKlwqdiZXlhEWO4sUE3B-m6r-4aXlag
 5sIoM1KOjIO0eU48g>
X-ME-Received: <xmr:uluwaMBFPDLuKXCAZbtc2UmLqGTWAjtUb0vvk1t3_jaz77LwoSn7j9M-D-yE4iLGcRQGeJ_d21E6Czv5fi-Rja5xJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeduudeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedutddp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhonhhgfigvihhlsehnvhhiughirg
 drtghomhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdr
 ohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehmrghtrg
 hnsehnvhhiughirgdrtghomhdprhgtphhtthhopehvihgrtghhvghslhgrvhhosehnvhhi
 ughirgdrtghomhdprhgtphhtthhopehorhhikhgrsehnvhhiughirgdrtghomhdprhgtph
 htthhopehsuhgrnhhmihhnghhmsehnvhhiughirgdrtghomhdprhgtphhtthhopehsthgr
 sghlvgesughpughkrdhorhhgpdhrtghpthhtohepughsohhsnhhofihskhhisehnvhhiug
 hirgdrtghomh
X-ME-Proxy: <xmx:uluwaKNr-sp-unHQwx5VAtrudyTUhXqKPi0PScY-pk392PBB2ZVA0Q>
 <xmx:uluwaMBHDS5QxS4i8sWmvnEIc4AfOk8TaSqm-GZ65ZXjQg1Hmg7A7A>
 <xmx:uluwaL7kO4sF7rZTsgP56-xddyZCaz2reVjR1hjs0kRkPQIAiT2zJA>
 <xmx:uluwaG6QLZTrXQ3mHYCslZzaXxe6deDUWhTzFiUAjdeRKslAhnSZVA>
 <xmx:u1uwaKHJs5ylQLSiyXokNXLhx9zmfbhR-YAxWvtSrKkvK7ldgGZNwOhx>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 09:38:01 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: rongwei liu <rongweil@nvidia.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org,
 matan@nvidia.com, viacheslavo@nvidia.com, orika@nvidia.com,
 suanmingm@nvidia.com, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>
Subject: Re: [PATCH v1] net/mlx5: fix probe optimization race condition
Date: Thu, 28 Aug 2025 15:37:59 +0200
Message-ID: <23111985.hxa6pUQ8Du@thomas>
In-Reply-To: <e30c6a96-d536-4454-b7b2-c98c4a24a3e4@nvidia.com>
References: <20250828032134.167999-1-rongweil@nvidia.com>
 <20250827214044.16f9baaa@hermes.local>
 <e30c6a96-d536-4454-b7b2-c98c4a24a3e4@nvidia.com>
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

28/08/2025 06:49, rongwei liu:
> 
> On 2025/8/28 12:40, Stephen Hemminger wrote:
> > On Thu, 28 Aug 2025 06:21:34 +0300
> > Rongwei Liu <rongweil@nvidia.com> wrote:
> > 
> >> With dedicated RDMA link monitor, there are two threads
> >> which can update the IB device port information.
> >>
> >> Add a new flag to avoid the race condition. Update should
> >> go through RDMA link monitor once ready.
> >>
> >> Fixes: 51fb5c40c826 ("net/mlx5: optimize device probing")
> >> Cc: rongweil@nvidia.com
> >> Cc: stable@dpdk.org
> >> Signed-off-by: Rongwei Liu <rongweil@nvidia.com>
> >> Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
> >> ---
> > 
> > If variable is modified (with out locking) on two threads it
> > needs to atomic or volatile.
> Exactly. Before this patch, it' user responsebility to seperate probe probing and sf manipualtion.
> Obviously, customer didn't follow this very well.
> Now logic change to:
> 1. Update all port information in probing thread.
> 2. Probe thread initiate the dedicated rdma monitor thread. Once ready, all port update will go to this thread.
> 3. Next port probing won't trigger PMD port information update.
> 
> No lock is required then.

This is the kind of info we need in a commit log.
Please make a v2, thanks.


