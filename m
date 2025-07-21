Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC822C83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 12:00:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 651DA4064C;
	Mon, 21 Jul 2025 14:00:08 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id D91BF4014F;
 Mon, 21 Jul 2025 14:00:06 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 71C4CEC0333;
 Mon, 21 Jul 2025 08:00:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 21 Jul 2025 08:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753099206;
 x=1753185606; bh=SV2rLRvvuu7XYRN4Bu/GQQK/9oJ6BGArNOJSlXJu9dw=; b=
 wpW6LVUtgCPb/ridyhaLTVKxxvHNBdp+UL21Dec57/5lnyLJLpVUgTQnBiJZJShi
 rvEPbMwQFGAMVrGEZk+zYP62Sa1g/qI1s6l2zDgEo4ZWQRilAS8WGDg4xOE+V3RE
 bgyzhCAD0z9WNtspjXfSiBHPlNXkyJYhrA2iELy9XqODqDWpF6cipl1Rbx8xyROA
 T/QL/dCLwHxg0xEGGoWn2cIGuP2oYJCmDlZyR/aD9ugnyjb7EAVY0MiQdek/HXw6
 klRr7FBeds3+6jntgeBsVLty9hYopLw3DXDZyoplvSvTUxybMQsVhfI5omYTK2Tv
 4mq1EVVVszwCJfZVm07qbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753099206; x=
 1753185606; bh=SV2rLRvvuu7XYRN4Bu/GQQK/9oJ6BGArNOJSlXJu9dw=; b=Y
 6WcDgGOiQJyyMoptRfz7udXVXyC4e0opmecHe11GOvyM5vl6xXVly9wFYzo3jJPJ
 HrqA4Yj5u/uNMv/MZbYN8ILQeZz9hpsZUTpq5PwEQxrHcXBykfx2cpNYQ9xjX1Vr
 JJI88HoTXcEN9o9VKGscAArYuPa1L5755M8TvEjtOrDGg/5Hl5LDDynjcce/BN/t
 +CTyUT7POYAzLjltiuah/QH6lQ3ciKYoikIlrF7YGP0+FMDbCn9bkwNarUoa+QYt
 AXEezlQLKmLPzVGsYK0p8ZrgKdAn33XlgNdZMvpLgOGUOYjHfouKAqfn6zHI7oGB
 9uyOz6WYunh/mdFffdg/g==
X-ME-Sender: <xms:xSt-aHWTtj6aBZe0tlxy15s0R4i-BEYcBWurJ5nx516u9jXrMam11A>
 <xme:xSt-aBIkwlT4ngtsp2D_oT8D0Aa5Wp7hDiumKsiI6uMqwzJoxru6yye0RDKAHYGfE
 zC7F8t9uwgWulkquA>
X-ME-Received: <xmr:xSt-aCoeNKZbOXev-IwdfdEV4fyk9okBa8uMr0T1-Twmp1STxMOiAihj1QRcVKn4H_i3w9af6LB51lnDuUPCDqfzhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvddtfecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepkeefheeftdegtdejheeuuedtgfelfeeiveekieekleekffelgfdtveei
 heehffdunecuffhomhgrihhnpeguphgukhdrohhrghenucevlhhushhtvghrufhiiigvpe
 dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhn
 vghtpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
 epughsohhsnhhofihskhhisehnvhhiughirgdrtghomhdprhgtphhtthhopehivhgrnhdr
 mhgrlhhovhesrghrkhhnvghtfihorhhkshdrrghmpdhrtghpthhtohepudegphiftghsvg
 duvddvgeesuhgvthhpvghshhgrfigrrhdrvgguuhdrphhkpdhrtghpthhtoheprghnughr
 vgifrdhrhigstghhvghnkhhosehokhhtvghtlhgrsghsrdhruhdprhgtphhtthhopeguvg
 hvseguphgukhdrohhrghdprhgtphhtthhopehrrghslhgrnhgusehnvhhiughirgdrtgho
 mhdprhgtphhtthhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtohepvhhirg
 gthhgvshhlrghvohesnhhvihguihgrrdgtohhmpdhrtghpthhtohepsghinhhgiiesnhhv
 ihguihgrrdgtohhm
