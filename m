Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0A7CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 19:24:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEEEE40395;
	Wed, 15 Oct 2025 21:24:37 +0200 (CEST)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mails.dpdk.org (Postfix) with ESMTP id 6554840273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 21:24:36 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 633AD7A017F;
 Wed, 15 Oct 2025 15:24:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Wed, 15 Oct 2025 15:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760556275;
 x=1760642675; bh=aJdmcDxa+vVnV2tpIacWEbZ7WcLFO0mTIxhDs1nF+Nc=; b=
 coFCu5YGBAn1paZAloiF6xYvu+KFNwRy6vF/gxn+ORVS2ALfJdLDawkuf94SB6V2
 1GGsv/m0euVYl7Af+4Q7jlCsYPqnNqoFCc4va9kLcUFaQwyaP/QZlvbSu38S3iue
 s7JE0VgJqEV+Ft573oLVBTWtMhyMFwYmtobnCQ1aqrFE1C97tdqWcKlgQSrc2Fwz
 MAN+jVCl9s+bJby6qtAEZhOOzZIcGXmLjYLL5LA+timoVlDLjH7OxGHf8Sq6oqV4
 T6SJ8myyjHen4Uqr8cz3FzdvuRUpurXb3yxGidPDb0MKSgkSdCopJ0skBwDEgHL8
 5hT65hiCIPsjx8dAKd/wVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760556275; x=
 1760642675; bh=aJdmcDxa+vVnV2tpIacWEbZ7WcLFO0mTIxhDs1nF+Nc=; b=K
 xqYL2R+uuIYio+6O/LvszX8XvcQPQa+nzv8iTPMWlN7lI48d6zyATPqx/pVQwZ7u
 M/rRQtE5y6lw+1+e5qhnGAFl+bZ1BGAbAj1AVf/gPimvapUapDRYTZQcGB9P2MSg
 VqFzzw+l+2M+wuYZxb+qRmuW+JYXCVQJy3yb6HpVUk/KjMA7FKnCfxOLBcJ4WpUW
 kKdZtBURAnzy5NkKQLttfGFTNUN9r5CatJVtuaMS5TDCkxhSyM8dhUeAGNwJBZbP
 /hiPirBOfk39GEIU4ZcM1o5XwJqj7LOO1tj4R7lYW/HHOLSh49cUX+rnOhQOrJht
 9f/gmE57XbpYB/eSIwMrg==
X-ME-Sender: <xms:8vTvaA9aZwKOqOfr9vXEgZ6iOJ1QuOXRwwj8Xv0uWBUNqAYIpIiCKQ>
 <xme:8vTvaHzNJ3cLtjqDtELL1lOLS42Fov7tMytzflQ5v86S_HFF-h3QL8WPk_QU-YAWb
 GVu-YwOErycOfjW8CHYC81Ux9ToOg304-z6LNGz613F0Z_5ar-Buw>
X-ME-Received: <xmr:8vTvaMOjbAglRP--4WvzoYuVcereLsIVrQGHojom5Q_BTobdkeQZaTKJc-JbmB5Yf_UdeYJZ-uRw0YU_zbNyDEGQNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdegvdegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeekpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehstghhnhgvihguvgesqhhtihdrqhhurg
 hltghomhhmrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthht
 oheprhgvshhhmhgrrdhprghtthgrnhesihhnthgvlhdrtghomhdprhgtphhtthhopehjvg
 hrihhnjhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopehkihhrrghnkhhumhgrrhhk
 sehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepnhgurggsihhlphhurhgrmhesmhgrrh
 hvvghllhdrtghomhdprhgtphhtthhopeihrghniihhihhruhhnpgduieefseduieefrdgt
 ohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorh
 hg
X-ME-Proxy: <xmx:8vTvaM8JELhoImYnskM-VV1tFc3RyfSU2uJRZDRfraDuo1KZ4wAP1A>
 <xmx:8vTvaJ61tnxydRggg7ZGsv_RnCMep4LAT70t2dcclz2YTGLNL1FzvA>
 <xmx:8vTvaC5GV5M20yF2rto2ecPrDBz5O1treXgAdRbHnhjpc_Ar_GcvoA>
 <xmx:8vTvaCqGYT6VR9PViCFbV01Wc_5gbPFx3vn7C-CsKSGiO9bGoGr8Vw>
 <xmx:8_TvaL7wnGpAjBmzgG3HEvVXJ-w_RCa087rExvLjGIVjXUaWd7w5qza1>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 15:24:33 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Schneide <schneide@qti.qualcomm.com>
Cc: dev@dpdk.org, Reshma Pattan <reshma.pattan@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the interface
 block
Date: Wed, 15 Oct 2025 21:24:32 +0200
Message-ID: <23703401.hxa6pUQ8Du@thomas>
In-Reply-To: <20250925165442.3a7a1764@hermes.local>
References: <20250827153852.1066521-1-schneide@qti.qualcomm.com>
 <20250827223216.1337749-1-schneide@qti.qualcomm.com>
 <20250925165442.3a7a1764@hermes.local>
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

26/09/2025 01:54, Stephen Hemminger:
> On Wed, 27 Aug 2025 16:32:15 -0600
> Schneide <schneide@qti.qualcomm.com> wrote:
> 
> > From: Dylan Schneider <schneide@qti.qualcomm.com>
> > 
> > Allow the user to specify protocol link type when creating pcapng files.
> > This change is needed to specify the protocol type in the pcapng file,
> > DLT_EN10MB specifies ethernet packets only. This will allow dissectors
> > for other protocols to be used on files generated by pcapng.
> > 
> > Includes a breaking change to rte_pcapng_add_interface to add link_type
> > parameter. Existing calls to the function have been updated to pass
> > DLT_EN10MB for the link type argument.
> > 
> > Fixes: d1da6d0d04c7 ("pcapng: require per-interface information")
> > Signed-off-by: Dylan Schneider <schneide@qti.qualcomm.com>
> 
> Acked-by: Stephen Hemminger <stephen@networplumber.org>

Applied with fixed release note, thanks.



