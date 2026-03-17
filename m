Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301F4FD7077
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 10:38:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12E4E402B0;
	Tue, 17 Mar 2026 11:38:08 +0100 (CET)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id 4945740270
 for <dev@dpdk.org>; Tue, 17 Mar 2026 11:38:06 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id ACE4CEC00DC;
 Tue, 17 Mar 2026 06:38:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 17 Mar 2026 06:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773743885;
 x=1773830285; bh=WT8aGtuP8Ih9z3Abf8AHLHGx+wJDxCE4C23W7joUjlk=; b=
 Im1kDQS0/m1y9BeGqUx1ECCvmXrc/4S4QB5YTPw71p3897Xhnx66R2NcRMPIwQGw
 pR7eVfAn9rZrjJMmpM6o8psektyXRTCksq09Qosdj+e/GFs0KpKWISjGMwgd6PJg
 FrNP0pm49Ap4PE+B9FQ+d1RHTJudcRSh4bxDQTSOf99bBrUgnp0eXvAjLQdL5yE7
 LLTFKFQ0vEJrKoiRp9YOAkPSB41sZQB5526qaAae0snIaHkqGU1lvx08vzxwifgx
 Wk4ja9+FhyYCx6chNOvb822oc0xKGOQCUp9mo77+9WRZF1V3ngrDt2WlWAZG6bYw
 d27H6mxfjekRmoDlgmkX8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773743885; x=
 1773830285; bh=WT8aGtuP8Ih9z3Abf8AHLHGx+wJDxCE4C23W7joUjlk=; b=G
 l5pnuQJjK4Z3es6dMmf10aw8TnR6yTnR0tYh600rugrF1ZPi+W0UUKSlO3HT90SB
 1ceJD+TU6dFgPKXGpPiKSY+kvAHpqP7l5iqbXU81EdZk0HzWKilRHYH71PoZUocK
 /uoNF0tz47EDc4zMBhfKWBP/RIibqF9yIH6Vdkj9xOGkhUpvGBWA1FU5F3Rh3uId
 HJ3/PYFM3AHsqtlsHc3m2D98KX34azw2n/XU/oCdWhtzizBpfARRiIIbKveVJeWr
 sSgC0azYx1kwwIsEGbcokT0QnH/QvtODSMgdBWNpY0/4PrtpEcNX4Q3p4RkbmsdZ
 1a5nnQhJed7kFe87apglg==
X-ME-Sender: <xms:DS-5aTSJyz76dL58KrlbeiiU9vd-Yb_LTO97go38zDyUiopPej_7ew>
 <xme:DS-5aREQie-jWsWk_Eq49zv_j2V79ktIHCb_1TmYV-kGFmOFMZlL0OGrb_U6Y7qlT
 PYhwu-X8btOTUHp0mx9w_ml9EnhL4KJCXqOuqUzliA0IUJuC2wjdQ>
X-ME-Received: <xmr:DS-5abkmdr6xXQhKspZ8j4p4Iwe_b-uZkRklmGVp7l2iTHFUc_JweQT-zUXf-uiFkD23IzfnD8KHOXSV-YJiGdFI2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddutdefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:DS-5aU1SODj64hWAVAMdneSNP1D3Z9wn9oKy6KuBf1TWAmJXZ3ZwGQ>
 <xmx:DS-5afQuMWPRT-sXvdFBoP5PmjF1oHUXigpRAm6Nt2PVnwVTg6TzHg>
 <xmx:DS-5aet-6nS8JNMLaK1akiZrm43GIrls8es58sgRS66qVSXH2f2JGA>
 <xmx:DS-5acapSSo29U7bUQfCyo_mgSRiWoNd2Poy2j4Qewic63rQ0zXBrw>
 <xmx:DS-5aZRWUWY36Xv4OYp_3-9qPibiziC9MlspvDAlzWnn2Q5VNXiUuxyq>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 06:38:04 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 0/5] pcapng: fixes for Windows and timestamps
Date: Tue, 17 Mar 2026 11:38:03 +0100
Message-ID: <17391386.geO5KgaWL5@thomas>
In-Reply-To: <20260228175601.585102-1-stephen@networkplumber.org>
References: <20260220184255.306368-1-stephen@networkplumber.org>
 <20260228175601.585102-1-stephen@networkplumber.org>
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

> Stephen Hemminger (5):
>   test: fix pcapng test to work on Windows
>   test: use fixed time length for write packet test
>   test: better logging for pcapng test
>   pcapng: handle packets copied before file open
>   test: add pcapng test for copy before open

Applied (with test/pcapng prefix), thanks.


