Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20BCC43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 22:14:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90DAB40268;
	Thu,  9 Jul 2026 00:14:58 +0200 (CEST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id E3C7240265
 for <dev@dpdk.org>; Thu,  9 Jul 2026 00:14:57 +0200 (CEST)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-4703bc0a99aso717596f8f.3
 for <dev@dpdk.org>; Wed, 08 Jul 2026 15:14:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783548897; cv=none;
 d=google.com; s=arc-20260327;
 b=N5ZA9Os1Xa9HSB0pfS7n9ki26V/c3Rye+SZWkfgv+6qVs36NsARffhKx5t/sqvdHvE
 k8/4dBJjwKl/ChrQqxwwys1ou+Vo1QjsQyGszlT57ElxQAPHtAxGJHGaOpPdnEe2BOel
 IQx+BXAuOV+pSB5aYiHXZXqujpH0+2O70AMuSHebSwzFpFWsc6kiJgHh3gweBeYUJF41
 s/RI8iJFVfNNXjAOZFuBgeh1ZFxPFDTUAkF4AQIIRqWbSjhpLHGGWWel0Ys5TkCaZQ4x
 OX2Pu+zp+O4b+UYAXuA0NvPd5ZYx1EV8xmB0V1yb/5ijEOIPvbnVTPwUVI0eyRKMRR63
 TMMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dXrmHTXQv0at5w4d/yFnuB5OyEcGAcx7ZJZLzZIJrGg=;
 fh=4tSMTISJ6WTFnfd3kyBWvJG83rua0w6GI9vr7mQX6Rk=;
 b=UrWjRe6sClmw0goXJHOK5Gb9vsbW2laIzfSaNULr8WGxaX5DGV+JBnZzSy4R81FuXE
 7iUWKH2h/F4xjnvciQDa9kvsAFfEjyv7pr4Q8IDzjZHRZowNfT2TXHGTOELMmTsZKqe0
 DOcs1aOcs4rmLgF/Oh70mNHX93LN6p8sykhhqzfLUSeaDfluPBefgzzC1Kru5yCzXhG/
 eRXHVZI+JLKtNGFeqmfFp5gAPYiVuCubOc9LQxRFTJD7DQOY93LY3U+x3lbuiiTm8DOC
 Vk0wq+qIoVq4dZU7yd/Sj2lw9+NW5T2gHYW3DieZxmW6E6ULu59SqrY3iG1/ATTKS3gL
 cYvw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783548897; x=1784153697; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dXrmHTXQv0at5w4d/yFnuB5OyEcGAcx7ZJZLzZIJrGg=;
 b=hH9VloiLDUkLpno+Jm8JyYuBrzdmOS1F6wQeSpAbfhGkjBtQUnozvI/tMaVyVXIvGR
 1InY6s0kw5CBOVGvPbRN/kC+GuOLwD3rE56jH85bcGN5b6oc093bwe0AQX77KLhKf4wa
 qTE1zD4cuJ+f7hkg9V1ixYgWcEgaB/KOhxR81fY9l8YrsTJVfY6y2VSV+FHxsp4Na+Hx
 abmAAyM6yUWMQT7rdRnLejmtCpZBNzf4tquvFUax9t+Slyc6+XCI02bT2S/PwsyLXKCR
 AJPVMVFB1fsPFfM4JGsoqAVPrI5GxuZyDVdhe0eI6hZjWANAvana1ABvzYYaEs7vlWBz
 v8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783548897; x=1784153697;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dXrmHTXQv0at5w4d/yFnuB5OyEcGAcx7ZJZLzZIJrGg=;
 b=o4MNJPHtCR1I187hkkh6bm2Yawq3MtSMo7uP/F38IL1s0OH74dehnjVRICxVcMCWYB
 tAkeLmNfBFLQrwrlUlrgPS3y/o8jvBJ53dJAzBASS3Y7wWHn8WwhRpHUjffpoF2sByO2
 G9H8mNSuuMHNNjNc5LYmdhQRH80P/hW64bOYPCYnAx0PikjFUKsnaVodqQlY5+fuU7Ed
 /QpJCkiewjYrxhkbtatwNEGNXzSxjEGhYBho+IrV5bj2S65OMXtyAPCqp75d7cuD+xVB
 9ZRk/Wr5Na4gu4IyGdhmKdxtesNFgX5GYWaJWD1xxIaMxnvvZHt4g1TJ7RwOPdzCqK/I
 Je5g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq3D7I5SRRXxEScUsVqcSsR8WrLmgNDFE7+yLhxQW8EKxbept5NzJvz3aW77SK6tRahL9c=@dpdk.org
X-Gm-Message-State: AOJu0YzbXvpDxSIqffBQOyv5p9jxCPFhv9W2IOrt0kkghYkmfNurmiIq
 E538Sot7K7N1awcdvbwOJ3QhE8W+rHvxs30j6KsjH9imGDNWkiEhdREdvSHE2Dr9wqppBG/qfsU
 Haz9UpM6lJ2SynXlyQCK2713mWAWza1A=
X-Gm-Gg: AfdE7cm/i1fFDZKawKpc4q0TSZaVpU+PWHlU+Z5+Zwr6TyFjryF55QinyBsODDby2SU
 esvtAMMPzyr90gUXc6ZjK39OhIHkX6mEUwFE4l1zYl5aLAhdlwf3EQiFMmOI15OGZ893mQbchlM
 0oP1WZ291N7Bb9LXxBzwJcYbq4b+23GCT35NOplh2CnFUqBruU9QPu8LbAi/sIAstJlnKtfAZVe
 SVvKCTiHtfWmmiF8q+cMESG8Fhy7xe6xjxtU6YdkTeFqnd3nRKmeJxei23+SHbxCYDSmjFOzgt/
 bNNfyF9VAYI0jbbiOD5uV/TUM4P5hw==
X-Received: by 2002:a5d:59c9:0:b0:475:f0f0:9efb with SMTP id
 ffacd0b85a97d-47df0787b87mr4640849f8f.50.1783548897192; Wed, 08 Jul 2026
 15:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260522154637.952588-1-knimoji@iol.unh.edu>
 <20260625181557.2331771-1-knimoji@iol.unh.edu>
 <20260625181557.2331771-2-knimoji@iol.unh.edu>
In-Reply-To: <20260625181557.2331771-2-knimoji@iol.unh.edu>
From: Patrick Robb <patrickrobb1997@gmail.com>
Date: Wed, 8 Jul 2026 18:14:45 -0400
X-Gm-Features: AUfX_myxuEaDT6mzEaN9rq5DYturvApWQqP-koXh6F-ktyfPUH9e1wZWR63iMvc
Message-ID: <CAK6DuxuiK4h8HKXov8vMam2k3-HwoyjWyWAxC_7qMTFXbDmdxA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dts: add build arguments to test run configuration
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, abailey@iol.unh.edu, 
 ahassick@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="00000000000074ee58065620d676"
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

--00000000000074ee58065620d676
Content-Type: text/plain; charset="UTF-8"

I think the polish on this patch is okay but also there are some moderate
importance cleanups that are recommended by the AI code review:
https://mails.dpdk.org/archives/test-report/2026-June/1011807.html

If you can't get time for this before RC3 I think we can merge this series,
but some of the cleanups (i.e. safely handling yaml string vs list of
strings format in the test_run.yaml) are valuable and if you can add that
either right now for RC3 or early in the 25.11 release window that is
ideal. Let me know what you think.

Reviewed-by: Patrick Robb <patrickrobb1997@gmail.com>

--00000000000074ee58065620d676
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I think the polish on this patch is okay but also there ar=
e some moderate importance cleanups that are recommended by the AI code rev=
iew:=C2=A0<a href=3D"https://mails.dpdk.org/archives/test-report/2026-June/=
1011807.html">https://mails.dpdk.org/archives/test-report/2026-June/1011807=
.html</a><div><br></div><div>If you can&#39;t get time for this before RC3 =
I think we can merge this series, but some of the cleanups (i.e. safely han=
dling yaml string vs list of strings format in the test_run.yaml) are valua=
ble and if you can add that either right now for RC3 or early in the 25.11 =
release=C2=A0window that is ideal. Let me know what you think.</div><div><b=
r></div><div>Reviewed-by: Patrick Robb &lt;<a href=3D"mailto:patrickrobb199=
7@gmail.com">patrickrobb1997@gmail.com</a>&gt;</div></div>

--00000000000074ee58065620d676--
