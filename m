Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450B2C83F22
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Jul 2025 20:12:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5802E4026D;
	Sun, 20 Jul 2025 22:12:14 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 46C7F40265
 for <dev@dpdk.org>; Sun, 20 Jul 2025 22:12:12 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id B75FCEC00D3;
 Sun, 20 Jul 2025 16:12:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Sun, 20 Jul 2025 16:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753042331;
 x=1753128731; bh=Krryf3wzZ4Rm7nl3tPLy8EVtZy8BJG0QJFmWJTHtvFc=; b=
 krbggyOf0ueQla8hPRf41o01/757keuJWtj8F2KCwfmhfyWPyPPbt2xIv8T+bg//
 5ZvjDVaVy67T4Jl75gaauVVa1AdI6aakxEAnACL6iuh8UhIFz39hJ9RtvpBqaWW/
 E/K1G/xaxYuoLFjKfCXIIkhGqVlPbLMjmLy6KLMD/Ju0l+7nLjnRYauA/xqv33hD
 utXMhnp8N1SuRbLfC43Y8xLiJQcc3AK19JjAY1vmEdS77nIdmdhrrteFgjubTDNa
 Ctx4do7FC35JzV4q6dLnoNZujPqQb1UR6mGm7EB53wnJuFQpzCBCLZ2ydDLyrefi
 NjR8/XNZyRG+SiyzzeVxBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753042331; x=
 1753128731; bh=Krryf3wzZ4Rm7nl3tPLy8EVtZy8BJG0QJFmWJTHtvFc=; b=c
 +K2yjXZ0HuJlQWQRrikrE5cg++TVq56+jBUSJbpcTOTsj/UFo9CdhahlLdNX3bIo
 F7JHikmgSOgmxFMYWWNwkx/zquTlARa0U7TvTBgCC6Dg3cBbO/y1+QB9EKK7gf8B
 5MyYOesQoURddvz70Q9m1lEl/Ng8nGSVZEQls4LI+Abf9nsvZOOp3sNL0+bg4AE5
 W9CXTE30vfaR/FPN4w36P+g4di9gDAPfZM9MqgmyhNXckBrZenUjMkCRJxKgRoc8
 dmyTgbAOFrxfp3x07UEhF86xr5fY4yCA+DzPbZ1Q8elB8zHuoVkDRgFDbWdQU9NS
 z/QdHFRMKkdpiJDkkDd5Q==
X-ME-Sender: <xms:m019aGsgjUlPetOTvjFigqEERJ_SciR9iN7y5NQNRI35bMj-oIGO1A>
 <xme:m019aAv52dcceWD8xRKAvmuCJ_zT3ktpCkwBS6rmwq0V0tkqI37da6MVqfh2c25DP
 bOjEhwy_AQa3kN7Bg>
X-ME-Received: <xmr:m019aDeLRrYfJx54FVloaV6r2ZEVtSc4N5XaZ8SNYiVNpMCB_x0n1GFUI0ACDH4FOgmzrl8OZCOPHpLPOd8br0HT_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejtddufecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepvddpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnse
 hinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:m019aJamGTrSo6ySFmXcBN_EuG_KTLC_YbuOB06qa9F7lxLuaDgM0A>
 <xmx:m019aOX6uJa0Pcb7WFiUGA-eebGnq2XNI6HdZPMQooSQv0YqXsI4jQ>
 <xmx:m019aDgPDylYHxZL5wsdmDYGd99wGgUacQIk8sFpnxgYqZyYuZUmhg>
 <xmx:m019aEW2TTi0muWJhZkm6X0PJlpfdCd9S4BJNsb8Dlc871pHuPNwgQ>
 <xmx:m019aJO0eZoW_pwG0uFFBLwL8YCdT6WfBjqR7H3eIyer0nV6V1_BPh67>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Jul 2025 16:12:10 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] doc/contributing: remove obsolete advice in coding std
Date: Sun, 20 Jul 2025 22:12:09 +0200
Message-ID: <3704737.R56niFO833@thomas>
In-Reply-To: <20250327162839.2472573-1-bruce.richardson@intel.com>
References: <20250327162839.2472573-1-bruce.richardson@intel.com>
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

27/03/2025 17:28, Bruce Richardson:
> Remove obsolete, and generally not followed, advice in the coding
> standards doc, around local variables.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.



