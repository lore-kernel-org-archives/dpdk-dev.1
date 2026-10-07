Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24397CA6009
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 08:26:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EADBF427CD;
	Wed,  7 Oct 2026 10:26:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0D69641157
 for <dev@dpdk.org>; Wed,  7 Oct 2026 10:26:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791361603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vyXkkMaRG6uvMOZ8ItK3gdo1u6PPyr83mcZbSC9wWWI=;
 b=bzDVFj31FXpPTrjK5MorP76N8+ZjrRjr6eK1W2xc1yINWTtdOgPiWVMdPO1HBThQYJ8Tcy
 U2QLtjOf/V4XXgBer4rWn2aWO1Z4aVHfVxLD2VahiHbsvsocARXaxfM3NmxaWC/jkWZ3u+
 C9c7pkPKEEMHnuab/GFHsoaOOnh00ho=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-EEli4M05NVaQ-wjJ0whoXw-1; Wed, 07 Oct 2026 04:26:40 -0400
X-MC-Unique: EEli4M05NVaQ-wjJ0whoXw-1
X-Mimecast-MFC-AGG-ID: EEli4M05NVaQ-wjJ0whoXw_1791361599
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3a781d7cc95so17524601fa.2
 for <dev@dpdk.org>; Wed, 07 Oct 2026 01:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791361598; x=1791966398;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vyXkkMaRG6uvMOZ8ItK3gdo1u6PPyr83mcZbSC9wWWI=;
 b=JtcivIU1SacHvV45ikmnRtnYebq7dXR2hLZcFu7XWQVXcLOYJaWU+HU6MZsDpPStUg
 x6N25ZI8X4JSluARTZ+KG++MwU9MpA0CofUinudq6evnOxvhNT01Ld2Nvmo1XAsa0D3n
 j+qAz5ibbX/mdyxwDEOlZE/vBjKm8VkOuZaOdUmDET2ZcwRnPaMwGTfzDSMnIBQVfrqY
 mqqrWcvdI7falWD7baksay2u4vOmiS2oaxdQ99d99eDqjo7ttI1lPyRBlkBjpy4j6T6J
 Y0COvJt7x1HSosrxPCs/X6o8yY1fn47rmYyLnEI2Cr5H3lnAF3zIOMelT9AyV41idZJ8
 h/+Q==
X-Gm-Message-State: AFq9FYJUUBDvkyzZPNnEn/0yCpXiH5d1gQi3XzPezco/VPADdVwDCLed
 ch1/JYcH0Yx+YV6QxT6Rnm8BCxyDTEX4A9jAU00a055+s2qKXhOgQg1X8r+1EysRchUczEGthX/
 kPRVaCoY9byNvpNOJCy37wddKwvyA/M7rQhO30h7wGAHqbQUPLxxNoGBlPHzxru6wFGkaWk4nE1
 QrgQt996sVXhB7k8H9+xM=
X-Gm-Gg: AYBFou3jx1/9hba9O5sYTr/ytaUBZp2t2970LXQn7rH2uhc8Nb0jdwDZb8fcjQKvsXO
 HkLP0wrQ8qCZ/uZ88jXeS9AvpjDG3w8HMt2S09TmY64pS6OJUvIyJbHPffGrArLG7L9pyiP7tTx
 GZ5+JmakzwC/fJDy0EApyyrhT28u9yb3ciEsAfX+RiWBkzMjFVlEiJnmyDYbq3wVNdly1V3UOGX
 9mQCbWS2lvs+g4xCNpYTV4htVwKBjcd3yHDAbCOCNfek57P
X-Received: by 2002:a05:651c:2115:b0:3a9:7b36:5886 with SMTP id
 38308e7fff4ca-3a9a2cd532emr3412021fa.7.1791361598504; 
 Wed, 07 Oct 2026 01:26:38 -0700 (PDT)
X-Received: by 2002:a05:651c:2115:b0:3a9:7b36:5886 with SMTP id
 38308e7fff4ca-3a9a2cd532emr3411911fa.7.1791361597937; Wed, 07 Oct 2026
 01:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20261006233144.644562-2-stephen@networkplumber.org>
 <asX8y0Nv8APsp8ct@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <asX8y0Nv8APsp8ct@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 7 Oct 2026 10:26:25 +0200
X-Gm-Features: AclHuK-ujEUMrt8gYPc_OclUsv3Xadug0AExEA2vWUPYxt1SnQqS9rQZXV9_YJI
Message-ID: <CAJFAV8zXbAnH-Ur1pv-1JiRKOX17MJjZLDQ9ySto_yGQz2zfJw@mail.gmail.com>
Subject: Re: [PATCH] metrics: remove experimental telemetry helper API
To: Bruce Richardson <bruce.richardson@intel.com>, 
 Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5YP6DHYPRZuR9bjvAZtjip3PBr0q6fA9umvvVoV5M04_1791361599
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

On Wed, 7 Oct 2026 at 10:04, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Tue, Oct 06, 2026 at 04:31:44PM -0700, Stephen Hemminger wrote:
> > While investigating experimental functions leftover in DPDK.
> >
> > The rte_metrics_tel_* functions are dead code. Nothing in the tree
> > calls them from outside the metrics library itself; they were left
> > exported by the telemetry library rewrite in 20.05.

Indeed, this patch is a continuation of 07c1b6925b65 ("telemetry:
invert dependency on metrics library").

> >
> > Stop exporting them. Delete the header, move the types into the C file
> > and make the helpers static. The file now only builds when jansson is
> > present, so the stub branch goes away too.
> >
> > The legacy commands ports_all_stat_values, global_stat_values and
> > ports_stats_values_by_name are unchanged.
> >
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> >  doc/guides/rel_notes/release_26_11.rst |   9 +++
> >  lib/metrics/meson.build                |   6 +-
> >  lib/metrics/rte_metrics_telemetry.c    | 106 ++++++-------------------
> >  lib/metrics/rte_metrics_telemetry.h    |  71 -----------------
> >  4 files changed, 39 insertions(+), 153 deletions(-)
> >  delete mode 100644 lib/metrics/rte_metrics_telemetry.h

This cleanup lgtm, I'll do some checks but it seems mergeable as is.


> In the process, should we post a deprecation notice for the whole
> metrics-based legacy telemetry system? It's been superceded for many years
> now and it has a lot of limitations: supporting ethdev only, having
> globally registered stats (so if you have two different NIC types, you get
> a list of all stats names for both whatever port you query), and probably
> more beside. That would allow us to remove a large enough chunk of code in
> a future release.

+1


-- 
David Marchand

