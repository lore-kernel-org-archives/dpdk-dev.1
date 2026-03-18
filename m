Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4FC10854D0
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Mar 2026 09:07:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4867E402A0;
	Wed, 18 Mar 2026 10:07:34 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id BFF934026F
 for <dev@dpdk.org>; Wed, 18 Mar 2026 10:07:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773824852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6poX+hjBxMkYdN5GWbDILSBRXdW/l0E80be/7GCXlE8=;
 b=HKjnIhIA0vbRZ+d82qzm20lYaiL4u1P2iGL13h9F0DMLc7eTljAMab1US0fOQFtoF/qjbD
 XyWBgXyS4gaKsb35gJjAYfk+M0jRRfzHFuNNMztg0GEb9DQt2B7a4b4dHcacg+YcnzsS3f
 sgyE0Nn/MWiNTiFlvgV1J0p1JD3ySOs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-moXyx7n3OZCivPNlj1Tfgw-1; Wed, 18 Mar 2026 05:07:31 -0400
X-MC-Unique: moXyx7n3OZCivPNlj1Tfgw-1
X-Mimecast-MFC-AGG-ID: moXyx7n3OZCivPNlj1Tfgw_1773824850
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5a2778d515aso432287e87.1
 for <dev@dpdk.org>; Wed, 18 Mar 2026 02:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773824849; x=1774429649;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6poX+hjBxMkYdN5GWbDILSBRXdW/l0E80be/7GCXlE8=;
 b=P5HVkgmstE2MuFytfueteYoeLJHMJ5/VJPNGiWVlXHFIci6VAIQ3x+1dL6a27IUFoP
 /aSVZ6L7QYkpjMzq6ndsLfxWYAplMiWdfw0Q2nz0lMZYt2MDj/0c18i0RPeqwNLxTsVA
 vJK1X1rU7wW/Om6XhKRNP6GkJmQ4SQtmuZ0lIvCpXfG93lCBpitrwiljwOdJeXnOlWEK
 PG/QJ6xPnbohRZhIjH9+JDzABq+g+VsJmSELiqrkhPYXJyH4y2/Iftcgr1/jFey8hucX
 CTmyWND1N/gabVWMCGqcu9AWARanOAJPSas0c+4x942s3F8tbcKUCeHiT20AQ6zyQg01
 pHew==
X-Gm-Message-State: AOJu0YzfQX/aqcjBzuonss4uQ5pzvy1c9XjMTHposa95Jk7r0lhdzDE5
 I6M3B7Jq8PlzR/AM1+SwkgoM6xHxw2wqOY7aiaRVnqDG7abwDayVAK2b2MJ7N128mBULsjL+s0Q
 ZTG6QxmGBLK7ku8r2tQEUasS+HTHzsjGlpc/SkbnOHfGlwVLdybxwo/SbTmugBFYkkuHY5yp7dq
 ZkbgZG0gu1kfRftTEZzyo=
X-Gm-Gg: ATEYQzxC8bFjN6wX6GmAoqzlxlg+p7Uax+CB3NWM+OL0GRgCYYYN5+KPSi6+LbOoeyq
 OfrsXg7L09o7isnkpe6ti2E4wV8TuIzMaUfpaKskvVwbydcqqk3kWzZUBM6G3mJPKZPSy/yip4C
 sq1oyR43jkaOVPOFve5+2ADvQYQj2Vwa9goZHm3OqOhfnf69UmfI2jgfoBVbYGKdQbcjlznY2ih
 KSw97mo3vAmfSu0mH8PVo1AXbVjPi/g1rtMN5l2I7YRIGvq6FU3N7w2GdmcPEQule0SYQ==
X-Received: by 2002:a05:6512:3786:20b0:5a1:334a:dd62 with SMTP id
 2adb3069b0e04-5a173bc0365mr1613651e87.13.1773824849448; 
 Wed, 18 Mar 2026 02:07:29 -0700 (PDT)
X-Received: by 2002:a05:6512:3786:20b0:5a1:334a:dd62 with SMTP id
 2adb3069b0e04-5a173bc0365mr1613641e87.13.1773824848941; Wed, 18 Mar 2026
 02:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260317203856.3a4b208e@stephen-xps.local>
In-Reply-To: <20260317203856.3a4b208e@stephen-xps.local>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 18 Mar 2026 10:07:15 +0100
X-Gm-Features: AaiRm53hMjyUjCPkX11J1QJpyobKNRMyi_C1BCQ8TM_uRws248HxCwPhAF7OG1c
Message-ID: <CAJFAV8xc=06CCWgCD+PTFytQekzdqpP_f2dnbjsJfYgDvY2P5Q@mail.gmail.com>
Subject: Re: [PATCH] test/tap: skip test if tap vdev not available
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Luca Boccassi <bluca@debian.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xwLLXoLbDBldAFXpyqKtYB3pFtNGvoUnaqOzliO0xe4_1773824850
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

On Wed, 18 Mar 2026 at 04:39, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
>
> If tap can not be created, mark test as SKIPPED not FAILED.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Tested-by: David Marchand <david.marchand@redhat.com>

Applied, thanks.


-- 
David Marchand

