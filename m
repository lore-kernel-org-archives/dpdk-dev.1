Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6FBC021B2
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Feb 2025 08:46:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F06FC41143;
	Sat, 22 Feb 2025 09:46:39 +0100 (CET)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id 3CD8D40649
 for <dev@dpdk.org>; Sat, 22 Feb 2025 09:46:38 +0100 (CET)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id 9B7041381097;
 Sat, 22 Feb 2025 03:46:37 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Sat, 22 Feb 2025 03:46:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1740213997;
 x=1740300397; bh=nbWK9lDU4TCloEuDNj1Hliyblk9wBARYkSZW8zllTRY=; b=
 EGLEo3gK7cjXJllPd6lbV1hWPTV7FHviylor/w2Fj+vsc5nht6/Ap/sdixAOrrHm
 OIii6OBseeyagsMG0trtg0+q/U3O1YETMIxRm4Zv/ZTNKCzBfyeWCGM0jt3uKhZ3
 EzKOrxoJOIMGQVh0rrIPvCfZPXePjN+VF7hp2YoKCeGrVrrNgB3C0Ip+npnpwY8Z
 OBUdPVajle4CANh8/HEJuUGTazQaO0BumYfv+tgAADIp4lc6v+13QKjukLT6Bczt
 CIJCqpWkP/FUSFlOwkkRwuFQ8YER4opprkkKEfXZA2sb2SeWwxn5OnIe1+Qbb5M1
 J78rKutafsFQLOtAZAOo5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740213997; x=
 1740300397; bh=nbWK9lDU4TCloEuDNj1Hliyblk9wBARYkSZW8zllTRY=; b=2
 aHErRH01VytXh5FkKEok8GcONqL6D8Uf5vHcyAEJUTqD7S/MuqZnH7K2hULvuNTn
 bGqOSIw37HgqHtg/uwvegL/vMNyXkSajhS2iqGRHRHIURKRuZRmzFPIu8+15vGew
 nSRHtg41LKkIa5XQcbsAjwwthlVOZJZdLvSePY727/jGcYuNIA0vZU4QwjNES8PQ
 qnFp+5+PuCj1zdjeZE22WY0iKiRRPuWpOTvnPED3BB1uReMYgl3jiRK5dzw3ZM6m
 GexE8eeJ5PfV4QiZhDxAX+lc+HYvNh31F3YACzffs5Vmz0wYGO3ScFzEhWXXubed
 7b4O7zGJvF2rwkOIcQxxg==
X-ME-Sender: <xms:7I65Z-zVJ1vYC-tAJZDDDtuzhzNH6ikAt0Rl8QRun4-DYTVn14wrbw>
 <xme:7I65Z6Q5rr8YlxIRLlak7CNyvpbsik2xEJ4qz6tb6BMdz2_f5FAItbA3SdqXo00eM
 qVnc1eKDynO6L63Qg>
X-ME-Received: <xmr:7I65ZwU7iHdza42cxlFoEGl-hBHOhhufUpyDTlgjpDOqbljkYrtZF7lpnCpxrmX5-hJIvRehAyjaGCJ3TbsuFnVpMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejvdegiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvg
 hphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhgpdhrtghpthhtoheprhhorhgvthiilhgrsehlihhnuhigrdhmihgtrh
 hoshhofhhtrdgtohhm
X-ME-Proxy: <xmx:7I65Z0gLh014rW2Mlcv2miN2pj5CspCAtMEJh7xoHCbEQmxeLUbNfQ>
 <xmx:7I65ZwBCRmnQ0z3a9EIbRSx5ssxx7qTPy0fFdBh4vBKwXVNGD7coSg>
 <xmx:7I65Z1K2HEs3pSUs7115fDNrzk5Iv2ansvDiP79-q6fYyzpskMAFrQ>
 <xmx:7I65Z3DePGl4zWQ2UrA-bcZxJjGWfLlCdmHFEgMIAbHyMxvTjrCs3A>
 <xmx:7Y65ZzPUcrHOJlZpXJN-FOmZsyYa-wMw8dsTduxZUZaEPx65WAbf9Qfh>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Feb 2025 03:46:36 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v2 1/7] eal: add queue macro extensions from FreeBSD
Date: Sat, 22 Feb 2025 09:46:34 +0100
Message-ID: <4310569.Lt9SDvczpP@thomas>
In-Reply-To: <20250221150545.2ae330ba@hermes.local>
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <12279496.nUPlyArG6x@thomas> <20250221150545.2ae330ba@hermes.local>
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

22/02/2025 00:05, Stephen Hemminger:
> On Wed, 19 Feb 2025 15:55:17 +0100
> Thomas Monjalon <thomas@monjalon.net> wrote:
> 
> > 14/02/2025 18:20, Stephen Hemminger:
> > > The Linux version of sys/queue.h is frozen at an older version
> > > and is missing the _SAFE macro variants. Several drivers started
> > > introducing the own workarounds for this. Should be handled in EAL.
> > > 
> > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>  
> > 
> > We may want to unify with lib/eal/windows/include/sys/queue.h
> 
> Do we want to just not use the local Linux version of queue.h entirely?
> Maybe just put in current FreeBSD one? It has lots more useful variations.

Yes but it should be global in EAL, no need to duplicate it for EAL Windows and others.

> The point is to avoid broken versions (like one Intel driver) or
> having same macro in multiple places.

Got it.


