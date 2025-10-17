Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC95ACCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 16:10:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5B56427BE;
	Fri, 17 Oct 2025 18:10:35 +0200 (CEST)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id D2A8B400D7
 for <dev@dpdk.org>; Fri, 17 Oct 2025 18:10:34 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 4EFB1140021E;
 Fri, 17 Oct 2025 12:10:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Fri, 17 Oct 2025 12:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760717434;
 x=1760803834; bh=43EqL0cnnkufM8JHiGDXrBDMT+R7MG07TTtPu7fzOVw=; b=
 HKuRbH88j2DoqQZdekMece2cYc4NU7pfpD//wKQEQv9JN1G9hQs+bSvv8FfZlV36
 SAFYnx8tseHayauh0XRfUxBEx1Ea6bNhjBF38SZbBLjmtJpujv3SXJUNsBBAQimT
 VeJYpVa8U/cIQ2+mcIUg22/DoPKzm+7IQJCXIb3FU0m2mLVXvnkDfBC6W8TrAFQb
 04jxDbaAc3+3sNZXlHMbGnr/g4ap1xYyGHWCJtbOaOBSsXogLM3SM3r1W5QCROcO
 N6VWQO0xtSFP16C0aByzzisFNVqQuEh5Bz0FyJpD1xjirVoJ5MCiNXnbfVAyv+E2
 8DInqFsUg9uwFFQX5MuLAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760717434; x=
 1760803834; bh=43EqL0cnnkufM8JHiGDXrBDMT+R7MG07TTtPu7fzOVw=; b=w
 w2LiJOh7mDOFsQAmAeyceMP9Da5bACXp2hx4yH9vNKOhvMlYEXJq/cW5ZXsnBTCX
 pDT/UIrk3LJAoo2bdoBlvckRMXKICgoQnUdPCXlnMmoXMgOk/x99qzLC6XVR/NTv
 NmJ+zzG1RrHBs5P80NDLvRD4CAUMApCNnLRcgJC9rggaqHvYLz1pSFZ24lcK+T9y
 S8VxjEo78blILZBWmK0xLFyj55ovjWD4cWJvdpXQy6TLWskZ2uLDwCs8VAOlFPgG
 rlqpKoYmQsI1ZagkvREreeVlma43M9mfUsdGOtZ91OYx3ajk9XQLzVE02c4zw6sJ
 ozWtUU+0BehdQhUTzdrXw==
X-ME-Sender: <xms:eWryaHScYXv53NO9ZRLIkNy_pXAcREgYsoyTdeFlG0zMaPydQ4Sc6Q>
 <xme:eWryaBsvDBK1AXaS13qc_pjENaNkLOiZqMJfy6F-QGTGFArg9odxhcHLFNakvfP3o
 y9mQaXOFHpcki-eWmKcojeo5_ajQ-SVbJ0NfrvznlES3G1K2VA3gQ>
X-ME-Received: <xmr:eWryaIaYn85vOhBveIx8buu-QQU5bXmYjthWZyaSEnR1Ym5X63WmX9nT9JbVgfHGl4MjNjFzFMgK9ddyI6geQL_ssw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdelieduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertd
 dttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevff
 fgtdegkeeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnh
 gvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
 uggvvhesughpughkrdhorhhgpdhrtghpthhtohepshhhphgvrhgvthiisehnvhhiughirg
 drtghomhdprhgtphhtthhopehvihgrtghhvghslhgrvhhosehnvhhiughirgdrtghomhdp
 rhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprh
 gtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihshhtvghmshdrtghomhdprhgtphht
 thhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrgh
X-ME-Proxy: <xmx:eWryaHGW9SNZYMaJEM-nylh_DN6_ZC3LISrt62tu-XfqYOntBkOahQ>
 <xmx:eWryaMzuqeuxvlBnCRNwjE7FIFv-l8uyjWXd-TYjS8-WhT6CZgIrjA>
 <xmx:eWryaJlk4_PsEeu7f3eIRKsO1gOn7xlLV7lxCNaBFh-fhN5Tp3o1hw>
 <xmx:eWryaFkatfX81hUq0x4_uyXh32VNNHVXPgtgxLirNPS_BlW2pmoEcA>
 <xmx:emryaL_HDFJRVAZWU5KEaKaRx5eCeqJbBezhjikfYbhJ3h-0kCdsvt_U>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 12:10:32 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: shperetz@nvidia.com, viacheslavo@nvidia.com, bruce.richardson@intel.com,
 mb@smartsharesystems.com, stephen@networkplumber.org
Subject: Re: [PATCH v7 0/7] add mbuf debug capabilities
Date: Fri, 17 Oct 2025 18:10:30 +0200
Message-ID: <4494855.FjKLVJYuhi@thomas>
In-Reply-To: <20251016203557.2554678-1-thomas@monjalon.net>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251016203557.2554678-1-thomas@monjalon.net>
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

16/10/2025 22:34, Thomas Monjalon:
> History is added to mbuf for debugging.
> 
> This series set some marks in mbuf allocation/freeing and ethdev Rx/Tx.
> More marks could be added in other libraries.
> Drivers could benefit a finer debugging by marking alloc/free calls,
> in addition to marks already done in the mbuf library.
> Even better, the application could add its own marks.
> 
> As part of this series, mbuf statistics can be dumped,
> and a Python script will help to parse mbuf history.

Applied
It is an experimental debug feature.
It would be interesting to get some test feedback
about how much it is useful and what can be improved.



