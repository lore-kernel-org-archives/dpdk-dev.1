Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49652CC6B3A
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 10:57:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D64EE4060A;
	Thu, 15 Oct 2026 12:57:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id CAB4F400EF
 for <dev@dpdk.org>; Thu, 15 Oct 2026 12:57:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792061859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G+q0nMJQJMrrBLLJdi+ovS6dPdnEWyZfbS1NC/hVYtM=;
 b=PKZE+t1xRPrSSxfgkD+gCrikERccixgViCNeqljBcSyqZJOAl0eb6kbGFulQM9ff37vRwj
 H95PUuUyPqw9vs8PpcHOtYbVXVbSDukMbzW2B69pjNFeQpdJQ7P02mPlanP4WUUsYoJDHc
 W+yWT2y7HKh3ejDxHUexQ2niosgiap0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-xJ-cXWBeO46SuMY1eZaDVQ-1; Thu, 15 Oct 2026 10:57:38 +0000
X-MC-Unique: xJ-cXWBeO46SuMY1eZaDVQ-1
X-Mimecast-MFC-AGG-ID: xJ-cXWBeO46SuMY1eZaDVQ_1792061856
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3aaf6c66b83so9751281fa.3
 for <dev@dpdk.org>; Thu, 15 Oct 2026 03:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061856; x=1792666656;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=G+q0nMJQJMrrBLLJdi+ovS6dPdnEWyZfbS1NC/hVYtM=;
 b=O6SUy28qY3DM89LG7zaYU2j+7wgu5OD61oP1NU2MQasfrHHDWNVpU9jbl0tgnWefRs
 6Hwot6sNmWFBAIH+5c/lqTngfNcpWTequERoezLNu46l4TT1j4+q5Jm0Rl5N4tHrb4Tn
 BoscV/7F/TgDcyDo0vDRHw1wXTnCncF1rbn0jk/Tyo7SfUcr1T/0HZEBjrphT9EG1LD/
 YG8iimqE7Q8/MAjznCKOFQjEXnXjOLocVuaPySMqbz0wbbOr2xyjZ5J/8DB4Rwp79Jfh
 e0Ikzp2BrXwlyqYF8GFMPwk63E+ZqW431NHs32Fk3kiOia5NEYzCZWEAuBNchHXiGaJs
 4e6g==
X-Gm-Message-State: AFq9FYJbkgOoL2XHuWsXWuAtrNkkGHfnmYAtyF5uFPw+rCpboMLiEaXy
 T+zZe9bNIrRlesanV98/kDIcJNYd7q/q5kH+D3J0wAw46BENOaFkJEJA/yA3059VrlckSELb+3f
 fzZ30MZ8/1Sw2b58SC2F7dhE2khMUgdh6ywRRPnOJsoleKjlbWYZ/h4rLAS+RQ5YIeelKT1wbV2
 MaCfR3HB5JzrniyTkEV+B+D8iw064=
X-Gm-Gg: AYBFou0G0CfIsAK0+tcpBGMt5iRAAikkJj20yFC8IcjcCW4h6r63d05a7NEpVBh17OS
 2NCpp+uIQKE6Uid6P1l+bUE3aEFHAFJFhysAHmZqT5GfTm1OrDEwbBwgfGrOf8uwxN+7u9Kdo0Z
 GehxJ9Pz9J7gO9MCLCZTktNlYtDeWf+lxYlle3hi8dqZ0xgvZqe4f68SioIL9xogRkxBLcspgC1
 nbWaS3PI8SRzzsEWKPldVzhK4dIMLM3CIk4iqea0IrQkP4a
X-Received: by 2002:a2e:a54c:0:b0:3a9:d937:7540 with SMTP id
 38308e7fff4ca-3a9d9377b24mr35935041fa.9.1792061856353; 
 Thu, 15 Oct 2026 03:57:36 -0700 (PDT)
X-Received: by 2002:a2e:a54c:0:b0:3a9:d937:7540 with SMTP id
 38308e7fff4ca-3a9d9377b24mr35934911fa.9.1792061855895; Thu, 15 Oct 2026
 03:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20261014201627.571496-1-thomas@monjalon.net>
In-Reply-To: <20261014201627.571496-1-thomas@monjalon.net>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 15 Oct 2026 12:57:24 +0200
X-Gm-Features: AclHuK_pW-19Y1IfLALWHe26xXXfEUc8KgxOOZ1Fz5F0l7dUGWxZyHaeOZkvEaE
Message-ID: <CAJFAV8wUXX-+Su8VLjuLPqR2YH3qm=UggfQ6vfoTs-qPp6=GQQ@mail.gmail.com>
Subject: Re: [PATCH] eal: enforce internal API check with Clang
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, stable@dpdk.org, 
 Bruce Richardson <bruce.richardson@intel.com>, "Burakov,
 Anatoly" <anatoly.burakov@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9obMIxoKXi7jj0IoatOPVefYtgP3s4Hm6HrIK5jtaYw_1792061856
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

On Wed, 14 Oct 2026 at 22:16, Thomas Monjalon <thomas@monjalon.net> wrote:
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

What a mess this header has become :-).

I have a little cleanup to propose, and this patch actually does not
pass the chkinc test with recent clang now, as it raises warnings that
were not seen so far.
I'll post a v2, as we discussed offlist.


-- 
David Marchand

