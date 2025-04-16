Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1C1C369BD
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 15:31:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 663B3402E7;
	Wed, 16 Apr 2025 17:31:36 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id BC6BE4025A
 for <dev@dpdk.org>; Wed, 16 Apr 2025 17:31:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744817494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o9v9H7RDxX9N1R3Sw7o1w7HRRk3dotUrIDqasrOpA/w=;
 b=CVDF6yQdotetXwni6teJsroHUnjqZBaRIfyDjlyFGqx2U5ZuOb7Ho9xMMD5M3kPxoO8E/p
 tqfez7V8RJlN5ojRngHZA8nCRVabI5oJX0dd1gesIDBc3S96+3iPg62cNN8g9nAg13GwHi
 OR+/wL6j1MZoHR7EnmMHExG1xaH4WMc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-ja3Pt7iIPCCMdZglaqF_lA-1; Wed, 16 Apr 2025 11:31:33 -0400
X-MC-Unique: ja3Pt7iIPCCMdZglaqF_lA-1
X-Mimecast-MFC-AGG-ID: ja3Pt7iIPCCMdZglaqF_lA_1744817491
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-30d8365667cso35247231fa.1
 for <dev@dpdk.org>; Wed, 16 Apr 2025 08:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744817490; x=1745422290;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o9v9H7RDxX9N1R3Sw7o1w7HRRk3dotUrIDqasrOpA/w=;
 b=E+/ElOIeGdctd9Pe/G1OjzBgoWkJzRpBQtqDPCYlATcFfKZe2r1b9vS/woVpVq1CEe
 nl1ElX/UUbsaEOhAZ12S2cYl9R99W8VNqOWbo7EF4ryEwoZHppLOmoAdfvdVWXXZZ7il
 zh8a/zNMapyAsQwoclz1V0G8/BZY/rWg/Rd4N6vPBPcwPW9Aryh1ahHMeNeFFt76fzsQ
 XhSgU6yrGS92H2YDKCFdn4/FSDasI/4hROa9uneYxK4uXS/rFyqbGTct1x4rIK3QDyXq
 gAol7j/wiGIpG5NCb69dJKqrNDxyLGnnoj9s4xKVVtfJhWqVVX5ydbn0UDipOfkweZgg
 2gmg==
X-Gm-Message-State: AOJu0Yw5sMYxA0RRdMgxgfwFg5N+VTRmzJemut/5V8+Gyb4tUpGqZv+g
 TxRcux1jHuIuAIOPVnQY+oRit+045vQc0KvSxxul5LXjetv02X3Yv5Nnw0t2I36t0nxabXtKduP
 QyE3eGZtZl5aNW4r6My3E7ucI3sZ2bHYNmRGev94DMTfnHUIp+Dx1YfR8EoEgxKFeEpnrHY0Syy
 epvpGY3T4oQe7pYrM=
X-Gm-Gg: ASbGncsE55amhkbFKaAOKykQ/huNScdJX/YdAM7gRzDdl56Q4w3Ax1odlds+gtLmYLt
 DVmHZR3NA/p14S+jbpeloXop5Inec2gwzV2xFhl2NjyFXyP9YY3v6Tm+djCwKPiHPapvwkcI=
X-Received: by 2002:a2e:ab09:0:b0:30b:f775:baf5 with SMTP id
 38308e7fff4ca-3107f5a91aemr9872441fa.0.1744817490562; 
 Wed, 16 Apr 2025 08:31:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOGQzmuMVSowxxdYcX9vI4bOdCOOzY2yPU3el4sB2xE6eCsGSZOJIsHMB9xZxoIQ+YUgS1960Q55vQKBmRuQA=
X-Received: by 2002:a2e:ab09:0:b0:30b:f775:baf5 with SMTP id
 38308e7fff4ca-3107f5a91aemr9872291fa.0.1744817490176; Wed, 16 Apr 2025
 08:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250416061034.649607-1-david.marchand@redhat.com>
 <20250416073716.0a4e3b4a@hermes.local>
In-Reply-To: <20250416073716.0a4e3b4a@hermes.local>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 16 Apr 2025 17:31:18 +0200
X-Gm-Features: ATxdqUE4V0m9LI2h3Xhz4k-p_iDrl-oZ0RAQ9_lYw_jMMe3G41F2p5aFVIUkx2g
Message-ID: <CAJFAV8wiK6qwdX6nVkd2Urf670VnQ1DDHteiUGxaaKE3CPK1mw@mail.gmail.com>
Subject: Re: [PATCH] pci: define more standard register offsets
To: Stephen Hemminger <stephen@networkplumber.org>, joshwash@google.com
Cc: dev@dpdk.org, Chengwen Feng <fengchengwen@huawei.com>, 
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>, 
 Potnuri Bharat Teja <bharat@chelsio.com>, Jie Hai <haijie1@huawei.com>, 
 Jingjing Wu <jingjing.wu@intel.com>, Chenbo Xia <chenbox@nvidia.com>, 
 Gaetan Rivet <grive@u256.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BispZFxwStH_nAhCrp86DKoHNErj99q873XYxWAlNiI_1744817491
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

On Wed, Apr 16, 2025 at 4:37=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Wed, 16 Apr 2025 08:10:34 +0200
> David Marchand <david.marchand@redhat.com> wrote:
>
> > The PCI standard defines registers for:
> > - subsystem id,
> > - revision id,
> > - status of the device,
> > - vital product data,
> >
> > Add them to rte_pci.h and use in existing drivers.
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
>
> Makes sense and aligns with <linux/pci_regs.h>
>
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>

Thanks for the review and merging it.

@Joshua Washington
The gve patch https://patchwork.dpdk.org/project/dpdk/patch/20250416024421.=
722135-1-joshwash@google.com/
should now use RTE_PCI_REVISION_ID.


--=20
David Marchand

