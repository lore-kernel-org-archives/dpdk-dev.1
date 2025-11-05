Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7BECCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 21:34:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3969340BA4;
	Wed,  5 Nov 2025 22:34:43 +0100 (CET)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id DB5DC40B9E
 for <dev@dpdk.org>; Wed,  5 Nov 2025 22:34:41 +0100 (CET)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id 6FA2AEC00BD;
 Wed,  5 Nov 2025 16:34:41 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Wed, 05 Nov 2025 16:34:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762378481;
 x=1762464881; bh=vTtyCdcrk6wqRxBo/YJ5YtozmobDfxp7PSt9dbliGKw=; b=
 v6r0Nl4G0hlhfhjGt1YKCnSNFbxRy2uBVYLU0ZMJl8cSTsH/xPEnHmpwVE+YepJ7
 I+mpkBl/+NlZEDj0rAOsheYExtCO/xyXlmrYtABXSXY2d79RZFOlqlUSnMh9gC4u
 ArRI8LJAp1LVJlT8CAtmU1i9vTihDi1vqudL59FQY+dGGi+6LdrNEvDmJ8xlSNI/
 CPVMh2mxLZCuUO54PBFQHsKYQGX5q8yCK2MgvzIQhnWR4fLMDTEKgPsu8Spg56xy
 mtMGDeUm7aRnN/6ts9hPpivWVD6J9dkaw0EX4Csyi73nVPpT8ZmkFYSw5U2u6taG
 PIvbpEmaF5M2l07XeLeb0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762378481; x=
 1762464881; bh=vTtyCdcrk6wqRxBo/YJ5YtozmobDfxp7PSt9dbliGKw=; b=W
 I8tyF/p8ejazjbrK58AmSHHvAvMwjeA9ziTbeQsEuXYbT1BL0Pp+n4tVXP5y1aAm
 FrW1ypjTRhT8l/DdgtX3yA1i8AbTUh+60G6oUdtMcOk2O/Y2Yo6aC8OU5iH1y3pr
 cqhUEkboU3yyP5JJ0cT2bGC32Lihih0lZ9VkB6OimOJkGzaYYQ2OYa3uK8F7PAX+
 G8+rbkFekeRuIS9P0dU3tOzei2Pv0btzGIvxb9FSbttvw/CXjCSg54WAJU0JmXFD
 2WmwiweNTtBlZ9CNzEDRGvIdPVzjxyMpa7TppbYbpkoQJ+Y7kbHSijPg/i7MIBJD
 jm71YTEo+XY9H1En1IxnQ==
X-ME-Sender: <xms:78ILaQAlGB84cXWtRWvtOXjnyAC_eRqJ6OoGSsEN6mY6ZUhfje23oQ>
 <xme:78ILafMMMBi0VzBHlJkxP_9M7Y6-xuBvzc3ySkLDVdAePPp0Tyj3OY_YFWcKH3dsw
 whjrRvsGEYfQighGJet48tqGor1L7JqEem_sPahIqJDLFaIIIaN9w>
X-ME-Received: <xmr:78ILaXe4CZyZtnTMS67hrHzmTov_KVStO5-a_eyWSxDeAQBfWhJl1uB8yxZsKxkE8b3jKjNs4n_s7OZ4zRY0LJDGyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegleelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedugedp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtg
 hpthhtohepohhrihhkrgesnhhvihguihgrrdgtohhmpdhrtghpthhtoheprghmrghnrdgu
 vggvphdrshhinhhghhesihhnthgvlhdrtghomhdprhgtphhtthhopehkohhnshhtrghnth
 hinhdrrghnrghnhigvvheshhhurgifvghirdgtohhmpdhrtghpthhtohepnhhitgholhgr
 shdrtghhrghuthhruhesihhnthgvlhdrtghomhdprhgtphhtthhopehgrdhsihhnghhhse
 hngihprdgtohhmpdhrtghpthhtohephhgvmhgrnhhtrdgrghhrrgifrghlsehngihprdgt
 ohhmpdhrtghpthhtohepkhgrihdrjhhisehinhhtvghlrdgtohhmpdhrtghpthhtohepph
 grsghlohdruggvrdhlrghrrgdrghhurghrtghhsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:78ILaQ5oWAmbtU2kuJk3LX5OBdx9JGZZOd0tycenfPOY0Ig2P2UrNA>
 <xmx:78ILaZIvgEDZyrfzqA3-XKSjM1-PTzTLknTMWXJY9igOhnYgDyaYzA>
 <xmx:78ILaaW0aUj_YphkpyvEi7ue0AUFxApE2TGFDK5hRlfGKr5SLhbFlw>
 <xmx:78ILaVGw1IrDDSLSN3eLYeZRxsTxty98uo18OaMz4hOJUx8QJ18Qig>
 <xmx:8cILabmhDq47c_zXDrRgp-lwgFhuE11u8eHNcV9hEx8_k8_25Z1Uot_f>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 16:34:38 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Ori Kam <orika@nvidia.com>, Aman Singh <aman.deep.singh@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Gagandeep Singh <g.singh@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Kai Ji <kai.ji@intel.com>, Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>, Wenbo Cao <caowenbo@mucse.com>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>
Subject: Re: [PATCH] fix after-code Doxygen comments
Date: Wed, 05 Nov 2025 22:34:36 +0100
Message-ID: <2746681.0RtB02Ng89@thomas>
In-Reply-To: <20251102221400.4018641-1-thomas@monjalon.net>
References: <20251102221400.4018641-1-thomas@monjalon.net>
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

02/11/2025 23:14, Thomas Monjalon:
> The comment syntax /*< is a mistake.
> The intent was to put a Doxygen comment after some code with /**<
> but an asterisk was missing.
> 
> In cases of .c files with all other comments not using Doxygen syntax,
> it is converted into normal comment syntax.
> 
> In cases the comment is completely useless, it is just removed.
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

I suppose there is not much to debate or review.
Applied



