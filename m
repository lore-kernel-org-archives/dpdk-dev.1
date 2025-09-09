Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC1DCAC587
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Sep 2025 09:22:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A756D402D3;
	Tue,  9 Sep 2025 11:22:19 +0200 (CEST)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mails.dpdk.org (Postfix) with ESMTP id 09B6E40281
 for <dev@dpdk.org>; Tue,  9 Sep 2025 11:22:19 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 9102E14000F8;
 Tue,  9 Sep 2025 05:22:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Tue, 09 Sep 2025 05:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1757409738;
 x=1757496138; bh=kDfUqQabIbYqDs5gglArUiyW/Hd3jdAy08gxt0fJxJA=; b=
 EgXkJ6l8toM06pa7DsgZmjooR7SqpqyhET62vMwZZKUYZhJaxLBTLmHZGfM6OCSq
 WWIXgElzFD2zE2SUY5ypeoh0S7RI4FjyM4DLKQIb2kb5krGAszWNO1CPTGQRjy5M
 u2HH49YXOK9zVzBMCOo+HXxmdQU/sTvZsiRpq0IK+MhrFcAGwK0UfmHsVlzrVsR6
 PJenGeid6Yrw8eoUhxKlSaKDrDBjjaI5rx89dj9p4WMh1ytM3mI8EUuItGolw/Ql
 8oIes2AE71qVquE6TSh9NPQp2Wxi7OIgaGXIl8mwWoU1Wkdyksp6R8RbydTAIsYr
 q7e+HmsH+WVu5dUfEnKIKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757409738; x=
 1757496138; bh=kDfUqQabIbYqDs5gglArUiyW/Hd3jdAy08gxt0fJxJA=; b=D
 WEbdFhHVUV5lMGlGJ8cZhjHtPwn/NK6Ne+DhTIUJAGAhAvpA7N9v0obz1M4HAbOQ
 hYI0ignotjxllWe5KMuIWztCVBvGkgTAc/PD89IVSFdA1mJS6tdd6JBggdHrYY9M
 toMl2tWoO8WBzDsA8dCxwM5VRmGMuCG1xCBqcDhwaT6LKZMG7kWlkGib7WraaH6L
 uR7rgCXVXciOKfOOT1JvCuGABm8snnGdVa68VdRuwC6UvQsbJzPWdHgdzBphKa6S
 Q2UJNCTzTmUu7/+ZMAbqKCi7Wf5GXJHlNvZ3OMitW6UZbyi/fJ4LMbIp7s2LJeMj
 Gfa2QWB6m1ih+MzkvNDGg==
X-ME-Sender: <xms:yvG_aGNw1_yKzmbQJoNX04DlYcuRKhtcy2ay0UPxQHTmEUeYJYFknQ>
 <xme:yvG_aMVCALq1phVIGfkF1yle_6X7VTD4DRK7q9cIk81tJedwlcCVK-oHJQD_wIpEW
 2LLNZ38r7rnFWHPDw>
X-ME-Received: <xmr:yvG_aC1wg9Ai0idxYZy8CAEd__JQsJMaAQenOaTjjbelfp7S1ChheH4OD6dbn3qLSyg5Dzq9TTlmlE1BNUFc8eFQ8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddtgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepjedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepfigrnhhrhieshihunhhsihhlihgtohhnrd
 gtohhmpdhrtghpthhtohepnhgrnhgrseihuhhnshhilhhitghonhdrtghomhdprhgtphht
 thhopehqihgrnhhrseihuhhnshhilhhitghonhdrtghomhdprhgtphhtthhopeiihhgrnh
 hggiigseihuhhnshhilhhitghonhdrtghomhdprhgtphhtthhopeiguhgufieshihunhhs
 ihhlihgtohhnrdgtohhmpdhrtghpthhtohepuggrvhhiugdrmhgrrhgthhgrnhgusehrvg
 guhhgrthdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:yvG_aCoNfzmbOPbCCaW9MjMXIyPfHfs7B1zSNe1vQMRVA0hoEgc9ig>
 <xmx:yvG_aBXFU75A80rCSwUl_UbmLEJ29IINu9dAAYKeIx5PyvReSs9LTA>
 <xmx:yvG_aFaczHnLtMkgl-EDfpitzijCg0gD5SoTVEWQIbCTy80FR_4iVA>
 <xmx:yvG_aGc0KbYI9NeqRpXS9KkyuZsHZKDal4A_xIUULiKPhp9C1sPGGg>
 <xmx:yvG_aLsZY5HUOgpCJgzNVF8dhTKr11yVZ-6yIjZig9_KBmyXNIaO3svH>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 05:22:17 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Renyong Wan <wanry@yunsilicon.com>, Na Na <nana@yunsilicon.com>,
 Rong Qian <qianr@yunsilicon.com>, Xiaoxiong Zhang <zhangxx@yunsilicon.com>,
 Dongwei Xu <xudw@yunsilicon.com>
