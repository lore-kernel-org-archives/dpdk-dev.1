Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03DAC624A5
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 08:25:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BED9C4025A;
	Mon, 31 Aug 2026 10:25:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3A945400D5
 for <dev@dpdk.org>; Mon, 31 Aug 2026 10:25:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788164702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JMtcySMpyVlxptxhrEFgOI9oSdjneQq1kX1lSL1HN/w=;
 b=BmqEWK7mSu0Q9OyjQSV8pvTmXA6NKL6WauQjnnHzDL/3XxGRLjLTC45e3M/SDlgHdYdjK1
 bJWn1QuFu5Hd14ll8TBJuWVEkZC1IBtgwFggYiV5qllvRN1cMCCW6n8lkYwthivhfbx8ll
 LEGpMcxcSTu9XNzTPdau65na7pm6xRc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-gl1neQP5NYqT3WuHbdFRnA-1; Mon, 31 Aug 2026 04:25:00 -0400
X-MC-Unique: gl1neQP5NYqT3WuHbdFRnA-1
X-Mimecast-MFC-AGG-ID: gl1neQP5NYqT3WuHbdFRnA_1788164699
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5b293eca8c4so3807901e87.2
 for <dev@dpdk.org>; Mon, 31 Aug 2026 01:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788164698; x=1788769498;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JMtcySMpyVlxptxhrEFgOI9oSdjneQq1kX1lSL1HN/w=;
 b=H6XUPeGV/GIaEVhZsrW6wHfCuztrNdnW82plhX5cAuqDKmpqR/2YYtWNPFNwxWcx3w
 kxMmQX6VkbwCbR7Ffs1NYOtWMMqEkGqbfv2hjijI4uxerychY0/BqTjY8snXBaswbRa5
 bc6U1QvK/yZCJpuXNbuH1vcJ0kukV9kT8W8u+jzZoqOPXXKZgJhXkFEmO/r8Ks+8V0w1
 S0Io/qzNUaL5EFGiB7biMtZyZ16ZSgpMs2YijOZIMF4mppz/Gv3N0LKXvOToQSJL/mMc
 5YyIqNx5bLj89ju4H9Ck7YeBLj6cSS6V+NKumKPDNsIEHtGSpmddn/DkINNH6NCgrcRz
 shqg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwsRQNXmbLfq/ZwYUWMOcVXLsHUMBoKMkGgYfZMeTq3TUdlSlWNXrjDC9M+hdfgcEMaGho=@dpdk.org
X-Gm-Message-State: AFuF++kbQp2VswLwvmrry8udHFc8IJnJPHamqup1xI8WOYI+iOFXHv+i
 JpoaFGJZcPtonpt5pgFH2vWJj55GRFHdjisQMcceRzmzgclH1zP5XtXV2OoJGcLQUFKxvxlFTx0
 tWG+h4ZNqgcSSCmzoWTOisSRMPz4Jn1Na8qgiO9zhN3843fAiQcGDwmu2qRehHcIryA4txfAuv5
 p0ee+gUYWjyNTff6l1Pts=
X-Gm-Gg: AYBFou1FLX8nTWwNZfixIJqVlgY6nP1YmLqh3HQJdTL8Bd8PhcLgqcFK0HMHp3YmUm5
 SnX7wqplXa6cTlsXDvc/VzPhgeubg218JFHu1tStFteXyYdjLqm5xmVEWXhsPibtzRIxt4DdKFO
 wC2nCQTjO/fC+gGufuyF52XvklvnHUqM4ZsButefWaFQsjAd8M6E8T+psUUvOxjV8mqsIiwlpEa
 VPzLoLzRct9imP4ypAA3TelN5WZ5Lx60DeyvlZ7uRozCkXB
X-Received: by 2002:a05:6512:244f:b0:5b4:9d34:eb7a with SMTP id
 2adb3069b0e04-5b5e68ec8ddmr6370175e87.12.1788164698588; 
 Mon, 31 Aug 2026 01:24:58 -0700 (PDT)
X-Received: by 2002:a05:6512:244f:b0:5b4:9d34:eb7a with SMTP id
 2adb3069b0e04-5b5e68ec8ddmr6370163e87.12.1788164698174; Mon, 31 Aug 2026
 01:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260827072854.1015059-1-prashant.gupta_3@nxp.com>
 <CAJFAV8yZBb7mQb+cEyuq_XnbQTaFxntTXz0sUm3NCMYsT0eDDg@mail.gmail.com>
 <0a6a1dff-1bee-49aa-bee3-946e13d80daf@oss.nxp.com>
In-Reply-To: <0a6a1dff-1bee-49aa-bee3-946e13d80daf@oss.nxp.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 31 Aug 2026 10:24:45 +0200
X-Gm-Features: AcwNN1X5x9pm3LZpV5NTkERX-_bk31PsZ2ChOIxTUWZpOc0p9UDQBRZ_C8GNQKM
Message-ID: <CAJFAV8xf7D2VpH31cSiHEwN23AOaLjHTxjpdMJ_GqDuB=NNHDw@mail.gmail.com>
Subject: Re: [PATCH] bus/dpaa: defer bus initialization to probe
To: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
Cc: Prashant Gupta <prashant.gupta_3@nxp.com>, stephen@networkplumber.org, 
 hemant.agrawal@nxp.com, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LTf7OEpudJ4Ggh_Px_5-bFdjnF_8wdkWpns5FB9erDw_1788164699
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

On Thu, 27 Aug 2026 at 18:02, Hemant Agrawal <hemant.agrawal@oss.nxp.com> wrote:
> On 27-08-2026 14:24, David Marchand wrote:
> > On Thu, 27 Aug 2026 at 09:37, Prashant Gupta <prashant.gupta_3@nxp.com> wrote:
> >> In the DPAA bus initialization: it builds the
> >> device list, loads the QMAN/BMAN drivers, registers the platform mbuf
> >> pool ops and populates the PA to VA translation table. All of it needs
> >> the DPDK heap or a memzone for multi process scenarios.
> >>
> >> get_iommu_class() for this bus only checks two sysfs paths, so the
> >> initialization is not needed in scan to report the IOVA mode. Move it
> >> back to probe.
> >>
> >> Fixes: cdefd2e980bd ("drivers/bus: initialize NXP bus specifics in scan")
> >>
> >> Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>
> > While the change looks correct, I don't understand what is being fixed.
> > Could you elaborate on the issue?
> >
> In my brief discussion about this issue, I was told that some of the
> these QMAN/BMAN related initialization should be done using
> shared/Hugepage memory for multi-process sharing;
>
> Hugepages are not available during scan, they become available later.

Ok, makes sense.
Worth rewording the commitlog then.

> Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>


-- 
David Marchand

