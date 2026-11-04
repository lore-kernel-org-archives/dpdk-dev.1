Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1255606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 12:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Pnp2Hojl
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B057C40281;
	Wed,  4 Nov 2026 13:17:45 +0100 (CET)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by mails.dpdk.org (Postfix) with ESMTPS id 01AFF4025A
 for <dev@dpdk.org>; Wed,  4 Nov 2026 13:17:43 +0100 (CET)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c4d1b35dc42so21504366b.0
 for <dev@dpdk.org>; Wed, 04 Nov 2026 04:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793794662;
 x=1794399462; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=y9zhRB3l+nourTiW4U7WAesUVXMOmYCA0HWd33rix0U=;
 b=Pnp2HojlGpgV2OpNllK7wsZDb5XvWlb20Qgn8P1YuzfmNmii6GGJ2QujIsNa6aY8b8
 wnvQNptINEVnR0h9Kuf5V6DGX6zotaH6W9ctLxdGWY9AToHaXgTqbjrBNWBDxcljnjdd
 S9ogMGwTGUcILxHsmFUHCmnWazGBmiReAzEC+RsqaUXqiz5g99iDiOQKw4tM4JUCn5KA
 yUXtpJOWNg8s/x3/RGgpTWdpYcDiRiwfOCubUEVB35d08qGgzFEpMIPkkbWotVqL31rv
 wSTih92khpm0Y0RMYVevq0GmRwnLOxbvvFL23M3+WqNyt4in5symFIpDh42f4er1gYKq
 GQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793794662; x=1794399462;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y9zhRB3l+nourTiW4U7WAesUVXMOmYCA0HWd33rix0U=;
 b=APQwjQw1w59aORjd9IQbZe0jUdLzY67AWjqAUkWjEfaRigMu2DC2sgqnQUPguitAZm
 o60g0xsXXnYnAc8pYuMZg1kLGWy1pOpiScCN/DvCXCJWZtmk4Y/SlTVsX94wRF7rH88K
 Buls7jfO9+LWn67VDhba0hQMxwY6dsdATu66+80wbqwfcPtSF5Yf59+0CgnYvDGE5JnD
 om789ArM8uvP8KnhFgA9qkzD0ffENTnewnAuu/qwoJr4STTssE+9SSBNEK0nfN+EbiZJ
 zLRWasOY6N7HEAWo33rmi7vUJP+PNdDTn2wu2AeFvO+0ijNWufgBOBkYd/oMRNnnb5IG
 UHAg==
X-Gm-Message-State: APuU4Z+lgyfHh7CZ/7fw0PPNidsiWQMSMHQQt7aG2KhiWpf3TLo2zafA
 xaAVBuqBD6/xZ7L4PYZSJJsN5vlw10SHMPrz2lmW8FVBzVf10/LcAdz3xrBs1BMtVxk=
X-Gm-Gg: AYBFou2UXtMHxzWhe3iGpym/zuaD5fHwNaKbwQbs+e0p1BeGeu9yRFexWDHbPD+mzbb
 WF3h5BbKQy2hCRgroNEgmEnTji+X559Lns0PUk+DYYPK8Qr+sWz/45e6RwwbjaNwv8IeDC8oJFL
 cX4kv3N9aUFcmk/MXbDWY5U6i72IBWKeY4iFBlv87SUuv0vxsrP1Sk7z+ICPRWG8Jao/m7ItlI0
 L3P2fYj+3OMNAUq7UjltNfcCNbHG8oaM0WCLvvnpU9zliqqfM91Ig3f87AYQ1brtwL+I6Um7Crl
 V3YwJZfmWRHmJ46ggeukBil29f/WlkTRcaCApMVcLlE7+Rkva8C8fp8I11JGs4MQCRiB2JHfiB2
 2Ho7o1DH7hrgodivWqFMUUcmS/UPzpijYmDIjiWmYR5PfF0BxbgYc7dvQZNdfFoIDlqRlk3Yyqr
 sY2gUJL6bW7ePE9rmqVAmSLp3vsCDcCuYhbGZi4bPaCY7VeavKcQSolgcjFhdDe5XGgkQG5aH73
 eDIinbc/xNRpflKdlFgFujDcSOTM+CgOodkc0xsGU3n6UtlEYvkPQtLcIaR65i3aoWJPl97p/Fr
 qDIkNRLcFHxadd81ITErVqJHEUmRd2YQDAJc0cr6VtYam43DaaTc1CY7RZrEuXLIkLHdbq8hY1R
 Uj84zYvAoqqDgJRs=
X-Received: by 2002:a17:907:e8d:b0:c49:c3f5:8bc with SMTP id
 a640c23a62f3a-c49d12867bbmr1682119466b.10.1793794662478; 
 Wed, 04 Nov 2026 04:17:42 -0800 (PST)
Received: from stephen-xps.local (93.224-78-194.adsl-static.isp.belgacom.be.
 [194.78.224.93]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e48a943sm62592366b.62.2026.11.04.04.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 04:17:42 -0800 (PST)
Date: Wed, 4 Nov 2026 13:17:37 +0100
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sun Yuechi <sunyuechi@iscas.ac.cn>
Cc: dev@dpdk.org, Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Subject: Re: [PATCH 0/2] acl: avoid vector spills in the RVV search loops
Message-ID: <20261104131737.0ac6e156@stephen-xps.local>
In-Reply-To: <20261104093401.3574400-1-sunyuechi@iscas.ac.cn>
References: <cover.1793520104.git.sunyuechi@iscas.ac.cn>
 <CAOaVG14=ECO921X+DmupfY60Dpo9r2xq=Y4+QC22G=AQ0kALQA@mail.gmail.com>
 <cac350a9-9d40-41d7-a136-0eb32a3813c0@yandex.ru>
 <20261104093401.3574400-1-sunyuechi@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed,  4 Nov 2026 01:34:01 -0800
Sun Yuechi <sunyuechi@iscas.ac.cn> wrote:

> The default DPDK build is unaffected.
> 
> Some distros package DPDK with buildtype=plain and -O2. Where ACL is used on
> RISC-V in such a build, the gap between -O2 and -O3 is very large. A gap is
> expected, but not one this large. The optimization level is the integrator's
> choice, and a library with hand-written vector paths should not lose this much
> because of it, so I would rather fix it upstream.
> 

NAK
Then fix the distro's choice. I don't think DPDK should be overriding
compiler or packaging choice.
