Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4D8606D822
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 11:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=nXyF/m9Q;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=rsA1HkJU
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DB3E40281;
	Wed,  4 Nov 2026 12:40:56 +0100 (CET)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mails.dpdk.org (Postfix) with ESMTPS id D58154025A
 for <dev@dpdk.org>; Wed,  4 Nov 2026 12:40:54 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id E46481400141
 for <dev@dpdk.org>; Wed,  4 Nov 2026 06:40:53 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Wed, 04 Nov 2026 06:40:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1793792453;
 x=1793878853; bh=iz9YbxdWG9aDdDRpVNBb/kmnJHXQn3bI4pvuKW7Dqs0=; b=
 nXyF/m9QHb9ScSvdCNL5CO76munveoxcnLtZPLXRH9rBfu/DVL7epcn2aD5HxLHn
 NJV9tTmKb5XtaHxvf9WhhtXyBYdT++yfy1JNF8wmEIDJ3W+oYLiBRY/XC61uKEpv
 eizkRDv+GvwBVIQDjK+ltLvNufHQHDzRDlXZP9i+AfAQ0JpZaqnx17t3NzuE+F2Y
 qfE33/zkb+KmpXggOpXXURZj+eXPX5GVMqU7ApPXLv5vpeBIYVQUGbzGC9qAKXoD
 YCNs4ek2IwTKo5MPRdAwVahJUbaC7REVbzeB24iokWKKbexPDaN0uUg6InQqbqzY
 RgegTUWpu0L66Rr+kk+huA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793792453; x=
 1793878853; bh=iz9YbxdWG9aDdDRpVNBb/kmnJHXQn3bI4pvuKW7Dqs0=; b=r
 sA1HkJULl8fBwD+KsozFnAy3qSaHekb+L6fDa5NPpwZUb8c1FI5shTDHG340xfiO
 HW2cu85i5orCAr6nf33ybFXnV3qiBT5NGhKjgz4/KUZw+LDd9YyfZZAJh0yRxzaC
 FtFqFFKZnH4QD4Tq5up8Np6Rb7Yif4C7I5qQK5sfUvFbq1YLEUuZ+/pKeBtMcAel
 nRjH0XmwX4lozdMuxPirqpSKKxajd75Nw2NWK39khvuoJMwbBoknFKq7YVXqdnoh
 2LKDA4/VeyNppLMs86BAKU9u/tBjUBqeP3Eh2r85Pk5p1AvgOTco1yuFKfa0rO1F
 BE1sa+TVfnds7tPVHAmXQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793792453; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:WqE367ib15DYlxLxyUdgYgQjNUstnNyMNe29mL7oaozwhnh
 NMV2aLvvoULMPTRUJol76SHenaJb456vHUm8kjoq6ULUjRylgtSbnT0YPm6LTNBy
 n4tleoney8oAnHzwFCB1OUCskOG5dpWqb+aWviNXZKsOuzDpqi5PFnFj+AvEZ5d/
 KAbMDhn+k6nszIggCmQOxzmdbz+bVa2B6h5cvUqB9fmswzfeTP72j39yCN1GBMsV
 a44chDu0fUjSUekAX4AG4NcNw6oKmdjtcr3rAZ4oGx2YNWgOhdaqgzoa6dddVveO
 0eFnu9lCKguuP4iKa8Kjal436K9/wKU7F2Cyu9A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:S6BK0Jo3mhUv2ZJFwhTBDKAt5JgatQVdF89c8pxAU3U=:ugPCfhDJZUUDK3+cugNfo5Qq/IkjYJtY/IBnB1Alq8Y=;
X-ME-Sender: <xms:xRnrasyxXiVRo9c0onNZ3dByXntAp8Ru-0b4izhKKoh5G1gIhrokIw>
 <xme:xRnrarMaT1yBR0jOZfPJxaExB_pu1w9LBoWtWzfK8zlkQDlznTvzuVMdTIUU3ETAa
 FuGPIiehkq8z2yzvUqMc9U82LPcuxo95X3dAiaEY6hJ3rj5g0AIlw>
