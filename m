Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E40CCAC5A7
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 12:33:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A6DE40677;
	Mon, 22 Sep 2025 14:33:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2609A402CB
 for <dev@dpdk.org>; Mon, 22 Sep 2025 14:33:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758544425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NwFfNXuEYC5w2CRyqR8EU2ag6WrGBHgUh5XAyf5EiU4=;
 b=irQ9TNbJsML7/jxgnSVENeGGNJ1XPnB0KWOzsoZoZccInNzO6Iot76NoMcfr62kLhhSOai
 WxKwtwqithHQZscZv2WPyYwMLeLalVaPE4vt2aGdP6xm9n8dxuZoqaJ6jo3ntaxNN2Bc6x
 NUARqY/dGtd/0JiJv74BoE0vfqJd+NE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-_8VNeTwYPT62zhzCsK9Q9w-1; Mon, 22 Sep 2025 08:33:44 -0400
X-MC-Unique: _8VNeTwYPT62zhzCsK9Q9w-1
X-Mimecast-MFC-AGG-ID: _8VNeTwYPT62zhzCsK9Q9w_1758544423
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-579e84da8a6so1701844e87.0
 for <dev@dpdk.org>; Mon, 22 Sep 2025 05:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758544422; x=1759149222;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NwFfNXuEYC5w2CRyqR8EU2ag6WrGBHgUh5XAyf5EiU4=;
 b=XlqSZqPepXT2TTlTN7xqgPAF7sS4M9xoR5Ydpb91xI/iNfJFQ7Htdgq32UTDtsOaQc
 xRvTE+w7TbiyhX9vO6GXx/3xOEyNrwfe3o2EQC2CnwbV+s4WI5uAqCGnX+2XmCw5fVlJ
 piH1vPmQFQyfmzFMCuV4H3zepZrYA3/hb+AWaOQD3uEsAEMmyBTaIIFrI4sXbBbk3ktZ
 myJ20XMxyZoy9EbITMGXR546VAKfRVBo7hHBZU0yj/6qQIdGNxUEouVH3p0QiO/TaHqH
 Nl1Zz/YLZc5xUhQePhdr9GR594uMjOE7W5TN0pnP8PbckrhLflFZpeAF4TJZpjZ5xrGB
 YxQQ==
X-Gm-Message-State: AOJu0YwbXKR9y2NQlrYcLPRAH1XRZnoPK8JWojbzM98UEvOSrq8+fJJp
 Qe8ZwkQ9DzlaG5B69YmMdGY0pUppt3BHMkl26q3ZR8e9+GQQWYelXn3RhYpGJq3qgyjGufHZNFA
 QVMYlWF8xvsPoG6TPOe7uVn+c5rYPaGkRsg4ylWFg7J3YmpnFvh8gbE5YQjKpVredMER4vDuDGV
 PIQ7h9V8W0C94VgeIKWgQ=
X-Gm-Gg: ASbGncvf/Q5QocBMCVZZiRTYhEAmz+vqcTKtKTkY6yR+xnob8FFgDS3E/w32sCZwGXA
 rkim946iniFvdSJLEUCzk20esJ80J8DypGJ6YhTM/eY8qtLNSarj2sJpZ1tnLjG+Vbg613IFBSK
 TLukla60QCv3zNKxzSSQh+liA=
X-Received: by 2002:a05:6512:6716:b0:577:184a:460a with SMTP id
 2adb3069b0e04-579e3d2aff7mr4051113e87.38.1758544422582; 
 Mon, 22 Sep 2025 05:33:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/0ISwc8EebvbZJJxicKfzanuCQb6Jtttze8If3QDMN0vBTJnKjiNGSm7012dJYJcJ5GZTXMJMvmiFPjSH19E=
X-Received: by 2002:a05:6512:6716:b0:577:184a:460a with SMTP id
 2adb3069b0e04-579e3d2aff7mr4051100e87.38.1758544422182; Mon, 22 Sep 2025
 05:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250407052532.1913-1-ming.1.yang@nokia-sbell.com>
 <20250719153227.1980-1-mosesyyoung@gmail.com>
 <20250719153227.1980-2-mosesyyoung@gmail.com>
 <82eea0d0-81c4-4623-984e-02ad11bdde59@intel.com>
In-Reply-To: <82eea0d0-81c4-4623-984e-02ad11bdde59@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 22 Sep 2025 14:33:30 +0200
X-Gm-Features: AS18NWAeb3j-1HCQuSmovTb9VDsvtnUkdtC8lo-_nciVZRi7c4oBCyFdecVrtBE
Message-ID: <CAJFAV8xrs164c5Ef05HCvkAC+UobMMw=M+ZheMyGEA=usHABuA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] crypto/ipsec_mb: fix QP release in secondary
To: Yang Ming <mosesyyoung@gmail.com>
Cc: dev@dpdk.org, kai.ji@intel.com, stable@dpdk.org, 
 "Burakov, Anatoly" <anatoly.burakov@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XpsktulRzHBhdxw-u75ugqAMup6Ut2fvcKcKTiQeyTc_1758544423
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

On Wed, 3 Sept 2025 at 11:27, Burakov, Anatoly
<anatoly.burakov@intel.com> wrote:
>
> On 7/19/2025 5:32 PM, Yang Ming wrote:
> > When a secondary process tries to release a queue pair (QP) that
> > does not belong to it, error logs occur:
> > CRYPTODEV: ipsec_mb_ipc_request() line 373: Unable to release
> > qp_id=0
> > EAL: Message data is too long
> > EAL: Fail to handle message: ipsec_mb_mp_msg
> > EAL: Fail to recv reply for request /tmp/dpdk/l2hi/mp_socket:
> > ipsec_mb_mp_msg
> >
> >  From the code path, cryptodev->data is allocated in the primary
> > via rte_cryptodev_data_alloc() (inside
> > ipsec_mb_create-->rte_cryptodev_pmd_create
> > -->rte_cryptodev_pmd_allocate-->rte_cryptodev_data_alloc).
> > This memory is placed in a shared memzone
> > (rte_cryptodev_data_%u), so both primary and secondary processes
> > reference the same cryptodev->data, including nb_queue_pairs and
> > queue_pairs[].
> >
> > As a result, when the secondary process exits, ipsec_mb_remove()
> > is called (inside
> > rte_eal_cleanup-->eal_bus_cleanup-->vdev_cleanup
> > -->rte_vdev_driver-->ipsec_mb_remove-->ipsec_mb_qp_release
> > -->ipsec_mb_secondary_qp_op) and it loops through all queue
> > pairs using:
> > for (qp_id = 0; qp_id < cryptodev->data->nb_queue_pairs; qp_id++)
> >       ipsec_mb_qp_release(cryptodev, qp_id);
> >
> > This causes the secondary to attempt releasing queue pairs it
> > doesn't own, triggering the error logs mentioned above.
> >
> > This patch ensures that a secondary process only frees a QP if
> > it actually owns it, preventing conflicts and resolving the
> > issue.
> >
> > Fixes: b35848bc01f6 ("crypto/ipsec_mb: add multi-process IPC request handler")
> > Cc: kai.ji@intel.com
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Yang Ming <mosesyyoung@gmail.com>
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

Series applied, thanks.


-- 
David Marchand

