Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F0ECEACEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 23:43:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3E5E40281;
	Tue, 18 Nov 2025 00:43:25 +0100 (CET)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mails.dpdk.org (Postfix) with ESMTP id 95B664027D
 for <dev@dpdk.org>; Tue, 18 Nov 2025 00:43:24 +0100 (CET)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-7b22ffa2a88so3937926b3a.1
 for <dev@dpdk.org>; Mon, 17 Nov 2025 15:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763423003;
 x=1764027803; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PM6BJTYMe5TZq4remVl1Zez1wNGU4Daihh21CDMeK48=;
 b=d2GHAgqm/PgZEAYgdm3ZSpiPZ+PES4MshTfqGjbVdS7izegsmtMyv1bmAbac1JcEt6
 3eM76ZBvHwrv2wl6raG5aXjWHue9k9aKvu0SzneipcZLJKU8EDOLainwtJAK2RbooVvV
 YJZIxrQkkBzwB6Apa+w5gcfzRtsO+slTMvTqjcgdr9V7NLvWRv8WIUpsmtdSS3ply4GD
 yTjjuKIH79XvwhT5ydWpd5embP7iy7I3hNJKaHpSQ6BXnTXnMgkFkM4RRZfyAXY1F1Sb
 ftj8aG+Lif8tiO/aBLt//cQGm55yzdmSMN301A2CYCm2cUzoNm9+qS26zZPGQM0ij46B
 pmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763423003; x=1764027803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PM6BJTYMe5TZq4remVl1Zez1wNGU4Daihh21CDMeK48=;
 b=rMA1fSp6XdML990ltTUy1visQXZNKiU27oc3ooUv4BFYFg3rDosgcAOMSevxcdWpSa
 WwDvtPDj9LZEMhdtv0jlhjOeMvDZM0o1Ttej7DVw8eyvasElSXL/k6TTdwNZ/5Lgrvqb
 t8ryWTlL6kMAKN+1dJsQ0bjLj+O8XVQr2EXQNVT9KBFebhXZSOZEJwWLFlD58oyRtrRx
 afFsEM/GotsVxdUgwHqYtbZuMD2ZoecldOOwkBb2RYY6u/iBPphu4JA0nK3BtZ3FpsNH
 YxZmIZS5PO6Ir8ShMxiSwJtiGaUSdf6Kev8EqN4JJPxpKyfbmPB0I67rAWYrMu+W428X
 xLKA==
X-Gm-Message-State: AOJu0YwJYMJc3kOc3uMAayPDFJV6vMfVzhiFKbBMUIqJOCW+vDW0QMmQ
 vVhjYKx+RiLWYZZfPYXSTOQQ0dLKosATiFbiSp/4sTJ6TfvN3tpSe+50LCwDrc3BvpqiY/04CIY
 83qbL
X-Gm-Gg: ASbGnctmjdxSVG3q2ZFQpn0T/38MM+v9UIfrnDiZ89RrogxpQlknkVwCfoYMmwtNg16
 PHtzZlMoSXcXscZ152rLTi1qqkpelAhyBLJj6nP9aRMzyzB00E/7c4tFyDztqpLROQ39v3MWrwu
 5FpUol+gfxktfHefs/TlU6yThgrq+QlyTASjJyZruCFXvoMPLat6wvBp9hsJrhBMZ9DFxffnija
 jiuUxAEJtvcvf2eoLpYskhJNPnWp8KVACF0t+MfaNY9UwiU9y7a00hfAYkt2PVqYIHaFcnTuK9y
 9p5z20m1AEyQTR3YkITYv/rkS0kQmwIWZlX2J5+K2WH6kzXOPXfqKFI8WhhLEU0LJJ5Q44AjjxQ
 e7YGFi74tSh9bIEZoJkDDM4bqNuuDyBOcPFB5lkKEcNaHwNAexsbf1uNZhSfHFluDb8m/VHrdj7
 HTVOcKqLnwaQSIithZbDydbKIiuZQ0AnnjMt865OGPTWfZ
X-Google-Smtp-Source: AGHT+IGy7qn/q62nVdmV0vCzvqVW+73IyT/Xl/oBkYIWwsWPEWZx7dC9y0dIz4Zwfy9ryEFV+r33SA==
X-Received: by 2002:a05:7022:5f14:b0:119:e569:f277 with SMTP id
 a92af1059eb24-11b411fe329mr4797493c88.32.1763423003076; 
 Mon, 17 Nov 2025 15:43:23 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11b0608860fsm44698952c88.5.2025.11.17.15.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 15:43:22 -0800 (PST)
Date: Mon, 17 Nov 2025 15:43:20 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>
Subject: Re: bugs in rte_pktmbuf_copy
Message-ID: <20251117154320.1fe3c651@phoenix>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65567@smartserver.smartshare.dk>
References: <98CBD80474FA8B44BF855DF32C47DC35F65567@smartserver.smartshare.dk>
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

On Mon, 17 Nov 2025 12:51:51 +0100
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> While working on a rte_pktmbuf_copy_bulk() function, I noticed a couple o=
f bugs in rte_pktmbuf_copy():
>=20
> 1. If the copy is allocated from a mempool using pinned external buffers,=
 the copy's RTE_MBUF_F_EXTERNAL flag is lost.
> This is simple to fix:
>=20
> -	/* copied mbuf is not indirect or external */
> -	mc->ol_flags =3D m->ol_flags & ~(RTE_MBUF_F_INDIRECT|RTE_MBUF_F_EXTERNA=
L);
> +	/* copy flags except indirect and external */
> +	mc->ol_flags |=3D m->ol_flags & ~(RTE_MBUF_F_INDIRECT|RTE_MBUF_F_EXTERN=
AL);

Good catch, external flag needs to be preserved.=20


> 2. If the packet is copied with non-zero offset, much of the metadata do =
not apply to the copy, e.g. many of the offload flags and the packet_type f=
ield.
> Maybe metadata should be reset when copying with a non-zero offset?
> Or maybe rte_pktmbuf_copy() should be considered "payload copy", so the c=
opy should have all metadata reset?

The use case for using offset, is for removing tunnel headers. I expect tha=
t the code doing so
would know what manipulation of offloads was required.=20

