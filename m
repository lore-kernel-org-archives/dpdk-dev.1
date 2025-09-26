Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82543CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 14:16:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C21D540684;
	Fri, 26 Sep 2025 16:16:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 47B3E40667
 for <dev@dpdk.org>; Fri, 26 Sep 2025 16:15:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758896158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F3g1XOhZOWDvlqdmaBXF5g9m5sIG/E8604EBMi4AKZ8=;
 b=NiAiEL4uxClpSB2ra4iCscDn6XUb97KRwmFU/CJ26CKle3xvJhzWw4FvZbeGXjmvKYxRz2
 Tm2p7ERCJocCZ0izLlNBGnDljbkGxvYFZxYmRLt41pvAybGdAM7fW6xAv1H74hpE5m3gMY
 SCPghOFEX5ay6sKwjjI2t7nL+lcvTYE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-ym3z_lMoMsmIqZFDEyz6Tg-1; Fri, 26 Sep 2025 10:15:57 -0400
X-MC-Unique: ym3z_lMoMsmIqZFDEyz6Tg-1
X-Mimecast-MFC-AGG-ID: ym3z_lMoMsmIqZFDEyz6Tg_1758896156
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-57dc4a84641so2777660e87.0
 for <dev@dpdk.org>; Fri, 26 Sep 2025 07:15:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758896156; x=1759500956;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F3g1XOhZOWDvlqdmaBXF5g9m5sIG/E8604EBMi4AKZ8=;
 b=KwS5KBrh/oQ0w80E0RxHNBJf0F5By/y/NFfMvxkCZNEX40pnCpXNHXEcg3YBMO0yAn
 ZB7yAk9nPKskoMqK/3DYYnjXO7lMBRRWsmMqcx1OAmzywSDFSpZuGYpEX/MJ2P+xt7zQ
 LFawJoTmIaS5gN3DI+3VKeigkjl+oYbARkuLF0Qny4celocvAC4WoWM16j78JQDdzA6Z
 97OkU4/kja+CnO8MeIXHpmU4IteDiyA+7aDx/19GUMeexEfv3kDHAHDB4jcOIvPI1UQv
 7USoC1IUHxEtVx7OMFG6RpmxQeUl0G11dvUZ6h7Gu2kjVPxvzZg6hOVPnCYsMg49HPes
 YHfQ==
X-Gm-Message-State: AOJu0YwqJ2GAfm6WAFQJaCCgbVoJyvlknZUsLbM4arQ4H6j2JnnukIK/
 DXPw1w5gj18nizAPDRrWBQTBnHteBAxcRfc0gc2Be09g2HzjkaNq8RM7Ty+d/GYBQrDZ0uQjQka
 vVCl2kVq/ruuGkTac61+onkbwDxKnMYCliG6vqiBbmcbS8UZyhTJZaD176ZOhm/2NRhbtozK6iz
 YRKL1imJs6fkdmF+3mVpNCXZkcmjA=
X-Gm-Gg: ASbGncsONnGc/dhJ5jVmXgVl9p1oKeHfqnSWiBOjWms35NxsjM/lO6AUSqt/bo05B2R
 gNymArCTJseA21EQBdixHcOWkQMb8EExAEWVEML2syvWq1tZtU+XtyC7doK2BF+SpwPRrbYl/Zd
 be2CRBO9eUH13YGjSht04Qv6A=
X-Received: by 2002:a05:6512:a96:b0:578:f6eb:e466 with SMTP id
 2adb3069b0e04-58301e3b3d3mr2185299e87.0.1758896155690; 
 Fri, 26 Sep 2025 07:15:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrEByMsoWFf55qvo8HJ2cjwzaoMGyntP33aG5KXbfmGpNg8gnRmiqVDg5ZA1TPsnqm6wvSwgGaIOW5Unfe1Zw=
X-Received: by 2002:a05:6512:a96:b0:578:f6eb:e466 with SMTP id
 2adb3069b0e04-58301e3b3d3mr2185287e87.0.1758896155197; Fri, 26 Sep 2025
 07:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250919075733.221023-1-bruce.richardson@intel.com>
 <20250923144000.13570-1-bruce.richardson@intel.com>
In-Reply-To: <20250923144000.13570-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 26 Sep 2025 16:15:42 +0200
X-Gm-Features: AS18NWCK_WInogFgwc8N3DteY-UtXaQT8qNQ1X06igtqknbcZW66H0L3AJrCbqE
Message-ID: <CAJFAV8xZJjksyC-7OVe5V0KmAD7kS7J15sdoKzjA5ith_ZKCnA@mail.gmail.com>
Subject: Re: [PATCH v3] build: remove deprecated kmods option
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YfdNyGtt9H3f6c2sfta4ORCzLl0I5U8J8T5Y8Nw8Rzw_1758896156
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

On Tue, 23 Sept 2025 at 16:40, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> The "enable_kmods" meson option was deprecated back in 2023[1], so can
> now be removed from DPDK.
>
> [1] https://doc.dpdk.org/guides-23.11/rel_notes/deprecation.html
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: David Marchand <david.marchand@redhat.com>

Applied, thanks.


-- 
David Marchand

