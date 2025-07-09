Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C721C83F09
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 14:40:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B4E8406BB;
	Wed,  9 Jul 2025 16:40:26 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id F3F17402A9;
 Wed,  9 Jul 2025 16:40:24 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id 5219A1D00258;
 Wed,  9 Jul 2025 10:40:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Wed, 09 Jul 2025 10:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1752072024;
 x=1752158424; bh=MUT0dwrs40sW+zP3TG3lifGCqtzMmufFjLzVgYcVIuU=; b=
 rYFypGxZZCQ0qFrW1qR5vumNvTOXiY6dUw9ghvnqyGL8JJk/IUHMyLozwK45AO+/
 gb+i7l5FQHfwGBxdOmO7Qu38YQMVFacaEyd/w+ATXjwPuXoZ1qvOlqWFpbk0QRlX
 BbW6bMPOF7p1alV3tgGJ8yHDYPza8tndKbjhRP1rd5rVqT54Td4MMkW+wPvKzKHh
 r90tgE+C0uSoH2GrnQZxjfWMvHKh6LsI1GK4Md71fJR6glXF8s6R+wnQpm3Vxm50
 /gybSCYaEbegdtPYVF7XQxhhzNXCodtMd72Nx33EEUzZ2Z45CncFmr8TYaQ8ozjv
 OKOerGgXfI/ZZln048E41A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752072024; x=
 1752158424; bh=MUT0dwrs40sW+zP3TG3lifGCqtzMmufFjLzVgYcVIuU=; b=e
 h/GkCwmaifeMtiJRUy5XCdeBZTnxD1aOc+BXIdim1UvQaeKOk+pX+31jTXU/Pq5M
 DJczUp4RGW9HQ2CVv9f43qZzNXdzdIN1lDl30kZNT9WpmaIqVxgaRpui96zg6UA8
 kEO/J3Sj6ELAgPtEEsuN2OxRLM5619Lk78fuQhBOAdKEckWk7V2vCRxMC21E4h9U
 HpbXp2gFyp1NOWHSDGHQRixk4WY2pZZ7jJSm9HImNN3NXZvKtydvvy6RD+aB2t8v
 WElEyxjZG3Ph+3Wz90ixsvttiPTsYvAezOUKgwYxpydgUf/svne07bceNHfQGyWg
 kA+wxU4AOlnsPrHdoNyVw==
X-ME-Sender: <xms:V39uaMC5ExAziCgxmmPCf7gKf22wwwCwvf5S98Eb0zKs6u7yitQ1cA>
 <xme:V39uaD6qM9aqK-9-4iM2zyJQ3JRxsJZUrIp5-Wra8VjB6PryXpsig-U6ehIHH8O4m
 ac-t6l1VbDGBu8yLA>
X-ME-Received: <xmr:V39uaPwWSG9rklWpYjCiFaShcpfKrHiEJaIteLDLzxhItRRwxKizbMj8LkkjJ-dPVvNlGN_PWZmfufv3-Vg1IDrQZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeekvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohephedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhkrghshhgrnhhisehnvhhiughirgdrtg
 homhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehrrghslhgr
 nhgusehnvhhiughirgdrtghomhdprhgtphhtthhopehsthgrsghlvgesughpughkrdhorh
 hgpdhrtghpthhtoheprghnrghtohhlhidrsghurhgrkhhovhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:V39uaCzEuoHPwHLJxAsTblJYEjI_AKl-QDL-vxr81bNGwzNXAVLqYA>
 <xmx:V39uaPw49o7b8bXQrFepxvttqj7AsjjnrNgV4xy97vYWqL9Ff_eGOQ>
 <xmx:V39uaEZoblvqiTYEGYnGN4tYBm8pMERtC8scbUXFLcsDNEre3iC4Zw>
 <xmx:V39uaIWjNfgbo5QhrF7RQWHktclgFUd9NgV7NDAPwuFH_JG9cFVpyA>
 <xmx:WH9uaF66MpIx6faQcNGqynu1NX1rfYkq-KQbTG5f5WLOBrWBIu682SYE>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 10:40:22 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Maayan Kashani <mkashani@nvidia.com>
Cc: dev@dpdk.org, rasland@nvidia.com, stable@dpdk.org,
 "Burakov, Anatoly" <anatoly.burakov@intel.com>
Subject: Re: [PATCH] examples/multi_process: fix cleanup on exit
Date: Wed, 09 Jul 2025 16:40:21 +0200
Message-ID: <5502217.yMk1gmxOD6@thomas>
In-Reply-To: <9ad49a76-13c4-4d8c-9de6-6b4a56a1a351@intel.com>
References: <20250708070954.165222-1-mkashani@nvidia.com>
 <9ad49a76-13c4-4d8c-9de6-6b4a56a1a351@intel.com>
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

09/07/2025 15:30, Burakov, Anatoly:
> On 7/8/2025 9:09 AM, Maayan Kashani wrote:
> > Device was started but not stopped on exit signal.
> > Added port stop and close on exit.
> > 
> > Fixes: af75078fece3 ("first public release")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> > ---
> 
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

There's always more cleanup and error handling we can do in examples.
As they are just code examples, I assume it does not have to be production-ready.

Applied, thanks.


