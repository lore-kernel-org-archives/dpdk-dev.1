Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C35F9D0D5
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 14:46:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12237402F2;
	Tue, 14 Apr 2026 16:46:02 +0200 (CEST)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mails.dpdk.org (Postfix) with ESMTP id 94260402EE
 for <dev@dpdk.org>; Tue, 14 Apr 2026 16:46:00 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 1CBAA14000B6;
 Tue, 14 Apr 2026 10:46:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 14 Apr 2026 10:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1776177960;
 x=1776264360; bh=TT3xf2/PYj0eoMX18zfPd4va+G4di+TiJyy4hP/05dk=; b=
 q4+42Z/EqisZaS70TOtLGkyMhqSD+UaO/c+1wijk6dfG2ilhnhN+0jFdsYjk+EsJ
 MS5jU4I7gNXB4xO3FgHD4k5WXINbagTt/bAiZDlNL98ZxQnsWnq5hC1ZdTon/cUM
 BoTeXetTuuujcPEOF+6c6Zwv58NTWOgZotENghmaFZYon/gX+02KFPny5fvX4ADE
 acLga4QfLfyCpu0YDlVh40s27t9qV1rW2qm/T26jwsduXqmZa1XO/11vF9HIB39H
 Yo7Lm/jSrTGerhN5jRrhqgdqAHQUXKUFehQKAmSdfCLftA0trKUomaYDaOqs4XtQ
 KDHUTbDmBnVGMK5/6Tgd1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776177960; x=
 1776264360; bh=TT3xf2/PYj0eoMX18zfPd4va+G4di+TiJyy4hP/05dk=; b=l
 n0b4C136aED7/67wdBXH6qT8MQnLLICApzhOhfYgOirowkPg6hF+PyVaKow3p8ea
 j2P69E2iQYz2uyUXCWYdTUjc3E0CXiXvNxk2tYwXnvPcpHp/of8HDtdSdkokzXfj
 9ufTl3zK2n6vuKD5EkC3U0RjEsoYRiQqYg8pFckPVK3/d4MH0HWHSIqH+c+XYaKg
 j8A1FLzgH4Na0leMytSl93nWHfc9p9w8TJAmjl4eJH3oMyYPXCcaYpxfGdDbSrkE
 Q0h0YzgB+DI3ASweqrBt1W7rvCpYQygXYVMWLAtVFZcbUFfTHMo8uiuVgJQTfxd1
 7B5OqwH4Tw/3ucXqWI69A==
X-ME-Sender: <xms:JlPeaQNCrvh6OcT-SuKMgOPwxjfPi_fFHp0XbX20AiR-pw1IiEiAxQ>
 <xme:JlPeaXaD5vfOHBqSM_p-76GZf4THMa0JXAH_ai5qiv3fByOXxzd0u7NvwxgW6Gxjn
 eGQA7cIJb72vt858c1wVIQuSCKVK24f-0meElXjrUjMOzqDB-QVKQ>
X-ME-Received: <xmr:JlPeaX_5EPXDNQyuhDvuBsQiotPAw5H1wOyHC1v2Ct7_Oo0XqT6YqnnJ3Rq_LDLD_KGHmrvdkpaaUuJ87iAEg0jxZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegudegfecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvihgurdhmrghrtghhrghnugesrh
 gvughhrghtrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthht
 ohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtoh
 eprhhjrghrrhihsehrvgguhhgrthdrtghomhdprhgtphhtthhopehhvghmrghnthdrrghg
 rhgrfigrlhesnhigphdrtghomhdprhgtphhtthhopehmrgigihhmvgeslhgvrhhohihsrd
 hfrhdprhgtphhtthhopehkthhrrgihnhhorhesrhgvughhrghtrdgtohhmpdhrtghpthht
 ohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtoh
 epfhgvnhhgtghhvghnghifvghnsehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:JlPeaQQ8QjORtHFiUeNUarQbvH63EoZnsV0gTJZbOsTBoU9ucmg2EQ>
 <xmx:JlPeaZdedZTiGZJrYJTfiO2Gw-OeDblZI9NLJaRTfUA1aNPkAtEoBQ>
 <xmx:JlPeaaTxnf7AUd8YOqr7umA1L5x_NV7G8Modsl2yJXjqqpmQYrWDng>
 <xmx:JlPeadISp6dRlchSBxvHSrBoHOOozZjXpvZG3PbLJ0Y5FSmXON0n1g>
 <xmx:KFPeaXJY8QJpsgE9QsUwMwuYL0UAr_GBcXGDgpNVF2fYtogqVs1LW3zh>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 10:45:57 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Robin Jarry <rjarry@redhat.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Maxime Leroy <maxime@leroys.fr>, Kevin Traynor <ktraynor@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v4 7/7] eal: configure initial device probing
Date: Tue, 14 Apr 2026 16:45:56 +0200
Message-ID: <9675337.EvYhyI6sBW@thomas>
In-Reply-To: <20260414123900.3355883-8-david.marchand@redhat.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260414123900.3355883-1-david.marchand@redhat.com>
 <20260414123900.3355883-8-david.marchand@redhat.com>
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

14/04/2026 14:38, David Marchand:
> +.. note::
> +    Block list (see ``-b`` option below) cannot be used when auto probing is disabled.

A blank line is missing after the note:: directive.

With this change,
Acked-by: Thomas Monjalon <thomas@monjalon.net>


