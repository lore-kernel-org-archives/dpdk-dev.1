Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F921C71136
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 07:13:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 934B4402EB;
	Mon, 16 Jun 2025 09:13:46 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id 5118840292
 for <dev@dpdk.org>; Mon, 16 Jun 2025 09:13:45 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id A16CB25401E9;
 Mon, 16 Jun 2025 03:13:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 16 Jun 2025 03:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1750058024;
 x=1750144424; bh=lFscqfwDNKfkfSzR+0CEASN09vERfKVe5P7a/t/89Fw=; b=
 kQGSTfXcZbcBVfewbwuYAqDHy0ASwSjqMrq5WdaRcg6Kj5t5uHU2Lk4+AaKyCkpG
 CvPMH6EtkzPThE59CJE/RoHFxhB/vOjiG5szpI6YzoFiZP+SpCMstJg0f2GhUy8L
 TMN91ynRSVALBhgdFIM8bSDqEwZeO6UrUQXy9+T0Zr8x5NmOKnm1T50hkb9TJ/7t
 /qZq0V5Vgfnv+38YUW4FFOZRmiJRnf/n9v04h7RnvJc9b9LRVQZqIN5ULhIaCG8g
 4Hr2BW+HTEAieyf6jTSN92Nas8nAyO20k2LUn+tipoBT+FDbXlWCXtwxf31mzvzj
 1SMvIAW2z9TiQeurG7nwEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750058024; x=
 1750144424; bh=lFscqfwDNKfkfSzR+0CEASN09vERfKVe5P7a/t/89Fw=; b=L
 J2trwFAWbOFSMyDknHyC+9nlZbC7gza2drZeEQBOXwxRf6AvngurCjDhq7s21zQZ
 aA+H3foa2hfHqv8GV0G+VQnvvAL8r3DOU5Wwl5jqgiB0V5/igZY+H48w+fwxNx78
 AwNTq5UIEl/qp10jjxoFuTJB/irtVDT0TxZg+AtCLMlggeJtb42HelXANEYuGVJV
 oZSmNzCCCc/juuBPTki5sfiMTrSp5LWQPAVuWFsCxe2/6cgH61qPkGIOGYWjfJVg
 Xt/R2VkxJNMeDe45KR7QyghE6JhLekXXixk7HOe2AAyIFPakvk9ZbJ+OTu1RLj8P
 R4GBxYhguNZpbytH7aeoA==
X-ME-Sender: <xms:KMRPaOtYzCcAlLKx58r_SiGsijpECKxoj05WhPEf-qV4N4g1VSTzsQ>
 <xme:KMRPaDcaf5S_179q2ktWaHeFzNzDYYzuEiZ9nKeI3bRXwOe8PLZ-XUqZ6-xngpc8p
 UQ7Cq2yXj8-1WfrKw>
X-ME-Received: <xmr:KMRPaJzrvz-kJQCMsvMaAjqxxJq1KufI_jECSmjb2jSTi3di8gafWBeiMnRrLcqPSjchfWp0tnqhG-xNGnx1OZgzvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvheelhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthguuh
 hsiiihnhhskhhisehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepuggvvhesughpughk
 rdhorhhgpdhrtghpthhtohepjhgvrhhinhhjsehmrghrvhgvlhhlrdgtohhmpdhrtghpth
 htohepshhkohhrihesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopehrohhrvghtiihl
 rgeslhhinhhugidrmhhitghrohhsohhfthdrtghomhdprhgtphhtthhopegsrhhutggvrd
 hrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopegurghvihgurdhm
 rghrtghhrghnugesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:KMRPaJPlGFO0UgUAoPoX0B7xiVw76BymDDafw6e7TlOhRXlOor1g_Q>
 <xmx:KMRPaO-VoxkwRxBU8dnpkLKMnEJ8GrtpKEc0YALIKSYNhBvoYEZT9Q>
 <xmx:KMRPaBUtlt6vV0_1mZWnrlyXiIbn9pGAmQYE_sSvTDJDjTDmMhVrpA>
 <xmx:KMRPaHeha-pjjzudohL9mMUn7JGon7SPQ6XsNIbdcjvlnTw-hzDQvQ>
 <xmx:KMRPaLkzD43cVhKr2RhFkgarKSezk219xWak7tVxZ-64dIU8xfyQcfkN>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Jun 2025 03:13:43 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Tomasz Duszynski <tduszynski@marvell.com>
Cc: dev@dpdk.org, Jerin Jacob <jerinj@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH 6/6] trace: add PMU
Date: Mon, 16 Jun 2025 09:13:41 +0200
Message-ID: <21436140.jiFIW2sfyF@thomas>
In-Reply-To: <20250616065341.3233106-7-tduszynski@marvell.com>
References: <20250616065341.3233106-1-tduszynski@marvell.com>
 <20250616065341.3233106-7-tduszynski@marvell.com>
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

16/06/2025 08:53, Tomasz Duszynski:
> @@ -86,6 +86,7 @@ always_enable = [
>          'ring',
>          'stack',
>          'telemetry',
> +        'pmu',
>  ]

This list is alphabetically sorted.

What is the justification for always enabling PMU lib?
Is it a good idea to always enable an experimental library?


