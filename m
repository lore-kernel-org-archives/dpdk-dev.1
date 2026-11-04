Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBBC606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dx4SvSuA
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FA2040281;
	Wed,  4 Nov 2026 13:24:25 +0100 (CET)
Received: from mta0.migadu.com (out-118.mta0.migadu.com [91.218.175.118])
 by mails.dpdk.org (Postfix) with ESMTPS id B8F7E4025A
 for <dev@dpdk.org>; Wed,  4 Nov 2026 13:24:23 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=BhprX/jk5AEEIGl+HdnehjDI4Ez92wj2xmUkzwwViGM=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793795063; v=1; x=1794399863;
 b=dx4SvSuAL5o0zmxRSvDUKHvGnKoGKCgGWeqBsVFC2ymwu1dXWFRJXMkqYI050q3IvUrLBb46
 QW7gDaSjudPvjTo+KGdeXAbHWdm2jotH2SKZLF816U8RJKhQc8BVZsRcv8nW1J3jn6g83PjFn7S
 xbTe7beecPfILtdrpuDmaiCg=
X-Envelope-To: dev@dpdk.org
Received: by smtp.migadu.com with ESMTPS id c2383d9cdc1fe1b3;
 Wed, 04 Nov 2026 12:24:23 +0000
X-Mizu-Trace-ID: c2383d9cdc1fe1b3
X-Migadu-Flow: FLOW_OUT
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Wed, 04 Nov 2026 12:24:22 +0000
Content-Type: multipart/alternative;
 boundary="616e1a39-f6b3-4595-bf4c-79f449f424c4-1"
From: chengwen.feng@linux.dev
Message-ID: <d1d59364e8121f9eff7e4327fae083eaf11d19f3@linux.dev>
TLS-Required: No
Subject: Re: [PATCH 000/227] use NUMA node terminology across the tree
To: "Thomas Monjalon" <thomas@monjalon.net>, "fengchengwen"
 <fengchengwen@huawei.com>
Cc: "David Marchand" <david.marchand@redhat.com>, "Stephen Hemminger"
 <stephen@networkplumber.org>, konstantin.v.ananyev@yandex.ru,
 dev@dpdk.org, "Aaron Conole" <aconole@redhat.com>
In-Reply-To: <DxcOTN1IQyaIHHadU1FREg@monjalon.net>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
 <7add359d-c77c-42ed-8e92-d5d496b8bcb4@huawei.com>
 <CAJFAV8w0rALL5A7BoewJRcEqY-=ZGyMONTTFbgo_OSuf3k7S+A@mail.gmail.com>
 <DxcOTN1IQyaIHHadU1FREg@monjalon.net>
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--616e1a39-f6b3-4595-bf4c-79f449f424c4-1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

November 4, 2026 at 7:40 PM, "Thomas Monjalon" <thomas@monjalon.net mailt=
o:thomas@monjalon.net?to=3D%22Thomas%20Monjalon%22%20%3Cthomas%40monjalon=
.net%3E > wrote:

>=20
>=2004/11/2026 10:29, David Marchand:
>=20
>=20>=20
>=20> On Wed, 4 Nov 2026 at 09:56, fengchengwen <fengchengwen@huawei.com>=
 wrote:
> >  On 11/4/2026 3:34 PM, Stephen Hemminger wrote:
> >  >> From: Chengwen Feng <fengchengwen@huawei.com>
> >  >> 905 files changed, 6113 insertions(+), 5439 deletions(-)
> >  >
> >  > Maybe a single coccinelle script would help here? Rather than tryi=
ng to look
> >  > at so many patches.
> >=20
>=20>  A coccinelle script is a helpful idea. I will try to prepare one.
> >=20=20
>=20>  Well, maybe.
> >  But never a 200+ patches series again.
> >=20=20
>=20>  Putting aside the way it was submitted, it seems this change is on=
ly
> >  cosmetic, and it was not announced in a *previous* deprecation notic=
e.
> >=20=20
>=20>  Why do we need this change?
> >  Why now, in this release?
> >=20
>=20I assume it is not for 26.11.
> Chengwen wanted to fix the namespace of SOCKET_ID_ANY, adding RTE_.
> And I told him that we should avoid changing this API 2 times
> when we will want to fix the terminology
> around CPU socket and NUMA memory domain.
> I think we should do both at once.
> That's why we see this big change.
>=20
>=20BUT
>=20
>=20It would be more efficient for such a change to discuss it first.
> Then once we agree on the names and usage,
> we should make it in a way it can be reproduced, maintained
> and ease future backport of patches containing the new terminology.
> A coccinelle script looks appropriate.
> And of course, the patch series should not have so many patches,
> it does not make sense.
> A mechanical change should come in one patch.
> If the series deserves several different mechanical changes,
> few patches should be sent for them, not hundreds.
>=20
Thanks=20Thomas for explaining the background of this change.

