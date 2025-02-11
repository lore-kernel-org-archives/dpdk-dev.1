Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5556BC0219E
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 08:38:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 523E140156;
	Tue, 11 Feb 2025 09:38:56 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 0E91740150
 for <dev@dpdk.org>; Tue, 11 Feb 2025 09:38:54 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 6D5291380439;
 Tue, 11 Feb 2025 03:38:53 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 11 Feb 2025 03:38:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1739263133;
 x=1739349533; bh=yWjfHWzN2OsFBa7mH+yvZikbmfa7HZxtQcD/tMNRVfo=; b=
 X/Mj/IY00JmwQHEGNdjg8t96BGtdPm/GGNN4ViSM1us3/l5khhsAtxamklIKJ3gU
 gJRjCJy7sNvX1mmBbXaczfewjgDOTivgf5+MPhP+Xcbm+Kcr9gDLYnmHazJBi0yU
 518sE9EFYC3U0illkUewIEMr9EhSt/yE+NuhkSxVcG3xJ/2CRNn89yWkDGHoTdEv
 QAlM6/Uw9s2vHfnUb/mhVA6foNm+tSAYFhGscmWjvh4iARAp7Ca70YMwVMdzFqAc
 PomHhD9qX6Uqt9TLRiRP2l8MNPReNhEMw2oIkfjHjPYebXYqPHFiDLT9OceL3inB
 nWSIkpLnyUOmxzoyTZdJvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739263133; x=
 1739349533; bh=yWjfHWzN2OsFBa7mH+yvZikbmfa7HZxtQcD/tMNRVfo=; b=e
 Pk4b73kkEZU73kB5M1FhO98SfPc5sg9RiL1lSm3Be1uYNPK+SLGYHXxXtMEOMZHL
 JUEftiPd8XZk3dNNc5Owf3Ububge2MzUebaBvMqeant5D2CEMOfNz1oQllS5sGYO
 wKFj2cIkC8MZEkcFmQCiDmVqHuxTcyqCkG81ddjGnx0PBDJW2Tah3T+69g7RtYPw
 L9lVuvqXgWOMwLPvgXUYyqipPyX6z4FbvZXdQ9aIQylAJJSX9O2oJHC0iTejBJYw
 aqs7hoaZShg5VInyRPX8Od9stcwlfo8HruJeg/suJpmxH5CmyvykHZ4dfJfEN+m+
 SGsI9864YTqvj38p/RLhA==
X-ME-Sender: <xms:nAyrZ-QbAl884Gw8dGVK840LmJjf8bW35LM-uNEOsMuMTLOzElcy3A>
 <xme:nAyrZzzUGg-z2lzD3FTd_th38IJI_phFrZrZ1-C9k5oQqwdc8FkckDRj7VlRZAd9n
 cO_UWDSGsE2L9pKOw>
X-ME-Received: <xmr:nAyrZ72dyi-h7qWiESnY8e31eZRC5pzbkoR6_UJom1IVjTJhadW6z9oyHyZHzehJl15-H1uvhi9hQuJ360zKYSppng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegtdehgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvg
 hphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhgpdhrtghpthhtohepphgruhhlrdhsiigtiigvphgrnhgvkhesrghrmh
 drtghomhdprhgtphhtthhopehprhhosggssehiohhlrdhunhhhrdgvughupdhrtghpthht
 ohepmhgrgihimhgvrdgtohhquhgvlhhinhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:nAyrZ6BjHPhVvluD2TRjDMXIl4Osi4WrCoXumLy0Kkssn6fxmJvEVQ>
 <xmx:nAyrZ3jvW_mfL00igIcQ4wiQoDzU6k5z8-Wts7wl2lvL9UkJMZk-dg>
 <xmx:nAyrZ2pi0RgOL1IvpaxlIf0geZor5Q9tEZZnJ2Xm-7HkRQXKoDYgIg>
 <xmx:nAyrZ6i058dDKlId73C8vJTTJKGQQzk93fpXg66g_HVuDvbx9h8DGQ>
 <xmx:nQyrZyVCfvKGyU_2jj4jVUAAd4lO0wUIyFUEuu0_krsSZQDa_Zn7-CCN>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Feb 2025 03:38:51 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [RFC] git: consolidate .gitignore files
Date: Tue, 11 Feb 2025 09:38:49 +0100
Message-ID: <1760201.izSxrag8PF@thomas>
In-Reply-To: <20250210172050.8884-1-stephen@networkplumber.org>
References: <20250207182634.168820-1-stephen@networkplumber.org>
 <20250210172050.8884-1-stephen@networkplumber.org>
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

10/02/2025 18:20, Stephen Hemminger:
> +# ignore Linux UAPI kernel headers
> +kernel/linux/uapi/version
> +kernel/linux/uapi/**/*.h

The original .gitignore had some "!" for an opposite logic.
I think we can just completely drop this one, it looks unneeded.


