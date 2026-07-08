Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4420DC43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 12:53:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F2CF40268;
	Wed,  8 Jul 2026 14:53:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6C30540265
 for <dev@dpdk.org>; Wed,  8 Jul 2026 14:53:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783515206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bVCsharvE76nr+NLnRgozKJE3mlyJD6y7ypMHdkRnk8=;
 b=D+X9Dag0AiA5HsdIjH6h8gpoc428XJd199HiGKLXGmhbZRNjf8rsAK4hBGiWRb80HLC+IP
 snezXw47wH6b4+JQAnVAVLuSl6SRzI/RiJsvzag+RUPfdEcoDEd8HcPH69hdjt+Lvp43oM
 05Z0bUdj+1Tf6conH8PJZfAkCvxd2l8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-EO4TtXBeOEuEME86prKd-Q-1; Wed, 08 Jul 2026 08:53:22 -0400
X-MC-Unique: EO4TtXBeOEuEME86prKd-Q-1
X-Mimecast-MFC-AGG-ID: EO4TtXBeOEuEME86prKd-Q_1783515201
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5aebf128d45so553981e87.1
 for <dev@dpdk.org>; Wed, 08 Jul 2026 05:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783515201; x=1784120001;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bVCsharvE76nr+NLnRgozKJE3mlyJD6y7ypMHdkRnk8=;
 b=i5lMQFJSkw8BUQ1ytRjoe75boW5uX2WBETl8gJi7srF0Emrm+AIqshtfEguG9xNHQ5
 PhxXIiix7EyMmdgzJWGBm30xl5TuuekTMbeu4xZo+VCWkqe2Wz4Qo5xDnO2g+g5GSqDK
 JucOFTAYoz1Fu6HPoFx3CxArXJXrMxW5dLJFf6o2ZWIGihAseXHBjcJ7L1rTif+PwL78
 U2SVq1mS/AM9m2bCQc3xHngSbLYqosHcRyIEkj6P2Jyz75iR8O7eT5Uletg7xC1y4qtf
 JBGY3yJmLcy4vQKTWSgNtytR1qt6vw2b69IvT3LH7lnPpuGPGffY6tKIYYJNw+osguYR
 uaiw==
X-Gm-Message-State: AOJu0Yy+1rw4bdRuoZQ2Ti95s4NMA3YxS/uxhHIU0mlmcKQUFJ791ZMp
 QxujJ3V0tnVcEl+JTI1z+ph7RGVtKiWK1eaHuoi47wezePx1PQv+sZVE36DkbcMz/Ji1I9uZ+WK
 b1zOO8mfECBpT+AOnZHfAGVfiirt10Kfg4jsfTFxEDYBlqWj+doLnVkV8LA1KC2VhPHcvB3dn5t
 AXCzRBEtt+nk4Sok0VYgc=
X-Gm-Gg: AfdE7ckNbiwPWbI7cXVYByUAxsscXdZ+oLXj3XOQkwvUIogA9iEOL4p9L02hwYjM3fh
 dK2YNPlSD0i+H3TYdSuIXJ5Ht5QM2ehkIxqDKX2CrKYVtl28AypdTue3fQ+yCyWHY1fc+sfBq1X
 MUeyYFajEDnX6D+TdxoovgHnTHe7Iqbhkk8UIAI4m1ZPI6w9508gLAYzBADxgZfF5Zmu1kM81XN
 2EOQF7+1kh4cSeUa6p7SZNp5YkDPJbgpX4a4tt2z9LFCyH89lBi/F8yLXc=
X-Received: by 2002:a05:6512:12d4:b0:5ae:b819:7880 with SMTP id
 2adb3069b0e04-5b00ac66f56mr1544181e87.6.1783515200997; 
 Wed, 08 Jul 2026 05:53:20 -0700 (PDT)
X-Received: by 2002:a05:6512:12d4:b0:5ae:b819:7880 with SMTP id
 2adb3069b0e04-5b00ac66f56mr1544169e87.6.1783515200334; Wed, 08 Jul 2026
 05:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260706150636.839560-1-david.marchand@redhat.com>
 <akzdNnQ9ol9sY1-p@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <akzdNnQ9ol9sY1-p@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 8 Jul 2026 14:53:08 +0200
X-Gm-Features: AVVi8CcxV50Aig1rkMjdmeDFw7e0QyoheInZvarrbf9vi8maNhUr9sL3Vt6BlIE
Message-ID: <CAJFAV8wrAsHjpsbzDfP=ye6VYyDetg_tuk8iAcbhSBZGodrqWQ@mail.gmail.com>
Subject: Re: [PATCH] dev: hide internal type for device comparison
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: udQf2Xz00JY113LqJpFxMFXBopjI-uG5OESS0XyzAto_1783515201
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

On Tue, 7 Jul 2026 at 13:04, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Mon, Jul 06, 2026 at 05:06:36PM +0200, David Marchand wrote:
> > rte_dev_cmp_t is a type used only in bus operations.
> > Since no public API references it, remove it from exported types.
> > Thanks to this, we can remove the dependency of bus_driver.h to
> > rte_dev.h.
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.


-- 
David Marchand

