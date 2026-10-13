Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE664CC6B03
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 09:30:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC15740272;
	Tue, 13 Oct 2026 11:30:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 962FA400D6
 for <dev@dpdk.org>; Tue, 13 Oct 2026 11:30:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791883818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nft2kpYlBjORH3BBHcQQUCJfNZJlFjqoxv27HI1SnXo=;
 b=QZqVfs9uf2pu9WAPUKXfc+vahtSq7DAkmDXeHAOZObrrVeo0zclTx3NTn5C1AzX87nc4wY
 RDmEXy3yEwTV5U4x5XztxsVpmbthLThxoYcS7Wzn38Hp3o+R1CwXOy/abQQzdIigG333wk
 GgYu4MKi3dOr3q80Cg1svgsfqC7/dnw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-G0oY7xbeN5O8_eE2bxLrxw-1; Tue, 13 Oct 2026 09:30:14 +0000
X-MC-Unique: G0oY7xbeN5O8_eE2bxLrxw-1
X-Mimecast-MFC-AGG-ID: G0oY7xbeN5O8_eE2bxLrxw_1791883813
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3a781525998so13678021fa.0
 for <dev@dpdk.org>; Tue, 13 Oct 2026 02:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791883813; x=1792488613;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nft2kpYlBjORH3BBHcQQUCJfNZJlFjqoxv27HI1SnXo=;
 b=0cRY3g3A8DfFRpZVEzzb5p/BnlmO2fdih3doDiI7eogObsjtsuFPQcBR9keUAVSJl/
 qfRtRywVCz28mZ3GynXj+/uIy3tLd/8srEzWJFy0FMAlIWiA0l8ECwnn2EGREEJW+xjI
 Fi2EDqaO8yvArBEs/dr9G2CVz43q4y5c9E1yQpn23uyuBwuRWZE3FonnTbSnp++bl+j8
 b6n/hgag2LdUCp65KpFKMOu3NWt1rHiqokzslGfBPtF0VK9fHrlDytauaMZzQefIAFW1
 ShLxNbcLhmczEg05sTnjDEwz8feJ6QKRFS4WQxpaRMz+zJTbfb86XYVDwmZ7vdvzFE2y
 vKcg==
X-Gm-Message-State: AFq9FYLZreIWeqiYvVpH2PUhtTuJF2L1ZP3ZvX+u4pXdEgVUBWbKpWsw
 i5G7IePW5VdRJhVzeXTcYg1RE0VH40zb5F0fc+ZOYyhYnm2Vtjoc3tBTZWWaVyWxgiF66H9r5zI
 RFZkltU8hs3Q5bXN24c9lzX9PuEijJRol5N0ZzNRJX5/OxdYHb7zWImdZSqjEM8y1qzgvnxlj34
 X5byFqtB+BroJ9I2whvvs=
X-Gm-Gg: AYBFou3UVRA++VrDMcCmOZ7+dWRt+HzdwsltTf/8y74l2UXqYG/p/7xR9tQnmihViDb
 zZ3MZPoF305/+ZqNW0fB2V2cJhXN31NCA1sWKx7aPryBTQjIL4PSAk8m8Omk6YmHiHbtBdlexUJ
 w5/HR3H8DVkhfAdIHNFP+4Idw/F/AuHgEuAQSMb0QvxWLpQmuSlVjBPlEhyW2DC564rxB5nUzE5
 K/TZm+BVkoHFietoatZKJHU3huaXQWu9HeVUk1CBGZge94f
X-Received: by 2002:a2e:a54c:0:b0:3a6:6f81:1027 with SMTP id
 38308e7fff4ca-3a9c55dcd5emr29037531fa.24.1791883813038; 
 Tue, 13 Oct 2026 02:30:13 -0700 (PDT)
X-Received: by 2002:a2e:a54c:0:b0:3a6:6f81:1027 with SMTP id
 38308e7fff4ca-3a9c55dcd5emr29037481fa.24.1791883812606; Tue, 13 Oct 2026
 02:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20261009114830.3630886-1-david.marchand@redhat.com>
In-Reply-To: <20261009114830.3630886-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 13 Oct 2026 11:29:59 +0200
X-Gm-Features: AclHuK9UKrcOKAi8abWIfKICSNAuQ5Lp3wfJLl0u_KHADvGQIoChEEYjIzCjlgE
Message-ID: <CAJFAV8ynU1x9=1FchFTq8tQtP7XSzDd3G5VUrtSVpfZdXTMMTA@mail.gmail.com>
Subject: Re: [PATCH] drivers/dma: cleanup PCI probing in Intel drivers
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, 
 Kevin Laatz <kevin.laatz@intel.com>, Conor Walsh <conor.walsh@intel.com>, 
 Chengwen Feng <fengchengwen@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rjlu6eTOUnb3qKMp11zuT-ixIiVTtezwMpucLohsKhU_1791883813
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

On Fri, 9 Oct 2026 at 13:48, David Marchand <david.marchand@redhat.com> wrote:
>
> Drivers are not responsible for setting the rte_device driver reference
> since this has been factorized in EAL.
>
> Fixes: f282771a04ef ("bus: factorize driver reference")
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Applied, thanks for the review.


-- 
David Marchand

