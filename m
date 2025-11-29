Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A69FD116EA
	for <dpdk-dev@archiver.kernel.org>; Sat, 29 Nov 2025 19:02:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F9E04013F;
	Sat, 29 Nov 2025 20:02:31 +0100 (CET)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id 77E65400D7
 for <dev@dpdk.org>; Sat, 29 Nov 2025 20:02:29 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id EC090140037F;
 Sat, 29 Nov 2025 14:02:28 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Sat, 29 Nov 2025 14:02:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1764442948;
 x=1764529348; bh=vOLF6vRR3p58cNUpMa4k2K3ORrJJ91B80tIFdWP/yVY=; b=
 lhIKLjTrnHt25YxrVgyn0XpSmO0qav/y1q69WRiiuicByMDDdT5wmi00PBTWecy5
 iF0jK13343xWFAX7M+CeijPxNQOZ+qFonWLESSy7UHLtPO60cMOqS3GmdYxcaZyn
 ixXB/xmZ63FZbyI6U1UcH1k/ThpCSlWsP2u9yiQrO7hdk3gfbmhwucuu5djQj+Me
 gdYcHZ6qBxWa36Nf7z6pSXQEf4jUUZuLnN4F7tqPFsPlI4dTMwtP8bnbkBw3UxnZ
 q1DahN0oBuwkN/8fWfrGKG/cmBrq8GnWLndGTNIrMjO+pf53FR1yoxnC0mRcnUiU
 So4TtaeJwAH7a679Kp5Wag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764442948; x=
 1764529348; bh=vOLF6vRR3p58cNUpMa4k2K3ORrJJ91B80tIFdWP/yVY=; b=L
 pFlfgrVDaAazwVxhVtUIFR7/b3hMWun6x44MlPjbppLxeCa+xna06e34zYmnxMtL
 GOjxIf2jZTLT/aJ1SuwMMer94+McXhaytjNOM5Hc0AwjHD63Uo4H0t+ayzIdZ9pT
 mltwaoZhRSX0JCKPCkINSXypE4Sg2kx171tcYJtuoAW6mGbVVdWLyhElQm9Q/YKB
 OeXJIFT96O7kyHaQx4uziIEjquS+QWLuJD9k5UzAZCQViYTpceaVviIuSzjA+dv9
 4I0Lv8VWe+AQLny0xSedsYrR8Rtrxw4nWzCFkl9RvBtz30F0rs91U2EUKD3Y5Met
 1Z9TwHw05rMeZExznagZw==
X-ME-Sender: <xms:REMraQkVG8fP0IKJkutqNblDJCegTIvXfIcXL9EnufhRECMl_hh6FQ>
 <xme:REMracL3ZA-DPnRkptj7swOsIWI22_uLUyaby9B_RSW1AWNLbV7Pi-jcIohAZKyf6
 uCk7YYeoFVgyTxTecFxsjxNpkmeA5kYbxWSOoKlu5mMk6BVir42cQ>
X-ME-Received: <xmr:REMraRbTbPazYF4wWaOKgH5_tE32_TxykDyifMpdR2GoO9s7eUcA9pnR6iD9XTpY3RpGf-8MUkjEx9g9EIFrenmBbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheefvdehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeekfeehfedtgedtjeehueeutdfgleefieevkeeikeelkefflefgtdev
 ieehheffudenucffohhmrghinhepughpughkrdhorhhgnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdr
 nhgvthdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
 epuggrvhhiugdrmhgrrhgthhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhopegu
 vghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:REMraeZD1zbdA3xggdA2yQkvTazaTdNoA_KIWydF39fhx87A-CqfRg>
 <xmx:REMraRmD-QBL2sS7AWjG44lfVT3YULGgF6t3gCE99obg-hApQqUtGA>
 <xmx:REMraayQ60aIvZuK0uITljS3WNOx3T0EMOM1BZktJ40q58KhASnANA>
 <xmx:REMrafOenUYavxSp9gW_4Gl8IVlEmIhNv6dtypLOVScsi5HWqKCTVw>
 <xmx:REMraT5Z8FXlm4tUENmWUMHkB1WdwsF84e-lgVKrUvtvVIeKDOg47Bd9>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Nov 2025 14:02:28 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/7] Fixes for Fedora Rawhide
Date: Sat, 29 Nov 2025 20:02:26 +0100
Message-ID: <4425601.mvXUDI8C0e@thomas>
In-Reply-To: <20251128135616.2662164-1-david.marchand@redhat.com>
References: <20251128135616.2662164-1-david.marchand@redhat.com>
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

28/11/2025 14:56, David Marchand:
> Similary to https://git.dpdk.org/dpdk/commit/?id=f4ef899bb3ae, we have
> many strstr/str*chr calls on const char * stored to non const pointers.
> 
> This breaks build in Fedora Rawhide as a change in its glibc now
> triggers build warnings.
> 
> Probably too late for 25.11, but sending in any case...

CI is green, it looks good to have in 25.11.

Applied, thanks.



