Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CE9CCD183
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 15:31:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F682402A8;
	Mon, 13 Oct 2025 17:31:17 +0200 (CEST)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id B2F544028C
 for <dev@dpdk.org>; Mon, 13 Oct 2025 17:31:15 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id E65E8EC0103;
 Mon, 13 Oct 2025 11:31:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Mon, 13 Oct 2025 11:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760369474;
 x=1760455874; bh=w0zi8j24ba/DSEzgl+0MeszfYSiq+f8Jf2VIi50Ki9I=; b=
 AVP4Lu4F4ySB8p8lXFG7IFLet5UKJ/IuDMNJYvoEf76bV+hleKKnoHYjxCYUZ54L
 YaJ3ODGSQvCkMsomkb/kLAjMXOF1WedSQDI5Hqz0HVv0Ng3gxOwS/MP4r2JQ3nyl
 OFDYsjis8MJKpa0thKSzO1+xoHixkq9wVbkOtt7ORNmIUOKd8ytG5tJg2iC4btkg
 Oopf5+GKESxzXHC8WbMrvLfH6wUXHRq/Lf0C9U9FGyhqHi2HuWzNXgap4iYoLjyG
 Gwg3S1gl6oxWKDWVyjk6GT7oat+fwy/MMMocih8E9ivrQfe/Qt8DlWNAVLAnMHb9
 4x6SL25mqISrkrMonv38nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760369474; x=
 1760455874; bh=w0zi8j24ba/DSEzgl+0MeszfYSiq+f8Jf2VIi50Ki9I=; b=I
 ZtEIFszIgxHXhs0GeN6hRV67GlU06AN7avFwtJbO/AWGXrSQzZthboasBkVhM8Aa
 sJZex1BL2iWGcT6GGZKpoI3XESWzkxQm3pm1/2r6WS2ETYWpLcE7j+gOVgpiOl7O
 9/f4H4l8SCA63vXEtqA/NCKGQsn8WNCq7OG8826UrcZFvglsnXKYZYKBV3t4+ARu
 AJHkkU1X87Vk/L9I8ryuOFTQCXewBlkxFi9pmQUR7oVqY+tV+7m1hZGCsfnlQtCh
 HoWBbje9dlsmcrl6LyCJW5xtW2aYfvqWitvZid64AMWe5c0tmoZPVleTqvnHXryZ
 JOygzRYO42+/93/UsycIw==
X-ME-Sender: <xms:QhvtaDJzxm5uEYWZ6PmG-HDmoemlMfFmU4e_jyVJ5et_210a9LzhAg>
 <xme:QhvtaCEXRpNchN0EkE5q01AFimmED2TpO7OcdtIFFU8Wp8uWcQXXuXUaXV7H1YDvX
 1dGZhcSIoabBpN99V7XubJTwxY1BxOTnYrqi3lKsLqnI2qyn39Iow>
X-ME-Received: <xmr:QhvtaKv1E6yBTT2x9odbJDFrrMjaJ-c9LsThtSrHWh0MqXA4ApyCRjaQs7euqZXsVWTT8WMT1PxKdSNpILAzJ2_2Wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudektdduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehshhhpvghrvghtiiesnhhvihguihgrrdgtohhmpdhrtghpthhtohepvhhirggthh
 gvshhlrghvohesnhhvihguihgrrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghh
 rghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepmhgssehsmhgrrhhtshhhrg
 hrvghshihsthgvmhhsrdgtohhmpdhrtghpthhtoheprghmrghnrdguvggvphdrshhinhhg
 hhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:QhvtaBtAqfV5_64Ttxe2tEvXoHbO82kQWggD-UDLAJTweMMxnqyIMw>
 <xmx:QhvtaIBp0BbOKNSwpO48YSEfzUWS4rdvudztftX-hKqkx9IHZ608AA>
 <xmx:QhvtaLNZNcbIUkaOE7djjfVip_E-tdWwJp6u2Kbfl8YRmms2fH52Xg>
 <xmx:QhvtaJzXBoYgqDVuGekFa-ZoVRmNAbxfUGNR3bpeu2MxF_2yXCHE1Q>
 <xmx:QhvtaLi9vSLNWMWkDEnmI3MwXpngtO0Xejm2qPd1V41clwNBwQZhoHqF>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 11:31:13 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, shperetz@nvidia.com,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: Re: [PATCH v3 4/5] app/testpmd: add commands to dump mbuf history
Date: Mon, 13 Oct 2025 17:31:11 +0200
Message-ID: <2700803.KlZ2vcFHjT@thomas>
In-Reply-To: <CAOaVG15nZ7NpHQuYnWtiit+U5HbwncEZEuUWA_ZaPnE1doHvpg@mail.gmail.com>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20250930233828.3999565-5-thomas@monjalon.net>
 <CAOaVG15nZ7NpHQuYnWtiit+U5HbwncEZEuUWA_ZaPnE1doHvpg@mail.gmail.com>
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

01/10/2025 10:20, Stephen Hemminger:
> Most testpmd commands use spaces not underline as word separator.

I agree.

The existing dump commands should also use a space separator.


> On Wed, Oct 1, 2025, 01:39 Thomas Monjalon <thomas@monjalon.net> wrote:
> > From: Shani Peretz <shperetz@nvidia.com>
> >
> > Dump the mbuf history to the console or to a file.
> >
> > The dump will contain:
> > - Operation history for each mbuf
> > - Summary and statistics about all mbufs
> >
> > Dump the history of all mbuf pools:
> > testpmd> dump_mbuf_history_all
> >
> > Dump the history of one mbuf pool:
> > testpmd> dump_mbuf_history_single_mempool <mempool_name> [file_name]
> >
> > Dump the history of one mbuf:
> > testpmd> dump_mbuf_history_single
> >
> > Signed-off-by: Shani Peretz <shperetz@nvidia.com>



