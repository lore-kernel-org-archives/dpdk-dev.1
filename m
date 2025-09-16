Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C724CAC598
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 14:42:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D610402E5;
	Tue, 16 Sep 2025 16:42:39 +0200 (CEST)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id BF97F402E0
 for <dev@dpdk.org>; Tue, 16 Sep 2025 16:42:36 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 12BB77A021B;
 Tue, 16 Sep 2025 10:42:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Tue, 16 Sep 2025 10:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758033755;
 x=1758120155; bh=io7JtQjWhkoTdndq1TR770I+viPZ+ZdIXt3yiMrFdEU=; b=
 bo+jGc6BmiiseMbXUzBpTgjW4wGF5ubbMycYYmwCi5dMgLoiTy/OQHTgO/CzVdTs
 ZQG9X6ySSKKvE6Bv12Brumv22rKl0LHvHRO1rbKgR1a7zShnaM6r8sb3SLo4pzPV
 GPFPyVsmg1A8Pis79R6jLZC21PSBwJT4oIvUPa4UTvrI+tyNRwPOgklFgSv/Wq5t
 BoMRqg5tMUMgfyYcEDyrP5eCvPLWhvx9WYzFSzCNJ7KpgDreazeaKDNZDKY4cxna
 OdjCfhwc0ha3IPAdLcQokmvl4n8DQBj42n9PVSpT+/IgJqknkiNNL6KFI6ychI8J
 EitSmmzkAaYAKvAQcrr7Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758033755; x=
 1758120155; bh=io7JtQjWhkoTdndq1TR770I+viPZ+ZdIXt3yiMrFdEU=; b=e
 v8hb7gsyxQE+cgt2CC5/VmDksEIQrQx3qFhEI9+ZKi5yduBiA0wuHzsYuCFZ5Ds0
 +vAIFQYPjJzk/Y03kxpiNX2HNVTBHij8cHZPxvt7OCgjVsgCuE1sKa84O4th72uR
 neBF8pCgiGeWen2KGOzEYmsS9VkfJTI9dK536kdC+1QOEptTZk8PmyT6VsZE5Apj
 z/GJzRA8tGwfWCgfZucP8HtEBTucLH0QlOi3mnmUFF8KzpxnJsMJ6MsvtGUVZxyg
 iuTb18apr19H/xYOXBgGHqV6JkUH88cBHHHemJO9mNCLLicDyHY1qymlt3Rb5PWv
 tajsJxoklzl4250QLrVcw==
X-ME-Sender: <xms:W3fJaJrAGzmCckAw3KiD6wTPsRzpcmKuTul9hAFq_k1XskF9ztk8ww>
 <xme:W3fJaGNrvcfamGTPDe5hgJ4pK8nnQkeO9TmJBzMXI8o1N4WTILlDVjoPn0Gk0zSah
 f20cKQdUMORRBrp0g>
X-ME-Received: <xmr:W3fJaCy5hewp4eI6zqMnqRE7a44niTeHFpW9_gMPdI2Cys0ZoHRsdWbxxH5-RXqE1K2UJmmU2pTamJqr2L86favXOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegtdekgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepkeefheeftdegtdejheeuuedtgfelfeeiveekieekleekffelgfdtveei
 heehffdunecuffhomhgrihhnpeguphgukhdrohhrghenucevlhhushhtvghrufhiiigvpe
 dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhn
 vghtpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
 hluhgtrgdrvhhiiiiirghrrhhosegrrhhmrdgtohhmpdhrtghpthhtohepuggvvhesughp
 ughkrdhorhhgpdhrtghpthhtohepphgruhhlrdhsiigtiigvphgrnhgvkhesrghrmhdrtg
 homhdprhgtphhtthhopehprhhosggssehiohhlrdhunhhhrdgvughu
X-ME-Proxy: <xmx:W3fJaHuVHmNvkORXGLwzwpZQ6tQ-iih0RPlbaPhC3JlnQJtaVGpBVw>
 <xmx:W3fJaD51THTvnTxUbOKO8ghb2qF9lPOKnquM5exxwsTXpdMCrHQYcw>
 <xmx:W3fJaOSy9pacyZjxeiCKrglUE5S5kIC4uX9dU23I8ul0Hy7PDvQcPw>
 <xmx:W3fJaKrpH6mv3MpZRJchRQwtY2RgHQSM-CRRYCvb_qx4NNHBjpH_oA>
 <xmx:W3fJaASAf-Sl2A-1d7AxW6orOcF2J32sGo4eFV_qUU9ZqfLUeI5cHTVu>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 10:42:34 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>
Subject: Re: [PATCH] maintainers: update for DTS
Date: Tue, 16 Sep 2025 16:42:33 +0200
Message-ID: <3840251.MHq7AAxBmi@thomas>
In-Reply-To: <20250807143019.1986881-1-luca.vizzarro@arm.com>
References: <20250807143019.1986881-1-luca.vizzarro@arm.com>
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

07/08/2025 16:30, Luca Vizzarro:
> The MAINTAINERS file was only updated to replace Paul with Luca for the
> next-dts tree only. This commit adds Luca as a maintainer for the dts
> folder on the main tree as well.
> 
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
> ---
>  DTS
> -M: Paul Szczepanek <paul.szczepanek@arm.com>
> +M: Luca Vizzarro <luca.vizzarro@arm.com>
>  M: Patrick Robb <probb@iol.unh.edu>
>  T: git://dpdk.org/next/dpdk-next-dts
>  F: dts/

Acked-by: Patrick Robb <probb@iol.unh.edu>
Acked-by: Paul Szczepanek <paul.szczepanek@arm.com>

Applied, thanks again Luca for taking this responsibility.


