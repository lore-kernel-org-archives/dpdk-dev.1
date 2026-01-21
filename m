Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBA5C44501
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 09:29:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EA9C4026C;
	Wed, 21 Jan 2026 10:29:36 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 079FA400D7
 for <dev@dpdk.org>; Wed, 21 Jan 2026 10:29:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768987773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zfm7NtvXCeH19vOgzh7T4xrW+8NCFSniT7oY/Rgp750=;
 b=HJGAkkR1eJtw5DXBRr2FeFWKGfFkZqxLFJ8x+BPkbiZ7CM2wQ0BxuY8l9JIOZZgyMLgYJ8
 Fn7WVjnoZPTKoxRVu9/29AeOpQk/ejMdDngVxZ04Tr3hQzGhgbirVBWU8vhfsJRJoO+S5k
 DejW2WJ/S1Wo+N3VjZoTZjCEhagvUQU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-B15q7HHcO-CsWGq2I9AlgQ-1; Wed, 21 Jan 2026 04:29:31 -0500
X-MC-Unique: B15q7HHcO-CsWGq2I9AlgQ-1
X-Mimecast-MFC-AGG-ID: B15q7HHcO-CsWGq2I9AlgQ_1768987770
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-59b6cbd5493so3665144e87.0
 for <dev@dpdk.org>; Wed, 21 Jan 2026 01:29:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768987770; x=1769592570;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zfm7NtvXCeH19vOgzh7T4xrW+8NCFSniT7oY/Rgp750=;
 b=gvKGrlruFCp3ycyI1osjjRKHuRIjk1T03TXEo6tI9HCsQPxIPkVgZzLAR+vcSG+lOt
 zAmbObArCQrXwGZbkkiMugXoXHHkkpFw/kSF1Au9ZdkQQrrZxZNPBZdqNM+I/jTKG6y+
 ClPzVZ6V0BiH/FqvtnuloH9+bgvgh2uZ4HkX2NPROxzGhgvgKdr49YG5Rp4zsRMk5n4S
 w2V/ts0/bPceITQDZGb0AyUacXlT5nwOJ2cTBbi6gnMQPRkZjLhPaZz7MR67pe89lUyO
 ZoaQzLzBmztrcjX0YponghZNlccix47scLh3fKCZMzHMxIkClGEp3nPJrl6DI/haco1F
 4R6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl2h08WCpguvF6QyduPR2qxQWJnyPnQdlGkQJVEfR2NafTsw0I+SSg3AMTHlsHMi6/h4Q=@dpdk.org
X-Gm-Message-State: AOJu0YzcmdgxhCqaN/xrkpAwwr6YueOXFVY4Uy8kUoKIBtfXmTv8IsaP
 BLq/oBWj3YJXNOF8M1YQemg/QcPkCUyZhQIcXs0yAc/ZMWTrHyrzEgOqVfza6C1Zmn7BLk7hgHL
 J+5u9JOVjEjKkwHX9ZMBvvuPDdScvzQQqJ4N7MzQhyXlIqJeRO9NSB+w+++0/0y1P+mdhADv2uG
 Qumsb0hhpTSkHMeWueY9Q=
X-Gm-Gg: AZuq6aKa+nWfVC2bDxGLo2gfB25CmrgLSPlbTSK12LDoqvO1PhWWjjlLaVfObsdvR6h
 KYvFppiGTBEYZH0FVIiUGAJQtnd1dAK9KLr/fgbOCAN1MWr9KJxVagBI/8kcX3rYfRIAzSsBm86
 MISORrbT6lYnEbO+lDV7EKpVPKbMmdt7U7MEBuC5Qf3SftOJhbg97kCl2VAEmUO9uh/wkT
X-Received: by 2002:a05:6512:b0d:b0:59b:b037:161c with SMTP id
 2adb3069b0e04-59dc8f11d3dmr1808032e87.5.1768987769996; 
 Wed, 21 Jan 2026 01:29:29 -0800 (PST)
X-Received: by 2002:a05:6512:b0d:b0:59b:b037:161c with SMTP id
 2adb3069b0e04-59dc8f11d3dmr1808020e87.5.1768987769544; Wed, 21 Jan 2026
 01:29:29 -0800 (PST)
MIME-Version: 1.0
References: <20260113151757.567234-1-ciara.loftus@intel.com>
 <20260114132159.644359-1-ciara.loftus@intel.com>
 <aW_DA9TtPD5cSc_u@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aW_DA9TtPD5cSc_u@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 21 Jan 2026 10:29:18 +0100
X-Gm-Features: AZwV_QhYeVFUF10sVjhs8UNXjmbAzIoGcL1h2L_tn53CMDds3EG0dZF8WMh-fcc
Message-ID: <CAJFAV8x7mozVaFw0y6n45SRw7PD3Wh9gBV-oXizj4YkWBZPO8Q@mail.gmail.com>
Subject: Re: [PATCH v2] net/iavf: support pre and post reset callbacks
To: Bruce Richardson <bruce.richardson@intel.com>,
 Aaron Conole <aconole@redhat.com>
Cc: Ciara Loftus <ciara.loftus@intel.com>, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sCBluh7K2R3dNulE2hKVL15Xq5GJLt_AJ4Kv5VSoHms_1768987770
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

On Tue, 20 Jan 2026 at 19:02, Bruce Richardson
<bruce.richardson@intel.com> wrote:
> >  void
> >  iavf_set_no_poll(struct iavf_adapter *adapter, bool link_change)
> >  {
> > diff --git a/drivers/net/intel/iavf/rte_pmd_iavf.h b/drivers/net/intel/iavf/rte_pmd_iavf.h
> > index dea1bd2789..d13417eb08 100644
> > --- a/drivers/net/intel/iavf/rte_pmd_iavf.h
> > +++ b/drivers/net/intel/iavf/rte_pmd_iavf.h
> > @@ -20,6 +20,8 @@
> >  #include <rte_mbuf.h>
> >  #include <rte_mbuf_dyn.h>
> >
> > +#include "iavf.h"
> > +
> This include is an issue, because it's an exported i.e. installed, header
> including a private header that will not be installed as part of DPDK. This
> gets picked up by running chkincs from test-meson-builds.sh script. [I'm
> surprised this wasn't caught in the CI].

Something looks wrong in the robot branch itself.
I don't see the patch in the associated branch.
https://github.com/ovsrobot/dpdk/commits/refs/heads/series_37048/


Otoh, pushing this patch in my own repo does raise a chkincs failure.
https://github.com/david-marchand/dpdk/actions/runs/21203869950/job/60995562483#step:19:5413


-- 
David Marchand

