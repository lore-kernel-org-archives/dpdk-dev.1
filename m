Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B6CCAC59A
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 15:13:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 775D5402CE;
	Fri, 19 Sep 2025 17:13:25 +0200 (CEST)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id D4408402C5
 for <dev@dpdk.org>; Fri, 19 Sep 2025 17:13:23 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 25BBBEC0113;
 Fri, 19 Sep 2025 11:13:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Fri, 19 Sep 2025 11:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758294803;
 x=1758381203; bh=B82KbtBDccu26XEWEb3U+aqSlCw9BjjS+qk8lmCHGYk=; b=
 LVzlxburXpUAhHtB0qTnomend5PoiWV33m/Q421ryQxEyZ/hxI0szOQZH9tGmDzr
 mX5anBF4cq2WgOqYjdzZkYIUN5HQEvKwozRAs6WGz5NnacoWK+kn9MV4GwoXMAtD
 O/y0ZhMUeMMAtuz7FPaKU4/q9VJ4dmpx93QglsY7ljYho21JbEsopLwxuuUuemZB
 JzbtOzVHEvxrlFrnZz7bzGIaXEZpoX9BMvLKhRFcfrNsx3trg1pNmGNs/7SAX5+8
 UFO5tsUUkHr4Y6CT5mdB8LkSvJRpmeWKnteKD07W2+I0jFnf75bPwX3GfvLQPMob
 ZOUL0TTKGvPTfB/YsolSNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758294803; x=
 1758381203; bh=B82KbtBDccu26XEWEb3U+aqSlCw9BjjS+qk8lmCHGYk=; b=K
 dM8Flgx9VIj4Q6Fw4gbK0Hz9s0yXwhvefkSMx/5U89DfnIth9+xSls+RKBs2leo5
 j74k3g9ZOylLovqqCbtqMxyOjg5futwcnfzxySknSmthqOU4Xat4xrYw6AG7+U86
 N9IpRRkhXHawLz61FIersvDZ5fW+/1bDvqYrDwkwEgKMOz+NHWg1txDUsjPDOlbL
 JLQ5vSAVjaPOI0z95th48WdSt9kV3bG9mJi7rqOBSGb34lORwUPctz7uO+nc/JrK
 M3woqYPMWXEM+sHq0e3ZA+S0Sj87K2WnNk87ZPwkOUTxQAkpC90KMhxxDesc4HtY
 0QtY/6lMiX+6eMFxFu+Cg==
X-ME-Sender: <xms:EnPNaKLZEgQPLYiJg-fZtpntZN8iCbEoyi4wPdvl0dG0fIZWSV_PGw>
 <xme:EnPNaMtD0DYoOZAw8b26FIc1JfC3BJP8rk9Q-wQ_vuhr-1YtkBT3JDl55H14DSFBp
 abqjkrlS3Aci5b0QQ>
X-ME-Received: <xmr:EnPNaHRN2dXS6Q3Dv7zj2ww6hERqYVIOwOoQ3BEyP5kAtk1N-bw9sHf8DsFp_GswdVKMTd_kE_-eS4VEeu2RLwmYDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegleehgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepgedttdeljeejgeffkeekkedtjeevtdehvedtkeeivdeuuedvieduvdel
 veejueejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepgedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhunhihuhgvtghhihesihhstggrshdrrg
 gtrdgtnhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehsthgr
 nhhishhlrgifrdhkrghruggrtghhsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhkje
 gssehfohigmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:EnPNaCNoTfW_Xt28K33Pah3Y5yZaDYiSfL8rsxu49JBcHhmA8cb1Rg>
 <xmx:EnPNaMYWX6ZP8yO9tCMi-71_i4St6r1tdSnnnbh3DKoDUcZIEKUzfg>
 <xmx:EnPNaMypZX9iUOKgEibA47pk8FiQhHKgOLSxRkkDYODuzpkgRl1S2g>
 <xmx:EnPNaHJ6EyAKVF8y75xGeGnJa7YO9qYBPx9WLnVsYlVsY1lxKwG31w>
 <xmx:E3PNaERM21fwGgPRxre_zuVXr7n1yeo__ej5E5CDYpIkdYQr1PoYZ31w>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 11:13:21 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Sun Yuechi <sunyuechi@iscas.ac.cn>
Cc: dev@dpdk.org, Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 uk7b@foxmail.com
Subject: Re: [PATCH v2 2/5] eal/riscv/spinlock: add rte_cpuflag.h
Date: Fri, 19 Sep 2025 17:13:19 +0200
Message-ID: <40834601.10thIPus4b@thomas>
In-Reply-To: <tencent_EFCE09AB3F6C9C0743F5C9226108A2D86D05@qq.com>
References: <20250701182033.642384-1-uk7b@foxmail.com>
 <tencent_EFCE09AB3F6C9C0743F5C9226108A2D86D05@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

01/07/2025 20:20, uk7b@foxmail.com:
> From: Sun Yuechi <sunyuechi@iscas.ac.cn>
>=20
> Same as the x86 style, include "rte_cpuflags.h" in rte_spinlock.h
> so that files like lib/fib/dir24_8.c don=E2=80=99t need to include it.
>=20
> Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>

I disagree.
I prefer removing useless includes like in x86 spinlock.


