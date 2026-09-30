Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEE8CA5FC7
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 15:27:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 021E840FB5;
	Wed, 30 Sep 2026 17:27:29 +0200 (CEST)
Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com
 [74.125.228.37]) by mails.dpdk.org (Postfix) with ESMTP id 7508E40E50
 for <dev@dpdk.org>; Wed, 30 Sep 2026 17:27:27 +0200 (CEST)
Received: by mail-pz2-f37.google.com with SMTP id
 d2e1a72fcca58-887ba76d5afso224180b3a.2
 for <dev@dpdk.org>; Wed, 30 Sep 2026 08:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790782046;
 x=1791386846; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Vnewa4wTNLUt01aCRfzLpOp/nmNXhhDCH4WQs+13JhA=;
 b=nSerg8dQqHV5An7nlNTIgOB0xJCzof+BUbAdT9w6mI265Ksx6eat1W7jsgy/BhoBsi
 h0KmCGY5lpt7F4ZHLGU9UITIfZtLp8TLlrpe923yv7TTw5/iaZitWp+VqamuVrdpVyjk
 uU5fbDKg1BcCd1idwCGC9ZWQSd3CWQedrGyvq7ZrPYliOhYkquKT6vX2DfdXhZSiygzg
 2Qro1QI0xnv44EeVNxVPQQJkD1VimJEtbHAA9u2vbGTrgC0JPf+mZM7rOl52k7I6q2tG
 obH2x5DF9A82qd5TQiXAl+VIYG+v6EC/EA1rIeEtRHmZ3UGZ57qHa9I6/W9b+7Jtc50M
 abnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790782046; x=1791386846;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vnewa4wTNLUt01aCRfzLpOp/nmNXhhDCH4WQs+13JhA=;
 b=gS3oG1ArAQ9FI4Tms0q+EwoEVUu/OCDxeCVU73OahKXYC2SxXOWjgVoBJSszkZOd2n
 ehIhh/6lQym1Nq7dGg1G73YBX2NUVjKMxdJ29ytAos/KhCJOGMg8HmyQs9MPDle4Rlgb
 yYFjo6GzGjKS/cjwzLebBzjYo2RA4T9CnXPRtV4Fug3OqAGIgb6tfLBZ9xPiGORcYBJA
 mG0uagP/E896+HFcYVEANeh5o5WgJP1x+ZWYU5ZU7ZzyX4fNKdpPWevkLV2eOoUW1KZI
 0rtgz6+ca+wWI6zN3GPCv+MeLo1uUWAAOAx2sZmRQIAQn4o+JKzgMODsOx/tp70GmSks
 Ot6g==
X-Gm-Message-State: AFuF++lMzh992wcQvUzRG+JQ0qrqMHgi66ciJW2CdvfUHLinDMTvn5ce
 QZgpd/MJE5vfygj8BRCRwt3i/PDRYRhtchEqUuUq9iiEXKkgv/MxqzBIAA0oRoY3K2k=
X-Gm-Gg: AYBFou29H7cQVl3WyUWW+4Sy4z0uKNVTBkwDi2S9YRMoMDy37l19Uur99cu3yZlP+1t
 JC7LexYa7sHf2Ar67rgu7bZT8C0HqqxEzcPG2JScPvBaPRL7LA0/mYemADcBb/qdFXRpufbkLR7
 pIQ9xeae7pAQwi8qRKZhXLqJ/BCx/JP63mm9m3Tq90cJOq8s/oAbAgRMlqwsLDOihU0TGc3Rb8M
 Vpd4Y9Dmc2WmnxCz6PG2oJmPzr/0yPvNGAaoG+Oj8UMp6mhhRjWTSyZ2irPONmRleFp/oalxfoO
 gbvQnphFimvk1/8/fk7/s/+JfTMo0g7x1xEIIeIFiMDQTHoX0G1l8IH4PjGT9Eaty3+K0tAM9vy
 o1dEekOBFl1EMclXy/l8w7cZiu3amT4W8jvJstFxyEISC/6u0fuTzg3L13s48s1zCuDycIIlZ/h
 UtRsV658cyXWWtIfDUXtGg8lfA6O/knaEXU7rMD1taAV2u2uXfRzzuOs8JTvIsL86QFkKv1Bz+m
 6DAZQcMv5tVf/HvNHZKTAtPA+7Ad9lJQg1Ijkgsq5bWBAVU/RCK73Q35gnKdw==
X-Received: by 2002:a05:6a00:4c14:b0:882:6836:25f0 with SMTP id
 d2e1a72fcca58-8874ba1e7e9mr1299586b3a.52.1790782046370; 
 Wed, 30 Sep 2026 08:27:26 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8872644105esm1060439b3a.50.2026.09.30.08.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 08:27:26 -0700 (PDT)
Date: Wed, 30 Sep 2026 08:27:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: dev@dpdk.org, eperezma@redhat.com, david.marchand@redhat.com,
 thomas@monjalon.net
Subject: Re: [PATCH 2/2] uapi: update headers to v6.19
Message-ID: <20260930082724.06b79bb6@phoenix.local>
In-Reply-To: <20260930095800.551314-3-maxime.coquelin@redhat.com>
References: <20260930095800.551314-1-maxime.coquelin@redhat.com>
 <20260930095800.551314-3-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 30 Sep 2026 11:58:00 +0200
Maxime Coquelin <maxime.coquelin@redhat.com> wrote:

> diff --git a/kernel/linux/uapi/linux/vfio.h b/kernel/linux/uapi/linux/vfio.h
> index 79bf8c0cc5..720edfee7a 100644
> --- a/kernel/linux/uapi/linux/vfio.h
> +++ b/kernel/linux/uapi/linux/vfio.h
> @@ -14,6 +14,7 @@
>  
>  #include <linux/types.h>
>  #include <linux/ioctl.h>
> +#include <linux/stddef.h>
>  

Just add sanitized stddef.h into kernel/linux/uapi/linux
