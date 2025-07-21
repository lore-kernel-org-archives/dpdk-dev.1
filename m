Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF2EC87FC5
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 09:24:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 599A64021E;
	Mon, 21 Jul 2025 11:24:54 +0200 (CEST)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id B643F4014F
 for <dev@dpdk.org>; Mon, 21 Jul 2025 11:24:51 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 4690A1400240;
 Mon, 21 Jul 2025 05:24:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Mon, 21 Jul 2025 05:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753089891;
 x=1753176291; bh=9mfC+bOTNjqn8Y8iQcJZObXilDhIiZgASZK0fnJjmLg=; b=
 N2QD7M5VxkXWQvHsdgvWxaYg20Z7vIoFGWUhHoOAXrAoJcgb9zL426/MMvlHOzBu
 r4d2SXbjcqFxs+9dLHotOYwVsu28Ah265JO7/JxqYX9xbFqC61Led8RT5La6RZOl
 J+GoSc+A8RqEGYY5gRdeEOrmOi58VOryNEvaZhRxLb6Y//gdtrwEj0+mgHO/m/Lo
 zspVPkQ6Y6uXIN1t7ZBs6T/NNC00/NV3VNPySKRMM/91O8+O5mrNkjy6Lpiu++VA
 Dr9kL4vvYg2sOOx3oiQ8MqPIaQ9872+bOraB28ZwrRTUyf52KN+mwF0FtsL63Vel
 4uAIJ+0XU6So4JmWApokZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753089891; x=
 1753176291; bh=9mfC+bOTNjqn8Y8iQcJZObXilDhIiZgASZK0fnJjmLg=; b=b
 MLJDRMh2xaTrs4Eo+VBMG8eeB15d1Qo2ALiAT9pX10w8a7LWVJtcNq1regskPt5X
 xh66IXr23Ig31usPjmLYLBCZNb/59CFNg2koKygdOByW/cGWfpAobsvDLzJnxrER
 eimB3E52JUfjJDOnOo4W7s8Rw71kXz6cV7jqbE43vv8CHNt/1iHK77a6IInJnIz+
 1EGnbgSuCt1ZAJs6eBPQri3L/GEV/R3l4uxsdNAjClRBQrnY8wyRDp97nX7ZS5ve
 bOA+6ZRaCL6JFT7WSvfW71vphpns1Md7YjLQknCrmWfftF98bsRY4okpz+jRXZJH
 ObTHzqjl+zEdUANS6RWlg==
X-ME-Sender: <xms:Ygd-aHOCazau7RH6BrCsJ1vrWGX_Mf-8We3zaB-F7arUXZyp7_piEQ>
 <xme:Ygd-aHXw6EZeIdjMD5nW87HUq4FLQSb6FexpTqmhQa67xNYWBN3NJ_7T56nNJE2Tl
 i-9tMDVNQDeYMWOJw>
X-ME-Received: <xmr:Ygd-aGdmQLb5mjo2lE79v13g4hYjmbqEA1zEugvF3OrsTttxk1ln3Czf72XFJd7hU-uuVWUptPMxx9exCIy4cifZpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejudejudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohephedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohephhgrihhlihhngidrgihusehinhhtvghlrd
 gtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtoheprhgrjhgv
 shhhrdhtrdhpuhhtthgrshifrghmhiesihhnthgvlhdrtghomhdprhgtphhtthhopehjoh
 hhnhdrmhgtnhgrmhgrrhgrsehinhhtvghlrdgtohhmpdhrtghpthhtohepsghruhgtvgdr
 rhhitghhrghrughsohhnsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:Ygd-aLu2ctGrF3PtMWUE03kH4SURdRvN3w_-MohTe5IL1Im3F93uyw>
 <xmx:Ygd-aN_5CGLxouBDzYZlsLTnmPH8CQopCV0RfarSQtyMqA1LpRUAeA>
 <xmx:Ygd-aO16-r4IC9deru9qJoPhMNjK_vGdh-YlP9CPEkD0shWWlwoc1g>
 <xmx:Ygd-aKCejzfGWwjxy5e5brFiBsK0KfmhucF6K2t5oCOAGyhKnW4Ekg>
 <xmx:Ywd-aE6YAt4-t4JVt7fhXowN5lgL7_pGtp5L2BMlBAhZG9Q-CMQx-JFG>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 05:24:50 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: hailinx <hailinx.xu@intel.com>
Cc: dev@dpdk.org, rajesh.t.puttaswamy@intel.com, john.mcnamara@intel.com,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH v1] net/i40e: updated latest recommended matching list
Date: Mon, 21 Jul 2025 11:24:48 +0200
Message-ID: <1853638.TLkxdtWsSY@thomas>
In-Reply-To: <aHonHqcvpaipUnkZ@bricha3-mobl1.ger.corp.intel.com>
References: <20250717061604.3288049-1-hailinx.xu@intel.com>
 <20250717061604.3288049-2-hailinx.xu@intel.com>
 <aHonHqcvpaipUnkZ@bricha3-mobl1.ger.corp.intel.com>
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

18/07/2025 12:51, Bruce Richardson:
> On Thu, Jul 17, 2025 at 02:16:03PM +0800, hailinx wrote:
> > Signed-off-by: hailinx <hailinx.xu@intel.com>
> > ---
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.



