Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51B2C982EE
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 20:19:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEE7740E2B;
	Mon, 21 Sep 2026 22:19:38 +0200 (CEST)
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by mails.dpdk.org (Postfix) with ESMTP id 5018340B94
 for <dev@dpdk.org>; Mon, 21 Sep 2026 22:19:37 +0200 (CEST)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c294496989aso466052366b.3
 for <dev@dpdk.org>; Mon, 21 Sep 2026 13:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790021977; x=1790626777; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Dnb44K/n/ECsVDt6eMWgoZmbPiD92VpBdzwCjD9FtsI=;
 b=XeGn1ZwsApUl6LCsRNA87gdSWEtNNHDSBMf0zY4smtQGDz3gvdCyAR42SXfIShsKzD
 ly6RfM2CmyQYjJBn8Cxvxjtr6IQmFMID0Q8CycWV5k0f4pxOzMEP4dNapL2TZzOQKjIa
 UCcdzoDtx4GEJPebRDEAj3bQmfZDBgkQ/IFbLh3LJxJNkCJgOFQobkpJPrIPe8iibMa6
 JNHulKexz/MOBqySYsW+dlyTmsOXpRnBdSStE8r8t8KIuy1H2lb1DbVo902u8ePP4eVK
 rBL99Myi8dV0b6mJxsz0Mo185DwioTF48ObG86kfnJAWbAWYFGFzCixHPANL420eMcFB
 O0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790021977; x=1790626777;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dnb44K/n/ECsVDt6eMWgoZmbPiD92VpBdzwCjD9FtsI=;
 b=rDMzdXAceHyaejESoW4iilrZFKznLf/7Yhj24bAO95wzFui7/BQ3xTQKdjfl4BBhiy
 J+AG7YHpaKcv2HPurMqNisyTF6zbIyPJe8ZctJzuYHZobY1wYwh9wuiHc9aHMt9MvJ3U
 3SLbmNU4mKWbEqvVezKPuGGzI1ZdMSwwYuGodY4BunGkeYnHTH/woZPWZYE6YGwD6uba
 ApE1WMoyKKFiRg3HJpwlK7D60mv4nDuGfIL9T8SxMjgmAVrwYP7Y2cnte+CAdzfs7QXZ
 OFdBSkfjWtxl2F5tW/u3tnD+zB89q8QXs2iTAyEbz/d2HA+9Q6GJiqRR0IAI0cb2f+js
 I4ig==
X-Gm-Message-State: AFuF++mmvIBwHN+A19BW7ZDapMd1UiDI7f/Si9GB23WI8YhvJj4a6ub/
 Wa757R8ay+sZoJTK8Kgr5iepcao2hn6AwlEbH9Pmzg4vHSYq+R7/GVsau1tF7Tzv
X-Gm-Gg: AYBFou2Lo0ewrZ9L7HV4GrbAGwJFffmTG0PZsnULwlBJ9YPTgLf6vRUnN5jBnDkIDyy
 +lHP00A279DLg5c1CQo/RkQIGyajtRkOx/KZWQMRwwmTa1L2Kl+yz5Vi3zN/fv6vZozMbyq/yye
 1weS06uetudzkb2XefKknznCs0Gy5poyxwKaxLIdVameAA7lWkJkV8E6oVdIE5gEe7O46lEOWTr
 cU5i9KOZdLhzTJxNwhw70/6WkMleW6qs41BPSCqFXcJMKrBBLr3EAYYraTxYTmEBWGbmYw6kNj3
 uSxcoa8FOkHX23LhwQaYfZT5oplhW3SfUh7JSebLRvmePNsQ5Ms743mLooNFaik6kn8+ZaIKsIx
 vyEHcKiwKeaeunzn7rTUjtbIpfuKwKvGWDbAs3jD7/WKtyhLsisjJXnWHBinSwfVdqjrvaa6Kk4
 /hElA9+uw0uiO8LuRy7K6o6Ycsr3YBQjp72flZ/yB+Bt/A95KNtrmSUBXyfHNPdSULIg==
X-Received: by 2002:a17:907:1c1b:b0:c25:62db:772b with SMTP id
 a640c23a62f3a-c2a15846850mr1078981766b.7.1790021976784; 
 Mon, 21 Sep 2026 13:19:36 -0700 (PDT)
Received: from [192.168.0.78] ([80.233.40.14])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2a963188dcsm991166b.45.2026.09.21.13.19.35
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 13:19:36 -0700 (PDT)
Message-ID: <443ac4e6-d070-4709-ae6a-6bb5c25f73c4@gmail.com>
Date: Mon, 21 Sep 2026 21:19:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] bpf: make bpf_def.h private
To: dev@dpdk.org
References: <20260917151916.48749-1-qm2k21@gmail.com>
 <20260918092117.74231-1-qm2k21@gmail.com>
 <20260918092117.74231-2-qm2k21@gmail.com>
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <20260918092117.74231-2-qm2k21@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Error in ci/iol-unit-arm64-testing does not seem to be related to the 
patch because it is a different test that fails, and identical v3 
successfully passed CI before.

