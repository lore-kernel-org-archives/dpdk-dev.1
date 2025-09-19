Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668BECAC592
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 19:16:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F47340647;
	Fri, 19 Sep 2025 21:16:25 +0200 (CEST)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id F268D4042F
 for <dev@dpdk.org>; Fri, 19 Sep 2025 21:16:23 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 8AE6514000B5;
 Fri, 19 Sep 2025 15:16:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Fri, 19 Sep 2025 15:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758309383;
 x=1758395783; bh=VQoQYr1TNcmI0WMd14c4NF3Z5BIuA2ekp9FuAdRpJOY=; b=
 sHLzCtcyUaOT6O9ngVNB4W6dFydfxIdA5niNnvHnrSv2GCQCD1nMd+bhMUVjZ/rP
 RaJzUcWwe1OF47bSerGCp4oawO6Ui+eLe0eI0GA34rmqfrQU3CJR20Y/OsO0dTde
 GuMUn3aI6ac9CP3Abu2egfjBYLzyHMP1zeC+KXLYj6a5KOdEpQRyP9kaLzHCzI1M
 6LJOoJcJcxpdHZErYknQu4ddy8qRwB4LLhzA6P4aRFOMfruiE+lnSZBSJUo+fsSC
 Uec8NdBzECrqVewRO2+JT/jqFdV/lgPzA5h/Wfpoz3mIogsshj+Q2TLjsGNF36eN
 MOSYfcUtiZ01s2RMgusyeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758309383; x=
 1758395783; bh=VQoQYr1TNcmI0WMd14c4NF3Z5BIuA2ekp9FuAdRpJOY=; b=M
 bx/9o/mw/fdBSSlnwVrjqwcx9rOu5Tg+TcVL62se0UBNLWsomCCvK1zgqNFtlqXj
 M5W4Cesno+1EjFjDrT/8Jko0HqrDkChvLYHa+9sVSTBpSIjwo6XYIYE+/b+nUcl6
 u1X/Tdtof5mptl0Y0NchV1Q5JZm6eUsWNTuBKIBTMjviMXt9zQz3SngHh/WQ6nqX
 ZAL9snVr4UgKgMz0IYKTDpl0vm+N408L9A+VA7KyEskLAbymt6RyBLaEx3mwASmK
 syTQvJS11vj+M+2lJzxZOIOkEGhZhWkGiLbCf80LYLprCJ9rFBbbe9/N0ojCZLm1
 pdZwOWi7Q3WKJxI/yc7Ow==
X-ME-Sender: <xms:B6zNaGP4vzkP1jtC-tw7d3FsZcEhEc0XJA8nCT9phiELS3OlGGy0qw>
 <xme:B6zNaPjBE1OipMJVvoihdlxbBtDknZXfdXJaOsZG5GLHV5Xaaj6Ac70XQ7lb6x22A
 AvcWq4pSQry5nTH3w>
X-ME-Received: <xmr:B6zNaJ10btkKvG5-5d98c4ie2ywycFc7WwmotMOlhSQrmr92CSYtYVoBQKWBxdIFLr9HGPA0LCFPPjcpu828rEdNzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehtddtvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepgedttdeljeejgeffkeekkedtjeevtdehvedtkeeivdeuuedvieduvdel
 veejueejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepgedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepiheshhgrtghkfehrrdhmohgvpdhrtghpth
 htohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepuggrvhhiugdrmhgrrhgthhgr
 nhgusehrvgguhhgrthdrtghomhdprhgtphhtthhopehsuhhnhihuvggthhhisehishgtrg
 hsrdgrtgdrtghn
X-ME-Proxy: <xmx:B6zNaJjqySS0N2aOHa-quuR3yIRblUu4uUUl-G-t4aDxMhN8yyVhsQ>
 <xmx:B6zNaJfAc3Uk2lRucn7tkCmllCt6BtH2aUDngFpCwf4dg2-FMCMKTQ>
 <xmx:B6zNaMm9bwYIso4n40POjCwX6e8nKucV6q7BqCgMTnSoFsLVURZIGQ>
 <xmx:B6zNaCtLj4C1X9q5PIeYi0csnDBDkCEmJes-vuV6D38Ggfkuk8Gfbw>
 <xmx:B6zNaJSoMENDvpzxUYUXkSVVtSwzOYJGMEuQfV3ZtI-3q1p6Eqjd6Fs6>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 15:16:22 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Eric Long <i@hack3r.moe>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>,
 =?UTF-8?B?5a2Z6LaK5rGg?= <sunyuechi@iscas.ac.cn>
Subject: Re: [PATCH] test: raise fast test timeout to 60s on RISC-V
Date: Fri, 19 Sep 2025 21:16:20 +0200
Message-ID: <2749886.8hzESeGDPO@thomas>
In-Reply-To: <42d5a086.2c8ee.1995d41f1c7.Coremail.sunyuechi@iscas.ac.cn>
References: <MW4PR11MB8289B816B08C6E19716B8F82D72C2@MW4PR11MB8289.namprd11.prod.outlook.com>
 <3616255.BddDVKsqQX@thomas>
 <42d5a086.2c8ee.1995d41f1c7.Coremail.sunyuechi@iscas.ac.cn>
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

18/09/2025 16:37, =E5=AD=99=E8=B6=8A=E6=B1=A0:
> &gt; =E5=8F=91=E4=BB=B6=E4=BA=BA: "Thomas Monjalon" <thomas@monjalon.net>
> &gt; 27/11/2024 04:26, Eric Long:
> &gt; &gt; On 27/11/2024 04:29, David Marchand wrote:
> &gt; &gt; &gt; You can extend the timeout via the multiplier option (defa=
ult timeout
> &gt; &gt; &gt; of 10s * multiplier).
> &gt; &gt; &gt; So in your case:
> &gt; &gt; &gt; $ meson test -C <build> --suite fast-tests -t 6
> &gt; &gt;=20
> &gt; &gt; I hope the RISC-V specific extended timeout could be upstreamed=
 though,=20
> &gt; &gt; in this way we won't need to bump timeout in every distro suppo=
rting the=20
> &gt; &gt; architecture (like Debian [1]) or even not running the tests al=
together=20
> &gt; &gt; (like OpenSUSE [2] and Fedora [3]), just because tests are fail=
ing due=20
> &gt; &gt; to timeout.
> &gt;=20
> &gt; What do we decide?
> &gt; A specific timeout doesn't harm I guess?
> &gt;=20
> I think increasing the RISC-V timeout is reasonable and shouldn=E2=80=99t=
 cause any issues.

Sorry for this very long (forgotten) decision,
and welcome.

Applied, thanks.



