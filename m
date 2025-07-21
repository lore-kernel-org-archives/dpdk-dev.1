Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33F0C83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 09:52:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C1FA4021E;
	Mon, 21 Jul 2025 11:52:09 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 494E84014F
 for <dev@dpdk.org>; Mon, 21 Jul 2025 11:52:05 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id E67E5EC0079;
 Mon, 21 Jul 2025 05:52:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Mon, 21 Jul 2025 05:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753091524;
 x=1753177924; bh=/L3odtgBKdupCxjoj8Xl4vLdy2MJC5reTGw1DC1XwaM=; b=
 eMJ1+IukvuRhUXL2fLoIAM8FHT/HUtmDowWbQHs4weveO/Z4nFW1ZIQXgOK2RjjK
 0CrDfq8+qW6wOabs8VIe9C8klfK4D0ZlzJOMOUbS810al3n9+bPvQzjzpxFitJld
 9sKY3twqJd2pDPMYY6NZmROOLdZuNrQ4fkdfW+SaFhatWhoVQaoL0abP/l7Fncvw
 t0pk5h/f24cNcTAkK40TMqK77KxPQ7ErolU72KFAR4sCLXVRVceZMYOqqePsJpTO
 VLpNulC3mkkv2M9i0k2edkFSzxAQVwQiTtvuuluybrTagACgiU6L/nrpKLsJLBaI
 vh0ym3ahHeZXemUToBbkHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753091524; x=
 1753177924; bh=/L3odtgBKdupCxjoj8Xl4vLdy2MJC5reTGw1DC1XwaM=; b=J
 q/SVulRKf4szY1rgHQ6oawPHIUjbpau++8lcju06t/FrKpS5c6xQORfuCUkzDZLP
 p0KnhZlgR7NgWXe6QxjFCTUW5FhVgxMALk0MsomUhxfgt+DFZKv915otaTTekPE8
 W2Nhw3Qf0L/iSmpThUUPBDxz6AjnfxJkzpSzTd0So5cz93qSh2TBj9K/IMKj9JCi
 b8wLa6I+NCfLO1fUPBk1v3/TYtT0TDAxTOqqJCwASO4JhejsoXgSMdF7QZyyi7da
 DUYF/wKUdpAp0hkEHzVOSixnUQxGKiZQgOVqQulNtY0wFklQFKl18ByhwLpuwAoM
 qVyPNzojrd8CK7YX1ALwA==
X-ME-Sender: <xms:xA1-aKvV3ZU9__L5-1yTMI4qE6rgeaHlFZFjvJrcrB3B0vURYur2Sw>
 <xme:xA1-aEulDnBs94T2sqPlK9-xQWfZeYGJysYOB1oYRY6a022B8cQzqzSnBLLcE79vj
 xz9bK4xqXJWhhQQFw>
X-ME-Received: <xmr:xA1-aHdidSKNI_hMmxsWm7_bXXDa6Iw6iNooODwevU2Jc4-eb1u8ulsVbN_NMdpl1cljBfbmFNhpYceL3o_6R2rx2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejudejjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepvddpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrshhlrghnugesnhhvihguihgrrdgtoh
 hmpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:xA1-aNbMbk7nJmdj5Ow8uG54O-dP4lJbsJciDRO44zaAHs0SLwuHYQ>
 <xmx:xA1-aCXEV4JAiPUmV1yosNuilCgptYdgzAoGT47f27IwbVJU-t4wgg>
 <xmx:xA1-aHg_eivEgzROvRPO0g9SwwcsHREmf5caw9dG6IJehK2t0Tya6A>
 <xmx:xA1-aIXBSojZX2h82zlleJ778xmoCkY-lkYoJ0WUOCgqUtdm0s8wKQ>
 <xmx:xA1-aMuVxq7uWwZmyAF5ahsXtA7f4qnwz-n11IdKteeblxn9q3BBPpCL>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 05:52:04 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Raslan Darawsheh <rasland@nvidia.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] doc: add tested platforms with NVIDIA NICs
Date: Mon, 21 Jul 2025 11:52:03 +0200
Message-ID: <14259112.RDIVbhacDa@thomas>
In-Reply-To: <20250714063848.56503-1-rasland@nvidia.com>
References: <20250714063848.56503-1-rasland@nvidia.com>
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

14/07/2025 08:38, Raslan Darawsheh:
> Add tested platforms with NVIDIA NICs to the 25.07 release notes.
> 
> Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>

Applied, thanks.



