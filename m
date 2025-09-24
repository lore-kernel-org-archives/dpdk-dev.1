Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9706FCAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 15:08:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D81C74065E;
	Wed, 24 Sep 2025 17:08:00 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id 220DB4025A
 for <dev@dpdk.org>; Wed, 24 Sep 2025 17:07:59 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 0148F7A016B;
 Wed, 24 Sep 2025 11:07:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Wed, 24 Sep 2025 11:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758726477;
 x=1758812877; bh=mCSaPiXRoik5We5f3PgDRN4Kj59wWTtY5YkLqzCVtlM=; b=
 QT+QGYAgye9Oj1L8diNHcZ7x1gS51+6a9LU821+gy7r+XnEoB0KNiDu6QIRWnAya
 AXDe78uqWscmxkZgDqHBlFzchl02yIaI+zEZ6oXI8QJq/+2mIout6CNALZCgo6x6
 PgAzcs4hQCF+qNSupgStLJiWvMFWMaJzuvwKXtul44MoTozU1LagUPhwXajoF4EA
 P/9GCi72xBeyxL84bY9BDU9lDLBsAGsqB1Mpqr5P+QHqIETBY7uI2NDaJcYz1BWk
 PTkjRR4B7RGz+RyfMw8c8xq1ZAggD400BzfTR7hXhtpo+FqlwMyNB426dJ+IyPOA
 JW5fVhyTGDr/1VNtDXcy3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758726477; x=
 1758812877; bh=mCSaPiXRoik5We5f3PgDRN4Kj59wWTtY5YkLqzCVtlM=; b=C
 FlHN978f38xyWajDdJ7brAbySaG2AqtmdbOzDOw5Mz9XEqYHhta+Y3uRzspRNH1s
 YT1sQyooFP2sjqJFR2QsTBoDrPsiTSOMoJD4pQI9KvCTqK6fGKQQDHFZKV7ffZ/8
 pSdT4wbZPmJWcOBJpkaHTNIL+DCEFh5AkyC2qM0xI+Q3HMcMG76m8CodnLDq0jIr
 mF53+xmPrwUUDrnmP3pmV+txbIhm+lx7R47hGtpRaM+yrDtoXVATnhLTNs784OUq
 ducVxhYwX7yPJuIO3UZaRciSVUBczGdJmyRDeHFYAoqL2wLicOebYacKxAVma+Hv
 BirjBlZpzVBI/l9iMgxKw==
X-ME-Sender: <xms:TQnUaJp4VU5jXs8vNGPLYkGV5xhXpI6_jYBs90vngfLcpAb4CTjtBg>
 <xme:TQnUaFsVBDGiA9uM4SE6J7cSIyu17dD-QhekoBLiDbXrQI_QVt_eMpFms7Yw8WLws
 Aui91mGApmwlUc0yHzftlW-EEvF5ugC9IKBmowfzUnAl2ELOCaFY74>
X-ME-Received: <xmr:TQnUaGE1q5edr15OzXHBQxGnD7B3UxWqLKFBgcxdnlVrpWqRQYP_y05D5XJriqIm76oVYtGXC6tB52moevlV5xruhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifeelvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepkedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpth
 htohepkhgrihdrjhhisehinhhtvghlrdgtohhmpdhrtghpthhtohepphgrsghlohdruggv
 rdhlrghrrgdrghhurghrtghhsehinhhtvghlrdgtohhmpdhrtghpthhtohepkhhonhhsth
 grnhhtihhnrdgrnhgrnhihvghvsehhuhgrfigvihdrtghomhdprhgtphhtthhopehvlhgr
 ughimhhirhdrmhgvughvvggukhhinhesihhnthgvlhdrtghomhdprhgtphhtthhopeihih
 hpvghnghdurdifrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehsrghmvghhrdhg
 ohgsrhhivghlsehinhhtvghlrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrg
 hrughsohhnsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:TQnUaGbbr0eOpB4yDajo7G9UbgohNFHCBfho_16Yb2RngIh9i2_vnw>
 <xmx:TQnUaGXMks7XrF-HRI7G9076HORGPbBrNgdFyUfowN3PTrtjkHgJgw>
 <xmx:TQnUaMniKFBHrsfLwEHZepiOCD9hhmHlkOY9e2IeNOQVoEm5XmTCWg>
 <xmx:TQnUaBC0s2RZ-zXMoGp95Va6v9BmZ3Kf7JTCyKzpdd1bwy6W_fmhAA>
 <xmx:TQnUaKIGXMYJpuCA6BA8Qam6rNQQG3bdasODEbh_XSCIJJzjBpcqRPV8>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 11:07:55 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Kai Ji <kai.ji@intel.com>, Pablo de Lara <pablo.de.lara.guarch@intel.com>, 
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH] eal/x86: remove useless include from spinlock header
Date: Wed, 24 Sep 2025 17:07:54 +0200
Message-ID: <6492290.29KlJPOoH8@thomas>
In-Reply-To: <aND9b4QpcXHAaC2o@bricha3-mobl1.ger.corp.intel.com>
References: <20250919190226.1840008-1-thomas@monjalon.net>
 <aND9b4QpcXHAaC2o@bricha3-mobl1.ger.corp.intel.com>
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

22/09/2025 09:40, Bruce Richardson:
> On Fri, Sep 19, 2025 at 09:02:26PM +0200, Thomas Monjalon wrote:
> > rte_cpuflags.h is not used in rte_spinlock.h,
> > so it is removed, and added back in .c files where needed.
> > 
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> > ---
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied



