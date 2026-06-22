Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E3BCDB46F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 12:45:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FBB740150;
	Mon, 22 Jun 2026 14:45:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7EFCA40144
 for <dev@dpdk.org>; Mon, 22 Jun 2026 14:45:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782132315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SpmviMjQRIKoZoNyou/XFHIX4MESHTx+LJrB1Hz+/J4=;
 b=f5jMd9cW6KB2O/+/0jwAYg2fo2ZperyfcvPiFQ+WdhLdOv/sE/1/Uc/7OuQMzYA6uXlQ3/
 9V4JIZ56m8S6IOEwcZfA06pcuSVsyNWUn29uZYyFnGA//YomCeZO1ySTWJ69nw/6MhDeKP
 PtxTFCMIaZWgrXbFtIlwlNCdZpDBudU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-7HTWowkHM02RI_4RsWTCZQ-1; Mon, 22 Jun 2026 08:45:13 -0400
X-MC-Unique: 7HTWowkHM02RI_4RsWTCZQ-1
X-Mimecast-MFC-AGG-ID: 7HTWowkHM02RI_4RsWTCZQ_1782132312
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-396774b3452so15796251fa.3
 for <dev@dpdk.org>; Mon, 22 Jun 2026 05:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782132312; x=1782737112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SpmviMjQRIKoZoNyou/XFHIX4MESHTx+LJrB1Hz+/J4=;
 b=UYgacgxSgGEUV8DjPR60TNoVhYTCZphDLMztA6pwHw1lefm/IM4+h7hlhqSp1TmWkf
 I389HOoEMNI3zOw3GF6JbHiWKgAVeu+Y61bZ1pOrIdboOLGCA6Oc/5Q71XGyBAc4nYCb
 m+gdpsmW89WQD6jSlRsh4t6YIAUV4WJpbQTaGCS1F77IYbQquzBR3J0qAb8fHZ1Vwbt5
 /QbXJJQ+1WtbR/i8pB1lRhQ0K/pcZ0KVFUnaoV5iVX3V8ZuJatRfffPQqO05W60inRzk
 teCCRJKRkaKGKYGraGvNA8AqRitOc2hbSx8ex/FTkX+iFmAsMrToXPrlCMmgxIA/7c+K
 6bgg==
X-Gm-Message-State: AOJu0YxlGz3/PrrBcA6s7vkmmD5VCFBSBQOAY1cjMC2cuVXPz/RRAq8R
 jfcnO2gsWtFkymP0qm7SVhuITZSk8FdP9T6MkYq4l5qdkuh3BNpjpNtO2fJlie8ntxtmneW98KF
 ioDfkcKH2nqVWKKWTCOIQneBauThCHapqaK1XfyHA3W3rWymonygaFf9ddOkAZWNpZI9WAykLiL
 y+nGAxlWFdcupaE5/WYz0=
X-Gm-Gg: AfdE7cm2yKhZwtlWjumZqzBSrCBD2KiQIQsBP2Ta5u618lPVHXNZ1NHABLli7+pMuQX
 Cmu/1Cre1xgrrjYoc9YUNjpb9Zkx7JDr4HNfK/hv8UzQFFyNrudZ/4m9o6/XiBoRg/HnuARsehI
 thzxKcwL0ROT9/oYo9mEs8OcuEqAvV4VTD8Trm+SukmhWM1bTx4jKJr8IeWJLZOG8dCrokySl/r
 DbkfSyN1bUmQ5/XTXAXMNblZ6BQVCm/MaxXw1ThUGEMQ9jz7tDh8cSOTq8=
X-Received: by 2002:a2e:9e94:0:b0:38e:e29c:9dc0 with SMTP id
 38308e7fff4ca-3998a3415fcmr27517361fa.20.1782132311914; 
 Mon, 22 Jun 2026 05:45:11 -0700 (PDT)
X-Received: by 2002:a2e:9e94:0:b0:38e:e29c:9dc0 with SMTP id
 38308e7fff4ca-3998a3415fcmr27517181fa.20.1782132311414; Mon, 22 Jun 2026
 05:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260618152826.490569-1-david.marchand@redhat.com>
 <20260618152826.490569-8-david.marchand@redhat.com>
 <ajkMFMirIOUtpF1-@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <ajkMFMirIOUtpF1-@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 22 Jun 2026 14:44:58 +0200
X-Gm-Features: AVVi8CdG2QTj7KLcM8h5Woa5jlQTlFOIb6QBn2_1vskAPVYRvaOy-nCXfoVPYr4
Message-ID: <CAJFAV8zsQdjvKNRPmeJp_yV_gdswikXnEFBs0VsvEPpxGk8k8A@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] bus: align unplug with device probe
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, thomas@monjalon.net, stephen@networkplumber.org, 
 fengchengwen@huawei.com, longli@microsoft.com, hemant.agrawal@nxp.com, 
 Parav Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>, 
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, 
 Sachin Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@altera.com>, 
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b3sAei4gCc_wp3saUrdbjfK8wYTayzqkx4vlC6E60Oc_1782132312
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

On Mon, 22 Jun 2026 at 12:19, Bruce Richardson
<bruce.richardson@intel.com> wrote:
> Running an AI correctness review reports a potential issue with ifpga bus
> after this patch. Maybe worth a double check.
>
> /Bruce
>
> In ifpga_alloc_afu_dev (called at scan time, before any probe),
> afu_dev->intr_handle is allocated unconditionally.
>
> In the old ifpga_cleanup, the "goto free:" label ran for all devices, so
> intr_handle was freed unconditionally. In the new ifpga_cleanup,
> intr_handle is only freed via ifpga_unplug_device, which is only called
> when rte_dev_is_probed() returns true. For any ifpga device discovered
> during scan but never successfully probed (no matching driver, failed
> probe, blocked devargs), intr_handle is leaked. The fix should free it
> unconditionally in ifpga_cleanup, outside the rte_dev_is_probed block.

My AI friend did not see it and it gets resolved when using the generic helper.
But yes good catch.


-- 
David Marchand

