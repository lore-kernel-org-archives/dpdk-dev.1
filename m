Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2BCC982DB
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 17:06:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26763427B3;
	Fri, 16 Jan 2026 18:06:24 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 642024026A
 for <dev@dpdk.org>; Fri, 16 Jan 2026 18:06:22 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-47ee937ecf2so17755235e9.0
 for <dev@dpdk.org>; Fri, 16 Jan 2026 09:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768583182;
 x=1769187982; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vzncvLtyxOIiJYz6+Tut1qs0Z61A032va8wF02+b1D0=;
 b=klU9Hy1BKOdkaIViLbnb+jtIUY+RczxrkdYmm/V0n+n7yiulgTA0gpi4OnziO6TnZJ
 eqDNZEzTC6j5IP2ucvL/C+khL5qh8fd0R2qtMT5XBdCIfj7N3tOj9NLX6RvnNa90oRUn
 S/+tVeB/4vKT3nDRzgUkGEVIgRSNzQnM6gKSeG/9nQcLwu4N09uRRU0JQMaTBYd3XVfy
 lrzUzzsj+1yqxG3XkswXCIqn0ITGRm+BHtnvWG7I/8Xb27tDBGfnEuNLm5YFPoAP+NOw
 5KeLtC78+y0Vi4wzd0I0efo7Oj7QIvBSjGt5Hmk/lZ1zTdvmWRoOuoU3mSxJPmcl9wpo
 3Yqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768583182; x=1769187982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vzncvLtyxOIiJYz6+Tut1qs0Z61A032va8wF02+b1D0=;
 b=leGq6EegvtKGELvd/i28oEDw75zyRl4FJuzK0Zlf2FmRIVbk+uI42HSXTB+G0UXeNe
 FzuIarkSAz2/uDOJkzE01zhNmBBIuqFd/59XYuafAFiKdoFRuJenDh5Ks8hKupujMS3c
 elhjQMQFHOIh3sWzaplRVyHRDIrJb/3EKnL2gaFJ8C2lkhQE49jtdAQdjTi+Blly5STH
 tALFbYPu+4Mp+yLMqUqcWBXs4MVaFDATt4BBgBdWcGr99p6HTr7MUDj+4Jlu1lxKrBWy
 93slJTJoB4Lrrj9+ExladV/Y5AYftNEtwrO760kcOYNd8ZTzIPr8gRny9WtQ55OIvTPm
 c0BA==
X-Gm-Message-State: AOJu0Yw7J/LEWX/673CNmCwAxyjLqW8HNDRnsWXDCCrfXRLFpx2mjpVG
 UdlYVa1SAwYGIZqcHHvK0uQ0dyKaHdTmLNl+ut238FkSfLq0xnOD0s4J7YS37Moggl4=
X-Gm-Gg: AY/fxX7mu9sRMlIKS/Nif0IvgPGBhBNLF8du8XcXXUrRYg5o34rU72pp/6PN+PrRwiL
 f0hWPGw4pCFhsNmIMkBTug0oDt3YKAb8/IAxJ3ge+CvE11iADrcZTX9BoS3/mxeRvaOE8Zy4z6x
 mbwbnHgR2knzlm6fncthf9d1JtF1Z+O5Sz9HDjr+CAGdAPh0aaBDIJJS1SV78dSpfLUuiLSCqg3
 7+5FomVQmf5VKl8DBrzz2kpxYZYxC35wtTPaenk8RniR1c/Sd7Z+M3MoamDIkCIUwzm1GZHtJuj
 gTD0cWD9rfQc5BceYpuQ41FO4TxBRzac06JxSc82e7Nt/jGA04jmIZWJY60lkoy7yhDmcM9OC+Y
 IBRoLNc5y6QfM8VI7GiQ6Vakj4MogqQCWt1qNA7jLpHV9+SWIrlDcaGv6pI6/7scIo0qM6kQL9t
 6E2LNVfI3iiw6gIQyas1z+ZjTl5p3j8KCHo3DlPJ20J4U1Zg8xAneZ
X-Received: by 2002:a05:600c:257:b0:477:9a61:fd06 with SMTP id
 5b1f17b1804b1-47f428bf878mr51260125e9.8.1768583181814; 
 Fri, 16 Jan 2026 09:06:21 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435696fbea8sm6379370f8f.0.2026.01.16.09.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 09:06:21 -0800 (PST)
Date: Fri, 16 Jan 2026 09:06:16 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, stable@dpdk.org, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH v2] mbuf: fix packet copy
Message-ID: <20260116090616.52854216@phoenix.local>
In-Reply-To: <20260116111621.300891-1-mb@smartsharesystems.com>
References: <20251119120403.907511-1-mb@smartsharesystems.com>
 <20260116111621.300891-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Fri, 16 Jan 2026 11:16:21 +0000
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> buf: fix packet copy
>=20
> Requests for copying the at the end of a packet incorrectly returned NULL,
> as if copying past the end of a packet.
>=20
> When allocating the mbuf for the copy from a mempool using pinned external
> buffers, the external flag in this mbuf was not preserved.
>=20
> Fixes: c3a90c381daa ("mbuf: add a copy routine")
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> ---
> v2:
> * Improved comment about preserving flags for newly allocated mbuf
>   potentially using pinned external buffer.
> * Added missing spaces in expression. (Stephen)
> ---
>  lib/mbuf/rte_mbuf.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/lib/mbuf/rte_mbuf.c b/lib/mbuf/rte_mbuf.c
> index 0d931c7a15..a5d16e4c97 100644
> --- a/lib/mbuf/rte_mbuf.c
> +++ b/lib/mbuf/rte_mbuf.c
> @@ -675,7 +675,7 @@ rte_pktmbuf_copy(const struct rte_mbuf *m, struct rte=
_mempool *mp,
>  	__rte_mbuf_sanity_check(m, 1);
> =20
>  	/* check for request to copy at offset past end of mbuf */
> -	if (unlikely(off >=3D m->pkt_len))
> +	if (unlikely(off > m->pkt_len))
>  		return NULL;
> =20

I still think asking for a copy of data that isn't there should return NULL
not a zero length mbuf.  Kind of academic since I dont think any code uses
non-zero offset now.