This series was AI-generated following the one commit per moduleconventio=
n
 to support per-subsystem review, with the expectationthat these commits
would be squashed before merge.

I understand this split imposed heavy CI load now, and I will adjustthe p=
atch
organisation in the next version.

Moving forward, I will prepare a coccinelle script for the mechanicalconv=
ersion
and follow the deprecation process before formal submission.
--616e1a39-f6b3-4595-bf4c-79f449f424c4-1
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><meta http-equiv=3D"Content-Type" content=3D"t=
ext/html; charset=3Dutf-8"></head><body><div>November 4, 2026 at 7:40 PM,=
 "Thomas Monjalon" &lt;<a href=3D"mailto:thomas@monjalon.net?to=3D%22Thom=
as%20Monjalon%22%20%3Cthomas%40monjalon.net%3E" tabindex=3D"-1" target=3D=
"_blank">thomas@monjalon.net</a>&gt; wrote:</div><blockquote>04/11/2026 1=
0:29, David Marchand:<br><blockquote>On Wed, 4 Nov 2026 at 09:56, fengche=
ngwen &lt;fengchengwen@huawei.com&gt; wrote:<br> On 11/4/2026 3:34 PM, St=
ephen Hemminger wrote:<br> &gt;&gt; From: Chengwen Feng &lt;fengchengwen@=
huawei.com&gt;<br> &gt;&gt;  905 files changed, 6113 insertions(+), 5439 =
deletions(-)<br> &gt;<br> &gt; Maybe a single coccinelle script would hel=
p here? Rather than trying to look<br> &gt; at so many patches.<br><br> A=
 coccinelle script is a helpful idea. I will try to prepare one.<br> <br>=
 Well, maybe.<br> But never a 200+ patches series again.<br> <br> Putting=
 aside the way it was submitted, it seems this change is only<br> cosmeti=
c, and it was not announced in a *previous* deprecation notice.<br> <br> =
Why do we need this change?<br> Why now, in this release?</blockquote><br=
>I assume it is not for 26.11.<br>Chengwen wanted to fix the namespace of=
 SOCKET_ID_ANY, adding RTE_.<br>And I told him that we should avoid chang=
ing this API 2 times<br>when we will want to fix the terminology<br>aroun=
d CPU socket and NUMA memory domain.<br>I think we should do both at once=
.<br>That's why we see this big change.<br><br>BUT<br><br>It would be mor=
e efficient for such a change to discuss it first.<br>Then once we agree =
on the names and usage,<br>we should make it in a way it can be reproduce=
d, maintained<br>and ease future backport of patches containing the new t=
erminology.<br>A coccinelle script looks appropriate.<br>And of course, t=
he patch series should not have so many patches,<br>it does not make sens=
e.<br>A mechanical change should come in one patch.<br>If the series dese=
rves several different mechanical changes,<br>few patches should be sent =
for them, not hundreds.<br><br></blockquote><div><br></div><div>Thanks Th=
omas for explaining the background of this change.</div><div><br></div><d=
iv>This series was AI-generated following the one commit per module
convention</div><div> to support per-subsystem review, with the expectati=
on
that these commits</div><div>would be squashed before merge.</div><div><b=
r></div><div>I understand this split imposed heavy CI load now, and I wil=
l adjust
the patch</div><div>organisation in the next version.</div><div><br></div=
><div>Moving forward, I will prepare a coccinelle script for the mechanic=
al
conversion</div><div>and follow the deprecation process before formal sub=
mission.</div><div><br></div></body></html>
--616e1a39-f6b3-4595-bf4c-79f449f424c4-1--
