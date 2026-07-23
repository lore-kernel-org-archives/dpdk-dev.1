Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9343CC531C7
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 08:54:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF89A4028A;
	Thu, 23 Jul 2026 10:54:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5DED24027C
 for <dev@dpdk.org>; Thu, 23 Jul 2026 10:54:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784796886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7Ixpstlc1y7GMzmxsi1rFElYZ9Z9NlVs65ALK9cdi+Q=;
 b=eurv6IGf6NlDsCZIZhTydb0Mg+mKVzQmLcZu3AEw5m6pyLIlkCpj/ntazcZ4XnaAKkOUWw
 3RjRNbEmuCwqPDMA0jipyB3fDcs2OwxHIedoeOFoW7VmbqAz3yW49Ycb7txahUsmFsKpRS
 6QnjRU7x7dKm68X7yYMEu3wypji8cP8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-sJ3PurPwNueTumdg_lf6aQ-1; Thu, 23 Jul 2026 04:54:45 -0400
X-MC-Unique: sJ3PurPwNueTumdg_lf6aQ-1
X-Mimecast-MFC-AGG-ID: sJ3PurPwNueTumdg_lf6aQ_1784796884
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-39eb3b2f25dso1520521fa.0
 for <dev@dpdk.org>; Thu, 23 Jul 2026 01:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784796884; x=1785401684;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7Ixpstlc1y7GMzmxsi1rFElYZ9Z9NlVs65ALK9cdi+Q=;
 b=YMnhcbeXZtj/rbg2o3ljEVbfQ9S7RQ5NK2d38i0bnSaAd4cLqOEc9LoMR6MYiCPU2w
 DoJQG/9ulNYG0G1adWVwrPOYGhwo0LX3yKlc77yU+1krlb53LZsxDXp2yisEXZMbv7y9
 TvZATPL9/LiPv+bChQ/xPjP4jI5ywEpRRnVML2iNLS5KU7HNGLUkQSt7zabBF7gflrKO
 b3oHkvc3Qul7JmG3pwYA9n9uPhbeKzpeezqYRwonzSe5/Wnhovf8dsNEzz7RnESaW4pV
 1f/iGnqc5kOoQbIz0tMSpVljVS+emvOxWN6HoAG2ogkzheW+RNBt+Dtt38+RLZNmeAVW
 Ewew==
X-Forwarded-Encrypted: i=1;
 AHgh+Roq29RzUVhjmFPzjiB9BctqZ6n0SoOKJHiSelUzyoIUsGWqrcHVNTxcC434YkeTotuAUU0=@dpdk.org
X-Gm-Message-State: AOJu0Yx1HoK+kx2t7qHtIOgIPbskeZSt0QogN8UGFIX3EeVHLoSFf/lI
 /opMNv+ZamacOl0tLhBAP2nth5VQQ3viRfRlGrXf/OQ/z0fRDpx4PvhgGoTQVdxJxLODSjlh4mh
 MkwjQPr/OnCBFH8geySLOcr0JuaJvi0ZoXHrLzAKHlLzwZkIfcXXBhSQOsM8MvzH49akF/zF4Wo
 Xkbni0+dqKeV0cBTmjNNgxjNWXNrA=
X-Gm-Gg: AR+sD12NMwSYIB0UxYtQ8YfwScSGHDACzNP7+gxpL/CUaYcwUJjY00WaMl5tHXtfqVL
 D/uzYqjYlj9WOsQq6XQSav9+ECCfgJvR4XWo1iY0YkqMs7+9+1s8no6KjaXOHConQhVA+plIdrx
 izlGmpIAWyfSRXdFYkZxJTgnwQpRPGmkSGaY4VuHfXMORkm0AxUa+CBYVAruQ8e56UM46pWy+Rc
 dhX1E9oI7oRpo1PnvJSxfJYGtGFPwDQd7g218Rrd4c3vhWd
X-Received: by 2002:a05:6512:a89:b0:5ae:b88f:311e with SMTP id
 2adb3069b0e04-5b2b2e59c32mr455663e87.15.1784796883773; 
 Thu, 23 Jul 2026 01:54:43 -0700 (PDT)
X-Received: by 2002:a05:6512:a89:b0:5ae:b88f:311e with SMTP id
 2adb3069b0e04-5b2b2e59c32mr455654e87.15.1784796883279; Thu, 23 Jul 2026
 01:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260713105935.24152-1-dsosnowski@nvidia.com>
 <CAJFAV8yNeZiiBrOn4Uei=Yg_T2he9p88jeizAh+3_ucqnRt_dQ@mail.gmail.com>
In-Reply-To: <CAJFAV8yNeZiiBrOn4Uei=Yg_T2he9p88jeizAh+3_ucqnRt_dQ@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 23 Jul 2026 10:54:30 +0200
X-Gm-Features: AUfX_mxyx02XWpdbptBPpgEsqell3O_51WYB5FWK2rqH4tgLfe-E_6HqLn264LI
Message-ID: <CAJFAV8x8Gfbk0whqi1EoFEVaow4EArgK8JdoHxMYxggUm_OvNA@mail.gmail.com>
Subject: Re: [PATCH 26.11] ethdev: remove flow metadata symbol aliases
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, 
 Ori Kam <orika@nvidia.com>, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lwWLKse-E7kICDrhmpP7uiwo5288bcopqa5bZ1vtnH0_1784796884
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

On Thu, 23 Jul 2026 at 10:31, David Marchand <david.marchand@redhat.com> wrote:
>
> On Mon, 13 Jul 2026 at 13:00, Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:
> >
> > Version aliases for rte_flow_dynf_metadata_register
> > and EXPERIMENTAL version on rte_flow_dynf_metadata_offs
> > and rte_flow_dynf_metadata_mask symbols added in [1]
> > are not needed after ABI version bump.
> > This patch removes them.
> >
> > [1]: 56045d198968 ("ethdev: add aliases for flow metadata symbols")
> >
> > Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
>
> Acked-by: David Marchand <david.marchand@redhat.com>

Rebased on 26.11.0-rc0 and applied, thanks Dariusz.


-- 
David Marchand

