Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF590606A319
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GW6f1VPF
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFBED40264;
	Thu, 22 Oct 2026 13:40:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 535DC4003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 13:40:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792669246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gyHHKji2psLnpsKgcJYAt5xanvSrtEWQZMPF+06bOW8=;
 b=GW6f1VPFSvdYUVTqnq/88gFFxMqqyE/CxCZobOc+10pUi22ci5lwk5DbxCp9hE6IsPoOTw
 XbO4eMctqv9k5P2BYvXsQHvomFsebUgM3LxM1eqjt3caeKubC9R5Z1odltTsGTr4cbnhFV
 Y/el98tBaNz8hM+ScvWgmVr9PwtIL9k=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-jPAlp_7zP3y7YLEYT9rTxQ-1; Thu, 22 Oct 2026 07:40:45 -0400
X-MC-Unique: jPAlp_7zP3y7YLEYT9rTxQ-1
X-Mimecast-MFC-AGG-ID: jPAlp_7zP3y7YLEYT9rTxQ_1792669244
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3a767a22ca6so9661471fa.1
 for <dev@dpdk.org>; Thu, 22 Oct 2026 04:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792669243; x=1793274043;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gyHHKji2psLnpsKgcJYAt5xanvSrtEWQZMPF+06bOW8=;
 b=RWLxowuG9X/xhk2K74Zgh8rliu9YYol/c77D0vmVWilP40DuR+HFKoUyFi3C1c2kRE
 NDcBpHvWjH6kOQTwzaDQkqQ2FoiYUNWbn72cScG5yvKI05whGNoo5ce2rJB9W80z5yZv
 8AOTmbVd8bWb5aizSBq11ii3nqgDEH34eNVOQNGrDeDTDIGX5MRrnS0WoAm+j3bzlnZY
 0r/5QdkXSvbAGwMZYuAxhn26oQJX5ivuoO/4da1Xa0vs9ibvhIzFOvRyyx2K6yeQTQJe
 qwDQX6Gd1B2tLEYRBgXMlfkWqXnpyVdU5hOLCoTmpt/98CKaiVRcDhFFG16pRiu1yvIr
 Z/CQ==
X-Gm-Message-State: AFq9FYJlJwJWCPI9pDaD1WY8dPxFaKrdpy71wDuozLORKdv/vxR1E9m0
 tpI/64wWrdvjy462JXnL8tshpK1L9mfLGMdR5nGp1K36VhU/2D6Ry5OY+eAy3Xq5nVmNaN4kgyX
 +HIn3IdGPh5/nCGIQ+CKLzR5nmB3Rp1RqltuinNPhFMHljb+3hRrpibr/aBasL7+zpf2X/Qm7Ep
 EvJs+UcE80hNTn156cZ3/0aWIGpwPOEg==
X-Gm-Gg: AYBFou2VNklT1SkQmXCM8avn5I8HEBeK7ikgbJOW1VN5uft1NI7P4VlTwuIT5WMncgw
 gZ0yp6TU1qWNbcPOKWxZgp/BOLZJqdl7uqK6x/eVQrV81P+YTsH1hkvqU2E94NPIRFWmv27CdXU
 HvnmFp3/8YuOTZfQtcYthEQgz76VvRylIgJ9ntql0HggeY3auZGD4arxh2nBZpp4dSk1hLg1VIR
 5h3apITNxU8VtiQDPVkpYvAU1YVkrowCfXI0L1oc7ALSLFl
X-Received: by 2002:a2e:be11:0:b0:3a6:553d:cb1c with SMTP id
 38308e7fff4ca-3ac4415e4e1mr13240641fa.12.1792669242791; 
 Thu, 22 Oct 2026 04:40:42 -0700 (PDT)
X-Received: by 2002:a2e:be11:0:b0:3a6:553d:cb1c with SMTP id
 38308e7fff4ca-3ac4415e4e1mr13240591fa.12.1792669242287; Thu, 22 Oct 2026
 04:40:42 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022082618.2730417-1-david.marchand@redhat.com>
In-Reply-To: <20261022082618.2730417-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 22 Oct 2026 13:40:30 +0200
X-Gm-Features: AclHuK8VB_y4gnaHd1ImJdBz5Kpioa9Yk7hMgK6O741iae903SQAnYY-zvQMX10
Message-ID: <CAJFAV8xVs52n+3cS9wH4hggFUdu5U8QrCFisgasEeP5sr1Ev=g@mail.gmail.com>
Subject: Re: [PATCH] bus/pci: fix interrupt setup for ioport in secondary
 process
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>,
 Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: U8a0LsmPdq_aZpsuf_cberWLhAe79p_L3-Jiai_9xoc_1792669244
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 at 10:26, David Marchand <david.marchand@redhat.com> wrote:
>
> Now that the interrupt handle contains a -1 FD by default, the logic in
> this code is wrong (yet, checking for a 0 FD was theoretically broken
> even before).
>
> The first invocation for a given PCI device will always have a FD < 0,
> since no code allocated a interrupt handle in the life of this PCI
> device.
>
> Bugzilla ID: 2067
> Fixes: 63a0dbf661e5 ("interrupts: mark FDs invalid on allocation")
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Tested-by: Yu Jiang <yux.jiang@intel.com>


-- 
David Marchand

