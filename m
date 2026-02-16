Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD792E8383C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 22:08:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A796B40289;
	Mon, 16 Feb 2026 23:08:39 +0100 (CET)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mails.dpdk.org (Postfix) with ESMTP id F08DD4026C;
 Mon, 16 Feb 2026 23:08:38 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 63DDB14000CF;
 Mon, 16 Feb 2026 17:08:38 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Mon, 16 Feb 2026 17:08:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1771279718;
 x=1771366118; bh=lHnDjkhpsOec6a1Vd1wrXAXIestbcf7UkMhOVRSHzP0=; b=
 HAF8JmDzBtB6j4S+eXjX/Sp+6J08jbCIbT19sW52s+uaVsrG8eHNjnrZXmhV9SEd
 cjlskb3rV9e6Of03e4dowlUzcY/ad9EueCujTSqf8sgYFhNjzqTkWQRqVJk3z96r
 Am0d8YAEie949w5uR9wfvEpwaq4rYrF0OKks4LziDh1SVO4aSk4y7xqAzwNlKtDO
 Y6i8FXINYtBRHIKDIAiNvJAaRF7DAFlCgFbb+kbeVMKRdVicHe3v+v2AJIBG8+ls
 3RMxXUBDACUZGCHtntc+/CSmRKbfrbv8jAY7d8uVER+EpzVrEHi/vv6l5cQX4g9m
 WfcIz/hTupTRDX4WGhfRCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771279718; x=
 1771366118; bh=lHnDjkhpsOec6a1Vd1wrXAXIestbcf7UkMhOVRSHzP0=; b=P
 ieG4DcDM6QmXQbe+Ke1DTcNB6JVAjkqhirjdaIGsCBjgtmRIglMVn7l6XEmCUFyt
 lOU/tURm6Tfb/czZrGZpRkgVzZY0JQjlZbDrjod26iQVJ4KzMt4bUChfaHnJIFfR
 GA2O4W3zobWJZVteVtujnKWX90FtOpf3POX9aZen5ISKc+AWv+IbwqgUEyxTeSSv
 DLN44QBH8dJITSWQhQ7Q6RWNdz5JcfY+k55r6lJc2GmU6GaUKi1OJEUlKhArixRs
 EXq+PNiFg0Oarb5HuMIVK5oPyeOH7lZVByiD1SxNxKQg4ant75Ud9MhPmycN0JkF
 p3iqsjNK17yPR6GAdlV7w==
X-ME-Sender: <xms:ZpWTafU-qbZ1zWrAMUIq2dWK9nKV3M7qL0MVXr5nQjSRMF7Wlcid6g>
 <xme:ZpWTab7XE_J2z-qDM0_IrKUQrG212YrOdgB8temrJISHnND-Qye90pVGPc7r805mY
 uaptGJwt4RZpGvtQvJYFj5F2tDuktUPgLse0sydAMgjom7ue3ZgaA>
X-ME-Received: <xmr:ZpWTaahCBGnWGh53GAN9r5M3jEKjSnHmaJ8Zz7SkL-OFirtSEe5Jx_0kZUB2GHbslTa7_x9aKLbh7D1S7-kySKWnsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudektdefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtohepsghruhgtvgdrrhhi
 tghhrghrughsohhnsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:ZpWTaSdJZV-oJXXrCJtXK1HQRBEtJkIbzOzubmh03QVHD3yh1GBjmA>
 <xmx:ZpWTafc3SxTvzAQ0-s9wDKxeBKVXc4_RGiAB8STa8gFd9fM6m4kExQ>
 <xmx:ZpWTac9Bzep2MQVZEbff42x_oayn2YtWcBNRodz3fr5mvnKo3Vk5lQ>
 <xmx:ZpWTabl6uvkFyz4qdx_fS1AHLjEhy6Dnapyg27Gn4MqsCOfjZ8HO3w>
 <xmx:ZpWTacFBvK8u42nmIcJFYugN3Kj3blheWwmFZSSAlM7EOBzagClJdqw0>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Feb 2026 17:08:37 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: stable@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH] examples/ethtool: fix error message about ports limit
Date: Mon, 16 Feb 2026 23:08:35 +0100
Message-ID: <5421831.2eUtgXV48J@thomas>
In-Reply-To: <aXnoYJo_ZJ68zodC@bricha3-mobl1.ger.corp.intel.com>
References: <20260128103350.2730104-1-thomas@monjalon.net>
 <aXnoYJo_ZJ68zodC@bricha3-mobl1.ger.corp.intel.com>
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

28/01/2026 11:43, Bruce Richardson:
> On Wed, Jan 28, 2026 at 11:33:50AM +0100, Thomas Monjalon wrote:
> > The error message about the number of ports was swapping
> > the desired and maximum number of ports.
> > 
> > Fixes: bda68ab9d1e7 ("examples/ethtool: add user-space ethtool sample application")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied


