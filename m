Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F52C531C9
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Jul 2026 11:25:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B58BA4029B;
	Fri, 24 Jul 2026 13:25:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id CDC3240276
 for <dev@dpdk.org>; Fri, 24 Jul 2026 13:25:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784892341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wETpocgr5YqtPNOGsGlFtbj9zI/t0rpEmKt0/49nKkE=;
 b=Ixn7jprsswmsuEMjWawn/C+FORTegD2bF8cIHmoXfv85kelPYWvn5dd1XNGn8oZ4dvUA55
 sfctYEdfNrEVPHBgvKDtKfahKxv+Ni2iOCwC+PgeAPLkCqWRclSu52pmS9oW1/E235gVHM
 OI4YT9tH6n+fdC9YnK4PO/5u0cl7p2E=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-H1uf7xScNOmMgbvFxmO-3g-1; Fri, 24 Jul 2026 07:25:39 -0400
X-MC-Unique: H1uf7xScNOmMgbvFxmO-3g-1
X-Mimecast-MFC-AGG-ID: H1uf7xScNOmMgbvFxmO-3g_1784892338
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5b293eca8c4so220423e87.2
 for <dev@dpdk.org>; Fri, 24 Jul 2026 04:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784892338; x=1785497138;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wETpocgr5YqtPNOGsGlFtbj9zI/t0rpEmKt0/49nKkE=;
 b=DWhuG5TQEVylUDNLJyIYY23x+3/om9/7zFikYMHckcmNNDWilmK3OpNpYYIJefeDIS
 Ivo/l9KI5trCR0PxkY7RSpHRGqm8GqDEqj1R93Nr0AL8nsP5PBF21bMuDp8awn35AizP
 niJ+qKbGFK2idq13PDRs2W1qYplTk1xcb+WffU8rX0Ot/0Ssv6z8cPfvcn525xRugcAd
 cnNsQQUuxnilOuz6RlKPrthPgk+DQsuA7YyY5w2xy5+OgBtS3KZb4xhZ1jxsX5XruL4I
 OfWuwWjPe4vY0ZBso+NT2Yv+2vvNsdo5e85VGIEugw6VjMhoHhVE9bW6mmkQrSqCFeW9
 AftA==
X-Gm-Message-State: AOJu0YzFqJHScEUPyvFi983Jkpq62vRzw9XBkMh+g6nSusBaXYNz1Mc4
 q3yGdXOFJWsPhwVq0ChxxKL8IGfvzqyQ2XrVNc3FnJDI3BuhoaoqYNs0Nsoai3R5gFcKE9iCtJW
 iMQ60zF/hnFHhgrZ3EFgXAHdRDb8adnKHVCH4wi9emYIRxgNwl4m2eiMtzgPzdCalmdgeUZZggo
 TQDpRgYEhYuMvQ3sKxs9c=
X-Gm-Gg: AR+sD108ePIOarCde7RJBUrCbqp6CAgvD2HVzrMMm/AhA9PKgkCrWAnj/3D4HDm5H0z
 Tiqs49FlUfDSOESIljU04xHeosCssHDy15odHe7aP71d75zgB7WTKwjijiawxxc60b9zKc14L7r
 qoiLHY2o1aL9jcWyQAKH8hUJsPPyKEroBaXMYPLbUkjrUEXWJ8TlboSr4nqSk0znhpm1miWgyML
 m2itJn7NuC7DHd2oHXLO5XUTtnGluDBhI5vdqlVoIhT9oJB
X-Received: by 2002:a05:6512:2243:b0:5ae:a0b4:5013 with SMTP id
 2adb3069b0e04-5b2b2e18d84mr1772580e87.0.1784892338230; 
 Fri, 24 Jul 2026 04:25:38 -0700 (PDT)
