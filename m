Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF26CC6B39
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 16:16:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0ADA402DF;
	Thu, 15 Oct 2026 18:16:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 610A3402E4
 for <dev@dpdk.org>; Thu, 15 Oct 2026 18:15:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792080958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=alec1+QnI4X/OMw7eWa8LCg/u7v9NpPwtBLNS9rlEoM=;
 b=Z1UAq5lH51g7Azi/86OrxFr3jtKpbrGHuOzelkbnRCIUQJRNj6eALwqHPNgSv0euqP0g7P
 pD7oIq9bjcwF/y2l/+TjEeXUfQYal4cf8qXP1rYN6ZlNSk0NqkTaIYgcBB6YZ6ctFLF/yU
 xJLuCqAWg66b1NkcJv4Ce0ha3Xd4/I8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-WsKCTL1uNOe9pFS2S_ddCw-1; Thu, 15 Oct 2026 16:15:55 +0000
X-MC-Unique: WsKCTL1uNOe9pFS2S_ddCw-1
X-Mimecast-MFC-AGG-ID: WsKCTL1uNOe9pFS2S_ddCw_1792080954
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5be3d12d10fso777086e87.3
 for <dev@dpdk.org>; Thu, 15 Oct 2026 09:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792080953; x=1792685753;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=alec1+QnI4X/OMw7eWa8LCg/u7v9NpPwtBLNS9rlEoM=;
 b=01Wq0LOHoazbyq283BqM32hK7M+Ga372nxCqNoAKivMoZt4ohmEOWxZKMRxoeGRXSQ
 qlGsyPtcV00xgGjnnpXCORGjTix86QtHkAXmJYnjWKSYebCVFdn3NnnPN+7jMdUy2QZ2
 0BPCjJqPUxBUPHW65TZumzatd8uAJU6tA1PDXuFIWMKGwhXVbm3EYWi+V1LmOKTewEHw
 qfcReSMbjDtdg+UDx3P2usuA9hBMQWjgdtiqLdL0KUzJE6+0hFol692Pyf0sO0dVVQER
 XY7gg9+aQ+4kg/vswQstaNcoDLCrN5rqeGvNl99iYCcbtDGztw0lKiGY0SR3x69oxZ/q
 Dwxw==
X-Gm-Message-State: AFq9FYJQdQ6bdPP4RWGmoVfM5qzubVdX0a/8UU2Hzptx+/YG5ToBjpTM
 3fgHWiND3BPbg3B46G8zaHrhgXucMctIdsv3u6YiY/9NECdisBHIVooI7RCSOXr2hZ5h4VpElZu
 ccmfo9K3daoFScaBhXgkvlFZZnFWW9pZKfdxgTm+8XgYLDbF9JwHgICkUSUcoBQgjL2xdNSjQe2
 8a9kDuxtQ33U3MuEmz5kE=
X-Gm-Gg: AYBFou1d//+F1kCpwdEmHHUMTHVEhWxjHnUDQO/aZjPUz3K6xNMsGJ2UZuwCOWI1ALx
 KTKUw/2TDVcmaKIolVRaPF/nUiTJGrBcML857bvfTZIMMijunQD3wNxWqEoOZupkMKfLERQvBoa
 PPBVba2YDSDjA1QxaH0cxoVNY2uuv8QGbO3//qVGkJrUnjHUCTGhu9fT/VrN//tE7dvyC13CMMu
 2S4d6k27QukW8+bJDXJY4r0vyap+yoTGbHozLXcZBryvglW
X-Received: by 2002:a05:6512:318e:b0:5be:4323:3cf5 with SMTP id
 2adb3069b0e04-5be43233e06mr612385e87.26.1792080953559; 
 Thu, 15 Oct 2026 09:15:53 -0700 (PDT)
X-Received: by 2002:a05:6512:318e:b0:5be:4323:3cf5 with SMTP id
 2adb3069b0e04-5be43233e06mr612372e87.26.1792080953114; Thu, 15 Oct 2026
 09:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <ee502d37f54dbb6ea8ae4473e684eeb0f500db1d.1792079025.git.anatoly.burakov@intel.com>
In-Reply-To: <ee502d37f54dbb6ea8ae4473e684eeb0f500db1d.1792079025.git.anatoly.burakov@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 15 Oct 2026 18:15:41 +0200
X-Gm-Features: AclHuK-aaTOaWbyObyWOKhYlCv9lpTtAj1_aiaLncrpSRlxxb90ZcZYz_dzEcNo
Message-ID: <CAJFAV8wubWQvcN7wArMbVZ5yxu8iLEMiUUQwWzGmCqyAVDk6Mg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] vfio: fix device lookup with no-IOMMU mode enabled
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, abailey@iol.unh.edu,
 dladd@iol.unh.edu
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SGD1GV7HyljpE-jAfzx4SpF17MuMmNWx-jK3L3aVfvc_1792080954
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

On Thu, 15 Oct 2026 at 17:44, Anatoly Burakov <anatoly.burakov@intel.com> wrote:
>
> Currently, when the `enable_unsafe_noiommu_mode` VFIO module parameter is
> set, VFIO selects PA IOVA mode and then only looks for no-IOMMU device
> nodes: `/dev/vfio/noiommu-N` in group mode, and `noiommu-vfioN` in cdev
> mode.
>
> However, the parameter does not make every VFIO device a no-IOMMU
> device. The kernel only creates a no-IOMMU group for a device that has no
> IOMMU group of its own; devices behind a real IOMMU still get a regular
> `/dev/vfio/N` group and `vfioN` cdev. On such systems, devices bound
> to `vfio-pci` are therefore reported as not managed by VFIO and fail
> to probe.
>
> Fix it by trying the regular node name first and falling back to the
> no-IOMMU one, in both group and cdev modes.
>
> Fixes: 6cb38a7f56e0 ("vfio: introduce VFIO mode")
> Fixes: d129414711aa ("vfio: introduce cdev mode")
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>

Acked-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

