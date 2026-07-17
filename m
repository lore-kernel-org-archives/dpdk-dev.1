Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336A8C44515
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 08:47:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DD644028B;
	Fri, 17 Jul 2026 10:47:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 68B744028A
 for <dev@dpdk.org>; Fri, 17 Jul 2026 10:47:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784278020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h5yPDGsGll6x78yW6EMQjrG5kbwIvYZbITNUAc/kGaQ=;
 b=Mj2zEso/LPJgzU2OOI9HTgNSs2u+lnT3JIgHxK4xe1ODYqOqKH5z60Rk/zgYZ6rvr1RyrV
 nFTQNjNac0//QTRpbp8o3kUk5rCyoQa9gaa2Yvhbqdc+2fLoYaQ5DTY6yBpywDjHCQcP8k
 p2R4v+JPg0ebAQM/rleOqaoPDjryXG0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-82tKoC_ROQuqEvXljm7SpQ-1; Fri, 17 Jul 2026 04:46:59 -0400
X-MC-Unique: 82tKoC_ROQuqEvXljm7SpQ-1
X-Mimecast-MFC-AGG-ID: 82tKoC_ROQuqEvXljm7SpQ_1784278018
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5aebe29f8cfso1370943e87.0
 for <dev@dpdk.org>; Fri, 17 Jul 2026 01:46:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784278018; x=1784882818;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=h5yPDGsGll6x78yW6EMQjrG5kbwIvYZbITNUAc/kGaQ=;
 b=g00xUfEukQQzKrM+cNHjabv90RuE1O/eixOfMqXAyb6sMUpNrInZ6/MPTLW2i1SfS5
 c9Q2t/6jJSTPqKgmNZcnjuD2fIeVUH21bZdPn5Lvh6e1nXy+c/Uq02gd93KJ3hbo1TO0
 9lHOtoxixiXGvLj8WdJlFb6bwCgIxXCjdugJX5+Lb1aHKjmnETFo+XC2kjzKqUqinWW4
 E8hXLk1KBJTWOrFjuDNH1RiC06W+V6pv4owJIqOHXYRD+L2YAH5FsvcMTrCoMYD8m9wJ
 jGaOMK8v/CkvMdV8RKUYp8xev2OI0cwbD3DjCA/adqI9VpiCB9CVTz828ttUruZbEooH
 sqwA==
X-Gm-Message-State: AOJu0YwjFvQnxPU7KBXbK0/4lf8z2SMwkMdqAqspVs5evifpafyhfF4V
 YjPSp6Njnomdz9xLzVQNRDnACeD+yjdeZRIKFp4Dj1uVj1osFs6ztZRdqGCM8bDknWUo930s2NJ
 trEJdNklkP6kAXcD0LSiXb7eS6U9TVQHBHEhCCXbb6oAFWKpgOM+Zq9SsCpbD9LVZm2vF0D4wAi
 3YjjILuZGSL1IVqHNZIk4=
X-Gm-Gg: AfdE7cm/2CDQjUbUPc6WCyM0Fr2BPeZz36ASbAWVuddgcfXJsMrooXocfqS8xQBa3IX
 wCFNcL/cM4hLyahnFQlPIG1cpwVGIyGGVURE7EEwfYCivDKM/Au5qviNCVaU5UG5E6r73nGI/8S
 Rnnb8zl5NsgYsZM7yVj6LisbnHwmRyDN4Srj1y4J7VkaDP7nG4R2DJByct4r2nFCP+kPbLKV5+l
 dqDdt+PgtbeXfkJJ5evMQOaYcv8WPDnShPQOF5MeyZ1woGD
X-Received: by 2002:a05:6512:ba1:b0:5b0:6343:a298 with SMTP id
 2adb3069b0e04-5b28a15cc69mr1334579e87.7.1784278017649; 
 Fri, 17 Jul 2026 01:46:57 -0700 (PDT)
X-Received: by 2002:a05:6512:ba1:b0:5b0:6343:a298 with SMTP id
 2adb3069b0e04-5b28a15cc69mr1334571e87.7.1784278017173; Fri, 17 Jul 2026
 01:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260715105959.2216756-1-ciara.loftus@intel.com>
 <20260715122045.2256082-1-ciara.loftus@intel.com>
In-Reply-To: <20260715122045.2256082-1-ciara.loftus@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 17 Jul 2026 10:46:45 +0200
X-Gm-Features: AUfX_my6etB38bHG2kyTRg8sIohISHxDOWYuE0RwTN26IfqRJN1g2ElMP5AORoo
Message-ID: <CAJFAV8x=gV6oUSA88cc4mEvqEOCown0wC5sZJX0o8TQTLtOCCw@mail.gmail.com>
Subject: Re: [PATCH v2] doc: add deprecation notice for iavf devarg auto
 reconfig
To: Ciara Loftus <ciara.loftus@intel.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qrwXSZtER6QmHvSzeIg1tOijbOoMNsjRQg2voYp14pc_1784278018
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

On Wed, 15 Jul 2026 at 14:21, Ciara Loftus <ciara.loftus@intel.com> wrote:
>
> The `auto_reconfig` devarg in the iavf driver is enabled by default and the
> case for ever disabling it is weak. When disabled, it means the user is
> requesting the driver not to restore settings (unicast/multicast
> promiscuous modes) when recovering from a reset. The use case where this
> might be desired is during a VF initiated reset where the user initiates
> the reset and wants the VF brought back up in an untouched state. That
> scenario can be facilitated by extending the `rte_pmd_iavf_reinit` API
> rather than relying on this devarg, so it should be safe to remove the
> devarg.
>
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