X-ME-Proxy: <xmx:xSt-aIxlAf3GGS5c7QpnoBFYFcRf-9kE3jF5HAudaxuGXz2EVPjkKg>
 <xmx:xSt-aGsSfcnYN2nc93bc8fRHuogzLK8OFO8nLxf1U4Hkv4REkDdEFQ>
 <xmx:xSt-aB142z8mo9ziWzSL1ltRqDER9B-253tm4vz6nxcsY-_EYj85BA>
 <xmx:xSt-aOBTCLyo4qJKXZv4yBJNMtokJ4f_AxNq74-8mNO7FsPyuDs50A>
 <xmx:xit-aJwqGz9jm1sTsNF-x2SO13CzNU2CwcGNw88hcGDHicKvH6n0V1-c>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 08:00:01 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Ivan Malov <ivan.malov@arknetworks.am>
Cc: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org,
 rasland@nvidia.com, stable@dpdk.org,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix crash when secondary queries dev info after
 primary exits
Date: Mon, 21 Jul 2025 13:59:59 +0200
Message-ID: <3358342.oiGErgHkdL@thomas>
In-Reply-To: <b0c702cc-1213-d773-0ee0-804542a07e28@arknetworks.am>
References: <20250721073851.963141-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250721105819.2ci66fl7bzikwb22@ds-vm-debian.local>
 <b0c702cc-1213-d773-0ee0-804542a07e28@arknetworks.am>
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

21/07/2025 13:46, Ivan Malov:
> On Mon, 21 Jul 2025, Dariusz Sosnowski wrote:
> 
> > + mlx5 maintainers
> >
> > Thank you for the patch.
> >
> > Could you please include other PMD maintainers (or other maintainers, depending on changed code)
> > in the future patches?
> > There is a script which automatically adds maintainers while sending a patch.
> > It is described in: https://doc.dpdk.org/guides/contributing/patches.html#sending-patches
> >
> > On Mon, Jul 21, 2025 at 03:38:51AM -0400, Khadem Ullah wrote:
> >> When the primary process exits, the shared mlx5 state becomes
> >> unavailable to secondary processes. If a secondary process attempts
> >> to query device information (e.g., via testpmd), a NULL dereference
> >> may occur due to missing shared data.
> >>
> >> This patch adds a check for shared context availability and fails
> >> gracefully while preventing a crash.
> >>
> >> Fixes: e60fbd5b24fc ("mlx5: add device configure/start/stop")
> >> Cc: stable@dpdk.org
> >>
> >> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> >> ---
> >>  drivers/net/mlx5/mlx5_ethdev.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/drivers/net/mlx5/mlx5_ethdev.c b/drivers/net/mlx5/mlx5_ethdev.c
> >> index 68d1c1bfa7..1848f6536a 100644
> >> --- a/drivers/net/mlx5/mlx5_ethdev.c
> >> +++ b/drivers/net/mlx5/mlx5_ethdev.c
> >> @@ -368,6 +368,12 @@ mlx5_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
> >>  	 * Since we need one CQ per QP, the limit is the minimum number
> >>  	 * between the two values.
> >>  	 */
> >> +	if (priv == NULL || priv->sh == NULL) {
> >> +		DRV_LOG(ERR,
> >> +		"mlx5 shared data unavailable (primary process likely exited)");
> >> +		rte_errno = ENODEV;
> >> +		return -rte_errno;
> >> +	}
> >
> > I don't think it's an issue on PMD level, but rather on
> > ethdev/multi-process handling level.
> 
> I may be very wrong here, but can't the PMD use its internal 'shared' state to
> somehow memorise the fact that a secondary process has attached, in order to not
> let the primary process close in the first place (before the secondary process
> detaches)? Or is this going to violate some established convention?

It looks to be a good idea.

> > When primary process closes the port, ethdev library zeroes and frees
> > device data shared between processes.
> > ethdev port data (rte_eth_dev) on secondary is not updated so it now points to
> > invalid data. rte_eth_dev_info_get() is not the only API call affected.
> >
> > If the primary process closes the port before exiting
> > (like testpmd does) and it exits before the secondary,
> > the any driver call seems invalid because of that use-after-free behavior.
> >
> > @Thomas, @Andrew - Do you happen to know if doing anything on ethdev ports
> > in secondary process after primary has gracefully exited is supported?

No there is no statement about whether it is supported or not.
I think we should at least return an error instead of crashing.


