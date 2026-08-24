Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E474C5DF9C
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 16:23:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5216B40270;
	Mon, 24 Aug 2026 18:23:40 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6E755400D6
 for <dev@dpdk.org>; Mon, 24 Aug 2026 18:23:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787588618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rv7uflmBnrbiKwVYkIDFWCoCZ8jlem/J67Q5RmhC4m4=;
 b=Aq9RsGvVC39O1WUWu/p031ccB4VJFzyKDeuuDFnoY0LRLJMeN4o3ltCk4At7mMb6+hElbp
 9bLZJZ0d7OGF9SRyY9YqhWNhmKpUYFIOyPBtBrvr8JRbT58VpcACIjwnWeEL9BPDWqGes4
 VT7+AcsbghXVcTA7suELbRwJIJAbyTQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-EooEjleKPC2kBKkwMiltBA-1; Mon, 24 Aug 2026 12:23:36 -0400
X-MC-Unique: EooEjleKPC2kBKkwMiltBA-1
X-Mimecast-MFC-AGG-ID: EooEjleKPC2kBKkwMiltBA_1787588615
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3a16eeb1474so288721fa.0
 for <dev@dpdk.org>; Mon, 24 Aug 2026 09:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787588615; x=1788193415;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Rv7uflmBnrbiKwVYkIDFWCoCZ8jlem/J67Q5RmhC4m4=;
 b=gHgGGApkTXkaQ3osCl1o7kJqKS/73Vr7N4ELFzoZbHXobjWEdTGvdN++2HH1EJ3Ipq
 kwcdx1DNNYozRDuDYaNjONopBux9CKxtxTn10BcA2YumiaaDOMdvRTPkO4Ah8aS8Ecbh
 VTHSFmrtZXCZ8l9CxShbKnsvtRscDPiK8cqtrPB8cSlKr2YBrFl4A96SF2rB/rtkH5m+
 dywsdbt2P/kEVp4eibBLRuCbfYPVLbifk6EBiPBwxWgxxiue91FAfr6NjVxq/1Ej+cMQ
 sGWCP+UPC+/9FYTXoPLR+7QfhmJ8Qi1vETpMyhwPvy3FIB1pcjN3XV3FeERaxkgL5kjG
 qAJA==
X-Gm-Message-State: AFuF++kFZbO8UPzbj8GresoGjpzRRy8k7GVGYEh/aA9+oXSgxqRbQNOE
 AtA0oCe3d94u9srORslurG6Ok0XVrv4O7hRJHScUVy2NPaO9CTlJ4lPPX4GKsLqJMxu1LsDeJW0
 8DXRSyzvzYUENv4kLMI1ilXJeGTBdSdhXIQy3BvkhDybATJ7Uiy7UCuxgRxCIqGDJtoOyqScxEu
 qlN/24GIOiUTklVbq8mRI=
X-Gm-Gg: AR+sD12cdHguVo/XxSXbVmSxgMEkJkqIPldKRD7IMdkep5sfb1FG0kf+1nOzWE16743
 khigOlrttX9n0dw10OnG1FHkQb9Oxf44g//s+4OMNEvw2T7ykrH9AiLrKtc8bhdDnajbv+3PCFS
 S+fWVsDTUPJ5COk8ajN3XPFozWfP8HF2K/vKIjzk+6WP6zpCh1kZXEecbG1RjAcdqz8fQxamHLL
 pAMfoCG8EyPNQ+FsIjAb2loH58gDXsVVM3haqFJsuibpENN
X-Received: by 2002:a05:6512:1110:b0:5b1:5e19:c496 with SMTP id
 2adb3069b0e04-5b49c7a9c83mr69684e87.14.1787588614911; 
 Mon, 24 Aug 2026 09:23:34 -0700 (PDT)
X-Received: by 2002:a05:6512:1110:b0:5b1:5e19:c496 with SMTP id
 2adb3069b0e04-5b49c7a9c83mr69668e87.14.1787588614368; Mon, 24 Aug 2026
 09:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260814153755.940302-1-bruce.richardson@intel.com>
 <20260814153755.940302-8-bruce.richardson@intel.com>
In-Reply-To: <20260814153755.940302-8-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 24 Aug 2026 18:23:22 +0200
X-Gm-Features: AcwNN1Vqa-tqJmR-SjmIlz1PdnU3q6Vic5dyQ1kPpEgdOQ3K4MenqHRcwcbULsk
Message-ID: <CAJFAV8zYSCsbKBJPYc_bH-QhJoZff+vU-va5Po5NJbptX9Q9qA@mail.gmail.com>
Subject: Re: [PATCH 7/8] net/ixgbe: move editable files out of base folder
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TzKL171cTE6EjTs3LPFLtShY8eWLW9IYI2cvr6KRxZw_1787588615
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

On Fri, 14 Aug 2026 at 17:39, Bruce Richardson
<bruce.richardson@intel.com> wrote:
> diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> index 3d4f4fb7fc..8e44bb3a09 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> @@ -36,15 +36,15 @@
>  #include <rte_os_shim.h>
>
>  #include "ixgbe_logs.h"
> -#include "base/ixgbe_api.h"
> -#include "base/ixgbe_vf.h"
> -#include "base/ixgbe_common.h"
> +#include "ixgbe_api.h"
> +#include "ixgbe_vf.h"
> +#include "ixgbe_common.h"
>  #include "ixgbe_ethdev.h"
>  #include "ixgbe_bypass.h"
>  #include "ixgbe_rxtx.h"
> -#include "base/ixgbe_type.h"
> -#include "base/ixgbe_phy.h"
> -#include "base/ixgbe_osdep.h"
> +#include "ixgbe_type.h"
> +#include "ixgbe_phy.h"
> +#include "ixgbe_osdep.h"
>  #include "ixgbe_regs.h"

While I agree with the base/ixgbe_osdep.h -> ixgbe_osdep.h conversion,
I don't get why you *need* to change other base headers inclusions
above.

The rest of the series looks good to me.


-- 
David Marchand

