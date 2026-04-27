Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB50DFF8868
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Apr 2026 15:53:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACFB040611;
	Mon, 27 Apr 2026 17:53:18 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id 57325402EA;
 Mon, 27 Apr 2026 17:53:17 +0200 (CEST)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfout.stl.internal (Postfix) with ESMTP id 68CE31D001BA;
 Mon, 27 Apr 2026 11:53:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Mon, 27 Apr 2026 11:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1777305196;
 x=1777391596; bh=LGnUr6iIdQvzFIxi35alGaHIkbTxjpPfHchygpolIBU=; b=
 cmNWB+1URN+nQe/mS5UqIPBpxIhhoaHOPGurjQsbNwAsdYnS4JmPfUoDX4Jjvg+l
 CFBI42cUDqVhFLgGP71zUzLAl2P1ZS7vTROanxXZ823Aay1vn9uvjHVQlGxv4eYk
 b76PAJg3aCor4ykIzdSwZRV7DDCH7WqBbTDG63ITkxxzQDEWftikEHdzaRWY6QEY
 O7qml21xny6msWKo13AUDRFPXC0vwnYPgkvpHWqsyLveWVnj+w3F/3NK87xkzZV7
 ysUqSFxRakx29PfJZUcvX7EJQgqmGWx8jiE1J2QfD0hFN1vMt70I+czJcWyyZYwT
 r4AzVsEITrMt2T+Cxswsyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777305196; x=
 1777391596; bh=LGnUr6iIdQvzFIxi35alGaHIkbTxjpPfHchygpolIBU=; b=e
 4D3/xifpMrDOKx2CNj+te1A8ef1ff21rUNB/ZlsYlhZmTEOXGGuuZrX6GGvR7Id9
 Wk+mbwqSATKwMVECn+thyPFyq5a8uvL2hKANk9f/TH4qGywkSgeA9PGSYMEjL0hT
 vW8SYcRDFQiWrVQZro1d4/iPRo2bTcWR00KPt0g9ebzS5NCK9CouCSNqme+05Tw2
 aZO63jg8/UwJpscw0fGRPPBTqEB4vbolcZQGS+J07iDQEWgW66z/dsbK0/GUFzfb
 hG+DtEYxFq2/vCKf+xhH6tFLJC0VflsTNzYlNv0aSDXOhGy6IAd2wh9omYtVHCme
 RozcEHKNMyMdYtVEWrbPw==
X-ME-Sender: <xms:bIbvaSoXZB6qwQ75jLXDVnMXwOxhU7eOkXGBaEkSZYYQEay2wj_n_Q>
 <xme:bIbvabm3VTMk7A-vDAxjzS9VJBQCRTwwMypNKs7H9IQDOk5dEqddhyE5k1pd5yf0W
 THy49yVcqiXUUaqNWVSjRdnENvZEFNg8qOV6hytIl36sWf21cNwvWE>
X-ME-Received: <xmr:bIbvaWPmI7l32vj_5Lyo6uXcsfOIf5I-JmRLVzi6IjJvfaHyQxwjt0EeePqYZbtuah5uqZfvPj_qFUyfo8WGeQ2NDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejledutdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepjedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugdrmhgrrhgthhgrnhgusehrvg
 guhhgrthdrtghomhdprhgtphhtthhopehrjhgrrhhrhiesrhgvughhrghtrdgtohhmpdhr
 tghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepghgvthgvlhhsohhnse
 hnvhhiughirgdrtghomhdprhgtphhtthhopehsthgrsghlvgesughpughkrdhorhhgpdhr
 tghpthhtohepkhhtrhgrhihnohhrsehrvgguhhgrthdrtghomhdprhgtphhtthhopegslh
 hutggrseguvggsihgrnhdrohhrgh
X-ME-Proxy: <xmx:bIbvaXMOWFGEs1geohNkFI66d_BMXmCrU79LGcWNSkaYU16P6Gs7oQ>
 <xmx:bIbvafhUwbb1QhXMaCzdhjulda7SxXF0EUgrUiwTVDRUTA61bZ-B8g>
 <xmx:bIbvactr93Vozy_E_uchgWJLX8WQVoXF1H7GpkalnRJ_vXjAKPpB8Q>
 <xmx:bIbvadQbCjZOde5KBIkJQeC9J6SifvO5pukvwnd-VzdEIbpYe2Xxww>
 <xmx:bIbvaQE7dL65oL_OEEKoT1Q6SY6yJbL92YdzVr3RLDx59kbAkqp796AX>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 11:53:15 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>, Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, Gregory Etelson <getelson@nvidia.com>, stable@dpdk.org,
 Kevin Traynor <ktraynor@redhat.com>, Luca Boccassi <bluca@debian.org>
Subject: Re: [PATCH dpdk v4] net: fix VLAN packet type
Date: Mon, 27 Apr 2026 17:53:13 +0200
Message-ID: <40394769.10thIPus4b@thomas>
In-Reply-To: <DI3VM171VBSL.3E3J3C1HJ1GZG@redhat.com>
References: <20260422102814.645299-2-rjarry@redhat.com>
 <CAJFAV8yAhr-iXkn6JvderT_Yy4rB91LVWqYvwRqJH0DdmNkJ1g@mail.gmail.com>
 <DI3VM171VBSL.3E3J3C1HJ1GZG@redhat.com>
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

27/04/2026 12:47, Robin Jarry:
> David Marchand, Apr 25, 2026 at 10:40:
> > On Thu, 23 Apr 2026 at 13:25, Robin Jarry <rjarry@redhat.com> wrote:
> > This is untested, but what do you think?
> 
> That looks correct. But you don't impose a limit in the number of VLANs?
> 
> I don't see any good reason to support more than 2 stacked tags.

Look in the mailing list.
I remember it was to limit a risk of infinite loop.


