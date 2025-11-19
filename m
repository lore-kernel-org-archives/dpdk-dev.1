Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34B1CF2573
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 03:29:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A45E040265;
	Wed, 19 Nov 2025 04:29:57 +0100 (CET)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id DEEAE4021E
 for <dev@dpdk.org>; Wed, 19 Nov 2025 04:29:55 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id E86DA1D00168;
 Tue, 18 Nov 2025 22:29:54 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 18 Nov 2025 22:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1763522994;
 x=1763609394; bh=xL9RjCO6HScOREFf7KB2mmD82Bu+URXpPmog1polWyA=; b=
 jp7XkjDeaEw6J8otH5793ycNP5gJXclBp/RMYrBv9aRhJyPfu0xLjl1u4R34aGIo
 9m+k8fAs7L/+jqsmgtjOEBdBqwRdwmfrV6DdvWnHEGPxnlP5zHfJcJqnrEjNvJ2H
 FO7aDS195YakQTD7bg/b18qUM/FcVO5CSOqfCBzcXfhU4YIeQx3UGHK2gNP7oPiv
 NRj56NVcEW5zye/rYBTjjZa84lOqD90MwTAOV0I21ZadodrVUyzo7YcQFxQwGIp1
 G5dJsgh0u96bLGeVa0NEt1UzWlXsBmMORmw4ipPyY1VaVI9BqZ/hWlbiHFQr8zNN
 Ojhv780QDfHldl8HfWDpNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763522994; x=
 1763609394; bh=xL9RjCO6HScOREFf7KB2mmD82Bu+URXpPmog1polWyA=; b=t
 K6eylHS0hxYAyaJ6SFGcwjh9UxTa+KVPKV9CZW3nIzb4ls9MggRw1rEeCUQGvBYf
 ZNFPttOrFMDu9YrwSvx3e8fIBHoDqdp9kQ7SxSSAd56oqNoG0A1+tnPZtyus2fED
 I1giYxOem9LaVu3QFZs51qmLI3fBwTm++vpUTKwRyqjU65muBpS0o8p4mJKy8jej
 Zst3BsgydQiCNVwo5mCq2QUCoSexodgmbJdYvkDoZmDxum8a6oeqilUJKpFN3161
 fQgsvGSy++zbIrYKs2tV2plobKuWHFySENLeh49hpy0091l/WB/aHXIWqHkHVJnI
 jfecz2gzjL4ya38vX0S4w==
X-ME-Sender: <xms:sTkdaS9_DM4qoi-jvltna1AYx5xZlQrMaZRONpZi0lXJXqjNFmRNEg>
 <xme:sTkdaWaiW-5INs34YkFORrs0hSLcYY73rY6umb4Dbc1sduigviKzHoDJCiVfRaXv8
 pyCEGzwYdLdBq9kfQ0scFZUiwj7BOokEj3oyEbIPIy7cwuT6OQ->
X-ME-Received: <xmr:sTkdaR0kt0PW3zFPPDtKf4XSSR8SGvnlHWcM8HnMmd2wNULW5wtDpjmfDVeN1v8UXIUxm2qCfFtONyB0riaMqztCGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefuddvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehrvghshhhmrgdrphgrthhtrghnsehinhhtvghlrdgtohhmpdhrtghpthhtohepsg
 hruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepudeg
 phiftghsvgduvddvgeesuhgvthhpvghshhgrfigrrhdrvgguuhdrphhk
X-ME-Proxy: <xmx:sTkdaRbeFbSmOjrAfwRocm7psbw59g-LVYw7ua3lpj_dytWc-LGsNQ>
 <xmx:sjkdaZIilYk0R-tLe2KG3cDXfNWQ9Ygl2Pf9ipAM0kazqX5RZho6HQ>
 <xmx:sjkdaQEDV5vIgpnqLFAxvpSP9iFrz2mRfRIPnVVa51kqPCaTVKsqhg>
 <xmx:sjkdaQukswG3pfkRBL7ajurdgSUiK4WrZyCdNYZosk0hWTZVIkcfjA>
 <xmx:sjkdaTq7ZnCC4SAGbH6v7Qw6KWGyCzsyXEaz3-VlUVeniMo8fVjdwm4l>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 22:29:53 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: Re: [PATCH 2/2] pdump: fix race in pdump disabling
Date: Wed, 19 Nov 2025 04:29:51 +0100
Message-ID: <9567436.NyiUUSuA9g@thomas>
In-Reply-To: <20251112200510.332651-2-stephen@networkplumber.org>
References: <20251112200510.332651-1-stephen@networkplumber.org>
 <20251112200510.332651-2-stephen@networkplumber.org>
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

12/11/2025 21:05, Stephen Hemminger:
> There is a race where the request to disable pdump may get ahead
> of the handling of pdump requests in dumpcap. The fix is to do
> local removal of callbacks before forwarding same to secondary.
> 
> To reproduce:
>    1. Start testpmd and start traffic
>    2. Start dumpcap to capture
>    3. Interrupt dumpcap with ^C
> 
> Testpmd will show missing response and dumpcap will show error:
> EAL: Cannot find action: mp_pdump
> 
> Only reproducible if additional logging not enabled.
> 
> Fixes: c3ceb8742295 ("pdump: forward callback enable to secondary process")
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Applied, thanks.



