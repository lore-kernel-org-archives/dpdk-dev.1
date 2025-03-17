Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A9BC282EC
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Mar 2025 09:46:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9AF25402D5;
	Mon, 17 Mar 2025 10:46:51 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 58834402BB
 for <dev@dpdk.org>; Mon, 17 Mar 2025 10:46:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742204808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dZ+iMhMPJ5LWF+b0y6ruozpUE7OSAS26FPc/XxOBAH8=;
 b=MKy1FeC0iLSPSnpxuc/0OTX2MncKaOu0ZLdKehChhEONBqWQEgqIDinwZABiZHzLz5ypgE
 fohW+aA49KTjnIwIeprttBYILXn2c8iKiE3cSqlZdHXCdwr1qZkw+jmzIfMVCWRQ1wFtoj
 MYZlGb3aYG39qRy5WXrCLbaVWDrbi9U=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-fnF-g7C2PiinkR-fR73RMA-1; Mon, 17 Mar 2025 05:46:46 -0400
X-MC-Unique: fnF-g7C2PiinkR-fR73RMA-1
X-Mimecast-MFC-AGG-ID: fnF-g7C2PiinkR-fR73RMA_1742204804
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-549aec489c5so2013651e87.0
 for <dev@dpdk.org>; Mon, 17 Mar 2025 02:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742204803; x=1742809603;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dZ+iMhMPJ5LWF+b0y6ruozpUE7OSAS26FPc/XxOBAH8=;
 b=tCW4CQHDbhgX33FDLx48VjXFiwOjM9a3AjklJeTv+2xaOfUA5wqTK5qluEn5wBQDTr
 tUBHRnwW41uw91pfqSQTiEvGYt9UrOICzSpf0Udr9WB9YdldSAsk50w56twHjh4CBhAh
 NFQUTEbVZrg1Ce2u0R6yCww8ICPIXYhZ8WYbNjcIzLg+I5swQBzRfj8al13JjIXYJIOw
 Ec+V1gS5DFSb7kBK3pyz4TZtVTyi7eLZ5edxBnCB4F0/3UYPEXyRr7Wvh9zRycUMh8Jg
 vTQtrdnMXtlTogXrRsBqQWRJ5GhOWgHXvqLGBVk6CXxyGWFR8VqbLJeNIF/W8PeQdiL7
 3pMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCB0oQp7yDtiz2xNhiCU77I/Ril4yjudd6OqPgzw/vnr8nSRQoUHcWI/AN/4jv4dYdwZI=@dpdk.org
X-Gm-Message-State: AOJu0Yywy27ydxUg20+OSydke2/9G0d6DHq4kEekY75lemAQF38Ww2kg
 hdunsP4gADHrl4HDU5UUh+WDERWfTpBwvbWBo3sTHZ7UT23gKMxxj/TIxZsDNhcFQFLhOLrR3fO
 6olRKBTIelE2QCl3gU+0iWSwb4ZvMuMr8y7UQIOnGVYJxbuR3QGj2JMCtfaQHP2G8bICxz8uTsx
 1gn+47lC086KSRDj4=
X-Gm-Gg: ASbGncsgn7KkFHI/b2Gy2isgGf3YMQMt4qMrtZiSQEy/7jaSGIMzZgC0bH/Q2NTH6i6
 QsT2n/iifIMCHaqBG5ao96SmMd6cpS36DKDp+ni7vj4Sj1FMpyA/2AHpdd89RauwBe4k4rhyjHh
 0=
X-Received: by 2002:a05:6512:3a8e:b0:549:4d78:2418 with SMTP id
 2adb3069b0e04-549c38f7d9cmr6209109e87.27.1742204803425; 
 Mon, 17 Mar 2025 02:46:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQNgntP9CS9vCm4eIb8SXYeucwOi8I954lvuZnATKdNqvIc9Br+FMm7lCbRGd6PoHqVqFtnvEUTfCa65Cm/nU=
X-Received: by 2002:a05:6512:3a8e:b0:549:4d78:2418 with SMTP id
 2adb3069b0e04-549c38f7d9cmr6209088e87.27.1742204803003; Mon, 17 Mar 2025
 02:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <1741998895-31065-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1741998895-31065-1-git-send-email-longli@linuxonhyperv.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 17 Mar 2025 10:46:31 +0100
X-Gm-Features: AQ5f1JrDmd2FtIcvgI9d0KEY3Wxwl1E0njltKOBudAuwwqKKaTN_1ci5ktNR7gI
Message-ID: <CAJFAV8zbV=YY+_mLs-+ZJquhzfkw_RJi2sSGrz4RcSqh8k3hjQ@mail.gmail.com>
Subject: Re: [Patch v2] doc: announce bus/vmbus API changes
To: longli@linuxonhyperv.com
Cc: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>,
 Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org,
 Long Li <longli@microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _a5cxaLk6nEkm8NEB5n13PQXer-8gNOnmAQXN7_WA48_1742204804
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, Mar 15, 2025 at 1:35=E2=80=AFAM <longli@linuxonhyperv.com> wrote:
>
> From: Long Li <longli@microsoft.com>
>
> All vmbus APIs are used internally by DPDK core and net/netvsc PMD.
> It's not feasible or practical to use those APIs by the application.
> Those APIs will be moved from "DPDK" to "Internal" in DPDK 25.11.
>
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
> Change in v2:
> add details on what APIs will be changed
>
>  doc/guides/rel_notes/deprecation.rst | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/=
deprecation.rst
> index 3f5f0e949c..0ff7dd69cd 100644
> --- a/doc/guides/rel_notes/deprecation.rst
> +++ b/doc/guides/rel_notes/deprecation.rst
> @@ -138,3 +138,27 @@ Deprecation Notices
>    will be deprecated and subsequently removed in DPDK 24.11 release.
>    Before this, the new port library API (functions rte_swx_port_*)
>    will gradually transition from experimental to stable status.
> +
> +* bus/vmbus: Starting DPDK 25.11, all the vmbus APIs will be moved
> +  from "DPDK" to "INTERNAL" in drivers/bus/vmbus/version.map.

Nit: I would not mention version.map: it is just an implementation
detail (of symbol exports/versioning) that will become obsolete
if/when my rework gets merged.
https://patchwork.dpdk.org/project/dpdk/list/?series=3D34828&state=3D*


> +  Those APIs are used only by DPDK core and net/netvsc PMD.
> +  The following APIs wil be moved:
> +  rte_vmbus_chan_close
> +  rte_vmbus_chan_open
> +  rte_vmbus_chan_recv
> +  rte_vmbus_chan_recv_raw
> +  rte_vmbus_chan_rx_empty
> +  rte_vmbus_chan_send
> +  rte_vmbus_chan_send_sglist
> +  rte_vmbus_chan_signal_read
> +  rte_vmbus_chan_signal_tx
> +  rte_vmbus_irq_mask
> +  rte_vmbus_irq_read
> +  rte_vmbus_irq_unmask
> +  rte_vmbus_map_device
> +  rte_vmbus_max_channels
> +  rte_vmbus_probe
> +  rte_vmbus_scan
> +  rte_vmbus_set_latency
> +  rte_vmbus_sub_channel_index
> +  rte_vmbus_subchan_open

So all symbols from rte_bus_vmbus.h header become internal.

As part of the move during 25.11, this header will have to be renamed,
and moved to the driver_sdk_headers list like other buses (see
bus_pci_driver.h, for example).
Keep this in mind when doing the API change during 25.11.
(this is just a heads up, we don't need to mention this point in the
deprecation notices)


Otherwise, this cleanup lgtm.
Thanks.

--=20
David Marchand

