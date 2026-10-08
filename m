Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3223ECA600A
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 09:17:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1539540274;
	Thu,  8 Oct 2026 11:17:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6D2814026D
 for <dev@dpdk.org>; Thu,  8 Oct 2026 11:17:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791451048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IKt4VYfcpydxku6lhRWf+DSmF+F4RBneXt+6kUl3Wb4=;
 b=RkZKocnYoeFsmAJ1j1nKFffxLp8wam3tAEf01doe24bbN7ON1sH+4UH6yv6cvJJxBbBTbJ
 UHVR5UOEbYcMMUaTzqrqEfX+vwrcLtDmQb652y8VnpamzcT/tSjTV9YjZZBsQ0ojsHkF5V
 aLuYPhXZAzmeFOjc9T8/VwDdOuNfQo0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-725p8ZQbN4K7jWK9FvlDkg-1; Thu, 8 Oct 2026 09:17:27 +0000
X-MC-Unique: 725p8ZQbN4K7jWK9FvlDkg-1
X-Mimecast-MFC-AGG-ID: 725p8ZQbN4K7jWK9FvlDkg_1791451046
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3a76c578fafso27298611fa.3
 for <dev@dpdk.org>; Thu, 08 Oct 2026 02:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791451046; x=1792055846;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IKt4VYfcpydxku6lhRWf+DSmF+F4RBneXt+6kUl3Wb4=;
 b=mlM79n/cwSJasnQ5UZMIhgGybdFhkYr+r15hkOKc8hyzV74+pm3c8bBgeffTngf94u
 E8zpwddjaSXVftEUYjkOtPpERSquDOVPLZQjjiBl9tNuY0DrBb8j/wjll40ML+UaZ+5Q
 oast88QNtJFVcXNnVaSXn6HRwrfyfCd47qCmtL4c5a07R7vgkV8AuowffNXcRIze06ba
 DeL3mrsfBphxrWfl1YshP6nTXkpu5SMFcsNmz2BWAnnE1wPpIgkae39aZValeGLPYXeq
 yYMN8fUUtZhkZcKhsjeM7B+Ay6MwSkEktdX4Kue9nMAuv0ggGxO/x11YDvYvN09gCeFY
 e9iw==
X-Gm-Message-State: AFq9FYLJZv9WLsm2Tw2XIRAyjHdfYDVuv0IT98Q+7Xczi2lsPVyDulbG
 jcEQkqJ9Cmq1ys3l6fhZ+rP3bbcPnGjSvgbiQp2eYIDN2wVjhoK3wOMsbaPPEGESYrIzkuvd0pw
 yQg9ocfA4A1VQbNkwotnyCSVOurvFAHpbdETY/W6+aEq/UU+l2biZZ2Xdp5T52D3+kuULZBNshB
 E8x+GD118wzZSuUNHCl7Y=
X-Gm-Gg: AYBFou1syQ2uIJVy2IzK+k9bNSwGSBZgRzy0tfP1CM/t9FdmTIZiz+YdM1x0IfFPNxr
 JiMqQ5uI8FxBcLSZL+dNFH6Gb+rh5LP103ea+sAXVE+BwD5xgE4m79L2P2g0RV0pJarBU/iGrLS
 VEbYxsRToWfM6tmkoGY4Pd0ko9DwjAaiT5hCDbBuBtIW3JXN932E8rm3ijIAmRyWq39Sg+JoDDe
 2Rl6V8i31wNm0EZaZm5wRqDhQhZ9ML7TaUzba+nfoKLmp+I
X-Received: by 2002:a05:651c:1506:b0:3a9:7f90:9506 with SMTP id
 38308e7fff4ca-3a9a2cfdefcmr10777521fa.26.1791451045967; 
 Thu, 08 Oct 2026 02:17:25 -0700 (PDT)
X-Received: by 2002:a05:651c:1506:b0:3a9:7f90:9506 with SMTP id
 38308e7fff4ca-3a9a2cfdefcmr10777431fa.26.1791451045448; Thu, 08 Oct 2026
 02:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20261006233144.644562-2-stephen@networkplumber.org>
In-Reply-To: <20261006233144.644562-2-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 8 Oct 2026 11:17:14 +0200
X-Gm-Features: AclHuK-ye-fY-qDo8Ls2oyCyp-sCk9SGEPL4IO5X_rWkZ0HNTF6nHOkFeeQhxPY
Message-ID: <CAJFAV8xyJMT8pMw_ZV8XEYO-biNLRQyfBWU-HkxrwwgfxeqsBw@mail.gmail.com>
Subject: Re: [PATCH] metrics: remove experimental telemetry helper API
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4IOaKQ3lhO9U9rwIX3SFnWm3VWCO0J5jY_XVk44fkdQ_1791451046
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

On Wed, 7 Oct 2026 at 01:33, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> While investigating experimental functions leftover in DPDK.
>
> The rte_metrics_tel_* functions are dead code. Nothing in the tree
> calls them from outside the metrics library itself; they were left
> exported by the telemetry library rewrite in 20.05.
>
> Stop exporting them. Delete the header, move the types into the C file
> and make the helpers static. The file now only builds when jansson is
> present, so the stub branch goes away too.
>
> The legacy commands ports_all_stat_values, global_stat_values and
> ports_stats_values_by_name are unchanged.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Applied, thanks.


-- 
David Marchand

