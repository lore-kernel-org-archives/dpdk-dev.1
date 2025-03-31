Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36846C3600B
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 14:47:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00EDE40650;
	Mon, 31 Mar 2025 16:47:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C4648402DF
 for <dev@dpdk.org>; Mon, 31 Mar 2025 16:47:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743432422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HGPra5YOruRQrjrKbQzSaY6+eNfhQdZgLTyr+zE8r8Y=;
 b=WjoeZQQe+j8/jcdqUNrPILroDhLTdWf9w2ugVZHAGfWJUMSUSSVwAGyuO6BkIR0ecri/kZ
 kdHpOJoqo4ki/N62H4Vi7lfcKkBmCJm/4dgb9qMLXuuL7QBaqCQige308zCKaRHPgXnvR6
 VNHlbBj9hC87xW4pCBsNmzm9aUt39/g=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-S3yDpS1oPQ6pbEAwC9s6Bg-1; Mon, 31 Mar 2025 10:46:58 -0400
X-MC-Unique: S3yDpS1oPQ6pbEAwC9s6Bg-1
X-Mimecast-MFC-AGG-ID: S3yDpS1oPQ6pbEAwC9s6Bg_1743432415
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5499a93f894so2898307e87.1
 for <dev@dpdk.org>; Mon, 31 Mar 2025 07:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743432415; x=1744037215;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HGPra5YOruRQrjrKbQzSaY6+eNfhQdZgLTyr+zE8r8Y=;
 b=HkILQzRRkZmbkkhnpkg8sOrE3d3zrH2eK70mbnzIdD6Rt9yM4IwTJqQcupoym2QQcD
 V1kJIcbN70P3+cjS2Vg8Bhv53dZzERr7gXxsnVRJC8Q+8WR8gf5rZODf9DjIfl11LICI
 +cl0s8ycUOj/BVJfEqIy8YSermnFrrYw7Wm79NyWHScFmk5jrh9cBN+2UCAbyzV4jKdo
 n9OZFVqi573qz7qwQuwLqKLa+DQ9RAemQbDKJs13p6TAoYcsnWv4cIF8GO4pWDk2ggw7
 3QrS30m2MzsmnAxpA2PW2a0+ZaIu3SjRMOs+nOwtaW7BSP5KfDTI0VSBHHVTfLE4BUnH
 mZmA==
X-Gm-Message-State: AOJu0YzVsgHzFcyjoNrbr5sBri+ALLlQb7DzQyxHIRT+vmwyH/XdrAD4
 6XpjOs7IUB2uk8vErE4+L0RnMxLc/1/k6jvA1HpSHFHAghaYF/rUuKzZC7Yg/SLwLhz51rJ0vCi
 DaQy28+m/Y8u0XRoB3A/avhjqSZ6BWr18d/6pqJG1scC/OMD5+i+kGY1QJLtsjD8CmPzJXwicBa
 9mtWISxWZ1OU/N6bY=
X-Gm-Gg: ASbGncvNM1eJ+VUiYR+PeBF5+GC1DXmWQ4JkmXqjicgP9369rfy+T6Wo6gHIYaM7eVd
 BXflSiRA13uIWpbFRIvHT+An53uGnn6kNvCjR+5CRFEpytRTSQeu2XRM1PLKlDY9OxcJi+24rzg
 I=
X-Received: by 2002:a05:6512:128a:b0:549:7c5f:d961 with SMTP id
 2adb3069b0e04-54b107354b9mr2713072e87.17.1743432415392; 
 Mon, 31 Mar 2025 07:46:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEI55paFhYVRM6I/GkzuEuFwBdrvTEOe240hYEpNpu8FeMR1y/VFxnjfyWLHpZySToa7naJg3DJmC8E8RYbY2k=
X-Received: by 2002:a05:6512:128a:b0:549:7c5f:d961 with SMTP id
 2adb3069b0e04-54b107354b9mr2713058e87.17.1743432414955; Mon, 31 Mar 2025
 07:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250309084526.972512-1-bhagyada.modali@amd.com>
In-Reply-To: <20250309084526.972512-1-bhagyada.modali@amd.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 31 Mar 2025 16:46:43 +0200
X-Gm-Features: AQ5f1JoFrzxZs7B-b0GAuf-Acj7oKV4UShTedjQCEk1sXuJAsLWM_0yo0ulz0cs
Message-ID: <CAJFAV8z2wg1mGjndn5uh=8wcFv3crRHV4H7OXFUaUQ0kOv_KWA@mail.gmail.com>
Subject: Re: [PATCH] dma\ae4dma: added AMD user space DMA driver
To: Bhagyada Modali <bhagyada.modali@amd.com>
Cc: dev@dpdk.org, ssebasti@amd.com, rningoji@amd.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mzNbSpPKLsdIt9AWdzm6pmE7AbKMkG8wZtE56FQPV1U_1743432415
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

On Sun, Mar 9, 2025 at 9:46=E2=80=AFAM Bhagyada Modali <bhagyada.modali@amd=
.com> wrote:
>
> Added a user-space driver with support for the AMD EPYC
> 4th Generation DMA (AE4DMA) offload engine.
>
> Implementation of new user-space driver supporting
> DMA memory copy offload on AMD EYPC 9004 & 8004 systems
> (Genoa and Siena processors).
>
> Signed-off-by: Bhagyada Modali <bhagyada.modali@amd.com>

This patch failed to apply and did not pass CI.

Please rebase and resubmit with comments from Chengwen and Morten addressed=
.


--=20
David Marchand

