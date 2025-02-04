Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DC1C02193
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 16:03:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 155EB410E3;
	Tue,  4 Feb 2025 17:03:04 +0100 (CET)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id BC426400D6
 for <dev@dpdk.org>; Tue,  4 Feb 2025 17:03:02 +0100 (CET)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 576431140101;
 Tue,  4 Feb 2025 11:03:02 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Tue, 04 Feb 2025 11:03:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1738684982;
 x=1738771382; bh=CgXeb6hhz/GmncTrBo3dO8uFfqb28RCHzjlC28un0fs=; b=
 V734ZrlEnVTs1wwFV3EeHlEuXrZ6UBU9mukF6uQtsq01HEdk28vhN7pRG1D3iGK4
 IIyjdR7Sw/u9HrOhsN42jhLA+4Do6GymVdyAD7o3H1qpXc8RDoXLwu8uXwYUSsBq
 iSrzQ0NikiZ5K4a2ou/rR3DP6/QtcrCdNlNZm2jsWEQx6th43J7KaNcsvNmzEz/d
 bMH4ZA1ZfaXgNHHzsoIBs1cDY6CWb9HrERbq6JCBHQ3mLqiVb9l4kk4RoW4FHsxR
 srfCzjIlmn1lJ+pJqq5puYTZkFq6kGrM2ITI8jiimDBa02xXAPwNT2kFc5BJjgo6
 A0spWgTbJLKIsb6X1vRbfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738684982; x=
 1738771382; bh=CgXeb6hhz/GmncTrBo3dO8uFfqb28RCHzjlC28un0fs=; b=a
 vsKfXul0PzKlhJi9qz46NpkfYjgKAy/oToIIikdaX9tobESID/hQvf//4CnbKimK
 Bq5x79zE4uXBoj7eVuJq9d+DPy6IOIBxphocpE3MQmDexABzlZXS9vDzE2Aup4/Q
 CRrGCccYEyNTfTAA4iqQmB49tw4OGqaT+g4yQH7tyJCCZM0KdCF0MNebmlqj+3Bj
 Z4C0GsOaHfFf5V8rRcqfYBpbZQTsNizL4LjuK6AGIHmFGpgsDZdsVeik1MsM2nGA
 z7ZDXqcACiFKLnuxMzfxjE2mSSkYrH308rRdRkfXEMKyjQgXv9/IE2sr/nPDK9wq
 pFz1EyPmU3wUKf8o7zmSA==
X-ME-Sender: <xms:NTqiZ9LJgA2WcUlv13esW8Nf-cpCXnpkAk4Z3I4Wwor-4Y1Bi_zYKg>
 <xme:NTqiZ5K2tuZUcq7xWdvo-VyzT6Yf4n621xKIuLwuMsGtqqBmHKmhnWE-lCI6e84J-
 tEs8b0GfK5fdIH9Lw>
X-ME-Received: <xmr:NTqiZ1tAy0XYLtPGDu4I7QnNnOdjNGo1H1Z-qeDy_0mjEE3EBI2IcpfREGzpT_-OI52UNL9LoMmvtArJcB5G2x5ZpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdelhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtqhertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepgedttdeljeejgeffkeekkedtjeev
 tdehvedtkeeivdeuuedvieduvdelveejueejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvnh
 hishdruggrvhhiughoghhluhessgdquhhllhhtvggthhdrtghomhdprhgtphhtthhopehs
 thgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopeguvg
 hvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:NTqiZ-aUI9asEj2J2GhuOtQ0xa7bZgfuJ5EKUGxbUwcFk3wnSXUT9w>
 <xmx:NTqiZ0bOOBnTqb2wLfWQHbdWRLPite3XTvgtmLn6X2yBYnF13q4JzQ>
 <xmx:NTqiZyBU8SMm4s22j7sx40_kr1ZpfoUEa14BcM_RVyHr_aoTFr2kWQ>
 <xmx:NTqiZyYjc9_RI2-nRjV1sOI7uEVkXhGPmB6cxLYaUiMwmE8FjC-OEQ>
 <xmx:NjqiZ8EdpHPQgaGplQ2XAI2xDI75KpM8PvSmyYJLgdK5Jy3jsWAn1VIR>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 11:03:00 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Denis Davidoglu <denis.davidoglu@b-ulltech.com>
Cc: "stephen@networkplumber.org" <stephen@networkplumber.org>, dev@dpdk.org
Subject: Re: [PATCH] net: support Arista L2 headers
Date: Tue, 04 Feb 2025 17:02:58 +0100
Message-ID: <4092617.3daJWjYHZt@thomas>
In-Reply-To: <GV1P190MB20413FBFFA4FC719AC6E982EA1F42@GV1P190MB2041.EURP190.PROD.OUTLOOK.COM>
References: <GV1P190MB20413FBFFA4FC719AC6E982EA1F42@GV1P190MB2041.EURP190.PROD.OUTLOOK.COM>
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

04/02/2025 16:41, Denis  Davidoglu:
> Packet parsing and type detection fail for packets containing
> Arista Vendor Specific Protocol (AVSP) headers. This patch adds
> support for three L2 headers: Arista TGen, Arista 64-bit Timestamp
> and Arista 48-bit Timestamp.

I'm not familiar with these headers.
Are they standardized?
Is there a RFC?

> +/* Arista Vendor Specific Protocol (AVSP) Header Types */
> +#define RTE_AVSP_SUBTYPE_TGEN=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=
=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=820xCAFE
> +#define RTE_AVSP_VERSION_TGEN=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=
=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=820x0001
> +#define RTE_AVSP_SUBTYPE_TIMESTAMP=E2=80=820x0001
> +#define RTE_AVSP_VERSION_64_MASK=E2=80=82=E2=80=82=E2=80=820x0010
> +#define RTE_AVSP_VERSION_48_MASK=E2=80=82=E2=80=82=E2=80=820x0020

I'm not sure about adding vendor specific protocols.
What should be the policy here?


