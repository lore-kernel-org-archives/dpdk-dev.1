Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287E1CDB479
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 11:23:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 657AC40280;
	Thu, 25 Jun 2026 13:23:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C09DE4025F
 for <dev@dpdk.org>; Thu, 25 Jun 2026 13:23:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782386603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xLZfgS4aasMraJY3DkPXcvGlMXVrzCmvNcnuSAsj7AI=;
 b=gdQkXSD6TJj5srR7iiPaLUPem44W5se3KLqmFmgVIWClcrvUdzqTjQOFbwLKBy5wgc7bcz
 KrTSd3/S/1Al6FbDBsHJbNlqSgRyMsVcpqnZ77R7X+ak0XX3vZ71SVEH11a6gZrGWWSrar
 0w4NW19vMDHyxwnRGOlOawcxOxSw7Dk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-i72ZYGkvO6e_vhNvuw6m_Q-1; Thu, 25 Jun 2026 07:23:21 -0400
X-MC-Unique: i72ZYGkvO6e_vhNvuw6m_Q-1
X-Mimecast-MFC-AGG-ID: i72ZYGkvO6e_vhNvuw6m_Q_1782386600
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-396cd85fb46so6399571fa.3
 for <dev@dpdk.org>; Thu, 25 Jun 2026 04:23:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782386600; x=1782991400;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xLZfgS4aasMraJY3DkPXcvGlMXVrzCmvNcnuSAsj7AI=;
 b=SpCTwEePkYSDEDhiZpV8E7waRiW9AkgcZoT4HIdXKS4UaNis+I1o4hPZgMoAwnWMVK
 QyGN8JoBYROo2lfrxP5MwAPDY6k2qS8hFMrLRPbcDzCmtbvEv69KfUcUSuHoxXQKw4o2
 iYHT0dx/gc2cy4dYAJsKjK6mqjqjVs9DBNk/4q4az+K+jq1mP84lBXO9fTsoh3eyBkUm
 67ny36xd+ogjaKbtWFGyNeTNO8TvrTa3P51YMLUSvfLgtOB1Tk+virTmJwA3u9uOA8U4
 EF+kS9FpDg/6DZtbHYFeGvED6ZA0GTqP5kSB6RZonMZDhm69DUolcuBYXnW2YPVkWNkZ
 Jhtw==
X-Gm-Message-State: AOJu0YzpIYAFNzNvKUcoG9cirmmdcQgsnaawYAFr+HtwHzlhdAIONU1d
 +5J25h0/OVfyMTlgEazMbqTpaFo6Bgo04HlN5kfLHFQWxNAJhSYoZlwq1a54xC9gfCusD417YC+
 pj28zSj/0z1rZrCwMBGy6ZRTMNJ7J1RAFvoTc/YDvcJgFTAk1mdUGaq9J7b3WVwszpBq9eEeihF
 hDHOPVQnFvG63qcwRIbZA=
X-Gm-Gg: AfdE7cl7w7QJD/gxgTkGAbFAAsu8IHbbzln4+w3fPWVe6t/i/YCQGAdP+rXaHDYUxc+
 eVroFRlLrhufOXCcBk6RiDuPu7K+pJk6m9RNsxWIL8mzwGl6oi7284+ClngFuvQu0IwiBKYyJlE
 LRPwyKolbAzjzErEjJT/X2IWIj3f3bUznQasWlwo5XoqvGBqzi3jPLmAPcITolfd1R+Mh/akfN9
 UQ6dH3kBhjfyrcyyjEMT/u1GmF6hqfLSe2cRjzfBMnXIMFwrQd1Zeprf7M=
X-Received: by 2002:a05:651c:891:b0:396:672b:4bfa with SMTP id
 38308e7fff4ca-39acb6807e0mr5491621fa.19.1782386599987; 
 Thu, 25 Jun 2026 04:23:19 -0700 (PDT)
X-Received: by 2002:a05:651c:891:b0:396:672b:4bfa with SMTP id
 38308e7fff4ca-39acb6807e0mr5491481fa.19.1782386599403; Thu, 25 Jun 2026
 04:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260611130738.1720628-1-david.marchand@redhat.com>
In-Reply-To: <20260611130738.1720628-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 25 Jun 2026 13:23:05 +0200
X-Gm-Features: AVVi8Cfz1lxghRik_-7OPMgwOyPQAUXtXc2hWyuT-fUCDDk0RyJt-gx9yI2w3Yg
Message-ID: <CAJFAV8y-ofapjVeDASJFfN8JrpNcHL0NwocBNWMwDb-fCea09g@mail.gmail.com>
Subject: Re: [PATCH 0/3] Cleanup rte_dpaa_device
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DnUwbftS5yNuervfBf9WuArMvzbyxpwzBn1izi_3AyE_1782386600
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

On Thu, 11 Jun 2026 at 15:08, David Marchand <david.marchand@redhat.com> wrote:
>
> Similar to the cleanup on the FSLMC bus, the DPAA bus device can
> be cleaned.
>
> The rte_dpaa_device object keeps track of a device class object
> (cryptodev, dmadev, ethdev) which is a layer violation.
>
> Make use of the device class respective infrastructure and remove those
> back references.
>
> Disclaimer: this series is untested as I don't have the hardware.
> I only based those changes on look at the code and other drivers.
>
>
> --
> David Marchand
>
> David Marchand (3):
>   crypto/dpaa_sec: remove cryptodev pointer from bus device
>   dma/dpaa: remove dmadev pointer from bus device
>   net/dpaa: remove ethdev pointer from bus device
>
>  drivers/bus/dpaa/bus_dpaa_driver.h |  5 ----
>  drivers/crypto/dpaa_sec/dpaa_sec.c |  8 ++----
>  drivers/dma/dpaa/dpaa_qdma.c       | 39 +++++++++++++++---------------
>  drivers/net/dpaa/dpaa_ethdev.c     |  3 +--
>  4 files changed, 22 insertions(+), 33 deletions(-)
>

Series applied.


-- 
David Marchand

