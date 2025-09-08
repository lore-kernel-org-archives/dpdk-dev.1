Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7CBCAC581
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 09:41:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DC9340264;
	Mon,  8 Sep 2025 11:41:22 +0200 (CEST)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id 38809400EF
 for <dev@dpdk.org>; Mon,  8 Sep 2025 11:41:21 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 5A6AE1D00117;
 Mon,  8 Sep 2025 05:41:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Mon, 08 Sep 2025 05:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1757324480;
 x=1757410880; bh=W0lB3GitWUwqiM4urR7EV6Yiz5Az5nlqwzR/Adh283U=; b=
 t08FE3lI1tTiaQViBzkfnbLI7gwKPA8s/KbJs1MOSbn3t1AHb/OifGhtP2dDzkVy
 KzRLtbDoll9oe6nB5ZQxuhDs73YcGr4oT6fchr52aIj3MAWVxVTqqFa4U7UKUOIa
 8yCc5iQ5RG/xxHgGX7cF/vJiUuLEfMnH3wIOcs9FaQXuGrlhx0pLzhNWk9gTbDm/
 kzkN15gzGfITjhN5H/uBRgJVqiOlEuCBqps6NUFpZPWdgFgtCIOprFhLZ9CFddzm
 5byds04HhqGuqmos2B4C3v/IZ+u9o1vxeHkeloNR8xY+pPbngA0Mmds2Y3M1FSP3
 B/dYAalGMVce26UOs038gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757324480; x=
 1757410880; bh=W0lB3GitWUwqiM4urR7EV6Yiz5Az5nlqwzR/Adh283U=; b=I
 VID/HYGMXVN1mK8nCOZKCbVNdO2OahB84RSyebruj+fNxt4KzTOHkqCGyY5oYadk
 PLnbFHHgUTeMg9P0ll+rtsmq2IiS+m0TIhDGKsPlqWFQ9RkdmI4BinLPGiZK7ELp
 4aaS1okN9QPdqDSUo5zoav9V4BsV6dKrixqAWMmMUSwb8kgg2zM61p+5VTlAqb43
 K0JPSWCUjGvs2l1nkTy/OZ5G21VnSkze6xz5ivmYbWaDWJKsdQbT2w9lF7g2sQas
 OsEHDHj9puQTS3p8XOqlOXlOv4WY+OUv3n8Vs0gvJBw/XGcCxTDjmlaqs8Iw3ruq
 A1WmoE7j6A5EQRFmSoRgg==
X-ME-Sender: <xms:v6S-aLGFqwc6YAVz501fwTCnp0MZj_blf9dEUMZvLW85p73cnLb6Rw>
 <xme:v6S-aNn7TyqMZPBAezgSbE8_4PtiKnmPAxLjqcqqOnV5-zypSH4FfbzQ144EhQJJw
 Vvs2n-PYrfOwLjxlw>
X-ME-Received: <xmr:v6S-aO3Q8hJoq9AK74cJxrYYzwAH_czuS2VRMuECjTNcOZGnbbN9oCyGknXCwrz0W4hoCPnM9U_aERiJTQkJrJ-b8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedvtdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepvddpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrgihimhgvrdgtohhquhgvlhhinhesrh
 gvughhrghtrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:v6S-aBTZ3I3oRj7Q2dsd6bc923RJBJ5HMLt85m63_f4xs9NDq_nQ8g>
 <xmx:v6S-aIuuWnDA5x3fmVayRjoVSzvSFMmIvrrKNEGPpkZgm9t42vqj-A>
 <xmx:v6S-aOawV6vqOWdhvUmjrug3bCyiauMtuNFQGtPI-0llVTGctiQe0Q>
 <xmx:v6S-aFvh5OIWKrnTh2sfjAcF7EgxmOMRDLOspbgiQghMCbNh_iAc3g>
 <xmx:wKS-aFTE88TVNceZWSwBPmYjPookrBevZRZE1Ol5le8tPayjtlRF9k86>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 05:41:19 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 6/6] devtools: add quiet mode in uAPI script
Date: Mon, 08 Sep 2025 11:41:18 +0200
Message-ID: <1930733.tdWV9SEqCh@thomas>
In-Reply-To: <d7b7fff5-8f0c-424b-ba7c-837a16e6d4ce@redhat.com>
References: <20250827082413.1417226-1-thomas@monjalon.net>
 <20250827082413.1417226-7-thomas@monjalon.net>
 <d7b7fff5-8f0c-424b-ba7c-837a16e6d4ce@redhat.com>
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

03/09/2025 15:54, Maxime Coquelin:
> On 8/27/25 10:21 AM, Thomas Monjalon wrote:
> > Most messages from the Linux uAPI script are not useful
> > when running the script in a regular fashion.
> > The quiet mode (option -q) is added to output only error messages if any.
> > 
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> > ---
> >   devtools/linux-uapi.sh | 26 +++++++++++++++-----------
> >   1 file changed, 15 insertions(+), 11 deletions(-)
> > 
> 
> 
> You forgot to update print_usage().

Oops, I'm adding this:

 print_usage()
 {
-       echo "Usage: $(basename $0) [-h] [-i FILE] [-u VERSION] [-c]"
+       echo "Usage: $(basename $0) [-h] [-i FILE] [-u VERSION] [-c] [-q]"
        echo "-i FILE      import Linux header file. E.g. linux/vfio.h"
        echo "-u VERSION   update imported list of Linux headers to a given version. E.g. v6.10"
        echo "-c           check headers are valid"
+       echo "-q           quiet mode"
 }


