Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11BACA1016
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 20:20:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2763402D3;
	Mon,  8 Sep 2025 22:20:54 +0200 (CEST)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id D678F40264
 for <dev@dpdk.org>; Mon,  8 Sep 2025 22:20:52 +0200 (CEST)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfout.phl.internal (Postfix) with ESMTP id 576F0EC021B;
 Mon,  8 Sep 2025 16:20:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Mon, 08 Sep 2025 16:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1757362852;
 x=1757449252; bh=PkhkiB3DkIeRDE6D6A4c9d9usYxe5HIbEkYV5BytT1I=; b=
 FGP7HVKph7U0wxSr0CC3u1lsnwZZppjrXeCKR1tDaczcs5uv1E3zeEJ8rJrDMrYl
 Q6zeuvO1G9ZQrpoyEZNc1KvallxKCZAcWAG8EQCRvw/ruwJFI14z79cA2HfLDcMC
 l7jOQYgQL4fw80yrzYowAxY4lcs1sZtnxYWOYgsAr0AJT3JPNFFNe/vt7eghdvT+
 GjRU+RJmZDFIfHgXWBBllu2NizHcecpkT+8ugxY1zIRx00vvC+NbHy8G7z01A7tY
 a9a8TT/hEbxPTVo6RIFSDWztfm2Y9eJ1c4fA1glUApjShv59KrFR0t684d26WUnY
 ql+90zXoK3znXFrljfnEpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757362852; x=
 1757449252; bh=PkhkiB3DkIeRDE6D6A4c9d9usYxe5HIbEkYV5BytT1I=; b=k
 7Nk1lddu/49k1uh/OXxgc2yUukqcrkl1gzsX1z4bQBhypOI8lFPDh01tcExianBO
 p2QNZ2LpMqfFeKIKJ1feADPwrYaclVRXmvW+7orEuWs+ZfKGplZba+jyVIKY91V4
 3M+wwstBtIYOIPvqqg/taWolLCGKTQv5GTg4wnm/pZ7S7352p+4p3QZl/4gir9IY
 z5QdJDB8zoxwLKLup0ASZ99u6ZoBkErjP2FAUkhN291jMc/JV8fjega22SP9KcHz
 x0oAvTtW8vF0sm3sAiPlQiS6830a7nKojl9hfgJHPo0Sz06dIbBsUo1mdGS4tLPv
 74e1RpOs7KjoJTViKzilQ==
X-ME-Sender: <xms:ozq_aBMVw3p3hZJ84ao49EjB71sXKyUYbRL86bRcTJFJ39BeOTS6nQ>
 <xme:ozq_aB5TvMc4yLJGxB3aeK5jX5CjzSGrU3odd3kI2VbPfXB7ndtzLqrhfPbYSbm62
 v5GEbPIbKyclpNVMQ>
X-ME-Received: <xmr:ozq_aCmZ9dhV5UDwQh030R6n75OwDsq99NQuxLD6KNnCJuv3DsK-EBw23HUBPxfAtQVM1lYScNL_9eqEJFjR9iC89Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepiedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplh
 humhgsvghrrdhorhhgpdhrtghpthhtohephhhurghnghguvghnghguuhhisehhuhgrfigv
 ihdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehlih
 hhuhhishhonhhgsehhuhgrfigvihdrtghomhdprhgtphhtthhopehfvghnghgthhgvnhhg
 figvnheshhhurgifvghirdgtohhmpdhrtghpthhtoheplhhiuhihohhnghhlohhngheshh
 hurgifvghirdgtohhm
X-ME-Proxy: <xmx:ozq_aCRnvBCovbGHotKkqCOEQeCqgwmEIEXKmuANeY_L7hWzf7tvsg>
 <xmx:ozq_aBGy_5XPPb9SkCpvJ4Czjpi59rnoqoFrafYH3SA9KhTDi4OZVw>
 <xmx:ozq_aHHm--P037uh7GQz3LhNXBq0FcFYei1KkDNV5kYD6ib3MZ-Cyw>
 <xmx:ozq_aPTCpmBFp_ywfbJLHg_06fJILBcNRjiPSrWr1yFiTEWObAT77g>
 <xmx:pDq_aLEZ4OnP4zUi_IcP4V6QTpDAuKSIDy7BNo9ZNY-iMVZEA6bKmvvH>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 16:20:50 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Dengdui Huang <huangdengdui@huawei.com>, dev@dpdk.org,
 lihuisong@huawei.com, fengchengwen@huawei.com, liuyonglong@huawei.com
Subject: Re: [PATCH 1/3] net/hns3: fix inconsistent lock
Date: Mon, 08 Sep 2025 22:20:49 +0200
Message-ID: <9500985.CDJkKcVGEf@thomas>
In-Reply-To: <20250908125815.3dbbfaa0@hermes.local>
References: <20250813073317.1352274-1-huangdengdui@huawei.com>
 <3368264.aeNJFYEL58@thomas> <20250908125815.3dbbfaa0@hermes.local>
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

08/09/2025 21:58, Stephen Hemminger:
> On Mon, 08 Sep 2025 13:53:38 +0200
> Thomas Monjalon <thomas@monjalon.net> wrote:
> 
> > 13/08/2025 23:06, Stephen Hemminger:
> > > On Wed, 13 Aug 2025 15:33:15 +0800
> > > Dengdui Huang <huangdengdui@huawei.com> wrote:
> > >   
> > > > The hns3 driver supports configuring RSS through both ops API and
> > > > rte_flow API. The ops API uses spink lock, while the rte_flow API uses
> > > > pthread mutex lock. When concurrent calls occur, issues may arise.
> > > > This patch replaces the lock in the flow API with spink lock.
> > > > 
> > > > Fixes: 1bdcca8006e4 ("net/hns3: fix flow director lock")
> > > > Cc: stable@dpdk.org
> > > > 
> > > > Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
> > > > ---  
> > > 
> > > With that mutex removed, you can also go farther and remove all references to pthread.  
> > 
> > This patch was (probably by mistake) in the next-net/for-main branch.
> > I've dropped it when pulling in main.
> > 
> 
> I went ahead and fixed the original patch to drop pthread references
> and fix wording in commit message; and put it back in next-net.

There are 2 other patches to consider in this series.
We should not break series if no urgency.


