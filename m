Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2390DCF256A
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 02:59:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCC4640265;
	Wed, 19 Nov 2025 03:59:04 +0100 (CET)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id 4ADC94021E
 for <dev@dpdk.org>; Wed, 19 Nov 2025 03:59:03 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 686307A0133;
 Tue, 18 Nov 2025 21:59:02 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Tue, 18 Nov 2025 21:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1763521142;
 x=1763607542; bh=cJjbZJeYCMVYZ8+fxljFG2Eu+xmxZTSIo/4IsLNFhKI=; b=
 uWSbkBb9RolyW8eATHvxz6VQ4wU529usZJjpGJryyb8OQBhOIimdvj+BTagjG9LL
 nDIwEmE44P9yoe/MmZXngg2ecYwrCGGtAN6pwNfApEB0iJiQpMViQcX9TOh0yXdQ
 y+Tyfg6+ezJ1EqwxtrG3sIKLpuhQj256Ibrs11ZuhEtxWXsPqBSm5XZVOXyFNqO/
 MaqcC2bObZxcpXmD3RKxtOUTxv32dXbXHTnE7/pYdjI75KCSAio1oaN5ZUsBbnyO
 mg0NHWtSp7tA7gN7w1zuV4pr/KgKv7I0Crfdl2NE4vI3mRCGx1CXI1sTD45lw4aT
 WrgBcn+bemBtkt7MWZGxag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763521142; x=
 1763607542; bh=cJjbZJeYCMVYZ8+fxljFG2Eu+xmxZTSIo/4IsLNFhKI=; b=E
 p2zWW1OGU9SJsNXmrd4aZzrdxbIIuXcDEdJ7pycJTwwNno/ZVisHu4qbetaq5HW2
 yo6JXKqcHOok4zd8/A4j1b3UpU0I2fFeD7SgaxCrCtAIQeZRFVTboO9SDcvYJ97J
 JUozgh3c9/d9Mjvt37gSEo+6j2GDzb7RJErBBKN2l5QG6Yn4TEmFzhyy3L1iO8T4
 3efPhQFENtfXpUG8VFuuxGQ9mMSvGmtwIg6Og3BdOkwpGOJqbxsw8yEW0ukIZUWN
 GzJtZp2uXnRRvPsmLPNCAkISiUNXrQzzmcGPE2lAisCG7p09S6GhDJMulY2g1lPy
 r+Q4e+aRbXJXzTc5bMsGQ==
X-ME-Sender: <xms:dTIdaSx1P2LR7RTTZWRDfce3hlkmIV5AHIOWgVqyqRtIu7TWTzQdaA>
 <xme:dTIdaVQsCWgZocEK_z_LHLpgZ15Y5n_WzYkeaJYaQoZXXKIESC1E3fd_Sfbe_2QTn
 NttsTegZO-3mzPOh2ELYrHkUOX5O_cI2KY04B6AtRDOlR5sBj1a0DQ>
X-ME-Received: <xmr:dTIdaZVlFa33JnF5v5PKPqogTxVAk29g9vxISkq-wI27a_LqDb4UCm23c-ZWvgagc32E4pXkp_fGTJMgeGiv0ZZXPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdeftdeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertd
 dttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevff
 fgtdegkeeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnh
 gvthdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
 uggvvhesughpughkrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrvghhrhhhrg
 hrughtsegtrghnohhnihgtrghlrdgtohhmpdhrtghpthhtohepmhgrihgtohhlghgrsghr
 ihgvlheshhhothhmrghilhdrtghomhdprhgtphhtthhopehrohhrvghtiihlrgeslhhinh
 hugidrmhhitghrohhsohhfthdrtghomh
X-ME-Proxy: <xmx:dTIdaXYs3J-H-LU3cqyFpz48UQCsYK4sS6mW8E4WFI7ESooN5GK_NA>
 <xmx:dTIdaf0nut4WyGak70jlFRYwdeW-z8qXfA_dMg7P_9IXSwQmMMWIvA>
 <xmx:dTIdaZiiAqdgpwvg0b6jiNbRfOKKxlaLpHeuHIl1HUqSgttuE1EPQg>
 <xmx:dTIdaTbePrYiZKOyStQUCrYFMqdqnjyi7zkOkibDiIfDZgDbtWQsSg>
 <xmx:djIdaQREYFRxtI534QciaPf2tOtQ7tMERhf6-BzJgUQTloV9Ss2dEGtp>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 21:59:01 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: christian.ehrhardt@canonical.com, maicolgabriel@hotmail.com,
 roretzla@linux.microsoft.com
Subject: Re: [PATCH] maintainers: remove some inactives
Date: Wed, 19 Nov 2025 03:58:58 +0100
Message-ID: <10455262.CDJkKcVGEf@thomas>
In-Reply-To: <20251102161410.4004823-1-thomas@monjalon.net>
References: <20251102161410.4004823-1-thomas@monjalon.net>
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

02/11/2025 17:14, Thomas Monjalon:
> Some maintainers known to be inactive for at least a year
> are removed to make clearer where help is needed.
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Applied



