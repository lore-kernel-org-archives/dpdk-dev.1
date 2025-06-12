Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF003C71135
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 01:01:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 195AA4021F;
	Thu, 12 Jun 2025 03:01:09 +0200 (CEST)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id DC57840156
 for <dev@dpdk.org>; Thu, 12 Jun 2025 03:01:06 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 38EDB11401F0;
 Wed, 11 Jun 2025 21:01:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 11 Jun 2025 21:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749690066;
 x=1749776466; bh=vTnpfOkfSJTpKromCBQpG5TSeMx3Ed7gDhAFMlgkvw0=; b=
 ExM8kYRHJXQVddEkmXhgo+bKjlDf4QJ5MysQe4RUSZWKAeW8INYzGfPxA1oAwya8
 g7lyUl+ZZ5SMKaemyjARF5aCzJS5+RFE2KJ1kF6TDNgstXOC7T7/8uY4hyHkyp7k
 /T9vBoIJ73aT1eriXj25qBvUdXN+25xxES0wPc51pAz9SJ8ZaNyBPHyhL0Uuw2NN
 T6n+FTbyn6usTTfzVm0m6ce7oCMyHfqv6L1u8Kb/+1E9JSB+VzlpZi2FDDG/hZRr
 tFXcKCms4JZFYDtscUgHYsU15RAYIg12OH9476bBAtQaDZJ15q3Fl6u0q2Tco1my
 +flnIjj8vGofpsb3AQEdSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749690066; x=
 1749776466; bh=vTnpfOkfSJTpKromCBQpG5TSeMx3Ed7gDhAFMlgkvw0=; b=j
 8azt6F2SY+DkCiRlmgDfCvdKCIS3oLwCnE2JRiSiX18dvgQS4m2mQj56oOVx3sNa
 hfYooRZq8i8zY3m7//CL7pRDNCp40y2Z2Eo0Mm84SrPV2aCwwqVC+Rk8qvyfcfGS
 +gSG2NMxNgL2UpggSJgT0+nQB6z98MrilvE2rhn4d/HmwkzghnAT1Co++u6ngsrX
 roNcYhXLhxZA3imX+JbAqNPTXSdC78z7dG7HJRzI9wrZDmi0wQt9mQjtUz4hu4q8
 jk/3MuVWqYQI9Tz2FTiVakVzDEcMYJI45X9NS0kLNGXU/C3HsRYndKpuF9OTsPbF
 xbwtvoRQgt3hT442YCylg==
X-ME-Sender: <xms:0SZKaD96I8vHZmWwFTn8bLlPXhuan8k8X-NuXR-vqAFNWDwX4qkJgQ>
 <xme:0SZKaPvC-fnsVLbD0h4jRMkeikJ9leHdfRKBVuEecdkgjhf11Ih7IwM2SqKyCLltQ
 ZaMoBmFV__BV0TY7Q>
X-ME-Received: <xmr:0SZKaBDfSTUqS-2gZ_icai2ApqaZH9BxTnL8N0F9M54zQ-aYGrUKtOhXwbEmWlIt4C7wHuP0RlVJOGRX6RzHDekTMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddufeeilecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnug
 hrvghmuhgvsehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepughm
 ihhtrhihrdhkohiilhhiuhhksehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhorhgvth
 iilhgrsehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhg
X-ME-Proxy: <xmx:0SZKaPfFf9ZQN0bV5l2rHD_BnqLL2ZkIFvCd8EjhSzRRxc6vEnTL6w>
 <xmx:0SZKaIP4Og7CKBxp9u5Fc9N-pUP1VAlZ9lQ8V4W9N4OxxFJiifq6tg>
 <xmx:0SZKaBkeDD796LI-EAD5hDckzrfQ-KKHRbjb8zcMSTR8tBg7QZl1IQ>
 <xmx:0SZKaCvY3C3YWdaDcPTBMLczWYB2KBUZg9pA2RbDSuvhS_4aEaczqQ>
 <xmx:0iZKaOGB4DMdYiEnvkMDiSQi8RAdfQy1J5oY8V1yzsNArZxkvzOnno1X>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 21:01:05 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>, dev@dpdk.org
Subject: Re: [PATCH] eal: add getline() function for Windows
Date: Thu, 12 Jun 2025 03:01:03 +0200
Message-ID: <4381337.bcXerOTE6V@thomas>
In-Reply-To: <1746477607-14961-1-git-send-email-andremue@linux.microsoft.com>
References: <1746477607-14961-1-git-send-email-andremue@linux.microsoft.com>
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

05/05/2025 22:40, Andre Muezerie:
> Existing DPDK code uses getline(), which is a POSIX function and is
> not available in the Windows APIs.
> 
> Instead of rewriting it or coming up with some other replacement, this
> patch makes use of the implementation provided by NetBSD to make it
> possible to compile code dependent on getline on Windows.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

It has been approved by the techboard on May 28,
and the govboard on May 30,
so the patch is applied, thanks.



