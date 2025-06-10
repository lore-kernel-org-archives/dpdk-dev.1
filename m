Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C33C5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 10:01:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A684442E62;
	Tue, 10 Jun 2025 12:01:56 +0200 (CEST)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id D89D542E5D
 for <dev@dpdk.org>; Tue, 10 Jun 2025 12:01:55 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 56E3F25400DE;
 Tue, 10 Jun 2025 06:01:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Tue, 10 Jun 2025 06:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749549715;
 x=1749636115; bh=tiwackAM8Hzj5VYE0FievL2LmYGW7y3sDRh0Z6eTngQ=; b=
 HV8B0J5osLNUDnmYy9tOBFQQk3tBPKSysPtKWBsBPkD1m58xGFLHmakqPwjvcVs+
 C5hQOvn56Ltho/oY4g6pxidx2yuUGbMoJU9eRzzmSZEhJ3ETaVkL/4znZH1N4SpN
 2XyzGF3CfYjckXyUqP5ui5FQOuE2NpKI2EO3014Fy+yahUJ1m9zHPi7fOHD9AmtW
 d5x4y86zFzcLYHC+k2wlaFW5iBUmorymnjKNN7yHF+qTsJTlRn0DpHLolNQGr/Ak
 9gFuKT6ob/hF7CUs0430efiIL0E+mFGqvCaLsgoUMDNtZYKXvYSsNB8IxM4RoCGX
 2aII1L4IyzUTwNfb+/IKIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749549715; x=
 1749636115; bh=tiwackAM8Hzj5VYE0FievL2LmYGW7y3sDRh0Z6eTngQ=; b=o
 1sQcS0A6yBWTR8NKG9RCwHjBdtpaUry5m+JTWKch25bdsM/Jex58SuxVSg9uxn47
 OjroGI8Lw2B/bVm3y6OlBPAxXD8O7X2t/7ZSnAdRzYPLdZRSJKljptMNonbBKPFt
 MYw0CjBJGnOvo9TD/0ofwY1lUN9ZNcV16w7t4IFNwz/xwATc/czllZLGsAQ8vDRG
 fdFJzKRuzd771NqPu+d31jj+kFd/qtAbOe7tvjV/0rd9j9Rqcr+ZjRIZaWW+TGHX
 f2TzSlLpTHFb7n4ADF+UiZTUS4p/ALCux1kr5BaJG6cVOLAxhTaFrQxg/+GgDq2a
 l6onwBtS2IzPRHv46tSPA==
X-ME-Sender: <xms:kwJIaIsirmSrnTThfcoE0mx_S43LAtlTLtVu3exmJ0XETHzas8f78A>
 <xme:kwJIaFezR_uz9qKUylotUXgO9D7uE9fmevpvJGUgMWDLDWP3ZC7j1vQbpphdMUImt
 CVifC6sOumZksPhxg>
X-ME-Received: <xmr:kwJIaDzeOyYcDYA7fcbPd_jsNsmk14mN-AIJyk3ELaCpd-J_Lza10tzMaWYZVO4kX85xx5LBUv2hLfFs2_uwdo46gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddutdehlecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvg
 hphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhg
X-ME-Proxy: <xmx:kwJIaLPzWj2xaq1Xmj_2NFDcf7DZXW0vJVaSnNGZNHSXvY9da23EHQ>
 <xmx:kwJIaI9Z9PXb-mtK5-0k6tucXm_sWmtBSqq5Ei-nrV7V09ubBbYypA>
 <xmx:kwJIaDU4O1TQnCrHWza0PAQz5ZR1qutqDqPf3m5F0t9HYKKkZESyHA>
 <xmx:kwJIaBceMEv1tAv3tp0nYOfcVy2nN-zjRzeChOKyBNSHF_q6hzBscA>
 <xmx:kwJIaPDWmOTNyRWYv6jvDDM0gqOhvqoOUkliMerjhois21eLlj7gmATA>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Jun 2025 06:01:54 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v7 0/7] latencystats: cleanup
Date: Tue, 10 Jun 2025 12:01:52 +0200
Message-ID: <51978185.MN2xkq1pzW@thomas>
In-Reply-To: <20250213212151.1693506-1-stephen@networkplumber.org>
References: <20240408195036.182545-1-stephen@networkplumber.org>
 <20250213212151.1693506-1-stephen@networkplumber.org>
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

13/02/2025 22:20, Stephen Hemminger:
> Latencystats uses unnecessary floating point and is inaccurate if the number
> of cycles per ns is not an integral value. Cleanup the code and add
> more tests as well.
> 
> v7 - rebase and drop already merged VLA patch

Sorry I missed it, and it requires another rebase.
Please make sure compilation is not broken after each patch.
Thanks


