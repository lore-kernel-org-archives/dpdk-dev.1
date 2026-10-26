Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5AA606A31B
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L+sM1dZS
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB430402A3;
	Mon, 26 Oct 2026 16:39:48 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id AE5A640275
 for <dev@dpdk.org>; Mon, 26 Oct 2026 16:39:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793029185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R/3qYIToffbOZiBZxpvPHxvu9IkRlgR28PgVZaApimQ=;
 b=L+sM1dZSPJrU0dCUQ94x07RUxzMavcZEq4NIyaiyLdzUkQw/gCHhtBfmhR4KLKDf3GaeCl
 gLBhxBQn/Sstptg703z/T0OGhgiLBMqx7odm9eYM2rWgO5JnfoiJD2V47gbNa51QgNs6Fk
 jSOXpcvDqyLlECaJos2JwhU9KQBPogQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-XQNj86cUN3Odb8AMWB5qVA-1; Mon, 26 Oct 2026 11:39:37 -0400
X-MC-Unique: XQNj86cUN3Odb8AMWB5qVA-1
X-Mimecast-MFC-AGG-ID: XQNj86cUN3Odb8AMWB5qVA_1793029176
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5bcd2b01d17so1388065e87.0
 for <dev@dpdk.org>; Mon, 26 Oct 2026 08:39:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793029176; x=1793633976;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=R/3qYIToffbOZiBZxpvPHxvu9IkRlgR28PgVZaApimQ=;
 b=UMY6c+5JM+dH/5KVQtCVH5uOWTwbdH9kf6Wew9jjE4yNuXhdDD7vXAHyVB5Zgk8bQ2
 KMcidE9s696TII6MJsZtPHQbiiEU+BipJ7Ss9Qc7Ahl4J2qXaSaaV1672yKF78lyrtOu
 WxckYKNBg73bl7pgxmGCgIFhvNmyDWiwMMMpdhztMRLpKgC5ocFyJZ8G6PA7Z2xwAurt
 RzE8IVbDru3GZFtHOuKauvXWNqX4XYA4xU8/ReixTKpam1qBZM31OWtpnELZHn+gs/JA
 Jc1eTsh+2Y8fbk3mr6d1ZCkyBJaFpJzlFL8OmV8FoHPaj7aUQtItdLD2CE3aYOyJ/yNF
 KCEg==
X-Gm-Message-State: AFq9FYKuw8mNdja6J3LlWzhOaAc8CquBfTmn8rFMJyJEOmAUhdmW4BsN
 WLoC6VWPvO+Y54jJi/SpnF56s3EmkuHB4YrV5qMxwWAQwv0YBeSfTXWKwueFJAFiRDFor1/+pvi
 YSyDl583wT7muTD+lxh3R/2KBu9sqE7TgNcNVDXn71uHFzdkJfUFsbeY7gQkhrxx/U/eB9GdzPa
 P0p+xX/V5wQz9OwvP6Lb8=
X-Gm-Gg: AYBFou3grT696jZRpRfAfLx44m3nz/KPSEnVCuyhC20JkqGy0r9m8ktvKGm95QNsxwx
 9Xtq4vywxESILtqQngv/u3+fOv2WSBZi5rdsXej7nUUp2PcEMggeta34ZTgAqVQ8Jji4MlM0lTN
 82TX03QBeb17vfxXHn25F3JG3oUpKvulopUpQoW3OiSn+JKn1OfKr14qrswrBA960BYxV472u3I
 jlKY7de/IJhAqcdA+VgkNoXFTNnUYUL4Tjw6K0wNFYVdTkA
X-Received: by 2002:a05:6512:4013:b0:5b8:f960:1bd8 with SMTP id
 2adb3069b0e04-5bfb71fe1cdmr2368863e87.61.1793029176053; 
 Mon, 26 Oct 2026 08:39:36 -0700 (PDT)
X-Received: by 2002:a05:6512:4013:b0:5b8:f960:1bd8 with SMTP id
 2adb3069b0e04-5bfb71fe1cdmr2368860e87.61.1793029175582; Mon, 26 Oct 2026
 08:39:35 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021092318.1554295-1-david.marchand@redhat.com>
 <20261024132138.7239-1-david.marchand@redhat.com>
 <20261024132138.7239-4-david.marchand@redhat.com>
 <b0870d53-0555-43a2-a5e8-8b4cf5917048@intel.com>
In-Reply-To: <b0870d53-0555-43a2-a5e8-8b4cf5917048@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 26 Oct 2026 11:39:23 -0400
X-Gm-Features: AclHuK_Rh9cXsoTwR-LXgYS8ek98TrCC4fIuNjDx-NIr_c_SoIMCPhwxhNemP4A
Message-ID: <CAJFAV8w+__2squsVhXhVi5qzJBSpK0hdies7ZLmZRu+eyqGm1A@mail.gmail.com>
Subject: Re: [PATCH v2 03/12] interrupts: do not duplicate interrupt handles
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, hkalra@marvell.com, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, 
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jakub Grajciar <jgrajcia@cisco.com>, 
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -K_YpEovo7ALfgkuoz-KEIzc2ZVasqlYDRBHgu5oJwo_1793029176
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 24 Oct 2026 at 16:11, Burakov, Anatoly
<anatoly.burakov@intel.com> wrote:
>
> On 10/24/2026 3:21 PM, David Marchand wrote:
> > The FD leak warnings recently added have revealed an interesting issue.
> >
> > An interrupt handle is allocated and living usually in a bus device object
> > (or some standalone code, like the alarm code).
> > All the logic around the referenced FDs in this object are specific to
> > the callers, and those FDs must then be closed in the callers context.
> >
> > On the other hand, the interrupt subsystem works with copies of interrupt
> > handle objects passed to it via rte_intr_callback_register/unregister.
> >
> > When releasing this clone of the interrupt handle, the FDs are reported
> > as leaked, though there is no way for the interrupt subsystem itself to
> > know what to do with those FDs.
> >
> > Instead of creating a clone, reference the interrupt handle directly.
> > The callers are responsible for unregistering those handles,
> > closing the FDs and freeing the handles.
> >
> > This change also switches the interrupt source lookup from FD based
> > matching to pointer based matching.
> > The original FD based matching allowed different intr_handle objects
> > with the same FD to share an interrupt source.
> > However, this was problematic:
> > * the cloned handle stored in the source came from the first registrant,
> > * the ucb_fn callback would receive this clone, not the (const)
> >    caller's handle,
> > * with multiple handles for the same FD, later registrants would get
> >    the wrong handle in their callback,
> >
> > In practice, DPDK components use one intr_handle per FD, so pointer
> > based matching simply enforces this existing invariant.
> > The interrupt dispatch code continues to use FD based matching since
> > epoll returns the FD, not the handle pointer.
> >
> > The unregister callback (ucb_fn) signature is updated to take a const
> > pointer, reflecting that the interrupt subsystem no longer owns the
> > handle. Note that with this change, the intr_handle parameter passed
> > to ucb_fn is the same pointer the caller registered with, callers
> > can simply use their own handle from cb_arg instead.
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
>
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
>
> However, my patches fixed the issue in instance_dup without removing the
> API. Those fixes should probably be backported to stable in some form.

Indeed.
I can take your first two patches right after the 2 first fixes in
this series, right before removing the duplicate API.
That's just a little rebase for me (I'll double check compilation is
not broken between patches).

WDYT?


-- 
David Marchand

