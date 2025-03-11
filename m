Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EADC282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 16:06:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A037740263;
	Tue, 11 Mar 2025 17:06:45 +0100 (CET)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id 304064014F
 for <dev@dpdk.org>; Tue, 11 Mar 2025 17:06:44 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 7B4AD1140143;
 Tue, 11 Mar 2025 12:06:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Tue, 11 Mar 2025 12:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1741709203;
 x=1741795603; bh=FwdSz3znUFbOsTwv1SrjZKvGTUYSUqE9i2URAMBGdgU=; b=
 ugEOIiQm8FSMT4PYZlZ10Hgaf6OF857VYXbB20SRmAgV1sAx1fJ4nh2Rd1XDVQRB
 XDWQA78x4X6Z65PpmtAVynnK3JYjnyGBHBzr7JsfIyypLz3NellBIc4EsBIGNysI
 7/nK2g+3nwBPcEbvzcNgBXDYc0KgIkinyKDwKMID+z06MsTom9q5lQOhAYDbtv4i
 MQcZIB+2ekUKUQou0jpQxMBhU1aurxQo2CpWxNvF6rp3t5c37R1O70ZNlu80v9y0
 BsuyIu3m/TOnN8k3f1Tzy99dyLLQOV7x51WTGXSXnqkXE/iokDS9fy0cpDdRH7yF
 fUeViFdrVTRjlITndsWIGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741709203; x=
 1741795603; bh=FwdSz3znUFbOsTwv1SrjZKvGTUYSUqE9i2URAMBGdgU=; b=L
 e9w9urawS9T7O8FKkjdP1xa78QBerahi5Ps5ArEEd8S1zLbIQnujBjHNFiuzL1K/
 /IWTP/ZCTiCBjBzvkcGie6NXNaNCNYJXCOFj/yrd/9ds9S8+TdyYgW+aPFFGd42w
 zBHzkCnMXBCw3sAu6lW/zki0hDsA0UgYFu68FThVtetrVTsAMjysgcdMdAecPOa4
 ilF52Bs69mp5Ighto1AF94dpeRAdcKkssW9M6CK8xxwYwkWV+5CEru1QuDVpaV0S
 il/M2S5ChBhNq79HjSe6JMpRK7V45VM6LMusgfPexbNJLqOk4TAha82UEgstYmbX
 RaUqGlAJ6GmKcAG2VRwuw==
X-ME-Sender: <xms:k1_QZ7gyU3TmFNuinykeyWCAPRzw5eQ-o0wAzYKKZa7UCSzEJgtw6Q>
 <xme:k1_QZ4AElODP2sEsqEuFK69gfy-k5yWaKlrBAcJ5Yqm5CXxUbAC-XbSSI5EmSWrHn
 HElDkqA6imVG-KINg>
X-ME-Received: <xmr:k1_QZ7FCcbilgvRs3bEOxIhq3ZlsJpXqvsV1X3Nqd37wCt6fZmBWgbPmAh5VYd5nIFPOlxYsX-cJ4_BIv399bZPzwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddvieeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
 evufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhj
 rghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvg
 hrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeugfefkeej
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhoh
 hmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehs
 mhhtphhouhhtpdhrtghpthhtohepphgshhgrghgrvhgrthhulhgrsehmrghrvhgvlhhlrd
 gtohhmpdhrtghpthhtohepjhgvrhhinhhjsehmrghrvhgvlhhlrdgtohhmpdhrtghpthht
 ohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:k1_QZ4TXM4ifmFCbLxCS0uqej-bNIq2bMNmY5sqc4NU8JUksbsRM4A>
 <xmx:k1_QZ4wfp_PZFKD_jyFA03GIsB5cAjy_p8rsCUmTCYzt9k4X3N_Ddw>
 <xmx:k1_QZ-7SduIq5NZq1iQuKlksKqarNYzg5EU9WD9d0vSlCbwDv8sIdw>
 <xmx:k1_QZ9w0H3jRG5DwWN-Bk9Ur5RKGFc3iD8Vy6FGRlS3S40H2qk5FbA>
 <xmx:k1_QZ09oYTLRTrkMps01FtF9c4rlmTEZ1P8nJ9eEO08Wt84o8RBj1VD6>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 12:06:42 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Pavan Nikhilesh <pbhagavatula@marvell.com>
Cc: jerinj@marvell.com, dev@dpdk.org
Subject: Re: [PATCH v2] devtools: fix regex of skip files
Date: Tue, 11 Mar 2025 17:06:41 +0100
Message-ID: <5739295.ZaRXLXkqSa@thomas>
In-Reply-To: <20250306171210.3707-1-pbhagavatula@marvell.com>
References: <20250306152516.2594-1-pbhagavatula@marvell.com>
 <20250306171210.3707-1-pbhagavatula@marvell.com>
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

06/03/2025 18:12, pbhagavatula@marvell.com:
> From: Pavan Nikhilesh <pbhagavatula@marvell.com>
> 
> SKIP_FILES should include the path of the file along with the name.
> Update the regex to match the entire path.
> 
> Fixes: dd88f51a5725 ("devtools: forbid DPDK API in cnxk base driver")
> Fixes: 2b843cac232e ("drivers: use per line logging in helpers")
> 
> Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>

Applied, thanks.



