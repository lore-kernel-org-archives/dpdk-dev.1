Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2DFE9A04C
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 08:19:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E61FA402CC;
	Thu, 19 Feb 2026 09:19:50 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8D44A402AC
 for <dev@dpdk.org>; Thu, 19 Feb 2026 09:19:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771489187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fegums9b61Q6vFkv6h9fXtIc9FVieLK9AKZeZRkKjkk=;
 b=USC9etUrrB9T2p5/MXT2ubmfQi69On72tjtKs/dc2lha8FuzYHutPp6B2CEDDbHcDMNYvX
 Kz7ZQ6I3uwCAidQjWQlza/TzUuxaZ5KQ254SXofO4nfT6VWeZyBmZrkMS3hZd1C24Zaidp
 rUA3sTk0MbJlI3PTCXfn6pNd9iiBp98=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-NiLEA2cnOYKNlsLPJcqhuQ-1; Thu, 19 Feb 2026 03:19:46 -0500
X-MC-Unique: NiLEA2cnOYKNlsLPJcqhuQ-1
X-Mimecast-MFC-AGG-ID: NiLEA2cnOYKNlsLPJcqhuQ_1771489185
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-59f855fc6aaso1488291e87.3
 for <dev@dpdk.org>; Thu, 19 Feb 2026 00:19:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771489184; x=1772093984;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fegums9b61Q6vFkv6h9fXtIc9FVieLK9AKZeZRkKjkk=;
 b=gItNulDfRyKlEnvk8Cl4IrOJWQq6BQprkKDIumSbgTQYT8hba4M3bzHz2ur5qQddPG
 sBGm+I0/B3zcXIqJ6Jk6pGynxUv6Qp4L3xxpx7ujpTRan6BAFs0VXaelSl7jHKjZXuPO
 ZlFFvTzlTNh716ud8UFOc7coKF7XzMMG+JTQT8Ggf2wvdXxf0h9GbCbZrRC3A8VeW1E9
 OG8CknqKIKfVJPOG+LTQe/74VlIvXCCwCI7eWK1nOKeVXfpzCX8gs39vDk9JCg9NE7Mv
 r1iy0w2/e3yYKtgKgB958fttmsGHdH7pefEuhydM0+Bf6SmwlT8Z6UIPfrSfoGVGv0j2
 v8lg==
X-Gm-Message-State: AOJu0YwKLYva0J4fNIKdqPf2iqGJMKa8MoruNsldvBNhkBAvFO2maKwE
 REIAxfeDyKwGxf05FHoE+D6kkGQYMcmBkIhrk4qSvKMW9i/K7O/+BZjrV+0r5LjLW8/3WLMAljl
 63ozQxLRpR6tpmxiPn8j6DCQJZtHlNr6Y6mMbUcJLTVRRlq3b/9kkaCahQnWlAMhnsjJBzD+Huh
 SHrwsxxBQ8+k/wjtuN2371rkixZS28gA==
X-Gm-Gg: AZuq6aKF07iRY/DLDEMIII6jVhElzOl2WfDS9yPMGzxOjEpBQcJJzwTL4H8JC8l9aGc
 47nwyiP1Yp+hGwyJYYeOatGi/QkJy8FQTud5HcGYbzdPVke0vQLwD2ejIib9T5Vp/pUL3It2Hfe
 SC+pLH+1vJd54BPbj+1ZA/44WZ3/55S9cyn8+uC8xqy5wwexmHYhFUvpQ4tmzJPlac4RU5qocsH
 /mCbOc6k/UawR1javCnKwtBsiFdXJuNt/YaMQumt4wGq/9hlCXuCqCMHGhvi4quwYfv2A==
X-Received: by 2002:a05:6512:238a:b0:59e:538c:cd9f with SMTP id
 2adb3069b0e04-59f0282a181mr6862743e87.42.1771489184266; 
 Thu, 19 Feb 2026 00:19:44 -0800 (PST)
X-Received: by 2002:a05:6512:238a:b0:59e:538c:cd9f with SMTP id
 2adb3069b0e04-59f0282a181mr6862740e87.42.1771489183787; Thu, 19 Feb 2026
 00:19:43 -0800 (PST)
MIME-Version: 1.0
References: <20260218101859.3028581-1-david.marchand@redhat.com>
In-Reply-To: <20260218101859.3028581-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 19 Feb 2026 09:19:31 +0100
X-Gm-Features: AaiRm51NGQBUYF5rDvaSwo-nKxDa_5Rrq-gycwsi1YqMYbjSYNFHdLTAM6iVMBc
Message-ID: <CAJFAV8wdMO=d9J-y1gf9UAsM9ZR0pq82h4gn+n+eWLoF0fukyQ@mail.gmail.com>
Subject: Re: [PATCH] eal/linux: fix HPET symbols export
To: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GKH3xRWVRcVMGM8nun3XMcRdoiBXg-wsqrbcrQLu83g_1771489185
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

On Wed, 18 Feb 2026 at 11:19, David Marchand <david.marchand@redhat.com> wrote:
>
> The .map generation script has no clue about build configuration as it
> relies only on the presence of RTE_EXPORT* and RTE_VERSION* markers in
> a source file.
>
> As a consequence, Linux eal_exports.map contains references to
> HPET symbols regardless of the use_hpet meson option value.
>
> $ meson configure build -Duse_hpet=false
> $ ninja -C build
> ...
> $ grep hpet build/lib/eal_exports.map
>         rte_eal_hpet_init;
>         rte_get_hpet_cycles;
>         rte_get_hpet_hz;
>
> As far as I have seen, superfluous exports have no impact on generating
> a shared library with the GNU linker, yet it might be different with
> other linkers (MSVC linker would complain, for example).
>
> Moving those symbols to a dedicated source file solves this (non?) issue.
>
> Fixes: 57c194d142d9 ("build: use dynamically generated version maps")
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Recheck-request: iol-unit-amd64-testing


-- 
David Marchand

