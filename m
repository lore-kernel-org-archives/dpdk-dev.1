Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81498C88E66
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 12:28:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B65440B97;
	Mon, 14 Sep 2026 14:28:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 64FAE402AD
 for <dev@dpdk.org>; Mon, 14 Sep 2026 14:28:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789388886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KG1B4dwF2/uDrnjwg/ItVqci+Tf/vmmQQdqtuN2zwhs=;
 b=HE3c8RUowH/JOXxLyHDx2NACOFamcONL3u3idiW3jPcBu/WLe0BaZ9JQ9BZ3gaCREoFd8Y
 +0V3fMAzRh/0aNOq2AqfvE+SoD7Ew4kiKIxXCCyr5BAOiChddvE7jMoBy0Ug/XVN2fQK9E
 GLKA+j5u39nAytUhxiHx6s++aGObgBU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-N3Zwe3BGNJKtRJymdKrGog-1; Mon, 14 Sep 2026 08:28:04 -0400
X-MC-Unique: N3Zwe3BGNJKtRJymdKrGog-1
X-Mimecast-MFC-AGG-ID: N3Zwe3BGNJKtRJymdKrGog_1789388883
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3a46d5e30bbso22429321fa.1
 for <dev@dpdk.org>; Mon, 14 Sep 2026 05:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789388883; x=1789993683;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KG1B4dwF2/uDrnjwg/ItVqci+Tf/vmmQQdqtuN2zwhs=;
 b=mulTpSyHl/Av7/ReRUYzjW2Z4s22K3CQ6pQTMrHbQV0NlHjNSwL5tmK1GPZYYgE7YR
 mrGPlMaua8wmhEsdinBYyzjA4+b6rtecubpPmNgUDrhEC7C788VrID7BI7cWuN8zdvA6
 UgAfGXnajbdKqaY1m2rLIyFJXByEspvOTChNpfoL3kkkAuWZt9gEPmHpNnbPpph0zQlF
 jgd/5WTzaLRnSS6erOTRH7sbq+Nwyxf68UvSc7BkMZ4Yn5xf/kFM/Mr/v3zyR0z+tex3
 wDHDKDOGPvzjlYIP0v9AaalA5SzwtmRTnYD22PshC5AkqXHE58dt+DLyJjWRpL+8VtjF
 SWAA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2fLvbNsjx83Loxo1v9e+BSzK9UByzylu62KEm2FK5Io6Yz+QkEE0P3jxZTceD057JHNI=@dpdk.org
X-Gm-Message-State: AFuF++lhyCHMKTII3qpun7kuAMeNThVWe0dGRysuy5sipLGYQNBaOSPz
 agwqJYRJeBNr9BTBNya/2/MgBW4JfESRbmRtR7DiM+6FYkEbTP7fiXLq4y6wMiPhaD5vw40SI9o
 fD8akvswGmM/9AbNadJRoqLNaTulYijoCzOEbDZ5APGPAbkDSfqgkfyRlPtKmidO02qliQdC80i
 k8wDUlHG2SBSpbWyGRMiY=
X-Gm-Gg: AYBFou2lufOHN2z+IVya8ltgW5UEGy6aqyIzdfrwgIcZB5wGljl5fgmzp3/dZ9Q/5P5
 ppuGWyBVrLc8I9Q4mRYuucSThFtUsicjU/rkzfTr5drmMhUx0EXEP0JmT0nVyM9U4glG3cNnMN9
 cFnobVsq+jerkfrcNCxyZNdLm8vjABDTpSoqWKYihhmB+rgKgkZguUq73Sik8leR9zHDc2t09m4
 /wOXUTjetX5jeroKbpJolWrZq9wJBaH8o8+9Ua38oWG1jMI
X-Received: by 2002:a05:6512:31d6:b0:5b6:183b:d217 with SMTP id
 2adb3069b0e04-5b8ae6a7640mr537134e87.62.1789388883009; 
 Mon, 14 Sep 2026 05:28:03 -0700 (PDT)
X-Received: by 2002:a05:6512:31d6:b0:5b6:183b:d217 with SMTP id
 2adb3069b0e04-5b8ae6a7640mr537122e87.62.1789388882538; Mon, 14 Sep 2026
 05:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260914081725.1097704-1-david.marchand@redhat.com>
 <20260914081725.1097704-2-david.marchand@redhat.com>
 <IA4PR11MB9278E70DC4CD62AEF396DC388EBB2@IA4PR11MB9278.namprd11.prod.outlook.com>
 <CAJFAV8xZMxZfwSDo=1TpeeV93BQA43RW+ctzkjnC5QnPZ9FQ9Q@mail.gmail.com>
 <aqfiOvgEZpOR_raG@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aqfiOvgEZpOR_raG@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 14 Sep 2026 14:27:49 +0200
X-Gm-Features: AcwNN1Xf5cWxrWMEaxbZlnXaP41Pe2dFW23717AIzB5dNq2ytMAN1ueusPeC2KY
Message-ID: <CAJFAV8z+1patLi6Fe8iFfwJHWkgsSFjVn=o_NrJm-pO68VgH+g@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] net/iavf: fix duplicate MAC addresses install
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: "Loftus, Ciara" <ciara.loftus@intel.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 "Burakov, Anatoly" <anatoly.burakov@intel.com>,
 "rjarry@redhat.com" <rjarry@redhat.com>, 
 "cfontain@redhat.com" <cfontain@redhat.com>,
 "stable@dpdk.org" <stable@dpdk.org>, 
 "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Q4iief_f4Tt6IWj7zxtL9iB9fhyPxg5CC-qYIsWJvnE_1789388883
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

On Mon, 14 Sept 2026 at 14:02, Bruce Richardson
<bruce.richardson@intel.com> wrote:
> On Mon, Sep 14, 2026 at 01:56:36PM +0200, David Marchand wrote:
> > On Mon, 14 Sept 2026 at 12:19, Loftus, Ciara <ciara.loftus@intel.com> wrote:
> > > > @@ -3428,6 +3428,14 @@ iavf_post_reset_reconfig(struct rte_eth_dev
> > > > *dev)
> > > >       int ret = 0;
> > > >       bool allmulti = false, allunicast = false;
> > > >       struct iavf_adapter *adapter = IAVF_DEV_PRIVATE_TO_ADAPTER(dev-
> > > > >data->dev_private);
> > > > +     struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data-
> > > > >dev_private);
> > > > +
> > > > +     /*
> > > > +      * After a VF reset, all MAC addresses got flushed.
> > > > +      * The primary MAC should have been set in iavf_dev_start, restore
> > >
> > > iavf_dev_start is not guaranteed to have been executed before this handler.
> > > So I would change this comment to something like:
> > > "The primary MAC has been or will be restored by iavf_dev_start".
> > >
> > > Other than that:
> > >
> > > Acked-by: Ciara Loftus <ciara.loftus@intel.com>
> >
> > Yes, true.
> > I'll update in a new revision if needed, otherwise, could it be
> > updated when applying?
> >
> Single line text changes I can handle on apply, no problem, so long as the
> rest of the set is good to go.

Yes, sure.
Thanks Bruce.


-- 
David Marchand

