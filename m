Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E33CD8CA4
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 08:52:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06E544065F;
	Tue,  9 Jun 2026 10:52:57 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5E91F4065F
 for <dev@dpdk.org>; Tue,  9 Jun 2026 10:52:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780995174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RXEqFL+nYsAWpxTqc07lHVb4wfRCYzZlOe4DPMjlcZY=;
 b=TO5oMBzhqcx01ATyXr4N1BEQEd3zNaWNyw8UOPGSKnKfY5G/hwa2qc9Rt3EJFrjodMEBKU
 MfxG785RmLqHhbomh2SN9bVylwWgweiQxT1s8vb8lSkZ0uKpsrxXiTyqUbizV7BJktQxQK
 Qj44/i+5tsdaMj074Rhfbrv0yhCjaw8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-_mNwrvyjOZCepD2pWx_BOQ-1; Tue, 09 Jun 2026 04:52:53 -0400
X-MC-Unique: _mNwrvyjOZCepD2pWx_BOQ-1
X-Mimecast-MFC-AGG-ID: _mNwrvyjOZCepD2pWx_BOQ_1780995172
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5aa5bfe8497so4695454e87.1
 for <dev@dpdk.org>; Tue, 09 Jun 2026 01:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780995171; x=1781599971;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RXEqFL+nYsAWpxTqc07lHVb4wfRCYzZlOe4DPMjlcZY=;
 b=RJ5D/Q9Q2IRYMOn79tkI6kdW3ML6gOMevtwxwE60Lndaxj+RlkCF0MtyZyu3rzQ7Ih
 ZPkb/ugos/uvwEximP33ckA2DIByE/khqWSOPvCu5NCMYhzoFfEX2697tPcJEEwJxaWC
 8jVGm0VzH4OIzw//ldK8E8ru+Qa6hfGaFkf2FgZNw2aLP/e9b16El4C58elrDOV+p0FM
 9K/Np7bpmIqGGXbFbqArSso88b1Q/EF3RGdAFOmQWFMARXOD7nXs4eisoKFABptJHfrF
 Y4C6wdVW3+iMjxzS2zP6xZ8rLW0ZjR7uE/lyG2AhH3t6ZfwfqZm4A8OaT59C9aqi5Rmt
 XbMQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8JMurwYDyWe9IucGAM4wwZDSKt0+e2h80RAh/uKqRlfpM2wtIdsqnP20/OLn2x8pxV7Fc=@dpdk.org
X-Gm-Message-State: AOJu0Yy/TMVGyRjncm0XXacqDZWxiZAYM5sKGo7xUrwquB6bfYblL/CZ
 LBQnBYdj8nB6zzFyOshGQpG1D0VhwZfI9ELT0BQeYQkG/SvEOBlemug07hi1339GBriaIlu0/vP
 VDd4gM27f5D3Uk7Gb1by7MqxS2rlaoyTAC1rZIDGmvuuCqF3mcEm6/d1tuua4hfm29b5zX/hWtK
 jBxd/ASpzaFD+9E2Iena0=
X-Gm-Gg: Acq92OG7nPF7vuj/18SB92odL8ZwqL4iNYlonvpQkE58gN8EVm7Moe3vov/7e0S5ZxO
 k78a4oEAby5IhbJVPKKV2HgGctTCDiLNBsi3XmHI3RDJbJ/69CAeb/rltP9/3PoG1LmCVUogwfF
 8HL2oLCJ05HvyuryYS49wMFTN6bbWXnpMRN8gChaenJ5QkhVxSn3eFT5gfR7G6bclmxvq3EfO0v
 rZcE5+2B6+fs4aY3c9WXf23k+rmpy/AnsymTkCbVPlnZfEDYirgyWhsSjgsVGpY6sjagS9kbSAm
 fcuK
X-Received: by 2002:a05:6512:b90:b0:5ad:a25:b8a3 with SMTP id
 2adb3069b0e04-5ad0a25b90emr320361e87.29.1780995171353; 
 Tue, 09 Jun 2026 01:52:51 -0700 (PDT)
X-Received: by 2002:a05:6512:b90:b0:5ad:a25:b8a3 with SMTP id
 2adb3069b0e04-5ad0a25b90emr320349e87.29.1780995170896; Tue, 09 Jun 2026
 01:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260513235518.408895-1-andremue@linux.microsoft.com>
In-Reply-To: <20260513235518.408895-1-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 9 Jun 2026 10:52:37 +0200
X-Gm-Features: AVVi8CcY6d5KRovvownt5vBV_q6wG4Lr90ZP95EBAMd2nbaTVeGnnILtuqQ8gSE
Message-ID: <CAJFAV8y+eCrK4O9pigs59x3YT3UyJR-o0FsOxxbpJO69Q=L+hg@mail.gmail.com>
Subject: Re: [PATCH] Windows: fix core count on NUMA with more than 64 cores
 per node
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>, dev@dpdk.org, 
 Gena Tertychnyi <genter@microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9Kjslz1fYk4XKQQpmH7iM7oxyq9osjpO4Xk98l3GL-o_1780995172
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

On Thu, 14 May 2026 at 01:56, Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> From: Gena Tertychnyi <genter@microsoft.com>
>
> Fix specific to Windows NUMA machines with more than 64 cores per node
> (e.g. 2 NUMAs with 128 cores each):
>
> - NumaNode.GroupMasks[] array is used instead of NumaNode.GroupMask.
> - RelationAll is used instead of RelationNumaNode when calling
> GetLogicalProcessorInformationEx because RelationAll returns the full
> multi-group NUMA affinity as RelationNumaNode returns only the NUMA
> node's primary group.
>
> Signed-off-by: Gena Tertychnyi <genter@microsoft.com>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

Applied with Dmitry suggestion on the Fixes: tag.
Thanks.


-- 
David Marchand

