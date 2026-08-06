Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1C7C5AC7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:19:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A75A4027E;
	Thu,  6 Aug 2026 19:19:58 +0200 (CEST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47]) by mails.dpdk.org (Postfix) with ESMTP id 2CDB640262
 for <dev@dpdk.org>; Thu,  6 Aug 2026 19:19:57 +0200 (CEST)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c2055573c8cso222181466b.3
 for <dev@dpdk.org>; Thu, 06 Aug 2026 10:19:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786036797; cv=none;
 d=google.com; s=arc-20260327;
 b=nKthrNvNqqrXu6esTdDwsqNr3/mRVBB7mTQEMvk74RJoOEVDGGxdI28hBlOwkhMtKQ
 M4YxToBkmTVgdyEKIcKY3F8U7xFtTSO5SFtsgkEcv4nJHFneB8Pm8EBI1Uiirb6AkFLp
 8cSwfgqIzljO6EgqvOc1d9GgN7gYvUmZMpALmZMiuTXJW+11HLgHGwti0zFK7qR2dOz1
 gL3Szlrv215agyO+RBRko2Lmb4C+JU23HuwPkpVggjSbpUjStOxF6J2BqAET3oxduQqb
 JpZ7J9NvrW/ScD4CU8Y7PPIllfCP37m3aujcS5C9ordjC7JWJPFcLRiEm5WDM7iRrXzi
 jiMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ORiFj61vezZe77mupWRR9cuWxct8+m5p68/3U7oqo/g=;
 fh=UMJ93c4jGx+8uNDwGo8ghV2VB5+nCFODu6lZ6pBlNjY=;
 b=nMBUecIgeV52HY62zRp4ISI5xtnlY37UDnlzx4dyUkrbDGIGzeCnBuKlFpwBxhZRYN
 mL1PRP+9Ifk8pqLEKCspE8Ji6p6x9w+kLVkDyEotIUTY8cmjUeaw4vfM420mm/L6YVc5
 ffW/pzaBRK+ekaKWF243SRUZQK0g187N7Tg8ff+d02hdRKOAM8+ROOXIq1C7uxm9+tjD
 Sq9a84luhrM2oTc1rfonr9cTvj9wXrBfD9oJiL0oNfMiiAvdNcwQh/JcNs1VRujm1TdU
 +phHYN5Xs8CQz82q8V9S7B80k5d5+KG5CbUbUIeYOtE0SlJfmw4SjHkk78LHAf7UC4S5
 Z3XA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1786036797; x=1786641597; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ORiFj61vezZe77mupWRR9cuWxct8+m5p68/3U7oqo/g=;
 b=IZZip2GL8p99APF37hEBworm9+jKM07PSwYdabEUxKzEpdrzo6HlndE1kPE392hiwB
 X349kDxzDJetL1OYNpjSnKy/Hke0iV/V43Pl51C6t1Lae9a6QF9cdz8BgA5cARxBaM2O
 Uz+oLYjYpOzHs1QtjhEG6j9AlBk7AaQvrZCQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786036797; x=1786641597;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ORiFj61vezZe77mupWRR9cuWxct8+m5p68/3U7oqo/g=;
 b=tQVqBeieDalpfgB9JU+50zWV48MLxksEh947KhI+vKTTDokAFqqSGT6K1UESUwArO/
 na92S6O5icn4rbdIxctv2+9GPT9Bjv9h25BJljDOmNQUUzJLR2DxVTfPA0LfeXyDxqcf
 LsV5UpL3e0eeRIGbRLa7aJx09EHEw9UACbNdgfXdyKDsunAiOkTDVRX+988sPEmMkK/u
 G64FdsMrgvB7BrDH4Q313tEUk/wV0JsZNYZ4NYruGkuEa9Zok3C6Zq977bYYN0HjHNYd
 rDc50h3ygXynC3qujG5KTtIvEI5yNtjv/ahuNOiEhczkHagemwY0WdRI8uj40rc1Ahve
 ZKrQ==
X-Gm-Message-State: AOJu0YxXk6ggDAK5y1r8FWUTkg8RkXhY/bFAJe0We9Q3LL/1CZjb4kgo
 EkNKSdxVsjo7Orh0eck3L3CChb5saaehXKnFkkIjaHeSgk9B7zcFFx214lEYGmq8DKDATZlfGSJ
 9AnaSbgJB/cBzNjXA4aljN+RyvoS06QJdpkU2J+ZbROEGyjKYP56fJt8=
X-Gm-Gg: AR+sD10OFVekLwn4nrgkvOYDdQbBqkaJ58+upW85g3WaPWCIxro4c3ytVOmKoI7YoMN
 uDmsb94KktJdZZm+MkeInjf1kFHlsMO6zoMMt1NHYDTbZUbB2dyBVyghvHBwo0Gu9hqkVO+RuhK
 hZCYXtrrLKaON2rispYCNbQwsG9GEpYnBv5yr1rKw+PixhzrI7A/W69E93LU71yXHH4yHHsq/Vn
 rrYUQetjWcONBbhhxD4ANH6BAKPXa4oKL2PYXoqmmrsLdu8OqrZ34ntC8j6aNc9dO359FKetMww
 BRQThwJ9sJ3DlaYdfkRrDo9RTac5u1n075FhE+g9RcmP3IC+uL9RwJTQQz4/
X-Received: by 2002:a17:907:c241:b0:c1c:6150:c2f1 with SMTP id
 a640c23a62f3a-c2039b49a08mr891529866b.8.1786036796819; Thu, 06 Aug 2026
 10:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260806135346.568766-1-abailey@iol.unh.edu>
 <20260806171636.656181-1-abailey@iol.unh.edu>
 <20260806171636.656181-3-abailey@iol.unh.edu>
In-Reply-To: <20260806171636.656181-3-abailey@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Thu, 6 Aug 2026 13:19:45 -0400
X-Gm-Features: AUfX_myAQEEFmQd7Ua0ZyHzZ0_TM7qMJ8Tl-ii_jAYvSeO0MmC1Nf8UGjGXPbAk
Message-ID: <CABJ3N2VcNvm2mt8TUj7qXBeoBFqG1W_QG6fH7AUVcyT0YKXOrQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] version: 26.07.0
To: dev@dpdk.org, luca.vizzarro@arm.com, patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu, 
 Thomas Monjalon <thomas@monjalon.net>
Content-Type: multipart/alternative; boundary="000000000000d4995e0658641876"
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

--000000000000d4995e0658641876
Content-Type: text/plain; charset="UTF-8"

Hi all,

I sent the wrong patchfiles out, please ignore.

Thanks,
Andrew Bailey

--000000000000d4995e0658641876
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<br><br>I sent the wrong patchfiles=C2=A0out, pleas=
e ignore.<br><br>Thanks,<br>Andrew Bailey</div>

--000000000000d4995e0658641876--
