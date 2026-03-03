Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E24EDA698
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 16:29:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 620CA402AA;
	Tue,  3 Mar 2026 17:29:22 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9B5AF40268
 for <dev@dpdk.org>; Tue,  3 Mar 2026 17:29:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772555361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1irr9xMjGcOb57X5Qn9tjZ2swkC2NaXkUcDu+n/dOAo=;
 b=ZbdI4zescxSPrmQ1LvoGeJHlbct/Sxyv9QBmVwbRkOrRD/uCLZoZrdrVX5MVb8pT3XbFSW
 Dn+y4peSZCZgY+O8IEFxmPHteCl8+WL3cEyjfFQEc9tFD278i1I4opLvOvczVt3q8prbj6
 LfOycRFoN8uCftYL8JHsL9WOL1Yoqfg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-O8_ju-HeMzyF5QFqmwlNrw-1; Tue, 03 Mar 2026 11:29:20 -0500
X-MC-Unique: O8_ju-HeMzyF5QFqmwlNrw-1
X-Mimecast-MFC-AGG-ID: O8_ju-HeMzyF5QFqmwlNrw_1772555358
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-389fd3214e3so52250081fa.0
 for <dev@dpdk.org>; Tue, 03 Mar 2026 08:29:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772555358; x=1773160158;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1irr9xMjGcOb57X5Qn9tjZ2swkC2NaXkUcDu+n/dOAo=;
 b=ZOIuS7YD2t+/xVFMGwvn0H3KTvJ3b3Yl/65Ku5plxK3QtHtJRDoQCZJvM5jgQOv/Lf
 WKxVZLgQoxvBMTfRYmwU29ofGPzIPl4wMJS91uHwVyx6l2Cxcj1WDgdZCUd+dO0EGw0D
 k6NsmgQJyC1oSy2hbfdPHgGjVxyg5Eu183d8GQRqb15OT/+KNFQP+M1ImDGnJaZErmFJ
 hFv9l0bs7PhQWqa8jXfFRrduxl4bg49NfYjycDeqbuK+yygqDZDc/y7OzFoj1KNGfm9e
 6hA2ziQRXZs+E+iiWkNdwe5OSDXcDDOVCZ+F1iDhu1rwpfHtwBESDEsoT7CHLEiZEXWN
 9xAA==
X-Gm-Message-State: AOJu0YwUKlRavV2/+rJxnzbyc+VPRrBnynvSXYwEalo9vqm66FtX+qhK
 7ypVSGw9ToiO/6H1cAX+O/43wFIt6XFf5lXeQFZybUJRAH3CUhb7vWJS/xGPPqp8ra8a9OBQq8j
 1u/rQq/meE4wWCv5skH070Ry13OulHbF76Grqnwm7GsZCWYe2PGz/GJmaO3v9nOGta27Q/n0GDH
 pt0Q3PD5EKkfNgbSeMy88=
X-Gm-Gg: ATEYQzxe81h1H+bd+WNc3wZ0YyFwXk4L/tXfRbUq62i/XTxuaFWmalCfAyvdpdERJCt
 1CyMqcbIzS6glH+TsJpk7hRYWHQ5Frj9BLtRNicWqwzaPwMXi2H5f48PIgI06pJy8Umu4kP2Tt+
 aTbIR60ds+GNwdHLW5J2HlIjSDabL6DvplNgm6MfvTuYc5uekjE4f+SQ0X7aV36cn7UHHzFLUdq
 USF5xlrvXeDWKZsYzuDg1d2PcRFxQ3nFWzChlaYkU2bMNTH/dMpnLBQhvkNV6AVzFamLA==
X-Received: by 2002:a2e:b891:0:b0:38a:71c:a320 with SMTP id
 38308e7fff4ca-38a071ca3d0mr103886341fa.29.1772555358224; 
 Tue, 03 Mar 2026 08:29:18 -0800 (PST)
X-Received: by 2002:a2e:b891:0:b0:38a:71c:a320 with SMTP id
 38308e7fff4ca-38a071ca3d0mr103885611fa.29.1772555357217; Tue, 03 Mar 2026
 08:29:17 -0800 (PST)
MIME-Version: 1.0
References: <20260122122354.1820368-1-bruce.richardson@intel.com>
 <20260219173953.2182757-1-bruce.richardson@intel.com>
In-Reply-To: <20260219173953.2182757-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 3 Mar 2026 17:29:04 +0100
X-Gm-Features: AaiRm50RK1lSoI2QznwMO2iBTqeaRSRHbM7Uibva7g6Vbx-Oqn4tkvkVTVRPs4o
Message-ID: <CAJFAV8xVOugdxA1sKZTNst4yLpAf_9LjULOQ_f7D0Ro5h7fJ8w@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] improve net/null dependency handling for tests
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, mb@smartsharesystems.com, stephen@networkplumber.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nOgbimg3tAGVNf1QTjeBb9SUFeGOadLSFfotQA6Pafg_1772555358
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

On Thu, 19 Feb 2026 at 18:40, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> A number of unit tests take advantage of net_null driver to use
> as a dummy packet source. When this driver is disabled we then get
> tests failures in fast-tests. Fix these by recording the dependency
> appropriately or by skipping test sections if the dependency isn't
> present.
>
> V2: reworked changes following feedback, discussion and other upstream
>     changes
>
> Bruce Richardson (4):
>   test/event_eth_rx_adapter: skip tests if no ethdevs
>   test/event_eth_tx_adapter: remove dependency on NULL PMD
>   test: fix missing dependency on null networking driver
>   build/tests: add warning for missing NULL PMD dependency
>
>  app/test/meson.build                 | 10 ++++++++--
>  app/test/test_event_eth_rx_adapter.c | 14 ++++++++++----
>  app/test/test_event_eth_tx_adapter.c |  4 ++++
>  3 files changed, 22 insertions(+), 6 deletions(-)

Series applied, thanks.


-- 
David Marchand

