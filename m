Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF2FCC6B3A
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 11:40:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D6CD402DA;
	Thu, 15 Oct 2026 13:40:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 66FDA400EF
 for <dev@dpdk.org>; Thu, 15 Oct 2026 13:40:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792064418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uZKlCKBDDmBqCBkzPRCfa1DATMLrrZ0/9jAqbZS87ME=;
 b=UDIJbnYBxId0xw2KuHaDvWl6c0SwlSFUeAfkApwSIAM1lfWEeU2OcLrAIkEgo1U8bsDByW
 kSxEr+mxMU/5hAkarqdiCk2FIp5WDRDEtXfAswy0lJ1rg5AuHOpeJjj4CdlTVpegR8oFnX
 B4jbsYYZyDyiVqsvX4e9ZVWP4JMm2TU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-gZvSXacuO0GcVFG2nPAk6A-1; Thu, 15 Oct 2026 11:40:16 +0000
X-MC-Unique: gZvSXacuO0GcVFG2nPAk6A-1
X-Mimecast-MFC-AGG-ID: gZvSXacuO0GcVFG2nPAk6A_1792064415
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3aafdfadb53so4740831fa.0
 for <dev@dpdk.org>; Thu, 15 Oct 2026 04:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792064415; x=1792669215;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uZKlCKBDDmBqCBkzPRCfa1DATMLrrZ0/9jAqbZS87ME=;
 b=OpkYwdKJrdANqTT+zxT2Azx0WYYWtdJ21Khi65g8QC+15LC++nAaCYkqCqel1XrvZ7
 yQEvaLdeWWlNWTK5JRtXAsDcXbYcOkBZszQ1GQ8ahQeEIGpRq5iuaJXXxgNO6ENQmCCv
 ko8tn0hX8Lh6nadS3cGVLJe3RZg61UVvJCZ/zWrFRZIb1AlQwrcDi37ZfRHHorRAYIyB
 3GVFRnKzK2fwNzD/9W+7WuY1uHAlIs63VC+JfdvyEK7a5ly38Os3Wh7frWQ1eJ0ndCj/
 kp1inHguqCdzzB6uVfUrjg2ceyAYe3GiucwKenUAHh5dg9wRsVDlTRqkbObn4W+eywkQ
 PA5A==
X-Gm-Message-State: AFq9FYK3idNjTkUdc4LOMmtx+9hzI/CyMzaNip149DCAXakCaZucOBSn
 y8RfWDk28mvS353/VePo0qdxRFynQ1IPUJ7RPBDVcTH3VOTZDFsBv7PIo2ktBacjEhzGG4fj9fQ
 ZUNIELHhLmDPVqd2maa3y6cq2ptBIVUWbyE0y8EnlfkfPwuFUYMaB392FY0xnK4uFe8olOCxQI6
 phhR+kF06+Wue+74Qhpto=
X-Gm-Gg: AYBFou27lVuVQfpDSIh1ru5ywyM8euQCSwoc2IZrTgrXbCRxJKcnspyfIUXLqfhYE6y
 ccUM4JcMFetJj+zw1WE/OxVwq6qNmtBUfVkIpMCrt6605v9YDJjVkogBbmUS5qbCEya5gokSLFS
 sRfwaa/kBCkDwAKc76mwRS69uKpMeBoYTfLZk+gijx0ZxxLK8QplcmRIp2L67HdbB1scjtCUOBd
 ONHMcJ5rTijxkDKfTJpy5dBNvwjjpW4chbdVHxuur+ESMq3
X-Received: by 2002:a2e:bc23:0:b0:3a8:7caa:cd4b with SMTP id
 38308e7fff4ca-3a9c53b2673mr36188121fa.7.1792064415180; 
 Thu, 15 Oct 2026 04:40:15 -0700 (PDT)
X-Received: by 2002:a2e:bc23:0:b0:3a8:7caa:cd4b with SMTP id
 38308e7fff4ca-3a9c53b2673mr36188001fa.7.1792064414687; Thu, 15 Oct 2026
 04:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <20261014201627.571496-1-thomas@monjalon.net>
 <20261015112916.2622825-1-david.marchand@redhat.com>
 <20261015112916.2622825-3-david.marchand@redhat.com>
In-Reply-To: <20261015112916.2622825-3-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 15 Oct 2026 13:40:02 +0200
X-Gm-Features: AclHuK8nfO_l-Iyrr7yVHjosdb8JiHqTQYA7zOMh4XQrWxdnQJJP-eyfw4lTXGs
Message-ID: <CAJFAV8y3=VWOBBVprmZ2mJg29DY5R9atk77vZ1HrqR25LVjwig@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] eal: enforce internal API check with Clang 14
To: thomas@monjalon.net
Cc: dev@dpdk.org, bruce.richardson@intel.com, anatoly.burakov@intel.com, 
 stable@dpdk.org, Aaron Conole <aconole@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8La8u6i8JInuaq6VG-wIVRAEVkGzQy9oyFE1LlZoI-U_1792064415
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

On Thu, 15 Oct 2026 at 13:29, David Marchand <david.marchand@redhat.com> wrote:
>
> From: Thomas Monjalon <thomas@monjalon.net>
>
> The __rte_internal macro is intended to prevent calls
> to internal API functions unless ALLOW_INTERNAL_API is defined.
> Unfortunately the check misses some calls to internal API
> when built with GCC or Clang.
> Clang can be better to diagnose such cases.
>
> Clang 14 and later support the error attribute
> and therefore select it instead of diagnose_if for __rte_internal.
> Unlike diagnose_if, the error attribute only rejects
> internal API calls that remain after optimization.
> Internal API calls can therefore go easily unnoticed,
> making internal API checks less strict with recent Clang.
>
> Prefer diagnose_if when available to keep strong Clang diagnostics.
> Retain the error attribute as a fallback for GCC.
>
> Fixes: 4ab63cd60ceb ("eal: fix internal ABI tag with clang")
> Cc: stable@dpdk.org
>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Just a note about CI.
It seems we have some trouble with the ovsrobot but this series passes
GHA in my repo:
https://github.com/david-marchand/dpdk/actions/runs/38725255308


-- 
David Marchand

