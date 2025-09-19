Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22391CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 08:59:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BCCF402C1;
	Fri, 19 Sep 2025 10:59:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6ADB7402B7
 for <dev@dpdk.org>; Fri, 19 Sep 2025 10:59:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758272344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DP9HPMo978S6W7ijYTmO10y1UI8tjzbDGCBDH3BatzY=;
 b=OdpAZK8/QicZqpyeQw5MHf88qtu2B0SS5NjkdnU7RKwTCJaAybZ9pwfSakjdyqc0R+P6d0
 sfNqS1EJZPO+LK8K3iHg3EhbV70Ld5lvjrS3q20eHlfC9JTyywiauaXX5x35pLBXciHNpW
 dGIdnDWKu54EYkYNAxPPaBgCbKvgzkQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-Oii-IpSfOm-HhCwqLwRA2Q-1; Fri, 19 Sep 2025 04:58:59 -0400
X-MC-Unique: Oii-IpSfOm-HhCwqLwRA2Q-1
X-Mimecast-MFC-AGG-ID: Oii-IpSfOm-HhCwqLwRA2Q_1758272338
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-350dc421109so7726101fa.0
 for <dev@dpdk.org>; Fri, 19 Sep 2025 01:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758272338; x=1758877138;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DP9HPMo978S6W7ijYTmO10y1UI8tjzbDGCBDH3BatzY=;
 b=CKzd7Txpvd73VJDPcsbJYwJY4DHy8sqPvCalXn/aU7SxfAxBJZ86IPQZfO/Gm1dgyb
 795zcJ2fMd1ci+K6FdaVEhdK6xaSlKzz64fnUzGfLGbeUl22BIazszl299APx6JBUKKo
 03UzKFLZ76OxT+mVwoLxBhqndxpH8gZJIXVjsO8DxspWMvNYxQmXyeAHFUruRrs6IFlP
 QoLfwauYpwTrv5RZT0asFTAGEcrnI1MocqdflPgz/ioHZZ5vedrAvpZoWZJ/xYHYczNc
 oe5FItgnCxvRXIK0+uyAfics9qI26jRT8Q/LsFTS1JcXhe0dTCSTRCWPYX0GLfn99vBU
 QLmA==
X-Gm-Message-State: AOJu0Yyu/EWeBbg8tL+aWE25xlPi4i9hIY/sErg6RPDJbXlFxDmjzs9z
 mlUhffOOBgRkzJ/nL5dqeHztN6eerJcC28MkuaIrk3ZIbxcYpgU6tuGauOjmGySnwnsS8ye00AC
 8mKrABbd1gJcphAYL1DBuXHslv1BizGI+w48I6WOXP8KNf1cCTloumyZlyhAQvuMDAvaxeduVOt
 pOOMC/UNBLnm/XYcWGymQ=
X-Gm-Gg: ASbGncu/6PzQ6DIz6tkc0e0Rl4hYLqSgzFT0TsObzHMlK3vGD3a7Y2C7aUmSFEuCQwQ
 ktOqKgLEqF9U6VX9Uuf4p/aNMCQlQzRyBEei9SJwOakEkgM9NpPYAzmLQvITOoJh+GbsQSDmaG6
 iz2rzIWAHKZNnNDqt0ZS3jdYc=
X-Received: by 2002:a05:651c:3257:10b0:360:5e8d:c85f with SMTP id
 38308e7fff4ca-3640eae2646mr6065311fa.0.1758272337551; 
 Fri, 19 Sep 2025 01:58:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8dSU5Y0LH+UHU4dBdbIFQ3ZexivFHs7AfxoMRaQHVQUWW0Sf58y7LYY/blbkkPCjOsfvGP4Ha2/98R5Ymczg=
X-Received: by 2002:a05:651c:3257:10b0:360:5e8d:c85f with SMTP id
 38308e7fff4ca-3640eae2646mr6065231fa.0.1758272337151; Fri, 19 Sep 2025
 01:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250919075654.220920-1-bruce.richardson@intel.com>
In-Reply-To: <20250919075654.220920-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 19 Sep 2025 10:58:43 +0200
X-Gm-Features: AS18NWAR-_vZuI4w2edhzbxo-R7ftShnsKm7pVUiKqEY4OIEDqTlvLaPRZRPqRg
Message-ID: <CAJFAV8yqz3jO6goA9PQaOns2Rxh2X2Df5Ez-NdEaUm7Ek6Mj3w@mail.gmail.com>
Subject: Re: [PATCH] telemetry: remove deprecated functions
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, guevenc.guelce@sap.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: o6VN70YYcLJ4YcqPfKaN9uXyAaXCqhH9joYdjRNMRm0_1758272338
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

On Fri, 19 Sept 2025 at 09:57, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> The "_u64" telemetry functions were replaced by the "_uint" versions
> back in 2023 [1], so can be removed from the release.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

With a release note update,
Acked-by: David Marchand <david.marchand@redhat.com>

Cc: dpservice, fyi.


-- 
David Marchand

