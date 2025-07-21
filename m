Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F445C83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 13:08:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C88294021E;
	Mon, 21 Jul 2025 15:08:02 +0200 (CEST)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTP id C8FB44014F
 for <dev@dpdk.org>; Mon, 21 Jul 2025 15:08:00 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 568B8EC022D;
 Mon, 21 Jul 2025 09:08:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 21 Jul 2025 09:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753103280;
 x=1753189680; bh=wsV+P4spLWAS1RXJll9UBCVs2zprXFlNimlYULNq0So=; b=
 wGlpFPp6IJuELVmolwqkjzHRPFQnM8KHJ7hgijZ8J2EO6JDq77onAGXUdq03Octu
 v2zs49+H6rlNKrbRokwnNyQEaGCgfM20adjK+Y00wedVC2HOXzcvtB2xnahpAMR5
 rOWqL2h2pAJAhqt+d5N0pfTzKdQ6RF75BhSBb5sJdW+QAVweIeui2icSE1H7ukyY
 YrIKIi2QFhtPhp4kol8OsmQN1H0tqTT521hHvnsTZWWHCtLtLJ9JPHU/rRv72tVs
 nEHIsTFOdf6QAxf6eWldUHrpJjPQo6QYTyqALwuyl8dF866LWGFjwgEXt1gi5ONL
 h6UAND6eVeKb3C/k/Y/BvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753103280; x=
 1753189680; bh=wsV+P4spLWAS1RXJll9UBCVs2zprXFlNimlYULNq0So=; b=E
 brI97xirKW1YZ4GanqUT5DbLzvKgiHYclVBqiPRF4uzuK3LrZE+PKxcliiDooxrY
 KD0mqlyPuz49uE8AvLQ+Sqh+x0SquRGWjfESiCXuKMl+bKLzfNAY0cJ0tIHSvt+N
 DqZWqTm+HjZHia+WnTWsgmrvknjYZYaOO1kN6jXBzXf6OTuKmqVzZ9tLF22zuHxR
 c00sCUnHvCFsOxhgsDhUcN2pGSZk55rpBQpmChwTQnWWgHS5stw95+DCSYTxjRcd
 fk2iyX4ALDOMqC/Sq7OjFFpYiHLSbQAprE0MZEPyHxSmf8Xkxp6Qkv3goSWH/P4A
 tcNa8ARqyRLPXhvjFwq8w==
X-ME-Sender: <xms:sDt-aCCHMVdITF-8xZrE94RlQfr2jSw1ypfSlEgAaabhICSAa3Y3Ww>
 <xme:sDt-aBxS_P9l90BFWkVeL6dMsbMXB3FDCPfUFxbvpp3iE2UzJpCcDd7TYR3bQtcDj
 EDDTHRYdko7i-MPqg>
X-ME-Received: <xmr:sDt-aHS9l4I1o3a4ZUht8Z1KXihYFcY197LaoLAhU8HhoXtNmzibYrQ9NGjL1JM7z5VMbu9IPTwHcq8tIgEq1w5uSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvdduiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepvddpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugdrmhgrrhgthhgrnhgusehrvg
 guhhgrthdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:sDt-aI_YCmKfCZxMj0bDgNZ6Jj8CSkwQwMlUPhXJMagI3zaZv-IvMQ>
 <xmx:sDt-aOr33ErRidT-AWFSgsOykyUCxEKpNgXHbUEQFI256DAueSLtwg>
 <xmx:sDt-aFlIUMiCpaCDPIL2ZMiWDGaL9buFb2niAcjJ8EVNPFV8fxBovw>
 <xmx:sDt-aFKv0uj_HHKFRXxVNPFhj3zgnNz7nNjKcv-a_-Jq3ZK1P8eUmQ>
 <xmx:sDt-aOvdTw4t_iZdnwEHbkwUBosgTvIkfMKI0z7tFgzqozZFAhwf9jiK>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 09:07:59 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] mailmap: fix entries with many aliases
Date: Mon, 21 Jul 2025 15:07:58 +0200
Message-ID: <4644175.8F6SAcFxjW@thomas>
In-Reply-To: <20250716144203.1994070-1-david.marchand@redhat.com>
References: <20250716144203.1994070-1-david.marchand@redhat.com>
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

16/07/2025 16:41, David Marchand:
> According to gitmailmap manual, a line is composed of a contact
> information followed by commit information.
> 
> Which translates to the following formats:
> Proper Name <commit@email.xx>
> <proper@email.xx> <commit@email.xx>
> Proper Name <proper@email.xx> <commit@email.xx>
> Proper Name <proper@email.xx> Commit Name <commit@email.xx>
> 
> Some lines had multiple commit infos which were not parsed correctly by
> tools. Fix this by duplicating lines as necessary.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Applied, thanks.



