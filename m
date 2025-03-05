Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178DFC19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 17:03:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4878540275;
	Wed,  5 Mar 2025 18:03:45 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 246D84025F
 for <dev@dpdk.org>; Wed,  5 Mar 2025 18:03:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741194222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1rwtzMv6OEFX7h8wVcVZ25R5NyJYa0XL9DkxBDqKux0=;
 b=Dpf9kcwiBrYmG1hA+xaXbwDfX7j3MJX7Pip1kpyU89L4aMjQJ3L3lzmAPO08hq5P//1Cp+
 23ILC9ul/WzjTIefL1W6vjH0AIPvjJScXa278sqwXMtkakQSp8rjmZKoi8EnJVsXluSSqw
 P+8nctJyYPDb5R+Slr041DgTCiTx/1s=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-s0mC1EhWPG-K3ztTA2wJrw-1; Wed, 05 Mar 2025 12:03:41 -0500
X-MC-Unique: s0mC1EhWPG-K3ztTA2wJrw-1
X-Mimecast-MFC-AGG-ID: s0mC1EhWPG-K3ztTA2wJrw_1741194220
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-549500fc33fso3559105e87.3
 for <dev@dpdk.org>; Wed, 05 Mar 2025 09:03:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741194220; x=1741799020;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1rwtzMv6OEFX7h8wVcVZ25R5NyJYa0XL9DkxBDqKux0=;
 b=UAkhRviKB/g/O9ZezfXqFD/ZZz6fbQkf/ElHuo25hySLl79bKF59Ovk/UBG2DKZfqe
 0lsRAxskqgQKykszanp8QI1pubBtMq5eN5vh8EgwVjE9QXlPY24cpCd12zHcshx39wCb
 e+aitEyTc/I09043PxKmYZFvyHi9yItnOc/LGbg87LWzGblQTNCSbujGUOyygO1UYcrf
 7sd4gjquI5ElhrO3H6ziwgLwbTIPkeueYZFsxRtjwoN+Pn1sYYcahCOvKYPVtxfK7v2v
 QLmuTB+1ovLtCK63YwN3cSAcFTcZt1f0/ByJiFYtO3wOGn9Jl2Su3ywTbrI2tjaZf0O9
 hLGA==
X-Gm-Message-State: AOJu0Ywh+QDPrKWc2ezgnVX6EEaxzafU8jn+Pz2k1P3IqoeclGyStQA+
 2tha2vdt3dwAcO7BZKzCiksNY8/YvrdUEQb08r0714hc8KO3E4YlAuLA8VIs++S0SuXelBgwSlO
 oHySJQLIN2i8sHKg/uweH2WJ2rXQgShK7BsN9ROqbn4cYHym1GFAAHrGbLpl9h2iNE+jMs5F3U+
 6/XZ9fVfdiVWLCza/lwP5tQ10=
X-Gm-Gg: ASbGncv17h/Ch0lfmVjVtEvayyAd1ooElHL75EK0jtVHJEViyffjoGp8O4604T3YbLB
 hGKhD9dbz09jyR+lmZJu+ZdqnR8JBvwxln9o/V+4zeVTWaQIXMHAKoU7rFpaQDskWLM6IeYpR8x
 s=
X-Received: by 2002:a05:6512:3089:b0:549:7394:2cd0 with SMTP id
 2adb3069b0e04-5497d337e68mr1419284e87.19.1741194219651; 
 Wed, 05 Mar 2025 09:03:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQVxaLyIi78pJ5kBXwkA7xzitbclIY1cejgydaexzVmV/MbVxrLWsZuToWwV1eTc78NjUmNzWAMIndNo2JgLc=
X-Received: by 2002:a05:6512:3089:b0:549:7394:2cd0 with SMTP id
 2adb3069b0e04-5497d337e68mr1419228e87.19.1741194219165; Wed, 05 Mar 2025
 09:03:39 -0800 (PST)
MIME-Version: 1.0
References: <20250220220406.3925597-1-sil-plv@napatech.com>
 <20250220220406.3925597-21-sil-plv@napatech.com>
In-Reply-To: <20250220220406.3925597-21-sil-plv@napatech.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 5 Mar 2025 18:03:27 +0100
X-Gm-Features: AQ5f1JpjUxb7XdGsIiYiTQUe7WIAVY6dLD8rGSBlmBJzEHpZC3Cu4X_8B22wksc
Message-ID: <CAJFAV8xtMHZfXo3c8vw0LG9-Cg4v8LCKjP8+psm=sJ3XoFzyNw@mail.gmail.com>
Subject: Re: [PATCH v1 20/32] net/ntnic: add clock init
To: Serhii Iliushyk <sil-plv@napatech.com>
Cc: dev@dpdk.org, mko-plv@napatech.com, ckm@napatech.com, 
 stephen@networkplumber.org, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Mo53d0dp5jPxfc5G6BFEY03U-uO3ynGCUtkE33SqXUQ_1741194220
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Feb 20, 2025 at 11:06=E2=80=AFPM Serhii Iliushyk <sil-plv@napatech.=
com> wrote:
> diff --git a/drivers/net/ntnic/nthw/core/include/NT400D13_U62_Si5332-GM2-=
RevD-1_V5-Registers.h b/drivers/net/ntnic/nthw/core/include/NT400D13_U62_Si=
5332-GM2-RevD-1_V5-Registers.h
> new file mode 100644
> index 0000000000..f87828fcfe
> --- /dev/null
> +++ b/drivers/net/ntnic/nthw/core/include/NT400D13_U62_Si5332-GM2-RevD-1_=
V5-Registers.h
> @@ -0,0 +1,425 @@
> +/*
> + * Si5332-GM2 Rev D Configuration Register Export Header File
> + *
> + * This file represents a series of Skyworks Si5332-GM2 Rev D
> + * register writes that can be performed to load a single configuration
> + * on a device. It was created by a Skyworks ClockBuilder Pro
> + * export tool.
> + *

This file is missing a SPDX tag.
Please send a fix or we will have to revert this change.

The filename also looks strange, as it does not follow some kind of
implicit convention (when I compare to other files in this driver).
Could it be renamed?


--=20
David Marchand

