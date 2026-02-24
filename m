Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C12EFB811
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 07:42:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36BD5402EF;
	Tue, 24 Feb 2026 08:42:17 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D06284027F
 for <dev@dpdk.org>; Tue, 24 Feb 2026 08:42:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771918935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ebj3H+E2HQ5mQBBMx90db9AC6pEmq2qtluR3d3v2LQQ=;
 b=Pk06s/5SS7BwuGiU5q/PU6VCkrkEleu/+GNFvBLw8iNhdXBVie5sGLF9iEYg3tKIKrAZ6A
 7/2PdwJQJpJhRhuulXvweyFl19dVeBJS8MdztjNB0JiMYztUb5Q4FGHl6jBLZULG0lv7aI
 CgbvMx7fYJooQshFI/eUqLm7qqPZNgE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-lMgruPivO2OMhgYtJZrCAQ-1; Tue, 24 Feb 2026 02:42:13 -0500
X-MC-Unique: lMgruPivO2OMhgYtJZrCAQ-1
X-Mimecast-MFC-AGG-ID: lMgruPivO2OMhgYtJZrCAQ_1771918932
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-59f6a933cbdso954694e87.3
 for <dev@dpdk.org>; Mon, 23 Feb 2026 23:42:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771918932; x=1772523732;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ebj3H+E2HQ5mQBBMx90db9AC6pEmq2qtluR3d3v2LQQ=;
 b=s361C+1m688TAyCTjBdW46x1wMTByqidzer3ira85wdDLEuu43imwxOUpZfaXlsXoM
 eSAJZRrAE1fCTG4IHzI+pif8VqZpWEOy5uSRs0ghWTdXD5l+QK/RiSzv8ZS7u3twVdre
 U6dfTBtCHZJ4h65e4tbgv9usVexUwtx0SZAqTYDYcM6Ikpp97NIvwVvqwUKpCsGuSELi
 5Thlo23we6wMQ/HjbF3hSwG/TEulXDRhC+MAZ9Po5WuxaZo5oAmuw5+GIvooH+mRMkBz
 sUO0DUllcYeJLXPMnUevj6tfdS89t8e+ML1c7bTlsuCwNGyV5/Jx+gu/wbVtDfV3ig3d
 33/Q==
X-Gm-Message-State: AOJu0YxfA1IbST1jtpfcdfUayKst2e3GyYyITwKYXoGW+w5zUOcJmwgg
 IOsYX1Z3cgIS0j6PZjom2zjcwEge6pe0Q7NlsjTIrR8fLBXb/qcGiwVSHYR6mpPMEaVITrFaXNy
 Oh6GIaIOguFgypT/Lix3YmE2379TPlsIuKbQvUfAnr4km99IbB+oZb+O3eXmUlCb4n6S489a/7t
 Rf1nFEyC64kB/ltVxNr0A=
X-Gm-Gg: ATEYQzw8pWzta/aAIyY8hALtJOeIzCBgT9gXsKWt2SOjmOWiTld3mV2K421/mNGLnxJ
 wNduPJv8V5bP6QTUMzn0IRdO9+yEJiRtf89abroB0ui8e/BJbBLsguSzfhuMplMvQdw5nIE632b
 Ri/GqQfDOCcwr14CV2MIu7Okk/t/WPXet1K+vpVYWCUvi1Gdmm68tZ8YhrAeQD+U7GXrBwwK9zl
 U6PpkTaHGmS8bMkTudqvAsC41SSUTeqkwcgtG6lWcLbXEr/+EpDUs9s693SbwCa7rYSJQ==
X-Received: by 2002:a05:6512:3f16:b0:59e:3e24:f0cb with SMTP id
 2adb3069b0e04-5a0ed99c7a9mr3479839e87.25.1771918931781; 
 Mon, 23 Feb 2026 23:42:11 -0800 (PST)
X-Received: by 2002:a05:6512:3f16:b0:59e:3e24:f0cb with SMTP id
 2adb3069b0e04-5a0ed99c7a9mr3479831e87.25.1771918931345; Mon, 23 Feb 2026
 23:42:11 -0800 (PST)
MIME-Version: 1.0
References: <20260224014259.443846-1-stephen@networkplumber.org>
In-Reply-To: <20260224014259.443846-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 24 Feb 2026 08:41:58 +0100
X-Gm-Features: AaiRm52Tyv0wa9TuyPu0zUAvdGKuOeDt6Fbz_PHKTQWyalSptOjoGgEFhLkYZqE
Message-ID: <CAJFAV8yNsWO7pFH3B4-Wce=XBMNA3N4t__YL7nDpKNeojV2Dtg@mail.gmail.com>
Subject: Re: [RFC] net/vdev_netvsc: disable auto-detection by default
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, 
 Matan Azrad <matan@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: P76YKTf2jj0cNaf7f9kHPtTk-tbQH1zXttcccU_ECYU_1771918932
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

On Tue, 24 Feb 2026 at 02:43, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> The vdev_netvsc driver auto-injects itself on Hyper-V via an
> RTE_INIT constructor. This interferes with tests on github actions
> which uses Azure where the driver probes in forked subprocesses
> and crashes on uninitialized interrupt instances.
>
> Guard the auto-detection behind RTE_LIBRTE_VDEV_NETVSC_AUTO
> (disabled by default). The driver must now be explicitly
> requested with --vdev=net_vdev_netvsc.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

The failure in GHA can be avoided with a simpler:
https://patchwork.dpdk.org/project/dpdk/patch/20260223155603.3651641-1-david.marchand@redhat.com/


-- 
David Marchand

