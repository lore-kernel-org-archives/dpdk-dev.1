Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F80FF8868
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Apr 2026 15:59:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2ACBE402E1;
	Tue, 28 Apr 2026 17:59:40 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id DAAEA402B5
 for <dev@dpdk.org>; Tue, 28 Apr 2026 17:59:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777391978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m4+pxaBEFTP6XJMGR7zeFQ0UrOJv4PqO4i01+sl9Hjg=;
 b=XdvZSKxM5qQElD4uUvH47UGEh4vYF/Blqx75b7xEKQ9dgGIUAVfGXW8v/QFJvHJ2jWnRsh
 ruP4wiGE3uw+1ETZmk9rEcZbv/BDouUf7OtK5zVOpkgixdWPtu/6cuYNFOtGWJclq+IEly
 1rplRwl1hcTi/Ds1GkIOdBPg6ySe2Ok=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-UnmEuA3yMtqF7aRmYaR6CQ-1; Tue, 28 Apr 2026 11:59:36 -0400
X-MC-Unique: UnmEuA3yMtqF7aRmYaR6CQ-1
X-Mimecast-MFC-AGG-ID: UnmEuA3yMtqF7aRmYaR6CQ_1777391975
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4836abfc742so102077405e9.0
 for <dev@dpdk.org>; Tue, 28 Apr 2026 08:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777391975; x=1777996775;
 h=in-reply-to:references:user-agent:to:from:cc:subject:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m4+pxaBEFTP6XJMGR7zeFQ0UrOJv4PqO4i01+sl9Hjg=;
 b=iqsrH678T5+FsWhOKCh/fFcsCnVjGXflH+fQcyubW5MAhdn7+PqVTxPvBTOSCm3H7U
 jd6U6Nxm+oUQx8wQWCOAbeDW9jClvcRNzTbRIWCQvJOLtQnD6//LUMcjFfsCkrSiVG2W
 fcmiZ7nAZfVgyvpX/fqYgNvr3vV7P5hYJCntstu3wklosMXHzWe4hwe/urMcqwdOd0S0
 fQWGq/r5uh5vs2lKmamom6OTvpOzgj6SMAnX9SflW3o+2RO1H0SNrZkUHH+B31NfGpOO
 /DgXn7CXvCm7beTq0OQ6YZzJzsEgv4zTJZMqSjlel1WG+DSIySnIqrCnsKmOju8TubBk
 +J8w==
X-Gm-Message-State: AOJu0Yzjd0wYj53gdmaa05YDEEeAbpyMgjmqwyzGRr6ky0HKX5vRtI34
 nodS2K8zRVuVF6CbVUgZHM1O1D7bEYWmgJN+8/UwMF924P3AQ35f9cnaxzOyQ7PZdtfbrSCvdDe
 N6v7hklfjAaak9sXbMPJ634mySBu5xr3tGtdIYfnYwtP6
X-Gm-Gg: AeBDieuEyz4Ay5t4s6qGEGfyiplVXGRI2lVC8FEu2tI1JFzuko/tHTd5tXW4g+4BG3D
 l2SxvSxVLtP8YDOiwzVgWRuXNsErm+r6bDuBZfOJSm2uRF94XyRmQNE/aA5aO3Hm3VqABHAN7Eq
 7V3Hlmi31t+vMFIMoHXxYBvc3vENfnETlCq0oKNk2E1XKqwPMNlmEnM1eq/lbuyPWPlOJrvtHKQ
 7H01r9nsu9eKlLFMu8DWbLQDUkpmPLCmGrGCaJ9AKsAIDDoJGgPl3cSnEKv0WMy0xn59BgmMuPr
 kX2JG8QIVjhFayDCS8jmoZJZesTOw+qYp699hS1xOmKXKUJsPZJavxqFuKICJM893E/BUTdTzw4
 l4NPxGYMMEJf+OM61hgpiWPbGCD23jtvAdgefCgNTslUl6OnEo++iu77/jE/mlt0ncL4K/BQU8t
 Je96RiTJV4nWqSWBY=
X-Received: by 2002:a05:600c:c087:b0:487:12c:e7e1 with SMTP id
 5b1f17b1804b1-48a77aed1d1mr45151085e9.11.1777391974704; 
 Tue, 28 Apr 2026 08:59:34 -0700 (PDT)
X-Received: by 2002:a05:600c:c087:b0:487:12c:e7e1 with SMTP id
 5b1f17b1804b1-48a77aed1d1mr45150775e9.11.1777391974273; 
 Tue, 28 Apr 2026 08:59:34 -0700 (PDT)
Received: from localhost (2a01cb00021ec0002fb5ec50e5a775d4.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2fb5:ec50:e5a7:75d4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a774b417csm21287635e9.14.2026.04.28.08.59.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 08:59:33 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 28 Apr 2026 17:59:32 +0200
Message-Id: <DI4WVC4VQYG9.7AI1V4UPUGY2@redhat.com>
Subject: Re: [PATCH dpdk] net/mlx5: add option to reduce Tx datapath
 compilation time
Cc: <dev@dpdk.org>, "Dariusz Sosnowski" <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, "Bing Zhao" <bingz@nvidia.com>, "Ori
 Kam" <orika@nvidia.com>, "Suanming Mou" <suanmingm@nvidia.com>, "Matan
 Azrad" <matan@nvidia.com>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
User-Agent: aerc/0.21.0-142-gcff39137b013-dirty
References: <20260421212356.573976-1-rjarry@redhat.com>
 <aeh4a5HS9iFtm9_D@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aeh4a5HS9iFtm9_D@bricha3-mobl1.ger.corp.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6_CW3QmP9nGB5sRiD1xvDDxNTGM069qjoT2FLtAqMKo_1777391975
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

Bruce Richardson, Apr 22, 2026 at 09:27:
> Out of interest, do you have any numbers for the performance delta betwee=
n
> the release builds with and without the new flag? I'm just wondering if t=
he
> flag can be the default to speed up builds generally?

The raw performance will depend on which offload features are enabled.
I have tested with the hardware I have at hand and these 3 TX offload
combinations:

0x10000: FAST_FREE
0x10020: FAST_FREE TCP_TSO
0x1008f: FAST_FREE TCP_TSO UDP_TSO UDP_CKSUM TCP_CKSUM IPV4_CKSUM VLAN_INSE=
RT

MINIMAL_TX   TX_OFFLOADS    TX_FUNC                      NON_DROP_RATE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
off          0x10000        mlx5_tx_burst_none_empw      42.4M
off          0x10020        mlx5_tx_burst_mt_empw        39.4M
off          0x1008f        mlx5_tx_burst_sciv_empw      30.2M
on           0x10000        mlx5_tx_burst_full_noi_empw  36.2M
on           0x10020        mlx5_tx_burst_full_noi_empw  36.2M
on           0x1008f        mlx5_tx_burst_full_empw      30.2M

There is obviously something wrong with my patch. I need to make sure
the *no offload* case does not result in -15% of performance.

> [Not that it should affect me that much, I generally use
> -Denable_drivers flag when configuring my builds to only select the
> specific drivers I want]

I usually do this too but it turns out I *always* need mlx5 ;)

