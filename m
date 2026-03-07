Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56968F55102
	for <dpdk-dev@archiver.kernel.org>; Sat,  7 Mar 2026 20:59:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D91F40041;
	Sat,  7 Mar 2026 21:59:56 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C958A4003C
 for <dev@dpdk.org>; Sat,  7 Mar 2026 21:59:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772917194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sRfcqYm+0EC9AtHwOX168wSAUaX9++7amwLc8J0MPhk=;
 b=L3s5fRWId01gsdUsq9uAsamQ1cNgNAjuhYVQstornXa9Y4bWy5H4W95AmoawCHrQV7byhf
 WQB9fXm81uVWIDkH2ou0ZtYkY2aq19qJoqXJxD3heOv+Y9XX12lILVsAbrAXF1wtCUv4Jg
 sEE7/X1dXWbI7D/JgWwdRErK+PyA3gM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-0NvVBo8qNbqOX-Gya9lNxw-1; Sat, 07 Mar 2026 15:59:50 -0500
X-MC-Unique: 0NvVBo8qNbqOX-Gya9lNxw-1
X-Mimecast-MFC-AGG-ID: 0NvVBo8qNbqOX-Gya9lNxw_1772917190
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-485335f4466so2860485e9.0
 for <dev@dpdk.org>; Sat, 07 Mar 2026 12:59:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772917189; x=1773521989;
 h=in-reply-to:references:user-agent:subject:to:from:cc:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sRfcqYm+0EC9AtHwOX168wSAUaX9++7amwLc8J0MPhk=;
 b=lN7MKGelDJswMtTv7RGfG1sORSMhzrLvE7pfG+dHkCaXUsjCg27a8BpEMcnP93rT3L
 rRJ923ZxjL0S16tou7pd25eVSToKNyR2YJAHvXTqPRiHzLI5NoxTnTaedtBbsDKegbDj
 9Zotx/YGRlugix1IDpdCBNekVMtYPkV/4daPZb/mGau1fTv95v47q7LHiJmWKITDGoez
 w/f198jdmScrd5OfJOTejDIomcyV+WTNJwApV73muYSiMfn+puSsn7w4GxBL9t7i9Z0W
 +XCGx0nBhQAUVat0gPm3OGXGdONnOOQIFFXFUEpdqITP3zaRnLD3MqkQ9VvzdwDq1qAM
 cBaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWREMrQ/xgvb9vi/HKIbG3gXFUR5bEiJYcEPN3rUsCSFD2srQLCsV9PnMA2pvB+CmiPry8=@dpdk.org
X-Gm-Message-State: AOJu0Yz9aPx3asuWu/cm11nkbANWFQAqXOXsiFFGE7RGP1pIfRW5cGGY
 6v/9FXkCMCvtzW84Ez38ztJIqpmU5LqKyQyj+SW275dqsKted8nfXop/G67OexAQcagPRbncOHL
 Nny3wvZW+l4345AZmyiMZsz3P6AppK4joNLY45M2C3bgH
X-Gm-Gg: ATEYQzyhEYhd1HNbBl60aX4BlFxjucZZNygxo0WGGn+5PsH2Lu39UhNdZoth7/O+2xI
 wsjaedciMXP1Wgl5Xtu6YeimNGmDvYEaETrSLQ7PEGsBf1G622y+0zv8aT9kxzTTfAfPzr5MEiU
 vZARzx75VmtgS8OoDepSTczvYi/KTpQj2iC6oVUPFEiWlgldKLYlMq/wlhFTrBg3hvOU5D3jIZC
 m56aydJwFWFwwytczV4G6RVqb9foKPVAuJsiHkFAgwqecyrBcrg/4PoYEdbyVdjah7kDx8cHP8/
 aSsEKEk4TY4FHumvUOHQ2p4piRu9d0wyI4iLS3Oiy5lngIO55fRM/CwweFlzXLiXhPlbPR9YNOQ
 VaBChemGpfO/bYx7ueftu8q4PmLroz3MAcOUT+LKTu0LyfdZ9UKs3PdZN9URJtEwR68MCdHkUbq
 tlF6vD
X-Received: by 2002:a05:600c:a4a:b0:480:690e:f14a with SMTP id
 5b1f17b1804b1-4852691e00dmr107640645e9.14.1772917189486; 
 Sat, 07 Mar 2026 12:59:49 -0800 (PST)
X-Received: by 2002:a05:600c:a4a:b0:480:690e:f14a with SMTP id
 5b1f17b1804b1-4852691e00dmr107640295e9.14.1772917189030; 
 Sat, 07 Mar 2026 12:59:49 -0800 (PST)
Received: from localhost (2a01cb00021ec0002fb5ec50e5a775d4.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2fb5:ec50:e5a7:75d4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485276b7547sm139266755e9.12.2026.03.07.12.59.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Mar 2026 12:59:48 -0800 (PST)
Mime-Version: 1.0
Date: Sat, 07 Mar 2026 21:59:47 +0100
Message-Id: <DGWUOW64VR9C.YZEVR1BGK38T@redhat.com>
Cc: "Parav Pandit" <parav@nvidia.com>, "Xueming Li" <xuemingl@nvidia.com>,
 "Nipun Gupta" <nipun.gupta@amd.com>, "Nikhil Agarwal"
 <nikhil.agarwal@amd.com>, "Hemant Agrawal" <hemant.agrawal@nxp.com>,
 "Sachin Saxena" <sachin.saxena@nxp.com>, "Chenbo Xia" <chenbox@nvidia.com>,
 "Tomasz Duszynski" <tduszynski@marvell.com>, "Chengwen Feng"
 <fengchengwen@huawei.com>, "Long Li" <longli@microsoft.com>, "Wei Hu"
 <weh@microsoft.com>, "Bruce Richardson" <bruce.richardson@intel.com>,
 "Kevin Laatz" <kevin.laatz@intel.com>
From: "Robin Jarry" <rjarry@redhat.com>
To: "David Marchand" <david.marchand@redhat.com>, <dev@dpdk.org>
Subject: Re: [RFC v3 6/7] bus: factorize device selection
User-Agent: aerc/0.21.0-127-g39acbf663345
References: <20260225112922.3982104-1-david.marchand@redhat.com>
 <20260305164550.2067453-1-david.marchand@redhat.com>
 <20260305164550.2067453-7-david.marchand@redhat.com>
In-Reply-To: <20260305164550.2067453-7-david.marchand@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4veHm_H1gMNmjXmVRq6jwy-1yS1uwxW5Zv0ioifFT00_1772917190
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

David Marchand, Mar 05, 2026 at 17:45:
> All buses (thankfully) implement the same logic when it comes to
> selecting the devices to probe based on -a/-b options.
> As we want to adjust how devices are selected, provide a common helper
> in EAL and use it in the buses.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> Changes since RFC v2:
> - changed API to query about a device name and hide the devargs meaning
>   in the common code,

Nice cleanup.

Reviewed-by: Robin Jarry <rjarry@redhat.com>

