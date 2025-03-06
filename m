Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B868C282DE
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 16:13:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1238406B6;
	Thu,  6 Mar 2025 17:13:54 +0100 (CET)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id 302194069F
 for <dev@dpdk.org>; Thu,  6 Mar 2025 17:13:54 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id A54441140204;
 Thu,  6 Mar 2025 11:13:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Thu, 06 Mar 2025 11:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1741277633;
 x=1741364033; bh=rgKO0rkZRplrnOBBU4MgEvS21icvck0Zonf8dffcqUk=; b=
 WcnV4adkb3CYtvmqO5Io5dYeXnz3TwQrqE/nk7RCIA4fxIjW8ybmihAZSQ8oUuGU
 4KD33vRrFnNlBFZHM1kR5Kts6qTAXXlHUy7FDtvkOcagQnoX5Fi8kJWZ7xzMP6g6
 AsZAklJPB1i2VCJloRPSY8zWj4Ih6FW3jPtx7eYsVlU9++Mep0yS/nh7AtDySmVn
 EM0s5w3+HsZVL0lMmjiI35vM4ze/G5OqwolrhwzCbBzeQIgeat1fuHUfgM+4OO8b
 ktDDvv/R+BeOB6nNa+a9Kma7pw0ID51nV3y51Jx/HiQE59in4xhZ4qIAFp+nX4rj
 WrY72YU3gAqDPbcp2QhkVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741277633; x=
 1741364033; bh=rgKO0rkZRplrnOBBU4MgEvS21icvck0Zonf8dffcqUk=; b=A
 seupYd47Lm/rYyOVy8TqQEyL7+dSHAQOeOYVrN34NcGmYI7QyBHSIdmB4PJtVUsU
 ToZClFccejN2p3QiBiBoi2Sx4lVUXdyXsMBWNAMD7T9+f/gF3DF+V11jHyjVRbba
 3mIv8STf85isZ4QgZKo9JrrUx6wN7lDaNowUhEakAA3HpZmWBz6UeVSUcyGofCTf
 Fh+oty+rbPziE6m6pgHXOxOj9TiRk1fwwCW2Qq/czoQrROKFnaZHuPFrssq9WeA1
 a5v558zHD6xwCBLmCtptLwzJfLD8Ww/57WGTdKuzdmElNLSVZLOsMBrljVG7K8HA
 y6lgPHqrSSamLd9K8OYvw==
X-ME-Sender: <xms:wcnJZ0E_N2aHkqS1Zh2rCTRXYZcCaYtXNFlsNnj2PFED3LoGBVdSMA>
 <xme:wcnJZ9VwPB5IQtTch8nh90jobvPlmEl8xOtFD83cVX6Qv2h49LzyvqbaywGiXscMq
 9j_6vyWDVo0cSb8Vw>
X-ME-Received: <xmr:wcnJZ-LA1951xMeJeGl7G89g_UdEdxXxpf8HZ-lcORhCwGlAI4KkY7HPrRwWzWkEoHQWOnUpkXYgfibbDg73OH92Ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdekvddvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
 evufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhj
 rghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvg
 hrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeugfefkeej
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhoh
 hmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehs
 mhhtphhouhhtpdhrtghpthhtohepphgshhgrghgrvhgrthhulhgrsehmrghrvhgvlhhlrd
 gtohhmpdhrtghpthhtohepjhgvrhhinhhjsehmrghrvhgvlhhlrdgtohhmpdhrtghpthht
 ohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:wcnJZ2GYY8qo7hafs4xc6F7rqaNzaCW7vBWz_h4Deuz8zKcbkE2QeQ>
 <xmx:wcnJZ6XL_nrJTbyQYHpeOP54X108xZ4MNewsQZNdc72ti-7baQywQQ>
 <xmx:wcnJZ5OPdZynGaOviCKENCzigfLRU5UMZE78oPV5wH3Z142K4iIszQ>
 <xmx:wcnJZx3FLYVv9MHPjCKpWdInKCjpsnbFb-LTMx7nABSDDGJtO7efpw>
 <xmx:wcnJZ5Q0OyLFjS6qUtKt18ogeNa2vtjTTOyeEg0IUNYXzTkXlhtedidI>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 11:13:52 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Pavan Nikhilesh <pbhagavatula@marvell.com>
Cc: jerinj@marvell.com, dev@dpdk.org
Subject: Re: [PATCH] devtools: fix regex of cnxk skip files
Date: Thu, 06 Mar 2025 17:13:50 +0100
Message-ID: <4055192.n0HT0TaD9V@thomas>
In-Reply-To: <20250306152516.2594-1-pbhagavatula@marvell.com>
References: <20250306152516.2594-1-pbhagavatula@marvell.com>
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

06/03/2025 16:25, pbhagavatula@marvell.com:
> From: Pavan Nikhilesh <pbhagavatula@marvell.com>
> 
> SKIP_FILES should include the path of the file.
> Update the regex to match the path.
> 
> Fixes: dd88f51a5725 ("devtools: forbid DPDK API in cnxk base driver")
> 
> Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
> ---
> -		-v SKIP_FILES='roc_platform*' \
> +		-v SKIP_FILES='.*roc_platform*' \

I don't think it is what you want.
The last part should be .*


