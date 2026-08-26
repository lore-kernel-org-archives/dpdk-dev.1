Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43786C61DC2
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 09:22:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F6914026D;
	Wed, 26 Aug 2026 11:22:03 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id 7B0D8400EF
 for <dev@dpdk.org>; Wed, 26 Aug 2026 11:22:01 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.stl.internal (Postfix) with ESMTP id D1B431D00125;
 Wed, 26 Aug 2026 05:22:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Wed, 26 Aug 2026 05:22:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1787736120;
 x=1787822520; bh=VkYTSjbHcWGzOhg7I7gqnxSrwWqYG3kn/A64kMj98H4=; b=
 Z7ZTqJ+Jof9HTssI+yL3j8Ea2vmIoA8wbSok8JCx3exvNWtGHc9ooOubh2F+B1a0
 hRsvhVZpFw90FJCse67EiUYl4jGZCOK279wyZWcjMKkrnCN0jK3zqMU1fYCFfruN
 ixnDEUZcPPAm6gaIicgOotfL1BQdl1TCDSelG4TUHhXjV2JdRFGaIDGFtQfQ8aiR
 GQkFa02ukPlxlM++SYSZKnBSv9yJLEl5CSSMymNJ+bp/HZwe40wcFGLAZYAHL67a
 nhQjzXvjZytjjFUM1QJ5v9Qnk+oPTZrgCgDwetnApZtXjnfUy7J+O0bC/JqOAg0o
 GsK12cssAwxj2r8S2Wv1NQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787736120; x=
 1787822520; bh=VkYTSjbHcWGzOhg7I7gqnxSrwWqYG3kn/A64kMj98H4=; b=R
 ZSwAjlV1KSU8i2fcfy7w9FGnEel6n8GkRywryW8dPNXcNyCix7JbWKTP6SNnACpJ
 mbdW3ZGgGUK6QErB7W+Pgc7h5dY7YhbtNH8PTozySio8hB53aIW+gCm/BFhkHgHb
 rRyRijdn/KIIFcHn6s6R84J6IcK/K+tFEIPs6lyP8sQM5XGSsycc2tV0TnVE0ERP
 qzcp0kGpX3EWQ79bsEl2mFJiY2X2keZzSz7WibDBgCQPiWk3BrooX7htN2rWozd4
 GdPifnQEYGTu78EYJ0jBdg3UzZJ1D0DV3ukCXCL/6yh/UuLZ3rYcEIL8RE0OjeNf
 rigpvVNsmXvfFt5/A+T7A==
X-ME-Sender: <xms:OLCOapeq9SMm8pZe1RADEPcZI3EuuCLoPFfH-tTVnA9WP5YF160xsw>
 <xme:OLCOanXNokaJFsRYIClxnuZWxBrWi2kyC7S8irfKttzYnTC4hHq5cJRu92agzJLiQ
 tP8pOgb2fUgOMKFm7yL_2nAKRUf3Zm2VMnOkmBtmAutxfQaonwjhw>
