Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BD1C5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 10:28:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 241A342E62;
	Tue, 10 Jun 2025 12:28:23 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id CFE6D42E5D
 for <dev@dpdk.org>; Tue, 10 Jun 2025 12:28:21 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 07220114011B;
 Tue, 10 Jun 2025 06:28:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 10 Jun 2025 06:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749551300;
 x=1749637700; bh=9j5/vTCnNRvGmuLFDHUvvRkMHyNJtkfuNcsrRx0i2f0=; b=
 flRvkUcQmZ5wn3l06RRpc5Gwyv6nDhKLAN1+4RAFrZ0DmISdJvxVR6pFmMARspDo
 nRJmHApVILwGhweLy3TwEm7zABI3Rt4o4xlb2AR9/5cpB8OidxK/NbPMh6/t/Rf1
 r0kHWnoQBPuBSttumsZbQnf8yTgCk5TLK3CKWN+J7bm4TW11+24ihKFVsElFMGRE
 mZpo6z+vTFDSuR9LPrtvPccRoKMdj0DU8v3MtaQRuuf65qgSsalhsdIT9FUnjc7g
 YkkAROBo9GtJRH3rjrAEjg6vAdfWPXT4oinawXFcu7YzDHXXKDA8NFw0YrDODpsc
 hZ7dL2frLIThVqH4uWDNuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749551300; x=
 1749637700; bh=9j5/vTCnNRvGmuLFDHUvvRkMHyNJtkfuNcsrRx0i2f0=; b=U
 LLHvKfFCkRTrHaNCdmqkQ4vrJ32FyBsK0BV2SC2i7nc8Yik7gyAsyIbZdZZU5Y/n
 PIinQADsmWXUQy4Uy5Q1WTzM399hU0nAPg2pFBFfluSjE+EqPvZgOpE2SCOuGY8T
 RMYp+RU90Y4hlHA0sTeZDoOS5prj7QjPiwz0DOcqSwE2fO+E2URAyDjs2KYF+2qu
 kYkJ1taL66WTxx5b7RfjIPiD29fC5oHENboK+WQg16/Rv+g9QGZDJVEMIrDcPWi+
 7zZuUruztkglC5pZg9k7rbEAdwn+cEtim4Up/YBuiNWf5Az1vLUehAl/TeDh428s
 6lsliv26y2b0GizZ+c0eA==
X-ME-Sender: <xms:xAhIaJkynhK6xsIuVikvef_yEWIOold0x4LLuLZQO8KGjHWK9o_Fpw>
 <xme:xAhIaE0d06lXslKkC61uU5095-iSIrtIqCQVKBtuhgmeZD5mA1N349GSflijiqk1Z
 pxO-7ARxAt1RIOdCA>
X-ME-Received: <xmr:xAhIaPr_krv-iCjomnOK9tPQhtFVTjy_mMzgjMw7r_djed_okZ1QXNEeK9maoonhuYuIJuIRBlE23IqnLXU1pKjSiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddutdeivdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhtg
 gthhgtkeekseduieefrdgtohhmpdhrtghpthhtohepjhgvrhhinhhjsehmrghrvhgvlhhl
 rdgtohhmpdhrtghpthhtohepnhgurggsihhlphhurhgrmhesmhgrrhhvvghllhdrtghomh
 dprhgtphhtthhopeihrghniihhihhruhhnpgduieefseduieefrdgtohhmpdhrtghpthht
 ohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepkhhirhgrnhhkuhhmrghrkhesmh
 grrhhvvghllhdrtghomh
X-ME-Proxy: <xmx:xAhIaJkF7frp8xfZvh0SPBeT3HhcZ_qEQQfO7UmH_Y7L_Jvd6n87fQ>
 <xmx:xAhIaH2cQt0H6I73fVmNUf4IA_EzQQFuI29tzlw_d5m88NTFFxbrJA>
 <xmx:xAhIaIuLFzhjRgIYwple38kckNmoeBkIaUMxlTbQzo9OGXjtALNIdQ>
 <xmx:xAhIaLXdJqq9q90ei_pM_Wf8u1kC1jENO_MLBcNffHLkcT0lmRvgQQ>
 <xmx:xAhIaAf-iUAxg4M4u3iZUcE2my2ERZcoaEUxlpfWLAVt2RFWdZyiYGqT>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Jun 2025 06:28:19 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Huichao Cai <chcchc88@163.com>
Cc: Jerin Jacob <jerinj@marvell.com>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
 "yanzhirun_163@163.com" <yanzhirun_163@163.com>, dev@dpdk.org,
 Kiran Kumar Kokkilagadda <kirankumark@marvell.com>
Subject: Re: [EXTERNAL] [PATCH v8] graph: mcore: optimize graph search
Date: Tue, 10 Jun 2025 12:28:18 +0200
Message-ID: <4921622.yaVYbkx8dN@thomas>
In-Reply-To: <PH0PR18MB507108E9C176A9D0DC0868A6ACC62@PH0PR18MB5071.namprd18.prod.outlook.com>
References: <20250206025322.2182-1-chcchc88@163.com>
 <20250207013939.1783-1-chcchc88@163.com>
 <PH0PR18MB507108E9C176A9D0DC0868A6ACC62@PH0PR18MB5071.namprd18.prod.outlook.com>
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

> > In the function __rte_graph_mcore_dispatch_sched_node_enqueue, use a
> > slower loop to search for the graph, modify the search logic to record the
> > result of the first search, and use this record for subsequent searches to
> > improve search speed. 
> > In the function __rte_graph_mcore_dispatch_sched_node_enqueue,
> > use a slower loop to search for the graph, modify the search logic to record the
> > result of the first search, and use this record for subsequent searches to
> > improve search speed.
> > 
> > Signed-off-by: Huichao Cai <chcchc88@163.com>
> 
> Acked-by: Kiran Kumar Kokkilagadda <kirankumark@marvell.com>

Applied, thanks.



