Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB913C982CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 06:51:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC0FA400D6;
	Thu, 17 Sep 2026 08:51:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id BE36F400D5
 for <dev@dpdk.org>; Thu, 17 Sep 2026 08:51:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789627904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W+gjqi2J2Pzo64cYpeb/7bz0+Z9BN6NOeu7g6Mm6s18=;
 b=dgX+f84IrA3oQLUqzVqmK5v1a9Qc+VJLi3yxOCA8G1WcShIAMe6xJMtYicj/56rwQhl+yj
 9Y1f2sXhSjyPTA4thBUne9eAbHx9iMw4f2LkT/ohfujfrr/RM2lGSSSqpszlDQGTNMy1gP
 pkcqac4p2kvvs+1mJoVkEdRj8LHUj5Y=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-62tahXqiP1K0sBMhkxtMzw-1; Thu, 17 Sep 2026 02:51:42 -0400
X-MC-Unique: 62tahXqiP1K0sBMhkxtMzw-1
X-Mimecast-MFC-AGG-ID: 62tahXqiP1K0sBMhkxtMzw_1789627901
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5b14d51dae1so179157e87.3
 for <dev@dpdk.org>; Wed, 16 Sep 2026 23:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789627901; x=1790232701;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=W+gjqi2J2Pzo64cYpeb/7bz0+Z9BN6NOeu7g6Mm6s18=;
 b=ElqqTrT7xcH/X9BJdLj2twoxTQKDdJ04GdBp5ReLRr1wj1Ay8s/CVgZ1O5EmIzjwwH
 VAXvC2khb8PyGmpEMhBn22Ci7JUP3O1KZHqBuEwEWyU+agEovP+/RH/1jNmYQ8vEeKNZ
 U5k1PL2UZmwBumZiqhAL40YPLoqyH5LrIlhH5B20EapSWDSGNposriYScIC51+0p3RUL
 0ZrHM2lvP4f0psKXYIqZOIAvvp+YtGuoJfPmakIvjZBZbe9pVHYhdM0QJp8X+wcOAvVR
 nf4jzVh69Lyvk1yTEQgXCKQEkN0PWX40/l/R63O3Z4nxk5aKRYV0Gx9RWjgK1f+CD0Nv
 q0Ew==
X-Forwarded-Encrypted: i=1;
 AKwUvBzIKznqJHRlP/mXeGql575IEzYuZPFj+aLaPIe6gejrRKy7g8+qpg0d+m5y1aRy/Ks7/KY=@dpdk.org
X-Gm-Message-State: AFuF++lGTIUzXbGIgKTxJhumOcWqBkmZjOGIvlXfbX3g7hkDkXoGRDrD
 fOS7eCrcH2/XE0jSUS5otstW5WjCSqOX8j2MCoRXSYMtJiZgMjgJMikKoU1Wmn4huyXzENCM0Yf
 KrwUi0ZfndD8PwLujxJwWKyf91ciQU4RWyHjnKFqeNiMgRFjdFR2Fb9rThNSEuai9+86wcY1NMd
 tp7QaN+HkPXVeaKXbHidY=
X-Gm-Gg: AYBFou0agpU4R4ec23fyYJljAty2XW/M6rzLC0a7L3OAORFgBHaHfmrS9Kh6yV9VEM3
 vkfjXwrRGUYlAl5CVZ51PiSn7mfG5XZUngyevrwPnV/SHAk6oTN9AmMbGvw5kAX6gk6DZSrfAzT
 IFJ5C0Z5mFH2EI3VQ66TEjju40tWZjAMV0znSh+Jd7WWrdwsKT4dIOZ0hXJ8Y5q+MaeDhahX2dd
 uzeP5g8mCHp1Tg4+P3O+mhkOLXw2uASWqz+XRLAaWALQaYK
X-Received: by 2002:a05:6512:138e:b0:5b6:183c:5c99 with SMTP id
 2adb3069b0e04-5b8b66547dcmr1570608e87.55.1789627901156; 
 Wed, 16 Sep 2026 23:51:41 -0700 (PDT)
X-Received: by 2002:a05:6512:138e:b0:5b6:183c:5c99 with SMTP id
 2adb3069b0e04-5b8b66547dcmr1570579e87.55.1789627899641; Wed, 16 Sep 2026
 23:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260915113459.4166621-1-prashant.gupta_3@nxp.com>
 <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
 <20260915120208.4185877-4-prashant.gupta_3@nxp.com>
In-Reply-To: <20260915120208.4185877-4-prashant.gupta_3@nxp.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 17 Sep 2026 08:51:27 +0200
X-Gm-Features: AcwNN1XOJmstXvsxd-s0ZypPc4dfH8tdYVYY0ndAcnrbRalkFKgtvmGQkBnALr8
Message-ID: <CAJFAV8wUBnWdOz7O8=bpt67A+hLKsuAXbhwNUudfa69f+3Z6wA@mail.gmail.com>
Subject: Re: [PATCH v3-S3 03/10] drivers: refresh dpaa2 MC and SoC version info
To: Prashant Gupta <prashant.gupta_3@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Jun Yang <jun.yang@nxp.com>
Cc: stephen@networkplumber.org, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _qZnIHOuPBFMk536m_Acgz7BWUiv8SvrS2dKP6mHiho_1789627901
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

On Tue, 15 Sept 2026 at 14:02, Prashant Gupta <prashant.gupta_3@nxp.com> wrote:
> @@ -102,6 +110,8 @@ struct rte_dpaa2_device {
>         char ep_name[RTE_DEV_NAME_MAX_LEN];
>         struct rte_intr_handle *intr_handle; /**< Interrupt handle */
>         char name[FSLMC_OBJECT_MAX_LEN];    /**< DPAA2 Object name*/
> +       struct rte_dma_dev *dmadev;          /**< DMA device */
> +       const struct rte_fslmc_bus_info *bus_info;
>  };

No dmadev back reference in the bus device object.

Thanks.

-- 
David Marchand

