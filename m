Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99430C88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 11:56:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0706340B9A;
	Mon, 14 Sep 2026 13:56:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3B29740A75
 for <dev@dpdk.org>; Mon, 14 Sep 2026 13:56:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789387011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KcTkfpSnyGNkPNxw25aTyVFDqxhmYUuw/+2ywp9A6A0=;
 b=MkZKdggcuNTSGxpNJDU2CeqSaSrZSHldCk5AiZbndjCGXK/R+rNC/mflrNEqgeHDugBHK3
 va5BzGE2fU+Hv0RiWvHVhCi94FiITu44eJFXD1S1FJAZiLOOBwQo/1YhI6MsjEwRQ8EB4y
 CGR2GOx3viRVKGjfWXTZ3kMzEhxOf8g=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-pNQ0wKTfMCe2StS9cTGCuQ-1; Mon, 14 Sep 2026 07:56:50 -0400
X-MC-Unique: pNQ0wKTfMCe2StS9cTGCuQ-1
X-Mimecast-MFC-AGG-ID: pNQ0wKTfMCe2StS9cTGCuQ_1789387009
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3a59aa88086so16492131fa.2
 for <dev@dpdk.org>; Mon, 14 Sep 2026 04:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789387009; x=1789991809;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KcTkfpSnyGNkPNxw25aTyVFDqxhmYUuw/+2ywp9A6A0=;
 b=r41UPi2SWssP9+hkGCxAztrXt3vhv8bfpa9BV3jHxW3T3GbqIgn1Z1UzCkvTBYZWfy
 6Y+Kw8w6G/DAcpU8LlYZ/1r/CF0vnARFBysJ7mW4KTPNvXKFOS/iyEJdJdD20tU/7wOF
 jf8fpb93tIjC8KW99c0/U7bAPThS/wSe9itlM/wH3U0AxmFnDwg/HFG/brpSBm9suGlf
 Y5i3BaApDVexldzvuuRKmfuJtPVoY3HJTETgScjKYUYNki16JXkJzhiytTjYiqwwApXQ
 CMKz2YS+L3j3KosUwwKhreG4Ub+lPHCBxx+fddrnEECGWq6qX2XJepSaQrDhhh67KrIp
 44EA==
X-Gm-Message-State: AFuF++nsb7rvRsmjuirSOGMAISjlY0QAYXVAHqd4n3DvoOP1kqR88S14
 GWjUncZ+TxbH++fgE8LVsCpw+DPyXCQL0XdI3WjRMkD1gq28t7blic4TjaVZjQj5Krvg/EFzz1Q
 UCnUrNX70wJTNHaKHE93xoQRBNL7rx2gyMahVuVvaZnq1Lo07xlrTZ3Gqsp/a9z3dY1x9Xza8nR
 i/PxOrEI57e94krXVjJ3M=
X-Gm-Gg: AYBFou2C0Fkz7psQm1A3U5lDLbH0/J3MzoFVVQz779cfjA2uX1uC0DvVbIgO63VoERs
 yC1X/GLW8NzQsyYZ+kOHYl1DhjzdwO3L1FwdGfmazQz0kVP5yRrn5JRmogAqNSrNpBnQVjkm4xf
 9XTwkHcZAherMX8aMy/KbhqqaBapGr15HsBNoVtREAk1eyfiaGui+FrH3qltyngSbPaBnZDOKQS
 SlPMYHuVwC52hMIg2lvV81+3PKF13x66Nll5SG8KO1iDcTd
X-Received: by 2002:a2e:a993:0:b0:3a3:7681:6d69 with SMTP id
 38308e7fff4ca-3a5c89797d1mr4490711fa.18.1789387008640; 
 Mon, 14 Sep 2026 04:56:48 -0700 (PDT)
X-Received: by 2002:a2e:a993:0:b0:3a3:7681:6d69 with SMTP id
 38308e7fff4ca-3a5c89797d1mr4490611fa.18.1789387008130; Mon, 14 Sep 2026
 04:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260914081725.1097704-1-david.marchand@redhat.com>
 <20260914081725.1097704-2-david.marchand@redhat.com>
 <IA4PR11MB9278E70DC4CD62AEF396DC388EBB2@IA4PR11MB9278.namprd11.prod.outlook.com>
In-Reply-To: <IA4PR11MB9278E70DC4CD62AEF396DC388EBB2@IA4PR11MB9278.namprd11.prod.outlook.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 14 Sep 2026 13:56:36 +0200
X-Gm-Features: AcwNN1XnjPEqodJZs-PKy7B2RJtjM92YyUPCXjJnzlnfdnlBicC-oJm9lbOp9r8
Message-ID: <CAJFAV8xZMxZfwSDo=1TpeeV93BQA43RW+ctzkjnC5QnPZ9FQ9Q@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] net/iavf: fix duplicate MAC addresses install
To: "Loftus, Ciara" <ciara.loftus@intel.com>, 
 "Richardson, Bruce" <bruce.richardson@intel.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "Burakov,
 Anatoly" <anatoly.burakov@intel.com>, 
 "rjarry@redhat.com" <rjarry@redhat.com>,
 "cfontain@redhat.com" <cfontain@redhat.com>, 
 "stable@dpdk.org" <stable@dpdk.org>, "Medvedkin,
 Vladimir" <vladimir.medvedkin@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: shQ5nu1UTgCkCFtpCS6jHzvbnoeWvAuxHc-tP7kEPvQ_1789387009
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

On Mon, 14 Sept 2026 at 12:19, Loftus, Ciara <ciara.loftus@intel.com> wrote:
> > @@ -3428,6 +3428,14 @@ iavf_post_reset_reconfig(struct rte_eth_dev
> > *dev)
> >       int ret = 0;
> >       bool allmulti = false, allunicast = false;
> >       struct iavf_adapter *adapter = IAVF_DEV_PRIVATE_TO_ADAPTER(dev-
> > >data->dev_private);
> > +     struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data-
> > >dev_private);
> > +
> > +     /*
> > +      * After a VF reset, all MAC addresses got flushed.
> > +      * The primary MAC should have been set in iavf_dev_start, restore
>
> iavf_dev_start is not guaranteed to have been executed before this handler.
> So I would change this comment to something like:
> "The primary MAC has been or will be restored by iavf_dev_start".
>
> Other than that:
>
> Acked-by: Ciara Loftus <ciara.loftus@intel.com>

Yes, true.
I'll update in a new revision if needed, otherwise, could it be
updated when applying?


-- 
David Marchand

