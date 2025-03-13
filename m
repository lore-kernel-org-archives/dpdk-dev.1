Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98999C282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 14:37:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C5DF40FDE;
	Thu, 13 Mar 2025 15:37:26 +0100 (CET)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id 5E32E40150
 for <dev@dpdk.org>; Thu, 13 Mar 2025 15:37:25 +0100 (CET)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal
 [10.202.2.47])
 by mailfout.phl.internal (Postfix) with ESMTP id C67091382D05;
 Thu, 13 Mar 2025 10:37:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Thu, 13 Mar 2025 10:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1741876644;
 x=1741963044; bh=huUyqE2CXdtRAomjn67nOZM+0cPdyz4fx3QoeiiJi3A=; b=
 TMGE2YkGS4oe3QZC0qtFJ5pPr5blNgzNYUocWws0JcBPoaKt5UFye9wYKMmncH2k
 aqv7At5wQ88aP4etLyVBmTLi39DuLV4hiP31oqsUwKsIDGiN0UP3TD6UbtDAOaZk
 DrHB3FalL8AO7Cqr/gf6GmdGisuna8pG5ZGgKqF7CjDc4CPxzgzj2Skd6xt5C5PA
 SYUJkHh349j2Ul/CuDgXPm6CmlxCOzvKKYIUSPz9Zy/frylJQ/bnWsUgRki8ZJXV
 v4+dfxCMzSJ09hbUkX9XcllL3OgXMF6t+mIOiWYjcQI6OcGsevb8IvXD5cngo5M8
 HB+8BHyIg+pQfpsz38mXWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741876644; x=
 1741963044; bh=huUyqE2CXdtRAomjn67nOZM+0cPdyz4fx3QoeiiJi3A=; b=I
 7Nc+YC8xAV4+LsZyvu3MxJ2rfhjf+gKhVpTCXe6Dw0GMMmgVXX3HewUrwTLQlZhN
 3ltth30BGBUagSWA170jT7XASUkemJdGWTqWSMc/QshSMtR9xm+4nCoIZO7d0ATo
 Uq9yXmyOzLJzuNK0VCAdayAQ5+NHeshG4FNIHCbzDAC/5FYswUTD0S7BmdqERI8w
 OaNOAsx8LzqH6R77y4FIUAp2nDZrgzsXbbohVarc6kpFG9iV9QAv+TiAWnFaIrOv
 c8dQL14S47buT7Bi6RVmQwHsJOK5Mvsltf1USTN5jx+MEWLGWLJJSO6c493/rI1J
 4nUVxh6gBO55jToWmDKgQ==
X-ME-Sender: <xms:pO3SZ0tK7KxI6uUYrO1byTWXGOMyGfMCur9GCyns6rXwEkxlwAhBHw>
 <xme:pO3SZxcgdbqVoONAl45pRuwDLGE-20uuBR6pH7Dye6M1xi1hpEenC2wxSySIBesAU
 awqMJBzhPS4bbgFLw>
X-ME-Received: <xmr:pO3SZ_yrRx39NeID1jbjfoX_Ytq4gvcE0H8vfVpPf1nni6m7ud2dTxAxAMJxw37XNz0q31tP3r9dOz7UfYbRRq9Y5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekvdduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehloh
 hnghhliheslhhinhhugihonhhhhihpvghrvhdrtghomhdprhgtphhtthhopehlohhnghhl
 ihesmhhitghrohhsohhfthdrtghomhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfi
 horhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopeifvghhsehmihgtrhhoshhofhht
 rdgtohhmpdhrtghpthhtohepuggrvhhiugdrmhgrrhgthhgrnhgusehrvgguhhgrthdrtg
 homhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:pO3SZ3MOPDXlKB8K7uuOZDifQPDse8Ktt48HsCdXb2YAQpxu-XSRwQ>
 <xmx:pO3SZ0891edaDV2eGFHGN9JIJXjN6pOHjd8tm7vsbzJfzy994EafHw>
 <xmx:pO3SZ_WwmtJH560hl-7C2ET3lrMqoVNsP7PGSc_Ei53wr7s3fp9rDw>
 <xmx:pO3SZ9cHU7HM_8DAiLEylyh1mK9KLtuEruNt1pPTHswjnB_CeStA0Q>
 <xmx:pO3SZ0zY_DVTz8bcxwNEVSy4RLKCMoKRJrqBwP6zrKTVhZwlZORe4z4M>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 10:37:23 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: longli@linuxonhyperv.com, Long Li <longli@microsoft.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Wei Hu <weh@microsoft.com>, David Marchand <david.marchand@redhat.com>,
 dev@dpdk.org
Subject: Re: [PATCH] doc: announce bus/vmbus API changes
Date: Thu, 13 Mar 2025 15:37:22 +0100
Message-ID: <3519006.Zkmt1EvEu4@thomas>
In-Reply-To: <1741815831-22977-1-git-send-email-longli@linuxonhyperv.com>
References: <1741815831-22977-1-git-send-email-longli@linuxonhyperv.com>
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

12/03/2025 22:43, longli@linuxonhyperv.com:
> From: Long Li <longli@microsoft.com>
> 
> All vmbus APIs are used internally by DPDK core and net/netvsc PMD.
> It's not feasible or practical to use those APIs by the application.
> Those APIs will be moved from "DPDK" to "Internal" in DPDK 25.11.
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
> +* bus/vmbus: Starting DPDK 25.11, all the vmbus APIs will be moved
> +  from "DPDK" to "Internal". Those APIs are used only by DPDK core
> +  and net/netvsc PMD.

You should mention that you mean the functions in rte_bus_vmbus.h


