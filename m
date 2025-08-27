Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C82C8303F
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 09:16:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BCD540298;
	Wed, 27 Aug 2025 11:16:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4ACB04028E
 for <dev@dpdk.org>; Wed, 27 Aug 2025 11:16:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756286172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/P9BFVMNt2PPKuITUTRJU6WMNTdOGgokvEVZxO7Zzyo=;
 b=INbGAWqayMe9SvIOATgeo8Y3IpRvXKvpI6K8VdiH0NPUVl/vbaCIcZq5jSJimesr4G8o26
 40WGGDpvJY9znvmblM6WlS8P17hsmkJjf9b+KzQ8gB4DGpm8AgOocw1frHeOnK+3G2TPoZ
 8X0A25CQ0xHLV4xgBsHspyvwgzvxMLM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-YtiVNCOxOoCnecBooXbykw-1; Wed, 27 Aug 2025 05:16:11 -0400
X-MC-Unique: YtiVNCOxOoCnecBooXbykw-1
X-Mimecast-MFC-AGG-ID: YtiVNCOxOoCnecBooXbykw_1756286170
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-33692144ccdso3080771fa.2
 for <dev@dpdk.org>; Wed, 27 Aug 2025 02:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756286170; x=1756890970;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/P9BFVMNt2PPKuITUTRJU6WMNTdOGgokvEVZxO7Zzyo=;
 b=Tk8A3QkUmq0JsD71AZHTlBUgHXsMTQg2+yhFr0trzvLMhopfGi93kL3r+VvJPeQZRB
 pb9zHqfE2Uj8suHyZ+SgH6vioAbAg5G8AqsYc4JqtShsaLytD/lRhTS9u0BAnrfcCabJ
 MT1CyupvMQaR5oKmFpkUOs4ouqYnavON8WV05NYMLNXqK5VPzW8a2/NFuYARgbmLjCJl
 pv/O1UQfVjwpPKYLUyM8mFNCSkdldpeeEsOBM15ht/p/ZlBNV94Qaa8hzb0by9gygJ7H
 L7/Ho0bhrAwFrJUYWFsMQju3B21A1waoUkztRQJ4+k1DrHPrnAKkYJZkR4XzlS1roiUa
 WjfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGGpc6biXEME7oSyIaBWCQi4WlApyBh8yXv1wTuwC+Eup+gYSUWn0LCHuB3NkVB9bDrNY=@dpdk.org
X-Gm-Message-State: AOJu0Yw1fYeujp91xijFAADT6VCNDZLZqrD4etEt6nkUeUrzUJCgbywR
 rW4i77H+rPa4W2/ymB2bCR+fKH465T4K/Nm60tZaE+5AZSLjL3ORR+JT8ytSOxWNm1XPfxz/Cf4
 H05qscWHg7sNgnN4PAWEcuo2fjVNihYZmJgL2FUSfGaNnlEG/WtnyXxf7Z+XQGSyGUKPBUuKfa7
 QvhAR+4cZillTWc7CbH88=
X-Gm-Gg: ASbGncsE519hTrGdybQSBz3AMESgEDN4PYKne+FxrMLnozINIQIT7tj/kyrbyLO1cs+
 VJ0qGslzr2r99SG4/Yd7f377F/MccHoLIxqBreyL7KFE23IFFNaAT+ETEgGwqO90bTVy0A7bz4W
 BbzLlrS4nAxzPvbVISHncJdZw=
X-Received: by 2002:a05:651c:20cc:20b0:32b:78ce:be8e with SMTP id
 38308e7fff4ca-33650faa9c1mr37013461fa.32.1756286169706; 
 Wed, 27 Aug 2025 02:16:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/aSiITayBg93Weisj4ctj5oUxfRuT+mQWSqNUv9o2V0nBbyL0PnYQBOiDbUBvpWEtzyGJ6zRonZJ/ltFSwYo=
X-Received: by 2002:a05:651c:20cc:20b0:32b:78ce:be8e with SMTP id
 38308e7fff4ca-33650faa9c1mr37013341fa.32.1756286169279; Wed, 27 Aug 2025
 02:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250820084521.1088620-1-dsosnowski@nvidia.com>
In-Reply-To: <20250820084521.1088620-1-dsosnowski@nvidia.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 27 Aug 2025 11:15:57 +0200
X-Gm-Features: Ac12FXzxEaqHGmt6JjXf1jFlhKvGHdEhz2jH8BokbP0oKYW3F5zMo3YvKP8u-QI
Message-ID: <CAJFAV8wF0PT58zVDJDcmLcLz6Jt99rjexJOkFHBOmXNAhMw+vw@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5: fix matcher flags in counter offset detection
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Andre Muezerie <andremue@linux.microsoft.com>
Cc: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, 
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 dev@dpdk.org, Raslan Darawsheh <rasland@nvidia.com>, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JAm6vYXfOtPGn5stV6Muj6ALMY8gK1lth_gfbUVy3N0_1756286170
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

On Wed, 20 Aug 2025 at 10:47, Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:
>
> This patch fixes a bug in
> mlx5_flow_dv_discover_counter_offset_support()
> uncovered by a warning reported by MSVC:
>
>     ../drivers/net/mlx5/mlx5_flow_dv.c(19636): warning C5287:
>         operands are different enum types 'ibv_flow_attr_type' and
>         'ibv_flow_flags';
>         use an explicit cast to silence this warning
>
> IBV_FLOW_ATTR_FLAGS_EGRESS was incorrectly passed in to
> type field of mlx5dv_flow_matcher_attr struct,
> instead of flags field.
> As a result counter offset support discovery returned a false positive
> result on application with old rdma-core.
>
> Bugzilla ID: 1758
> Fixes: 4fd5e1484887 ("net/mlx5: fix counter offset detection")
> Cc: suanmingm@nvidia.com
> Cc: stable@dpdk.org
>
> Reported-by: Andre Muezerie <andremue@linux.microsoft.com>
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

I did not test the patch, but on the principle this lgtm.

Andre, can you confirm it solves the build warning you were seeing with MSVC?


-- 
David Marchand

