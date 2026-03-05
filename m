Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1358CF33A66
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 13:59:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DDB240A6F;
	Thu,  5 Mar 2026 14:59:48 +0100 (CET)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id 0DD204029D
 for <dev@dpdk.org>; Thu,  5 Mar 2026 14:59:47 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id E60897A00FC;
 Thu,  5 Mar 2026 08:59:45 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 05 Mar 2026 08:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1772719185;
 x=1772805585; bh=NSKd5w5IQjoJHb6SyeVi6hnnVYXuaSa8HnxyOPGvzMU=; b=
 O81nrHL/nuGmfgm7VaS26QYTX3/8cUJm7GCY77wiUyXu4VBwalU+bYEFbV8cZFTx
 nEosuJBp/xd5DRZitSI89gkYj5iJQTwNJSI707PQisb8pVbvrsw3rN+tugXJIElr
 8xOE695p0OBwiWL1Xdbz/YugeVBYKJbCsppjF2XaIcwxrbfOtgMhebm7WZxTR+zJ
 QqPYPkY3clv1go7ZfV18BmQ4yxStyO6vICzsbnPfe2CmDR/bqMeY6ajaB/CkEqaa
 mnxq7QCUK+rVw/qvrWwjNrwOclpxMajdOF71kLNxEeaVd1ABJ+/Pu6B4uk3/LZRs
 PcFuQj1pHmoInPhvhXY27A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772719185; x=
 1772805585; bh=NSKd5w5IQjoJHb6SyeVi6hnnVYXuaSa8HnxyOPGvzMU=; b=H
 ZYhxTIdXOE+z84K74til7hzQ1N9jUge/bl7ym5cmsBRgJYMSvHzfvGLOBIoaU6CW
 CE9/EDYR9QlUIFFSFAa+sOUDT1e34aDZelYNDXwQiDfDtvKSKwM/WY7TNLu9ADY+
 /wG1kAiLhSxc6qHWGRRbWQ3hpnfKgB/QsADOXP8O58vzkqVRQy7y1Bg8s4P7gRr4
 Qv/QmK+PwkHKGhROKSit5k829fQz7tQHX3VkEuGuvTVuv9lIob+J34d8f0ZJL41l
 tWWwSQQdlCYHTAFlxP8IFxywz4aLlyhW6QcwnKWZDCnNa3/h6B18YfC3wzi26EnQ
 SzVs/zpGd1SRLEyOea0GQ==
X-ME-Sender: <xms:UYypacJw4GqevreHHJgy9PzCp2G-QFPt5XnDDZdYs0_RrYS_eE-e7g>
 <xme:UYypaVGoslld2IPVxDZgfHd0nBn9fC_W6Q8RgxQa0zfntLz_oRn1FHM8I1YGFe64g
 rOQ2h6W_MZWnKmXPmC8vYm7e_fScF5l2syruVvn_ORxJJ4cwM6XgJE>
X-ME-Received: <xmr:UYypaYS4L3MgtQNB8r1WvN-9f6IXAuvfBwK7btuFxtBKGYeGeizk5yoeeAhPt0-lrX2ceFlie12nYiYkMiNCDJzh_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeiheeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvkeetheduvdeukeetjeetledvfeelfeetkeeujeffjefhlefftdev
 fffgueetteenucffohhmrghinhepuhgtfidrtgiipdhgihhthhhusgdrtghomhenucevlh
 hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshes
 mhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpoh
 huthdprhgtphhtthhopehmrghurhhitggvrdhgrhgvvghnsehmrghurhhitggvghhrvggv
 nhhjrhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhope
 gvrghgohhsthhinhhisehnvhhiughirgdrtghomhdprhgtphhtthhopehgvghtvghlshho
 nhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepmhhkrghshhgrnhhisehnvhhiughirg
 drtghomhdprhgtphhtthhopehrrghslhgrnhgusehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:UYypaZdpOXSVoaHbL8ZOdBxz84LMUCDNy-RjBJfZKM7XX_QEhDltCg>
 <xmx:UYypafr5RqPPI5fvOzSOUR4iP7mIwEy0GLhOB-x0Euk7kokcB6dyMg>
 <xmx:UYypaS97NGz7Hnn-yxpC0Qosx1HnwRArpCOhIEqhDAj1MbIlEZfkrw>
 <xmx:UYypaTd8zvDYWrLbzLA-ynK5zR_gIMlMX27OgWpKcLmABp_bY55kTA>
 <xmx:UYypaWEe47lniVg-mA5F2sBGL38gGYkKP-1MnmzUdzXAb11U2Zy18INc>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 08:59:44 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Maurice Green <maurice.green@mauricegreenjr.com>
Cc: dev@dpdk.org, eagostini@nvidia.com, getelson@nvidia.com,
 mkashani@nvidia.com, rasland@nvidia.com
Subject: Re: [PATCH 7/9] gpu/cuda: extend NVIDIA GPU device ID list
Date: Thu, 05 Mar 2026 14:59:41 +0100
Message-ID: <6412176.lOV4Wx5bFT@thomas>
In-Reply-To: <20260304225051.26238-1-maurice.green@mauricegreenjr.com>
References: <6937723.QfHCVqEBuz@thomas>
 <20260304225051.26238-1-maurice.green@mauricegreenjr.com>
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

04/03/2026 23:50, Maurice Green:
> > +#define NVIDIA_GPU_GH100      0x2335 /* H200 SXM 141GB */
> > 
> > As you can see it requires knowledge to get the right name for each ID.
> > Not everything is in https://pci-ids.ucw.cz/
> > https://github.com/NVIDIA/open-gpu-kernel-modules is a good source but not perfect as well.
> 
> Right, the naming is a little tricky since neither source is fully complete.
> I wrote a sync script that cross-references the PCI ID DB and OKM repo to 
> construct unique macro names. For the few entries with totally identical
> descriptions across both sources, the device ID is appended as a fallback. 
> Here is an example for the GH100 family:
> 
> #define NVIDIA_GPU_GH100_H20                       0x2329  /* H20 */
> #define NVIDIA_GPU_GH100_H20_HBM3E                 0x232c  /* H20 HBM3e */
> #define NVIDIA_GPU_GH100_H100_SXM5_80GB            0x2330  /* H100 SXM5 80GB */
> #define NVIDIA_GPU_GH100_H100_PCIE                 0x2331  /* H100 PCIe */
> #define NVIDIA_GPU_GH100_H200_SXM_141GB            0x2335  /* H200 SXM 141GB */
> #define NVIDIA_GPU_GH100_H100                      0x2336  /* H100 */

That's interesting.
How do you suggest to fill the gaps in these databases?


