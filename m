Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFCFC83F34
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 19:50:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A6D5402EE;
	Thu, 17 Jul 2025 21:50:46 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id DABD640283;
 Thu, 17 Jul 2025 21:50:43 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 4E8161D000E2;
 Thu, 17 Jul 2025 15:50:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Thu, 17 Jul 2025 15:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1752781843;
 x=1752868243; bh=CjbXpgGCG+YqJhM/d8c8HBpUiDrfG1kCvRa8Vp/kuvw=; b=
 z+PVFvXeGTq9+FPSQKnIWku1H/dTr8V+qzpQYLQJXUw1tcekiHjOiRHeBC/f4cLf
 WBR17GIxrhGnnbADPSVOh685clU8H6+gwhZ7iXkxwo4Q5+wfOr2WrVhF665a4RZq
 Ik4XxQtax7ZNZNKdjAZdSmmjiL8v/GGSkmJ5zY63AmqVujzvRZd+kYTTfc+sBsC0
 fihXnnlCEpsd/MMXGzhlcIPnFA3Ro5a/SbDDuFU5QPh1yJ0f8gpB9Yh0f45Jmy1k
 co5IjM2VMZPjlIqCbHvfkxCcUtLXjh7taqYhZahHFQTu1AoBYvcVE9FMPpXTHoUm
 elatfuFAN6YBJ1MRaOWaCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752781843; x=
 1752868243; bh=CjbXpgGCG+YqJhM/d8c8HBpUiDrfG1kCvRa8Vp/kuvw=; b=j
 bYGaEhb+IRAy1OL4YqOX7iggh9jXe9GyiBFd5IW/Ddsk2R+iqwNC8n15WeiORAnd
 o6GjMyBbU8vZN0KeFTcfrSgLfPXC8GywxANZZEdp44+JrcuVs2F6mJwNn7FARKN+
 evF0ENk2r02BY5hqdWJrW9Yx6CyGCmm9u0YGTOmZQoWcaHkfkFb3/9LBI/eGi0+d
 BA/xZKPl/myiERiHmiLCal+2b6Ja4MdBv6d1l5pQSs6JjfsE5SbSltin3K703+n2
 FN1ZxknQpzPpMUe2HpCqeOHIOA4+QaRoAshX73tFAEBQ/A29qAwwWF1XBSH9Aeu4
 Ybz4n4uCdQN821vz5W8wA==
X-ME-Sender: <xms:ElR5aAHp0jH9kH8RRleI-uecib7fXEliXpxKL5kM3YjEz2HnMFqGpA>
 <xme:ElR5aOsu--bWDlN_saAN2i9u-xku3lRbFoax3ojW4bVnzPBkEqTeEo8ovQNDOqQm9
 191u47tWBnPDR9DxA>
X-ME-Received: <xmr:ElR5aKUC6yqHL2ndItM2mbYpyKzsDkhQNC_YNNAYopsR865Nw9P9fmqpE8oyjuxWBIUvFw28wfuAg4s18LwY3dN1BA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeiudegjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohephedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhkrghshhgrnhhisehnvhhiughirgdrtg
 homhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehsthgrsghl
 vgesughpughkrdhorhhgpdhrtghpthhtohepshhonhhggidrjhhirghlvgesihhnthgvlh
 drtghomhdprhgtphhtthhopegrnhgrthholhihrdgsuhhrrghkohhvsehinhhtvghlrdgt
 ohhm
X-ME-Proxy: <xmx:ElR5aCHxnpProQ8fnM8iwjPFEVxO1XL0l1YCrbA1LXCYdFUarjs2Jw>
 <xmx:E1R5aE17XRWg0iU-Q96WwtAgJ-etKq77QKGkJECchamZx_Zrlbo1zA>
 <xmx:E1R5aMNqprt86vI0O0USmYoEkdaHauIlCYCRlDnfaiHKa0CBJxuK3g>
 <xmx:E1R5aL4Ah_N60lyYlvtbuS3mprua3x24E9aCmf0X3ov4mb9YDQ7oTA>
 <xmx:E1R5aCOoCnhHL-CXvBkXs4PZFYiZq52BJqrGIm-JuoziibhgapAx0Xv1>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 15:50:42 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Maayan Kashani <mkashani@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org, Song Jiale <songx.jiale@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH] examples/multi_process: revert ports cleanup on exit
Date: Thu, 17 Jul 2025 21:50:40 +0200
Message-ID: <3002544.e9J7NaK4W3@thomas>
In-Reply-To: <20250715121111.156639-1-thomas@monjalon.net>
References: <20250715121111.156639-1-thomas@monjalon.net>
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

15/07/2025 14:11, Thomas Monjalon:
> When closing the primary process, an error occurs when closing ports:
> 
> Error closing ports
> EAL: failed to send to (/var/run/dpdk/dpdk_X/mp_socket_Y) due to Bad file descriptor
> EAL: Fail to send request /var/run/dpdk/dpdk_X/mp_socket_Y:mp_malloc_sync
> EAL: Could not send sync request to secondary process
> 
> And the secondary process crashes.
> 
> It may show several problems to fix in the next release.
> Revert the fix causing these issues for 25.07 release.
> 
> Bugzilla ID: 1751
> Fixes: 4382d58097b4 ("examples/multi_process: fix ports cleanup on exit")
> Cc: stable@dpdk.org
> 
> Reported-by: Song Jiale <songx.jiale@intel.com>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Applied



