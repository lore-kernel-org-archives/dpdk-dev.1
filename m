Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAC7606A319
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 09:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O4zYJVa0
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9403C40659;
	Wed, 21 Oct 2026 11:53:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id CCD1B4060B
 for <dev@dpdk.org>; Wed, 21 Oct 2026 11:53:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792576422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aBW7S3tp4PO3xn108llR55jug4LYZcvIISsCV9mXdJg=;
 b=O4zYJVa0BtED7F2IXoSG5MbblvAfl1eI6pX5Gld93MWmX3OpIqaAnZ0LAZEtxE/i8GeFqV
 pXea7m637M4uqWQSaZzjdqMixj1ns/IkV4SYKDhNIAWyalqnLr3MeV2oZPgXOj2uaLaRcd
 LfJ/au7DkYD9J060RA727VdhXVVufyc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-6_dNyAGdPNqE4aMponNXfw-1; Wed, 21 Oct 2026 09:53:40 +0000
X-MC-Unique: 6_dNyAGdPNqE4aMponNXfw-1
X-Mimecast-MFC-AGG-ID: 6_dNyAGdPNqE4aMponNXfw_1792576419
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5bfa48eb110so23091e87.0
 for <dev@dpdk.org>; Wed, 21 Oct 2026 02:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792576419; x=1793181219;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aBW7S3tp4PO3xn108llR55jug4LYZcvIISsCV9mXdJg=;
 b=NdZFSynQ4vmtfW7aEYZQObihl+breE0q9MHOXqgglPmKNgsHC3VxFby4jum5S1n8Ln
 d+Sz+n9gGO3pW32s3QuxFhG99nE/Zfe8ZUybVgTTgeT1XGL31n6Y7PSvPVNKEaT+6t3z
 N4k1kbViCOjP6YZKUoEoGLLBEE+Jj9PvN6fUVD59vPDIBw/+7exDdPmuEWd8xjKIol0N
 Ssum8F+RxUbcKZYL1QcF2f7Do8sI2/uO5Hkq6cmlFOYSEMBjT+ySJu99gq7WjDKJdg0w
 n8Yiswk4c0SW4X15V2iAPIOBq2OmnJgrBXTvoOgQiyHkgfaXaJlw5KOlcTLkmmrK/2CM
 ooWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxwrPEfCfxpfkutrR2twbrUT63yA9kj++UuX/yXPaKfgIKPMB6MQ/azKffH+DJZV26Ugic=@dpdk.org
X-Gm-Message-State: AFq9FYIB7wBP2DCuD+hyWBGhB5KOvWHI4Id36onPhz7xUuK34/6E11k8
 oAlNe+OLFZeJII7A7QYROtwSMBs64F2q298jW6uq3nwik7Eq+R31de0Wqxc7dnGu7PqksevdPPQ
 M9zjkOgjLp6wHXcSezTyXBb6eXp7SnqPSaHNonDkIBssi7lkuj39RIEntOfZbjelNUBE6qlHza8
 aNz4BAtj0LdUVTI62sHN4=
X-Gm-Gg: AYBFou0EXG7upE5ut58f6S7rd42CH1gFptGnwcyuJWAEPxQtwIk1ERis4CjdsbkR6mY
 nE9hvtgKDVYrxX4wGp2ocP96l+RCdMtyOYybj2GlOFyMiawgD6ebYIfpFHewgZ3UQyRz2nlg+qA
 VLBtASAJ2Cq8PIPPp6/M0oH5rqjRdJxcIV8dFp/P+rXN71rP4pHkpjWZy9vxecrGoUY27cXBFt2
 Gf+mOt/OTm0qaTrAkCUqw9vKe/ujdJn/ZHgb9r7tAEPEnRd
X-Received: by 2002:a05:6512:12d6:b0:5bc:e430:9c8e with SMTP id
 2adb3069b0e04-5bfa1b961afmr522789e87.2.1792576418796; 
 Wed, 21 Oct 2026 02:53:38 -0700 (PDT)
X-Received: by 2002:a05:6512:12d6:b0:5bc:e430:9c8e with SMTP id
 2adb3069b0e04-5bfa1b961afmr522781e87.2.1792576418239; Wed, 21 Oct 2026
 02:53:38 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <35d9aed797cb433296b1c0d53fbda4b45c38e833.1792074055.git.anatoly.burakov@intel.com>
 <ff393eb2eef43c9ab3d27824badda9743e717a98.1792074055.git.anatoly.burakov@intel.com>
 <atDk1fSEoCYA8ZZd@bricha3-mobl1.ger.corp.intel.com>
 <atDlunTe_r3gqsVW@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <atDlunTe_r3gqsVW@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 21 Oct 2026 11:53:26 +0200
X-Gm-Features: AclHuK-RQbsFk3sjrjoPTJv8HavDh2g1pwLzETv5biapPJBCvobGQNGmeWM_GQE
Message-ID: <CAJFAV8wwuxGjGC95KkASQvPe07E64=N9L_aKuygT9LCoooTOdA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] net/ice: do not include private headers in testpmd
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Anatoly Burakov <anatoly.burakov@intel.com>, dev@dpdk.org,
 techboard@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fDzmwvyeZFjxNqM5ZkicyWUwIzXPEVJZUE7tXAlYwa0_1792576419
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 15 Oct 2026 at 16:40, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Thu, Oct 15, 2026 at 03:36:05PM +0100, Bruce Richardson wrote:
> > On Thu, Oct 15, 2026 at 03:21:04PM +0100, Anatoly Burakov wrote:
> > > Currently, the `ice_testpmd.c` file includes headers that are only
> > > available to driver itself, but should not be available to applications,
> > > including testpmd. Instead, testpmd should access them through public PMD
> > > specific API.
> > >
> > > The ice driver does not have one (even though it offers a testpmd file), so
> > > add the public PMD-specific API header, move all function definitions
> > > into that file, and get rid of driver-private includes in testpmd file.
> > >
> > > Fixes: df539aaf35cb ("net/ice: refactor flex descriptor protocol field extraction")
> > > Cc: stable@dpdk.org
> > >
> > > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > > ---
> > >  doc/guides/nics/ice.rst                |  3 +
> > >  doc/guides/rel_notes/release_26_11.rst |  2 +
> > >  drivers/net/intel/ice/ice_diagnose.c   |  1 +
> > >  drivers/net/intel/ice/ice_ethdev.h     |  9 ---
> > >  drivers/net/intel/ice/ice_testpmd.c    |  7 ++-
> > >  drivers/net/intel/ice/meson.build      |  1 +
> > >  drivers/net/intel/ice/rte_pmd_ice.h    | 76 ++++++++++++++++++++++++++
> > >  7 files changed, 88 insertions(+), 11 deletions(-)
> > >  create mode 100644 drivers/net/intel/ice/rte_pmd_ice.h
> > >
> >
> > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> >
> > Given where we are, this is probably a reasonable solution. However, I'm
> > also thinking that maybe we should have a discussion as to whether testpmd
> > - which is, after all, for testing PMDs - should be limited to the public
> > APIs. Is there not a case to be made for allowing the per-driver testpmd
> > files to access the internals of the driver for testing purposes?
> >
> +techboard and others for more input and thoughts for the future.

Accessing some symbols from the internal ABI is probably ok but it is
a slippery topic.
Like the ethdev ops changes between 25.11/26.07 that triggered crashes
in app/test.


-- 
David Marchand

