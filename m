Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7262EE6529D
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Feb 2026 20:29:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2BEC40654;
	Sun,  1 Feb 2026 21:29:29 +0100 (CET)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id 0248440150;
 Sun,  1 Feb 2026 21:29:27 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 46C537A00E4;
 Sun,  1 Feb 2026 15:29:27 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Sun, 01 Feb 2026 15:29:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1769977767;
 x=1770064167; bh=m3crgCR49GPHe4MfD7X6JbM3vM9a9pm7TFOaMVQ8uIs=; b=
 WEDkqMNVPLgfbn8UqGQ8QozcsatIZVHZiycE7phkUctKTrb9q+2J1ueROZ46J9Zn
 SCdPx4BG5IiszXBVPnx5M9f70sMviYfNg8Hb8/DMLp7EQHW+if3YBc0/adZbGBOd
 LVFJ2vrI+oaIX8KYL08zUwZw/U/XaoT0KLIq5yQXgOjURqo/CdvtcakwefraMq6S
 CQuAPVurEMTBHVDhCLLkzfgFxXwFldY+0fN3AscA980xPHw3L+cpoc+4+bMWdS9y
 UG1CdkAok2GkBdhCI6jNbTDhkHxhQ0ImjEs+oODR5o2I/UoEtG82ofxPwyBSIi1+
 ORfpeWvanIw/WVu0xfhS9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769977767; x=
 1770064167; bh=m3crgCR49GPHe4MfD7X6JbM3vM9a9pm7TFOaMVQ8uIs=; b=n
 QYeNDdPFBbqiUI4M6a87MxdTlHlk0Fg9anj8hbs6G9PjdpQAyMYic8z2yoKtNlH3
 ukHu16KGPgul6kMuWZ2Hpg6Zvfk441XRnz0JoSx0cMalAZ1Sp02CPSw5ZsCRY4i7
 ITxP1Hrua+foawemEdV04KzF0dupNrgX3phR5JYXrFA0jF4K7uv19mLpKgQhwB2T
 TTdtEcPTTCytKKX+sXqp8SVZdV3un7ADJVcEtj/8iC0IFSdd4Lz2Hl37LYeFwM/Y
 PU2CcdSKkkQH0s5kp1Zn5IUlbozKI3wTkI8pAGLvSjlE1PMW2JhZNsIRu7yEr6kq
 gRD253mI6wNlr2MWmZezQ==
X-ME-Sender: <xms:prd_aRJcqrbVklju6OnGk4zerQZbNrqqSaUjsV0RQtZ97YXEnCbe6g>
 <xme:prd_aYF-CeGKxk5WmOw9gXarMhzOcMFE4EsGXQNtgfZPSOpQ4PSvpI3K3M1kx8B3V
 kigeX7RqEUPk_veoV9oB3kFJ8iJSoaNBl_tjDL5aILOcZH3VHFtCg>
X-ME-Received: <xmr:prd_aYs5p-Nl_ph-lANTiJ5YP03ER6CpN5ydmiXKR8AvTwwDwrIH-sDKijSdiDXDL0xfwZKenZhWYDu9xyGY_N7gkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeehjeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguihhmohhnrdiihhgrohesnhgvsghulh
 grqdhmrghtrhhigidrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgt
 phhtthhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtohepkhihohdrlhhiuh
 esnhgvsghulhgrqdhmrghtrhhigidrtghomhdprhgtphhtthhopehlvghonhdrhihusehn
 vggsuhhlrgdqmhgrthhrihigrdgtohhmpdhrtghpthhtohepshgrmhdrtghhvghnsehnvg
 gsuhhlrgdqmhgrthhrihigrdgtohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthif
 ohhrkhhplhhumhgsvghrrdhorhhg
X-ME-Proxy: <xmx:prd_aXtm2MCuOj3_L8eaxLXfEMYe98lBL9bMpmfZasgneEU2c7tniw>
 <xmx:prd_aWAA3pZAiQ54piWC_1YTn-LGwaCob_8a0ZYg1IOd4mbzz3wSCA>
 <xmx:prd_aRPXC9gcX24KdqjHWGNfbxSf0q761dMsbmYG1BGgkFXgV5GQiQ>
 <xmx:prd_aXx5fqfc7cBL4ZY-NZsgaX4zO0AvpAcC_qd5T4yh6xroHaCktg>
 <xmx:p7d_adXdGrw5RzHJR8Ty2s1CGoMfiG2y2LMYOjvj2gQU-v-tIFj-xCDF>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Feb 2026 15:29:25 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, stable@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v3 1/1] net/nbl: fix issues reported by Coverity
Date: Sun, 01 Feb 2026 21:29:24 +0100
Message-ID: <5502163.GXAFRqVoOG@thomas>
In-Reply-To: <20260120203613.6f292ccf@phoenix.local>
References: <20251030033619.3386064-1-dimon.zhao@nebula-matrix.com>
 <20260115032744.62449-2-dimon.zhao@nebula-matrix.com>
 <20260120203613.6f292ccf@phoenix.local>
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

21/01/2026 05:36, Stephen Hemminger:
> On Wed, 14 Jan 2026 19:27:44 -0800
> Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:
> 
> > Address multiple issues reported by Coverity static analysis:
> > 
> > Check return values of ioctl() calls for NBL_DEV_USER_GET_BAR_SIZE
> > and NBL_DEV_USER_CLEAR_EVENTFD. The original code tested the return
> > value without capturing it from the ioctl call.
> > 
> > Move debug log statement after NULL pointer validation in
> > nbl_dev_configure() to prevent dereference of adapter before the
> > check.
> > 
> > Cast u16 operands to u64 before multiplication when calculating
> > buffer sizes and offsets to prevent potential integer overflow.
> > The num_txq_entries, num_rxq_entries, txq_buf_size, and rxq_buf_size
> > fields are all u16 types, and their product could overflow before
> > assignment to size_t or u64 destination variables.
> > 
> > Coverity issue: 490942
> > Coverity issue: 490943
> > Coverity issue: 490946
> > Coverity issue: 490947
> > Coverity issue: 490949
> > Coverity issue: 490950
> > Coverity issue: 490951
> > Coverity issue: 490952
> > Coverity issue: 490953
> > Coverity issue: 490954
> > Coverity issue: 490955
> > Coverity issue: 490957
> > Coverity issue: 490958
> > Coverity issue: 490959
> > Fixes: a1c5ffa13b2c ("net/nbl: add channel layer")
> > Fixes: dc955cd24c8f ("net/nbl: add coexistence mode")
> > Fixes: 93b38df5a2ec ("net/nbl: support basic configuration")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
> 
> Queued to next-net

After another look, I think it deserves to be split per type of issue.
Maybe 3 commits?