X-ME-Received: <xmr:xRnratWmt0SH8RoAmxu_dJZYES7SeBBO2qBoc7hq2UmcJ_ZKixXUZ1f0p2Ooh_xmojos1dt3f8PCScRkCDyNFMQ>
X-ME-Proxy-Cause: dmFkZTFdtyuH8BkhviV/jTs3gRj3/QyUPXLDHG7ix/bq+VnqqpzHfOnawWUjZK5+Kf7pHW
 YkKDSv2abh/q2fG7ESbxsT6mbUhfzYnbT1JbrnSyOdboaCGONnv6LvcW3mju6HY//6195u
 RKfCG4kpP5VO2IY+kwjHPRr0CznilZ2xAj+C68nkt+N1DazIEc+cnL01B9MDCnoTirMvYT
 j18fWW2BAEUReZGN4SU+WkgIVGuqqkDUdB093vQ9Odv8nTGjCcIK9jXYMf9A19bheUtpdv
 qzvYkLU4hNFQ0uEZV40CSjryhkIvLJGGf51Y6zK99WGUivEzo04+Igxx8PJn58hlaG00pY
 1mCIUkv6c8i5CvnES85afdFFM+ng7cLV02HXyCfyQOHXv13TRpufkJTz1BGOPQOPzcJuU3
 Rsb5sQaw8izpJGaJJe6Xx3uiK5vp3Bk+vrMcu7WsHj8EJCzYtn6Z/9IsgUqYI85c6Zcb3/
 6GEitq0RAsUsd4AE4f5ZAsPoeW0+1OV+AIdgg9+B0U472CeG/S2zQczGRNUFMMCRGKJxPR
 hkngHrK3MKVeavTGmcGMNiJxHtcqpnKzgDWEeeVAKB/Msm1K6B0aYVrAef850+E38kApqI
 OXA9Rtvoi6/2TF/ApaGIbVS/So6rPWEwoyd1+Jqn9XmoaJneV1QY0dgEjF1w
X-ME-Proxy: <xmx:xRnrav1qP8N4KnLS_jUa5xhH2Ctu8hD6YccpZG3mGEtnwdxh4Z_4ow>
 <xmx:xRnrarq3nw5bF_Bx-ay5OjhL6imttLFU-STAyEVgOzWgoTkm-etgpw>
 <xmx:xRnramXEOfPlnbPfFiYiR3037iAtqySKMiOBOAsgncJy1nHrsUKRTA>
 <xmx:xRnramYx3GAL3ITcD7Dfn0Aqi8fneoglmjZAEpIz8hyPtIZ-hE_VTA>
 <xmx:xRnragGT2M6Ftw3-0e-iJPfh2yGJflscfDFJgOE11csXlvApNcoWm2Gv>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 06:40:52 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: fengchengwen <fengchengwen@huawei.com>
Cc: David Marchand <david.marchand@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <chengwen.feng@linux.dev>, konstantin.v.ananyev@yandex.ru,
 dev@dpdk.org, Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH 000/227] use NUMA node terminology across the tree
Date: Wed, 04 Nov 2026 12:40:49 +0100
Message-ID: <DxcOTN1IQyaIHHadU1FREg@monjalon.net>
In-Reply-To: <CAJFAV8w0rALL5A7BoewJRcEqY-=ZGyMONTTFbgo_OSuf3k7S+A@mail.gmail.com>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
 <7add359d-c77c-42ed-8e92-d5d496b8bcb4@huawei.com>
 <CAJFAV8w0rALL5A7BoewJRcEqY-=ZGyMONTTFbgo_OSuf3k7S+A@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

04/11/2026 10:29, David Marchand:
> On Wed, 4 Nov 2026 at 09:56, fengchengwen <fengchengwen@huawei.com> wrote:
> > On 11/4/2026 3:34 PM, Stephen Hemminger wrote:
> > >> From: Chengwen Feng <fengchengwen@huawei.com>
> > >>  905 files changed, 6113 insertions(+), 5439 deletions(-)
> > >
> > > Maybe a single coccinelle script would help here? Rather than trying to look
> > > at so many patches.
> >
> > A coccinelle script is a helpful idea. I will try to prepare one.
> 
> Well, maybe.
> But never a 200+ patches series again.
> 
> Putting aside the way it was submitted, it seems this change is only
> cosmetic, and it was not announced in a *previous* deprecation notice.
> 
> Why do we need this change?
> Why now, in this release?

I assume it is not for 26.11.
Chengwen wanted to fix the namespace of SOCKET_ID_ANY, adding RTE_.
And I told him that we should avoid changing this API 2 times
when we will want to fix the terminology
around CPU socket and NUMA memory domain.
I think we should do both at once.
That's why we see this big change.

BUT

It would be more efficient for such a change to discuss it first.
Then once we agree on the names and usage,
we should make it in a way it can be reproduced, maintained
and ease future backport of patches containing the new terminology.
A coccinelle script looks appropriate.
And of course, the patch series should not have so many patches,
it does not make sense.
A mechanical change should come in one patch.
If the series deserves several different mechanical changes,
few patches should be sent for them, not hundreds.

Sorry for not giving these advices earlier.


