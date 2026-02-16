Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28F0E7BD81
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 10:01:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18D9E402DA;
	Mon, 16 Feb 2026 11:01:52 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 766A440289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 11:01:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771236109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZGMjiSHEm50yIdYCW6uB/ONPvNfmG1Wdl6pC/4xL9wo=;
 b=UgqL4p/CSFFE1q2sATqIdDN28V5Dz2pUn23z+jXLbl3DplHTy/nt/p5OKWprAc/XccORKp
 dP5iP3ihXH00CBhy/6E1agwIMdOgCqXoTeSj0KMAAtdMOS64xynEi9wZZdOnBkLMRZNo6a
 uLRYQxWTE6jHd4IDCtIP+scOMu2k03g=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-zNP7tXTnPbqznx7GvwwHyQ-1; Mon, 16 Feb 2026 05:01:48 -0500
X-MC-Unique: zNP7tXTnPbqznx7GvwwHyQ-1
X-Mimecast-MFC-AGG-ID: zNP7tXTnPbqznx7GvwwHyQ_1771236107
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-387126f6da6so15594761fa.1
 for <dev@dpdk.org>; Mon, 16 Feb 2026 02:01:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771236106; x=1771840906;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZGMjiSHEm50yIdYCW6uB/ONPvNfmG1Wdl6pC/4xL9wo=;
 b=DSampC3SbczcqvrGIFbBDySp4WXMWvIQp9kLwgkzfvdfoFMOE6vDfQQJv9qdP3vCCG
 gprlp41hstwfLtydpEPC5k0tR9Ox68vrBxi9pB6Nn4qvX/EjnYU/CjE4AQr8iobY8m+b
 /zjETTmAvRKBftsLKxITGAT4y9EFVUIbEEbRVGbjQUQdER405hBEikDJn1km4bDg3GX6
 e3CCtZMIZ/l7Cesb54TZ1yEJS5ksm7jQVP0JyzT4ChgHtR96zHM+z+dLlsxoZ1/3tQp+
 SPyRfBh+bQXVHCFI5VUQTkUzlkpqvIuDCwEdDhSbh0H3lvU2aj6nku9oSgPk3Bu2kXS6
 Pvxg==
X-Gm-Message-State: AOJu0YxSE3ug2bqTWENuCznGu14LChONWuEDEfpC8OvGLy+VVTEKIAAZ
 2XGAEEgMPtlLML5CtcDAIDJwJPKzZg1KiUOhlMmsLz/5a6yBi1vxzLVOxkAF2Yet0I+Jb+q2DNS
 YBxnK90kFKmnIhqPj2+00lK5vv8y9AO2BN40elRLqZmkrZeEepWd0khvGozgSLM7chy6RFfZKZe
 wwXI+bvFmsSvsqL56v7XmVCZgDLzjfZg==
X-Gm-Gg: AZuq6aLAgRKOFxKwk9m8pK7bs27J2X5weqY2tgFHgBcr7aHlisaeIbPGdF7mdsSVh1p
 qjUiPCwS5LZLWaj/VGbcjurCiUAN/3EMKQ22JTn8csCwa/o+PyO+21rEt8Zq5ZrYqSEv5ptXFZr
 Txgw7anKgDw+/pFYUnbnlVOA0xGs9hbwcsXHJoY9RWZw3ZvyX8s1Z1bOZGGzRLGcbgTqCNGsDJK
 mxErlWmAyBBO/GI5avfdEOVugVAFdSI8qlBV/9Ht5hObAANIwhGTA1bDT4Nh+PwEVxALQ==
X-Received: by 2002:a05:651c:1545:b0:387:90a:e4a0 with SMTP id
 38308e7fff4ca-3881b9509eemr18181441fa.29.1771236106498; 
 Mon, 16 Feb 2026 02:01:46 -0800 (PST)
X-Received: by 2002:a05:651c:1545:b0:387:90a:e4a0 with SMTP id
 38308e7fff4ca-3881b9509eemr18181301fa.29.1771236106016; Mon, 16 Feb 2026
 02:01:46 -0800 (PST)
MIME-Version: 1.0
References: <20260126210615.175816-1-stephen@networkplumber.org>
 <20260213192039.221213-1-stephen@networkplumber.org>
 <20260213192039.221213-7-stephen@networkplumber.org>
In-Reply-To: <20260213192039.221213-7-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 16 Feb 2026 11:01:34 +0100
X-Gm-Features: AaiRm50hr-belWdxP2ZqD5Y_g380wHAvLJEMVoY3DzozB4L131GmAnbL1lpbV-c
Message-ID: <CAJFAV8x-9SDi2hfeAHT3zaxr0kSiAEdW=GtHkKz+DTr_K7-H6w@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] test/pcapng: skip test if null driver missing
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZjV5yj5HhdhSf7P-97Fon-TIn0TEqyS5sJ8UxmM8lhw_1771236107
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 13 Feb 2026 at 20:21, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> If null PMD is disabled in the build via -Ddisable_drivers=null
> then do not build pcapng test.
>
> Fixes: 6f01a3ca5c7f ("test: fix dependency on pcapng")

There was no dependency on net/null at this point in git history.
Instead, this fix is about:
Fixes: 0c614a0fa6c6 ("test/pcapng: cleanup")


> Cc: stable@dpdk.org
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>


-- 
David Marchand

