Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF27ACD6E55
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 19:56:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EB0B4042C;
	Mon,  1 Jun 2026 21:56:18 +0200 (CEST)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id 6AB6B40150;
 Mon,  1 Jun 2026 21:56:17 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 9FB7F7A00C3;
 Mon,  1 Jun 2026 15:56:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Mon, 01 Jun 2026 15:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780343776;
 x=1780430176; bh=u0yuveXEeSVDx4hq6KQD8dlkYoukKcZqU2uk2nA/Cnw=; b=
 OtpxWnK9ycEoD3AbsVaf+vsXLKIIgFcY5W2vEezWytMqb2iOYU+D45exsQhm50vO
 7kLFelyC6fDwFlFNGs3dvK9oOr6d20MDMihppvNrW/eNfFRv78WeotSYqJWRaHhD
 rZVSegmVXzKFuwrALn2izI8bGPKofyknzm5Xs076fI7yQ4Am7othKxuIzk7mfg6D
 AxjH9ViT+kv8mcM2fbxrknaC8tSqo25MQNs0ZnPF8E9JP6T0u/eCXwNrYl50I6Pb
 bUvK9xmuYy7CVQwB4Kj7A5LOQDaKFoUW25Z4EjqX0OUPoZnwD8AYpPEyMua5dFyn
 Pn6sINshrWSsR5ZZ9JH3ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780343776; x=
 1780430176; bh=u0yuveXEeSVDx4hq6KQD8dlkYoukKcZqU2uk2nA/Cnw=; b=G
 TbusQY/WM3lzThoZcxgTy4LjDWdQc2asyS8jDOVUoBszePEFf90q6O/CYg0O0zm+
 63DqRWygRyJkQRLOJhorBQHmyUhN5O7PQF4OOWXhApYQF3dN1LCG3KRwReTEC3rH
 A/uCQaRZus02kvRlvlws5qpgIHwPNDzSnAqATDgfhBSdQSkAfzBZh6daTqe5Cvtj
 tEtkiw7jKdGowZWebr8SUPDNf99qm6aUN5yGjhxxBdl57NNf+52LvFtm+qFSvyTW
 ymFZBxQtwJz4G77HhxvbYkmUeXC6arByX6Uf7k8W3v+HeTJmPEFZHCVD/4ew3VVk
 XINx0iyBXB26m30XdFwLA==
X-ME-Sender: <xms:4OMdagWVY9cwaJFjR2vo5fVnbs12hinhadkfkO8nH5Np7rxV8pWkAw>
 <xme:4OMdaktydu6HGHk_IL8eEBI8Fli3JOUlZ17kwByTqaxoXlbBLI3IJf8RJ4666Dors
 KEfOCyfWt5rpnXqRGBfQ6gHPNu4K3vdU2O97cHl_6um_7Gy6-eR>
X-ME-Received: <xmr:4OMdasUVFchb7EBaPtxCqMsFo59FmX8fBhnrrDFcVSiudnVdJqmT32bEpi0kzApcW85w94B6U_rvPG28V4eH7cRp1w>
X-ME-Proxy-Cause: dmFkZTFFjl7ZTL1fn4c4hMR1gWX0eZ9vxwSFRSdJ/5ENFkHoyZJyKuNLfYX57YjbymTFQV
 kyJVsKWUw/mnGWPwI4p1y/+y0H8jJ4vHX8DuS0AnG4Qh/gjZph7213oPMvyTcIgE5i9NOr
 lqN85PHH+QDT6KmsT8q43puBqWRu1zGnNWx1tjm62h0peJEFBmtd/+ag4+MrrwKlAxb41p
 HnSzERxZui2NnKqhyt6nB9ypgSbHi73fnM7lfm/gMD+Y5fCdG4Kd8xKfsZ1EN3foVchiFk
 2zu6RwAlZbT0aBECwPzEiK038lYvZedEAb0r1yRd4EZiYnodEz0JZ1q3/0+Enuno/VDORl
 dlnYpiDAkF4f+xmyZj5jig/EdHFPvF6j48F7Ha5JrggkJPY5YgtE2ojloSbVmrgjq5WcBY
 Vva0CmssV6Jo5h89l1X6oAA2d9e7F0SkzjC8RgK58bdmaGdV97iy2ReLrFIoZYM+WGb7uh
 5eKYzMszk3/suPgJDoO6UrZsS3L1zJ2NTZLM/Apf+oouvy9tFFKDc4QorjgvgKfL84ES9M
 VE7GfMSp2y6EBZxPw+U0/LvTcCfgMdLgP2EYU5oeP+//Jd5O4Ndy1VGFQ2WavToPrpk3Ec
 XmEsj7XtmZlHDDqIWt6/kgK3SGGQAoKbR7RIRAXJ7qFIzlFGR4LdzO1eXHeQ
X-ME-Proxy: <xmx:4OMdankDVG2odDX8rcPY0vdWfaOgBhtgAjHI9VJCOjpmMEvEylducQ>
 <xmx:4OMdalY-WpceKRrgJ4mwZc-KLTtTyuYcP2USEEBwAUkiGlTOrbLR6Q>
 <xmx:4OMdaqPc1Wmb1KK3S26kbyMxLMOt_GjmKTwgWIBbIquVAgaQwsoUZQ>
 <xmx:4OMdaiaZzqEbL-Nb9oK921N60iU4AQ7zkQjMvbDYN6Gfx01uGM0BAQ>
 <xmx:4OMdapj0hdgTWe5Yo-uZfYeP3r773rPmWzoAwuzsh6f02HX3ZcLdUNax>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 15:56:15 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org, Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH] ci: update versions of actions in GHA
Date: Mon, 01 Jun 2026 21:56:14 +0200
Message-ID: <9jg6Bj5CT3KabfWlrZorig@monjalon.net>
In-Reply-To: <20260511161116.18652-1-david.marchand@redhat.com>
References: <20260511161116.18652-1-david.marchand@redhat.com>
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

11/05/2026 18:11, David Marchand:
> GitHub started deprecating GHA actions based on Node 20.
> For now, only warnings are raised, but we can switch to more recent
> versions of the common actions, now:
> - cache v5
> - checkout v6
> - upload-artifact v7
> - setup-python v6
> 
> Link: https://github.blog/changelog/2025-09-19-deprecation-of-node-20-on-github-actions-runners/
> 
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Applied, thanks.



