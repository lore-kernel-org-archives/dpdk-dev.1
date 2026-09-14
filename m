Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188C0C88E70
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 11:54:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F333402F1;
	Mon, 14 Sep 2026 13:54:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4EFE840272
 for <dev@dpdk.org>; Mon, 14 Sep 2026 13:54:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789386894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FJZp/6wfuhG6n/coEpGDYSaE+KzUK0qW+Zmy4l5jIKA=;
 b=TgInsrktxzpvYXZCpUQKB6vEmz6sh1pPGJ6aAYOalD/JqjmuudYSXuqkcAhE390sBaHRNJ
 +ydMV2RitLOnHQsEHF4n5j8V8r1nwODDnfUdncbfSAJF2xy91BWRw2WYVi/xom5+twnVb0
 68LDS1X3rEK6LsaqZCw/EBzZqniX9Do=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-mGBhU3ldMoOcewEtjqoqYg-1; Mon, 14 Sep 2026 07:54:53 -0400
X-MC-Unique: mGBhU3ldMoOcewEtjqoqYg-1
X-Mimecast-MFC-AGG-ID: mGBhU3ldMoOcewEtjqoqYg_1789386892
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3a27721662eso13311301fa.1
 for <dev@dpdk.org>; Mon, 14 Sep 2026 04:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789386892; x=1789991692;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FJZp/6wfuhG6n/coEpGDYSaE+KzUK0qW+Zmy4l5jIKA=;
 b=SBVyFdPwVavNLR2JPKpk/myNlEU58IxY843Ol4lzhW9CVFbAdXX4gaJUDk1aygPd96
 XCA312qFxEDwCvmub+Mo+9nKKC381pe9WFW8jiv1V3NNCJCWdXtOEz0axR9ZQNrDBTSN
 VSIAFPTl8bi7CjBsg2/uF+kc814wV8Vbwq2I2ylhs37csABWq9JJAVSoHxoaueiYNMs4
 d27vlBQvSYhNL/VU4Yi0nHjvW7tUKtTjX0Cc0VIV7xVVh0NtkVg5tCno3JMZ/nFWGuJD
 S+d2EbOhJsDRfNEUo89wc1q0rWAbSxgtxZREBBN6xR2RwCl/UeDzdu+oBsj5Vwz7ddpm
 7v8Q==
X-Gm-Message-State: AFuF++kU3eHXwz4g1ybj5bqz5jNk2NBY5pywOGIFaBVIlxsK1FZcwc1F
 iWWq5Dh5IvbXidPib0WkmvBpMX9degIZkqzXJjt/vn5ugczT8lwKEhHd5LdEBGSwAnfhU/p6a2q
 2HOp3MNVPzVrf0yn3jpcRsER3rIWGrypZxJePpF6nEmKySNjlpVLpRhF2kV4vHUWJQ6bPqZQjLW
 EcB03qorfzEaQWRXzqaEM=
X-Gm-Gg: AYBFou0WLKH5LDWzZ6NZ5ijArQUCPezi8JVQmJQ8Vwf4+4WZhoo4uwSPwK33E6VKRYr
 ZXmYl8NO2D5pmILn2Zl+p0/eKJJbFwDwaTLQ3EcXWDO0H2jUZcp/gsHVLk7qGo/rjQEoKLWYW5U
 6T3jzWv8EwdQz/RVshzEmgsHZuXF4kapp2Ogezr8B7PDCJ68cQwUtUdJ/OKzUiupWdvloZHOBsV
 Lb5izI9LSMD8kTmqP9vz8Ymb6DNbk6YnH17VbDd6amxpH5i
X-Received: by 2002:a2e:be04:0:b0:3a5:b4d4:89ea with SMTP id
 38308e7fff4ca-3a5c898e73fmr3274051fa.22.1789386891961; 
 Mon, 14 Sep 2026 04:54:51 -0700 (PDT)
X-Received: by 2002:a2e:be04:0:b0:3a5:b4d4:89ea with SMTP id
 38308e7fff4ca-3a5c898e73fmr3273981fa.22.1789386891506; Mon, 14 Sep 2026
 04:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260914081725.1097704-1-david.marchand@redhat.com>
 <IA4PR11MB9278D5E85C6AD7C17FCF659D8EBB2@IA4PR11MB9278.namprd11.prod.outlook.com>
In-Reply-To: <IA4PR11MB9278D5E85C6AD7C17FCF659D8EBB2@IA4PR11MB9278.namprd11.prod.outlook.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 14 Sep 2026 13:54:39 +0200
X-Gm-Features: AcwNN1V76FJyNbgsgZRBYDcWK7nrgMsPMYOP_nHZTlhZdtxTC4QHUWQfs3CDx8c
Message-ID: <CAJFAV8z-yyLsScuWJhoZp-1Jz+3r1+zV2Qr5z_qFWp_sLfTFPA@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] net/iavf: fix MAC addresses leak on reset
To: "Loftus, Ciara" <ciara.loftus@intel.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "Burakov,
 Anatoly" <anatoly.burakov@intel.com>, 
 "rjarry@redhat.com" <rjarry@redhat.com>,
 "cfontain@redhat.com" <cfontain@redhat.com>, 
 "stable@dpdk.org" <stable@dpdk.org>, "Medvedkin,
 Vladimir" <vladimir.medvedkin@intel.com>, 
 Lunyuan Cui <lunyuanx.cui@intel.com>, "Wu, Jingjing" <jingjing.wu@intel.com>, 
 Xiaolong Ye <xiaolong.ye@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sC_iEmrKvht-_lR8OLvE4I67nJTPJYhhm1MEMqe0jZU_1789386892
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

On Mon, 14 Sept 2026 at 12:16, Loftus, Ciara <ciara.loftus@intel.com> wrote:
> > @@ -3123,7 +3116,6 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
> >       rte_ether_addr_copy((struct rte_ether_addr *)hw->mac.addr,
> >                       &eth_dev->data->mac_addrs[0]);
> >
> > -
>
> Nit: stray line removal. The rest LGTM.

I did this on purpose.

I was reviewing accesses to eth_dev->data->mac_addrs and noticed this
stray double line.
No strong opinion, but I would prefer it is removed.

> Acked-by: Ciara Loftus <ciara.loftus@intel.com>

Thanks.


-- 
David Marchand

