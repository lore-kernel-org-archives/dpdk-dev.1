Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB76BC83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 10:09:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71E4D4021E;
	Mon, 21 Jul 2025 12:09:04 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 9F1094014F
 for <dev@dpdk.org>; Mon, 21 Jul 2025 12:09:02 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 3F5F9EC02E1;
 Mon, 21 Jul 2025 06:09:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 21 Jul 2025 06:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753092542;
 x=1753178942; bh=OY7YdhxIcFq9p6Te4ZWaidhfTkT+ZQlENLSiqzNQr+8=; b=
 VRFWpHHKppNfMkOGU+t0bZbDU4AMar/xn8IgBCi9zFxl6LQ69Fxk2ImqvANBLS0E
 si2IFIfFIkow9FjQYK4VN0fYovEZ0NJzj+rktevJvhalt1NKQ5gCvzENiXPF9Yfn
 S5CdiKe7S1BCDLz1dTLAXdB81u+C8KrBcBrPi52+7pVPsa6pTlHBBsPPD31VqKZc
 MQhWGzdCoLzhYBTdPiqwq4vQyktI3kVy9+Bb6tMG3Yzb8YNqZVWsc/aFrvUuAuuB
 1ok4HSumUHLUl+sQQczu3lr7bJlcYpCOeU0APhIkdnPLCMQQMLQ4McMfHWdM1vCo
 B4v5uxHrUoAEw2KMdZxBQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753092542; x=
 1753178942; bh=OY7YdhxIcFq9p6Te4ZWaidhfTkT+ZQlENLSiqzNQr+8=; b=F
 x53fEa8m3wzzAkVZrzuMQqpRGidMDmvyGFAv22VvHRY4xQjwfAKogWcoLPPzNHfd
 3jYujVG2pt43dIYB881OPJnLZw8dZYuymtWuIJze+nPtrMU555LkEBiXErLogHzu
 KJes37dwnOSneMCSIQX9NuIjkeKyNyK8KYLkCoL7xgOfR7UlAVHdBlQPUUSAVDRW
 HlovoFNi43iNILPFgqLC8D3Qp/T2bUhtp/7GTP82MjCiKrtjIrdWZDz5lPbW6dr5
 Q826kpgLCAjFgQDLPAp01NTLHpwj6DgET5599mE4363hdFtfobAid3uSaxdzUCdI
 rETq6kTi3YT4xhQuaFbvw==
X-ME-Sender: <xms:vRF-aNNviGW-VCvXQ2z-qJJ1bDsebokMi2mG-HDGa_NrGks0LYdLrA>
 <xme:vRF-aJnhp7ujzG6CjwzWF5_6EzpXp_YCR11wpH47OfSP8kEOrs1oq_npedxRUo488
 T89hw6xa3I5qbjjhA>
X-ME-Received: <xmr:vRF-aMR7CBT7NCxYQocnTHTnkQowHdP0tNSVzPTfmdPSLX2v8BEzuNCeUwOdR8jFTjNu9aZBbui27c2O9AcH6FvJEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejudektdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepkeefheeftdegtdejheeuuedtgfelfeeiveekieekleekffelgfdtveei
 heehffdunecuffhomhgrihhnpeguphgukhdrohhrghenucevlhhushhtvghrufhiiigvpe
 dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhn
 vghtpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
 hfvghrrhhuhhdrhihighhithesrghmugdrtghomhdprhgtphhtthhopeguvghvseguphgu
 khdrohhrghdprhgtphhtthhopegrnhgurhgvfidrrhihsggthhgvnhhkohesohhkthgvth
 hlrggsshdrrhhu
X-ME-Proxy: <xmx:vRF-aNDS_Gsphx2e9jSVkiVXpf9-J3J18-G0aLXx0oR4y4xXDH8AsQ>
 <xmx:vRF-aDQml8BJoTyFnk4VO9cBxWyOJBHz5Rd6qBKMoUHxZ6deXgf75Q>
 <xmx:vRF-aLp3_4YAq7aPtwWyqaCXl7YJSQmSaCMZvgSBTW2BE-nkszM0VA>
 <xmx:vRF-aFyXYLZ9KqpAmcT-6lv9qYhYIXo7D-B6sxzME0JJ0-F591ouBw>
 <xmx:vhF-aAQ8F0j5gOWGKE0VS2JLo0mHKK2tHcfd6aM6Gtkni4KvzKEQPifC>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 06:09:01 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Ferruh Yigit <ferruh.yigit@amd.com>
Cc: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH] maintainers: update for ethdev library
Date: Mon, 21 Jul 2025 12:08:59 +0200
Message-ID: <24697780.ouqheUzb2q@thomas>
In-Reply-To: <f5e03ee4-98ce-4c3f-91f6-c2c0ef727970@amd.com>
References: <20250711144326.1288907-1-thomas@monjalon.net>
 <f5e03ee4-98ce-4c3f-91f6-c2c0ef727970@amd.com>
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

15/07/2025 17:10, Ferruh Yigit:
> On 7/11/2025 3:43 PM, Thomas Monjalon wrote:
> > Ferruh Yigit has no time this year for ethdev maintenance.
> > 
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> > ---
> >  MAINTAINERS | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0e9357f3a3..b96496adb7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -435,7 +435,6 @@ F: app/test/test_mbuf.c
> >  
> >  Ethernet API
> >  M: Thomas Monjalon <thomas@monjalon.net>
> > -M: Ferruh Yigit <ferruh.yigit@amd.com>
> >  M: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
> >  T: git://dpdk.org/next/dpdk-next-net
> >  F: lib/ethdev/
> 
> Acked-by: Ferruh Yigit <ferruh.yigit@amd.com>
> 
> Thanks Thomas for the patch.

Applied with regret


