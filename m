Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6030BCCFA13
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 09:32:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82DF7400D6;
	Mon, 10 Nov 2025 10:32:01 +0100 (CET)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id EC1F4400D5
 for <dev@dpdk.org>; Mon, 10 Nov 2025 10:31:59 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 255131D00117;
 Mon, 10 Nov 2025 04:31:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 10 Nov 2025 04:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762767119;
 x=1762853519; bh=zcPsvlgDxjf9GuEvY/IbSAo3ndr9W3TRFrnpYyhUWhQ=; b=
 I1TJ1Ge2Kud+7DxWruGbI0Bo1Wb+Wy5ZDONGMEF9efgcXC4Fr62m9okEljmu6lhi
 /l/9DOjofU4krZfdjtFiq0GHUGOxFut52+reoR7b4TLFmUg2OC8/VRHF1C1tzc8/
 iYzPmfRemUicJ5h2Opz58vKKlW9zyNOi9c5xl42Ro5qB3StoObwNk/oaI/pRHnnQ
 cvl7eAJZce4yZ23FjCZSPZij4G5uUrDptwI1W8XMyaYpiq6Wdw0y/SCWO9vv82BE
 75QWMG3Nh7qiefVWQlgrZor2nVdzTXtjBUjIn6WjzbFUIAXIHmyOy6lAf/O/GYCr
 b6v8AUj6ZzALgn3MFCoB4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762767119; x=
 1762853519; bh=zcPsvlgDxjf9GuEvY/IbSAo3ndr9W3TRFrnpYyhUWhQ=; b=a
 jtMkpLnLkqvBUPJJ0rzSOS9Bmo3JcmZXwUIhitGAGF+4ME0AZWJoj2oEMbfwaSGu
 1rXjE8RTaVulPIBdl3T8Y11OKDI4ga1o6Ko2nbBtx/7+ok5KCFZXmbImDJjJRgvP
 SDbSm6SuCjvnGqG++Kt9zpkubV+fI3lshrAyxxD2B7P4FJn37yYfShTow9r39YLU
 R7czbyeC2vk6i6lNLEmo4Vdz3y9+tM2lvHwjb7zwWhfGrfJAvRZlT5MxCyts+EUu
 cIaBkOcf76Jlh7Ezuhv7L5h0CESNoNTSwUQyqwYemtBzNM32S/iTnLg5+/2mkqD4
 Ysw4yjAqoEkRx+VybRuvw==
X-ME-Sender: <xms:DrERaUcj16nbk7NjEiG2t1PkZCikFGSjRzvsx_uc97mssBM8BeuwsA>
 <xme:DrERaRLu70DQF7xqxSRDdSi-2Nzf4NH0SmNd2vvnFRxIEb2gRewEwJh55JWC1iHzK
 mVjJdWL5YyJEBc4Cb3p_6-XLzdJqufFFZ4jZlL6RsagbXU6NQHEnQ>
X-ME-Received: <xmr:DrERaUgArViOz1H6gZPegeTqneIP_76qkYyqH4-7AY7RrCkTdrVnSrV_9ZZ6NmM9csq5C3Oi-B8kFzmaol4wqwTiEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleejleeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehhvghmrghnthdrrghgrhgrfigrlhesnh
 igphdrtghomhdprhgtphhtthhopehsrggthhhinhdrshgrgigvnhgrsehngihprdgtohhm
 pdhrtghpthhtohepjhhunhdrhigrnhhgsehngihprdgtohhmpdhrtghpthhtohepghdrsh
 hinhhghhesnhigphdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgt
 phhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtph
 htthhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:DrERafTSF-GxFk1m8vu9jFM4q0GWRbgsBjrTaOyu50FT28XWC7L6KQ>
 <xmx:DrERaeXl3zqSlCmTuYT4YqvpskYyciQ797zdYgKBKsyED517FiN8QA>
 <xmx:DrERabQOrE3zUQAkfvQOmNyrAI2rp8GKFi4LX1nMYoeUMrcL0_X2ZQ>
 <xmx:DrERaQnPHJU0-pR6A8em3bqKudoCtACzVV991x1GO7mKFVGlnKAvTA>
 <xmx:DrERaS-CeyQ5x7VvE8JAYrP8VGMqajfPmJm-aTse_WDhovkfFXjuNjxg>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 04:31:57 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>,
 Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH v6 4/6] bus/dpaa: disable qman Invalid Enqueue State
 interrupt
Date: Mon, 10 Nov 2025 10:31:56 +0100
Message-ID: <2722532.aiPYRZItUj@thomas>
In-Reply-To: <20251024061906.3535470-5-g.singh@nxp.com>
References: <20251017044848.3269627-1-g.singh@nxp.com>
 <20251024061906.3535470-1-g.singh@nxp.com>
 <20251024061906.3535470-5-g.singh@nxp.com>
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

24/10/2025 08:19, Gagandeep Singh:
> From: Jun Yang <jun.yang@nxp.com>
> 
> ShareMAC port is still alive after dpdk process quits but RXQ setup
> in dpdk process is in invalid state. If high loading ingress traffic
> hits the FMan PCD then it's en-queued to the RXQ to generate frequent
> interrupts. This causes system stuck.
> User can disable this kind of interrupt by env to avoid this issue:
> export DPAA_QMAN_IESR_ISR_DISABLE=1
> 
> Signed-off-by: Jun Yang <jun.yang@nxp.com>

For this patch and the next one,
I don't think using environment variable is a good direction.
We have devargs.
Also these environment variables are not documented at all.



