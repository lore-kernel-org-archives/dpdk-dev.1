Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D89C87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 12:56:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEE3940DCA;
	Mon, 11 Aug 2025 14:56:21 +0200 (CEST)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id C418C40DCA
 for <dev@dpdk.org>; Mon, 11 Aug 2025 14:56:19 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 3FF841400076;
 Mon, 11 Aug 2025 08:56:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Mon, 11 Aug 2025 08:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm3; t=1754916979; x=1755003379; bh=FpoypPJu+a
 T+105yGnFI0e5QWI/7kRp4hOLPI85DTKA=; b=ZuIF7egmv5IGci9AaE9dU7SJYE
 YskVpv8xnsQBhWwnpKCO3B6AYd2TcL3sTo454tB8qLQU+BHDW9dzfmBQYH3BeEzW
 yxHrOWjKRJIujMn2y1ByUr7yDrWId7VXFnH0uottFcFNlalCUpYTTp8ZsfhWu6Kp
 Wluo9VDptCvnskGxwqmHYmfsOfdtUln98knbrc6P0fSRWeBhxX23/Ne88qTFzn3N
 WxbD4bQsQbLooovMbE7+PQZpFmu3EM+WbKvI+ZPeLYLBJ+pvzDTAky83XJ8nFcId
 UhIWtjs0SWrRkbWzUVq8knS3PJOWvN72AAszQs9bUPZYuyedJ+kQ5y3oVAog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1754916979; x=1755003379; bh=FpoypPJu+aT+105yGnFI0e5QWI/7kRp4hOL
 PI85DTKA=; b=EyMQnknuhL/dQIhCmXHiQRTXG8dc/WJzGICPH4DMrA+SVI4+Q+j
 37Uae3oEMg0J+2gzmyik8g2RmRxj8VnkKAScyz9A/XFUgDUq0Gy020qxXIPdQGdc
 Iz2sX5aUvKVBvHUGPQrni41Y591AMq28vsX3eDbkUAgav790M/WNcCOo+H6KDjlH
 4QzyFnczCLf8gZtA+MRdFte00PphdHrb5gaUh5QB+4iPaBgBSbdc3iGziorRp86Z
 Ghi4M858kwOjDIUTzv7c66Ui3CA3bK4wo2VxBqkQpzZRycgyDx7+UuuHKaCMaNVz
 Wb8Sr5P6TkMOGSkco5yRNxyuNX1zi8a9YsA==
X-ME-Sender: <xms:c-iZaFFK4PL618bBg_xE5OMI7AVeDQhLSm9XQKlgT6_0eufkNSXv-Q>
 <xme:c-iZaFk3obV64jbL-DMugQzhkxe5ynLE6Ldedyh20zpp0OewvLi_2SgP7LLTamLe0
 5uLHYIcAI0-gscCmg>
X-ME-Received: <xmr:c-iZaHybCggve2PD4P1SXgihMcC7TEQxPmTTkrtJfftC4K67gScz7n0VArmBuueCq_yMumXq55jCt6iPvx5Gw9Xr0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvheduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkggfgtgesthfuredttddtje
 enucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhj
 rghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeehgedttefhtdetlefgvddvffefge
 ehhfefhfduffehleduudekkeeitdfhfeevgfenucffohhmrghinheplhhinhhugihfohhu
 nhgurghtihhonhdrohhrghdpughpughkrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgv
 thdpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepug
 gvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:c-iZaBQHqE4A1gumkAtwinWC9-MfFpbZ9apujCFFGHi_67TtXsr-4g>
 <xmx:c-iZaKt8zLrRwGejJlfUIvFL0UwvtGKjXdZsUrH4OmfaOdFtPwWwwg>
 <xmx:c-iZaDus2xmsdvOhpoSPs_W_pucQAlOkcAGDNXStQlqwhGRBgGZUmw>
 <xmx:c-iZaAxEVBH8Hh_39haVio__j-OST_k56UwAnyuVkbd_92NA5DMLqg>
 <xmx:c-iZaFkbHq_eXrfnO97H2QV6cewEA7hh5Y8zNuJp49dY3VhBTsD9DnvP>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for <dev@dpdk.org>; 
 Mon, 11 Aug 2025 08:56:18 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Subject: Minutes of DPDK Technical Board Meeting, 2025-07-23
Date: Mon, 11 Aug 2025 14:56:17 +0200
Message-ID: <2515820.jE0xQCEvom@thomas>
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

Members Attending: 5/11
	- Aaron Conole
	- Bruce Richardson
	- Jerin Jacob
	- Stephen Hemminger
	- Thomas Monjalon (Chair)

NOTE: The Technical Board meetings take place every second Wednesday at 3 pm UTC
on https://zoom-lfx.platform.linuxfoundation.org/meeting/96459488340?password=d808f1f6-0a28-4165-929e-5a5bcae7efeb
Meetings are public, and DPDK community members are welcome to attend.
Agenda and minutes can be found at http://core.dpdk.org/techboard/minutes
The next meeting will happen on September 3.


1/ Socket and NUMA node IDs

Sometimes it is defined as a signed type, sometimes as an unsigned type.
The value -1 (SOCKET_ID_ANY) means any socket/node.
We could use a typedef to ensure consistency.
If an unsigned type is defined, we need to explicitly cast -1 value.

Defining a type would be an API breaking change but not too big,
so it could be acceptable in 25.11.


2/ DTS maintainers

Paul Szczepanek (Arm) is replaced by Luca Vizzarro (Arm)


3/ DPDK Summit

Cancellation of September Summit (California) has been announced.
https://mails.dpdk.org/archives/announce/2025-July/000536.html


4/ AI review bots

Grout repository on GitHub is already testing 2 bots (CodeRabbit and Sourcery).

For the DPDK repository, we must open a GitHub pull request for each patch series received on the mailing list.
The the review link would be published in patchwork as a test result.

We must guess the branch to use, by using the same script as for patchwork delegation.
We must check that the free versions of the AI bots accept using multiple branches.
We must decide whether to use the OVS robot account or the main DPDK account.


