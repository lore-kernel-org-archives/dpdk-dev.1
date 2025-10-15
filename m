Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55FECCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 12:01:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E957C40A80;
	Wed, 15 Oct 2025 14:01:18 +0200 (CEST)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mails.dpdk.org (Postfix) with ESMTP id 38B9E4065E
 for <dev@dpdk.org>; Wed, 15 Oct 2025 14:01:17 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 70E4E7A012D;
 Wed, 15 Oct 2025 08:01:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Wed, 15 Oct 2025 08:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760529676;
 x=1760616076; bh=jIsVO0vN8i7PkXHbHLGKfhugr500egPT+vH7st5tJYE=; b=
 ObnM9gUzdDIl8wRHYtmfh+haDeFKtFPh7iaUQ7+WVAVA1/uMsfR7CfehxOQIbZH3
 rXQWc8cUiuT7bU5e+SaY8agOlfwL6+Op46RLYlNEJhlIVv6dv+NJgxviuSic/Cfg
 5HI8aCuZsHeuDKw0BfM6OwvmWkv9hklO9rWupZ40/gzMClu73sVfocQK29phTNXY
 /FyKIkEXMgx2j3ejZjsYr3vK+Oa8/1SIC3pGNrxcVADZ4uf28Zz5lc9Sy7vOn8eN
 SUXumKHDLb+YNNSLb1FjDD94sq3oevnHoGWXYO0fMhj78yPTicIrrxXqvZKGTwaa
 UFj3AgOJ8NUvvix/XW5m9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760529676; x=
 1760616076; bh=jIsVO0vN8i7PkXHbHLGKfhugr500egPT+vH7st5tJYE=; b=f
 reIUmdRTBPfaUjIE/1rMRUCw+osSDofiUMSHpGrGiEQPI37qtGrvrqIW1t/aYmZp
 ecCBA5l1Ui+5DCvbyBlxwOfSfiJF3+1eMSbNzcK/WEfJ4qbm9CoVOZO1uFK9VYdF
 yH6N5jVVChorZiqj1ATxLhQYb1EjMysSDOzU/4ulPhy+Dt6WTW50slWVF1F7pNAC
 fUs4ToFURB1VGqp5xakfxQhBUW5yt9YtPZuZK7SANDfVt3Dr/nX4vOLPkq1Lrr5t
 q1TXMFrPMa2y28cPvvnWsrT0c19f9v3fI+Ip7iAgTGwQUjr0dQvOjGMfs8nnf7fq
 P5H+PzdqTqJIsRfTe40Og==
X-ME-Sender: <xms:C43vaEJRN_mdVFnmp0U21K9lJkn6ks7PbF9Q2Vi0hSbSsh4ViNLC6g>
 <xme:C43vaIfQ_pHfIrbPdFcl8JB9jeKTl009rVbkqOyH3jqtMkLKreIB60j2n9L2ErBAF
 wncT_Wf7m6CU9nRFe5ex4TN4ITBWrEa-sTzCJzugrg4dA3oIomT>
X-ME-Received: <xmr:C43vaD3G4ELss10aBAYhbztx33dv8P6Zrf8V9pdWhU9ELkydwsQhX6jF-oFDBZGqyuAA8dQRrT0mMia4szIW1loAiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeffeeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertd
 dttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevff
 fgtdegkeeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnh
 gvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
 fhgvnhhgtghhvghnghifvghnsehhuhgrfigvihdrtghomhdprhgtphhtthhopeguvghvse
 guphgukhdrohhrghdprhgtphhtthhopehlihhuhihonhhglhhonhhgsehhuhgrfigvihdr
 tghomh
X-ME-Proxy: <xmx:C43vaJgt3cNeNgfAapp_qhNmXh6RioIwtniSaFKWStg-7Mqh7UENtw>
 <xmx:C43vaBQCwSjx4BmflNhFb0yZCu52FyCqmdpMv3ao-9YsQwVYA_PTLA>
 <xmx:C43vaCheRu0MVzRkF-rm4u0hYwJ-KLKq2r_t62wb_IgUYO_b7x_OTQ>
 <xmx:C43vaJ6Czyai4VD-j8cUN6cfdew8A_fyPJcy8IHH_M9utZ0cDKYvig>
 <xmx:DI3vaPKLDWqTYl-NbzZqYjrXsK5j_oMdIYu13sL76b76Xq5DxP2Yp84W>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 08:01:15 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: fengchengwen <fengchengwen@huawei.com>
Cc: dev@dpdk.org, liuyonglong@huawei.com
Subject: Re: [PATCH v4 4/4] dma/acc: add doc
Date: Wed, 15 Oct 2025 14:01:13 +0200
Message-ID: <6737235.31tnzDBltd@thomas>
In-Reply-To: <57df6dc3-aa82-3c2d-3980-7c5ef7b900fb@huawei.com>
References: <20250827092729.10719-1-fengchengwen@huawei.com>
 <4548489.fW5hKsROvD@thomas>
 <57df6dc3-aa82-3c2d-3980-7c5ef7b900fb@huawei.com>
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

15/10/2025 13:10, fengchengwen:
> On 2025/10/15 18:05, Thomas Monjalon wrote:
> > 13/10/2025 11:11, Chengwen Feng:
> >> +HISILICON Accelerator DMA Driver
> >> +================================
> >> +
> >> +Kunpeng SoC has an internal accelerator unit which includes zip function, and
> >> +the zip also supports data copy and fill. This driver exposes this capability to
> >> +DPDK application.
> > How is it different of drivers/dma/hisilicon/ ?
> >
> > "
> > Kunpeng SoC has an internal DMA unit which can be used by application
> > to accelerate data copies.
> > "
> >
> > If it is the same hardware (Kunpeng),
> > I recommend having a single driver, or a single directory.
> > Also we already have a driver named "acc" in baseband.
> 
> 
> they belong to different hardware IP of Kunpeng platform, /dma/hisilicon 
> is the PCIE subsystem DMA's driver, while this acc is the 
> Accelerator(ZIP) subsystem DMA's driver.  they don't exist in the same 
> specific Kunpeng Soc.
> 
> a single driver will add complex.
> 
> as for a single directory, should we do for all vendor?  I see there 
> are  dpaa and dpaa2, ioat and idxd both belong to vendor platform.

When it is really different driver, it is OK to keep them separate.

> if there are no rule to have same name with different subsystem driver, 
> I prefer keep it.

OK but why it does not contain HiSilicon or Kunpeng in its name?
"acc" is a really short name, and already used.
Please find something else.


