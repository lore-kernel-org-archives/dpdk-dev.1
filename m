Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CA6C35FFB
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 04:35:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C845B40612;
	Wed, 19 Mar 2025 05:35:05 +0100 (CET)
Received: from mails.dpdk.org (localhost [127.0.0.1])
 by mails.dpdk.org (Postfix) with ESMTP id 25A9A402C4;
 Wed, 19 Mar 2025 05:35:04 +0100 (CET)
Received: from fout-b3-smtp.messagingengine.com
 (fout-b3-smtp.messagingengine.com [202.12.124.146])
 by mails.dpdk.org (Postfix) with ESMTP id 473054025A
 for <announce@dpdk.org>; Wed, 19 Mar 2025 05:35:03 +0100 (CET)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal
 [10.202.2.50])
 by mailfout.stl.internal (Postfix) with ESMTP id 793DF1140169;
 Wed, 19 Mar 2025 00:35:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Wed, 19 Mar 2025 00:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm1; t=1742358902; x=1742445302; bh=byQ6kdb7WI
 LVufOzxtFyjDwhB3lZsIvLwwQThb6CWF8=; b=suIaUjX7wQQN6pEaGhEfCRr/CO
 bRKjphzAjouuIV7oJqkibNUDcvHXc+X6GcBZImwNYFXt3zQ0iVVkqaeiCrWikLew
 j4jc0Zc4hgn0/TnrY3l548zbDUluU5oUo9PBxC/gJ2pjoBpDI3PjbbGUwmhjU+/i
 h+rsKhip8PXv7Cqg7HyqFEiTASqcS0GWDLiO9wfuisEt/1CzGXZmy6wnLoPelf3P
 ffJQN7FfcnGvwn2P0cER5q+X1QVcs5Ngd/QoTdfQC22VetiQnbXOTv9I52o1cHGy
 qV8N4MqdYM8uNnzEFbTuzC7bDSKCg904x4tRyowjHHVVExl0p67D1hUpYq3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1742358902; x=1742445302; bh=byQ6kdb7WILVufOzxtFyjDwhB3lZsIvLwwQ
 Thb6CWF8=; b=Zs0GF9YphZI3DdyprClK7Y60cPtXENHNlA0qEl+Gjg/DxmyMNZp
 PX9TmmHvLV0vcQlsrUNRO2sBp+mZXSUzlpwUJlMIRmW9AsYdQVBaEJi4/wJ3SHRE
 ehn7QFsatJ6pzMkrVukONwN7PohdlT00fhzT1AgdbVsuVUyr1bi4iL3o7pTXB44k
 onZbjeKSQ9RIA4i93uk0JzWXKZOz5ce+7k7qRQjabvgywtUS2SHqAsbIWCCiSzL4
 L/FKwdl5uKHQqcID0tiwgL/RAq+tDmLoq8ywQlEF5sj4qGkOpbhe7XMKmwxiKHzV
 JrU8iPo7NUPoyiciYn08LfEAfijd1W80I9A==
X-ME-Sender: <xms:dknaZ1p-60yX419MIvK0XAl_lSpHWEOzB2co1-mUkZl-RdSrCsHAhw>
 <xme:dknaZ3rEtyLde4oeytdsQeFFGBDeBL9FDK7Z1Q4NhxEKmKZG-7qKGGBSJ1YfI3YYW
 fUwS7O1u5EyON9vFw>
X-ME-Received: <xmr:dknaZyOcnMa3xEYFZzFGLErGFZyiRDEI1u62i8KwzOc6DHHN6oQiQmdXIAbvTLnNx0hjFJFYfrSnAi2bkXg9udEjSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeegfeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
 fufffkggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhho
 nhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpe
 eugeeuhfetuddvtdejveejhefggeejgeeiieelveevgeeiffdvheehjeevveekfeenucff
 ohhmrghinhepughpughkrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
 hmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghr
 tghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnnhhouhhntg
 gvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:dknaZw5ZHdReBMnBBtcW-LiUGoqsa0d3n_pvlmDcu4PMupXQoIyi8A>
 <xmx:dknaZ05DrSfCBfy6boRiedL9SiqolP2UQAcqEtxFOTx0KZ35JSoFjQ>
 <xmx:dknaZ4hYDMA0I9Y27BS1NUrgq3LZRLGW-8vSgiHRMtZs8DcjU8X27w>
 <xmx:dknaZ25zydzZ6MzEEx3arqMMVrlcoxxPy0MbYjV-XUTXQ6OebMIQcg>
 <xmx:dknaZyQ4dT4rApcDLV05bJd0tdo6JbfewkER9OcpRzJVAGfX9m3eANWR>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <announce@dpdk.org>; Wed, 19 Mar 2025 00:35:01 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: announce@dpdk.org
Subject: release candidate 25.03-rc3
Date: Wed, 19 Mar 2025 05:35:00 +0100
Message-ID: <4293915.o2A3GueYyp@thomas>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: announce@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
X-BeenThere: dev@dpdk.org
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

A new DPDK release candidate is ready for testing:
	https://git.dpdk.org/dpdk/tag/?id=v25.03-rc3

There are 71 new patches in this snapshot.

Release notes:
	https://doc.dpdk.org/guides/rel_notes/release_25_03.html

Please test and report new issues on https://bugs.dpdk.org

If no major blocker is discovered,
this release cycle may be closed at the end of the week.

Thank you everyone


