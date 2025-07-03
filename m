Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38998C77B7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 08:42:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47584402A0;
	Thu,  3 Jul 2025 10:42:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id DD4FB40285
 for <dev@dpdk.org>; Thu,  3 Jul 2025 10:42:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751532161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vc5dTvKlTbYl/J6XUneOFjaYmVVGUAX9floNyc8vnJ4=;
 b=ajfSoOqq5TV9jC6U5IQLZtPhtLM6E+N+YB8a4PU4z/w+XdB+d7RtK2OoAiDtOobFS1uMSI
 wjgZWb68PxHVNMM/FGAH5cgitZE+AnczjTJkDyupWdI5VQ8tg3xZ+6Cp9nrv1BxArdnLgV
 iXZlEfuUYvK/ocy5AWStJCoeQ73DjqY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-34-eOso_OnGbI8PZT90M7g-1; Thu, 03 Jul 2025 04:42:40 -0400
X-MC-Unique: 34-eOso_OnGbI8PZT90M7g-1
X-Mimecast-MFC-AGG-ID: 34-eOso_OnGbI8PZT90M7g_1751532159
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-550d7bd9a7fso3687667e87.2
 for <dev@dpdk.org>; Thu, 03 Jul 2025 01:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751532158; x=1752136958;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vc5dTvKlTbYl/J6XUneOFjaYmVVGUAX9floNyc8vnJ4=;
 b=eI3OJYhf930EvYjMnPFoStQSOp8oq76nEak62T10oHuwGyDR9vpIfNyfPaQ519lNos
 EGZvhKU8/Oee++SkITsU4jByhV6pyYLWf7hm3Pt6BLjqB6UQd05HxV++CLQC6OidBNvV
 jOlm2/JjYLF+YSTLmyRAQRgT/0+7/PqUNQoM0IcZ4vVRCzmPMXFw70AY+deixr+DNed9
 tLm0N5m3Rx0fwOpC1wG1F+JXTJnjMcwqVUQE9I2bFv8Et783VjSomV7eVNS+BuFTkTAp
 N+jWzEe0iqySP3poccaS57DDcjMG3z8cARatpCcX8xnpDGdFZU7UNkXdP+HqS93N2tYP
 AbRw==
X-Gm-Message-State: AOJu0Yw9Ta5C3E7WY2yzCkvEsK1sYlacF6sqgCYSRVXu1Tj1xFvq3wZb
 lSy3TulFhJAVcBpfMhBLAXH8Tg+1ILzR4pvJRlZC1BhZk7h93y8nnfKIRx2uXyl8Lmm0H6Q9Nhc
 0aPeiHiblbEs1YBUPGGzY68IrRDdH+7/p0uIOV1d3R5C22Au5jaE+dIba562yHe4ucoKkJI092s
 xJlIA6mzaikkd1tAN8W9E=
X-Gm-Gg: ASbGncvysMyRtdqKwRfMpM99G1frXB580mLiWVRuCNmIP2P1QiV1xbK6o9VAsab+4XE
 Ht8l6a0MWHWz7Z5yAjMMET9DL2d/mLMj17DPGkfR9zNqyIPEzOD2GwIaRPolCLUxOPxq9AWoLKh
 cdDEJ4dg==
X-Received: by 2002:a05:6512:138d:b0:553:ccef:e303 with SMTP id
 2adb3069b0e04-556282fcb62mr2486959e87.22.1751532158412; 
 Thu, 03 Jul 2025 01:42:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhlMCc172mgOAckWtn2gaMG27GlgO8DWEweManPnCCJgIcIHySdoNbo2eyTmCQ36d3Oa054YLLUH5HaGRpuSY=
X-Received: by 2002:a05:6512:138d:b0:553:ccef:e303 with SMTP id
 2adb3069b0e04-556282fcb62mr2486946e87.22.1751532157938; Thu, 03 Jul 2025
 01:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250624134139.552315-1-bruce.richardson@intel.com>
 <20250630153752.2361112-1-bruce.richardson@intel.com>
 <CAJFAV8yixOQ-GFn9FZoheQzfwXh5c=zCms6wvRdZwHqZctTJ=w@mail.gmail.com>
In-Reply-To: <CAJFAV8yixOQ-GFn9FZoheQzfwXh5c=zCms6wvRdZwHqZctTJ=w@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 3 Jul 2025 10:42:25 +0200
X-Gm-Features: Ac12FXzXwRA2aOt3O-eOnrygrxXeDMIWKi7hNPvKGtJRAJCjGCA2BXxfNWRbROs
Message-ID: <CAJFAV8x_X2FKYBuRhpPCbhghh=9V2sXk7QwcLmnRcM=GMMmVzg@mail.gmail.com>
Subject: Re: [PATCH v2] eal: deprecate old coremask-based EAL parameters
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, thomas@monjalon.net, techboard@dpdk.org, 
 Vipin Varghese <vipin.varghese@amd.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, 
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s5-yEli66TGL1b1syl6Ly7zbKK361KzhWJjnYWepcrY_1751532159
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Jul 1, 2025 at 9:56=E2=80=AFAM David Marchand <david.marchand@redha=
t.com> wrote:
>
> On Mon, Jun 30, 2025 at 5:38=E2=80=AFPM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > As the number of cores/cpus on platforms has increased over the years,
> > the use of coremasks rather than core-lists for identifying DPDK cores
> > has become more and more unwieldy. At this point, let's deprecate the
> > coremask-based EAL parameters for future removal, and point users to th=
e
> > core-list based versions instead.
> >
> > Depends-on: series-35540 ("use core lists not masks in documentation")
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > Acked-by: Vipin Varghese <vipin.varghese@amd.com>
> > Acked-By: Anatoly Burakov <anatoly.burakov@intel.com>
> > Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
>
> Acked-by: David Marchand <david.marchand@redhat.com>

I realised the test-null.sh script needs tweaking.
I'll squash this:

diff --git a/devtools/test-null.sh b/devtools/test-null.sh
index 6cd34f64f1..e3ac168ce3 100755
--- a/devtools/test-null.sh
+++ b/devtools/test-null.sh
@@ -7,7 +7,7 @@

 build=3D${1:-build} # first argument can be the build directory
 testpmd=3D$1 # or first argument can be the testpmd path
-coremask=3D${2:-3} # default using cores 0 and 1
+corelist=3D${2:-0-1} # default using cores 0 and 1
 eal_options=3D$3
 testpmd_options=3D$4

@@ -28,6 +28,6 @@ fi

 (sleep 1 && echo stop) |
 # testpmd only needs 20M, make it x2 (default number of cores) for NUMA sy=
stems
-$testpmd -c $coremask --no-huge -m 40 \
+$testpmd -l $corelist --no-huge -m 40 \
        $libs -a 0:0.0 --vdev net_null1 --vdev net_null2 $eal_options -- \
        --no-mlockall --total-num-mbufs=3D2048 $testpmd_options -ia


--=20
David Marchand

