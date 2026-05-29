Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781C4CD6E49
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 15:52:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9682D40262;
	Fri, 29 May 2026 17:52:15 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 64432400D7
 for <dev@dpdk.org>; Fri, 29 May 2026 17:52:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780069933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tJ/UYGSAhJoHD2OKag7MVcq1MA8u551Vc3k4EQe70GA=;
 b=HJen8RZEndWQkALZNI6KmX2+OUPSq2OY2G5ZADK5U6/Nm4jI7f83ZhQs92aOlW9Z/t4DHc
 mo7CPaARWUOyfhz/uVdwvb3kBCOwAlWRCz2pwsibLduRfXjq1bHw7EbUn8rIdjBaG9fQvX
 P6R/wo/bp8EIH1Qi+5CPSM42dueUDyw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-JI9gbcEjNB-WVg7vX74ovg-1; Fri, 29 May 2026 11:52:12 -0400
X-MC-Unique: JI9gbcEjNB-WVg7vX74ovg-1
X-Mimecast-MFC-AGG-ID: JI9gbcEjNB-WVg7vX74ovg_1780069931
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-39391b06ef8so74652521fa.2
 for <dev@dpdk.org>; Fri, 29 May 2026 08:52:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780069931; x=1780674731;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tJ/UYGSAhJoHD2OKag7MVcq1MA8u551Vc3k4EQe70GA=;
 b=g6oqeOR1OvWpd3w16Jvdu4u1h6HDlrE3c1UGf7de7AsW9nCsAi8uiiMiL9t3fFkq2j
 ESRWoQXS8gI1RlcrE1Zes+WfA7f3PFbhrI6ELdnLnxS5G6Mmvsg37m2nF9KjW9Wo/Dr/
 egkFB7uc6eVJ89b2x7HdzwlQkc6tiWKDVCeMqNuQWH9z3Bb/I/xcEY+X4rtszEBXGyGT
 q6jW5dg8KhdsSC5HPxdO7OzDz3PhmDWJn28F00GN9T5mvjx2MQaMzn2rQ83A1vy+zyQo
 XjFHi4/cU6i4iGxb6xOH0QEzEFHFJXQaKvy31hBgCRgwy36lqR0TP9cb8Z/6UZ7IVxPo
 JxEg==
X-Gm-Message-State: AOJu0Yz+JI+pR0VQTUw8E/O/WzHfK4Q+UJE44zrBkm5M6tNP7RUXhLPh
 JDkd2H2ukTNLG35G51KwO4rda+bsKdQ4bvLboLYgsvWX5qWa/4PUk1iy6cSO8seVszRNB1eAVwd
 zJM3Z6oBTrGOb9Q3VOLuItxzm52gIHDyRmcmsddWScc5g5O/GPxeBAwqLgv5BV09cad0jA2vWsB
 kTVNtj1T3HvBLbJ6UYBjs=
X-Gm-Gg: Acq92OF4aTSoJkTL5bfCBVB2eViWuXeHQLtQbQ5cmuuqAKG7iP+76JNzjdg0pAqQnFY
 5CMsC3nqaJKuRdjgOofAWi+ShBgkSzU4MZBhOI/tUZ6ow7P5HEUgmcfx43n+5Qk3Vab3d4VcDfS
 Y8rvlYl3KdXK3f5PebxySWMb0v9agbdcVhtfzkS9hJrgSS3NV+vtB86gQcmPe11lh9PBs54ucZN
 WvIOSdEpGifAmopeNi9tEbA8vEjYhb6kECjJlnh3h1bJP8u5T6bnPsu8l+YYH7DDTrmhuYAgu3g
 pRYL
X-Received: by 2002:a2e:8198:0:b0:393:8ba5:3d01 with SMTP id
 38308e7fff4ca-39664f95574mr357101fa.22.1780069930632; 
 Fri, 29 May 2026 08:52:10 -0700 (PDT)
X-Received: by 2002:a2e:8198:0:b0:393:8ba5:3d01 with SMTP id
 38308e7fff4ca-39664f95574mr357021fa.22.1780069930194; Fri, 29 May 2026
 08:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260527075654.3780732-1-david.marchand@redhat.com>
 <20260527075654.3780732-16-david.marchand@redhat.com>
 <124390f4-6c99-4782-9161-545752784ee8@huawei.com>
In-Reply-To: <124390f4-6c99-4782-9161-545752784ee8@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 29 May 2026 17:51:58 +0200
X-Gm-Features: AVHnY4J0mC3quIIRBqSAek5bKbERjFH5j9tNV19A-LrhJGdOLNt7iIP_zGpdvqU
Message-ID: <CAJFAV8zVY3n113vSL=X2juZSanbJYXpQsprALQMAhLq6GC9TTQ@mail.gmail.com>
Subject: Re: [PATCH v4 15/25] bus: support multiple probe
To: fengchengwen <fengchengwen@huawei.com>
Cc: dev@dpdk.org, thomas@monjalon.net, stephen@networkplumber.org, 
 bruce.richardson@intel.com, Parav Pandit <parav@nvidia.com>, 
 Xueming Li <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, 
 Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, 
 Sachin Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@altera.com>, 
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>, 
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JYZ4v7eCkNztgNq8sEQ03cjsGZuu6e9_vPe0YHgxcGc_1780069931
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

On Fri, 29 May 2026 at 09:27, fengchengwen <fengchengwen@huawei.com> wrote:
>
> Currently, the bus probe is still the specific impl which don't test allow_multi_probe flag.
> And local_dev_probe only cover the plug device case.

Oh indeed, good catch.
It is fixed later in the series, but I'll fix this patch in v5.

Thanks!

-- 
David Marchand

