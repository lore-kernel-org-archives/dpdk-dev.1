Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FE4C83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 13:26:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9AAE4021E;
	Mon, 21 Jul 2025 15:26:17 +0200 (CEST)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id A07E44014F
 for <dev@dpdk.org>; Mon, 21 Jul 2025 15:26:16 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id F41CB140007D;
 Mon, 21 Jul 2025 09:26:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Mon, 21 Jul 2025 09:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753104375;
 x=1753190775; bh=bsdiDvS2RMAq5BWeoXPlNQidBOQ4BMGI/unAtVqan6Y=; b=
 t544nQgzvI6cWI5AYiJXfemBWiaoC85vqa+KArMHF74qMmhcE9eh76IFXESjvRNN
 NiXOEly+eP5A/jBJs9Wvv5XHXyCpXHjtZvNedK1sZOi6V/x+2xU0aOsThSayibhX
 teYQ34KwxEmPGpHKpN2hJ0OAuT7Oqw4BBGWdXZrz9Jo8Y94IqZJdlxOhr9EPn2xw
 BR+KFdUQWyyU5r/+g+2tPHpTFnB/7dJw7MRc/UU4ZvlCxG2Y+Jfqm69iLm1eY57d
 ctd+4HPDzuq8urQ1F0aPsIgMCQc2nVAvXZ4l1zu//t+07B0UNzLyW/ORGjnzrhuf
 LtnLgHvQeMlEvtWxShgekQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753104375; x=
 1753190775; bh=bsdiDvS2RMAq5BWeoXPlNQidBOQ4BMGI/unAtVqan6Y=; b=Q
 pXwax+dV2Xmrhs9X+aHwoKORtSoqhPKGr75JlV2AMle76pE+AJjrjNs8JTfdPuYO
 PWAjj4AMe8REoMagjEXjoy9E7aDalag43NXIa7XchzpAmK5scSmKL2qBAT878NWQ
 oz7oZWbgqfAhZpOvQfmdkRVCsBr6MH/mSi4kqGDPYue1eGgpyukx+hQGaJn6bN5f
 Y8LxPlgO871AXA7HmSenvIln1kL7itlvSkevhJFHwrjvUs7NjHh9gywUjZQ6CtYQ
 ZMeg6BxsHozCoOrDOqzbB0xktJnqg2zJRNlqDnWg1r40F3CvaTy/bKGAbu6qUazv
 LuAM7teaq0HaQDyGkUGwA==
X-ME-Sender: <xms:9z9-aMdo1E5wD6aPG8Xk4_u3UxIh8XqL0H5qgK7UOQnd_JmrZUTlag>
 <xme:9z9-aO81ffadCCseyOva0HZyB4leQiYmoYwues9_Od7VZobFaZ4M8YnPf5mduxV9G
 jep8CekKe6hfggM_w>
X-ME-Received: <xmr:9z9-aJrPSPuSsBPIhc4IuKSphvRMlCDHrSlmnrMTtGzO_Fw_YMuJh3CLhm_e4KDbRjmLJdsXX1URq2UFr3oy18vk7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvddulecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepgedttdeljeejgeffkeekkedtjeevtdehvedtkeeivdeuuedvieduvdel
 veejueejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepiedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugdrmhgrrhgthhgrnhgusehrvg
 guhhgrthdrtghomhdprhgtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihshhtvghm
 shdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopegsrh
 hutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopegrnhgu
 rhgvmhhuvgeslhhinhhugidrmhhitghrohhsohhfthdrtghomhdprhgtphhtthhopehroh
 hrvghtiihlrgeslhhinhhugidrmhhitghrohhsohhfthdrtghomh
X-ME-Proxy: <xmx:9z9-aDA3hWT0jHt-lK4Jr95THCVMcLpNfUCPDaA5IAtosH2ce7CyOQ>
 <xmx:9z9-aLyjW_u3vVobxi2NYd0G4JesegKo2UUSG_V_2XKTQhnaJH3ftw>
 <xmx:9z9-aA17sz-V24YWve8XxOn3MZwmz_MlxAsWG5nT7WXbYy_81RidsQ>
 <xmx:9z9-aLyApKS0QuTH8SaJpL90YoUFqi3moDsEPYJkLD3YbTfNnuXKXA>
 <xmx:9z9-aFWm9GnNCcG1qgKfxagseSlm5qabc2gz4k3MB9VKT20sIf6truqz>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 09:26:14 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>, dev@dpdk.org, 
 bruce.richardson@intel.com, andremue@linux.microsoft.com,
 roretzla@linux.microsoft.com
Subject: Re: [PATCH] devtools: forbid use of compiler pragmas
Date: Mon, 21 Jul 2025 15:26:13 +0200
Message-ID: <2928176.88bMQJbFj6@thomas>
In-Reply-To: <CAJFAV8z-E7MMdx=W3XVp98=wffDtSd=7X3QyG=vfFV4L+=u-UQ@mail.gmail.com>
References: <20250130083741.3258965-1-david.marchand@redhat.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FA08@smartserver.smartshare.dk>
 <CAJFAV8z-E7MMdx=W3XVp98=wffDtSd=7X3QyG=vfFV4L+=u-UQ@mail.gmail.com>
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

30/01/2025 09:52, David Marchand:
> On Thu, Jan 30, 2025 at 9:45=E2=80=AFAM Morten Br=C3=B8rup <mb@smartshare=
systems.com> wrote:
> >
> > > From: David Marchand [mailto:david.marchand@redhat.com]
> > > Sent: Thursday, 30 January 2025 09.38
> > >
> > > Using pragma must be prevented to avoid breaking builds with other
> > > compilers.
> > > Let EAL use them (like for abstraction macros).
> >
> > You are only allowing them in rte_common.h.
> > Do we need them elsewhere in EAL?
> > Not that I think so, but the patch description could be interpreted tha=
t way.
>=20
> Ah yes, I forgot to update description afterwards.
> I can update when applying.
>=20
> >
> > >
> > > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > > ---
> >
> > Good idea!
> >
> > Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>

Applied with updated commit log, thanks.