Cc: David Marchand <david.marchand@redhat.com>, dev@dpdk.org
Subject: Re: [PATCH] net/xsc: fix use after free in some RXQ cleanup
Date: Tue, 09 Sep 2025 11:22:15 +0200
Message-ID: <24075832.6Emhk5qWAg@thomas>
In-Reply-To: <f50263c8-895e-4878-962e-f888f599bd90@yunsilicon.com>
References: <20250909070427.2711048-1-david.marchand@redhat.com>
 <f50263c8-895e-4878-962e-f888f599bd90@yunsilicon.com>
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

09/09/2025 10:08, Renyong Wan:
> Thanks David for catching this issue.
> We'll address it in the 25.11 release.

I don't understand your answer.
Do you ack this change?
We want to merge it today because it is breaking our CI on the main branch
(next-net has been pulled yesterday).


> On 2025/9/9 15:04, David Marchand wrote:
> > Debian 12 gcc complains about a use after free in this cleanup section.
> >
> > [7/11] Compiling C object drivers/libtmp_rte_net_xsc.a.p/net_xsc_xsc_rx.c.o
> > In function 'xsc_rss_qp_create',
> >      inlined from 'xsc_rxq_rss_obj_new' at ../drivers/net/xsc/xsc_rx.c:565:8:
> > ../drivers/net/xsc/xsc_rx.c:501:9: warning: pointer 'req' may be used after
> > 	'free' [-Wuse-after-free]
> >    501 |         free(req);
> >        |         ^~~~~~~~~
> > ../drivers/net/xsc/xsc_rx.c:501:9: note: call to 'free' here
> >
> > Indeed, req may be free'd twice, as an error in the cleanup loop may
> > jump back to the set_qp_fail label.
> >
> > Instead, skip the erroneous rxq and don't touch errno since all the code
> > jumping to set_qp_fail already sets it.
> >
> > Fixes: 3991c890fb4c ("net/xsc: optimize RSS queue creation")
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> >   drivers/net/xsc/xsc_rx.c | 6 ++----
> >   1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/xsc/xsc_rx.c b/drivers/net/xsc/xsc_rx.c
> > index 5f8003a1f6..5ff3f818c2 100644
> > --- a/drivers/net/xsc/xsc_rx.c
> > +++ b/drivers/net/xsc/xsc_rx.c
> > @@ -502,10 +502,8 @@ xsc_rss_qp_create(struct xsc_ethdev_priv *priv, int port_id)
> >   	for (i = 0; i < set_last_no; i++) {
> >   		xsc_unset_qp_info(xdev, rqn_base + i);
> >   		rxq_data = xsc_rxq_get(priv, i);
> > -		if (rxq_data == NULL) {
> > -			rte_errno = EINVAL;
> > -			goto set_qp_fail;
> > -		}
> > +		if (rxq_data == NULL)
> > +			continue;
> >   		rte_memzone_free(rxq_data->rq_pas);
> >   		rxq_data->rq_pas = NULL;
> >   	}



