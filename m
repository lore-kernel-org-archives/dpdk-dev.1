Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E13ED7B96
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 10:26:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7CFF402E1;
	Tue, 14 Apr 2026 12:26:26 +0200 (CEST)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id 21726402DE
 for <dev@dpdk.org>; Tue, 14 Apr 2026 12:26:25 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id AEFD41D0003A;
 Tue, 14 Apr 2026 06:26:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 14 Apr 2026 06:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1776162383;
 x=1776248783; bh=qt2gca7K4sUukk7HXjuh64lS7OE5hxUv6eKPbNUb4Yg=; b=
 sUc/j1DjxI7gycxtJXGSq4v3cG2mbq+UTE8XtWUWSfR1/rE7G8kZvQ4UxqHLjlvt
 kusvf1D/4zGKxOz1WEW/5oNQmsvdOhrNiWUICFgAKvQjOrnCpEqn+BzPh8VuXjYn
 sp2bKGTg7nCL3+c8mvDO/HS6FjY281Oznnu8eGBVzQsqD0xR6Lw7Ng794idmZ/S/
 cauJ5HdJIF/SgytmG1rhxH1rGCoXWgCNDA/AnuCEMxBUO7FZH4iO1yhlKmJ01+bi
 Jf5+KWYy1CSILwuff7C1+58iXwLn0ODSJhhwpL2IRWyDLq4iMegiScRiRegbsZ9+
 NR9d3XRdSZZ2ltHDxJPt7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776162383; x=
 1776248783; bh=qt2gca7K4sUukk7HXjuh64lS7OE5hxUv6eKPbNUb4Yg=; b=E
 Kwvh8wjzHf5bIvqnb3zV/tu2EUNTpBO2C+CWKtwxtACvWfnvwZf6wgnLZX3eh9gF
 FRot8roYOhkfqdxQ57bRbmOYJJ6mlYCXZz2ssAmqts51xm0ha9u33D6MY01HGjFg
 O2k6cMevLPVP23Q4gIOflrtqLCmSA895Y4122BD9TbAVjYJsQ3CKw5bYYQFTWNMd
 gMykNoa8cs2s+88VumLRqvjiwjd3Kc5GUghQ0GW6ZAdjsnh3XWJBfmKAbhHBvuQi
 CSb2BPNzxhg0hbgv1cOCUL9ioPffRhbtkEqNai9v/1i5D2HsUqgKOpNkAwc9bWRP
 PjxebFrL5qvmNRarq67Yw==
X-ME-Sender: <xms:ThbeaWP6aPVgi23_8noHIioi2FPst4fm7BwpvZYHALTsaioQ6PEXDg>
 <xme:Thbeaajtni9F7Tx1hbEpeKTiCTjJNSXUCoXYUwGR_KgC6LKuTnGaLp9kTwIMTNDH6
 vPaYJtMyPw62jDFzgi03Isg-wxTcko2510CTNASy2vosoDGD9Y6JRI>
X-ME-Received: <xmr:ThbeaW2oYeuddCFC7VX_nJgVZirHJUSiaXsv2Wi3txY3OF_KIC83OvTEv6itBPYvV2-HbStKa4iFY59ltoblbFPOvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegtdeltdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepudejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvihgurdhmrghrtghhrghnugesrh
 gvughhrghtrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthht
 ohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtoh
 ephhgvmhgrnhhtrdgrghhrrgifrghlsehngihprdgtohhmpdhrtghpthhtohepmhgrgihi
 mhgvsehlvghrohihshdrfhhrpdhrtghpthhtohepkhhtrhgrhihnohhrsehrvgguhhgrth
 drtghomhdprhgtphhtthhopehprghrrghvsehnvhhiughirgdrtghomhdprhgtphhtthho
 peiguhgvmhhinhhglhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepnhhiphhunhdrgh
 huphhtrgesrghmugdrtghomh
X-ME-Proxy: <xmx:ThbeaXni6J-ImDJRT0fF1g52EiNCkm3F_hhRCnu5FUNR3zR9e-OKHA>
 <xmx:ThbeaVs_KX1z9L-QM-HevtmqTsuN8by-eARakrifJYgVwhTYWXRMaw>
 <xmx:ThbeaX0HxnzdefzkrLDPKXV3NYKXrc7UDzua6N1wz3eeKTZKNIeHGg>
 <xmx:ThbeaRS8RijAwkDp2cCPdmljztLNHc1Eo_PGlxohLVFuhXUo-8JZ3w>
 <xmx:TxbeaQcEWCt_Z-zjc_s_HDd15WosF9fdWR_MK7s2qePXjr7-1tIl986I>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 06:26:20 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Maxime Leroy <maxime@leroys.fr>,
 Kevin Traynor <ktraynor@redhat.com>, Parav Pandit <parav@nvidia.com>,
 Xueming Li <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>,
 Tomasz Duszynski <tduszynski@marvell.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, Kevin Laatz <kevin.laatz@intel.com>
Subject: Re: [PATCH v3 5/7] bus: factorize devargs lookup
Date: Tue, 14 Apr 2026 12:26:18 +0200
Message-ID: <6806263.GXAFRqVoOG@thomas>
In-Reply-To: <2267120.Mh6RI2rZIc@thomas>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <2054977.usQuhbGJ8B@thomas> <2267120.Mh6RI2rZIc@thomas>
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

13/04/2026 21:48, Thomas Monjalon:
> 13/04/2026 21:18, Thomas Monjalon:
> In the function rte_bus_find_devargs(), there is this comment:
> 
> +               /* The name in the devargs is usually prefixed with : */
> +               if (strncmp(devargs_name, bus_name, strlen(bus_name)) == 0)
> +                       devargs_name += strlen(bus_name) + 1;
> 
> I think you mean "prefixed with <bus>:".

Actually this is what you wrote but my mail software hides it because of a bug.
You can ignore this comment.



