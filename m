Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C452C83F1A
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Jul 2025 22:17:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87CFF40281;
	Mon, 21 Jul 2025 00:17:20 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id C54C14026D;
 Mon, 21 Jul 2025 00:17:18 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id 6B7FAEC0013;
 Sun, 20 Jul 2025 18:17:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Sun, 20 Jul 2025 18:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753049838;
 x=1753136238; bh=T1o5mcJO+8CMum5Q0BBGPs3y3u7l7GG0smLlTr2TTG4=; b=
 GigIemdOXXZ2jAAk7L9HOslWhrMNPoWmHvEl4y5Rdu/1kq4sLqR48+giglr7A8pn
 KwCNnql9ABs277GWe3+Fo+a/uuYmn2gt0DlYJ/9uqmrd4J1qXE5GLFJpZGf7/NkX
 NnqQ+hGCahPsYxVRwZUaqrE8Wngx8BBpnq97N8LC/VNyLDYxrVvjmvQFKPQaOlG/
 mCXje5IP84ivQNHpXJMtLcsEcvoCBsVYbZjV0A8x49qV+KQR3j5jxXWCFPCJRdip
 wo3X1Ie0kWVaL63VWiv3ajRijJSEzO2S38KYqzfhfYuOd1gQ5UAfdcndDxKj8rEn
 PfiIPSiZjuJfPi+wKma/Hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753049838; x=
 1753136238; bh=T1o5mcJO+8CMum5Q0BBGPs3y3u7l7GG0smLlTr2TTG4=; b=C
 GZxkBQ65rHfrAN8z1wkYiCT84S86WazCBFglbHkRkEkc5oPCvW9csdgYF54gjQMZ
 DXKAtNkrxJQvoA1c6KdlO7UCKMohnaBDE8Yac/bVt0dWqEUw/s+bYs15v/aCx10y
 7S1wyC2iQTnp2oPl1EO+i4Zqyf7Ox5uHnWtuFfCAQKfUkAfSXH2xC/tq7fn/oQ1u
 GVx2nEN2ZhMDZWORKECFrJjSpamGWFsCB9jQoUs7oy2KuR5+nB836/vqEPH7iQSN
 /qRLjGb/qZoQqG9Xyy752Xe/caU/1SbQmmJ3+6POVUVLiRdsvBZYTVGqkiGR/1Bv
 e+UAFx2XPu+gl2F6IfG2Q==
X-ME-Sender: <xms:7mp9aN0Gvu6qKsWpZi9xXyF862uRzBXW7ko1yy0BLfehzKvXHwNkcw>
 <xme:7mp9aMjUkqNf4sFZhDjhK6FmKtmGlEcVtqLonwEpo3fF5vf4rq0IkY3RVbh0FPzSr
 EgHiTjCIw9CN7ONuw>
X-ME-Received: <xmr:7mp9aOW4_QzMz-2Z-noYBxsZhWpF_9doqTR9fIyBevXoPOULGAheq3yrZSwONkyPr2gL_U3qqj0uZ6sgniRt8drJag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejtdefkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepiedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugdrmhgrrhgthhgrnhgusehrvg
 guhhgrthdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthho
 pehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtoheprhhorhgvthiilhgrsehlih
 hnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohephhgrrhhrhidrvhgrnhdr
 hhgrrghrvghnsehinhhtvghlrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrg
 hrughsohhnsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:7mp9aLVGt-ulV1WDQcWVc3w5tSyBX8QqxR_wIYKN69GncPV-r_43LA>
 <xmx:7mp9aOjXm7qvVUOguPjbuBoNqPZeBD39ScO0dJ39xfhKhqmwdQT_8g>
 <xmx:7mp9aGbUPcBsIHsi234HG-a4XLK0uBDoR7dq0B9oaOxsZ7PR1592mg>
 <xmx:7mp9aLoX_afirasLDYEfdPoIFH-JKue67f4m-HKRaOWMiIzA21sR9g>
 <xmx:7mp9aCD5B8wke2AoE1AywG6S3VNx0pG7jZ5dQngJLSanaTW8bDFeUTVt>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Jul 2025 18:17:17 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Harry van Haaren <harry.van.haaren@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH] eal: add description of service corelist in usage
Date: Mon, 21 Jul 2025 00:17:15 +0200
Message-ID: <2870796.BEx9A2HvPv@thomas>
In-Reply-To: <aHjHpmnnifLtCXta@bricha3-mobl1.ger.corp.intel.com>
References: <20250717094232.2184783-1-david.marchand@redhat.com>
 <aHjHpmnnifLtCXta@bricha3-mobl1.ger.corp.intel.com>
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

17/07/2025 11:51, Bruce Richardson:
> On Thu, Jul 17, 2025 at 11:42:32AM +0200, David Marchand wrote:
> > The -S option is not described in EAL usage().
> > 
> > Fixes: 7dbd7a6413ef ("service: add -S corelist option")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.


