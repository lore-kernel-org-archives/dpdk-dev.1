Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCED2C79F8A
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 12:50:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCDCB40613;
	Mon,  5 Jan 2026 13:50:51 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 128884026F
 for <dev@dpdk.org>; Mon,  5 Jan 2026 13:50:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767617449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H8RxXLjMSBH//sk3JQZ7qh7IiJ0AJWCmmIZaq86ygfM=;
 b=V40iN9d77nnZNxWWZRkAzBt0V9Pi2ZAN6SXViMAi1knySeke1jv3J3LTzExnQdpNKqL6kE
 hI0AVSEYjNsUOIFXr/dxYkWookOsp7i/FjSB/+5+Lg+i2Wy+hgaKAzk+ojOzLM18gdD6wG
 H/CZtJqeEUzlZPNddS0ovPJ0Dd9s4do=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-ssHLYFljMFigiBXbJ5N3eg-1; Mon, 05 Jan 2026 07:50:48 -0500
X-MC-Unique: ssHLYFljMFigiBXbJ5N3eg-1
X-Mimecast-MFC-AGG-ID: ssHLYFljMFigiBXbJ5N3eg_1767617447
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-37fd49d4907so67524641fa.1
 for <dev@dpdk.org>; Mon, 05 Jan 2026 04:50:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767617446; x=1768222246;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H8RxXLjMSBH//sk3JQZ7qh7IiJ0AJWCmmIZaq86ygfM=;
 b=DFvuy3H3PZVW8iFpqxdrDpR59JFFGQYBopbUv4aFel+n/qonviZAnggwVdbk81tlAC
 bXVuRlcxBy9U9lcI5+JVqug4kDpjEZoC7rAVjdUBgxXv3094xi9khbEiLjkT/0C0HHwd
 T60yd4pv9E0pz2FH0iv3bhcDZE3z3R2ZknoPYXISS69QlBwoo8st2Umq219CJ6ZAxPSI
 uTgJILqngskju6cPQJ5USMz0GYOtRySZlTlWCxrCA2ggXOYCxdkswoaLnaK9Vz3mPWS8
 VBoylZJ7fkghNiokm52anCpu8PgVbrTLhwZSmPX0FQJroD7M6jZdtW/Up9hdg20QPGPr
 O7jw==
X-Gm-Message-State: AOJu0YzidV8OB8PWDWNj9SKfuxDNBGwDhuPJjhvdfQ3ZsV9HgtQukGgl
 dLHnMJph/P/sthqOBM+W93Ba9zbUkEDhzLxRSJMwk1z0hFhWPK0QUPb/WShXJs/5U5cpkmWiwS0
 ZjJt6+AemlaTMg+Q5YN5bSDLbgoHA1TAiwXoCZxmJnF2L/3LFlQLCi3xMD2oULFhqqlpFtBzMk0
 M4Dfn91ZIqqqi2TjoZgo3pRtWTi18=
X-Gm-Gg: AY/fxX6SJtzzjzrHCZrQWL0HKux9OPGlPueYUCT9IXdbKTjEDNLDYd57l+cmTl5ypfv
 AMAl8lrBc20TGOkU3vJTqiKYZFUS56WdHNNcqYCsOB5SwlmnR2AvnOF2pYfOFk5e61RA5E5/jxx
 cKobk7+oUX0AnBys36oLkFqHZ5Oh2CsQcYpz+fUuiB6+c8surBH0KhD59oEtpc84t7VZRI
X-Received: by 2002:a05:651c:1443:b0:382:4d6b:993b with SMTP id
 38308e7fff4ca-3824d6b9c18mr115244181fa.35.1767617446349; 
 Mon, 05 Jan 2026 04:50:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvy2VTgeh8+ZJ1q1VzYyVB2monJczoN/Q625Qj9agaBnacuVg4h2tM88gH3ZoVV5rkcU2gXwk/3qBhwZlH46E=
X-Received: by 2002:a05:651c:1443:b0:382:4d6b:993b with SMTP id
 38308e7fff4ca-3824d6b9c18mr115244081fa.35.1767617445886; Mon, 05 Jan 2026
 04:50:45 -0800 (PST)
MIME-Version: 1.0
References: <20260105123640.48325-1-david.marchand@redhat.com>
In-Reply-To: <20260105123640.48325-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 5 Jan 2026 13:50:31 +0100
X-Gm-Features: AQt7F2q9tbXPtj4RcUIDmqoMLooE8doWCt_LCCfUavyYbfyfUJ0ONsd-6XHq1Us
Message-ID: <CAJFAV8yOrbgZCo6-BFAVt_0SKUZT1nFm29N1RgsBOk1DV6r5GA@mail.gmail.com>
Subject: Re: [PATCH] net/tap: remove log when running without multiprocess
To: dev@dpdk.org
Cc: stable@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>, 
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Kumara Parameshwaran <kumaraparamesh92@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mKF76x00DXjHGV9OOelz_kmFRATOjKnSHSlw1sDtySU_1767617447
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

On Mon, 5 Jan 2026 at 13:37, David Marchand <david.marchand@redhat.com> wrote:
>
> In case DPDK is started with multiprocess disabled (like in OVS), there
> is no reason to log an error on multiprocess aspects.
>
> Note: the only caller of this helper does not check the return value.
>
> Fixes: c36ce7099c21 ("net/tap: fix to populate FDs in secondary process")
> Cc: stable@dpdk.org
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>

I chose to simply silence this warning, though I think something is
wrong with the sync mechanism.
Secondary processes should be the one requesting fds, instead of the
primary process broadcasting to all.


-- 
David Marchand

