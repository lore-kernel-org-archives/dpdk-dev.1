Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742ACC83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 20:06:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 233F84026C;
	Mon, 21 Jul 2025 22:06:51 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id EB5294021E
 for <dev@dpdk.org>; Mon, 21 Jul 2025 22:06:49 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 4EDFD14001D6;
 Mon, 21 Jul 2025 16:06:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Mon, 21 Jul 2025 16:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753128409;
 x=1753214809; bh=AGbRUP4QtnVq9jsg7hlaqceU4k3t8eOGq7HiFudj+YI=; b=
 xbKDvgyaW9tyzqqCWr/5QLTdklqd+yJ+C5XCJdFy0Msc+k6zay+3KgEe/fd0vG/A
 3F3hHkEGy4c7kNZgMxSpGNENByXDgvZ2E2Za+8CZtLotwkvuJzbh2YTipx+lnhem
 SdsuMpL5Ws/ZY57GqZ9nn0C6kvtVRYX5K/Hbqj0NSS7Th5++ZsEqVO4nNAP4gphY
 fw904tZ5ztp3R5H7MTInuhawjzLLBZNZjwkfAvPmHTKrtfAWJGs+1FcO7OV4XtY0
 CMGHnrvb7QPzyyfnvCaA/LDtDsz+3FqEyQZNvrXv+Fa4naxtxUuSR6TBqf9WE53q
 RbowxJjSRomtP9X8VMqU8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753128409; x=
 1753214809; bh=AGbRUP4QtnVq9jsg7hlaqceU4k3t8eOGq7HiFudj+YI=; b=X
 bcDrV9WvS/Qm7WnZTOODiA1Qw1LnBSkJ1XvObsRV9Xq1H4TCWyRz/YZBNjylL19k
 iFyGAElJc0g2BMWMbTTL/MbLwWmz65eWaSrB4xgKom/yTUFQvhlo3GmfV9zFV8Wc
 1TmtqJTZ90KBq4Os+jq2hKF3qjtvVvizwwsYrc2G7s3b8ZbnkqF103I/avc5jjC8
 IjuudKg7ltEE3oczNPIoGJsmpNxRVpiP9UgPH1yJ3vMzQ4DQu/GOJaNaB8jmsUtN
 bb0zb0PMp2H5WlBvEURD068kaLmEXHHdcIjcgsJSypx+nltdwteBy6596gWdbRuz
 +tN/S6vukGBEs7aODv7Zg==
X-ME-Sender: <xms:2J1-aEvTqnee19KOBBHlcAatH-mUUZhR2J_NbmXlAA-Gq98eq6CHHg>
 <xme:2J1-aLELShxi3As6n4Z_XRbc0CGAWwj0ThOlU1kdJVMFbqCdr0-stmQ4XcrGB4NzD
 vVF6c6UDIhXuBBVhw>
X-ME-Received: <xmr:2J1-aPz3BYlYfoDnVgecg6PXm4_JrznKwEjJfMvb9AfK2gcu2cjjGocgHwzsiOuCLQ-XH5hiOJcUE-H2kbI6xKN1fQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvdellecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepfedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtoheptghirghrrgdrlhhofhhtuhhssehinhhtvg
 hlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepsghr
 uhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:2J1-aKgGJQ3m6qLAaRpROjPGe96aYdA_ig617kzd9ZFDufOmD1_bwg>
 <xmx:2J1-aCxJaZjDeI_QOpq3yFwfb1NkDjY8N0pQV6EnSJPPO7HHaNxWcw>
 <xmx:2J1-aFIrg4NsxWTiExWfdWuGmsZ_WbRpNs7FmgrKXCbYxLNAG0iY_A>
 <xmx:2J1-aBSf7u3Wz2B682Ouuac3v6CT6NrrbADB3t6r-Lwxbd4eaXw4HQ>
 <xmx:2Z1-aD9rdPWKrh6lSh8pXqih2IIj57fqg6yXuAwLsVRDmYowEzstM0MR>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 16:06:48 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Ciara Loftus <ciara.loftus@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com
Subject: Re: [PATCH v2] net/intel: deprecate some SSE paths
Date: Mon, 21 Jul 2025 22:06:46 +0200
Message-ID: <1791599.yIU609i1g2@thomas>
In-Reply-To: <20250703143119.1140097-1-ciara.loftus@intel.com>
References: <20250703121624.1050845-1-ciara.loftus@intel.com>
 <20250703143119.1140097-1-ciara.loftus@intel.com>
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

03/07/2025 16:31, Ciara Loftus:
> The SSE rx and tx paths will be removed from the i40e, iavf and ice
> drivers in the 25.11 release. Each of these drivers have faster vector
> paths (AVX2 and AVX-512) which have feature parity with the soon to be
> removed SSE paths. In environments where AVX2 or AVX-512 are not
> supported, the scalar path will still be used, which also has feature
> parity.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Acked-by: Kevin Traynor <ktraynor@redhat.com>

Applied, thanks.


