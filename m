Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DC3C02198
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 16:25:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96488427E8;
	Wed, 12 Feb 2025 17:25:14 +0100 (CET)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id E9BF742707
 for <dev@dpdk.org>; Wed, 12 Feb 2025 17:25:12 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 6FC5B138020F;
 Wed, 12 Feb 2025 11:25:12 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
 by phl-compute-04.internal (MEProxy); Wed, 12 Feb 2025 11:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1739377512;
 x=1739463912; bh=w4pss+2xva4TTER4459CzPXfvs/zhREo2WKChnO02B8=; b=
 r7pFYUso9EeAt/x79doVssTtyS0aHYmQTghr9A50KpIESqZRDmR7SYGb3K2kPSIJ
 MlCb7iBZvyO1FISvFrnJVhinnU2w7Q8C48vGNdbf+M6MQQTDMCjYQf2PplcG09Ud
 Y6eyrn48SSb3p2t/OWbyGvJBRSsP1kHIGNlru482+b9OQvLI3ZbQ/rWugrcOISNe
 2ZfYkKQxFMd+uAro52QXzB6P8N+ApJGsbfZj9IySTzxDCYUAmOcvbM31k6E/ZYX5
 pwbKfCTCdHcZ+jF9CbUT1VJgshekPiFT07g4c9Lpgmx3x3wKuMVFs2V8QBil+iRi
 55tBPD7vrbleN8GZuFCw3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739377512; x=
 1739463912; bh=w4pss+2xva4TTER4459CzPXfvs/zhREo2WKChnO02B8=; b=N
 btdO/2pqJGoNfMclONzhugF8AhJiHAzgALwOZVOjiFWg0k5a+qdMMdHUKxboftLV
 LjmplrpJNxhT71Mic8RsRKHVcU96Skn8VD6OyobrnpuvY83dlUBAKTJ3K1zzFqfi
 dY8S9tQOb8N0eePv3+wHb1B3GOycZ9SMunqhbsK5tvRUrQ1DI/DfrfuBak82RaQe
 g8YQvtScu4xs6FsMrPwnmwC+xoYgNZtZAT+iE4SvePtxpQAK0DZrLAh6/CW1Sism
 D+nWcrBumjp7KnDwIV+smIDpbED2rxzKjiKUIY7x2jif9Qeo+wYUYvhB3Jc1HiiD
 hzXuV5Fnun7oEawJK4eXg==
X-ME-Sender: <xms:Z8usZwXzszymsDv9zXeN2jQCp0_m3nqIaWeDNvipYTyvSNbyJNafPw>
 <xme:Z8usZ0kThys8Xeo723-Y-F13nm9_kXOQwop1DL8fPoC4InSqI79Sf08fGTOpsAiF-
 8b9k0DwXveA7mjJqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggeefhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
 jeenucfhrhhomhepfdfvhhhomhgrshcuofhonhhjrghlohhnfdcuoehthhhomhgrshesmh
 honhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeevteffffffgfevfeduffdv
 vedtveefueduudeufeetiefgtddvgedvjeejieetudenucevlhhushhtvghrufhiiigvpe
 dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhn
 vghtpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
 guvghvseguphgukhdrohhrghdprhgtphhtthhopegrnhgurhgvmhhuvgeslhhinhhugidr
 mhhitghrohhsohhfthdrtghomhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorh
 hkphhluhhmsggvrhdrohhrgh
X-ME-Proxy: <xmx:aMusZ0Ykg_DXRWEm2b8S9NfRdNjvCHKxK5Gx8uGRau0w-_832oMYWQ>
 <xmx:aMusZ_XB2KP0FyktkbROb6MEkfhww5o0p8gw4v937QSJ1sRo2q5BkA>
 <xmx:aMusZ6l3rAHPQfNVVBbm8AfCxck9UhWmuuaPPGwmLlDb5wSdKQLivA>
 <xmx:aMusZ0dlowjVhGKkBQNrELfQagUy79d2gJesGJCEpAotCeYoEL7ZhA>
 <xmx:aMusZ_xwxVTW0KS29x6hBE1pY2FPgnskwVabcMBwWIwFs9E6ynev9CNa>
Feedback-ID: i47234305:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id E472B78005E; Wed, 12 Feb 2025 11:25:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Wed, 12 Feb 2025 17:24:51 +0100
From: "Thomas Monjalon" <thomas@monjalon.net>
To: "Andre Muezerie" <andremue@linux.microsoft.com>
Cc: "Stephen Hemminger" <stephen@networkplumber.org>, dev@dpdk.org
Message-Id: <10d7a706-55e5-4d77-8965-15ce82b0c137@app.fastmail.com>
In-Reply-To: <25209858.kmuVQn2iE0@thomas>
References: <1739224265-4158-1-git-send-email-andremue@linux.microsoft.com>
 <20250210143429.5ec26d17@hermes.local>
 <20250211021916.GA5671@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <25209858.kmuVQn2iE0@thomas>
Subject: Re: [PATCH] mbuf: enable to be compiled with MSVC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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



Mer 12 f=C3=A9vr 2025, =C3=A0 15:23, Thomas Monjalon a =C3=A9crit=E2=80=AF:
> 11/02/2025 03:19, Andre Muezerie:
>> On Mon, Feb 10, 2025 at 02:34:29PM -0800, Stephen Hemminger wrote:
>> > On Mon, 10 Feb 2025 13:51:05 -0800
>> > Andre Muezerie <andremue@linux.microsoft.com> wrote:
>> >=20
>> > > Now that the issues preventing this lib from be compiled with MSVC
>> > > are fixed it can be included in the compilation.
>> > >=20
>> > > The "net" library will automatically get compiled as well as it
>> > > has a dependency on "mbuf" which will now get fulfilled.
>> > >=20
>> > > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
>> > > ---
>> >=20
>> > Getting close to building test-pmd on Windows?
>> >=20
>> > Acked-by: Stephen Hemminger <stephen@networkplumber.org>
>>=20
>> We are getting closer, yes :-)
>
> Good news
>
> Applied, thanks.

The patch has been removed from main because Andre reported a compilatio=
n issue.
