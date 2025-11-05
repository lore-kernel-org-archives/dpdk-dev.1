Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F265CCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 10:25:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AAE2840695;
	Wed,  5 Nov 2025 11:25:49 +0100 (CET)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id DF23D400D7
 for <dev@dpdk.org>; Wed,  5 Nov 2025 11:25:47 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 891B41400250;
 Wed,  5 Nov 2025 05:25:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 05 Nov 2025 05:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762338347;
 x=1762424747; bh=so47cW3mvoyLdoyU2RyG6cGh6zvOWc/dJuOhZphHNxU=; b=
 kMCu2vHX8WCrkUOkF72atdjwe2YAcUxte+x1NvPxq4eBX+GX2LQogJjfvK7vYbcw
 kwZlbTyES1ozJyfK7zOzIvZIlfGHS7K+Ty8ZHbutKL+3ugzWgVYmZ8rpWERnwIdF
 iBubLKz4/1liBDv5tcHsxaWmV2uaYtRwvbWpcmouBvSQ5HX7S1aT/mX1gUmbQOhU
 ehA0Ao010UAhcfMXr7EIhA9qAziyc8enho0KW2xjKIQ+9ugKZYLY0ySKnvrhV7Qn
 IqLU/DcoHqjzbWg5bITvJt7IF3n+gvevcYoMn+ZsH4EvUSE3KXVmZfhRqYpYjjDw
 UGF9a0rlahOnW6i2SlaaPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762338347; x=
 1762424747; bh=so47cW3mvoyLdoyU2RyG6cGh6zvOWc/dJuOhZphHNxU=; b=z
 byd8zGU26a0pwOp/fQdura5vwTLhXx1SEBCOyIYtynvZFmWEwmaiJ8lzkT8C+RjL
 1kkZRaj1lkxlnfpUPk9uKDhUq9lG3hDxE+xaZ53P4PUqE6UAqtaFJvpnDK8gJHUZ
 wlDLb3IhtUepzhTEdQBpc8JLxh8r0/PqFfbCySWU7VKzokvWDjvXGx/HSKN5BaM4
 +YP/kEnD1NG9gN0c+2bNoWshMXr+46/TcjSYsOU4THwInYEKDBHhN/pd+/Ux8LBa
 0/2KhVGDh9flLJ6H4yu2deRpb+Fp0p9GlB61eiiGM080tnoTpYjt44gfhXDXLiA9
 HETxykzqfKHlGaHilRmfQ==
X-ME-Sender: <xms:KiYLaUifJdDIdwY9JL43uK4janyNlm2j4CjcziM49pdOpJDSZXJ8UQ>
 <xme:KiYLaQvD8KoAjDZ4Ls0MxLE4XAkWMBIoAIh75lWdaa11Hxv1tHdsOGh8BG7KB4_bO
 JbJ3QqxX7X2K7cHbQB_bEq49pZuF-EJKXeya67Qy9a7OxP_Jq9iXg>
X-ME-Received: <xmr:KiYLaV5Iprhwr5G8NXS_doI6rGdjlSO8WdJ9scOd8IzqInwiMltycGnlw772hqANxdd9BKcmfH3wjo6oIkJTc7KVfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeefieehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhgurhgvmhhuvgeslhhinhhugidrmh
 hitghrohhsohhfthdrtghomhdprhgtphhtthhopegumhhithhrhidrkhhoiihlihhukhes
 ghhmrghilhdrtghomhdprhgtphhtthhopehthhgvnhhvvggvrhdrphhoohhlrghkkhgrnh
 hnihesihifrghvvgdqghhlohgsrghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughk
 rdhorhhgpdhrtghpthhtoheptgdrphhrrggshhhusehifigrvhgvqdhglhhosggrlhdrtg
 homhdprhgtphhtthhopegrhihshhgrthhhuhhlrdhthhhuhhgrrhgrsehifigrvhgvqdhg
 lhhosggrlhdrtghomh
X-ME-Proxy: <xmx:KiYLacOzZiL5r4nsjPYG8PzBOBP8l1PGPFwq_8iwcxKX1dLjibdP3A>
 <xmx:KiYLaTuLdSP3VvUcuoFQyFCrh7NeiTNT3NqpNn0xACO0rtqj7JmzDQ>
 <xmx:KiYLafZot8dlfvN6gVjiAtx-rnhQg4QowMFowylFRmO9mEk7kvNw-g>
 <xmx:KiYLaVwrNfagRJ9g5rlswwyZEfUJMWTZxJUCVwQawbIjQItAcxCR8g>
 <xmx:KyYLaRNsxdncHzabnXS9wy9ErhR0v5_GSW6NZfWfLPfQbLIefCw4KvjQ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 05:25:45 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: "andremue@linux.microsoft.com" <andremue@linux.microsoft.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Cc: Thenveer Poolakkanni <thenveer.poolakkanni@iwave-global.com>,
 dev@dpdk.org, Chaturbhuja Nath Prabhu <c.prabhu@iwave-global.com>,
 Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com>
Subject: Re: Assistance with DPDK on Windows
Date: Wed, 05 Nov 2025 11:25:43 +0100
Message-ID: <2455856.MHSsGVy7CF@thomas>
In-Reply-To: <85f9def5-7f88-47d1-9dc8-524b060c54e5@gmail.com>
References: <PN3P287MB0273982789E89005206DA9B0B7C4A@PN3P287MB0273.INDP287.PROD.OUTLOOK.COM>
 <85f9def5-7f88-47d1-9dc8-524b060c54e5@gmail.com>
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

05/11/2025 08:36, Dmitry Kozlyuk:
> Hi Thenveer,
> 
> 
> On 11/5/25 10:18, Thenveer Poolakkanni wrote:
> > 1. Is it possible to execute or use dpdk-devbind.py on Windows to 
> > verify the device binding status?
> 
> No. Please use Device Manager for now.
> 
> > 2. On Windows, the build generates .dll files (e.g., 
> > rte_net_driver.dll) instead of .so files (e.g., librte_net_driver.so 
> > in Linux). How can we use or execute these .dll files in the same way 
> > we use .so files when running DPDK applications?
> >
> The application must link the needed libraries and PMDs when building. 
> These files must be in PATH or in the working directory when running the 
> application. Loading additional PMDs with "-d" EAL option is not yet 
> implemented. If you have a custom PMD you have to build it as a part of 
> DPDK and link to your application.
> 
> 
> P. S. Questions like these belong to users@dpdk.org. Keeping in dev@ to 
> avoid breaking threads.

This question is probably showing a lack of documentation.
Please can we have this gap solved with a patch?


