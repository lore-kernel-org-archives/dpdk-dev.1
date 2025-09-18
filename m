Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A59CAC5A0
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 12:28:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD7A640288;
	Thu, 18 Sep 2025 14:28:11 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id 889B84027A
 for <dev@dpdk.org>; Thu, 18 Sep 2025 14:28:10 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id A384B1D003CF;
 Thu, 18 Sep 2025 08:28:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 18 Sep 2025 08:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758198489;
 x=1758284889; bh=CP9EqMT05t4EtJKzta6pBKGZbVtv+9mUwt6VuHgcPEY=; b=
 GIDmaJooiF4OBm+zeM2aqi6CV7RT05yi8xqQWbhxy9Cro53xb9sWLZ+rSD9RbZL/
 QzaBaDmVWCZrF2C//BdCsSyEkClOtmlirqN39dsMJWRYRib2efuSoECFVYJnfcG9
 W4PA3NQvaZXt6Z3MLJCCmf/nMs3IZpFzG5l+VL6NcyOhvY0znuzIACKvrnXGcjDp
 FxNL1X0xj7l5i9TZpiI7blFMoWqo5/JbL94l/yFzthzquR5l/hmGZ+f9RTtkFvmG
 jTwhGJiD75OXCHXsC/p9g1N3es9FCP90/QgS5V1RjTdRMF5PlO4+Dkx/1Evzkvm4
 uGqGgWI2j/MkctYH/CFfbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758198489; x=
 1758284889; bh=CP9EqMT05t4EtJKzta6pBKGZbVtv+9mUwt6VuHgcPEY=; b=o
 F9bFlw0RwOjFn3jv76N36U90GJWQ5xkDMlLwSELm+p7QfZ1ft4OVmPWr1dKBrqdt
 8vUVzxDR3Q7svIdd2DWdw6F14r4oriHs8g84Ts7XZbtT2GTTfHZKrUN5GGlqzeUL
 gQ6Epx24u1gjBRngiWGbpsWPQ+axHdQA948/UAnWbdtNyEe+F3mVcALmf5kGLL+b
 WIZHiUFABgOdYENZ6nA+coqAKdjbhIIvg/aCDS8zdplFXcByqYT2G69lcI6Prjwi
 FKb8TdDL+ZPjDbiGsXGDFO7+R02vcT0jjQF8TCV6ePHQ9rric5k5S856MZFy/B8I
 Nv08YynkBVKT0YQfZ+uEQ==
X-ME-Sender: <xms:2frLaCtTswcHZ440IVFVkReD2PDOHuAdRje8JjzslX4bDYZk9OyTog>
 <xme:2frLaBG-SzUsnJgGS9ONhp9MajAiXeQIst1cRJKmOOyDyVLmjihm0-388l_OXYeg5
 MWQU6x-PGlYbAIybA>
X-ME-Received: <xmr:2frLaNwqgWWpHOo7wZ-0fIPO3bCXLAyscnxzCi-X9spQfa2Gf_0AemfzcRNkn0E_IU5Xaez2SCf3bhLCkr8hbYGrBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegieeffecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepfedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugdrmhgrrhgthhgrnhgusehrvg
 guhhgrthdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthho
 pehisehhrggtkhefrhdrmhhovg
X-ME-Proxy: <xmx:2frLaAjwzsPLmxOF5p_9RmqcLX6iXyCoiZb2-eWU24kcf0mMWIgGHw>
 <xmx:2frLaAzn7WquwvHPWKXIXEm0Ja4OekcmzWYcDWiv73RrdOXviMv_gg>
 <xmx:2frLaLKjURa0XTG7-yMRchrZhSXGrfJsid8eoQLwOxwdjDXcIbMPlw>
 <xmx:2frLaPQffigrV8CPQL-W2KciUUBepSVOpMJraV8rx809W5f114kSyA>
 <xmx:2frLaIsdykY66k1gvdd7v9lhaC62gtgutK7iNtIy5OfU35oBxmU1qRWJ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 08:28:08 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>, dev@dpdk.org
Cc: Eric Long <i@hack3r.moe>
Subject: Re: [PATCH] test: raise fast test timeout to 60s on RISC-V
Date: Thu, 18 Sep 2025 14:28:07 +0200
Message-ID: <3616255.BddDVKsqQX@thomas>
In-Reply-To: <MW4PR11MB8289AF4AB84FB5FA14BE3FC3D7282@MW4PR11MB8289.namprd11.prod.outlook.com>
References: <MW4PR11MB8289B816B08C6E19716B8F82D72C2@MW4PR11MB8289.namprd11.prod.outlook.com>
 <CAJFAV8xjcsip9dxKW3PdVtmv_-HYfbe7h9H+-8x816i=z=aL8Q@mail.gmail.com>
 <MW4PR11MB8289AF4AB84FB5FA14BE3FC3D7282@MW4PR11MB8289.namprd11.prod.outlook.com>
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

27/11/2024 04:26, Eric Long:
> On 27/11/2024 04:29, David Marchand wrote:
> > You can extend the timeout via the multiplier option (default timeout
> > of 10s * multiplier).
> > So in your case:
> > $ meson test -C <build> --suite fast-tests -t 6
> 
> I hope the RISC-V specific extended timeout could be upstreamed though, 
> in this way we won't need to bump timeout in every distro supporting the 
> architecture (like Debian [1]) or even not running the tests altogether 
> (like OpenSUSE [2] and Fedora [3]), just because tests are failing due 
> to timeout.

What do we decide?
A specific timeout doesn't harm I guess?