X-ME-Received: <xmr:OLCOaqeil6O_YMaaDqHAXKVWGim7Po1iLXfXJOD1oCL3hrOihKgBJxrJqRt4pz4pjBggmdoCOR82yN9Q57uR5AMrIQ>
X-ME-Proxy-Cause: dmFkZTGNf2HY34pUkEjlkU2RCPKHJdrV6/ayMFkfgHcvMTYB2RTQri+8bGWPi1iWpxQS9P
 pXq2o37G2ANVw+MO/y52Ow04cHEGTcMCNUaldfECbQHcYOee3twTbkRGxR6N+/LFK7Q4oX
 lZ99e+X645OypFcEJHWGLnL2d/V2CErRxZaUCKop2P20feZ/RJecEdttEzxnZVnOP1GETb
 ksgBUd79nSXIA+KXtt+S1TznCDNQC7XT+F1dBKTPBRdcaK1mN3mFOMhtDgqd6AWLyoM0vs
 Gj+HEYff45Yl3mm1YBnd3nlAzpQ/n+CujWYt0lo3nNsug4gv7ibNHiNESh0P0xm7HjZhBw
 2LZQyz7JesxPdlCHUwMkjWdr7HjpOVLDLSDU+mFlNrOBycHoe8vCQ4bLVfxhLFsyCz7MMM
 5Q6nNG+XqYATN/h0qs4JgGylPwJjLbnb6pb47ZtEFTRqQdBY2yIDikQNqX2S3WwMNR4hA9
 6ZjkCuHVNpNi1HcSFryFHvZRtzmG0KCuh/gIL7fP4IbjV2WNrP7+E9MlcTpgsvzR5krgR5
 L/ml/Ugf4TkmWTVtTAHYpNMPUZ0whqrGqrgAYbRLz6rn8HIW1sOca3X+JyqLyTttQDV9cg
 +3s9x8j9dQdFRAUT14kZQvuPOJ735jLAZUoeJLaGAi2/9A4Vqnx6KpZFDR4w
X-ME-Proxy: <xmx:OLCOarML1Qr69aCyBZaoxrzZp-jcEIP9E46h9nNrcZ3e_V126iBVhA>
 <xmx:OLCOagjbJnZucQIrZjwEX0einm2Bj7x802Mb5j-BoL8jVQEGpgHoGw>
 <xmx:OLCOam2A1OscGCp0X_e7WCK3GUJPCCNDJ3xM7r2FqSGD9J4uxCH7Pg>
 <xmx:OLCOaijSmexx9V0yJ85EyvVbVpAhYTRDwOvv51ODdKFApwSPRZQehA>
 <xmx:OLCOagaWO3hhNZMN9wo0Eh1OBwX8_IuotRawrhAWFbbsepvgxzMZo469>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 05:21:59 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Ori Kam <orika@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>
Subject: Re: [PATCH v1 01/21] ethdev: add flow graph API
Date: Wed, 26 Aug 2026 11:21:57 +0200
Message-ID: <nA_0NtHGRc2CE05D7MYfOw@monjalon.net>
In-Reply-To: <dcb80f5b-31e2-4f64-8d92-f4f4783393f4@intel.com>
References: <3284b12762de6e3b7791f5e3fa63c78b26ed5e6f.1787233987.git.anatoly.burakov@intel.com>
 <DPk1E-kwRJqv9GCxmKhBVg@monjalon.net>
 <dcb80f5b-31e2-4f64-8d92-f4f4783393f4@intel.com>
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

26/08/2026 10:58, Burakov, Anatoly:
> On 8/25/2026 3:55 PM, Thomas Monjalon wrote:
> > 20/08/2026 16:00, Anatoly Burakov:
> >> This commit adds a flow graph parsing API. This is a helper API intended to
> >> help ethdev drivers implement rte_flow parsers, as common usages map to
> >> graph traversal problem very well.
> >>
> >> Features provided by the API:
> >> - Flow graph, edge, and node definitions
> >> - Graph traversal logic
> >> - Declarative validation against common flow item types
> >> - Per-node validation and state processing callbacks
> > [...]
> >>   lib/ethdev/rte_flow_graph.h                 | 532 ++++++++++++++
> > 
> > Are we sure about the name? Why not "parsing" instead of "graph"?
> > 
> 
> Because it is intended to help build *protocol graphs*, not *generic 
> flow parsing*. I.e. only things that lend themselves to be represented 
> by a graph would work with this - things like conntrack wouldn't. So, I 
> feel like "graph" is a more accurate name for this, because this is only 
> for enabling the protocol graph walk, not for full flow parsing.

OK

> > Is it only for drivers? In this case, no need to make it a public API.
> 
> Yes, it is for drivers. It is not a public API, it is not installed into 
> public headers. If there is anything I forgot to do to remove it from 
> being public, please let me know.

You should not use the rte_ prefix for files which are not public.
I know this convention is not well followed for historical reason,
like rte_flow_driver.h should be flow_driver.h