X-Received: by 2002:a05:6512:2243:b0:5ae:a0b4:5013 with SMTP id
 2adb3069b0e04-5b2b2e18d84mr1772568e87.0.1784892337706; Fri, 24 Jul 2026
 04:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260724084917.1045026-2-rjarry@redhat.com>
In-Reply-To: <20260724084917.1045026-2-rjarry@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 24 Jul 2026 13:25:26 +0200
X-Gm-Features: AUfX_mx2nXZzxLUcGoZIuN1wR7fu3x6kyMcHqUDSJdewfrjBRC5WwJJ8Cux6CnY
Message-ID: <CAJFAV8yMuRT4U2J+4QbyxMySjr2Y+MRp_yBQfz3A1fSr1QC1gw@mail.gmail.com>
Subject: Re: [PATCH dpdk] lpm6, fib6, rib6, table: remove deprecated functions
 and macros
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, 
 Bruce Richardson <bruce.richardson@intel.com>, 
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6eLxAZn24d2D1cJLx-P9eTaN9fjYzlRRylz6cvi_L8w_1784892338
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

On Fri, 24 Jul 2026 at 10:49, Robin Jarry <rjarry@redhat.com> wrote:
>
> These function were marked as deprecated in DPDK 24.11. Remove them
> completely.
>
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---
>  doc/guides/rel_notes/release_26_11.rst | 11 ++++
>  lib/fib/rte_fib6.h                     |  4 --
>  lib/lpm/rte_lpm6.h                     |  3 --
>  lib/rib/rte_rib6.h                     | 73 --------------------------
>  lib/table/rte_table_lpm_ipv6.h         |  2 -

Thanks for the quick patch.

rte_fib6.h, rte_lpm6.h and rte_table_lpm_ipv6.h don't need to include
rte_common.h anymore.
It had been added when deprecating those macros/functions.

I think you missed RTE_IP_ICMP_ECHO_REPLY and
RTE_IP_ICMP_ECHO_REQUEST, from 87bde5ae6873 ("net: add more ICMP types
and codes").


>  5 files changed, 11 insertions(+), 82 deletions(-)
>
> diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
> index 938617ca7542..fb9cde591695 100644
> --- a/doc/guides/rel_notes/release_26_11.rst
> +++ b/doc/guides/rel_notes/release_26_11.rst
> @@ -68,6 +68,17 @@ Removed Items
>     Also, make sure to start the actual text at the margin.
>     =======================================================
>
> +* Deprecated functions removed:
> +
> +  - ``RTE_FIB6_IPV6_ADDR_SIZE``
> +  - ``RTE_FIB6_MAXDEPTH``
> +  - ``RTE_LPM6_IPV6_ADDR_SIZE``
> +  - ``RTE_LPM6_MAX_DEPTH``
> +  - ``RTE_LPM_IPV6_ADDR_SIZE``
> +  - ``RTE_RIB6_IPV6_ADDR_SIZE``
> +  - ``get_msk_part``
> +  - ``rte_rib6_copy_addr``
> +  - ``rte_rib6_is_equal``

Yes good thing to add a generic entry, we have other removals that
will end up here.
I would sort those by libraries, as I intend to reuse this entry for
PCI cleanup.

So something like:

@@ -68,6 +68,14 @@ Removed Items
    Also, make sure to start the actual text at the margin.
    =======================================================

+* Removed deprecated macros and functions:
+
+  * fib: ``RTE_FIB6_IPV6_ADDR_SIZE``, ``RTE_FIB6_MAXDEPTH``,
+  * lpm: ``RTE_LPM6_IPV6_ADDR_SIZE``, ``RTE_LPM6_MAX_DEPTH``,
+  * rib: ``RTE_RIB6_IPV6_ADDR_SIZE``, ``get_msk_part``,
``rte_rib6_copy_addr``,
+    ``rte_rib6_is_equal``
+  * table: ``RTE_LPM_IPV6_ADDR_SIZE``,
+

 API Changes
 -----------


-- 
David Marchand

