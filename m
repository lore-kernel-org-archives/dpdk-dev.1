Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B3FC71137
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 17:15:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A03DB402DB;
	Wed, 11 Jun 2025 19:15:50 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id AA5C540144
 for <dev@dpdk.org>; Wed, 11 Jun 2025 19:15:49 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 4ABFF114023E;
 Wed, 11 Jun 2025 13:15:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Wed, 11 Jun 2025 13:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749662149;
 x=1749748549; bh=rUXQpk1B1drVf7JvdBxbEKd5O5VkM4dUE94i0V8G1lY=; b=
 JrLr7Vra8NvNQbb81shEHqyNG35p3QNeIx0oMSjQhVxAkuPjPEndXfSGjGk1bfpj
 ldWV7YJNKqV42GPc/QFbLl/bExUUkX3l9keG75d5PZeLY6TlMEdRFgyogwDlFQM9
 zFrGDkdLQ1pZNShz5zJ0ddNq8GMeUBXNUiQDTo3WRfiKyK75ogV+PyVClYAkOayV
 dt1DWcfGdUa4gh7Qd9LbkLoL82LoupGXBjBtMqMEl8ASlZEt7uQQxyYKiu2Wdqt0
 4n27v/ZjcOdn/lhrFzKtKiBZVp1SzIYGy5CVXuc1Qwm9hLn2/gujUy/f7QXF7l2w
 nXVAW66Eqbt1Qisk1RZD4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749662149; x=
 1749748549; bh=rUXQpk1B1drVf7JvdBxbEKd5O5VkM4dUE94i0V8G1lY=; b=O
 q4+m7sSmtT4gB03WXCxJRwNmbQ/WAqgo3hAcGE3Kmd1xysbX2RwCgM9cMKSXc+B+
 VcSnEQjPGHaLmtiD5LNg7/0zSIUgtYWDP+0+JJV5YT87HO7PcpQmYx7ptDpvUDr0
 0oRBOFgZQTCHjZ9oYFW5JjCSjfV3rRaj576S9Sf3gtLCeQ1dV+b5n31INkzc30oq
 R51PX9Mgkn3OnOt2yjIlc+m/Vu5aRw5EZoBvD+rtdGTXHvh02wohV1ikwUQBX4fJ
 KN/KxfQvCxkunJ+Y31igfnBvVtWqkIWgCMQCG+lo0oz6Frsinx5w1kvwhRruawL+
 ZegIjCGZRtBn9NnsKMCtA==
X-ME-Sender: <xms:xLlJaDbUr7nCy_uU6YBBM1tItQLBM6DxmQKr4-MMoJOfUHJdEKBarA>
 <xme:xLlJaCb7Q8bxh7-HMkq88-UI8N5w9c1CW3rDlTTaPZzbks1IOKNLjA3vxlokS_HdV
 RdHreISdOPxyBkH_Q>
X-ME-Received: <xmr:xLlJaF9r_vCkJLNZvivkqH6lfPwWEHRW0MnXLkbZsaPpwlGOpYej-FUAasUKTzx5GvUWY5sEs5neHXkK3a0PefmmPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvdejiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvh
 hiugdrmhgrrhgthhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhopeguvghvsegu
 phgukhdrohhrghdprhgtphhtthhopehpsghhrghgrghvrghtuhhlrgesmhgrrhhvvghllh
 drtghomh
X-ME-Proxy: <xmx:xLlJaJp9QtMhIqB8Wg7oApJuDPd8Wi7_4bDlvyb4Pk4dsOM1EqcDAA>
 <xmx:xLlJaOqaY0KGvQtYmF97gB2iNuhAsGENW-6Fxz3VtzFaWEOpVmnPgA>
 <xmx:xLlJaPTNNf4EdS7exPlAU19ch4EraRl3RzlvaCrsOrZcILigfkG7KQ>
 <xmx:xLlJaGp6f3sgbIZerZPAH4ob5x2vczyM8j244mx91z8WACzhOvRl2w>
 <xmx:xblJaF-dnRJm3RlslELWsvK2MS7S66tXGVrdSTwaS11rNj3FMGQKKzPv>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 13:15:48 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: Re: [PATCH] test/event: disable vector adapter test
Date: Wed, 11 Jun 2025 19:15:46 +0200
Message-ID: <7983044.zQ0Gbyo6oJ@thomas>
In-Reply-To: <20250611133751.1477562-1-david.marchand@redhat.com>
References: <20250611133751.1477562-1-david.marchand@redhat.com>
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

11/06/2025 15:37, David Marchand:
> This test triggers random failures in the CI.
> Disable it until we have a fix.
> 
> Bugzilla ID: 1720
> Fixes: de09387f1313 ("eventdev/vector: add default software vector adapter")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Applied, thanks.



